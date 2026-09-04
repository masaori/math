#!/usr/bin/env bash
# 自動研究ループの Slack 報告本文（scripts/compose-tick-report.py）の回帰テスト。
#
# 固定したいのは次の四つ。
#  - どのプロジェクトの報告にも四項目（最終ゴール・現在地・今回の一歩・次の一手）が入ること
#  - README のゴールや進捗の正本が変わると、報告もその内容へ追従すること（固定文の複製でない）
#  - 正本の構造が壊れたとき（節や表が無い、宣言が無い）は、空欄で報告せず異常終了すること
#  - Slack へ報告する各 tick が、この組み立て器を通した本文と成果物 URL を一緒に送ること
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
COMPOSE="$REPO_DIR/scripts/compose-tick-report.py"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
failed=0
fail() { printf 'FAIL: %s\n' "$1" >&2; failed=1; }

# Slack へ報告する自動ループと、その報告を送る実装。
# 「実行待ちがなく Slack へも送らない」プロジェクト（finite-graph-ising-partition-polynomial-and-fisher-zeros）は
# 通知経路を持たないので対象外。通知を足すときはここへ 1 行足す。
NOTIFYING_PROJECTS=(
  "exact-solution-of-2d-ising-model-lambda:scripts/auto-loop-tick.sh"
  "countable-core-of-3d-ising:scripts/auto-loop-tick.sh"
  "cellular-automata-statistical-mechanics:scripts/publish-artifact.sh"
  "countable-ising-on-hyperbolic-surfaces:scripts/auto-loop-tick.sh"
)

# --- 実在するプロジェクトの正本から、四項目がそろうこと -----------------------
for entry in "${NOTIFYING_PROJECTS[@]}"; do
  project="${entry%%:*}"
  sender="$REPO_DIR/$project/${entry#*:}"
  if [ ! -f "$REPO_DIR/$project/docs/tasks/tick-report-sources.json" ]; then
    fail "$project に報告の出どころの宣言（docs/tasks/tick-report-sources.json）が無い"
    continue
  fi
  if ! out="$(python3 "$COMPOSE" "$REPO_DIR/$project" "今回の一歩の一文。" 2>&1)"; then
    fail "$project の報告を組み立てられない: $out"
    continue
  fi
  for item in 最終ゴール 現在地 今回の一歩 次の一手; do
    grep -q "^${item}: " <<<"$out" || fail "$project の報告に「${item}」が無い"
  done
  grep -q '今回の一歩の一文' <<<"$out" || fail "$project の報告に今回の一歩が入っていない"
  # 送る側が組み立て器を通し、成果物 URL を添え、失敗時は送らずに落ちること
  grep -q 'compose-tick-report.py' "$sender" || fail "$project の通知が組み立て器を通していない"
  grep -qE 'hexcomp-artifacts\.web\.app|artifact-url|\$\{?url' "$sender" \
    || fail "$project の通知に成果物 URL が無い"
done

# 双曲曲面の tick はエージェント自身が通知するので、指示文で経路を固定していることを見る
hyperbolic="$REPO_DIR/countable-ising-on-hyperbolic-surfaces/scripts/auto-loop-tick.sh"
grep -q '組み立てに失敗したら通知せず' "$hyperbolic" \
  || fail "双曲曲面の tick の指示文に、組み立て失敗時に通知しない指示が無い"

# --- 作り物の正本で、追従と fail-closed を固定する -----------------------------
setup_fixture() {   # $1: ゴール文, $2: 残作業表の先頭行の題名
  mkdir -p "$WORK/project/docs/tasks"
  {
    printf '# 見出し\n\n## ゴール\n\n'
    printf '**%s**\n\n' "$1"
    printf '続きの説明。\n'
  } > "$WORK/project/README.md"
  {
    printf '# 台帳\n\n## 現在地\n\n'
    printf '| 章 | セクション | 状態 | 備考 |\n|---|---|---|---|\n'
    printf '| Onsager 閉形式への接続 | %s | 未着手 | 円分体上で閉じる。 |\n' "$2"
    printf '| 全章 | 道具の節を移す | 未着手 | 道具は $|E|$ 件ある。 |\n'
    printf '| 臨界指数 | 先頭距離の列 | done | 済んだもの。 |\n\n'
    printf '## 前進の記録\n- 何か。\n'
  } > "$WORK/project/docs/tasks/auto-loop-state.md"
  cat > "$WORK/project/docs/tasks/tick-report-sources.json" <<'JSON'
{
  "readme": "README.md",
  "goalSection": "ゴール",
  "progress": "docs/tasks/auto-loop-state.md",
  "queueSection": "現在地",
  "doneMarkers": ["done", "完了", "済"],
  "titleColumns": [0, 1]
}
JSON
}

setup_fixture "分配多項式を可算な世界で扱い、実数への脱出を一点へ隔離する。" "ねじれた有限 Fourier 分解"
out="$(python3 "$COMPOSE" "$WORK/project" "検算を実装した。")"
grep -q '実数への脱出を一点へ隔離する' <<<"$out" || fail "README のゴールが報告へ入っていない"
grep -q '次の一手: .*ねじれた有限 Fourier 分解' <<<"$out" || fail "次の一手が表の先頭の未完了行から来ていない"
grep -q '残る作業は 2 件' <<<"$out" || fail "残作業の件数が現在地に入っていない"
# 数式中の縦棒（$|E|$）を列区切りと誤読して行を落としていないこと
grep -q '3 件のうち完了は 1 件' <<<"$out" || fail "数式中の縦棒か完了の印の数え方が壊れている"

# 正本が変われば報告も変わる（固定文の複製になっていない）
setup_fixture "零点の詰め寄りだけで相転移を述べる。" "有限体積の積公式"
out="$(python3 "$COMPOSE" "$WORK/project" "検算を実装した。")"
grep -q '零点の詰め寄りだけで相転移を述べる' <<<"$out" || fail "README を変えても報告のゴールが変わらない"
grep -q '次の一手: .*有限体積の積公式' <<<"$out" || fail "台帳を変えても次の一手が変わらない"

# 正本の構造が壊れたら、空欄で報告せず落ちる
setup_fixture "ゴール。" "先頭の作業"
printf '# 見出し\n\n本文だけでゴール節が無い。\n' > "$WORK/project/README.md"
python3 "$COMPOSE" "$WORK/project" "一歩。" >/dev/null 2>&1 \
  && fail "README にゴール節が無いのに報告を出した"

setup_fixture "ゴール。" "先頭の作業"
printf '# 台帳\n\n## 現在地\n- 表が無い。\n' > "$WORK/project/docs/tasks/auto-loop-state.md"
python3 "$COMPOSE" "$WORK/project" "一歩。" >/dev/null 2>&1 \
  && fail "台帳に残作業表が無いのに報告を出した"

setup_fixture "ゴール。" "先頭の作業"
rm "$WORK/project/docs/tasks/tick-report-sources.json"
python3 "$COMPOSE" "$WORK/project" "一歩。" >/dev/null 2>&1 \
  && fail "報告の出どころの宣言が無いのに報告を出した"

setup_fixture "ゴール。" "先頭の作業"
python3 "$COMPOSE" "$WORK/project" "   " >/dev/null 2>&1 \
  && fail "今回の一歩が空なのに報告を出した"

if [ "$failed" -eq 0 ]; then
  echo "PASS: 全通知プロジェクトの四項目・追従・fail-closed・成果物 URL"
else
  exit 1
fi
