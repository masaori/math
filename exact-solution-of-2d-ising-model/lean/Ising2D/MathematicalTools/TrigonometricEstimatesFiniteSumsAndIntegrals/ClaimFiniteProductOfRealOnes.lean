/-
# 実数の 1 の有限積は 1（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_finite_product_of_real_ones`、ラベル **`finite_product_of_real_ones`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 1 行（定義の `Π_{j=1}^{1} r_j := r_1`（`r_j → 1`）） | `finite_product_of_real_ones` の `0` の節の `calc` の 1 段 |
| `m → m+1` の 3 行（定義の帰納の式（`r_j → 1`） → 帰納法の仮定 → ℝ の乗法の単位元 `p·1 = p`（`p → 1`）） | `m + 1` の節の `calc` の 3 段 |

- 人手の `m`（`m ≥ 1`）は Lean の `m + 1` で、因子の添字は `Fin (m + 1)` である。
- 人手の有限積（`def_finite_product_of_real_numbers`）は Lean の `∏ j, r j`（`Finset.prod`）で、定義の 2 つの式は
  `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む（`ClaimFiniteProductOfRealProducts.lean` と同じ）。
  mathlib の `Finset.prod_const_one` は使わない（この主張がそれに当たる）。
- 人手の「ℝ の乗法の単位元 `p·1 = p`（`set_and_algebra_notation`）」は mathlib の `mul_one` である。

必要十分版は `Ising2D/NecSuf/FiniteProductLeft.lean` の `finProdLeft_const_one'`、具体版をその系として導くのは
`ClaimFiniteProductOfRealOnesFromNecSuf.lean`。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `finite_product_of_real_ones`**: `Π_{j=1}^{m} 1 = 1`（人手の `m` は Lean の `m + 1`）。 -/
theorem finite_product_of_real_ones : ∀ m : ℕ, ∏ _j : Fin (m + 1), (1 : ℝ) = 1
  | 0 =>
    calc ∏ _j : Fin 1, (1 : ℝ)
        = 1 := Fin.prod_univ_one _                                            -- `def_finite_product_of_real_numbers` の `Π_{j=1}^{1} r_j := r_1`（`r_j → 1`）
  | m + 1 =>
    calc ∏ _j : Fin (m + 2), (1 : ℝ)
        = (∏ _j : Fin (m + 1), (1 : ℝ)) * 1 :=
          Fin.prod_univ_castSucc _                                            -- `def_finite_product_of_real_numbers` の帰納の式（`r_j → 1`）
      _ = 1 * 1 := by rw [finite_product_of_real_ones m]                      -- 帰納法の仮定
      _ = 1 := mul_one 1                                                      -- ℝ の乗法の単位元 `p·1 = p`（`p → 1`。`set_and_algebra_notation`）

end Ising2D
