/-
# 複素数の和の有限和と、行列の積の因子の和への分配（**具体版**）

対応する人手証明のラベル: `finite_sum_of_complex_sums`, `mat_mult_distributes_over_sum_in_right_factor`,
`mat_mult_distributes_over_sum_in_left_factor`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_finite_sum_of_complex_sums`,
`linear_space_general_claim_mat_mult_distributes_over_sum_in_right_factor`,
`linear_space_general_claim_mat_mult_distributes_over_sum_in_left_factor`）。

**必要十分版**: `Ising2D/NecSuf/MatMulDistribSum.lean`。具体版をその系として導くのは
`ClaimMatMultDistributesOverSumFromNecSuf.lean`。

## 人手証明との対応

* `finite_sum_of_complex_sums` の帰納法は、Lean では `n + 1` 項の和（`Fin (n + 1)` の上の和）について `n` の帰納法で書く
  （`finite_sum_of_complex_sums_succ`）。人手の `n ∈ ℤ_{≥1}` が Lean の `n + 1` に当たる。`def_finite_sum_of_complex_numbers` の 2 つの式は
  `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す（mathlib の `Finset.sum` を人手の左から足す和の定義へ読み替える段）。
  帰納法の段の結合律・交換律の 5 行（人手の `α := Σ a_j`、`β := Σ b_j`）は `finite_sum_of_complex_sums_step` の 5 段と 1 対 1 である
  （`complex_numbers_form_a_field` の和の結合律・交換律は `add_assoc`・`add_comm`）。`n = 0`（空の和）は人手には無い。
* 2 つの分配の成分の鎖の 6 行は、`mul_add_matrix_apply`・`add_mul_matrix_apply` の `calc` の 6 段と 1 対 1 である。
  `ℂ` の分配律を各項へ同時適用する行は `Finset.sum_congr` と `mul_add`・`add_mul`（`complex_numbers_form_a_field`）で出す。
  成分の式との接点は `matrix_mul_apply_sum`（`mat_mult`）と `matrix_sum_apply`（`def_matrix_sum`）である。
* 人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

open Matrix

/-- **`finite_sum_of_complex_sums`** の帰納法の段の 5 行: `(α + β) + (a_{n+1} + b_{n+1}) = (α + a_{n+1}) + (β + b_{n+1})`。 -/
theorem finite_sum_of_complex_sums_step (α β x y : ℂ) :
    (α + β) + (x + y) = (α + x) + (β + y) :=
  calc (α + β) + (x + y)
      = α + (β + (x + y)) := add_assoc _ _ _                                 -- 和の結合律
    _ = α + ((β + x) + y) := by rw [add_assoc β x y]                         -- 和の結合律
    _ = α + ((x + β) + y) := by rw [add_comm β x]                            -- 和の交換律
    _ = α + (x + (β + y)) := by rw [add_assoc x β y]                         -- 和の結合律
    _ = (α + x) + (β + y) := (add_assoc _ _ _).symm                          -- 和の結合律

/-- **`finite_sum_of_complex_sums`**（`n + 1` 項）: `Σ_{j=1}^{n+1}(a_j + b_j) = Σ a_j + Σ b_j`。`n` についての帰納法。 -/
theorem finite_sum_of_complex_sums_succ (n : ℕ) (a b : Fin (n + 1) → ℂ) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j := by
  induction n with
  | zero =>
    calc ∑ j : Fin 1, (a j + b j)
        = a 0 + b 0 := Fin.sum_univ_one _                                    -- `def_finite_sum_of_complex_numbers`
      _ = (∑ j : Fin 1, a j) + ∑ j : Fin 1, b j := by
          rw [Fin.sum_univ_one a, Fin.sum_univ_one b]                         -- 同上を 2 か所
  | succ n ih =>
    calc ∑ j : Fin (n + 2), (a j + b j)
        = (∑ j : Fin (n + 1), (a j.castSucc + b j.castSucc)) + (a (Fin.last _) + b (Fin.last _)) :=
          Fin.sum_univ_castSucc _                                             -- `def_finite_sum_of_complex_numbers`
      _ = ((∑ j : Fin (n + 1), a j.castSucc) + ∑ j : Fin (n + 1), b j.castSucc)
            + (a (Fin.last _) + b (Fin.last _)) := by
          rw [ih (fun j => a j.castSucc) (fun j => b j.castSucc)]             -- 帰納法の仮定
      _ = ((∑ j : Fin (n + 1), a j.castSucc) + a (Fin.last _))
            + ((∑ j : Fin (n + 1), b j.castSucc) + b (Fin.last _)) :=
          finite_sum_of_complex_sums_step _ _ _ _                              -- 結合律・交換律の 5 行
      _ = (∑ j, a j) + ∑ j, b j := by
          rw [Fin.sum_univ_castSucc a, Fin.sum_univ_castSucc b]               -- `def_finite_sum_of_complex_numbers` を 2 か所

