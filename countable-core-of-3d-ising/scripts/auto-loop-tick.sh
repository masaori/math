#!/usr/bin/env bash
# 自動ループの 1 tick を、独立したエージェントセッションとして走らせる。
#
# launchd（com.masaori.ising-3d-cut-auto-loop）から 15 分ごとに呼ばれる。
# ただし**実際に走る間隔はこのスクリプトが決める**（下の「発火間隔の自動調整」を見よ）。
# 打ち切り・異常終了が続くときは間隔を伸ばし、1 tick の持ち時間も一緒に伸ばす。
# 手順の正本は docs/tasks/auto-loop-runbook.md、状態の正本は docs/tasks/auto-loop-state.md。
# このスクリプトは「起動・多重起動の防止・作業場の用意・ログ」だけを担当し、
# 作業内容の判断は一切しない。
#
# 手で 1 回だけ回したいとき: bash scripts/auto-loop-tick.sh
#
# **2 次元側のループ（com.masaori.ising-lambda-auto-loop）とは別の作業ツリーで動く。**
# 同じ作業ツリーを共有すると、片方が編集している間もう片方が「汚れている」で見送るため、
# 短い間隔のこちらはほぼ毎回見送られる（あちらの tick は 45 分走る）。
# そこでこのループは専用の git worktree を持ち、そこで作業して origin/main へ push する。
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

# このループ専用の作業ツリーと、その中のプロジェクト。
LOOP_WORKTREE="$HOME/git/masaori/math-ising-3d-cut-loop"
LOOP_BRANCH="ising-3d-cut-loop"
PROJECT_NAME="countable-core-of-3d-ising"

# 共有チェックアウト（メインの作業ツリー）の場所は、スクリプトの位置から辿らずに
# git の共通ディレクトリから求める。このスクリプトはメイン側からもループ用 worktree からも
# 起動されるので、位置に依存させると依存のコピー元を自分自身にしてしまう。
GIT_COMMON_DIR="$(git -C "$SCRIPT_DIR" rev-parse --path-format=absolute --git-common-dir 2>/dev/null || true)"
if [ -n "$GIT_COMMON_DIR" ]; then
  MAIN_REPO_DIR="$(cd "$(dirname "$GIT_COMMON_DIR")" && pwd -P)"
else
  MAIN_REPO_DIR="$HOME/git/masaori/math"
fi

# ログとロックはリポジトリの外に置く。作業ツリーはこのスクリプト自身が作ったり origin/main へ
# 合わせ直したりするので、その中にログを置くと「まだ無い」「消える」が起きる。
LOG_DIR="$HOME/Library/Logs/ising-3d-cut-auto-loop"
LOG_FILE="$LOG_DIR/auto-loop.log"
LOCK_DIR="$LOG_DIR/auto-loop.lock"
LEFTOVER_MARK="$LOG_DIR/leftover-from-tick"

# --- 発火間隔の自動調整 ------------------------------------------------------
# launchd は 15 分ごとに呼ぶが、**実際に走る間隔はここで決める**。
# 打ち切り・異常終了（=中断）が 2 回続いたら、階段を 1 段上げて間隔を伸ばす。
# 中断が続くのは 1 tick の持ち時間が足りていない兆候なので、間隔と一緒に持ち時間も伸ばす。
# 正常終了したら 1 段下げる（いきなり最短へ戻さないのは、境界で伸縮を繰り返さないため）。
INTERVAL_LADDER=(15 30 45 60)
INTERVAL_MARK="$LOG_DIR/interval-minutes"
INTERRUPTION_MARK="$LOG_DIR/consecutive-interruptions"
NEXT_START_MARK="$LOG_DIR/next-earliest-start"
# 中断が何回続いたら間隔を伸ばすか。1 回の中断は機械の一時的な事情でも起きるため 2 回とする。
INTERRUPTIONS_TO_BACK_OFF=2
# 作業場の用意・PDF 生成・公開・通知のために、間隔から必ず差し引く分。
TICK_OVERHEAD_SECONDS=180

mkdir -p "$LOG_DIR"

interval_minutes="$(cat "$INTERVAL_MARK" 2>/dev/null || echo "${INTERVAL_LADDER[0]}")"
case "$interval_minutes" in
  15|30|45|60) : ;;
  *) interval_minutes="${INTERVAL_LADDER[0]}" ;;
