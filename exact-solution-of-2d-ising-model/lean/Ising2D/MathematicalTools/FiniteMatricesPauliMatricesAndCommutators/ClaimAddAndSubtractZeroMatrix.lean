/-
# 零行列を足す・引く・零行列の有限和（**具体版**）

対応する人手証明のラベル: `def_matrix_sum`, `matrix_plus_zero_matrix`, `zero_matrix_plus_matrix`,
`matrix_minus_zero_matrix`, `finite_sum_of_zero_matrices`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_definition_matrix_sum`,
`linear_space_general_claim_matrix_plus_zero_matrix`, `linear_space_general_claim_zero_matrix_plus_matrix`,
`linear_space_general_claim_matrix_minus_zero_matrix`, `linear_space_general_claim_finite_sum_of_zero_matrices`）。

**必要十分版**: `Ising2D/NecSuf/MatrixAddSubZero.lean`。具体版をその系として導くのは
`ClaimAddAndSubtractZeroMatrixFromNecSuf.lean`。

## 人手証明との対応

* 行列の和・差・零行列は mathlib の `+`・`-`・`0` を使い、人手の成分の式との接点は `matrix_sum_apply`（`def_matrix_sum`）と、
  `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `matrix_sub_apply`（`def_matrix_difference`）・`matrix_zero_apply`（`def_zero_matrix`）である。
* 人手の `X_{ik} = (a,b)`（`definition_of_cc` の台集合 `ℝ²` の元）は、Lean の `ℂ` の構造体の 2 つの欄 `re`・`im` で
  `⟨(X i k).re, (X i k).im⟩` と書く（構造体の η で `X i k` と定義上等しい）。`0_ℂ = (0,0)`（`inclusion_rr_to_cc`）も定義上の等号である。
* `matrix_plus_zero_matrix`・`zero_matrix_plus_matrix` の成分の鎖の 7 行は、`matrix_add_zero_matrix_apply`・`zero_matrix_add_matrix_apply` の
  `calc` の 7 段と 1 対 1 である。最後の「行列の等号は成分ごと」は `Matrix.ext`。
* `matrix_minus_zero_matrix` の成分の鎖の 10 行は `matrix_sub_zero_matrix_apply` の 10 段と 1 対 1 である。
  人手の `-0_ℂ = (-1_ℂ)·0_ℂ`（`multiply_by_minus_one`）は、Lean の `ℂ` の符号反転が積で定義されていないので `neg_one_mul` で出す。
  `(-1_ℂ, 0_ℂ) = ((-1,0),(0,0))`（`inclusion_rr_to_cc`）と `ℝ` の四則の段は、構造体の欄ごとの等号（`Complex.ext`）で出す。
  続く `X - O = X + O = X` の 2 行は `matrix_sub_zero_matrix` の 2 段である。