/-- **`finite_sum_of_complex_sums`**（`n = 0` の空の和を含む。`n = 0` は人手には無い）。 -/
theorem finite_sum_of_complex_sums (n : ℕ) (a b : Fin n → ℂ) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j := by
  cases n with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, Fin.sum_univ_zero, add_zero]
  | succ n => exact finite_sum_of_complex_sums_succ n a b

/-- **`mat_mult_distributes_over_sum_in_right_factor`** の成分の鎖: `(A(B + C))_{ik} = (AB + AC)_{ik}`。 -/
theorem mul_add_matrix_apply {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ)
    (B C : Matrix (Fin n) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    (A * (B + C)) i k = (A * B + A * C) i k :=
  calc (A * (B + C)) i k
      = ∑ j, A i j * (B + C) j k := matrix_mul_apply_sum _ _ _ _              -- `mat_mult`
    _ = ∑ j, A i j * (B j k + C j k) := by simp only [matrix_sum_apply]       -- `def_matrix_sum`
    _ = ∑ j, (A i j * B j k + A i j * C j k) :=
        Finset.sum_congr rfl fun _ _ => mul_add _ _ _                         -- `ℂ` の分配律を各項へ
    _ = (∑ j, A i j * B j k) + ∑ j, A i j * C j k :=
        finite_sum_of_complex_sums n (fun j => A i j * B j k) (fun j => A i j * C j k)  -- `finite_sum_of_complex_sums`
    _ = (A * B) i k + (A * C) i k := by
        rw [matrix_mul_apply_sum A B, matrix_mul_apply_sum A C]               -- `mat_mult` を 2 か所
    _ = (A * B + A * C) i k := (matrix_sum_apply _ _ _ _).symm                -- `def_matrix_sum`

/-- **`mat_mult_distributes_over_sum_in_right_factor`**: `A(B + C) = AB + AC`。 -/
theorem mul_add_matrix {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B C : Matrix (Fin n) (Fin p) ℂ) :
    A * (B + C) = A * B + A * C :=
  Matrix.ext (mul_add_matrix_apply A B C)   -- 全ての成分が一致する

/-- **`mat_mult_distributes_over_sum_in_left_factor`** の成分の鎖: `((A + B)C)_{ik} = (AC + BC)_{ik}`。 -/
theorem add_mul_matrix_apply {m n p : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ)
    (C : Matrix (Fin n) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    ((A + B) * C) i k = (A * C + B * C) i k :=
  calc ((A + B) * C) i k
      = ∑ j, (A + B) i j * C j k := matrix_mul_apply_sum _ _ _ _              -- `mat_mult`
    _ = ∑ j, (A i j + B i j) * C j k := by simp only [matrix_sum_apply]       -- `def_matrix_sum`
    _ = ∑ j, (A i j * C j k + B i j * C j k) :=
        Finset.sum_congr rfl fun _ _ => add_mul _ _ _                         -- `ℂ` の分配律を各項へ
    _ = (∑ j, A i j * C j k) + ∑ j, B i j * C j k :=
        finite_sum_of_complex_sums n (fun j => A i j * C j k) (fun j => B i j * C j k)  -- `finite_sum_of_complex_sums`
    _ = (A * C) i k + (B * C) i k := by
        rw [matrix_mul_apply_sum A C, matrix_mul_apply_sum B C]               -- `mat_mult` を 2 か所
    _ = (A * C + B * C) i k := (matrix_sum_apply _ _ _ _).symm                -- `def_matrix_sum`

/-- **`mat_mult_distributes_over_sum_in_left_factor`**: `(A + B)C = AC + BC`。 -/
theorem add_mul_matrix {m n p : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (C : Matrix (Fin n) (Fin p) ℂ) :
    (A + B) * C = A * C + B * C :=
  Matrix.ext (add_mul_matrix_apply A B C)   -- 全ての成分が一致する

end Ising2D
