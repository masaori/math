/-
# 各因子と可換な行列は有限積とも可換、二つの有限積の積は因子ごとの積の有限積（**具体版**）

対応する人手証明のラベル: `matrix_commuting_with_each_factor_commutes_with_finite_product`・`product_of_two_finite_products_of_matrices`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_matrix_commuting_with_each_factor_commutes_with_finite_product`・
`linear_space_general_claim_product_of_two_finite_products_of_matrices`）。

**必要十分版**: `Ising2D/NecSuf/FiniteProductCommute.lean`。具体版をその系として導くのは
`ClaimFiniteProductsOfCommutingMatricesFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たり、人手の `A_j` が Lean の `A (j - 1)` である。有限積は `finiteMatrixProduct`（`def_finite_product_of_matrices`）。
* 二つの主張の帰納法の鎖（一つ目は `r = 1` の 3 行と `r → r + 1` の 7 行、二つ目は `r = 1` の 2 行と `r → r + 1` の 8 行）は、
  同じ名前の定理の 2 つの節の `calc` と 1 対 1 である。
  `mat_mult_associative` は Lean の具体版が無く、mathlib の `Matrix.mul_assoc` を 1 回ずつ使う（ほかのファイルと同じ扱い）。
* 人手の前提「`1 ≤ j < i ≤ r+1` なら `A_iB_j = B_jA_i`」から帰納法の仮定の前提と一つ目の主張の前提を取り出す段は、
  `Fin.castSucc_lt_castSucc_iff`・`Fin.castSucc_lt_last`（添字の大小の読み替え）である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatrices

namespace Ising2D

open Matrix

/-- **`matrix_commuting_with_each_factor_commutes_with_finite_product`**: 全ての `j` で `XA_j = A_jX` なら `X∏A_j = (∏A_j)X`（人手の `r` は Lean の `r + 1`）。 -/
theorem matrix_commuting_with_each_factor_commutes_with_finite_product {n : ℕ} :
    ∀ (r : ℕ) (X : Matrix (Fin n) (Fin n) ℂ) (A : Fin (r + 1) → Matrix (Fin n) (Fin n) ℂ),
      (∀ j, X * A j = A j * X) → X * finiteMatrixProduct r A = finiteMatrixProduct r A * X
  | 0, X, A, h =>
    calc X * finiteMatrixProduct 0 A
        = X * A 0 := by rw [finiteMatrixProduct_zero]                            -- `def_finite_product_of_matrices`
      _ = A 0 * X := h 0                                                         -- 仮定（`j → 1`）
      _ = finiteMatrixProduct 0 A * X := by rw [finiteMatrixProduct_zero]        -- `def_finite_product_of_matrices` を右辺から左辺へ
  | r + 1, X, A, h =>
    calc X * finiteMatrixProduct (r + 1) A
        = X * (finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))) := by
          rw [finiteMatrixProduct_succ]                                          -- `def_finite_product_of_matrices`
      _ = (X * finiteMatrixProduct r (fun j => A (Fin.castSucc j))) * A (Fin.last (r + 1)) :=
          (Matrix.mul_assoc _ _ _).symm                                          -- `mat_mult_associative` を右辺から左辺へ
      _ = (finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * X) * A (Fin.last (r + 1)) := by
          rw [matrix_commuting_with_each_factor_commutes_with_finite_product r X _
            (fun j => h (Fin.castSucc j))]                                       -- 帰納法の仮定
      _ = finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * (X * A (Fin.last (r + 1))) :=
          Matrix.mul_assoc _ _ _                                                 -- `mat_mult_associative`
      _ = finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * (A (Fin.last (r + 1)) * X) := by
          rw [h (Fin.last (r + 1))]                                              -- 仮定（`j → r + 1`）
      _ = (finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))) * X :=
          (Matrix.mul_assoc _ _ _).symm                                          -- `mat_mult_associative` を右辺から左辺へ
      _ = finiteMatrixProduct (r + 1) A * X := by
          rw [finiteMatrixProduct_succ]                                          -- `def_finite_product_of_matrices` を右辺から左辺へ

