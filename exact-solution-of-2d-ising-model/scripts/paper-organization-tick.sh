#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
LOOP_WORKTREE="/Users/masaori/git/masaori/math-complex-matrix-ising-paper-loop"
LOOP_BRANCH="goal/complex-matrix-ising-paper-organization-loop"
LOG_DIR="$HOME/Library/Logs/math-complex-matrix-ising-paper-organization"
LOG_FILE="$LOG_DIR/tick.log"
LOCK_DIR="$LOG_DIR/tick.lock"
TIMEOUT_SECONDS=3300
GIT_NETWORK_TIMEOUT_SECONDS=120

PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$HOME/.elan/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH
mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%F %T')" "$1" | tee -a "$LOG_FILE"; }

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  prior_pid=""
  if [ -f "$LOCK_DIR/pid" ]; then
    IFS= read -r prior_pid < "$LOCK_DIR/pid"
  fi
  if [ -n "$prior_pid" ] && kill -0 "$prior_pid" 2>/dev/null; then
    log "SKIP: 前の論文構成tick（pid $prior_pid）が動作中"
    exit 0
  fi
  log "RECOVER: 所有プロセスの無いstale lockを回収"
  rm -f "$LOCK_DIR/pid"
  rmdir "$LOCK_DIR"
  mkdir "$LOCK_DIR"
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap 'rm -f "$LOCK_DIR/pid"; rmdir "$LOCK_DIR"' EXIT

test "$REPO_DIR" = "$LOOP_WORKTREE"
test "$(git -C "$REPO_DIR" branch --show-current)" = "$LOOP_BRANCH"
log "PREPARE: remote default追随を開始"
set +e
timeout -k 10 "$GIT_NETWORK_TIMEOUT_SECONDS" git -C "$REPO_DIR" fetch origin >>"$LOG_FILE" 2>&1
fetch_status=$?
set -e
if [ "$fetch_status" -ne 0 ]; then
  log "ERROR: git fetchに失敗（exit $fetch_status）"
  exit "$fetch_status"
fi
if ! default_ref="$(git -C "$REPO_DIR" symbolic-ref --quiet refs/remotes/origin/HEAD)"; then
  log "ERROR: origin/HEADをローカル参照から取得できない"
  exit 1
fi
case "$default_ref" in
  refs/remotes/origin/*) default_branch="${default_ref#refs/remotes/origin/}" ;;
  *) log "ERROR: origin/HEADがremote branchを指していない"; exit 1 ;;
esac
test -n "$default_branch"
if [ -z "$(git -C "$REPO_DIR" status --porcelain)" ]; then
  git -C "$REPO_DIR" merge --ff-only "origin/$default_branch"
else
  log "INFO: 前回tickの未コミット成果を保持して続行"
fi

PROMPT='[[AI_AGENT_MESSAGE]] 複素行列版2次元イジング模型の論文構成再編を1 tickだけ進める。AGENTS.md、CLAUDE.md、docs/context/全ファイル、exact-solution-of-2d-ising-model/README.md、paper-organization-runbook.md、paper-organization-state.md、MEMORY.mdを全文読む。状態台帳の「次の一歩」だけを実施し、別エージェントによるレビューと指摘修正を同じ単位で反復する。共有main作業ツリー、lambda版、既存tick、docs/contextは変更しない。棚卸し再生成、全検証、状態とMEMORY更新、コミット、PR、remote defaultへのマージ、fetch後の包含確認まで行う。失敗時は別手段へフォールバックせず、一次情報をログへ残して停止する。'

log "START: 論文構成tick"
set +e
printf '%s' "$PROMPT" | timeout -k 60 "$TIMEOUT_SECONDS" codex exec -C "$REPO_DIR" - >>"$LOG_FILE" 2>&1
status=$?
set -e
case "$status" in
  0) log "SUCCESS: 論文構成tick完了" ;;
  124|137) log "TIMEOUT: 前回成果をworktreeへ保持（exit $status）" ;;
  *) log "ERROR: 論文構成tick異常終了（exit $status）" ;;
esac
exit "$status"