esac
# 1 tick の上限。次の発火に食い込ませないため、間隔から用意と後片付けの分を引く。
TICK_TIMEOUT_SECONDS=$(( interval_minutes * 60 - TICK_OVERHEAD_SECONDS ))

log() {
  printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"
}

# launchd は対話シェルの PATH を持たないので、必要なものを明示的に足す。
PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# node / npm は mise または nvm 配下にある。足さないと npm run check も build:pdf も回せない。
if [ -d "$HOME/.local/share/mise/shims" ]; then
  PATH="$HOME/.local/share/mise/shims:$PATH"
fi
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
export PATH

# tick は Claude と Codex を交互に使う（2 次元側と同じ運用）。両方が要る。
for cli in claude codex; do
  if ! command -v "$cli" >/dev/null 2>&1; then
    log "SKIP: $cli が PATH に無い"
    exit 1
  fi
done

# 間隔を伸ばしている間は、launchd の発火を見送る（launchd 側の設定は 15 分ごとに固定）。
TICK_START_EPOCH="$(date +%s)"
next_earliest="$(cat "$NEXT_START_MARK" 2>/dev/null || echo 0)"
case "$next_earliest" in
  ''|*[!0-9]*) next_earliest=0 ;;
esac
if [ "$TICK_START_EPOCH" -lt "$next_earliest" ]; then
  log "SKIP: 間隔を ${interval_minutes} 分へ伸ばしている（次に走れるのは $(date -r "$next_earliest" '+%H:%M' 2>/dev/null) 以降）"
  exit 0
fi

# 多重起動の防止。mkdir は失敗が原子的なのでロックに使える。
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  stale_pid="$(cat "$LOCK_DIR/pid" 2>/dev/null || true)"
  lock_age_limit=$(( TICK_TIMEOUT_SECONDS + 300 ))
  lock_age="$(( $(date +%s) - $(stat -f %m "$LOCK_DIR" 2>/dev/null || echo 0) ))"
  if [ -n "$stale_pid" ] && kill -0 "$stale_pid" 2>/dev/null && [ "$lock_age" -lt "$lock_age_limit" ]; then
    log "SKIP: 前の tick (pid $stale_pid) がまだ走っている"
    exit 0
  fi
  if [ "$lock_age" -ge "$lock_age_limit" ]; then
    log "WARN: ロックが古すぎる（${lock_age} 秒）。居座りとみなして掃除する (pid ${stale_pid:-unknown})"
  else
    log "WARN: 死んだロックを掃除した (pid ${stale_pid:-unknown})"
  fi
  rm -rf "$LOCK_DIR"
  mkdir "$LOCK_DIR"
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap 'rm -rf "$LOCK_DIR"' EXIT

# 機械が応答しないときは見送る。判定は load average の数字ではなく実際の応答時間で行う。
probe_start="$(date +%s)"
timeout 30 git -C "$MAIN_REPO_DIR" status --porcelain >/dev/null 2>&1 || true
probe_elapsed=$(( $(date +%s) - probe_start ))
if [ "$probe_elapsed" -ge 20 ]; then
  log "SKIP: 機械が応答しない（git status に ${probe_elapsed} 秒）"
  exit 0
fi

# --- 作業場の用意 ------------------------------------------------------------
# 専用 worktree が無ければ作る。あれば origin/main へ合わせる。
git -C "$MAIN_REPO_DIR" fetch --quiet origin || log "WARN: fetch に失敗した（続行する）"

if [ ! -d "$LOOP_WORKTREE/.git" ] && [ ! -f "$LOOP_WORKTREE/.git" ]; then
  log "専用の作業ツリーを作る: $LOOP_WORKTREE"
  mkdir -p "$(dirname "$LOOP_WORKTREE")"
  git -C "$MAIN_REPO_DIR" worktree add -B "$LOOP_BRANCH" "$LOOP_WORKTREE" origin/main >> "$LOG_FILE" 2>&1
fi

cd "$LOOP_WORKTREE"

