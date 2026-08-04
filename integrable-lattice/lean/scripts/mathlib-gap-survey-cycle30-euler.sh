#!/usr/bin/env bash
# cycle 30 step 1（命題 W* の整数への降下）で使った mathlib の実在確認。
#
# 使い方:
#   cd integrable-lattice/lean && bash scripts/mathlib-gap-survey-cycle30-euler.sh \
#     > logs/mathlib-gap-survey-cycle30-euler.log
#
# 方式は scripts/mathlib-gap-survey.sh と同じ 3 段（連結語の内容 grep / 語幹の内容 grep /
# 語幹のファイル名検索）。(2)(3) がともに 0 のときにだけ「無い」と書く。
#
# 見たいのは 2 つ。
#   (a) 降下の段で実際に使う素材が在るか（在るはず。名指しで確かめる）。
#   (b) rho が可約な場合に要る素材＝可換環の上のトレース双対 / 双対基底が在るか（無いはず）。
#       ここが命題 W* の残る 1 段であり、「無い」と書くならその場でログを残す。
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
  "可約の段(無いはず) 可換環の上のトレース双対|Basis.traceDualRing|traceDual"
  "可約の段(無いはず) 可換環の上の双対基底|BilinForm.dualBasisRing|dualBasis"
  "可約の段(無いはず) Euler の双対基底公式|eulerDualBasis|euler dual basis"
  "可約の段(無いはず) Frobenius 代数|FrobeniusAlgebra|frobenius algebra"
  "可約の段(無いはず) 体の積へのトレースの分解|trace_pi|trace_prod"
  "降下の段(在るはず) minpolyDiv の係数の漸化式|coeff_minpolyDiv|minpolydiv"
  "降下の段(在るはず) 行の並べ替えと行列式|det_permute|det_permute"
  "降下の段(在るはず) 上三角行列の行列式|det_of_upperTriangular|blocktriangular"
  "降下の段(在るはず) 可逆行列の定める線形同型|Matrix.toLinearEquiv|tolinearequiv"
  "降下の段(在るはず) 適合基底（Smith 標準形）|Ideal.smithNormalForm|smith"
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
echo "=== 実在するトレース双対 / 双対基底が体を要求していることの直接確認 ==="
echo "--- Module.Basis.traceDual の宣言（RingTheory/Trace/Basic.lean）"
grep -n -B 12 "noncomputable def Module.Basis.traceDual" "$ML/Mathlib/RingTheory/Trace/Basic.lean" |
  grep -E "variable|def Module.Basis.traceDual|Field|IsSeparable" | head -12
echo "--- LinearMap.BilinForm.dualBasis の宣言"
grep -rn "def dualBasis" -B 8 "$ML/Mathlib/LinearAlgebra/BilinearForm/DualLattice.lean" \
  "$ML/Mathlib/LinearAlgebra/SesquilinearForm.lean" 2>/dev/null |
  grep -E "variable|def dualBasis|Field|DivisionRing" | head -12

# 本 step で実際に使った宣言の名指し確認
# （実在を確かめずに mathlib の補題名を書く誤りが記録され続けているため）。
echo
echo "=== 名指しの実在確認（本 step が実際に使った宣言） ==="
decls=(
  "Polynomial.coeff_minpolyDiv"
  "Polynomial.natDegree_minpolyDiv_lt"
  "Polynomial.coeff_eq_zero_of_natDegree_lt"
  "Matrix.det_permute'"
  "Matrix.det_of_upperTriangular"
  "Matrix.BlockTriangular"
  "Matrix.toLinearEquiv"
  "Matrix.toLin_mul"
  "Matrix.toLin_toMatrix"
  "Ideal.smithCoeffs"
  "Ideal.span_singleton_eq_bot"
  "Ideal.mem_span_singleton'"
  "LinearMap.mulLeft_apply"
  "isUnit_iff_exists_inv"
  "Fin.revPerm"
  "Fin.val_rev"
  "Fin.sum_univ_eq_sum_range"
  "Finset.sum_range_succ'"
  "Module.Basis.repr_sum_self"
  "PowerBasis.natDegree_minpoly"
  "PowerBasis.isIntegral_gen"
  "minpoly.natDegree_pos"
  "Algebra.smul_def"
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
