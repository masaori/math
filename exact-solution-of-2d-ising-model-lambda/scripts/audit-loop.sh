#!/usr/bin/env bash
# 自動ループの出力を、ループの外から独立に検証する。
#
# なぜ要るか: tick は自分で検証して自分で push し、自分の前回の出力を自分でレビューする。
# つまり「done」と書いた本人以外が確かめる経路が無かった。人間が気づいて聞くまで
# 打ち切りや食い違いが埋もれる（実測: 25 分の上限による打ち切りが 4 回、誰にも通知されていなかった）。
#
# 何をするか: origin/main を専用の worktree へ取り出し（走行中の tick と踏み合わないため）、
# 四層の検証を全部回し、台帳の「done」が機械検証を通っているかを突き合わせる。
# **異常があるときだけ** Slack へ通知する（正常時は黙る。毎回通知すると読まれなくなる）。
#
# 手で 1 回だけ回したいとき: bash scripts/audit-loop.sh
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/audit.log"
LOCK_DIR="$LOG_DIR/audit.lock"
WORKTREE="$LOG_DIR/audit-worktree"
PROJECT_NAME="$(basename "$PROJECT_DIR")"

mkdir -p "$LOG_DIR"

log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"; }

PATH="$HOME/.local/bin:$HOME/.elan/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
if [ -s "$HOME/.nvm/alias/default" ]; then
  NODE_VERSION="$(cat "$HOME/.nvm/alias/default")"
  [ -d "$HOME/.nvm/versions/node/v$NODE_VERSION/bin" ] &&
    PATH="$HOME/.nvm/versions/node/v$NODE_VERSION/bin:$PATH"
  for dir in "$HOME"/.nvm/versions/node/v"$NODE_VERSION"*; do
    [ -d "$dir/bin" ] && PATH="$dir/bin:$PATH"
  done
fi
export PATH

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  log "SKIP: 前の監査がまだ走っている"
  exit 0
fi
trap 'rm -rf "$LOCK_DIR"' EXIT

problems=()
add() { problems+=("$1"); log "NG: $1"; }

# --- 1. tick のログから、通知されていない失敗を拾う ---------------------------
# 打ち切り・異常終了は tick 自身が Slack へ通知しない（通知はセクション完了と停止時だけ）。
# 直近 3 時間ぶんを見る。
since="$(date -v-3H '+%Y-%m-%d %H:%M:%S' 2>/dev/null || date -d '3 hours ago' '+%Y-%m-%d %H:%M:%S')"
TICK_STATUS_LOG="$LOG_DIR/auto-loop-status.log"
[ -f "$TICK_STATUS_LOG" ] || TICK_STATUS_LOG="$LOG_DIR/auto-loop.log"
if [ -f "$TICK_STATUS_LOG" ]; then
  # **このスクリプトが書いた行だけを見る。** ログには tick（Claude セッション）の説明文も
  # そのまま流れ込むので、「打ち切り」の語を含む地の文が混ざる。
  # 語で数えると、SageMath の絞り込みを「打ち切りとして記録した」と書いた文まで
  # 打ち切りに数えてしまう（実測: 実際の打ち切り 0 回のところを 7 回と誤報した）。
  # 目印は行頭の日時と `=== tick <結果>` の形に限る。
  recent="$(awk -v since="$since" '/^20[0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] === / && $0 >= since' \
    "$TICK_STATUS_LOG" 2>/dev/null || true)"
  cut_count="$(printf '%s\n' "$recent" | grep -c '=== tick 打ち切り' || true)"
  err_count="$(printf '%s\n' "$recent" | grep -c '=== tick 異常終了' || true)"
  cap_minutes="$(( $(grep -m1 '^TICK_TIMEOUT_SECONDS=' "$PROJECT_DIR/scripts/auto-loop-tick.sh" | cut -d= -f2) / 60 ))"
  [ "${cut_count:-0}" -gt 0 ] && add "直近 3 時間で tick が ${cut_count} 回 ${cap_minutes} 分の上限で打ち切られた（セクションが大きすぎる。割り直しが要る）"
  [ "${err_count:-0}" -gt 0 ] && add "直近 3 時間で tick が ${err_count} 回異常終了した"
fi

# --- 2. origin/main を専用 worktree へ取り出す --------------------------------
git -C "$REPO_DIR" fetch origin --quiet || add "git fetch に失敗した"
head_commit="$(git -C "$REPO_DIR" rev-parse origin/main)"

if [ -d "$WORKTREE" ]; then
  git -C "$REPO_DIR" worktree remove --force "$WORKTREE" >/dev/null 2>&1 || rm -rf "$WORKTREE"
fi
if ! git -C "$REPO_DIR" worktree add --detach --quiet "$WORKTREE" "$head_commit" >> "$LOG_FILE" 2>&1; then
  add "監査用 worktree を作れなかった"
fi

AUDIT_PROJECT="$WORKTREE/$PROJECT_NAME"

run() {  # run <説明> <作業ディレクトリ> <コマンド...>
  local what="$1" dir="$2"; shift 2
  if ! (cd "$dir" && "$@" >> "$LOG_FILE" 2>&1); then
    add "$what が落ちた（origin/main の内容で再現。詳細: logs/audit.log）"
  fi
}

