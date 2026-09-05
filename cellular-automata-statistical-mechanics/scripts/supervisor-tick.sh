#!/usr/bin/env bash
# cellular-automata-statistical-mechanics の研究の「方向」を 1 回監督する。
# launchd から 6 時間ごとに、研究 tick とは別の専用 worktree 上で呼ばれる。
#
# この tick は研究を前進させない。README の問いとの照合、段取りの妥当性、証明済み事項から
# 得たインサイト、段取りの変更だけを行う。契約の正本は docs/tasks/supervision-runbook.md。
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
PROJECT_NAME="cellular-automata-statistical-mechanics"
LOOP_BRANCH="cellular-automata-research-supervision"

GIT_COMMON_DIR="$(git -C "$SCRIPT_DIR" rev-parse --path-format=absolute --git-common-dir 2>/dev/null || true)"
if [ -n "$GIT_COMMON_DIR" ]; then
  MAIN_REPO_DIR="$(cd "$(dirname "$GIT_COMMON_DIR")" && pwd -P)"
else
  MAIN_REPO_DIR="$HOME/git/masaori/math"
fi

# 研究 tick（.codex/worktrees/tick/cellular-automata-auto-loop）とは別の worktree を使う。
# 同じ worktree を共有すると、監督が研究 tick の未コミット成果を巻き込むか、
# 互いのロックで見送り合う。配置名前空間は起動する CLI に合わせて .codex 側に置く。
LOOP_WORKTREE="$MAIN_REPO_DIR/.codex/worktrees/tick/cellular-automata-research-supervision"

LOG_DIR="$HOME/Library/Logs/cellular-automata-research-supervision"
LOG_FILE="$LOG_DIR/supervision.log"
LOCK_DIR="$LOG_DIR/supervision.lock"
LEFTOVER_MARK="$LOG_DIR/leftover-from-tick"
TICK_TIMEOUT_SECONDS=2400

# 対話シェルの割り当てに依存せず、この tick のアカウントを固定する。
CODEX_TICK_HOME="$HOME/.codex-coding-agent-0002"

mkdir -p "$LOG_DIR"
# 進捗行は supervision.log と launchd の標準出力の両方へ書く。片方だけだと、外から見張っている
# 点検（local-pc-management の check-daily-jobs-health.py）が失敗の原因を読めない。
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
export PATH

for cli in codex timeout git node; do
  if ! command -v "$cli" >/dev/null 2>&1; then
    log "SKIP: 必要なコマンドが PATH に無い: $cli"
    exit 1
  fi
done

if [ ! -d "$CODEX_TICK_HOME" ] || [ ! -s "$CODEX_TICK_HOME/auth.json" ]; then
  log "ERROR: tick 専用の Codex 設定または認証ファイルが無い: $CODEX_TICK_HOME"
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
  if [ -n "$stale_pid" ] && kill -0 "$stale_pid" 2>/dev/null && [ "$lock_age" -lt 3000 ]; then
    log "SKIP: 前の監督 (pid $stale_pid) がまだ走っている"
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
  log "監督用の専用 worktree を作る: $LOOP_WORKTREE"
  mkdir -p "$(dirname "$LOOP_WORKTREE")"
  git -C "$MAIN_REPO_DIR" worktree add -B "$LOOP_BRANCH" "$LOOP_WORKTREE" origin/main >> "$LOG_FILE" 2>&1
fi

cd "$LOOP_WORKTREE"

if [ -z "$(git status --porcelain)" ]; then
  rm -f "$LEFTOVER_MARK"
  if ! git merge --ff-only origin/main >> "$LOG_FILE" 2>&1; then
    log "SKIP: 監督用ブランチを origin/main へ fast-forward できない"
    exit 1
  fi
elif [ -f "$LEFTOVER_MARK" ]; then
  log "前回の未コミット成果を引き継ぐ（$(cat "$LEFTOVER_MARK")）"
else
  log "SKIP: 監督用 worktree に由来不明の未コミット変更がある"
  exit 1
fi

# 記録の検査と段取りの検査だけが依存を要る。段取りを変えた回に検査を通せるよう、
# 監督でも構造化テキスト側の依存を用意しておく。
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

SOFT_DEADLINE="$(date -v+32M '+%H:%M' 2>/dev/null || date -d '+32 minutes' '+%H:%M')"
HARD_DEADLINE="$(date -v+40M '+%H:%M' 2>/dev/null || date -d '+40 minutes' '+%H:%M')"

