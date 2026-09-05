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

if [ -f "$SCRIPT_DIR/../docs/tasks/auto-loop-paused.md" ] &&
   ! grep -qx "状態: 再開" "$SCRIPT_DIR/../docs/tasks/auto-loop-paused.md"; then
  printf '%s\n' "3次元 Ising の自動 tick は人間指示により停止中である。"
  exit 0
fi

# このループ専用の作業ツリーと、その中のプロジェクト。
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

# 起動口が用意した専用 worktree をそのまま使う。ここから別の worktree を作ると、
# パスから所有リポジトリを読めない置き場所へ成果が残り、tick ごとに worktree が 2 つできる。
LOOP_WORKTREE="$MAIN_REPO_DIR/.codex/worktrees/tick/ising-3d-cut-auto-loop"

# ログとロックはリポジトリの外に置く。作業ツリーはこのスクリプト自身が作ったり origin/main へ
# 合わせ直したりするので、その中にログを置くと「まだ無い」「消える」が起きる。
LOG_DIR="$HOME/Library/Logs/ising-3d-cut-auto-loop"
LOG_FILE="$LOG_DIR/auto-loop.log"
LOCK_DIR="$LOG_DIR/auto-loop.lock"
LEFTOVER_MARK="$LOG_DIR/leftover-from-tick"
CODEX_TICK_HOME="${CODEX_HOME:?正規の起動口がCODEX_HOMEを設定する必要がある}"

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

# 進捗行は auto-loop.log と launchd の標準出力の両方へ書く。**片方だけだと、外から
# 見張っている点検（local-pc-management の check-daily-jobs-health.py）が失敗の原因を
# 読めない。** 実際に 2026-08-22、launchd 側が空だったせいで、上限で終えた tick の原因が
# 「ログは空」としか出ず、2日前の無関係な ssh エラーが原因として拾われた。
# エージェントの生出力は量が多いので LOG_FILE だけに残し、ここでは短い進捗行だけ複製する。
log() {
  printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE"
}

# launchd は対話シェルの PATH を持たないので、必要なものを明示的に足す。
PATH="$HOME/.agent-shims:$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# node / npm は mise または nvm 配下にある。足さないと npm run check も build:pdf も回せない。
if [ -d "$HOME/.local/share/mise/shims" ]; then
  PATH="$HOME/.local/share/mise/shims:$PATH"
