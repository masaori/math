#!/usr/bin/env bash
# cellular-automata-statistical-mechanics の研究を 1 tick 進める。
# launchd から 30 分ごとに、専用 worktree 上で呼ばれる。
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
PROJECT_NAME="cellular-automata-statistical-mechanics"
LOOP_BRANCH="cellular-automata-loop"

GIT_COMMON_DIR="$(git -C "$SCRIPT_DIR" rev-parse --path-format=absolute --git-common-dir 2>/dev/null || true)"
if [ -n "$GIT_COMMON_DIR" ]; then
  MAIN_REPO_DIR="$(cd "$(dirname "$GIT_COMMON_DIR")" && pwd -P)"
else
  MAIN_REPO_DIR="$HOME/git/masaori/math"
fi

# 起動口が用意した専用 worktree をそのまま使う。ここから別の worktree を作ると、
# パスから所有リポジトリを読めない置き場所へ成果が残り、tick ごとに worktree が 2 つできる。
LOOP_WORKTREE="$MAIN_REPO_DIR/.codex/worktrees/tick/cellular-automata-auto-loop"

LOG_DIR="$HOME/Library/Logs/cellular-automata-auto-loop"
LOG_FILE="$LOG_DIR/auto-loop.log"
LOCK_DIR="$LOG_DIR/auto-loop.lock"
LEFTOVER_MARK="$LOG_DIR/leftover-from-tick"
TICK_TIMEOUT_SECONDS=1620

# 正規起動口が起動前に選んだアカウントを使い、この実行中は変更しない。
CODEX_TICK_HOME="${CODEX_HOME:?正規の起動口がCODEX_HOMEを設定する必要がある}"

mkdir -p "$LOG_DIR"
# 進捗行は auto-loop.log と launchd の標準出力の両方へ書く。**片方だけだと、外から
# 見張っている点検（local-pc-management の check-daily-jobs-health.py）が失敗の原因を
# 読めない。** 実際に 2026-08-22、launchd 側が空だったせいで、上限で終えた tick の原因が
# 「ログは空」としか出ず、2日前の無関係な ssh エラーが原因として拾われた。
# エージェントの生出力は量が多いので LOG_FILE だけに残し、ここでは短い進捗行だけ複製する。
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE"; }