* `finite_sum_of_zero_matrices` の帰納法は、Lean では `r + 1` 項の和（`Fin (r + 1)` の上の和）について `r` の帰納法で書く。
  人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。`def_finite_sum_of_matrices` の 2 つの式（`Σ_{j=1}^{1} X_j = X_1` と
  `Σ_{j=1}^{r+1} X_j = (Σ_{j=1}^{r} X_j) + X_{r+1}`）は、`Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す
  （mathlib の `Finset.sum` を人手の左から足す和の定義へ読み替える段で、計算の内容を委ねるものではない）。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

open Matrix

/-- **`def_matrix_sum`**: `(A + B)_{ik} = A_{ik} + B_{ik}`。 -/
theorem matrix_sum_apply {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    (A + B) i k = A i k + B i k :=
  rfl

/-- **`matrix_plus_zero_matrix`** の成分の鎖: `(X + O)_{ik} = X_{ik}`。 -/
theorem matrix_add_zero_matrix_apply {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    (X + 0) i k = X i k :=
  calc (X + 0) i k
      = X i k + (0 : Matrix (Fin m) (Fin n) ℂ) i k := matrix_sum_apply _ _ _ _   -- `def_matrix_sum`
    _ = X i k + 0 := by rw [matrix_zero_apply]                                     -- `def_zero_matrix`
    _ = (⟨(X i k).re, (X i k).im⟩ : ℂ) + 0 := rfl                                 -- `a, b` の取り方（`X_{ik} = (a,b)`）
    _ = (⟨(X i k).re, (X i k).im⟩ : ℂ) + ⟨0, 0⟩ := rfl                            -- `inclusion_rr_to_cc`
    _ = ⟨(X i k).re + 0, (X i k).im + 0⟩ := rfl                                   -- `definition_of_cc` の和
    _ = ⟨(X i k).re, (X i k).im⟩ := by rw [add_zero, add_zero]                    -- `ℝ` で `a + 0 = a`, `b + 0 = b`
    _ = X i k := rfl                                                               -- `a, b` の取り方

/-- **`matrix_plus_zero_matrix`**: `X + O = X`。 -/
theorem matrix_add_zero_matrix {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) : X + 0 = X :=
  Matrix.ext (matrix_add_zero_matrix_apply X)   -- 行列の等号は成分ごと

/-- **`zero_matrix_plus_matrix`** の成分の鎖: `(O + X)_{ik} = X_{ik}`。 -/
theorem zero_matrix_add_matrix_apply {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    (0 + X) i k = X i k :=
  calc (0 + X) i k
      = (0 : Matrix (Fin m) (Fin n) ℂ) i k + X i k := matrix_sum_apply _ _ _ _   -- `def_matrix_sum`
    _ = 0 + X i k := by rw [matrix_zero_apply]                                     -- `def_zero_matrix`
    _ = 0 + (⟨(X i k).re, (X i k).im⟩ : ℂ) := rfl                                 -- `a, b` の取り方（`X_{ik} = (a,b)`）
    _ = (⟨0, 0⟩ : ℂ) + ⟨(X i k).re, (X i k).im⟩ := rfl                            -- `inclusion_rr_to_cc`
    _ = ⟨0 + (X i k).re, 0 + (X i k).im⟩ := rfl                                   -- `definition_of_cc` の和
    _ = ⟨(X i k).re, (X i k).im⟩ := by rw [zero_add, zero_add]                    -- `ℝ` で `0 + a = a`, `0 + b = b`
    _ = X i k := rfl                                                               -- `a, b` の取り方

/-- **`zero_matrix_plus_matrix`**: `O + X = X`。 -/
theorem zero_matrix_add_matrix {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) : 0 + X = X :=
  Matrix.ext (zero_matrix_add_matrix_apply X)   -- 行列の等号は成分ごと

/-- **`matrix_minus_zero_matrix`** の成分の鎖: `(X - O)_{ik} = (X + O)_{ik}`。 -/
theorem matrix_sub_zero_matrix_apply {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    (X - 0) i k = (X + 0) i k :=
  calc (X - 0) i k
      = X i k - (0 : Matrix (Fin m) (Fin n) ℂ) i k := matrix_sub_apply _ _ _ _    -- `def_matrix_difference`
    _ = X i k - 0 := by rw [matrix_zero_apply]                                     -- `def_zero_matrix`
    _ = X i k + -(0 : ℂ) := sub_eq_add_neg _ _                                     -- `def_complex_difference`
    _ = X i k + (-1) * (0 : ℂ) := by rw [neg_one_mul]                              -- `multiply_by_minus_one`
    _ = X i k + (⟨-1, 0⟩ : ℂ) * ⟨0, 0⟩ := by
        congr 1
        exact congrArg₂ (· * ·) (Complex.ext (by simp) (by simp)) rfl             -- `inclusion_rr_to_cc`
    _ = X i k + ⟨(-1) * 0 - 0 * 0, (-1) * 0 + 0 * 0⟩ := rfl                       -- `definition_of_cc` の積
    _ = X i k + ⟨0, 0⟩ := by congr 1; exact Complex.ext (by simp) (by simp)        -- `ℝ` の四則
    _ = X i k + 0 := rfl                                                           -- `inclusion_rr_to_cc`
    _ = X i k + (0 : Matrix (Fin m) (Fin n) ℂ) i k := by rw [matrix_zero_apply]    -- `def_zero_matrix`
    _ = (X + 0) i k := (matrix_sum_apply _ _ _ _).symm                             -- `def_matrix_sum`

/-- **`matrix_minus_zero_matrix`**: `X - O = X`。 -/
theorem matrix_sub_zero_matrix {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) : X - 0 = X :=
  calc X - 0
      = X + 0 := Matrix.ext (matrix_sub_zero_matrix_apply X)   -- 上の成分ごとの等式（行列の等号は成分ごと）
    _ = X := matrix_add_zero_matrix X                          -- `matrix_plus_zero_matrix`

/-- **`finite_sum_of_zero_matrices`**: `Σ_{j=1}^{r+1} O = O`（人手の `r` は Lean の `r + 1`）。 -/
theorem finite_sum_of_zero_matrices {m n : ℕ} (r : ℕ) :
    ∑ _j : Fin (r + 1), (0 : Matrix (Fin m) (Fin n) ℂ) = 0 := by
  induction r with
  | zero =>
    calc ∑ _j : Fin (0 + 1), (0 : Matrix (Fin m) (Fin n) ℂ)
        = 0 := Fin.sum_univ_one _                                          -- `def_finite_sum_of_matrices`
  | succ r ih =>
    calc ∑ _j : Fin (r + 1 + 1), (0 : Matrix (Fin m) (Fin n) ℂ)
        = (∑ _j : Fin (r + 1), (0 : Matrix (Fin m) (Fin n) ℂ)) + 0 :=
          Fin.sum_univ_castSucc _                                          -- `def_finite_sum_of_matrices`
      _ = 0 + 0 := by rw [ih]                                              -- 帰納法の仮定
      _ = 0 := matrix_add_zero_matrix 0                                    -- `matrix_plus_zero_matrix`（`X = O`）

end Ising2D
