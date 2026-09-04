#!/usr/bin/env bash
# 報告本文の組み立て（scripts/compose-tick-report.py）の回帰テスト。
#
# 固定したいのは次の四つ。
#  - 報告に四項目（最終ゴール・現在地・今回の一歩・次の一手）が必ず入ること
#  - README のゴールや台帳の残作業表が変わると、報告もその内容へ追従すること
#  - 正本の構造が壊れたとき（節や表が無い）は、空欄で報告せず異常終了すること
#  - tick スクリプトが四項目の本文と公開 URL を一緒に送り続けること
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
COMPOSE="$PROJECT_DIR/scripts/compose-tick-report.py"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
failed=0

fail() { printf 'FAIL: %s\n' "$1" >&2; failed=1; }

make_readme() {
  local goal="${1:-分配多項式を可算な世界で扱い、実数への脱出を一点へ隔離する。}"
  {
    printf '# 見出し\n\n## ゴール\n\n'
    printf '**%s**\n\n' "$goal"
    printf '続きの説明。\n'
  } > "$WORK/README.md"
}

make_state() {
  cat > "$WORK/state.md" <<'MD'
# 台帳

## 現在地
- 直前の tick で何かをした。

**残っているもの**

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| Onsager 閉形式への接続 | ねじれた有限 Fourier 分解 | 未着手 | 円分体上で閉じる。 |
| 全章 | 道具の節を移す | 未着手 | 道具は $|E|$ 件ある。 |
| 臨界指数 | 先頭距離の列 | 保留 | 命題候補が立つまで待つ。 |

## 前進の記録
- 何か。
MD
}

# 四項目がそろう
make_readme
make_state
out="$(python3 "$COMPOSE" "$WORK/README.md" "$WORK/state.md" "検算を実装した。")"
for item in 最終ゴール 現在地 今回の一歩 次の一手; do
  grep -q "^${item}: " <<<"$out" || fail "報告に「${item}」が無い"
done
grep -q '実数への脱出を一点へ隔離する' <<<"$out" || fail "README のゴールが報告へ入っていない"
grep -q '検算を実装した' <<<"$out" || fail "今回の一歩が報告へ入っていない"
grep -q 'ねじれた有限 Fourier 分解' <<<"$out" || fail "次の一手が台帳の先頭行から来ていない"
grep -q '残る作業は 3 件' <<<"$out" || fail "残作業の件数が現在地に入っていない"
# 数式に含まれる縦棒（$|E|$）を列区切りと誤読して行を落としていないこと
grep -q '未着手 2 件' <<<"$out" || fail "数式中の縦棒で残作業の数え方が壊れている"

# README のゴールを変えると報告が追従する（固定文の写しになっていない）
make_readme "零点の詰め寄りだけで相転移を述べる。"
out="$(python3 "$COMPOSE" "$WORK/README.md" "$WORK/state.md" "検算を実装した。")"
grep -q '零点の詰め寄りだけで相転移を述べる' <<<"$out" || fail "README を変えても報告のゴールが変わらない"

# 台帳の残作業表を並べ替えると次の一手が追従する
make_readme
python3 - "$WORK/state.md" <<'PY'
import sys
path = sys.argv[1]
text = open(path, encoding="utf-8").read()
head, body = text.split("|---|---|---|---|\n", 1)
lines = body.splitlines()
open(path, "w", encoding="utf-8").write(
    head + "|---|---|---|---|\n" + "\n".join([lines[1], lines[0]] + lines[2:]) + "\n"
)
PY
out="$(python3 "$COMPOSE" "$WORK/README.md" "$WORK/state.md" "検算を実装した。")"
grep -q '次の一手: .*道具の節を移す' <<<"$out" || fail "台帳を並べ替えても次の一手が変わらない"

# 正本の構造が壊れていたら、空欄で報告せず落ちる
make_state
printf '# 見出し\n\n本文だけでゴール節が無い。\n' > "$WORK/README.md"
if python3 "$COMPOSE" "$WORK/README.md" "$WORK/state.md" "検算を実装した。" >/dev/null 2>&1; then
  fail "README にゴール節が無いのに報告を出した"
fi
make_readme
printf '# 台帳\n\n## 現在地\n- 表が無い。\n' > "$WORK/state.md"
if python3 "$COMPOSE" "$WORK/README.md" "$WORK/state.md" "検算を実装した。" >/dev/null 2>&1; then
  fail "台帳に残作業表が無いのに報告を出した"
fi
make_state
if python3 "$COMPOSE" "$WORK/README.md" "$WORK/state.md" "   " >/dev/null 2>&1; then
  fail "今回の一歩が空なのに報告を出した"
fi

# tick スクリプトが四項目の本文と公開 URL を一緒に送り、組み立てに失敗したら送らずに落ちること
tick="$PROJECT_DIR/scripts/auto-loop-tick.sh"
grep -q 'compose-tick-report.py' "$tick" || fail "tick スクリプトが報告本文の組み立てを呼んでいない"
grep -q 'tick_message=.*tick_body.*published_url' "$tick" \
  || fail "tick スクリプトが四項目の本文と公開 URL を一緒に送っていない"
grep -q '報告本文（最終ゴール・現在地・今回の一歩・次の一手）を組み立てられなかった' "$tick" \
  || fail "tick スクリプトが組み立て失敗時に落ちる経路を持っていない"

if [ "$failed" -eq 0 ]; then
  echo "PASS: 報告本文の四項目・追従・fail-closed・URL 維持"
else
  exit 1
fi
