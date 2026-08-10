#!/usr/bin/env bash
# 自動ループの 1 tick を、独立した Claude セッションとして走らせる。
#
# launchd（com.masaori.ising-lambda-auto-loop）から毎時呼ばれる。
# 手順の正本は docs/tasks/auto-loop-runbook.md、状態の正本は docs/tasks/auto-loop-state.md。
# このスクリプトは「起動と多重起動の防止とログ」だけを担当し、作業内容の判断は一切しない。
#
# 手で 1 回だけ回したいとき: bash scripts/auto-loop-tick.sh
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/auto-loop.log"
LOCK_DIR="$LOG_DIR/auto-loop.lock"

# 1 tick の上限。次の発火（60 分後）と、その前に走る監査（毎時 55 分）に食い込ませないため
# 45 分で打ち切る。30 分間隔・25 分上限では四層まで終わらず 4 回打ち切られたので広げた。
TICK_TIMEOUT_SECONDS=2700

mkdir -p "$LOG_DIR"

log() {
  printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"
}

# launchd は対話シェルの PATH を持たないので、必要なものを明示的に足す。
# claude は ~/.local/bin、sage と tectonic は Homebrew（Intel は /usr/local、Apple Silicon は /opt/homebrew）。
PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# node / npm / pnpm は nvm 配下にあり、上の固定パスには入っていない。
# 足さないと tick の中で `npm run check` も `npm run build:pdf` も実行できず、
# 検証を通さないまま tick が終わる（実測: 2 回目の tick で npm が見つからなかった）。
# 既定バージョンの別名（~/.nvm/alias/default）を先に見て、無ければ最も新しいものを使う。
if [ -d "$HOME/.nvm/versions/node" ]; then
  nvm_default="$(cat "$HOME/.nvm/alias/default" 2>/dev/null || true)"
  nvm_bin=""
  if [ -n "$nvm_default" ]; then
    nvm_bin="$(ls -d "$HOME"/.nvm/versions/node/v"${nvm_default#v}"* 2>/dev/null | sort -V | tail -1)"
  fi
  if [ -z "$nvm_bin" ]; then
    nvm_bin="$(ls -d "$HOME"/.nvm/versions/node/v* 2>/dev/null | sort -V | tail -1)"
  fi
  [ -n "$nvm_bin" ] && PATH="$nvm_bin/bin:$PATH"
fi

# lake / lean は elan 配下にあり、これも固定パスには入っていない。
[ -d "$HOME/.elan/bin" ] && PATH="$HOME/.elan/bin:$PATH"

export PATH

if ! command -v claude >/dev/null 2>&1; then
  log "SKIP: claude が PATH に無い"
  exit 1
fi

# 多重起動の防止。mkdir は失敗が原子的なのでロックに使える。
# 前の tick が異常終了してロックが残った場合に備え、生きているプロセスがあるかを PID で確認する。
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  stale_pid="$(cat "$LOCK_DIR/pid" 2>/dev/null || true)"
  # ロックが上限＋10 分より古ければ、プロセスが生きていても居座りとみなす。
  # 生存だけを条件にすると、終了処理で固まったスクリプトに以後の tick が永久に止められる
  # （実測: SIGKILL 後もスクリプトが 10 分以上ロックを握ったままだった）。
  lock_age_limit=$(( TICK_TIMEOUT_SECONDS + 600 ))
  lock_age="$(( $(date +%s) - $(stat -f %m "$LOCK_DIR" 2>/dev/null || echo 0) ))"
  if [ -n "$stale_pid" ] && kill -0 "$stale_pid" 2>/dev/null && [ "$lock_age" -lt "$lock_age_limit" ]; then
    log "SKIP: 前の tick (pid $stale_pid) がまだ走っている"
    exit 0
  fi
  if [ "$lock_age" -ge "$lock_age_limit" ]; then
    log "WARN: ロックが古すぎる（${lock_age} 秒）。居座りとみなして掃除する (pid ${stale_pid:-unknown})"
  fi
  log "WARN: 死んだロックを掃除した (pid ${stale_pid:-unknown})"
  rm -rf "$LOCK_DIR"
  mkdir "$LOCK_DIR"
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap 'rm -rf "$LOCK_DIR"' EXIT

# 機械の負荷が高すぎるときは見送る。負荷が高いと lake build も date も返らず、
# 45 分の上限まで何もできずに終わる（実測 2026-08-10 05:00: load average 248。
# 原因はこのループではなく、同じ機械で多数の対話セッションが MCP と Chrome を抱えていたこと）。
# 判定は load average の数字ではなく、**実際に応答するか**で行う。
# 他セッションの iOS シミュレータや Chrome で load が常時 100 を超える機械なので、
# 数字で切ると走れる回まで見送ってしまう（実測 2026-08-11 01:00: load 122 が 1 時間以上続き、
# ループが見送りを繰り返した）。逆に、応答が遅いときは lake build も git も返らないので、
# 45 分を無駄に使い切る。そこで軽い操作の所要時間を測る。
probe_start="$(date +%s)"
timeout 30 git -C "$REPO_DIR" status --porcelain >/dev/null 2>&1
probe_elapsed=$(( $(date +%s) - probe_start ))
load1="$(sysctl -n vm.loadavg 2>/dev/null | awk '{print int($2)}')"
if [ "$probe_elapsed" -ge 20 ]; then
  log "SKIP: 機械が応答しない（git status に ${probe_elapsed} 秒。load average ${load1:-不明}）"
  exit 0
fi

# 作業ツリーが汚れているときは見送る。
# このリポジトリでは人間の対話セッションが同じ作業ツリーを使うので、
# 編集の途中に tick が割り込むと互いの変更を踏む。ロックは tick どうしの衝突しか防げない。
cd "$REPO_DIR"
LEFTOVER_MARK="$LOG_DIR/leftover-from-tick"
# 残骸が片付いていれば目印を消す（人手で拾ったあとも残り続けると、次の tick が
# 「残骸がある」と誤認する）。
[ -z "$(git status --porcelain)" ] && rm -f "$LEFTOVER_MARK"
if [ -n "$(git status --porcelain)" ]; then
  # 汚れている理由は 2 つある。人間が作業中か、前の tick が失敗して残骸を置いたか。
  # 前者なら踏んではいけないので見送る。**後者で見送ると、残骸が片付くまで
  # 以後のすべての tick が見送られ、ループが永久に止まる**（実測: 使用量の上限で
  # 異常終了した tick の残骸がそれに当たった）。目印の有無で区別する。
  if [ -f "$LEFTOVER_MARK" ]; then
    log "前の tick の残骸がある。見送らずに拾いに行く（$(cat "$LEFTOVER_MARK")）"
  else
    log "SKIP: 作業ツリーに未コミットの変更がある（人間が作業中とみなす）"
    exit 0
  fi
fi

# まとめに入る締切。上限（強制終了）の 10 分前に置く。
# **時間を見積もらせるのではなく、時計を見て切り上げさせる。** LLM は作業時間を見積もれないが、
# `date` で現在時刻を読むことはできる。強制終了は成果を書きかけで落とすので、その前に
# 自分でまとめさせるほうが取りこぼしが小さい。
SOFT_DEADLINE="$(date -v+$(( (TICK_TIMEOUT_SECONDS - 600) / 60 ))M '+%H:%M' 2>/dev/null \
  || date -d "+$(( (TICK_TIMEOUT_SECONDS - 600) / 60 )) minutes" '+%H:%M')"
HARD_DEADLINE="$(date -v+$(( TICK_TIMEOUT_SECONDS / 60 ))M '+%H:%M' 2>/dev/null \
  || date -d "+$(( TICK_TIMEOUT_SECONDS / 60 )) minutes" '+%H:%M')"

PROMPT=$(cat <<'EOF'
exact-solution-of-2d-ising-model-lambda の自動ループを 1 tick 進める。

まず次を全て読む。
- docs/context/ の全ファイル（リポジトリ全体の思想。ここが最上位）
- exact-solution-of-2d-ising-model-lambda/README.md（このプロジェクトのゴール設定と記述規則）
- exact-solution-of-2d-ising-model-lambda/docs/tasks/auto-loop-runbook.md（1 tick の手順の正本）
- exact-solution-of-2d-ising-model-lambda/docs/tasks/auto-loop-state.md（状態台帳）
- exact-solution-of-2d-ising-model-lambda/MEMORY.md

そのうえで runbook のとおりに実行する。要点を再掲する。
1. 既存出力のレビューと修正を先に行う（毎 tick 必須。飛ばして前進しない）。
   直したら、前進に入る前にコミットして push まで済ませる。
2. そのあと、台帳の todo の先頭セクションを 1 つだけ進める。2 つ以上進めない。
   時間のかかる処理は前面で実行し、終わるまで待つ。裏で走らせたまま tick を終えると
   その処理は道連れに終了し、成果が残らない。
3. 検証（npm run check / build:pdf / sage / verify-check-linkage / lake build）を通す。
   検証が落ちたら本文を直す。検証を主張に合わせて緩めない。
4. 台帳と MEMORY を更新し、main へ push して反映を確認する。
5. tick の最後に PDF を作り直す（cd structured-latex && npm run build:pdf）。
   本文を変えなかった tick でも必ず行う。人間が開いたまま進み具合を見るため。
6. 1 セクション進めたら止まる。

締切について。この tick は @HARD@ に強制終了される（書きかけでも落ちる）。
そこで @SOFT@ を「まとめに入る締切」とする。作業の区切りごとに `date` で現在時刻を
確認し、@SOFT@ を過ぎていたら**新しい着手をやめ、いま手元にあるものを検証して
コミットし、push と台帳の更新まで済ませて終える**。中途半端な成果でも、検証を通して
コミットしてあれば次の tick が続きから進められる。落ちたまま書きかけで残すより良い。
時間の見積もりはしなくてよい（できない）。時計を見て判断すること。
EOF
)
# ヒアドキュメントは <<'EOF' なので変数を展開しない（プロンプト中のバッククォートを
# コマンド置換として実行させないため）。締切だけは後から差し込む。
PROMPT="${PROMPT//@SOFT@/$SOFT_DEADLINE}"
PROMPT="${PROMPT//@HARD@/$HARD_DEADLINE}"

log "=== tick 開始（まとめに入る締切 ${SOFT_DEADLINE} / 強制終了 ${HARD_DEADLINE}）"

set +e
# -k 60: SIGTERM の 60 秒後に SIGKILL を送る。付けないと、SIGTERM を無視したプロセスが
# 居座ってロックが残り、以後の tick が「まだ走っている」で見送られ続ける。
# --strict-mcp-config と空の --mcp-config で MCP サーバを 1 つも起動しない。
# **これが無いと tick ごとに MCP（chrome-devtools 等）のプロセスが残り、機械が詰まる。**
# 実測 2026-08-10 05:00: claude 32・npm 42・MCP 35・Chrome 54 プロセスが 7 時間分たまり、
# load average が 248 に達して lake build も date も返らなくなった。
# tick の作業（証明・SageMath・Lean・git）に MCP は 1 つも要らない。
echo '{"mcpServers":{}}' > "$LOG_DIR/empty-mcp.json"
# **プロンプトは標準入力から渡す。** --mcp-config は可変長引数なので、引数として
# プロンプトを続けると設定ファイル名として飲み込まれる
# （実測 2026-08-10 06:05: "ENAMETOOLONG: name too long" で 2 秒で落ちた）。
printf '%s' "$PROMPT" | timeout -k 60 "$TICK_TIMEOUT_SECONDS" claude -p \
  --dangerously-skip-permissions --strict-mcp-config \
  --mcp-config "$LOG_DIR/empty-mcp.json" >> "$LOG_FILE" 2>&1
status=$?
set -e

record_leftover() {  # 失敗した tick が残したものを目印へ書く（次の tick が拾う）
  local reason="$1"
  local files
  files="$(git -C "$REPO_DIR" status --porcelain | wc -l | tr -d ' ')"
  if [ "$files" != "0" ]; then
    printf '%s に %s で終了し、%s ファイルが未コミットで残った\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" "$reason" "$files" > "$LEFTOVER_MARK"
    log "    未コミットの成果が ${files} ファイル残っている（目印を置いた。次の tick が拾う）"
  else
    rm -f "$LEFTOVER_MARK"
  fi
}

# 124 = timeout が SIGTERM で終わらせた。137 = 128+9 で、SIGTERM に応じなかったため
# timeout -k が SIGKILL へ昇格させた。どちらも「上限に当たった」なので同じ扱いにする
# （実測: 137 を異常終了と報告して原因の切り分けを誤った）。
if [ "$status" -eq 124 ] || [ "$status" -eq 137 ]; then
  log "=== tick 打ち切り（${TICK_TIMEOUT_SECONDS} 秒を超えた。exit ${status}）"
  record_leftover "打ち切り (exit $status)"
elif [ "$status" -ne 0 ]; then
  log "=== tick 異常終了 (exit $status)"
  record_leftover "異常終了 (exit $status)"
else
  log "=== tick 正常終了"
  # **正常終了でも成果が未コミットで残ることがある。** 実測 2026-08-10 03:35 の tick は、
  # 機械の負荷で lake build が返らず、まとめの push を完了できないまま turn を終えた。
  # 目印を消すと、以後の tick が「人間が作業中」と誤認して見送り続ける（実際 04:35 が見送った）。
  record_leftover "正常終了したが未コミットの成果が残った"
fi

exit "$status"
