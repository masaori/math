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
  if [ -n "$stale_pid" ] && kill -0 "$stale_pid" 2>/dev/null; then
    log "SKIP: 前の tick (pid $stale_pid) がまだ走っている"
    exit 0
  fi
  log "WARN: 死んだロックを掃除した (pid ${stale_pid:-unknown})"
  rm -rf "$LOCK_DIR"
  mkdir "$LOCK_DIR"
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap 'rm -rf "$LOCK_DIR"' EXIT

# 作業ツリーが汚れているときは見送る。
# このリポジトリでは人間の対話セッションが同じ作業ツリーを使うので、
# 編集の途中に tick が割り込むと互いの変更を踏む。ロックは tick どうしの衝突しか防げない。
cd "$REPO_DIR"
LEFTOVER_MARK="$LOG_DIR/leftover-from-tick"
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
EOF
)

log "=== tick 開始"

set +e
timeout "$TICK_TIMEOUT_SECONDS" claude -p --dangerously-skip-permissions "$PROMPT" >> "$LOG_FILE" 2>&1
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

if [ "$status" -eq 124 ]; then
  log "=== tick 打ち切り（${TICK_TIMEOUT_SECONDS} 秒を超えた）"
  record_leftover "打ち切り"
elif [ "$status" -ne 0 ]; then
  log "=== tick 異常終了 (exit $status)"
  record_leftover "異常終了 (exit $status)"
else
  log "=== tick 正常終了"
  rm -f "$LEFTOVER_MARK"
fi

exit "$status"
