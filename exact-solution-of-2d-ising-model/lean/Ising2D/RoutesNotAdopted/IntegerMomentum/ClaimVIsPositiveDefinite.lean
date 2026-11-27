/-
# `V` の正定値性と `tr(V) > 0`（**具体版**。整数運動量の経路の形式化の記録）

対応する人手証明のラベル: `V_is_positive_definite`
（`structured-latex/notes/integer_momentum_route_not_adopted.ts` の
`note_evenEigen_008_claim_V_plus_is_positive_definite_integer_route_eigenvalues_of_V_015_claim_V_is_positive_definite`。
本文から参照用ノートへ退避した整数運動量の経路の主張で、この Lean は形式化の記録として残す）。

`Vmat` は `V := (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`、`Vmat_posDef` は Step 3、`trace_Vmat_pos` は Step 5 である。
使う補題（エルミート行列の `exp` が正定値 `posDef_exp_of_isHermitian`、`S_1`・`S_2` のエルミート性 `S1_isHermitian`・
`S2_isHermitian_by_anticommutation`）は `MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPositiveDefinite.lean` にある。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveDefinite

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-! ## `V` の正定値性（原文 `V_is_positive_definite`） -/

section Vpos

variable {M : ℕ}

/-- **原文 `V_is_positive_definite` の `V := (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`**。 -/
noncomputable def Vmat (M : ℕ) (K1 η : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  V1pmHalf M K1 η * V2H2Form M s2 K2star * V1pmHalf M K1 η

/-- **原文 `V_is_positive_definite` Step 3**: `V` は正定値。 -/
theorem Vmat_posDef {K1 η K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hη : star η = η)
    (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (Vmat M K1 η s2 K2star).PosDef := by
  have hS1 : (((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)).IsHermitian := by
    have : ((((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)))ᴴ
        = ((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η) := by
      rw [Matrix.conjTranspose_smul, (S1_isHermitian hK1 hη).eq]
      norm_num
    exact this
  have hB : (V1pmHalf M K1 η).IsHermitian := by
    have hEq : V1pmHalf M K1 η = NormedSpace.exp (((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)) := by
      rw [V1pmHalf, matExp, smul_smul, mul_assoc]
    rw [hEq]
    -- `exp_hermitian_is_positive_definite`（`S → ½(iK_1H)`）で正定値、`def_hermitian_positive_definite` よりとくにエルミート
    exact (posDef_exp_of_isHermitian hS1).1
  have hA : (NormedSpace.exp ((Complex.I * K2star) • H2 M)).PosDef :=
    have h := posDef_exp_of_isHermitian (S2_isHermitian_by_anticommutation hK2)
    posDef_of_conjBilin'_pos h.1 h.2
  have hinj : Function.Injective (V1pmHalf M K1 η).mulVec := by
    have hEq : V1pmHalf M K1 η = NormedSpace.exp (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η) := rfl
    rw [hEq]
    exact Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  have hBAB : ((V1pmHalf M K1 η)ᴴ * NormedSpace.exp ((Complex.I * K2star) • H2 M)
      * V1pmHalf M K1 η).PosDef := hA.conjTranspose_mul_mul_same hinj
  rw [hB.eq] at hBAB
  have hV : Vmat M K1 η s2 K2star
      = (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ)) : ℂ))
        • (V1pmHalf M K1 η * NormedSpace.exp ((Complex.I * K2star) • H2 M) * V1pmHalf M K1 η) := by
    rw [Vmat, V2H2Form, matExp]
    rw [Matrix.mul_smul, Matrix.smul_mul]
  rw [hV]
  refine positive_real_multiple_preserves_positive_definite_of_necSuf' hBAB ?_
  have : (0 : ℝ) < 2 * s2 := by linarith
  exact Real.rpow_pos_of_pos this _

/-- **原文 `V_is_positive_definite` Step 5**: `tr(V) > 0`。 -/
theorem trace_Vmat_pos {K1 η K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hη : star η = η)
    (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (Vmat M K1 η s2 K2star).trace :=
  (Vmat_posDef hK1 hη hK2 hs2).trace_pos

end Vpos

end Ising2D