fi
if [ -d "$HOME/.nvm/versions/node" ]; then
  nvm_default="$(cat "$HOME/.nvm/alias/default" 2>/dev/null || true)"
  nvm_bin=""
  if [ -n "$nvm_default" ]; then
    nvm_bin="$(find "$HOME/.nvm/versions/node" -mindepth 1 -maxdepth 1 -type d -name "v${nvm_default#v}*" -print | sort -V | tail -1)"
  fi
  if [ -z "$nvm_bin" ]; then
    nvm_bin="$(find "$HOME/.nvm/versions/node" -mindepth 1 -maxdepth 1 -type d -name 'v*' -print | sort -V | tail -1)"
  fi
  [ -n "$nvm_bin" ] && PATH="$nvm_bin/bin:$PATH"
fi
export PATH

# tick は Codex の固定モデルだけを使う。
for cli in codex timeout git; do
  if ! command -v "$cli" >/dev/null 2>&1; then
    log "SKIP: $cli が PATH に無い"
    exit 1
  fi
done

if [ ! -d "$CODEX_TICK_HOME" ] || [ ! -s "$CODEX_TICK_HOME/auth.json" ]; then
  log "ERROR: 起動口から渡された Codex 設定または認証ファイルが無い: $CODEX_TICK_HOME"
  exit 1
fi

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

# launchd の kickstart -k や強制終了が Git の index 更新中に入ると、Git プロセスだけが
# 終了して専用 worktree の空の index.lock が残る。このループ自身の排他ロックを取得済みで、
# かつ lock を開いているプロセスが無い場合に限り回収する。保持者がいる lock は異常として止め、
# 別プロセスの Git 操作へ割り込まない。
WORKTREE_GIT_DIR="$(git -C "$MAIN_REPO_DIR" rev-parse --path-format=absolute \
  --git-path worktrees/"$(basename "$LOOP_WORKTREE")")"
WORKTREE_INDEX_LOCK="$WORKTREE_GIT_DIR/index.lock"
if [ -e "$WORKTREE_INDEX_LOCK" ]; then
  if /usr/sbin/lsof "$WORKTREE_INDEX_LOCK" >/dev/null 2>&1; then
    log "ERROR: 専用 worktree の index.lock を別プロセスが保持している"
    exit 1
  fi
  rm -f "$WORKTREE_INDEX_LOCK"
  log "    保持者のいない専用 worktree の index.lock を回収した"
fi

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
[[AI_AGENT_MESSAGE]]
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
2. そのあと、台帳の「現在の研究対象」の todo の先頭セクションを 1 つだけ進める。2 つ以上進めない。
   時間のかかる処理は前面で実行し、終わるまで待つ。裏で走らせたまま tick を終えると
   その処理は道連れに終了し、成果が残らない。
   **「締切に収まらないから着手しない」と決めて、レビューだけで tick を終えることを禁止する。**
   所要時間の見積もりはできない（できると思っているのは錯覚である）。実測 2026-08-16 に、
   この見積もりを理由に着手しない tick が 4 時間続き、その間 1 行も前進しなかった。
   セクションが大きいと思うなら、**その場で小さく割って、割った先頭だけを完成させる**
   （割った結果は台帳へ書く）。まず着手し、まとめ締切を過ぎたらそこまでの成果を検証して
   コミットする。書きかけでも、検証を通してコミットしてあれば次の tick が続きから進める。
3. 現在の実行対象は docs/tasks/next-research-target.md の固定候補の評価だけである。
   台帳の「現在の研究対象」を進め、過去の並行ストリームを再開しない。
   入力の適合性、候補の採否、存在条件への寄与または不足を記録して閉じる。
   一件を閉じたら小主張・評価点・別候補を自動追加しない。
4. このプロジェクトの立場を厳守する。許される非可算への脱出は箱の大きさの極限だけである。
   上限・下限・積分・微分・無限和・級数・指数関数・実対数・逆温度の記号を使わない。
   相・臨界温度・自発磁化などの無限体積の語を主張に使わない。
   立場を守れないと分かったら、黙って脱出せず、台帳へ論点を書いて報告して止まる。
5. 検証（npm run check / build:pdf / sage / verify-check-linkage）を通す。
   検証が落ちたら本文を直す。検証を主張に合わせて緩めない。
6. 台帳と MEMORY を更新し、main へ push して反映を確認する
   （git push origin HEAD:main と git merge-base --is-ancestor での確認）。
7. tick の最後に PDF を作り直す（cd countable-core-of-3d-ising/structured-latex && npm run build:pdf）。
   本文を変えなかった tick でも必ず行う。
8. 本流を 1 セクション進めたら止まる（現在は並行ストリームを実行しない）。
9. **Slack へ通知しない**（slack-notification skill も curl も使わない）。tick の完了報告は
   この tick スクリプトが最後に 1 通だけ送る。自分でも送ると 1 tick で 2 通届く。
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

log "=== tick 開始（codex / 間隔 ${interval_minutes} 分 / 作業ツリー ${LOOP_WORKTREE} / まとめ ${SOFT_DEADLINE} / 強制終了 ${HARD_DEADLINE}）"
head_before="$(git -C "$LOOP_WORKTREE" rev-parse --short HEAD)"
# 実行モデルとアカウントを固定する。上限・失敗時も別モデル／別 CLI へ切り替えない。
log "モデル起動: codex / gpt-5.6-sol / reasoning high / CODEX_HOME=$CODEX_TICK_HOME"
set +e
printf '%s' "$PROMPT" | CODEX_HOME="$CODEX_TICK_HOME" \
  timeout -k 60 "$TICK_TIMEOUT_SECONDS" codex exec \
  -m gpt-5.6-sol -c model_reasoning_effort=high \
  --dangerously-bypass-approvals-and-sandbox - >> "$LOG_FILE" 2>&1
status=$?
set -e

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
  # 1 なら「進まなかった」。中断（打ち切り・異常終了）だけでなく、**正常終了したのに
  # 証明・検証・形式化が 1 件も増えなかった tick も含める**（2026-08-16 に判明した実害:
  # 「持ち時間では収まらない」と判断してレビューだけで終える tick が 05:03 から 4 時間続き、
  # そのすべてが正常終了だったため、中断だけを見る階段は一度も上がらなかった）。
  local interrupted="$1"
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
        log "    進まない tick が ${INTERRUPTIONS_TO_BACK_OFF} 回続いた。間隔を ${interval_minutes} 分から ${new_interval} 分へ伸ばす（1 tick の持ち時間も伸びる）"
      else
        log "    進まない tick が続いているが、間隔はすでに階段の最長（${interval_minutes} 分）である"
      fi
    else
      log "    進まない tick が ${count} 回目（${INTERRUPTIONS_TO_BACK_OFF} 回続いたら間隔を伸ばす）"
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
  # **正常終了でも、証明・検証・形式化が増えていなければ「進まなかった」として扱う。**
  # 台帳と MEMORY だけを更新した tick（レビューのみの tick）はここに落ちる。
  substantive_commits="$(git -C "$LOOP_WORKTREE" rev-list --count "$head_before..HEAD" -- \
    "$PROJECT_NAME/structured-latex/content" "$PROJECT_NAME/lean" "$PROJECT_NAME/sagemath" \
    2>/dev/null || echo 0)"
  if [ "${substantive_commits:-0}" -gt 0 ]; then
    adjust_interval 0
  else
    log "    本文・Lean・SageMath が 1 件も増えていない（レビューのみ）。進まなかった扱いにする"
    adjust_interval 1
  fi
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
  log "    公開を見送った（exit ${status}、未コミット $(git -C "$LOOP_WORKTREE" status --porcelain | wc -l | tr -d ' ') ファイル）"
fi

# --- Slack への報告（1 tick 1 通。ここに一本化してある） ----------------------
# **通知はこの 1 箇所だけで行う**（2026-08-15 のユーザー指示）。公開スクリプトも、
# tick の中のエージェントも送らない。以前は公開スクリプトが送っていたため、
# 公開まで到達しなかった tick（打ち切り・異常終了）が一度も報告されなかった。
notify_slack() {
  local message="$1"
  if ! slack route-post math "$message" \
    --topic "可算核心による三次元イジング模型" \
    --artifact-url "https://hexcomp-artifacts.web.app/math/ising-3d-cut/" \
    >> "$LOG_FILE" 2>&1; then
    log "    Slack の明示routeへの通知に失敗した"
    return 1
  fi
}

# 見出しは README の表題から取る。**固定文字列にすると、ゴール設定が変わったときに
# 古い名前を通知し続ける**（実測 2026-08-14: 降格した「臨界点の切断」を名乗り続けていた）。
tick_title="$(sed -n '1s/^#\{1,\} *//p' "$LOOP_WORKTREE/$PROJECT_NAME/README.md" 2>/dev/null || true)"
[ -z "$tick_title" ] && tick_title="3 次元 Ising（可算側）"

# その tick が何をしたか。台帳の「現在地」の先頭項目をそのまま使う。
tick_summary="$(python3 - "$LOOP_WORKTREE/$PROJECT_NAME/docs/tasks/auto-loop-state.md" <<'PYEOF' 2>/dev/null || true
import re, sys

text = open(sys.argv[1], encoding="utf-8").read()
section = re.search(r"^## 現在地\n(.*?)(?=^## |\Z)", text, re.S | re.M)
if section is None:
    raise SystemExit(0)

lines, body = section.group(1).strip().split("\n"), []
for line in lines:
    if line.startswith("- ") and body:
        break
    if line.startswith("- "):
        body.append(line[2:].strip())
    elif line.strip():
        body.append(line.strip())
text = " ".join(body).replace("**", "")
# **最初の一文だけを送る**（2026-08-16 に通知の書式を統一した）。
# 一読で「何をしたか」が分かることだけを求め、目的・経緯・検証の羅列は送らない（台帳には残る)。
# 切るのは字数ではなく文の切れ目にする（字数で切ると文が途中で終わって読めなくなる）。
text = re.sub(r"^20\d\d-\d\d-\d\d:\s*", "", text)   # 先頭の日付は通知には要らない
head = text.split("。")[0].strip()
print(head + "。" if head else text)
PYEOF
)"

