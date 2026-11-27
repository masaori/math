/-
# `(V^{(+)})^{-1}` は正定値で、`tr((V^{(+)})^{-1}) > 0`（**具体版**。どの章のゴールの主張からも使われない主張の形式化の記録）

対応する人手証明のラベル: `V_plus_inverse_is_positive_definite`、`V_plus_inverse_positive_and_trace_positivity`
（`structured-latex/notes/claims_unused_by_chapter_goals_not_adopted.ts` の
`note_evenEigen_claim_V_plus_inverse_is_positive_definite_unused_by_chapter_goals`・
`note_evenEigen_claim_V_plus_inverse_positive_and_traces_unused_by_chapter_goals`。
本文から参照用ノートへ退避した主張で、この Lean は形式化の記録として残す）。

`(V^{(+)})^{-1}` の明示形 `VPlusInv` と、それが `V^{(+)}` の逆であること（本文 `V_plus_is_invertible`）は
`EigenvalueProblem/EigenvaluesOfVPlus/ClaimVPlusPositiveDefinite.lean` にある。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusPositiveDefinite

namespace Ising2D

open Matrix
open scoped ComplexOrder

section VPlusInverse

variable {M : ℕ}

/-- **原文 `V_plus_inverse_is_positive_definite`**:
`(V^{(+)})^{-1}` も正定値。

証明は Step 2〜3 をそのまま `-\tfrac12 S_1^{(+)}`, `-S_2` に適用するだけである。 -/
theorem VPlusInv_posDef {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (VPlusInv M K1 s2 K2star).PosDef := by
  set E := matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) with hE
  set B := matExp (-((Complex.I * K2star) • H2 M)) with hB
  -- `-\tfrac12 S_1^{(+)}` はエルミート
  have hS1 : (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1plus M))).IsHermitian := by
    have h : (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1plus M)))ᴴ
        = -(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1plus M)) := by
      rw [Matrix.conjTranspose_neg, Matrix.conjTranspose_smul,
        (S1plus_isHermitian hK1).eq]
      norm_num
    exact h
  have hEeq : E = NormedSpace.exp (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1plus M))) := by
    rw [hE, matExp]
  have hEherm : E.IsHermitian := by
    rw [hEeq]
    -- `exp_hermitian_is_positive_definite`（`S → -½S_1^{(+)}`）で正定値、`def_hermitian_positive_definite` よりとくにエルミート
    exact (posDef_exp_of_isHermitian hS1).isHermitian
  have hEinj : Function.Injective E.mulVec := by
    rw [hEeq]
    exact Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  -- `-S_2` はエルミートなので `exp(-S_2)` は正定値
  have hS2 : (-((Complex.I * K2star) • H2 M)).IsHermitian := by
    have h : (-((Complex.I * K2star) • H2 M))ᴴ = -((Complex.I * K2star) • H2 M) := by
      rw [Matrix.conjTranspose_neg, (S2_isHermitian hK2).eq]
    exact h
  have hBpos : B.PosDef := by
    rw [hB, matExp]
    exact posDef_exp_of_isHermitian hS2
  have hEBE : (Eᴴ * B * E).PosDef := hBpos.conjTranspose_mul_mul_same hEinj
  rw [hEherm.eq] at hEBE
  rw [VPlusInv]
  refine positive_real_multiple_preserves_positive_definite_tensorPow hEBE ?_
  have : (0 : ℝ) < 2 * s2 := by linarith
  exact inv_pos.mpr (Real.rpow_pos_of_pos this _)

/-- **原文 `V_plus_inverse_positive_and_trace_positivity`**:
`tr((V^{(+)})^{-1}) > 0`。 -/
theorem trace_VPlusInv_pos {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (VPlusInv M K1 s2 K2star).trace :=
  (VPlusInv_posDef hK1 hK2 hs2).trace_pos

end VPlusInverse

end Ising2D