# 前の tick の残骸があるかを見る。残骸が無いなら origin/main へ合わせる（追跡外は触らない）。
# **判定は追跡済みファイルの変更だけで行う。** 未追跡のファイル・ディレクトリで見送ると、
# ディレクトリ改名の残骸や再生成物が残っただけでループが恒久的に止まる
# （実測 2026-08-14: 旧名のディレクトリが未追跡で残り、7 回連続で見送られた）。
untracked_count="$(git status --porcelain | grep -c '^??' || true)"
if [ "$untracked_count" != "0" ]; then
  log "    未追跡が ${untracked_count} 件ある（見送らない。追跡済みの変更だけで判定する）"
fi
if [ -z "$(git status --porcelain --untracked-files=no)" ]; then
  rm -f "$LEFTOVER_MARK"
  git checkout -q -B "$LOOP_BRANCH" origin/main >> "$LOG_FILE" 2>&1
else
  if [ -f "$LEFTOVER_MARK" ]; then
    log "前の tick の残骸がある。見送らずに拾いに行く（$(cat "$LEFTOVER_MARK")）"
  else
    # この作業ツリーはループ専用なので、人間が触っている可能性は低い。
    # それでも由来の分からない変更を踏まないため、目印が無ければ見送って報告に残す。
    log "SKIP: 専用作業ツリーに由来の分からない未コミット変更がある（$(git status --porcelain | wc -l | tr -d ' ') ファイル）"
    exit 0
  fi
fi

# 依存（node_modules）は gitignore なので worktree には無い。lockfile が一致するなら
# メインの作業ツリーから clone copy（APFS の copy-on-write）で持ち込む。実複製はしない。
ensure_node_modules() {
  local rel="$1"
  local dst="$LOOP_WORKTREE/$rel/node_modules"
  local src="$MAIN_REPO_DIR/$rel/node_modules"
  [ -d "$dst" ] && return 0
  if [ -d "$src" ] && cmp -s "$MAIN_REPO_DIR/$rel/pnpm-lock.yaml" "$LOOP_WORKTREE/$rel/pnpm-lock.yaml"; then
    cp -Rc "$src" "$dst" 2>/dev/null || cp -R "$src" "$dst"
    log "    依存を clone copy で持ち込んだ: $rel"
  else
    ( cd "$LOOP_WORKTREE/$rel" && pnpm install --frozen-lockfile ) >> "$LOG_FILE" 2>&1 \
      && log "    依存を install した: $rel"
  fi
}
ensure_node_modules "structured-latex"
ensure_node_modules "$PROJECT_NAME/structured-latex"

# Lean の依存（mathlib）も gitignore なので worktree には無い。**ダウンロードし直さない。**
# 2 次元側と同じ Lean/mathlib の版に固定してあるので、lake-manifest.json が一致するなら
# 共有チェックアウトの 2 次元側から clone copy（copy-on-write）で持ち込む。
# 8GB 級なので実複製もダウンロードも 25 分の tick には収まらない。
ensure_lake_packages() {
  local dst="$LOOP_WORKTREE/$PROJECT_NAME/lean/.lake/packages"
  local self_src="$MAIN_REPO_DIR/$PROJECT_NAME/lean/.lake/packages"
  local sibling_src="$MAIN_REPO_DIR/exact-solution-of-2d-ising-model-lambda/lean/.lake/packages"
  # **ソースだけの packages では lake build が mathlib を丸ごと再ビルドし、tick の上限に収まらない。**
  # ビルド済みの成果物があるかどうかで判定する（実測 2026-08-13: 締切内に終わらなかった）。
  [ -d "$dst/mathlib/.lake/build" ] && return 0
  [ -d "$LOOP_WORKTREE/$PROJECT_NAME/lean" ] || return 0
  [ -d "$dst" ] && rm -rf "$dst"
  local src=""
  if [ -d "$self_src" ] && cmp -s "$MAIN_REPO_DIR/$PROJECT_NAME/lean/lake-manifest.json" \
      "$LOOP_WORKTREE/$PROJECT_NAME/lean/lake-manifest.json"; then
    src="$self_src"
  elif [ -d "$sibling_src" ] && cmp -s "$MAIN_REPO_DIR/exact-solution-of-2d-ising-model-lambda/lean/lake-manifest.json" \
      "$LOOP_WORKTREE/$PROJECT_NAME/lean/lake-manifest.json"; then
    src="$sibling_src"
  fi
  if [ -n "$src" ]; then
    mkdir -p "$(dirname "$dst")"
    cp -Rc "$src" "$dst" 2>/dev/null || cp -R "$src" "$dst"
    log "    Lean の依存を clone copy で持ち込んだ（$src）"
  else
    log "    WARN: Lean の依存を持ち込めなかった（lake-manifest.json が一致する取得済みの依存が無い）"
  fi
}
ensure_lake_packages