tick_commit="$(git -C "$LOOP_WORKTREE" rev-parse --short HEAD 2>/dev/null || echo '-')"
[ -z "$tick_summary" ] && tick_summary="$(git -C "$LOOP_WORKTREE" log -1 --format='%s' 2>/dev/null || true)"
# **公開 URL は必ず添える**（ユーザー指示 2026-08-15）。公開が走らなかった tick でも、
# 人は通知から論文を開くので、URL が無い通知は用を成さない。今回の版でなければ、
# 前回公開した版のものであることを添えて出す（黙って古い URL を出さないため）。
published_url="$(cut -f2 "$LOG_DIR/last-published" 2>/dev/null || true)"
published_commit="$(cut -f1 "$LOG_DIR/last-published" 2>/dev/null || true)"
if [ -z "$published_url" ]; then
  # 受け渡しファイルがまだ無い場合は、公開ログの最後の成功行から拾う。URL は決め打ちしない。
  published_url="$(grep 'OK: 公開した' "$LOG_DIR/publish-artifact.log" 2>/dev/null | tail -1 | sed 's/.*→ //')"
  published_commit=""
fi
if [ -z "$published_url" ]; then
  published_url="（未公開。公開ログに成功の記録が無い）"
elif [ "$published_commit" != "$tick_commit" ]; then
  published_url="$published_url （公開は版 ${published_commit:-不明} のもの）"
