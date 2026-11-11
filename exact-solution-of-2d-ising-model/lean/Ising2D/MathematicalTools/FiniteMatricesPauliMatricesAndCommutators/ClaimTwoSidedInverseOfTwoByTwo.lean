/-
# 2×2 行列の余因子行列と、行列式が 0 でない 2×2 行列の両側逆元（**具体版**）

対応する人手証明のラベル: `def_adjugate_two_by_two`, `matrix_times_adjugate_two_by_two`,
`adjugate_times_matrix_two_by_two`, `two_sided_inverse_of_two_by_two_with_nonzero_det`
（`structured-latex/content/000_calculation_formulae_45_46.ts` の
`finite_matrix_definition_adjugate_two_by_two`, `finite_matrix_claim_matrix_times_adjugate_two_by_two`,
`finite_matrix_claim_adjugate_times_matrix_two_by_two`,
`finite_matrix_claim_two_sided_inverse_of_two_by_two_with_nonzero_det`）

**必要十分版**: `Ising2D/NecSuf/TwoByTwoAdjugateInverse.lean`。具体版をその系として導くのは
`ClaimTwoSidedInverseOfTwoByTwoFromNecSuf.lean`。

## 人手証明との対応

* 添字: Lean の `Fin 2` の `0, 1` が人手の添字 `1, 2` に当たる（`B 0 1` が人手の `B_{12}`）。
* `def_adjugate_two_by_two`: `adjTwo`。成分の `-B_{12}` は Lean の `ℂ` の符号反転で、人手の `multiply_by_minus_one` の
  `-w := (-1_ℂ) w` とは `neg_one_mul` の 1 段でつながる（準備 (a)・(b)・(c) の 1 段目）。
* `mat_mult` の 2×2 の成分 `(AB)_{ik} = A_{i1}B_{1k} + A_{i2}B_{2k}`: `mul_two_apply`（`matrix_mul_apply_sum` と 2 項の和）。
* 準備 (a) `z(-w) = -(zw)` の 5 行: `mul_neg_eq_neg_mul_complex`。(b) `(-z)w = -(zw)` の 3 行: `neg_mul_eq_neg_mul_complex`。
  (c) `(-x) + x = 0_ℂ` の 8 行: `neg_add_self_complex`（`(-1,0) + (1,0) = (-1+1, 0+0) = (0,0)` の 3 段は成分の等式）。
* `matrix_times_adjugate_two_by_two`: 4 つの成分の鎖 `mul_adjTwo_apply_00`・`_01`・`_10`・`_11`（人手の 9・9・10・11 行と
  1 段ずつの `calc`）と `mul_adjTwo`（全ての成分が一致する）。
* `adjugate_times_matrix_two_by_two`: `adjTwo_mul_apply_00`・`_01`・`_10`・`_11`（10・10・9・11 行）と `adjTwo_mul`。
* `two_sided_inverse_of_two_by_two_with_nonzero_det`: 2 本の 6 行の鎖 `mul_detInv_smul_adjTwo`・`detInv_smul_adjTwo_mul`。
  `scalar_multiple_factors_out_of_right_factor`・`..._left_factor` は具体版 `mul_smul_matrix`・`smul_mul_matrix`、
  `scalar_multiple_is_associative` は具体版が無く既存の慣行どおり mathlib の `smul_smul`、
  `multiplicative_group_of_cc` の逆元 `(det B)^{-1} det B = 1_ℂ` は `inv_mul_cancel₀`、`scalar_multiple_by_one` は `matrix_one_smul`。
* 行列式は `ClaimNonzeroKernelIffDetZeroTwoByTwo.lean` と同じく mathlib の `Matrix.det` を使い、人手の定義との接点は
  `det_two_by_two_def` の 1 か所だけである。
* 後段の Lean は逆行列を mathlib の `⁻¹`（`Matrix.nonsing_inv`）で書いている。人手の `def_invertible_elements_of_R` の
  「逆元の一意性」でそれが `h` に等しいことは `inv_eq_detInv_smul_adjTwo`（一意性の 5 行の鎖を `h_1 → B⁻¹` で書いたもの。
  mathlib との接点は `B⁻¹` が左逆元であること `Matrix.nonsing_inv_mul` の 1 段だけ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNonzeroKernelIffDetZeroTwoByTwo
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOne
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

namespace Ising2D

open Matrix

