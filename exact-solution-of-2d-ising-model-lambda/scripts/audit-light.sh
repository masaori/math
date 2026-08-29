#!/usr/bin/env bash
# 毎時の軽い監査。ループの外から独立に、**速く終わる検査だけ**を回す。
#
# なぜ分けたか: SageMath の検証が 34 件（L=6 まで走るものもある）に増えて、
# 監査 1 回が 1 時間の枠に収まらなくなった。次の回が前の回に重なり、
# 結果を 2 時間出せない状態になった（実測 2026-08-10 02:00）。
# 重い全数検証は日次（audit-loop.sh）へ移し、毎時はここだけを見る。
#
# 見るもの: tick のログ（通知されない失敗）、origin/main を取り出しての
# 構造化テキスト検査・PDF 生成・検証と証明の対応、Lean、台帳と本文の突き合わせ。
# 見ないもの: SageMath の全数検証（日次へ）。
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/audit.log"
LOCK_DIR="$LOG_DIR/audit-light.lock"
WORKTREE="$LOG_DIR/audit-light-worktree"
PROJECT_NAME="$(basename "$PROJECT_DIR")"

mkdir -p "$LOG_DIR"
log() { printf '%s [light] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"; }

PATH="$HOME/.local/bin:$HOME/.elan/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
if [ -d "$HOME/.nvm/versions/node" ]; then
  nvm_bin="$(ls -d "$HOME"/.nvm/versions/node/v* 2>/dev/null | sort -V | tail -1)"
  [ -n "$nvm_bin" ] && PATH="$nvm_bin/bin:$PATH"
fi
export PATH

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  log "SKIP: 前の軽い監査がまだ走っている"
  exit 0
fi
trap 'rm -rf "$LOCK_DIR"' EXIT

problems=()
add() { problems+=("$1"); log "NG: $1"; }

# 1. tick のログから、通知されていない失敗を拾う（スクリプトが書いた行だけを見る）。
since="$(date -v-3H '+%Y-%m-%d %H:%M:%S' 2>/dev/null || date -d '3 hours ago' '+%Y-%m-%d %H:%M:%S')"
TICK_STATUS_LOG="$LOG_DIR/auto-loop-status.log"
[ -f "$TICK_STATUS_LOG" ] || TICK_STATUS_LOG="$LOG_DIR/auto-loop.log"
if [ -f "$TICK_STATUS_LOG" ]; then
  recent="$(awk -v since="$since" '/^20[0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] === / && $0 >= since' \
    "$TICK_STATUS_LOG" 2>/dev/null || true)"
  cut_count="$(printf '%s\n' "$recent" | grep -c '=== tick 打ち切り' || true)"
  err_count="$(printf '%s\n' "$recent" | grep -c '=== tick 異常終了' || true)"
  [ "${cut_count:-0}" -gt 1 ] && add "直近 3 時間で tick が ${cut_count} 回上限で打ち切られた（セクションが大きすぎる）"
  [ "${err_count:-0}" -gt 0 ] && add "直近 3 時間で tick が ${err_count} 回異常終了した"
fi

# 2. ループが止まっていないか（origin/main が 3 時間動いていないなら異常）。
git -C "$REPO_DIR" fetch origin --quiet 2>/dev/null || add "git fetch に失敗した"
head_commit="$(git -C "$REPO_DIR" rev-parse origin/main)"
last_commit_epoch="$(git -C "$REPO_DIR" log -1 --format=%ct origin/main)"
stall_hours=$(( ( $(date +%s) - last_commit_epoch ) / 3600 ))
[ "$stall_hours" -ge 3 ] && add "origin/main が ${stall_hours} 時間前進していない（ループが止まっている疑い）"

# 3. origin/main を取り出して、速い検査だけ回す。
if [ -d "$WORKTREE" ]; then
  git -C "$REPO_DIR" worktree remove --force "$WORKTREE" >/dev/null 2>&1 || rm -rf "$WORKTREE"
fi
git -C "$REPO_DIR" worktree add --detach --quiet "$WORKTREE" "$head_commit" >> "$LOG_FILE" 2>&1 \
  || add "監査用 worktree を作れなかった"

AUDIT_PROJECT="$WORKTREE/$PROJECT_NAME"
run() {
  local what="$1" dir="$2"; shift 2
  if ! (cd "$dir" && "$@" >> "$LOG_FILE" 2>&1); then
    add "$what が落ちた（origin/main の内容で再現。詳細: logs/audit.log）"
  fi
}

if [ -d "$AUDIT_PROJECT/structured-latex" ]; then
  run "依存の取得（システム側）" "$WORKTREE/structured-latex" pnpm install --silent
  run "依存の取得" "$AUDIT_PROJECT/structured-latex" pnpm install --silent
  run "構造化テキストの検査一式" "$AUDIT_PROJECT/structured-latex" npm run check
  run "PDF の生成" "$AUDIT_PROJECT/structured-latex" npm run build:pdf
  run "検証と証明の対応" "$AUDIT_PROJECT" node sagemath/tools/verify-check-linkage.ts
fi

# Lean はメインの作業ツリーが origin/main と一致していて、かつ誰も作業していないときだけ。
if [ "$(git -C "$REPO_DIR" rev-parse HEAD)" = "$head_commit" ] &&
   [ -z "$(git -C "$REPO_DIR" status --porcelain)" ] &&
   [ ! -d "$LOG_DIR/auto-loop.lock" ]; then
  run "lake build" "$PROJECT_DIR/lean" lake build
  run "sorry 非依存と import の網羅" "$PROJECT_DIR/lean" bash scripts/check-no-sorry.sh
fi

# 4. 台帳と本文の突き合わせ。
ledger="$AUDIT_PROJECT/docs/tasks/auto-loop-state.md"
if [ -f "$ledger" ]; then
  remark_items="$(grep -c 'todo("残り")\|todo("未着手")' "$AUDIT_PROJECT/structured-latex/content/main-text.ts" 2>/dev/null || echo 0)"
  ledger_todo="$(grep -c '| todo |' "$ledger" 2>/dev/null || echo 0)"
  [ "${remark_items:-0}" -gt "${ledger_todo:-0}" ] &&
    add "本文の「この先に書くこと」が ${remark_items} 項目あるのに台帳の todo は ${ledger_todo} 件"
fi

git -C "$REPO_DIR" worktree remove --force "$WORKTREE" >/dev/null 2>&1 || rm -rf "$WORKTREE"

if [ ${#problems[@]} -eq 0 ]; then
  log "OK: 軽い監査で異常なし（origin/main = ${head_commit:0:7}）"
  exit 0
fi

message="自動ループの監査（毎時）で異常を検出した（origin/main = ${head_commit:0:7}）:"
for p in "${problems[@]}"; do message="$message"$'\n'"・$p"; done
message="$message"$'\n'"詳細: $PROJECT_NAME/logs/audit.log"

log "軽い監査で ${#problems[@]} 件の異常を検出したので通知する"
if ! slack route-post math "$message" \
  --topic "可算対数順序群による二次元イジング模型" \
  --artifact-url "https://hexcomp-artifacts.web.app/math/ising-lambda/" \
  >> "$LOG_FILE" 2>&1; then
  log "Slack の明示routeへの通知に失敗した"
fi
exit 1