fi

# 「前進した」と言えるのは、このプロジェクトを触るコミットが増えたときだけである。
# 単に HEAD が動いただけでは、他プロジェクトのループのコミットを取り込んだ可能性がある。
own_commits="$(git -C "$LOOP_WORKTREE" rev-list --count "$head_before..HEAD" -- "$PROJECT_NAME" 2>/dev/null || echo 0)"

# 通知でも「前進」と「レビューのみ」を書き分ける。台帳と MEMORY だけを直した tick を
# 「前進」と報告すると、止まっていることが通知から分からない（実測 2026-08-16）。
notify_substantive="$(git -C "$LOOP_WORKTREE" rev-list --count "$head_before..HEAD" -- \
  "$PROJECT_NAME/structured-latex/content" "$PROJECT_NAME/lean" "$PROJECT_NAME/sagemath" \
  2>/dev/null || echo 0)"

case "$status" in
  0)   if [ "${notify_substantive:-0}" -gt 0 ]; then
         tick_outcome="前進（${notify_substantive} コミット）"
       elif [ "${own_commits:-0}" -gt 0 ]; then
         tick_outcome="レビューのみ（本文・Lean・SageMath は増えていない）"
       else
         tick_outcome="コミットなし（何も残していない）"
       fi ;;
  124|137) tick_outcome="打ち切り（持ち時間 $(( TICK_TIMEOUT_SECONDS / 60 )) 分を超えた）" ;;
  *)   tick_outcome="異常終了 (exit $status)" ;;
esac

# **一文だけ送る**（ユーザー指示 2026-08-16）。何をしたかが一読で分かる一文と公開 URL だけ。
# 表題・エージェント名・版は書かない。前進しなかった tick も報告する（黙ると止まっていることに
# 誰も気づかない）が、そのときは「何をしなかったか」自体が伝えるべき一文になる。
case "$tick_outcome" in
  前進*) tick_line="$tick_summary" ;;
  *)     tick_line="$tick_outcome" ;;
esac

# **報告には最終ゴール・現在地・今回の一歩・次の一手の四項目を必ず入れる**
# （ユーザー指示 2026-09-05。それまでは今回の一歩だけを送っていて、人間から
# 「今どういう状況か・ゴール設定が報告に含まれていない」と指摘された）。四項目は
# 固定文ではなく、README と台帳から共通の組み立て器が毎回抽出する（正本が変われば
# 報告も変わる）。抽出に失敗したら送らずに落ちる（空欄のまま報告しない）。
if ! tick_body="$(python3 "$LOOP_WORKTREE/scripts/compose-tick-report.py" \
      "$LOOP_WORKTREE/$PROJECT_NAME" "$tick_line" 2>>"$LOG_FILE")"; then
  log "    報告本文（最終ゴール・現在地・今回の一歩・次の一手）を組み立てられなかった"
  exit 1
fi
notify_slack "$(printf '%s\n%s' "$tick_body" "$published_url")"

loop_pdf="$LOOP_WORKTREE/$PROJECT_NAME/structured-latex/build/document.pdf"
main_pdf_dir="$MAIN_REPO_DIR/$PROJECT_NAME/structured-latex/build"
if [ -f "$loop_pdf" ] && [ -d "$MAIN_REPO_DIR/$PROJECT_NAME" ]; then
  mkdir -p "$main_pdf_dir"
  cp "$loop_pdf" "$main_pdf_dir/document.pdf" \
    && log "    PDF をメイン側へ複製した（$main_pdf_dir/document.pdf）"
fi

exit "$status"
