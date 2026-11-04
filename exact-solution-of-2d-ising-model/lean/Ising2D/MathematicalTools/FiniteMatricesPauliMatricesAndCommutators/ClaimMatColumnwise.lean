/-
# 行列の積は列ごとに作用する（**具体版**）

対応する人手証明のラベル: `mat_columnwise`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_004_action_on_matrix_pair`）。

**必要十分版**: `Ising2D/NecSuf/MatColumnwise.lean` の `NecSuf.mul_cols_eq_cols_mulVec`。
具体版をその系として導くのと `TensorPow M` での系は `ClaimMatColumnwiseFromNecSuf.lean`。

## 人手証明との対応

* 人手の「列に並べた行列 `[b_1 ⋯ b_p]`（第 `k` 列の第 `j` 成分が `(b_k)_j`）」は `Matrix.of fun j k => b k j`、
  数ベクトル `b_k ∈ ℂ^n` は `b k : Fin n → ℂ` である（Lean の数ベクトルは 1 列の行列ではなく `Fin n → ℂ`）。
* 人手の成分の鎖 4 行は `matrix_mul_columns` の `calc` の 4 段と 1 対 1 である
  （1 行目と 3 行目の `mat_mult` は `matrix_mul_apply_sum`・`mulVec_apply_sum`、2 行目と 4 行目の
  「列に並べた行列の成分の定め方」は `Matrix.of` の成分で、定義の展開 `rfl` である）。
  人手の「各成分が一致することを示せばよい」は `ext i k` である。
* 人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`mat_columnwise`**: `A[b_1 ⋯ b_p] = [Ab_1 ⋯ Ab_p]`。 -/
theorem matrix_mul_columns {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (b : Fin p → Fin n → ℂ) :
    A * Matrix.of (fun j k => b k j) = Matrix.of (fun i k => (A *ᵥ b k) i) := by
  ext i k
  calc (A * Matrix.of (fun j k => b k j)) i k
      = ∑ j, A i j * Matrix.of (fun j k => b k j) j k := matrix_mul_apply_sum _ _ _ _
                                                        -- `mat_mult`
    _ = ∑ j, A i j * b k j := rfl                       -- 列に並べた行列の成分の定め方
    _ = (A *ᵥ b k) i := (mulVec_apply_sum _ _ _).symm  -- `mat_mult` を `Ab_k` へ適用
    _ = Matrix.of (fun i k => (A *ᵥ b k) i) i k := rfl  -- 列に並べた行列の成分の定め方

end Ising2D