/-- **`def_adjugate_two_by_two`**: `adj B := [[B_{22}, -B_{12}], [-B_{21}, B_{11}]]`。 -/
def adjTwo (B : Matrix (Fin 2) (Fin 2) ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![B 1 1, -B 0 1; -B 1 0, B 0 0]

/-- **`mat_mult`** の 2×2 の成分: `(AB)_{ik} = A_{i1}B_{1k} + A_{i2}B_{2k}`。 -/
theorem mul_two_apply (A B : Matrix (Fin 2) (Fin 2) ℂ) (i k : Fin 2) :
    (A * B) i k = A i 0 * B 0 k + A i 1 * B 1 k := by
  rw [matrix_mul_apply_sum, Fin.sum_univ_two]

/-- 準備 (a): `z(-w) = -(zw)`。 -/
theorem mul_neg_eq_neg_mul_complex (z w : ℂ) : z * (-w) = -(z * w) :=
  calc z * (-w)
      = z * ((-1) * w) := by rw [neg_one_mul]   -- `multiply_by_minus_one`
    _ = (z * (-1)) * w := (mul_assoc _ _ _).symm  -- 積の結合律を右辺から左辺へ
    _ = ((-1) * z) * w := by rw [mul_comm z (-1)] -- 積の可換律
    _ = (-1) * (z * w) := mul_assoc _ _ _         -- 積の結合律
    _ = -(z * w) := neg_one_mul _                 -- `multiply_by_minus_one` を右辺から左辺へ

/-- 準備 (b): `(-z)w = -(zw)`。 -/
theorem neg_mul_eq_neg_mul_complex (z w : ℂ) : (-z) * w = -(z * w) :=
  calc (-z) * w
      = ((-1) * z) * w := by rw [neg_one_mul]     -- `multiply_by_minus_one`
    _ = (-1) * (z * w) := mul_assoc _ _ _         -- 積の結合律
    _ = -(z * w) := neg_one_mul _                 -- `multiply_by_minus_one` を右辺から左辺へ

/-- 準備 (c): `(-x) + x = 0_ℂ`。 -/
theorem neg_add_self_complex (x : ℂ) : (-x) + x = 0 :=
  calc (-x) + x
      = (-1) * x + x := by rw [neg_one_mul]                       -- `multiply_by_minus_one`
    _ = (-1) * x + 1 * x := by rw [one_mul]                       -- 積の単位元を右辺から左辺へ
    _ = ((-1) + 1) * x := (add_mul _ _ _).symm                    -- 右からの分配律を右辺から左辺へ
    _ = ((⟨-1, 0⟩ : ℂ) + ⟨1, 0⟩) * x := by
        congr 2 <;> apply Complex.ext <;> simp                    -- `inclusion_rr_to_cc`
    _ = (⟨-1 + 1, 0 + 0⟩ : ℂ) * x := rfl                          -- `definition_of_cc` の和
    _ = (⟨0, 0⟩ : ℂ) * x := by norm_num                           -- `ℝ` の四則
    _ = 0 * x := rfl                                              -- `inclusion_rr_to_cc`
    _ = 0 := zero_mul _                                           -- `complex_zero_times_is_zero`

/-! ## `matrix_times_adjugate_two_by_two`: `B (adj B) = (det B) I` -/

theorem mul_adjTwo_apply_00 (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (B * adjTwo B) 0 0 = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 0 :=
  calc (B * adjTwo B) 0 0
      = B 0 0 * adjTwo B 0 0 + B 0 1 * adjTwo B 1 0 := mul_two_apply _ _ _ _   -- `mat_mult`
    _ = B 0 0 * B 1 1 + B 0 1 * (-B 1 0) := rfl                                -- `def_adjugate_two_by_two`
    _ = B 0 0 * B 1 1 + (-(B 0 1 * B 1 0)) := by rw [mul_neg_eq_neg_mul_complex] -- (a)
    _ = B 0 0 * B 1 1 - B 0 1 * B 1 0 := (sub_eq_add_neg _ _).symm             -- `def_complex_difference` を右辺から左辺へ
    _ = B.det := (det_two_by_two_def B).symm                                   -- `def_det_two_by_two` を右辺から左辺へ
    _ = B.det * 1 := (mul_one _).symm                                          -- 積の単位元を右辺から左辺へ
    _ = B.det * kroneckerDelta (0 : Fin 2) 0 := by rw [kroneckerDelta_self]              -- `def_kronecker_delta` を右辺から左辺へ
    _ = B.det * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 0 := by rw [identity_matrix_apply] -- `def_identity_matrix` を右辺から左辺へ
    _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 0 := (matrix_smul_apply _ _ _ _).symm
                                                                               -- `def_matrix_scalar_multiple` を右辺から左辺へ

theorem mul_adjTwo_apply_01 (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (B * adjTwo B) 0 1 = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 1 :=
  calc (B * adjTwo B) 0 1
      = B 0 0 * adjTwo B 0 1 + B 0 1 * adjTwo B 1 1 := mul_two_apply _ _ _ _   -- `mat_mult`
    _ = B 0 0 * (-B 0 1) + B 0 1 * B 0 0 := rfl                                -- `def_adjugate_two_by_two`
    _ = (-(B 0 0 * B 0 1)) + B 0 1 * B 0 0 := by rw [mul_neg_eq_neg_mul_complex] -- (a)
    _ = (-(B 0 0 * B 0 1)) + B 0 0 * B 0 1 := by rw [mul_comm (B 0 1) (B 0 0)] -- 積の可換律
    _ = 0 := neg_add_self_complex _                                            -- (c)
    _ = B.det * 0 := (mul_zero _).symm                                         -- `complex_times_zero_is_zero` を右辺から左辺へ
    _ = B.det * kroneckerDelta (0 : Fin 2) 1 := by rw [kroneckerDelta_of_ne (by decide)] -- `def_kronecker_delta` を右辺から左辺へ
    _ = B.det * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 1 := by rw [identity_matrix_apply] -- `def_identity_matrix` を右辺から左辺へ
    _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 1 := (matrix_smul_apply _ _ _ _).symm
                                                                               -- `def_matrix_scalar_multiple` を右辺から左辺へ

theorem mul_adjTwo_apply_10 (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (B * adjTwo B) 1 0 = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 0 :=
  calc (B * adjTwo B) 1 0
      = B 1 0 * adjTwo B 0 0 + B 1 1 * adjTwo B 1 0 := mul_two_apply _ _ _ _   -- `mat_mult`
    _ = B 1 0 * B 1 1 + B 1 1 * (-B 1 0) := rfl                                -- `def_adjugate_two_by_two`
    _ = B 1 0 * B 1 1 + (-(B 1 1 * B 1 0)) := by rw [mul_neg_eq_neg_mul_complex] -- (a)
    _ = B 1 0 * B 1 1 + (-(B 1 0 * B 1 1)) := by rw [mul_comm (B 1 1) (B 1 0)] -- 積の可換律
    _ = (-(B 1 0 * B 1 1)) + B 1 0 * B 1 1 := add_comm _ _                     -- 加法の可換律
    _ = 0 := neg_add_self_complex _                                            -- (c)
    _ = B.det * 0 := (mul_zero _).symm                                         -- `complex_times_zero_is_zero` を右辺から左辺へ
    _ = B.det * kroneckerDelta (1 : Fin 2) 0 := by rw [kroneckerDelta_of_ne (by decide)] -- `def_kronecker_delta` を右辺から左辺へ
    _ = B.det * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 0 := by rw [identity_matrix_apply] -- `def_identity_matrix` を右辺から左辺へ
    _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 0 := (matrix_smul_apply _ _ _ _).symm
                                                                               -- `def_matrix_scalar_multiple` を右辺から左辺へ

theorem mul_adjTwo_apply_11 (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (B * adjTwo B) 1 1 = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 1 :=
  calc (B * adjTwo B) 1 1
      = B 1 0 * adjTwo B 0 1 + B 1 1 * adjTwo B 1 1 := mul_two_apply _ _ _ _   -- `mat_mult`
    _ = B 1 0 * (-B 0 1) + B 1 1 * B 0 0 := rfl                                -- `def_adjugate_two_by_two`
    _ = (-(B 1 0 * B 0 1)) + B 1 1 * B 0 0 := by rw [mul_neg_eq_neg_mul_complex] -- (a)
    _ = B 1 1 * B 0 0 + (-(B 1 0 * B 0 1)) := add_comm _ _                     -- 加法の可換律
    _ = B 0 0 * B 1 1 + (-(B 0 1 * B 1 0)) := by
        rw [mul_comm (B 1 1) (B 0 0), mul_comm (B 1 0) (B 0 1)]               -- 積の可換律を 2 か所へ
    _ = B 0 0 * B 1 1 - B 0 1 * B 1 0 := (sub_eq_add_neg _ _).symm             -- `def_complex_difference` を右辺から左辺へ
    _ = B.det := (det_two_by_two_def B).symm                                   -- `def_det_two_by_two` を右辺から左辺へ
    _ = B.det * 1 := (mul_one _).symm                                          -- 積の単位元を右辺から左辺へ
    _ = B.det * kroneckerDelta (1 : Fin 2) 1 := by rw [kroneckerDelta_self]              -- `def_kronecker_delta` を右辺から左辺へ
    _ = B.det * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 1 := by rw [identity_matrix_apply] -- `def_identity_matrix` を右辺から左辺へ
    _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 1 := (matrix_smul_apply _ _ _ _).symm
                                                                               -- `def_matrix_scalar_multiple` を右辺から左辺へ

/-- **`matrix_times_adjugate_two_by_two`**: `B (adj B) = (det B) I`。 -/
theorem mul_adjTwo (B : Matrix (Fin 2) (Fin 2) ℂ) :
    B * adjTwo B = B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  ext i k   -- 4 つの成分が一致する
  fin_cases i <;> fin_cases k
  · exact mul_adjTwo_apply_00 B
  · exact mul_adjTwo_apply_01 B
  · exact mul_adjTwo_apply_10 B
  · exact mul_adjTwo_apply_11 B

/-! ## `adjugate_times_matrix_two_by_two`: `(adj B) B = (det B) I` -/

theorem adjTwo_mul_apply_00 (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (adjTwo B * B) 0 0 = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 0 :=
  calc (adjTwo B * B) 0 0
      = adjTwo B 0 0 * B 0 0 + adjTwo B 0 1 * B 1 0 := mul_two_apply _ _ _ _   -- `mat_mult`
    _ = B 1 1 * B 0 0 + (-B 0 1) * B 1 0 := rfl                                -- `def_adjugate_two_by_two`
    _ = B 1 1 * B 0 0 + (-(B 0 1 * B 1 0)) := by rw [neg_mul_eq_neg_mul_complex] -- (b)
    _ = B 0 0 * B 1 1 + (-(B 0 1 * B 1 0)) := by rw [mul_comm (B 1 1) (B 0 0)] -- 積の可換律
    _ = B 0 0 * B 1 1 - B 0 1 * B 1 0 := (sub_eq_add_neg _ _).symm             -- `def_complex_difference` を右辺から左辺へ
    _ = B.det := (det_two_by_two_def B).symm                                   -- `def_det_two_by_two` を右辺から左辺へ
    _ = B.det * 1 := (mul_one _).symm                                          -- 積の単位元を右辺から左辺へ
    _ = B.det * kroneckerDelta (0 : Fin 2) 0 := by rw [kroneckerDelta_self]              -- `def_kronecker_delta` を右辺から左辺へ
    _ = B.det * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 0 := by rw [identity_matrix_apply] -- `def_identity_matrix` を右辺から左辺へ
    _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 0 := (matrix_smul_apply _ _ _ _).symm
                                                                               -- `def_matrix_scalar_multiple` を右辺から左辺へ

theorem adjTwo_mul_apply_01 (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (adjTwo B * B) 0 1 = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 1 :=
  calc (adjTwo B * B) 0 1
      = adjTwo B 0 0 * B 0 1 + adjTwo B 0 1 * B 1 1 := mul_two_apply _ _ _ _   -- `mat_mult`
    _ = B 1 1 * B 0 1 + (-B 0 1) * B 1 1 := rfl                                -- `def_adjugate_two_by_two`
    _ = B 1 1 * B 0 1 + (-(B 0 1 * B 1 1)) := by rw [neg_mul_eq_neg_mul_complex] -- (b)
    _ = B 1 1 * B 0 1 + (-(B 1 1 * B 0 1)) := by rw [mul_comm (B 0 1) (B 1 1)] -- 積の可換律
    _ = (-(B 1 1 * B 0 1)) + B 1 1 * B 0 1 := add_comm _ _                     -- 加法の可換律
    _ = 0 := neg_add_self_complex _                                            -- (c)
    _ = B.det * 0 := (mul_zero _).symm                                         -- `complex_times_zero_is_zero` を右辺から左辺へ
    _ = B.det * kroneckerDelta (0 : Fin 2) 1 := by rw [kroneckerDelta_of_ne (by decide)] -- `def_kronecker_delta` を右辺から左辺へ
    _ = B.det * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 1 := by rw [identity_matrix_apply] -- `def_identity_matrix` を右辺から左辺へ
    _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 1 := (matrix_smul_apply _ _ _ _).symm
                                                                               -- `def_matrix_scalar_multiple` を右辺から左辺へ

theorem adjTwo_mul_apply_10 (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (adjTwo B * B) 1 0 = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 0 :=
  calc (adjTwo B * B) 1 0
      = adjTwo B 1 0 * B 0 0 + adjTwo B 1 1 * B 1 0 := mul_two_apply _ _ _ _   -- `mat_mult`
    _ = (-B 1 0) * B 0 0 + B 0 0 * B 1 0 := rfl                                -- `def_adjugate_two_by_two`
    _ = (-(B 1 0 * B 0 0)) + B 0 0 * B 1 0 := by rw [neg_mul_eq_neg_mul_complex] -- (b)
    _ = (-(B 1 0 * B 0 0)) + B 1 0 * B 0 0 := by rw [mul_comm (B 0 0) (B 1 0)] -- 積の可換律
    _ = 0 := neg_add_self_complex _                                            -- (c)
    _ = B.det * 0 := (mul_zero _).symm                                         -- `complex_times_zero_is_zero` を右辺から左辺へ
    _ = B.det * kroneckerDelta (1 : Fin 2) 0 := by rw [kroneckerDelta_of_ne (by decide)] -- `def_kronecker_delta` を右辺から左辺へ
    _ = B.det * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 0 := by rw [identity_matrix_apply] -- `def_identity_matrix` を右辺から左辺へ
    _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 0 := (matrix_smul_apply _ _ _ _).symm
                                                                               -- `def_matrix_scalar_multiple` を右辺から左辺へ

theorem adjTwo_mul_apply_11 (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (adjTwo B * B) 1 1 = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 1 :=
  calc (adjTwo B * B) 1 1
      = adjTwo B 1 0 * B 0 1 + adjTwo B 1 1 * B 1 1 := mul_two_apply _ _ _ _   -- `mat_mult`
    _ = (-B 1 0) * B 0 1 + B 0 0 * B 1 1 := rfl                                -- `def_adjugate_two_by_two`
    _ = (-(B 1 0 * B 0 1)) + B 0 0 * B 1 1 := by rw [neg_mul_eq_neg_mul_complex] -- (b)
    _ = B 0 0 * B 1 1 + (-(B 1 0 * B 0 1)) := add_comm _ _                     -- 加法の可換律
    _ = B 0 0 * B 1 1 + (-(B 0 1 * B 1 0)) := by rw [mul_comm (B 1 0) (B 0 1)] -- 積の可換律
    _ = B 0 0 * B 1 1 - B 0 1 * B 1 0 := (sub_eq_add_neg _ _).symm             -- `def_complex_difference` を右辺から左辺へ
    _ = B.det := (det_two_by_two_def B).symm                                   -- `def_det_two_by_two` を右辺から左辺へ
    _ = B.det * 1 := (mul_one _).symm                                          -- 積の単位元を右辺から左辺へ
    _ = B.det * kroneckerDelta (1 : Fin 2) 1 := by rw [kroneckerDelta_self]              -- `def_kronecker_delta` を右辺から左辺へ
    _ = B.det * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 1 := by rw [identity_matrix_apply] -- `def_identity_matrix` を右辺から左辺へ
    _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 1 := (matrix_smul_apply _ _ _ _).symm
                                                                               -- `def_matrix_scalar_multiple` を右辺から左辺へ

/-- **`adjugate_times_matrix_two_by_two`**: `(adj B) B = (det B) I`。 -/
theorem adjTwo_mul (B : Matrix (Fin 2) (Fin 2) ℂ) :
    adjTwo B * B = B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  ext i k   -- 4 つの成分が一致する
  fin_cases i <;> fin_cases k
  · exact adjTwo_mul_apply_00 B
  · exact adjTwo_mul_apply_01 B
  · exact adjTwo_mul_apply_10 B
  · exact adjTwo_mul_apply_11 B

/-! ## `two_sided_inverse_of_two_by_two_with_nonzero_det` -/

/-- **`two_sided_inverse_of_two_by_two_with_nonzero_det`** の右側: `B h = I`（`h := (det B)^{-1} adj B`）。 -/
theorem mul_detInv_smul_adjTwo (B : Matrix (Fin 2) (Fin 2) ℂ) (hB : B.det ≠ 0) :
    B * (B.det⁻¹ • adjTwo B) = 1 :=
  calc B * (B.det⁻¹ • adjTwo B)
      = B.det⁻¹ • (B * adjTwo B) := mul_smul_matrix _ _ _
          -- `scalar_multiple_factors_out_of_right_factor`
    _ = B.det⁻¹ • (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) := by rw [mul_adjTwo]
          -- `matrix_times_adjugate_two_by_two`
    _ = (B.det⁻¹ * B.det) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := smul_smul _ _ _
          -- `scalar_multiple_is_associative`
    _ = (1 : ℂ) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by rw [inv_mul_cancel₀ hB]
          -- `multiplicative_group_of_cc` の逆元（`det B ∈ ℂ^×`）
    _ = 1 := matrix_one_smul _
          -- `scalar_multiple_by_one`

/-- **`two_sided_inverse_of_two_by_two_with_nonzero_det`** の左側: `h B = I`。 -/
theorem detInv_smul_adjTwo_mul (B : Matrix (Fin 2) (Fin 2) ℂ) (hB : B.det ≠ 0) :
    (B.det⁻¹ • adjTwo B) * B = 1 :=
  calc (B.det⁻¹ • adjTwo B) * B
      = B.det⁻¹ • (adjTwo B * B) := smul_mul_matrix _ _ _
          -- `scalar_multiple_factors_out_of_left_factor`
    _ = B.det⁻¹ • (B.det • (1 : Matrix (Fin 2) (Fin 2) ℂ)) := by rw [adjTwo_mul]
          -- `adjugate_times_matrix_two_by_two`
    _ = (B.det⁻¹ * B.det) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := smul_smul _ _ _
          -- `scalar_multiple_is_associative`
    _ = (1 : ℂ) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by rw [inv_mul_cancel₀ hB]
          -- `multiplicative_group_of_cc` の逆元（`det B ∈ ℂ^×`）
    _ = 1 := matrix_one_smul _
          -- `scalar_multiple_by_one`

/-- **`two_sided_inverse_of_two_by_two_with_nonzero_det`**: `h := (det B)^{-1} adj B` は `B h = I` かつ `h B = I`。 -/
theorem two_sided_inverse_of_two_by_two (B : Matrix (Fin 2) (Fin 2) ℂ) (hB : B.det ≠ 0) :
    B * (B.det⁻¹ • adjTwo B) = 1 ∧ (B.det⁻¹ • adjTwo B) * B = 1 :=
  ⟨mul_detInv_smul_adjTwo B hB, detInv_smul_adjTwo_mul B hB⟩

/-- `def_invertible_elements_of_R`（`M → 1`）の逆元の一意性の鎖 `h_1 = h_1 I = h_1(B h_2) = (h_1 B) h_2 = I h_2 = h_2` を
`h_1 → B⁻¹`（mathlib の逆行列）、`h_2 → (det B)^{-1} adj B` で書いたもの。mathlib との接点は `B⁻¹ B = I`
（`Matrix.nonsing_inv_mul`）の 1 段だけである。 -/
theorem inv_eq_detInv_smul_adjTwo (B : Matrix (Fin 2) (Fin 2) ℂ) (hB : B.det ≠ 0) :
    B⁻¹ = B.det⁻¹ • adjTwo B :=
  calc B⁻¹
      = B⁻¹ * 1 := (mul_identity_matrix _).symm
          -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = B⁻¹ * (B * (B.det⁻¹ • adjTwo B)) := by rw [mul_detInv_smul_adjTwo B hB]
          -- `B h_2 = I`（`two_sided_inverse_of_two_by_two_with_nonzero_det`）
    _ = (B⁻¹ * B) * (B.det⁻¹ • adjTwo B) := (Matrix.mul_assoc _ _ _).symm
          -- `mat_mult_associative`（既存の慣行どおり mathlib の `Matrix.mul_assoc`）
    _ = 1 * (B.det⁻¹ • adjTwo B) := by rw [Matrix.nonsing_inv_mul B (isUnit_iff_ne_zero.2 hB)]
          -- `h_1 B = I`（mathlib の逆行列が左逆元であること）
    _ = B.det⁻¹ • adjTwo B := identity_matrix_mul _
          -- `identity_matrix_is_left_unit_of_mat_mult`

end Ising2D
