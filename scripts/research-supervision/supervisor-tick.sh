#!/usr/bin/env bash
# 既存の監督起動口から、六研究を一つの観測区間として評価する。
set -Eeuo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
GIT_COMMON_DIR="$(git -C "$SCRIPT_DIR" rev-parse --path-format=absolute --git-common-dir)"
MAIN_REPO_DIR="$(cd "$(dirname "$GIT_COMMON_DIR")" && pwd -P)"
LOOP_WORKTREE="$MAIN_REPO_DIR/.codex/worktrees/tick/cellular-automata-research-supervision"
LOG_DIR="$HOME/Library/Logs/cellular-automata-research-supervision"
LOG_FILE="$LOG_DIR/supervision.log"
LOCK_DIR="$LOG_DIR/supervision.lock"
LEFTOVER_MARK="$LOG_DIR/leftover-from-tick"
TICK_TIMEOUT_SECONDS=2400
CODEX_TICK_HOME="${CODEX_HOME:?正規の起動口がCODEX_HOMEを設定する必要がある}"
PATH="$HOME/.agent-shims:$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH
mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE"; }
cleanup_lock() { local result=$?; log "実行終端: exit=$result"; rm "$LOCK_DIR/pid"; rmdir "$LOCK_DIR"; }
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  log "見送り: 監督ロックが存在する。pid と実ログを確認し、別の監督を重ねない"
  exit 0
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap cleanup_lock EXIT
for cli in codex timeout git node; do
  command -v "$cli" >/dev/null || { log "異常終了: 必要なコマンドが無い: $cli"; exit 1; }
done
[ -s "$CODEX_TICK_HOME/auth.json" ] || { log "異常終了: 固定アカウントの認証ファイルが無い"; exit 1; }
timeout 120 git -C "$MAIN_REPO_DIR" fetch --quiet origin
DEFAULT_BRANCH="$(timeout 120 git -C "$MAIN_REPO_DIR" ls-remote --symref origin HEAD | sed -n 's@^ref: refs/heads/\([^[:space:]]*\).*@\1@p')"
[ -n "$DEFAULT_BRANCH" ] || { log "異常終了: remote default を特定できない"; exit 1; }
REMOTE_DEFAULT="origin/$DEFAULT_BRANCH"
[ -e "$LOOP_WORKTREE/.git" ] || { log "異常終了: 正規起動口が監督用worktreeを用意していない"; exit 1; }
cd "$LOOP_WORKTREE"
if [ -f "$LEFTOVER_MARK" ]; then
  log "復旧: 前回と同じ実行識別子・開始時成果を引き継ぐ"
elif [ -z "$(git status --porcelain)" ]; then
  git merge --ff-only "$REMOTE_DEFAULT" >> "$LOG_FILE" 2>&1
else
  log "異常終了: 由来不明の未コミット変更がある"
  exit 1