if [ -d "$AUDIT_PROJECT/structured-latex" ]; then
  # worktree には gitignore された依存が無いので入れる（reversible なローカルセットアップ）。
  # **入力言語の正本であるシステム側（リポジトリ直下 structured-latex/）にも入れる。**
  # プロジェクトの schema.ts はそこを import しており、抜けると「モジュールが無い」で落ちる
  # （実測: 監査の初回実行がこれで落ちた。ループの異常ではなく監査側の設定漏れだった）。
  run "依存の取得（システム側 pnpm install）" "$WORKTREE/structured-latex" pnpm install --silent
  run "依存の取得（pnpm install）" "$AUDIT_PROJECT/structured-latex" pnpm install --silent
  run "構造化テキストの検査一式（npm run check）" "$AUDIT_PROJECT/structured-latex" npm run check
  run "PDF の生成（npm run build:pdf）" "$AUDIT_PROJECT/structured-latex" npm run build:pdf
  run "検証と証明の対応" "$AUDIT_PROJECT" node sagemath/tools/verify-check-linkage.ts
fi

# SageMath の検証は台帳が done と言っているものを全部回す（時間はかかるが監査の本体）。
if command -v sage >/dev/null 2>&1; then
  for dir in "$AUDIT_PROJECT"/sagemath/check/*/; do
    [ -f "$dir/check.sage" ] || continue
    run "SageMath 検証 $(basename "$dir")" "$AUDIT_PROJECT" sage "$dir/check.sage"
  done
else
  add "sage が PATH に無いので SageMath 検証を回せなかった"
fi

# Lean は worktree では .lake を持たないので、メインの作業ツリー側で回す
# （origin/main と同じ内容であることを確かめたうえで）。
if [ "$(git -C "$REPO_DIR" rev-parse HEAD)" = "$head_commit" ] &&
   [ -z "$(git -C "$REPO_DIR" status --porcelain)" ]; then
  run "lake build" "$PROJECT_DIR/lean" lake build
  run "sorry 非依存の検査" "$PROJECT_DIR/lean" bash scripts/check-no-sorry.sh
else
  log "注意: メインの作業ツリーが origin/main と一致していないため Lean の検査は行わなかった"
fi

# --- 3. 台帳の主張と実態の突き合わせ -----------------------------------------
ledger="$AUDIT_PROJECT/docs/tasks/auto-loop-state.md"
if [ -f "$ledger" ]; then
  # done と書いたセクションは四層すべてを満たすはずなので、Lean の定理が 1 件も
  # 登録されていないのに done が増えている状態を拾う。
  done_count="$(grep -c '| done |' "$ledger" || true)"
  target_count="$(grep -c '^  Ising2DLambda' "$PROJECT_DIR/lean/scripts/check-no-sorry.sh" || true)"
  log "台帳の done: ${done_count} 件 / sorry 検査の対象定理: ${target_count} 件"
  if [ "${done_count:-0}" -gt 0 ] && [ "${target_count:-0}" -eq 0 ]; then
    add "台帳に done が ${done_count} 件あるのに、sorry 検査の対象定理が 0 件（Lean が実質未検証）"
  fi

  # 本文末尾の「この先に書くこと」と台帳のセクション表の突き合わせ。
  # 本文のリストにしか無い項目は実行の列に並ばないので永久に落ちる（実測で 1 件落ちていた）。
  remark_items="$(grep -c 'todo("残り")\|todo("未着手")' "$AUDIT_PROJECT/structured-latex/content/main-text.ts" 2>/dev/null || echo 0)"
  ledger_todo="$(grep -c '| todo |' "$ledger" 2>/dev/null || echo 0)"
  log "本文の「この先に書くこと」: ${remark_items} 項目 / 台帳の todo: ${ledger_todo} 件"
  if [ "${remark_items:-0}" -gt "${ledger_todo:-0}" ]; then
    add "本文の「この先に書くこと」が ${remark_items} 項目あるのに台帳の todo は ${ledger_todo} 件（台帳に無い項目は実行されない）"
  fi
fi

git -C "$REPO_DIR" worktree remove --force "$WORKTREE" >/dev/null 2>&1 || rm -rf "$WORKTREE"

# --- 4. 異常だけ通知する ------------------------------------------------------
if [ ${#problems[@]} -eq 0 ]; then
  log "OK: 監査で異常なし（origin/main = ${head_commit:0:7}）"
  exit 0
fi

message="自動ループの監査で異常を検出した（origin/main = ${head_commit:0:7}）:"
for p in "${problems[@]}"; do message="$message"$'\n'"・$p"; done
message="$message"$'\n'"詳細: $PROJECT_NAME/logs/audit.log"

log "監査で ${#problems[@]} 件の異常を検出したので通知する"
if ! slack route-post math "$message" \
  --topic "可算対数順序群による二次元イジング模型" \
  --artifact-url "https://hexcomp-artifacts.web.app/math/ising-lambda/" \
  >> "$LOG_FILE" 2>&1; then
  log "Slack の明示routeへの通知に失敗した"
fi

exit 1
