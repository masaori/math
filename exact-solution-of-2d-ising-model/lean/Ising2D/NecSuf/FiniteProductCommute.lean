/-
# 各因子と可換な元は有限積とも可換、二つの有限積の積は因子ごとの積の有限積（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteProductsOfCommutingMatrices.lean`
（人手 `matrix_commuting_with_each_factor_commutes_with_finite_product`・`product_of_two_finite_products_of_matrices`）。
具体版をこのファイルの系として導くのは、同じフォルダの `ClaimFiniteProductsOfCommutingMatricesFromNecSuf.lean`。

人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たり、人手の `A_j` が Lean の `A (j - 1)` である。有限積は左から掛ける `finProdLeft`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_commuting_with_each_factor_commutes_with_finite_product` の `r = 1`（3 行）・`r → r + 1`（7 行） | `commute_finProdLeft` の 2 つの節（同じ並び） |
| `product_of_two_finite_products_of_matrices` の `r = 1`（2 行）・`r → r + 1`（8 行） | `finProdLeft_mul_finProdLeft` の 2 つの節（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは積の結合則だけである（`Semigroup R`）。単位元・和・スカラー倍は効いていない（空の積を持たないので単位元が要らない）。
- 可換性の仮定は、一つ目の主張では `X` と各因子の組だけ、二つ目の主張では `j < i` の組 `A_i B_j = B_j A_i` だけである。
  `A_i` どうし・`B_j` どうし・`i ≤ j` の組 `A_i B_j` の可換性は効いていない。
- 残した可換性の仮定は外せない。一つ目は `r = 1` で `X A_1 ≠ A_1 X` なら主張そのものが外れる。二つ目は `r = 2` で
  `A_2 B_1 ≠ B_1 A_2` となる不定元の行列なら `(A_1A_2)(B_1B_2) ≠ (A_1B_1)(A_2B_2)` となる（SageMath の
  `product_of_two_finite_products_of_matrices` の否定コントロール）。
- 結合則は、帰納法の段で括弧を付け替える行（`(∏A)A_{r+1}` の中へ `X` や `∏B` を入れる行）に使う。
-/
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

/-- **`matrix_commuting_with_each_factor_commutes_with_finite_product`** の必要十分版: 各因子と可換な `X` は、左から掛ける有限積とも可換。 -/
theorem commute_finProdLeft {R : Type*} [Semigroup R] :
    ∀ (r : ℕ) (X : R) (A : Fin (r + 1) → R), (∀ j, X * A j = A j * X) → X * finProdLeft r A = finProdLeft r A * X
  | 0, X, A, h =>
    calc X * finProdLeft 0 A
        = X * A 0 := by rw [finProdLeft_zero]                                    -- 定義
      _ = A 0 * X := h 0                                                         -- 仮定（`j → 1`）
      _ = finProdLeft 0 A * X := by rw [finProdLeft_zero]                        -- 定義を右辺から左辺へ
  | r + 1, X, A, h =>
    calc X * finProdLeft (r + 1) A
        = X * (finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))) := by
          rw [finProdLeft_succ]                                                  -- 定義
      _ = (X * finProdLeft r (fun j => A (Fin.castSucc j))) * A (Fin.last (r + 1)) :=
          (mul_assoc _ _ _).symm                                                 -- 結合則を右辺から左辺へ
      _ = (finProdLeft r (fun j => A (Fin.castSucc j)) * X) * A (Fin.last (r + 1)) := by
          rw [commute_finProdLeft r X _ (fun j => h (Fin.castSucc j))]           -- 帰納法の仮定
      _ = finProdLeft r (fun j => A (Fin.castSucc j)) * (X * A (Fin.last (r + 1))) :=
          mul_assoc _ _ _                                                        -- 結合則
      _ = finProdLeft r (fun j => A (Fin.castSucc j)) * (A (Fin.last (r + 1)) * X) := by
          rw [h (Fin.last (r + 1))]                                              -- 仮定（`j → r + 1`）
      _ = (finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))) * X :=
          (mul_assoc _ _ _).symm                                                 -- 結合則を右辺から左辺へ
      _ = finProdLeft (r + 1) A * X := by rw [finProdLeft_succ]                  -- 定義を右辺から左辺へ

/-- **`product_of_two_finite_products_of_matrices`** の必要十分版: `j < i` で `A_i B_j = B_j A_i` なら `(∏A_j)(∏B_j) = ∏(A_jB_j)`。 -/
theorem finProdLeft_mul_finProdLeft {R : Type*} [Semigroup R] :
    ∀ (r : ℕ) (A B : Fin (r + 1) → R), (∀ i j : Fin (r + 1), j < i → A i * B j = B j * A i) →
      finProdLeft r A * finProdLeft r B = finProdLeft r (fun j => A j * B j)
  | 0, A, B, _ =>
    calc finProdLeft 0 A * finProdLeft 0 B
        = A 0 * B 0 := by rw [finProdLeft_zero, finProdLeft_zero]                -- 定義を 2 か所
      _ = finProdLeft 0 (fun j => A j * B j) := (finProdLeft_zero (fun j => A j * B j)).symm -- 定義を右辺から左辺へ
  | r + 1, A, B, h =>
    calc finProdLeft (r + 1) A * finProdLeft (r + 1) B
        = (finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1)))
            * (finProdLeft r (fun j => B (Fin.castSucc j)) * B (Fin.last (r + 1))) := by
          rw [finProdLeft_succ, finProdLeft_succ]                                -- 定義を 2 か所
      _ = ((finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1)))
            * finProdLeft r (fun j => B (Fin.castSucc j))) * B (Fin.last (r + 1)) :=
          (mul_assoc _ _ _).symm                                                 -- 結合則を右辺から左辺へ
      _ = (finProdLeft r (fun j => A (Fin.castSucc j))
            * (A (Fin.last (r + 1)) * finProdLeft r (fun j => B (Fin.castSucc j)))) * B (Fin.last (r + 1)) := by
          rw [mul_assoc (finProdLeft r (fun j => A (Fin.castSucc j)))]           -- 結合則
      _ = (finProdLeft r (fun j => A (Fin.castSucc j))
            * (finProdLeft r (fun j => B (Fin.castSucc j)) * A (Fin.last (r + 1)))) * B (Fin.last (r + 1)) := by
          rw [commute_finProdLeft r (A (Fin.last (r + 1))) (fun j => B (Fin.castSucc j))
            (fun j => h _ _ (Fin.castSucc_lt_last j))]                           -- 一つ目の主張（`X → A_{r+1}`、`A_j → B_j`）
      _ = ((finProdLeft r (fun j => A (Fin.castSucc j)) * finProdLeft r (fun j => B (Fin.castSucc j)))
            * A (Fin.last (r + 1))) * B (Fin.last (r + 1)) := by
          rw [← mul_assoc (finProdLeft r (fun j => A (Fin.castSucc j)))]         -- 結合則を右辺から左辺へ
      _ = (finProdLeft r (fun j => A (Fin.castSucc j) * B (Fin.castSucc j)) * A (Fin.last (r + 1)))
            * B (Fin.last (r + 1)) := by
          rw [finProdLeft_mul_finProdLeft r (fun j => A (Fin.castSucc j)) (fun j => B (Fin.castSucc j))
            (fun i j hij => h _ _ (Fin.castSucc_lt_castSucc_iff.mpr hij))]       -- 帰納法の仮定
      _ = finProdLeft r (fun j => A (Fin.castSucc j) * B (Fin.castSucc j))
            * (A (Fin.last (r + 1)) * B (Fin.last (r + 1))) := mul_assoc _ _ _    -- 結合則
      _ = finProdLeft (r + 1) (fun j => A j * B j) := (finProdLeft_succ r (fun j => A j * B j)).symm -- 定義を右辺から左辺へ

end Ising2D.NecSuf
