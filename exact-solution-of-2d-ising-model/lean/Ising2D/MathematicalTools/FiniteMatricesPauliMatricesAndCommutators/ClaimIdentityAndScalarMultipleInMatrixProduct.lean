/-
# 単位行列とスカラー倍の、行列同士の積での性質（**具体版**）

対応する人手証明のラベル:
`identity_matrix_is_left_unit_of_mat_mult`, `identity_matrix_is_right_unit_of_mat_mult`,
`scalar_multiple_factors_out_of_left_factor`, `scalar_multiple_factors_out_of_right_factor`
（`structured-latex/content/002_linear_space_general.ts` の
`linear_space_general_claim_identity_matrix_is_left_unit_of_mat_mult`,
`linear_space_general_claim_identity_matrix_is_right_unit_of_mat_mult`,
`linear_space_general_claim_scalar_multiple_factors_out_of_left_factor`,
`linear_space_general_claim_scalar_multiple_factors_out_of_right_factor`）。
右の因子が数ベクトルの場合は `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` にある。

**必要十分版**: `Ising2D/NecSuf/MatrixProductIdentityAndScalar.lean`。具体版をその系として導くのは
`ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf.lean`。

## 人手証明との対応

* 4 つの主張とも、`(i, k)` 成分の鎖を人手の行の順に 1 行ずつ辿り、最後に「全ての成分が一致する」で行列の等号にする。
* 成分の式との接点は `matrix_mul_apply_sum`（`mat_mult`）と、`ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の
  `identity_matrix_apply`（`def_identity_matrix`）・`matrix_smul_apply`（`def_matrix_scalar_multiple`）・
  `kroneckerDelta_self`・`kroneckerDelta_of_ne`（`def_kronecker_delta`）である。
* 人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`mat_mult`**: `(AB)_{ik} = Σ_j A_{ij} B_{jk}`。 -/
theorem matrix_mul_apply_sum {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ)
    (i : Fin m) (k : Fin p) : (A * B) i k = ∑ j, A i j * B j k :=
  rfl

/-- **`identity_matrix_is_left_unit_of_mat_mult`** の成分の鎖: `(I A)_{ik} = A_{ik}`。 -/
theorem identity_matrix_mul_apply {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    ((1 : Matrix (Fin m) (Fin m) ℂ) * A) i k = A i k :=
  calc ((1 : Matrix (Fin m) (Fin m) ℂ) * A) i k
      = ∑ j, (1 : Matrix (Fin m) (Fin m) ℂ) i j * A j k := matrix_mul_apply_sum _ _ _ _  -- `mat_mult`
    _ = ∑ j, kroneckerDelta i j * A j k := by simp only [identity_matrix_apply]         -- `def_identity_matrix`
    _ = kroneckerDelta i i * A i k + ∑ j ∈ Finset.univ.erase i, kroneckerDelta i j * A j k :=
        (Finset.add_sum_erase _ _ (Finset.mem_univ i)).symm                            -- `j = i` の項を分ける
    _ = 1 * A i k + ∑ j ∈ Finset.univ.erase i, 0 * A j k := by
        congr 1
        · rw [kroneckerDelta_self]                                                     -- `δ` の値
        · refine Finset.sum_congr rfl fun j hj => ?_
          rw [kroneckerDelta_of_ne (Finset.ne_of_mem_erase hj).symm]                   -- `δ` の値
    _ = A i k + ∑ j ∈ Finset.univ.erase i, 0 * A j k := by rw [one_mul]               -- `1` は積の単位元
    _ = A i k + ∑ j ∈ Finset.univ.erase i, (0 : ℂ) := by simp only [zero_mul]          -- `0·z = 0` を各項へ
    _ = A i k := by rw [Finset.sum_const_zero, add_zero]                               -- `0` は加法の単位元

/-- **`identity_matrix_is_left_unit_of_mat_mult`**: `I_{Mat(m,ℂ)} A = A`。 -/
theorem identity_matrix_mul {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    (1 : Matrix (Fin m) (Fin m) ℂ) * A = A :=
  Matrix.ext (identity_matrix_mul_apply A)   -- 全ての成分が一致する

/-- **`identity_matrix_is_right_unit_of_mat_mult`** の成分の鎖: `(A I)_{ik} = A_{ik}`。 -/
theorem mul_identity_matrix_apply {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    (A * (1 : Matrix (Fin n) (Fin n) ℂ)) i k = A i k :=
  calc (A * (1 : Matrix (Fin n) (Fin n) ℂ)) i k
      = ∑ j, A i j * (1 : Matrix (Fin n) (Fin n) ℂ) j k := matrix_mul_apply_sum _ _ _ _  -- `mat_mult`
    _ = ∑ j, A i j * kroneckerDelta j k := by simp only [identity_matrix_apply]         -- `def_identity_matrix`
    _ = A i k * kroneckerDelta k k + ∑ j ∈ Finset.univ.erase k, A i j * kroneckerDelta j k :=
        (Finset.add_sum_erase _ _ (Finset.mem_univ k)).symm                            -- `j = k` の項を分ける
    _ = A i k * 1 + ∑ j ∈ Finset.univ.erase k, A i j * 0 := by
        congr 1
        · rw [kroneckerDelta_self]                                                     -- `δ` の値
        · refine Finset.sum_congr rfl fun j hj => ?_
          rw [kroneckerDelta_of_ne (Finset.ne_of_mem_erase hj)]                        -- `δ` の値
    _ = A i k + ∑ j ∈ Finset.univ.erase k, A i j * 0 := by rw [mul_one]               -- `1` は積の単位元
    _ = A i k + ∑ j ∈ Finset.univ.erase k, (0 : ℂ) := by simp only [mul_zero]          -- `z·0 = 0` を各項へ
    _ = A i k := by rw [Finset.sum_const_zero, add_zero]                               -- `0` は加法の単位元

/-- **`identity_matrix_is_right_unit_of_mat_mult`**: `A I_{Mat(n,ℂ)} = A`。 -/
theorem mul_identity_matrix {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    A * (1 : Matrix (Fin n) (Fin n) ℂ) = A :=
  Matrix.ext (mul_identity_matrix_apply A)   -- 全ての成分が一致する

/-- **`scalar_multiple_factors_out_of_left_factor`** の成分の鎖: `((aA)B)_{ik} = (a(AB))_{ik}`。 -/
theorem smul_mul_matrix_apply {m n p : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ)
    (B : Matrix (Fin n) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    ((a • A) * B) i k = (a • (A * B)) i k :=
  calc ((a • A) * B) i k
      = ∑ j, (a • A) i j * B j k := matrix_mul_apply_sum _ _ _ _    -- `mat_mult`
    _ = ∑ j, (a * A i j) * B j k := by simp only [matrix_smul_apply] -- `def_matrix_scalar_multiple`
    _ = ∑ j, a * (A i j * B j k) := by simp only [mul_assoc]        -- 積の結合律
    _ = a * ∑ j, A i j * B j k := (Finset.mul_sum _ _ _).symm       -- 分配律
    _ = a * (A * B) i k := by rw [matrix_mul_apply_sum]             -- `mat_mult`
    _ = (a • (A * B)) i k := (matrix_smul_apply _ _ _ _).symm       -- `def_matrix_scalar_multiple`

/-- **`scalar_multiple_factors_out_of_left_factor`**: `(aA)B = a(AB)`。 -/
theorem smul_mul_matrix {m n p : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ) :
    (a • A) * B = a • (A * B) :=
  Matrix.ext (smul_mul_matrix_apply a A B)   -- 全ての成分が一致する

/-- **`scalar_multiple_factors_out_of_right_factor`** の成分の鎖: `(A(aB))_{ik} = (a(AB))_{ik}`。 -/
theorem mul_smul_matrix_apply {m n p : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ)
    (B : Matrix (Fin n) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    (A * (a • B)) i k = (a • (A * B)) i k :=
  calc (A * (a • B)) i k
      = ∑ j, A i j * (a • B) j k := matrix_mul_apply_sum _ _ _ _    -- `mat_mult`
    _ = ∑ j, A i j * (a * B j k) := by simp only [matrix_smul_apply] -- `def_matrix_scalar_multiple`
    _ = ∑ j, (A i j * a) * B j k := by simp only [mul_assoc]        -- 積の結合律
    _ = ∑ j, (a * A i j) * B j k := by simp only [mul_comm _ a]     -- 積の交換律
    _ = ∑ j, a * (A i j * B j k) := by simp only [mul_assoc]        -- 積の結合律
    _ = a * ∑ j, A i j * B j k := (Finset.mul_sum _ _ _).symm       -- 分配律
    _ = a * (A * B) i k := by rw [matrix_mul_apply_sum]             -- `mat_mult`
    _ = (a • (A * B)) i k := (matrix_smul_apply _ _ _ _).symm       -- `def_matrix_scalar_multiple`

/-- **`scalar_multiple_factors_out_of_right_factor`**: `A(aB) = a(AB)`。 -/
theorem mul_smul_matrix {m n p : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ) :
    A * (a • B) = a • (A * B) :=
  Matrix.ext (mul_smul_matrix_apply a A B)   -- 全ての成分が一致する

end Ising2D
