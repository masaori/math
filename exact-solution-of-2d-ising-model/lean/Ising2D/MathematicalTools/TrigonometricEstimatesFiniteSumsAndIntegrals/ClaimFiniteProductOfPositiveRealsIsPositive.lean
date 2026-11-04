/-
# 正の実数の有限積は正（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_finite_product_of_positive_reals_is_positive`、ラベル **`finite_product_of_positive_reals_is_positive`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 2 行（`def_finite_product_of_real_numbers` → 仮定 `r_1 > 0`） | `finite_product_of_positive_reals_is_positive` の `0` の節の `calc` の 2 段 |
| `m → m+1` の前置き（帰納法の仮定で `Π_{j=1}^{m} r_j > 0`、仮定で `r_{m+1} > 0`） | `m + 1` の節の `hprod`・`hlast` |
| `m → m+1` の 2 行（`def_finite_product_of_real_numbers` → ℝ で `a > 0, b > 0` なら `ab > 0`） | `m + 1` の節の `calc` の 2 段 |

- 人手の `r_1, …, r_m`（`m ≥ 1`）は Lean の `r : Fin (m + 1) → ℝ` である（人手の `m` は Lean の `m + 1`。添字は 0 始まりで、人手の `j` は `j - 1`）。
- 人手の有限積（`def_finite_product_of_real_numbers`）は Lean の `∏ j, r j`（`Finset.prod`）で、定義の 2 つの式は
  `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む（`ClaimRealExpOfFiniteSum.lean` と同じ）。
- 人手の「ℝ で `a > 0, b > 0` なら `ab > 0`」は mathlib の `mul_pos`（順序体の規則の 1 つ）である。mathlib の `Finset.prod_pos` は使わない。

必要十分版は `Ising2D/NecSuf/FiniteProductOfPositiveElementsIsPositive.lean`、具体版をその系として導くのは
`ClaimFiniteProductOfPositiveRealsIsPositiveFromNecSuf.lean`。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.Ring.Defs
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `finite_product_of_positive_reals_is_positive`**: すべての `j` で `r_j > 0` なら `Π_{j=1}^{m} r_j > 0`
（人手の `m` は Lean の `m + 1`）。 -/
theorem finite_product_of_positive_reals_is_positive :
    ∀ (m : ℕ) (r : Fin (m + 1) → ℝ), (∀ j, 0 < r j) → ∏ j, r j > 0
  | 0, r, hr =>
    calc ∏ j, r j
        = r 0 := Fin.prod_univ_one r                                          -- `def_finite_product_of_real_numbers`
      _ > 0 := hr 0                                                           -- 仮定 `r_1 > 0`
  | m + 1, r, hr =>
    have hprod : ∏ j : Fin (m + 1), r (Fin.castSucc j) > 0 :=
      finite_product_of_positive_reals_is_positive m (fun j => r (Fin.castSucc j)) (fun j => hr _)
                                                                              -- 帰納法の仮定（`r_1, …, r_m` に当てる）
    have hlast : r (Fin.last (m + 1)) > 0 := hr _                             -- 仮定 `r_{m+1} > 0`
    calc ∏ j, r j
        = (∏ j : Fin (m + 1), r (Fin.castSucc j)) * r (Fin.last (m + 1)) :=
          Fin.prod_univ_castSucc r                                            -- `def_finite_product_of_real_numbers`
      _ > 0 := mul_pos hprod hlast                                            -- ℝ で `a > 0, b > 0` なら `ab > 0`
                                                                              -- （`a → Π_{j=1}^{m} r_j`、`b → r_{m+1}`）

end Ising2D