PATH="$HOME/.agent-shims:$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
[ -d "$HOME/.local/share/mise/shims" ] && PATH="$HOME/.local/share/mise/shims:$PATH"
if [ -d "$HOME/.nvm/versions/node" ]; then
  nvm_default="$(cat "$HOME/.nvm/alias/default" 2>/dev/null || true)"
  nvm_bin=""
  if [ -n "$nvm_default" ]; then
    nvm_bin="$(find "$HOME/.nvm/versions/node" -mindepth 1 -maxdepth 1 -type d \
      -name "v${nvm_default#v}*" -print | sort -V | tail -1)"
  fi
  if [ -z "$nvm_bin" ]; then
    nvm_bin="$(find "$HOME/.nvm/versions/node" -mindepth 1 -maxdepth 1 -type d \
      -name 'v*' -print | sort -V | tail -1)"
  fi
  [ -n "$nvm_bin" ] && PATH="$nvm_bin/bin:$PATH"
fi
[ -d "$HOME/.elan/bin" ] && PATH="$HOME/.elan/bin:$PATH"
export PATH

for cli in codex timeout git; do
  if ! command -v "$cli" >/dev/null 2>&1; then
    log "SKIP: 必要なコマンドが PATH に無い: $cli"
    exit 1
  fi
done

if [ ! -d "$CODEX_TICK_HOME" ] || [ ! -s "$CODEX_TICK_HOME/auth.json" ]; then
  log "ERROR: 起動口から渡された Codex 設定または認証ファイルが無い: $CODEX_TICK_HOME"
  exit 1
fi

# trap から呼ばれるため、静的解析には通常の関数呼び出しとして見えない。
# shellcheck disable=SC2329
cleanup_lock() {
  rm -f "$LOCK_DIR/pid"
  rmdir "$LOCK_DIR" 2>/dev/null || true
}

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  stale_pid="$(cat "$LOCK_DIR/pid" 2>/dev/null || true)"
  lock_age="$(( $(date +%s) - $(stat -f %m "$LOCK_DIR" 2>/dev/null || echo 0) ))"
  if [ -n "$stale_pid" ] && kill -0 "$stale_pid" 2>/dev/null && [ "$lock_age" -lt 2100 ]; then
    log "SKIP: 前の tick (pid $stale_pid) がまだ走っている"
    exit 0
  fi
  rm -f "$LOCK_DIR/pid"
  if ! rmdir "$LOCK_DIR" 2>/dev/null; then
    log "SKIP: 古いロックに未知の内容があり、安全に除去できない: $LOCK_DIR"
    exit 1
  fi
  mkdir "$LOCK_DIR"
  log "WARN: 死んだロックを除去した (pid ${stale_pid:-unknown})"
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap cleanup_lock EXIT

probe_start="$(date +%s)"
timeout 30 git -C "$MAIN_REPO_DIR" status --porcelain >/dev/null 2>&1 || true
probe_elapsed=$(( $(date +%s) - probe_start ))
if [ "$probe_elapsed" -ge 20 ]; then
  log "SKIP: 機械が応答しない（git status に ${probe_elapsed} 秒）"
  exit 0
fi

git -C "$MAIN_REPO_DIR" fetch --quiet origin || {
  log "SKIP: origin の取得に失敗した"
  exit 1
}

if [ ! -e "$LOOP_WORKTREE/.git" ]; then
  log "専用 worktree を作る: $LOOP_WORKTREE"
  mkdir -p "$(dirname "$LOOP_WORKTREE")"
  git -C "$MAIN_REPO_DIR" worktree add -B "$LOOP_BRANCH" "$LOOP_WORKTREE" origin/main >> "$LOG_FILE" 2>&1
fi

cd "$LOOP_WORKTREE"

if [ -z "$(git status --porcelain)" ]; then
  rm -f "$LEFTOVER_MARK"
  if ! git merge --ff-only origin/main >> "$LOG_FILE" 2>&1; then
    log "SKIP: 専用ブランチを origin/main へ fast-forward できない"
    exit 1
  fi
elif [ -f "$LEFTOVER_MARK" ]; then
  log "前 tick の未コミット成果を引き継ぐ（$(cat "$LEFTOVER_MARK")）"
else
  log "SKIP: 専用 worktree に由来不明の未コミット変更がある"
  exit 1
fi

ensure_node_modules() {
  local rel="$1"
  local dst="$LOOP_WORKTREE/$rel/node_modules"
  local src="$MAIN_REPO_DIR/$rel/node_modules"
  local lock="$rel/pnpm-lock.yaml"
  [ -f "$LOOP_WORKTREE/$lock" ] || return 0
  [ -d "$dst" ] && return 0
  if [ -d "$src" ] && cmp -s "$MAIN_REPO_DIR/$lock" "$LOOP_WORKTREE/$lock"; then
    cp -Rc "$src" "$dst"
    log "依存を clone copy で持ち込んだ: $rel"
  else
    (cd "$LOOP_WORKTREE/$rel" && pnpm install --frozen-lockfile) >> "$LOG_FILE" 2>&1
    log "依存を lockfile から用意した: $rel"
  fi
}

ensure_node_modules "structured-latex"
ensure_node_modules "$PROJECT_NAME/structured-latex"

ensure_lean_packages() {
  local lean_dir="$LOOP_WORKTREE/$PROJECT_NAME/lean"
  local manifest="$lean_dir/lake-manifest.json"
  local dst="$lean_dir/.lake/packages"
  [ -f "$manifest" ] || return 0
  [ -d "$dst/mathlib/.lake/build" ] && return 0
  [ -e "$dst" ] && return 0

  local candidate candidate_manifest
  for candidate in \
    "$MAIN_REPO_DIR/$PROJECT_NAME/lean/.lake/packages" \
    "$MAIN_REPO_DIR/countable-core-of-3d-ising/lean/.lake/packages" \
    "$MAIN_REPO_DIR/exact-solution-of-2d-ising-model-lambda/lean/.lake/packages"; do
    candidate_manifest="$(dirname "$(dirname "$candidate")")/lake-manifest.json"
    if [ -d "$candidate/mathlib/.lake/build" ] && cmp -s "$candidate_manifest" "$manifest"; then
      mkdir -p "$(dirname "$dst")"
      cp -Rc "$candidate" "$dst"
      log "Lean 依存を clone copy で持ち込んだ: $candidate"
      return 0
    fi
  done
  log "WARN: 一致する取得済み Lean 依存が無い。必要なら tick 内で lake update する"
}

ensure_lean_packages

SOFT_DEADLINE="$(date -v+22M '+%H:%M' 2>/dev/null || date -d '+22 minutes' '+%H:%M')"
HARD_DEADLINE="$(date -v+27M '+%H:%M' 2>/dev/null || date -d '+27 minutes' '+%H:%M')"

PROMPT=$(cat <<'EOF'
[[AI_AGENT_MESSAGE]]
cellular-automata-statistical-mechanics の自動ループを 1 tick 進める。

最初に次を全て読む。
- docs/context/ の全ファイル
- cellular-automata-statistical-mechanics/README.md
- cellular-automata-statistical-mechanics/docs/マニフェスト.md
- cellular-automata-statistical-mechanics/MEMORY.md
- cellular-automata-statistical-mechanics/docs/tasks/auto-loop-runbook.md
- cellular-automata-statistical-mechanics/docs/tasks/auto-loop-state.md
- cellular-automata-statistical-mechanics/docs/2値セルオートマトンの定義と呼び名.md
- 今回の対象に直接関係する survey / ideas / structured-latex のファイル

runbook の通り、前 tick のレビューを先に行う。成果整理の未解消の欠陥があれば先に直す。
整理が全層完了していれば、README が正本とする research-roadmap.ts の現在の段階と
台帳の「現在の研究対象」を読み、先頭の未完了対象を一層進める。既存の目的の実行に再開許可を求めない。
物理的意味を先に入れず、量の定義域・所属・必要な演算を確かめる。未定義の対数や除算は使わない。
新しい主張も二章の分類と依存順、節の入力・出力・主張の明示を維持する。
既存成果の再検査や台帳の行数だけを新しい研究成果としない。

研究方向を守る。既存の量子論・場の量子論・相対論を CA へ実装しない。物理的意味を局所規則へ
入れず、有限舞台と有限真理値表から内在的に生じる数学構造を先に抽出する。ヒルベルト空間、
作用素代数、多様体、因果集合を目標仕様として先取りしない。非可算構造は説明のための理想化された
近似でありうるという前提に立つが、数学的な近似を主張する場合は比較写像と誤差または収束概念を定義する。
CA 自体も正解として先取りせず、反例と非対応を成果として保存する。

検証を通し、台帳と MEMORY を更新し、commit、origin/main への push、fetch 後の ancestry 確認まで行う。
Slack 通知はこのエージェントから送らない。正常終了後に外側の処理が論文を公開し、公開 URL つきで一度だけ通知する。

この tick は @HARD@ に強制終了される。@SOFT@ を過ぎたら新規着手を止め、現在の成果を検証し、
台帳・MEMORY・commit・push・ancestry 確認を完了させる。時間を予測せず、date の実測で判断する。
EOF
)
PROMPT="${PROMPT//@SOFT@/$SOFT_DEADLINE}"
PROMPT="${PROMPT//@HARD@/$HARD_DEADLINE}"

log "=== tick 開始（codex / 30 分間隔 / まとめ ${SOFT_DEADLINE} / 強制終了 ${HARD_DEADLINE}）"
# 実行モデルとアカウントを固定する。上限・失敗時も別モデル／別 CLI へ切り替えない。
log "モデル起動: codex / gpt-6-astra / reasoning medium / CODEX_HOME=$CODEX_TICK_HOME"
set +e
printf '%s' "$PROMPT" | CODEX_HOME="$CODEX_TICK_HOME" \
  timeout -k 60 "$TICK_TIMEOUT_SECONDS" codex exec \
  -m gpt-6-astra -c model_reasoning_effort=medium \
  --dangerously-bypass-approvals-and-sandbox - >> "$LOG_FILE" 2>&1
status=$?
set -e

dirty_count="$(git status --porcelain | wc -l | tr -d ' ')"
if [ "$dirty_count" != "0" ]; then
  printf '%s に exit %s で終了し、%s ファイルが未コミットで残った\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "$status" "$dirty_count" > "$LEFTOVER_MARK"
else
  rm -f "$LEFTOVER_MARK"
fi

case "$status" in
  0) log "=== tick 正常終了（未コミット ${dirty_count} ファイル）" ;;
  124|137) log "=== tick 打ち切り（${TICK_TIMEOUT_SECONDS} 秒、exit ${status}、未コミット ${dirty_count} ファイル）" ;;
  *) log "=== tick 異常終了（exit ${status}、未コミット ${dirty_count} ファイル）" ;;
esac

loop_pdf="$LOOP_WORKTREE/$PROJECT_NAME/structured-latex/build/document.pdf"
main_pdf_dir="$MAIN_REPO_DIR/$PROJECT_NAME/structured-latex/build"
if [ -f "$loop_pdf" ] && [ -d "$MAIN_REPO_DIR/$PROJECT_NAME" ]; then
  mkdir -p "$main_pdf_dir"
  cp "$loop_pdf" "$main_pdf_dir/document.pdf"
  log "PDF を共有チェックアウト側へ更新した"
fi

if [ "$status" -eq 0 ] && [ "$dirty_count" = "0" ]; then
  if /bin/bash "$LOOP_WORKTREE/$PROJECT_NAME/scripts/publish-artifact.sh" >> "$LOG_FILE" 2>&1; then
    git rev-parse HEAD > "$LOG_DIR/last-success-commit"
    log "論文公開・URL つき Slack 通知の処理を完了した"
  else
    log "NG: 論文の公開または URL つき Slack 通知に失敗した"
    exit 1
  fi
fi

exit "$status"
