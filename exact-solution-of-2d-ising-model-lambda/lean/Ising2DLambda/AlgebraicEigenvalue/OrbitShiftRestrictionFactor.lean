/-
章「固有値の代数性」の「軌道の元の個数が 2 以上のとき、巡回シフトの制限の因子は
単位元の加法についての逆元である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_shift_restriction_factor`）に対応する。

  人手証明                                              このファイル
  準備の第二（ι(κ(-1)) = ι(-κ(1)) = u）                 constSecond_neg_one
  準備の第三（τ ∈ O ⇒ ch(U)_{τ,S(τ)} = u）              charMatrix_shiftMatrix_shift_entry
  準備の第四（u * u = ι(κ(1)) は単位元）                 具体版では (-1)·(-1) = 1（`norm_num`）
  主張（|O| ≥ 2 ⇒ W_O(ch(U),S↾_O) = ι(-κ(1))）          orbitFactor_shiftMatrix_shift_of_two_le

`S↾_O` は `orbitFactor` の引数の持ち方に合わせて ambient の写像 `rowShift L` として渡す
（`shiftOrbitRestriction_val` がこの 2 つの値の一致である）。これは人手証明の
`S↾_O ∈ 𝔅_O` に対応する。

mathlib の `Matrix.charpoly` や置換行列の既製定理は引いていない。使ったのは既に示した
`shiftOrbitRestriction_sign`・`rowShift_eq_self_iff_card_orbit_eq_one` と、
有限積の基本則（`Finset.prod_congr`・`Finset.prod_const`）および冪の指数法則だけである。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（成分は `Polynomial (Polynomial ℤ)`、添字は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitShiftRestrictionSign
import Ising2DLambda.AlgebraicEigenvalue.OrbitIdentityFactor
import Ising2DLambda.AlgebraicEigenvalue.OrbitFixedIffCardOne

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の準備の第二。`ι(-κ(1))` は `ℤ[x][t]` の単位元の加法についての逆元である。 -/
theorem constSecond_neg_one :
    constSecond (-(constPoly 1)) = (-1 : SecondPoly) := by
  simp [constSecond, constPoly]

/-- 人手証明の準備の第三。`|O| ≥ 2` のとき `τ ∈ O` について `ch(U)_{τ,S(τ)} = ι(-κ(1))`。

`|O| ≠ 1` から `S(τ) ≠ τ` を出し（同値の対偶）、特性行列の非対角の場合を経て
`U_{τ,S(τ)} = κ(1)` を代入する。 -/
theorem charMatrix_shiftMatrix_shift_entry {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hmem : τ ∈ O) (hcard : 2 ≤ O.card) :
    charMatrix L (shiftMatrix L) τ (rowShift L τ) = (-1 : SecondPoly) := by
  classical
  have hne : rowShift L τ ≠ τ := by
    intro hfix
    have : O.card = 1 := (rowShift_eq_self_iff_card_orbit_eq_one hO hmem).mp hfix
    omega
  have hoff : ¬(τ = rowShift L τ) := fun h => hne h.symm
  calc charMatrix L (shiftMatrix L) τ (rowShift L τ)
      = constSecond (-(shiftMatrix L τ (rowShift L τ))) := by
        simp only [charMatrix]; rw [if_neg hoff]
    _ = constSecond (-(constPoly 1)) := by
        simp [shiftMatrix]
    _ = (-1 : SecondPoly) := constSecond_neg_one

/-- 人手証明の主張「`|O| ≥ 2` ならば `W_O(ch(U), S↾_O) = ι(-κ(1))`」。

人手証明の鎖をそのまま辿る（符号を代入 → 成分を `u` へ書き換え → 積を冪へ畳む →
指数を足す → `u·u = 1` で落とす）。 -/
theorem orbitFactor_shiftMatrix_shift_of_two_le {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hcard : 2 ≤ O.card) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O (rowShift L)
      = constSecond (-(constPoly 1)) := by
  classical
  -- 重み（符号の側）。ι(κ((-1)^{|O|-1})) = (-1)^{|O|-1}。
  have hweight : constSecond (constPoly (orbitPermSign L O (rowShift L)))
      = (-1 : SecondPoly) ^ (O.card - 1) := by
    rw [shiftOrbitRestriction_sign hO]
    simp [constSecond, constPoly]
  -- 成分の側。台の上で因子はすべて -1 である。
  have hprod : ∏ τ ∈ O, charMatrix L (shiftMatrix L) τ (rowShift L τ)
      = (-1 : SecondPoly) ^ O.card := by
    rw [Finset.prod_congr rfl (fun τ hmem =>
      charMatrix_shiftMatrix_shift_entry hO hmem hcard), Finset.prod_const]
  have hexp : (O.card - 1) + O.card = 2 * (O.card - 1) + 1 := by omega
  calc orbitFactor L (charMatrix L (shiftMatrix L)) O (rowShift L)
      = constSecond (constPoly (orbitPermSign L O (rowShift L)))
          * ∏ τ ∈ O, charMatrix L (shiftMatrix L) τ (rowShift L τ) := rfl
    _ = (-1 : SecondPoly) ^ (O.card - 1) * (-1 : SecondPoly) ^ O.card := by
        rw [hweight, hprod]
    _ = (-1 : SecondPoly) ^ ((O.card - 1) + O.card) := (pow_add _ _ _).symm
    _ = (-1 : SecondPoly) ^ (2 * (O.card - 1) + 1) := by rw [hexp]
    _ = ((-1 : SecondPoly) * (-1 : SecondPoly)) ^ (O.card - 1) * (-1 : SecondPoly) := by
        rw [pow_succ, pow_mul, sq]
    _ = (-1 : SecondPoly) := by norm_num
    _ = constSecond (-(constPoly 1)) := constSecond_neg_one.symm

end Ising2DLambda.AlgebraicEigenvalue