# --- 締切 --------------------------------------------------------------------
# まとめに入る締切は強制終了より前に置く。時間を見積もらせるのではなく時計を見させる。
# 持ち時間は間隔によって変わるので、まとめの猶予も持ち時間の 3 分の 1（上限 5 分）とする。
SOFT_MARGIN_SECONDS=$(( TICK_TIMEOUT_SECONDS / 3 ))
[ "$SOFT_MARGIN_SECONDS" -gt 300 ] && SOFT_MARGIN_SECONDS=300
SOFT_DEADLINE="$(date -v+$(( (TICK_TIMEOUT_SECONDS - SOFT_MARGIN_SECONDS) / 60 ))M '+%H:%M' 2>/dev/null \
  || date -d "+$(( (TICK_TIMEOUT_SECONDS - SOFT_MARGIN_SECONDS) / 60 )) minutes" '+%H:%M')"
HARD_DEADLINE="$(date -v+$(( TICK_TIMEOUT_SECONDS / 60 ))M '+%H:%M' 2>/dev/null \
  || date -d "+$(( TICK_TIMEOUT_SECONDS / 60 )) minutes" '+%H:%M')"

PROMPT=$(cat <<'EOF'
countable-core-of-3d-ising の自動ループを 1 tick 進める。

まず次を全て読む。
- docs/context/ の全ファイル（リポジトリ全体の思想。ここが最上位）
- countable-core-of-3d-ising/README.md（ゴールと立場。許される脱出の定義）
- countable-core-of-3d-ising/docs/tasks/auto-loop-runbook.md（1 tick の手順の正本）
- countable-core-of-3d-ising/docs/tasks/auto-loop-state.md（状態台帳）
- countable-core-of-3d-ising/MEMORY.md
- docs/discussion/3次元Isingを可算側で書く/ の全ファイル（方針と文献の格付け）

そのうえで runbook のとおりに実行する。要点を再掲する。
1. 既存出力のレビューと修正を先に行う（毎 tick 必須。飛ばして前進しない）。
   直したら、前進に入る前にコミットして push まで済ませる。
2. そのあと、台帳の todo の先頭セクションを 1 つだけ進める。2 つ以上進めない。
   時間のかかる処理は前面で実行し、終わるまで待つ。裏で走らせたまま tick を終えると
   その処理は道連れに終了し、成果が残らない。
3. このプロジェクトの立場を厳守する。許される非可算への脱出は箱の大きさの極限だけである。
   上限・下限・積分・微分・無限和・級数・指数関数・実対数・逆温度の記号を使わない。
   相・臨界温度・自発磁化などの無限体積の語を主張に使わない。
   立場を守れないと分かったら、黙って脱出せず、台帳へ論点を書いて報告して止まる。
4. 検証（npm run check / build:pdf / sage / verify-check-linkage）を通す。
   検証が落ちたら本文を直す。検証を主張に合わせて緩めない。
5. 台帳と MEMORY を更新し、main へ push して反映を確認する
   （git push origin HEAD:main と git merge-base --is-ancestor での確認）。
6. tick の最後に PDF を作り直す（cd countable-core-of-3d-ising/structured-latex && npm run build:pdf）。
   本文を変えなかった tick でも必ず行う。
7. 1 セクション進めたら止まる。
8. **Slack へ通知しない**（slack-notification skill も curl も使わない）。tick の完了報告は
   このスクリプトが公開処理の中で 1 通だけ送る。自分でも送ると 1 tick で 2 通届く。
   例外は、立場を守れない等で人間の判断を待って止まるときだけである。
   通知の本文は台帳の「現在地」の先頭項目なので、そこに何をしたかを 1〜2 文で簡潔に書く。

締切について。この tick は @HARD@ に強制終了される（書きかけでも落ちる）。
そこで @SOFT@ を「まとめに入る締切」とする。作業の区切りごとに `date` で現在時刻を
確認し、@SOFT@ を過ぎていたら新しい着手をやめ、いま手元にあるものを検証して
コミットし、push と台帳の更新まで済ませて終える。中途半端な成果でも、検証を通して
コミットしてあれば次の tick が続きから進められる。時間の見積もりはしなくてよい（できない）。
時計を見て判断すること。
EOF
)
PROMPT="${PROMPT//@SOFT@/$SOFT_DEADLINE}"
PROMPT="${PROMPT//@HARD@/$HARD_DEADLINE}"

