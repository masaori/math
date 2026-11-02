/-
# 因子の符号反転は行列の積の外へ出る（**具体版**）

対応する人手証明のラベル: `negation_factors_out_of_left_factor`, `negation_factors_out_of_right_factor`
（`structured-latex/content/002_linear_space_general.ts` の
`linear_space_general_claim_negation_factors_out_of_left_factor`,
`linear_space_general_claim_negation_factors_out_of_right_factor`）。

**必要十分版**: `Ising2D/NecSuf/NegMatrixProduct.lean`。具体版をその系として導くのは
`ClaimNegationFactorsOutOfMatrixProductFromNecSuf.lean`。

## 人手証明との対応

* 2 つの主張とも、`(i, k)` 成分の鎖を人手の行の順に 1 行ずつ辿り、最後に「全ての成分が一致する」で行列の等号にする。
* 成分の式との接点は `ClaimIdentityAndScalarMultipleInMatrixProduct.lean` の `matrix_mul_apply_sum`（`mat_mult`）と、
  `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `matrix_neg_apply`（`def_matrix_negation`）である。
* 人手の `-z := (-1_ℂ)·z`（`multiply_by_minus_one`）は、Lean の `ℂ` の符号反転が積で定義されていないので `neg_one_mul` で出す。
  `ℂ` の積の結合律・交換律は `mul_assoc`・`mul_comm`、「分配律を有限和の項の数だけ繰り返す」は `Finset.mul_sum` で出す
  （`complex_numbers_form_a_field`）。
* 人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct

namespace Ising2D

open Matrix

/-- **`negation_factors_out_of_left_factor`** の成分の鎖: `((-A)B)_{ik} = (-(AB))_{ik}`。 -/
theorem neg_mul_matrix_apply {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ)
    (B : Matrix (Fin n) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    ((-A) * B) i k = (-(A * B)) i k :=
  calc ((-A) * B) i k
      = ∑ j, (-A) i j * B j k := matrix_mul_apply_sum _ _ _ _                -- `mat_mult`
    _ = ∑ j, (-A i j) * B j k := by simp only [matrix_neg_apply]              -- `def_matrix_negation`
    _ = ∑ j, ((-1) * A i j) * B j k :=
        Finset.sum_congr rfl fun j _ => by rw [neg_one_mul]                   -- `multiply_by_minus_one`
    _ = ∑ j, (-1) * (A i j * B j k) := by simp only [mul_assoc]               -- 積の結合律
    _ = (-1) * ∑ j, A i j * B j k := (Finset.mul_sum _ _ _).symm              -- 分配律
    _ = (-1) * (A * B) i k := by rw [matrix_mul_apply_sum]                    -- `mat_mult`
    _ = -(A * B) i k := neg_one_mul _                                         -- `multiply_by_minus_one`
    _ = (-(A * B)) i k := (matrix_neg_apply _ _ _).symm                       -- `def_matrix_negation`

/-- **`negation_factors_out_of_left_factor`**: `(-A)B = -(AB)`。 -/
theorem neg_mul_matrix {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ) :
    (-A) * B = -(A * B) :=
  Matrix.ext (neg_mul_matrix_apply A B)   -- 全ての成分が一致する

/-- **`negation_factors_out_of_right_factor`** の成分の鎖: `(A(-B))_{ik} = (-(AB))_{ik}`。 -/
theorem mul_neg_matrix_apply {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ)
    (B : Matrix (Fin n) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    (A * (-B)) i k = (-(A * B)) i k :=
  calc (A * (-B)) i k
      = ∑ j, A i j * (-B) j k := matrix_mul_apply_sum _ _ _ _                -- `mat_mult`
    _ = ∑ j, A i j * (-B j k) := by simp only [matrix_neg_apply]              -- `def_matrix_negation`
    _ = ∑ j, A i j * ((-1) * B j k) :=
        Finset.sum_congr rfl fun j _ => by rw [neg_one_mul]                   -- `multiply_by_minus_one`
    _ = ∑ j, (A i j * (-1)) * B j k :=
        Finset.sum_congr rfl fun j _ => (mul_assoc _ _ _).symm                -- 積の結合律
    _ = ∑ j, ((-1) * A i j) * B j k :=
        Finset.sum_congr rfl fun j _ => by rw [mul_comm (A i j) (-1)]         -- 積の交換律
    _ = ∑ j, (-1) * (A i j * B j k) :=
        Finset.sum_congr rfl fun j _ => mul_assoc _ _ _                       -- 積の結合律
    _ = (-1) * ∑ j, A i j * B j k := (Finset.mul_sum _ _ _).symm              -- 分配律
    _ = (-1) * (A * B) i k := by rw [matrix_mul_apply_sum]                    -- `mat_mult`
    _ = -(A * B) i k := neg_one_mul _                                         -- `multiply_by_minus_one`
    _ = (-(A * B)) i k := (matrix_neg_apply _ _ _).symm                       -- `def_matrix_negation`

/-- **`negation_factors_out_of_right_factor`**: `A(-B) = -(AB)`。 -/
theorem mul_neg_matrix {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ) :
    A * (-B) = -(A * B) :=
  Matrix.ext (mul_neg_matrix_apply A B)   -- 全ての成分が一致する

end Ising2D
