#!/usr/bin/env bash
# 有限双曲曲面上の Ising 模型を、一回につき一つの数学的主張だけ進める。
# 作業判断の正本は docs/tasks/auto-loop-runbook.md と auto-loop-state.md である。
set -euo pipefail

PROJECT_NAME="countable-ising-on-hyperbolic-surfaces"
LOOP_BRANCH="hyperbolic-ising-loop"
LOG_DIR="$HOME/Library/Logs/hyperbolic-ising-auto-loop"
LOG_FILE="$LOG_DIR/auto-loop.log"
LOCK_DIR="$LOG_DIR/auto-loop.lock"
CODEX_TICK_HOME="${CODEX_HOME:?正規の起動口がCODEX_HOMEを設定する必要がある}"
TICK_TIMEOUT_SECONDS=3300

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
GIT_COMMON_DIR="$(git -C "$SCRIPT_DIR" rev-parse --path-format=absolute --git-common-dir)"
MAIN_REPO_DIR="$(cd "$(dirname "$GIT_COMMON_DIR")" && pwd -P)"

PATH="$HOME/.agent-shims:$HOME/.local/bin:$HOME/.local/share/mise/shims:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
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

# 起動口が用意した専用 worktree をそのまま使う。ここから別の worktree を作ると、
# パスから所有リポジトリを読めない置き場所へ成果が残り、tick ごとに worktree が 2 つできる。
LOOP_WORKTREE="$MAIN_REPO_DIR/.codex/worktrees/tick/hyperbolic-ising-auto-loop"
trap 'rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT

if ! command -v codex >/dev/null 2>&1; then
  log "ERROR: codex が PATH に無い"
  exit 1
fi

if [ ! -d "$CODEX_TICK_HOME" ] || [ ! -s "$CODEX_TICK_HOME/auth.json" ]; then
  log "ERROR: 起動口から渡された Codex 設定または認証ファイルが無い: $CODEX_TICK_HOME"
  exit 1
fi

git -C "$MAIN_REPO_DIR" fetch --quiet origin
if [ ! -e "$LOOP_WORKTREE/.git" ]; then
  mkdir -p "$(dirname "$LOOP_WORKTREE")"
  git -C "$MAIN_REPO_DIR" worktree add -B "$LOOP_BRANCH" "$LOOP_WORKTREE" origin/main >> "$LOG_FILE" 2>&1
fi

if [ -z "$(git -C "$LOOP_WORKTREE" status --porcelain)" ]; then
  git -C "$LOOP_WORKTREE" merge --ff-only origin/main >> "$LOG_FILE" 2>&1
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
これは有限双曲曲面上の Ising 模型の自動 tick です。人間の承認を表すメッセージではありません。

リポジトリ直下の AGENTS.md、CLAUDE.md、docs/context/ の全ファイルを読み、続いて countable-ising-on-hyperbolic-surfaces/README.md、MEMORY.md、docs/tasks/auto-loop-runbook.md、docs/tasks/auto-loop-state.md、docs/tasks/hyperbolic-ising/task-dependency-graph.md、今回の個別タスク文書を読んでください。.codex/skills/math-prover/SKILL.md も完全に読み、その skill を使うことを commentary で宣言してください。

runbook に厳密に従い、既存成果のレビュー後、docs/tasks/next-research-target.md と台帳の「現在の研究対象」の最初の未達項目から、有限入力の一つの判定または構造化本文の一つの定義・主張・定理だけを前進させてください。必要な SageMath 検算、全検証、台帳と MEMORY の更新、コミット、origin の remote default branch への push、包含確認、Slack 通知まで行ってください。Slack は --topic "有限双曲曲面上の可算イジング模型" --artifact-url "https://hexcomp-artifacts.web.app/math/countable-hyperbolic-ising-mathjax/" を指定してください。通知の本文は自分で書かず、リポジトリ直下の scripts/compose-tick-report.py に今回の一歩の一文を渡して組み立ててください（python3 scripts/compose-tick-report.py countable-ising-on-hyperbolic-surfaces "<今回の一歩>"）。これは報告へ最終ゴール・現在地・今回の一歩・次の一手の四項目を必ず入れるためであり（ユーザー指示 2026-09-05）、組み立てに失敗したら通知せず、失敗を報告して終えてください。公開 URL は本文の最後に添えてください。一 tick 一主張を超えて次へ進まないでください。'

log "=== tick 開始"
log "モデル起動: codex / gpt-5.6-sol / reasoning high / CODEX_HOME=$CODEX_TICK_HOME"
set +e
printf '%s' "$PROMPT" | CODEX_HOME="$CODEX_TICK_HOME" \
  timeout -k 60 "$TICK_TIMEOUT_SECONDS" codex exec \
  -m gpt-5.6-sol -c model_reasoning_effort=high \
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
