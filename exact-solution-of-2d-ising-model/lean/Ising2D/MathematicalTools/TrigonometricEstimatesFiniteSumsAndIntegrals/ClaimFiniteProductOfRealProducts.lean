/-
# 実数の積の有限積は有限積の積（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_finite_product_of_real_products`、ラベル **`finite_product_of_real_products`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 2 行（`def_finite_product_of_real_numbers` → 同じ定義を 2 箇所へ同時に、右辺から左辺へ） | `finite_product_of_real_products` の `0` の節の `calc` の 2 段 |
| `m → m+1` の 4 行（定義 → 帰納法の仮定 → ℝ で `(ab)(cd) = (ac)(bd)` → 定義を 2 箇所へ同時に、右辺から左辺へ） | `m + 1` の節の `calc` の 4 段 |

- 人手の `x_1, …, x_m`・`y_1, …, y_m`（`m ≥ 1`）は Lean の `x y : Fin (m + 1) → ℝ` である（人手の `m` は Lean の `m + 1`。添字は 0 始まりで、人手の `j` は `j - 1`）。
- 人手の有限積（`def_finite_product_of_real_numbers`）は Lean の `∏ j, x j`（`Finset.prod`）で、定義の 2 つの式は
  `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む（`ClaimFiniteProductOfPositiveRealsIsPositive.lean` と同じ）。
- 人手の「ℝ で `(ab)(cd) = (ac)(bd)`（乗法の交換則と結合則）」は mathlib の `mul_mul_mul_comm` である。mathlib の `Finset.prod_mul_distrib` は使わない。

必要十分版は `Ising2D/NecSuf/FiniteProductOfProducts.lean`、具体版をその系として導くのは
`ClaimFiniteProductOfRealProductsFromNecSuf.lean`。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `finite_product_of_real_products`**: `Π_{j=1}^{m}(x_jy_j) = (Π_{j=1}^{m}x_j)(Π_{j=1}^{m}y_j)`
（人手の `m` は Lean の `m + 1`）。 -/
theorem finite_product_of_real_products :
    ∀ (m : ℕ) (x y : Fin (m + 1) → ℝ), ∏ j, (x j * y j) = (∏ j, x j) * (∏ j, y j)
  | 0, x, y =>
    calc ∏ j, (x j * y j)
        = x 0 * y 0 := Fin.prod_univ_one _                                   -- `def_finite_product_of_real_numbers`（`r_j → x_jy_j`）
      _ = (∏ j, x j) * (∏ j, y j) := by rw [Fin.prod_univ_one, Fin.prod_univ_one]
                                                                              -- `def_finite_product_of_real_numbers`（`r_j → x_j`、`r_j → y_j`）
                                                                              -- を 2 箇所へ同時に、右辺から左辺へ
  | m + 1, x, y =>
    calc ∏ j, (x j * y j)
        = (∏ j : Fin (m + 1), (x (Fin.castSucc j) * y (Fin.castSucc j))) * (x (Fin.last (m + 1)) * y (Fin.last (m + 1))) :=
          Fin.prod_univ_castSucc _                                            -- `def_finite_product_of_real_numbers`（`r_j → x_jy_j`）
      _ = ((∏ j : Fin (m + 1), x (Fin.castSucc j)) * (∏ j : Fin (m + 1), y (Fin.castSucc j)))
            * (x (Fin.last (m + 1)) * y (Fin.last (m + 1))) := by
          rw [finite_product_of_real_products m (fun j => x (Fin.castSucc j)) (fun j => y (Fin.castSucc j))]
                                                                              -- 帰納法の仮定
      _ = ((∏ j : Fin (m + 1), x (Fin.castSucc j)) * x (Fin.last (m + 1)))
            * ((∏ j : Fin (m + 1), y (Fin.castSucc j)) * y (Fin.last (m + 1))) :=
          mul_mul_mul_comm _ _ _ _                                            -- ℝ で `(ab)(cd) = (ac)(bd)`（乗法の交換則と結合則）
      _ = (∏ j, x j) * (∏ j, y j) := by rw [Fin.prod_univ_castSucc x, Fin.prod_univ_castSucc y]
                                                                              -- `def_finite_product_of_real_numbers`（`r_j → x_j`、`r_j → y_j`）
                                                                              -- を 2 箇所へ同時に、右辺から左辺へ

end Ising2D
