#!/usr/bin/env bash
set -euo pipefail
: "${CODEX_HOME:?正規の起動口がCODEX_HOMEを設定する必要がある}"

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
# 起動口が用意した専用 worktree の正規配置。所有リポジトリ配下に置くことで、
# パスだけでどのリポジトリの何のための worktree かが分かる。
LOOP_WORKTREE="$HOME/git/masaori/math/.codex/worktrees/tick/math-complex-matrix-ising-paper-organization-loop"
LOOP_BRANCH="goal/complex-matrix-ising-paper-organization-loop"
LOG_DIR="$HOME/Library/Logs/math-complex-matrix-ising-paper-organization"
LOG_FILE="$LOG_DIR/tick.log"
LOCK_DIR="$LOG_DIR/tick.lock"
TIMEOUT_SECONDS=3300
GIT_NETWORK_TIMEOUT_SECONDS=120

NODE_BIN="$HOME/.local/share/mise/installs/node/22.22.3/bin"
test -x "$NODE_BIN/node"
test -x "$NODE_BIN/npm"
PATH="$HOME/.local/bin:$NODE_BIN:$HOME/.elan/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Codex の exec_command は既定で /bin/bash -lc を使う。bashrc の mise activate が
# 本文コマンドより先に hook-env を実行するため、内側の timeout ではその停滞を
# 打ち切れない。tick 内ではmise shimではなくNode実体を含む実行系をPATHで
# 固定済みなので、子シェルの
# mise 設定探索を止め、本文コマンドまで有限時間で到達させる。
MISE_NO_CONFIG=1
export PATH MISE_NO_CONFIG
mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%F %T')" "$1" | tee -a "$LOG_FILE"; }

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  prior_pid=""
  if [ -f "$LOCK_DIR/pid" ]; then
    IFS= read -r prior_pid < "$LOCK_DIR/pid"
  fi
  if [ -n "$prior_pid" ] && kill -0 "$prior_pid" 2>/dev/null; then
    log "SKIP: 前の論文構成tick（pid ${prior_pid}）が動作中"
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
  log "ERROR: git fetchに失敗（exit ${fetch_status}）"
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
continuation_mode=0
if "$PROJECT_DIR/scripts/paper-organization-has-pending-work.sh" "$REPO_DIR" "origin/$default_branch"; then
  continuation_mode=1
  log "INFO: 前回tickの未コミット成果またはremote default未包含コミットを保持して続行"
else
  git -C "$REPO_DIR" merge --ff-only "origin/$default_branch"
fi
start_default_commit="$(git -C "$REPO_DIR" rev-parse "origin/$default_branch")"
run_id="$(date '+%Y%m%dT%H%M%S')-$$"
success_prefix="TICK_RESULT_SUCCESS:$run_id:"
run_output="$LOG_DIR/tick-run-$run_id.log"

if [ "$continuation_mode" -eq 1 ]; then
  mode_instruction="継続モードである。未コミット差分またはremote default未包含コミット以外の新しい分類・依存境界へ着手せず、既存差分または未包含コミットの内容と前回ログを一度だけ確認し、未完のレビュー、指摘修正、全検証、状態とMEMORYの整合、必要なコミット、remote default反映を完了する。既に成功を確認できる工程を理由なく反復せず、巨大なdiffや全文を出力へ貼らない。"
else
  mode_instruction="新規モードである。状態台帳の『次の一歩』から、既存棚卸し項目を最大二項だけ扱う。三項以上の本文分割・形式化同期が必要と判明した場合は本文を大規模改変せず、その境界候補と次回の一単位を状態台帳へ記録するところまでを成果とする。独立した別境界へ進まない。"
fi