# どちらのエージェントを使うかを交互に決める（同じモデルの癖が証明の癖になるのを避けるため）。
AGENT_MARK="$LOG_DIR/last-agent"
BLOCKED_MARK="$LOG_DIR/claude-blocked-until"
last_agent="$(cat "$AGENT_MARK" 2>/dev/null || echo codex)"
if [ "$last_agent" = "claude" ]; then agent="codex"; else agent="claude"; fi

if [ "$agent" = "claude" ] && [ -f "$BLOCKED_MARK" ]; then
  blocked_until="$(cat "$BLOCKED_MARK" 2>/dev/null || echo 0)"
  if [ "$(date +%s)" -lt "${blocked_until:-0}" ]; then
    log "claude は使用量の上限中（$(date -r "$blocked_until" '+%m-%d %H:%M' 2>/dev/null) まで）。codex で回す"
    agent="codex"
  else
    rm -f "$BLOCKED_MARK"
  fi
fi

log "=== tick 開始（${agent} / 間隔 ${interval_minutes} 分 / 作業ツリー ${LOOP_WORKTREE} / まとめ ${SOFT_DEADLINE} / 強制終了 ${HARD_DEADLINE}）"

set +e
# MCP サーバは 1 つも起動しない（tick の作業に不要で、残ると機械が詰まる）。
echo '{"mcpServers":{}}' > "$LOG_DIR/empty-mcp.json"
# プロンプトは標準入力から渡す（--mcp-config が可変長引数なので引数で続けると飲み込まれる）。
if [ "$agent" = "claude" ]; then
  printf '%s' "$PROMPT" | timeout -k 60 "$TICK_TIMEOUT_SECONDS" claude -p \
    --model claude-fable-5 --effort medium \
    --dangerously-skip-permissions --strict-mcp-config \
    --mcp-config "$LOG_DIR/empty-mcp.json" >> "$LOG_FILE" 2>&1
else
  printf '%s' "$PROMPT" | timeout -k 60 "$TICK_TIMEOUT_SECONDS" codex exec \
    -m gpt-5.6-sol -c model_reasoning_effort=medium \
    --dangerously-bypass-approvals-and-sandbox - >> "$LOG_FILE" 2>&1
fi
status=$?
set -e
printf '%s\n' "$agent" > "$AGENT_MARK"

if [ "$agent" = "claude" ] && [ "$status" -ne 0 ]; then
  recent_output="$(tail -5 "$LOG_FILE")"
  case "$recent_output" in
    *"weekly limit"*) date -v+1d +%s > "$BLOCKED_MARK" 2>/dev/null || echo $(( $(date +%s) + 86400 )) > "$BLOCKED_MARK"
                      log "    claude が週次の上限に達した。1 日後まで codex だけで回す" ;;
    *"session limit"*) date -v+3H +%s > "$BLOCKED_MARK" 2>/dev/null || echo $(( $(date +%s) + 10800 )) > "$BLOCKED_MARK"
                      log "    claude がセッションの上限に達した。3 時間後まで codex だけで回す" ;;
  esac
fi

record_leftover() {  # 失敗した tick が残したものを目印へ書く（次の tick が拾う）
  local reason="$1"
  local files
  files="$(git -C "$LOOP_WORKTREE" status --porcelain | wc -l | tr -d ' ')"
  if [ "$files" != "0" ]; then
    printf '%s に %s で終了し、%s ファイルが未コミットで残った\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" "$reason" "$files" > "$LEFTOVER_MARK"
    log "    未コミットの成果が ${files} ファイル残っている（目印を置いた。次の tick が拾う）"
  else
    rm -f "$LEFTOVER_MARK"
  fi
}

