/-
# 行列の積の転置は転置を逆の順に掛けた積（**具体版**）

対応する人手証明のラベル: `transpose_of_matrix_product`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_transpose_of_matrix_product`）。

**必要十分版**: `Ising2D/NecSuf/TransposeOfMatrixProduct.lean`。具体版をその系として導き、`TensorPow M` の系を置くのは
`ClaimTransposeOfMatrixProductFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `(k, l)` 成分の鎖の 5 行（`def_matrix_transpose` → `mat_mult` → `def_matrix_transpose` を各項の 2 箇所 → `ℂ` の積の交換律を各項へ → `mat_mult`） | `matrix_transpose_mul_apply` の `calc` の 5 段 |
| 「全ての成分が一致する」 | `Matrix.ext` |

* 成分の式との接点は `matrix_transpose_apply`（`def_matrix_transpose`）・`matrix_mul_apply_sum`（`mat_mult`）である。
* `ℂ` の積の交換律（`complex_numbers_form_a_field`）は `mul_comm` で出す。mathlib の `Matrix.transpose_mul` は使わない。
* 人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いか和が空なだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`transpose_of_matrix_product`** の成分の鎖: `((AB)^⊤)_{kl} = (B^⊤A^⊤)_{kl}`。必要十分版は `NecSuf.transpose_mul_matrix_apply'`（同じ段の並び）。 -/
theorem matrix_transpose_mul_apply {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ)
    (k : Fin p) (l : Fin m) :
    (A * B)ᵀ k l = (Bᵀ * Aᵀ) k l :=
  calc (A * B)ᵀ k l
      = (A * B) l k := matrix_transpose_apply _ _ _                           -- `def_matrix_transpose`（`B → AB`, `p → k`, `q → l`）
    _ = ∑ j, A l j * B j k := matrix_mul_apply_sum _ _ _ _                    -- `mat_mult`（`i → l`）
    _ = ∑ j, Aᵀ j l * Bᵀ k j := by
        simp only [matrix_transpose_apply]                                    -- `def_matrix_transpose` を各項の 2 箇所へ同時に適用
    _ = ∑ j, Bᵀ k j * Aᵀ j l :=
        Finset.sum_congr rfl fun _ _ => mul_comm _ _                          -- `ℂ` の積の交換律を各項へ同時に適用
    _ = (Bᵀ * Aᵀ) k l := (matrix_mul_apply_sum _ _ _ _).symm                  -- `mat_mult`（`A → B^⊤`, `B → A^⊤`, `i → k`, `k → l`）

/-- **`transpose_of_matrix_product`**: `(AB)^⊤ = B^⊤A^⊤`。必要十分版は `NecSuf.transpose_mul_matrix'`（同じ段の並び）。 -/
theorem matrix_transpose_mul {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ) :
    (A * B)ᵀ = Bᵀ * Aᵀ :=
  Matrix.ext (matrix_transpose_mul_apply A B)   -- 全ての成分が一致する

end Ising2D
