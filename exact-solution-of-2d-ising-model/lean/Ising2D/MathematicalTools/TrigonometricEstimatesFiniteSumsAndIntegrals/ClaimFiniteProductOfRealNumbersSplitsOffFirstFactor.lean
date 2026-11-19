/-
# 実数の有限積から先頭の因子を外へ出せる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_finite_product_of_real_numbers_splits_off_first_factor`、
ラベル **`finite_product_of_real_numbers_splits_off_first_factor`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 3 行（定義の `m → 1` の帰納の式 → 定義の `Π_{j=1}^{1} r_j := r_1` → 同じ式を `r_j → r_{j+1}` で右辺から左辺へ） | `finite_product_of_real_numbers_splits_off_first_factor` の `0` の節の `calc` の 3 段 |
| `m → m+1` の 4 行（定義の `m → m+1` の帰納の式 → 帰納法の仮定 → ℝ の乗法の結合律 → 定義の帰納の式を `r_j → r_{j+1}` で右辺から左辺へ） | `m + 1` の節の `calc` の 4 段 |

- 人手の `r_1, …, r_{m+1}`（`m ≥ 1`）は Lean の `r : Fin (m + 2) → ℝ` である（人手の `m` は Lean の `m + 1`。添字は 0 始まりで、
  人手の `r_j` は `r (j - 1)`、人手の `r_{j+1}`（人手の `j = 1, …, m`）は `r j.succ`（Lean の `j : Fin (m + 1)` は人手の `j − 1`。この `m` は Lean の `m`））。
- 人手の有限積（`def_finite_product_of_real_numbers`）は Lean の `∏ j, r j`（`Finset.prod`）で、定義の 2 つの式は
  `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む（`ClaimFiniteProductOfRealProducts.lean` と同じ）。
  先頭の因子を外へ出す mathlib の `Fin.prod_univ_succ` は使わない（この主張がそれに当たる）。
- 人手の「ℝ の乗法の結合律 `(xy)t = x(yt)`（`set_and_algebra_notation`）」は mathlib の `mul_assoc` である。乗法の可換律は使わない。

必要十分版は `Ising2D/NecSuf/FiniteProductLeftFirstFactor.lean`、具体版をその系として導くのは
`ClaimFiniteProductOfRealNumbersSplitsOffFirstFactorFromNecSuf.lean`。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `finite_product_of_real_numbers_splits_off_first_factor`**: `Π_{j=1}^{m+1} r_j = r_1(Π_{j=1}^{m} r_{j+1})`
（人手の `m` は Lean の `m + 1`）。 -/
theorem finite_product_of_real_numbers_splits_off_first_factor :
    ∀ (m : ℕ) (r : Fin (m + 2) → ℝ), ∏ j, r j = r 0 * ∏ j : Fin (m + 1), r j.succ
  | 0, r =>
    calc ∏ j, r j
        = (∏ j : Fin 1, r (Fin.castSucc j)) * r (Fin.last 1) :=
          Fin.prod_univ_castSucc _                                            -- `def_finite_product_of_real_numbers` の帰納の式（`m → 1`）
      _ = r 0 * r 1 := by rw [Fin.prod_univ_one]; rfl                         -- `def_finite_product_of_real_numbers` の `Π_{j=1}^{1} r_j := r_1`
      _ = r 0 * ∏ j : Fin 1, r j.succ := by rw [Fin.prod_univ_one]; rfl       -- 同じ式（`r_j → r_{j+1}`）を右辺から左辺へ
  | m + 1, r =>
    calc ∏ j, r j
        = (∏ j : Fin (m + 2), r (Fin.castSucc j)) * r (Fin.last (m + 2)) :=
          Fin.prod_univ_castSucc _                                            -- `def_finite_product_of_real_numbers` の帰納の式（`m → m+1`）
      _ = (r 0 * ∏ j : Fin (m + 1), r j.succ.castSucc) * r (Fin.last (m + 2)) := by
          rw [finite_product_of_real_numbers_splits_off_first_factor m (fun j => r (Fin.castSucc j))]
          rfl                                                                 -- 帰納法の仮定（`r_1, …, r_{m+1}` に当てる）
      _ = r 0 * ((∏ j : Fin (m + 1), r j.succ.castSucc) * r (Fin.last (m + 2))) :=
          mul_assoc _ _ _                                                     -- ℝ の乗法の結合律 `(xy)t = x(yt)`（`set_and_algebra_notation`）
      _ = r 0 * ∏ j : Fin (m + 2), r j.succ := by
          rw [Fin.prod_univ_castSucc (fun j : Fin (m + 2) => r j.succ)]
          rfl                                                                 -- `def_finite_product_of_real_numbers` の帰納の式（`r_j → r_{j+1}`）を右辺から左辺へ

end Ising2D