# 間隔の階段を上げ下げする。中断（打ち切り・異常終了）が続いたら伸ばし、正常終了で 1 段戻す。
adjust_interval() {
  local interrupted="$1"   # 1 なら中断
  local count=0 idx=0 i new_interval="$interval_minutes"
  count="$(cat "$INTERRUPTION_MARK" 2>/dev/null || echo 0)"
  case "$count" in ''|*[!0-9]*) count=0 ;; esac
  for i in "${!INTERVAL_LADDER[@]}"; do
    [ "${INTERVAL_LADDER[$i]}" = "$interval_minutes" ] && idx="$i"
  done

  if [ "$interrupted" = "1" ]; then
    count=$(( count + 1 ))
    if [ "$count" -ge "$INTERRUPTIONS_TO_BACK_OFF" ]; then
      count=0
      if [ "$idx" -lt $(( ${#INTERVAL_LADDER[@]} - 1 )) ]; then
        new_interval="${INTERVAL_LADDER[$(( idx + 1 ))]}"
        log "    中断が ${INTERRUPTIONS_TO_BACK_OFF} 回続いた。間隔を ${interval_minutes} 分から ${new_interval} 分へ伸ばす（1 tick の持ち時間も伸びる）"
      else
        log "    中断が続いているが、間隔はすでに階段の最長（${interval_minutes} 分）である"
      fi
    else
      log "    中断が ${count} 回目（${INTERRUPTIONS_TO_BACK_OFF} 回続いたら間隔を伸ばす）"
    fi
  else
    count=0
    if [ "$idx" -gt 0 ]; then
      new_interval="${INTERVAL_LADDER[$(( idx - 1 ))]}"
      log "    正常終了したので間隔を ${interval_minutes} 分から ${new_interval} 分へ戻す"
    fi
  fi

  printf '%s\n' "$count" > "$INTERRUPTION_MARK"
  printf '%s\n' "$new_interval" > "$INTERVAL_MARK"
  # 次に走れる時刻。launchd の発火（毎時 0/15/30/45 分）との数秒のずれで 1 回分余計に
  # 見送られないよう、2 分だけ手前に置く。
  printf '%s\n' "$(( TICK_START_EPOCH + new_interval * 60 - 120 ))" > "$NEXT_START_MARK"
}

if [ "$status" -eq 124 ] || [ "$status" -eq 137 ]; then
  log "=== tick 打ち切り（${TICK_TIMEOUT_SECONDS} 秒を超えた。exit ${status}）"
  record_leftover "打ち切り (exit $status)"
  adjust_interval 1
elif [ "$status" -ne 0 ]; then
  log "=== tick 異常終了 (exit $status)"
  record_leftover "異常終了 (exit $status)"
  adjust_interval 1
else
  log "=== tick 正常終了"
  record_leftover "正常終了したが未コミットの成果が残った"
  adjust_interval 0
fi

# 人間が開いたまま進み具合を見られるように、PDF をメインの作業ツリー側の固定パスへ置く。
# build/ は gitignore なので、コピーしても人間の作業と衝突しない。
# 論文 HTML を公開し、tick の完了を Slack へ報告する（作業概要と公開 URL を添える。ユーザー指示）。
# **検証が通ってコミット済みのときだけ公開・通知する。** 失敗・打ち切りの tick の内容を
# 「前進した」と通知しないため、また未コミットの内容に HEAD の版番号を付けて公開しないため
# （2026-08-13 の 2 回目のレビューの指摘）。
if [ "$status" -eq 0 ] && [ -z "$(git -C "$LOOP_WORKTREE" status --porcelain)" ]; then
  bash "$LOOP_WORKTREE/$PROJECT_NAME/scripts/publish-artifact.sh" >> "$LOG_FILE" 2>&1 \
    || log "    アーティファクトの公開に失敗した"
else
  log "    公開と通知を見送った（exit ${status}、未コミット $(git -C "$LOOP_WORKTREE" status --porcelain | wc -l | tr -d ' ') ファイル）"
fi

loop_pdf="$LOOP_WORKTREE/$PROJECT_NAME/structured-latex/build/document.pdf"
main_pdf_dir="$MAIN_REPO_DIR/$PROJECT_NAME/structured-latex/build"
if [ -f "$loop_pdf" ] && [ -d "$MAIN_REPO_DIR/$PROJECT_NAME" ]; then
  mkdir -p "$main_pdf_dir"
  cp "$loop_pdf" "$main_pdf_dir/document.pdf" \
    && log "    PDF をメイン側へ複製した（$main_pdf_dir/document.pdf）"
fi

exit "$status"
