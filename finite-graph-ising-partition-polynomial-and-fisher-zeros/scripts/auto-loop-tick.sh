#!/usr/bin/env bash
# 有限グラフ上の Ising 分配多項式と Fisher 零点を、一回につき一つの数学的主張だけ進める。
# 作業判断の正本は docs/tasks/auto-loop-runbook.md と auto-loop-state.md である。
set -euo pipefail

PROJECT_NAME="finite-graph-ising-partition-polynomial-and-fisher-zeros"
LOOP_WORKTREE="$HOME/git/masaori/math-finite-graph-ising-loop"
LOOP_BRANCH="finite-graph-ising-loop"
LOG_DIR="$HOME/Library/Logs/finite-graph-ising-auto-loop"
LOG_FILE="$LOG_DIR/auto-loop.log"
LOCK_DIR="$LOG_DIR/auto-loop.lock"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
GIT_COMMON_DIR="$(git -C "$SCRIPT_DIR" rev-parse --path-format=absolute --git-common-dir)"
MAIN_REPO_DIR="$(cd "$(dirname "$GIT_COMMON_DIR")" && pwd -P)"

PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH

mkdir -p "$LOG_DIR"
# 進捗行は auto-loop.log と launchd の標準出力の両方へ書く。**片方だけだと、外から
# 見張っている点検（local-pc-management の check-daily-jobs-health.py）が失敗の原因を
# 読めない。** 実際に 2026-08-22、launchd 側が空だったせいで、上限で終えた tick の原因が
# 「ログは空」としか出ず、2日前の無関係な ssh エラーが原因として拾われた。
# エージェントの生出力は量が多いので LOG_FILE だけに残し、ここでは短い進捗行だけ複製する。
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE"; }

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  log "SKIP: 前の tick が動作中"
  exit 0
fi
trap 'rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT

if ! command -v codex >/dev/null 2>&1; then
  log "ERROR: codex が PATH に無い"
  exit 1
fi

git -C "$MAIN_REPO_DIR" fetch --quiet origin
if [ ! -e "$LOOP_WORKTREE/.git" ]; then
  mkdir -p "$(dirname "$LOOP_WORKTREE")"
  git -C "$MAIN_REPO_DIR" worktree add -B "$LOOP_BRANCH" "$LOOP_WORKTREE" origin/main >> "$LOG_FILE" 2>&1
fi

if [ -z "$(git -C "$LOOP_WORKTREE" status --porcelain)" ]; then
  git -C "$LOOP_WORKTREE" checkout -q -B "$LOOP_BRANCH" origin/main >> "$LOG_FILE" 2>&1
else
  log "INFO: 前回 tick の未コミット成果を引き継ぐ"
fi

ensure_dependencies() {
  local relative="$1"
  local destination="$LOOP_WORKTREE/$relative/node_modules"
  local source="$MAIN_REPO_DIR/$relative/node_modules"
  [ -d "$destination" ] && return 0
  if [ -d "$source" ] && cmp -s "$MAIN_REPO_DIR/$relative/pnpm-lock.yaml" "$LOOP_WORKTREE/$relative/pnpm-lock.yaml"; then
    cp -Rc "$source" "$destination"
    log "依存を clone copy した: $relative"
  else
    (cd "$LOOP_WORKTREE/$relative" && pnpm install --frozen-lockfile) >> "$LOG_FILE" 2>&1
    log "依存を lockfile から復旧した: $relative"
  fi
}

ensure_dependencies "structured-latex"
ensure_dependencies "$PROJECT_NAME/structured-latex"

PROMPT='[[AI_AGENT_MESSAGE]]
これは有限グラフ上の Ising 分配多項式と Fisher 零点の自動 tick です。人間の承認を表すメッセージではありません。

リポジトリ直下の AGENTS.md、CLAUDE.md、docs/context/ の全ファイルを読み、続いて finite-graph-ising-partition-polynomial-and-fisher-zeros/README.md、MEMORY.md、docs/tasks/auto-loop-runbook.md、docs/tasks/auto-loop-state.md、docs/tasks/task-dependency-graph.md、今回の個別タスク文書を読んでください。.codex/skills/math-prover/SKILL.md も完全に読み、その skill を使うことを commentary で宣言してください。

runbook に厳密に従い、既存成果のレビュー後、実行待ちの最初の一件から構造化本文の一つの定義・主張・定理だけを前進させてください。必要な SageMath 検算、全検証、台帳と MEMORY の更新、コミット、origin の remote default branch への push、包含確認、Slack 通知まで行ってください。Slack は --topic "有限グラフのイジング分配多項式とFisher零点" --artifact-url "https://hexcomp-artifacts.web.app/math/finite-graph-ising-partition-polynomial/" を指定し、commit URL を人間へ本文を見せる URL として使わないでください。一 tick 一主張を超えて次へ進まないでください。'

log "=== tick 開始"
set +e
printf '%s' "$PROMPT" | timeout -k 60 3300 codex exec \
  -m gpt-5.6-sol -c model_reasoning_effort=medium \
  --dangerously-bypass-approvals-and-sandbox -C "$LOOP_WORKTREE" - >> "$LOG_FILE" 2>&1
status=$?
set -e

if [ "$status" -eq 0 ]; then
  log "=== tick 正常終了"
elif [ "$status" -eq 124 ] || [ "$status" -eq 137 ]; then
  log "=== tick 打ち切り (exit $status)。未コミット成果は次回へ残す"
else
  log "=== tick 異常終了 (exit $status)。未コミット成果は次回へ残す"
fi
exit "$status"