fi
RUN_STATE="$(node "$SCRIPT_DIR/run-state.ts" "$LEFTOVER_MARK" "$(git rev-parse HEAD)")"
read -r RUN_ID BASE_COMMIT <<< "$RUN_STATE"
git merge-base --is-ancestor "$BASE_COMMIT" HEAD
START_SECONDS="$(date +%s)"
PROMPT=$(cat <<'EOF'
[[AI_AGENT_MESSAGE]]
全六研究の方向を一回監督する。契約の正本 docs/tasks/research-supervision-runbook.md を全文読む。
AGENTS.md、CLAUDE.md、docs/context/全文、scripts/research-supervision/projects.ts の六研究すべての
README、研究runbook、state、MEMORY、直前の監督記録を読む。前回以後の成果と本文を照合する。
初回の対象も停止中の対象も省略しない。今回の実行識別子は @RUN@、開始時成果は @BASE@。
各研究で四項目（最終ゴールとの照合、段取りの妥当性、証明済み事項から得たインサイト、段取りの変更）を評価する。
本文・README・依存関係表・台帳に段取りが埋め込まれていないかを読み、ファイル名だけで不在と判定しない。
実行状態と研究上の前進を分離し、実ログの観測時刻・終了値・出典を各研究の docs/tasks に記録する。
launchctl list/print、plist、実ログの読取は許可されている。登録有無を今回読み取る。
観測できない起動状態は未確認とする。過去の観測を今回の実測として書かない。
停止理由は人間本人の指示、その記録、エージェントの運用文を区別する。研究を再開しない。
READMEから次の具体的対象を根拠つきで導き、上位ゴール設定・再開等の未取得判断は分離して残す。
新しい数学的主張・証明を進める作業はしない。READMEの最終目的と人間の明示停止は維持する。
その範囲の段取り修正は、正本が本文・runbook・stateにある場合も実施し、差分と根拠を残す。
停止条件の上書き、新しい目的の選定、停止研究の再開は行わず、必要な判断として分離する。文書・記録・検査の件数を研究進捗としない。
各研究の docs/tasks/supervision-log.jsonl に schemaVersion:2 の今回評価を一行ずつ追記する。
未完の復旧では @BASE@ と現在を比較し、@RUN@ の既存追記を完成させる。同じ回を重複追記しない。
前回の未コミット・未push成果を保持し、最新remote defaultの変更を取り込んでから修正する。
内容はLLMによる検証と明記し、実行値・受理規則のプログラミングによる検証とは区別する。
node scripts/research-supervision/verify.ts --all と node scripts/research-supervision/verify-supervision-log-test.ts を通す。
監督記録だけの変更で、変更していない数学本文のLean・SageMath全体検査を繰り返さない。
段取りを修正した場合はその変更に対応する既存のプログラミングによる検証を通す。
各研究MEMORYと docs/ゴール台帳.md の既存「全研究の実行状態と研究上の前進を区別し、監督を全研究へ広げる」を更新する。
新規ゴール、アーティファクト、Slack通知は作らない。launchctl bootstrap/bootout/kickstartとLaunchAgentsの編集は禁止。実行途中のアカウント・モデル切替は禁止。
commitしてremote defaultへSSH Gitで反映し、fetch後の包含を確認する。初回は実装担当がPR経由で統合する。
処理上限は2400秒。時計の実測で完了工程へ移る。空の成功や過去記録の再利用は失敗として扱われる。
EOF
)
PROMPT="${PROMPT//@RUN@/$RUN_ID}"
PROMPT="${PROMPT//@BASE@/$BASE_COMMIT}"
log "=== 六研究監督開始 run=$RUN_ID base=$BASE_COMMIT"
log "モデル起動: codex / gpt-5.6-sol / reasoning high / CODEX_HOME=$CODEX_TICK_HOME"
set +e
printf '%s' "$PROMPT" | CODEX_HOME="$CODEX_TICK_HOME" LEAN_NUM_THREADS=1 \
  timeout -k 60 "$TICK_TIMEOUT_SECONDS" codex exec \
  -m gpt-5.6-sol -c model_reasoning_effort=high \
  --dangerously-bypass-approvals-and-sandbox - >> "$LOG_FILE" 2>&1
status=$?
set -e
if [ "$status" -eq 0 ]; then
  timeout 120 git fetch --quiet origin
  if ! node scripts/research-supervision/verify.ts --completed "$BASE_COMMIT" "$RUN_ID" "$REMOTE_DEFAULT" >> "$LOG_FILE" 2>&1; then
    log "異常終了: 今回の六研究評価・履歴保存・remote包含のいずれかが未達 run=$RUN_ID"
    exit 1
  fi
  rm "$LEFTOVER_MARK"
  log "正常終了: 六研究の今回評価がremote defaultに包含された。研究上の前進は各評価を参照 run=$RUN_ID"
elif [ "$status" -eq 124 ] || [ "$status" -eq 137 ]; then
  log "打ち切り: exit=${status} run=$RUN_ID"
else
  log "異常終了: exit=${status} run=$RUN_ID。モデル・アカウントは切り替えない"
fi
log "実行時間: $(( $(date +%s) - START_SECONDS )) 秒 run=$RUN_ID"
exit "$status"
