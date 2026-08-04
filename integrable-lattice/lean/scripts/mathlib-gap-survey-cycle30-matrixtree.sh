#!/usr/bin/env bash
# cycle 30 step 2（matrix-tree 定理を自前で書くかの判断）で使った mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle30-matrixtree.sh \
#     > logs/mathlib-gap-survey-cycle30-matrixtree.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 3 つ。
#   (a) matrix-tree 定理そのもの（全域木を数える定理）が在るか。
#   (b) その標準的な証明に要る Cauchy-Binet の公式が在るか。
#   (c) 入口の素材（ラプラシアン・接続行列）は在るか。どこまで既にあるかを測る。
# 「無い」と書くならその場でログを残す、という規律のためのスクリプトである。
set -uo pipefail

cd "$(dirname "$0")/.."
ML=.lake/packages/mathlib

echo "=== 日付 ==="
date -u +%Y-%m-%dT%H:%M:%SZ
echo "=== mathlib commit ==="
git -C "$ML" rev-parse HEAD
echo "=== toolchain ==="
cat lean-toolchain

LIST=$(mktemp)
find "$ML/Mathlib" -name '*.lean' > "$LIST"
echo "=== 走査対象 Mathlib/*.lean ファイル数 ==="
wc -l < "$LIST" | tr -d ' '

concepts=(
  "(a) 全域木を数える定理|matrixTree|matrix tree"
  "(a) Kirchhoff の定理|kirchhoff|kirchhoff"
  "(a) 全域木の個数|numSpanningTrees|spanning tree"
  "(b) Cauchy-Binet の公式|CauchyBinet|cauchy binet"
  "(b) 非正方行列の積の行列式|det_mul_of_card_lt|det_mul"
  "(c) グラフのラプラシアン|lapMatrix|lapmatrix"
  "(c) 接続行列|incMatrix|incmatrix"
  "(c) 余因子・余因子行列|adjugate|adjugate"
)

for entry in "${concepts[@]}"; do
  label="${entry%%|*}"
  rest="${entry#*|}"
  joined="${rest%%|*}"
  stem="${rest#*|}"
  echo
  echo "=== $label ==="
  echo "--- (1) 連結語の内容 grep: '$joined'"
  n1=$(xargs grep -l -- "$joined" < "$LIST" 2>/dev/null | wc -l | tr -d ' ')
  echo "files=$n1"
  xargs grep -l -- "$joined" < "$LIST" 2>/dev/null | head -8
  if [ -n "$stem" ]; then
    echo "--- (2) 語幹の case-insensitive 内容 grep: '$stem'"
    n2=$(xargs grep -il -- "$stem" < "$LIST" 2>/dev/null | wc -l | tr -d ' ')
    echo "files=$n2"
    xargs grep -il -- "$stem" < "$LIST" 2>/dev/null | head -8
    echo "--- (3) 語幹の case-insensitive ファイル名検索: '$stem'"
    n3=$(find "$ML/Mathlib" -iname "*$(echo "$stem" | tr -d ' ')*" -name '*.lean' | wc -l | tr -d ' ')
    echo "files=$n3"
    find "$ML/Mathlib" -iname "*$(echo "$stem" | tr -d ' ')*" -name '*.lean' | head -8
  fi
done

# 「トレース双対は体の上にしか無い」は語の不在では示せないので、
# 実在する宣言の仮定を直接読んで確かめる（体を要求しているか）。
echo
echo "=== 既存のラプラシアンの守備範囲（何が在って何が無いかを宣言で読む） ==="
grep -nE "^(theorem|lemma|def|noncomputable def)" "$ML/Mathlib/Combinatorics/SimpleGraph/LapMatrix.lean" | head -40
echo "--- 接続行列は符号付きか（単純グラフの incMatrix の定義を読む）"
grep -n -A 4 "^def incMatrix" "$ML/Mathlib/Combinatorics/SimpleGraph/IncMatrix.lean"

# 本 step で実際に使った宣言、および入口の素材の名指し確認。
echo
echo "=== 名指しの実在確認（本 step が実際に使った宣言） ==="
decls=(
  "Matrix.transpose_apply"
  "Matrix.mul_apply"
  "Matrix.adjugate"
  "Matrix.det_fin_zero"
  "Finset.card_filter"
  "Finset.sum_comm"
  "SimpleGraph.lapMatrix"
  "SimpleGraph.incMatrix"
  "SimpleGraph.IsAcyclic"
  "SimpleGraph.IsTree"
)
for d in "${decls[@]}"; do
  base="${d##*.}"
  # 宣言行の照合。名前に ' を含む宣言があるので \b では切れない（実際に
  # `Finset.sum_range_succ'` 等が偽の MISS になった）。宣言キーワードの直後で切る。
  # 宣言は短い名前でも完全名でも書かれるので、両方を試す。
  esc=$(printf '%s' "$base" | sed "s/[.[\\*^$()+?{}|]/\\\\&/g")
  escfull=$(printf '%s' "$d" | sed "s/[.[\\*^$()+?{}|]/\\\\&/g")
  kw="^ *(@\[[^]]*\] *)?(protected |private |nonrec |noncomputable |scoped )*(theorem|lemma|def|abbrev|structure|class|instance) +"
  # 宣言行では名前空間が部分的に付くことがある（`theorem Basis.repr_sum_self` 等）ので、
  # 短い名前の前に任意の名前空間接頭辞を許す。
  hit=$(xargs grep -nE "$kw([A-Za-z_][A-Za-z0-9_.']*\.)?($esc|$escfull)( |\(|\{|\[|:|$)" < "$LIST" 2>/dev/null | head -1)
  if [ -n "$hit" ]; then
    echo "OK   $d :: $hit"
  else
    # ここに落ちるものが 2 種類ある。どちらも「無い」ではないので区別して書く。
    #   (a) Lean core / Batteries で宣言されているもの（Mathlib/ の外）。
    #   (b) `@[to_additive]` で乗法版から生成される加法版。生成物なので宣言行が存在しない
    #       （実測: Finset.sum_range_succ' は Finset.prod_range_succ' から、
    #        Fin.sum_univ_eq_sum_range は Fin.prod_univ_eq_prod_range から生成される）。
    # 文字列検査だけでは実在を否定できない範囲であり、実在の最終的な根拠はビルドが通ることである。
    echo "OUT  $d （Mathlib/*.lean に宣言行が無い。core / Batteries、または to_additive の生成物）"
  fi
done

rm -f "$LIST"