/-- **`product_of_two_finite_products_of_matrices`**: `j < i` で `A_iB_j = B_jA_i` なら `(∏A_j)(∏B_j) = ∏(A_jB_j)`（人手の `r` は Lean の `r + 1`）。 -/
theorem product_of_two_finite_products_of_matrices {n : ℕ} :
    ∀ (r : ℕ) (A B : Fin (r + 1) → Matrix (Fin n) (Fin n) ℂ),
      (∀ i j : Fin (r + 1), j < i → A i * B j = B j * A i) →
      finiteMatrixProduct r A * finiteMatrixProduct r B = finiteMatrixProduct r (fun j => A j * B j)
  | 0, A, B, _ =>
    calc finiteMatrixProduct 0 A * finiteMatrixProduct 0 B
        = A 0 * B 0 := by rw [finiteMatrixProduct_zero, finiteMatrixProduct_zero] -- `def_finite_product_of_matrices` を 2 か所
      _ = finiteMatrixProduct 0 (fun j => A j * B j) :=
          (finiteMatrixProduct_zero (fun j => A j * B j)).symm -- `def_finite_product_of_matrices`（`A_j → A_jB_j`）を右辺から左辺へ
  | r + 1, A, B, h =>
    calc finiteMatrixProduct (r + 1) A * finiteMatrixProduct (r + 1) B
        = (finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1)))
            * (finiteMatrixProduct r (fun j => B (Fin.castSucc j)) * B (Fin.last (r + 1))) := by
          rw [finiteMatrixProduct_succ, finiteMatrixProduct_succ]                -- `def_finite_product_of_matrices` を 2 か所
      _ = ((finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1)))
            * finiteMatrixProduct r (fun j => B (Fin.castSucc j))) * B (Fin.last (r + 1)) :=
          (Matrix.mul_assoc _ _ _).symm                                          -- `mat_mult_associative` を右辺から左辺へ
      _ = (finiteMatrixProduct r (fun j => A (Fin.castSucc j))
            * (A (Fin.last (r + 1)) * finiteMatrixProduct r (fun j => B (Fin.castSucc j))))
            * B (Fin.last (r + 1)) := by
          rw [Matrix.mul_assoc (finiteMatrixProduct r (fun j => A (Fin.castSucc j)))] -- `mat_mult_associative`
      _ = (finiteMatrixProduct r (fun j => A (Fin.castSucc j))
            * (finiteMatrixProduct r (fun j => B (Fin.castSucc j)) * A (Fin.last (r + 1))))
            * B (Fin.last (r + 1)) := by
          rw [matrix_commuting_with_each_factor_commutes_with_finite_product r (A (Fin.last (r + 1)))
            (fun j => B (Fin.castSucc j)) (fun j => h _ _ (Fin.castSucc_lt_last j))]
                                                                                 -- `matrix_commuting_with_each_factor_commutes_with_finite_product`（`X → A_{r+1}`、`A_j → B_j`）
      _ = ((finiteMatrixProduct r (fun j => A (Fin.castSucc j))
            * finiteMatrixProduct r (fun j => B (Fin.castSucc j))) * A (Fin.last (r + 1)))
            * B (Fin.last (r + 1)) := by
          rw [← Matrix.mul_assoc (finiteMatrixProduct r (fun j => A (Fin.castSucc j)))] -- `mat_mult_associative` を右辺から左辺へ
      _ = (finiteMatrixProduct r (fun j => A (Fin.castSucc j) * B (Fin.castSucc j)) * A (Fin.last (r + 1)))
            * B (Fin.last (r + 1)) := by
          rw [product_of_two_finite_products_of_matrices r (fun j => A (Fin.castSucc j))
            (fun j => B (Fin.castSucc j))
            (fun i j hij => h _ _ (Fin.castSucc_lt_castSucc_iff.mpr hij))]       -- 帰納法の仮定
      _ = finiteMatrixProduct r (fun j => A (Fin.castSucc j) * B (Fin.castSucc j))
            * (A (Fin.last (r + 1)) * B (Fin.last (r + 1))) :=
          Matrix.mul_assoc _ _ _                                                 -- `mat_mult_associative`
      _ = finiteMatrixProduct (r + 1) (fun j => A j * B j) :=
          (finiteMatrixProduct_succ r (fun j => A j * B j)).symm -- `def_finite_product_of_matrices`（`A_j → A_jB_j`）を右辺から左辺へ

end Ising2D