PROMPT=$(cat <<'EOF'
[[AI_AGENT_MESSAGE]]
cellular-automata-statistical-mechanics の研究の「方向」を 1 回監督する。
**これは研究を前進させる自動ループではない。** 本文の定義・主張・定理を進めてはならない。

最初に次を全て読む。
- docs/context/ の全ファイル
- cellular-automata-statistical-mechanics/README.md
- cellular-automata-statistical-mechanics/docs/マニフェスト.md
- cellular-automata-statistical-mechanics/docs/tasks/supervision-runbook.md（この監督の契約の正本）
- cellular-automata-statistical-mechanics/docs/tasks/supervision-log.jsonl（直前までの監督の記録）
- cellular-automata-statistical-mechanics/structured-latex/research-roadmap.ts（段取りの正本）
- cellular-automata-statistical-mechanics/docs/tasks/auto-loop-runbook.md
- cellular-automata-statistical-mechanics/docs/tasks/auto-loop-state.md
  （直前の監督の記録の末尾以降に積まれた節を全て読む。そこが今回の対象範囲である）

supervision-runbook.md の契約どおり、次の四つを必ず全て判定する。
1. 最終ゴールとの照合。README の三つの問いと五つの成果物、マニフェストの成功条件に対して、
   対象範囲の成果が寄与しているか。手段（検査基盤・公開・整形）の改善だけが積まれていれば「逸脱」と書く。
   逸脱を避けるために判定を甘くしてはならない。
2. 段取りの妥当性。research-roadmap.ts の七段階について、段取りが書かれた時点では分かっていなかった
   ことが成果から分かっていないか。完了条件が実際には有限検査へ落ちない、依存が逆・不要、範囲に
   扱えない対象が混ざる、段取りに無い対象が繰り返し現れる、のいずれかがあれば「要変更」と書く。
3. 証明済み事項から得たインサイト。対象範囲で本文へ入った定義・主張・定理から何が分かったかを書く。
   定理の再述ではなく、次の探索の向きを変えうる内容を書く。無いなら無いと書く。
4. 段取りの変更。変えるべきだと結論したなら research-roadmap.ts をこの監督の中で実際に変更する。
   提案だけを残して次へ送らない。変更したら証拠と差分を記録へ書き、
   scripts/verify-roadmap-artifact.sh を通す。**ゴールを縮める変更をしてはならない。**
   README の三つの問いが射程から落ちる変更は権限の外なので、人間へ渡す判断として記録へ書いて止める。

進捗を件数で測ってはならない。証明の件数・ブロック数・検査の件数・ページ数は進捗ではない。
記録には反復の中身（対象・仮説・反例・不変量・採否・インサイト・次の探索への接続）を書く。
対象は本文のラベルかプロジェクト内のファイルで指す。実在しない対象を書いた記録は検査が落とす。

判定を終えたら docs/tasks/supervision-log.jsonl へ 1 行追記し、次を通す。
  node cellular-automata-statistical-mechanics/scripts/verify-supervision-log.ts
  node cellular-automata-statistical-mechanics/scripts/verify-supervision-log-test.ts
  bash cellular-automata-statistical-mechanics/scripts/verify-cellular-automata-supervisor-tick.sh
検証が落ちたら、検証を記録に合わせて緩めず、記録の側を契約どおりに直す。

MEMORY.md を更新し、commit、origin/main への push、fetch 後の ancestry 確認まで行う。
Slack 通知はこのエージェントから送らない。アーティファクトを新規に作らない。

この監督は @HARD@ に強制終了される。@SOFT@ を過ぎたら新規の調査を止め、現在の判定を記録へ書き、
検証・MEMORY・commit・push・ancestry 確認を完了させる。時間を予測せず、date の実測で判断する。
EOF
)
PROMPT="${PROMPT//@SOFT@/$SOFT_DEADLINE}"
PROMPT="${PROMPT//@HARD@/$HARD_DEADLINE}"

log "=== 監督開始（6 時間間隔 / まとめ ${SOFT_DEADLINE} / 強制終了 ${HARD_DEADLINE}）"
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
  0) log "=== 監督 正常終了（未コミット ${dirty_count} ファイル）" ;;
  124|137) log "=== 監督 打ち切り（${TICK_TIMEOUT_SECONDS} 秒、exit ${status}、未コミット ${dirty_count} ファイル）" ;;
  *) log "=== 監督 異常終了（exit ${status}、未コミット ${dirty_count} ファイル）" ;;
esac

# 正常終了を名乗る回は、記録が契約を満たしていることまで確かめる。エージェントが記録を
# 書かずに終えた回を成功として通すと、監督が回っているように見えて中身が無い状態になる。
if [ "$status" -eq 0 ]; then
  if ! node "$LOOP_WORKTREE/$PROJECT_NAME/scripts/verify-supervision-log.ts" >> "$LOG_FILE" 2>&1; then
    log "NG: 監督は正常終了したが、記録が契約を満たしていない"
    exit 1
  fi
  log "監督の記録が契約を満たしていることを確認した"
fi

exit "$status"
