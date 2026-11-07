/-
# 実数の行列とベクトルの積は、ベクトルの実数倍と交換する（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`

* `linear_space_general_claim_real_matrix_vector_product_commutes_with_real_scalar_multiple`
  （ラベル **`real_matrix_vector_product_commutes_with_real_scalar_multiple`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 7 行の鎖 `(Pw)_i = … = c(Pu)_i` | `real_matrix_vector_product_commutes_with_real_scalar_multiple` の `calc` の 7 段 |
| 結び（`i` は任意） | 同じ定理の `∀ i` |

- 人手の `def_real_matrix_vector_product` は Lean の `Matrix _ _ ℝ` の `*ᵥ`（成分は `dotProduct` で、人手の式と `rfl`）である。
- 人手の `ℝ^n` の元の実数倍は本文で定めていないので、人手どおり `w` を成分の等式の仮定 `hw : ∀ k, w k = c * u k` で受け取る
  （`w := fun k => c * u k` なら `fun _ => rfl`）。
- 6 行目の `finite_sum_of_real_scalar_multiples` は、有限型の添字の版 `finite_sum_of_real_scalar_multiples_fintype` を引く。
  乗法の結合則・交換則は `mul_assoc`・`mul_comm` である。
- 人手の `m, n ∈ ℤ_{≥1}` と成分の番号は、Lean の添字の型の元である。Lean の主張は添字の型が空でも成り立つので、`Nonempty` を置かない。

必要十分版は `Ising2D.NecSuf.matrix_vector_product_commutes_with_scalar_multiple'`
（`Ising2D/NecSuf/MatrixVectorProductCommutesWithScalarMultiple.lean`）、導出は同じフォルダの
`ClaimRealMatrixVectorProductCommutesWithRealScalarMultipleFromNecSuf.lean` に置く。
必要十分版も同じ 7 段の `calc` で、4 段目の交換則は仮定 `hc`、6 段目は `finite_sum_mul_left'` に当たる。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Mathlib.Data.Matrix.Mul

namespace Ising2D

open Matrix

/-- **人手 `real_matrix_vector_product_commutes_with_real_scalar_multiple`**: すべての `k` で `w_k = c u_k` なら、
すべての `i` で `(Pw)_i = c(Pu)_i`。 -/
theorem real_matrix_vector_product_commutes_with_real_scalar_multiple {α β : Type*} [Fintype β]
    (P : Matrix α β ℝ) (c : ℝ) (u w : β → ℝ) (hw : ∀ k, w k = c * u k) :
    ∀ i, (P *ᵥ w) i = c * (P *ᵥ u) i := fun i =>
  calc (P *ᵥ w) i
      = ∑ j, P i j * w j := rfl                                               -- `def_real_matrix_vector_product`（`x → w`）
    _ = ∑ j, P i j * (c * u j) :=
        Finset.sum_congr rfl fun j _ => by rw [hw j]                          -- 仮定 `w_k = c u_k`（`k → j`）を `n` 個の項へ
    _ = ∑ j, (P i j * c) * u j :=
        Finset.sum_congr rfl fun j _ => (mul_assoc _ _ _).symm                -- ℝ の乗法の結合則を `n` 個の項へ
    _ = ∑ j, (c * P i j) * u j :=
        Finset.sum_congr rfl fun j _ => by rw [mul_comm (P i j) c]            -- ℝ の乗法の交換則を `n` 個の項へ
    _ = ∑ j, c * (P i j * u j) :=
        Finset.sum_congr rfl fun j _ => mul_assoc _ _ _                       -- ℝ の乗法の結合則を `n` 個の項へ
    _ = c * ∑ j, P i j * u j :=
        finite_sum_of_real_scalar_multiples_fintype c (fun j => P i j * u j)  -- `finite_sum_of_real_scalar_multiples`（`m → n`、`x_j → P_ij u_j`）
    _ = c * (P *ᵥ u) i := rfl                                                 -- `def_real_matrix_vector_product`（`x → u`）を右辺から左辺へ

end Ising2D