PROMPT="[[AI_AGENT_MESSAGE]] 複素行列版2次元イジング模型の論文構成再編を1 tickだけ進める。この実行はlaunchdから起動されたtmux外のtickであり、作業場所は正規起動口が用意済みである。AGENTS.mdのclaim-worktreeはtmux担当窓が作業場所を登録する規則なので、このtick自身からdelegation_completion.py claim-worktreeを呼ばない。TMUX_PANEを偽装せず、既存の作業場所で進める。AGENTS.md、CLAUDE.md、docs/context/全ファイル、exact-solution-of-2d-ising-model/README.md、'$PROJECT_DIR/docs/tasks/paper-organization-runbook.md'、'$PROJECT_DIR/docs/tasks/paper-organization-state.md'、'$PROJECT_DIR/MEMORY.md'を全文読む。$mode_instruction 別エージェントによるレビューと指摘修正を同じ単位で反復する。共有main作業ツリー、lambda版、既存tick、docs/contextは変更しない。全てのexec_commandはlogin=falseを明示し、/bin/bash -lcを使わない。論文側のnpm操作は作業ディレクトリに依存させず、必ず npm --prefix '$PROJECT_DIR/structured-latex' run <script> とする。ラベル再生成は npm --prefix '$PROJECT_DIR/structured-latex' run gen、棚卸し再生成は npm --prefix '$PROJECT_DIR/structured-latex' run inventory:organization、論文検査は npm --prefix '$PROJECT_DIR/structured-latex' run check を使う。リポジトリ直下でprefixなしのnpm runを実行しない。状態台帳の次の一歩は2次元イジングモデル章だけを進め、並行担当が編集する数学的道具立ての分類・節境界は変更しない。全検証、状態とMEMORY更新、コミットまで行う。launchd由来のtmux外実行ではGitHub CLIのkeyringを読めないため gh は一切実行しない。反映はSSHのGitだけを使い、120秒上限付きでfetchしたremote defaultを取り込み、検証後の成果コミットを git push origin HEAD:$default_branch で直接反映する。non-fast-forwardなら別手段へ切り替えず、同じGit経路でfetch・merge・再検証してから同じpushを行う。最後にfetchし、成果コミットのremote default包含を確認する。失敗時は別手段へフォールバックせず、一次情報をログへ残して停止し、成功マーカーを出力しない。全作業が成功し、今回の成果コミットがremote defaultの祖先であることをfetch後に確認した場合だけ、最終行へ '${success_prefix}<成果コミットの40桁小文字SHA>' を正確に1行出力する。"

log "START: 論文構成tick"
log "モデル起動: codex / gpt-5.6-sol / reasoning high / CODEX_HOME=$CODEX_HOME"
set +e
printf '%s' "$PROMPT" \
  | timeout -k 60 "$TIMEOUT_SECONDS" codex exec -m gpt-5.6-sol -c model_reasoning_effort=high -C "$REPO_DIR" - 2>&1 \
  | tee -a "$LOG_FILE" "$run_output"
pipeline_status=("${PIPESTATUS[@]}")
status="${pipeline_status[1]}"
tee_status="${pipeline_status[2]}"
set -e
if [ "$tee_status" -ne 0 ]; then
  status="$tee_status"
  log "ERROR: tick出力の記録に失敗（exit ${tee_status}）"
fi
has_pending_work=0
if "$PROJECT_DIR/scripts/paper-organization-has-pending-work.sh" "$REPO_DIR" "origin/$default_branch"; then
  has_pending_work=1
fi
timeout_disposition="$("$PROJECT_DIR/scripts/paper-organization-timeout-disposition.sh" "$status" "$has_pending_work")"
if [ "$timeout_disposition" = checkpoint ]; then
  log "CHECKPOINT: 有限上限までの成果をworktreeへ保持し、次回は継続モードで完了工程だけを行う（exit ${status}）"
  exit 0
fi
if [ "$status" -eq 0 ]; then
  if ! result_commit="$("$PROJECT_DIR/scripts/verify-paper-organization-tick-result.sh" "$run_output" "$success_prefix")"; then
    status=1
    log "ERROR: 成果包含を示す実行固有成功マーカーの検証に失敗"
  else
    set +e
    timeout -k 10 "$GIT_NETWORK_TIMEOUT_SECONDS" git -C "$REPO_DIR" fetch origin >>"$LOG_FILE" 2>&1
    verify_fetch_status=$?
    set -e
    if [ "$verify_fetch_status" -ne 0 ]; then
      status="$verify_fetch_status"
      log "ERROR: 成果包含確認のgit fetchに失敗（exit ${verify_fetch_status}）"
    elif [ "$result_commit" = "$start_default_commit" ]; then
      status=1
      log "ERROR: 成果コミットがtick開始時のremote defaultと同一"
    elif ! git -C "$REPO_DIR" merge-base --is-ancestor "$result_commit" "origin/$default_branch"; then
      status=1
      log "ERROR: 成果コミットがremote defaultに含まれていない（${result_commit}）"
    fi
  fi
fi
if [ "$status" -eq 0 ]; then
  # 台帳の前進だけでは人間が読む公開物が古いままになる（2026-08-30 から 2026-09-05 まで
  # 構成棚卸しページが更新されず、人間から「全く変化していない」と指摘された）。
  # 成果を remote default へ反映した後、同じ tick で公開物まで追随させる。
  log "PUBLISH: 論文本体と構成棚卸しの公開物を更新"
  set +e
  "$PROJECT_DIR/scripts/publish-paper-organization-artifacts.sh" >>"$LOG_FILE" 2>&1
  publish_status=$?
  set -e
  if [ "$publish_status" -ne 0 ]; then
    status="$publish_status"
    log "ERROR: 公開物の更新に失敗（exit ${publish_status}）"
  fi
fi
case "$status" in
  0) log "SUCCESS: 論文構成tick完了" ;;
  124|137) log "TIMEOUT: 前回成果をworktreeへ保持（exit ${status}）" ;;
  *) log "ERROR: 論文構成tick異常終了（exit ${status}）" ;;
esac
exit "$status"
