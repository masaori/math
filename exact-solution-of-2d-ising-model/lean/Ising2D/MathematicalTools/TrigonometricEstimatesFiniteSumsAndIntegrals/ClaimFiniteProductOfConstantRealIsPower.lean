/-
# 実数の定数の有限積は冪に等しい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_finite_product_of_constant_real_is_power`、ラベル **`finite_product_of_constant_real_is_power`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 4 行（`def_finite_product_of_real_numbers` → `1` は乗法の単位元 → `a^0 := 1` → `a^{m+1} := a^m a`） | `finite_product_of_constant_real_is_power` の `0` の節の `calc` の 4 段 |
| `m → m+1` の 3 行（`def_finite_product_of_real_numbers` → 帰納法の仮定 → `a^{m+1} := a^m a`） | `m + 1` の節の `calc` の 3 段 |

- 人手の `m ≥ 1` は Lean の `m + 1` である（`ClaimFiniteProductOfPositiveRealsIsPositive.lean` と同じ）。
- 人手の有限積（`def_finite_product_of_real_numbers`、因子 `r_j → r`）は Lean の `∏ _j : Fin (m + 1), r`（`Finset.prod`）で、
  定義の 2 つの式は `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む。
- 人手の冪（`def_power_of_real_number`）は mathlib の `r ^ m`（`Monoid.npow`）で、定義の 2 つの式は `pow_zero`・`pow_succ` で読む。
  mathlib の `Finset.prod_const` は使わない。

必要十分版は `Ising2D/NecSuf/FiniteProductOfConstantIsPower.lean`、具体版をその系として導くのは
`ClaimFiniteProductOfConstantRealIsPowerFromNecSuf.lean`。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `finite_product_of_constant_real_is_power`**: `Π_{j=1}^{m} r = r^m`（人手の `m` は Lean の `m + 1`）。 -/
theorem finite_product_of_constant_real_is_power :
    ∀ (m : ℕ) (r : ℝ), ∏ _j : Fin (m + 1), r = r ^ (m + 1)
  | 0, r =>
    calc ∏ _j : Fin 1, r
        = r := Fin.prod_univ_one _                                            -- `def_finite_product_of_real_numbers`（`r_j → r`）
      _ = 1 * r := (one_mul r).symm                                           -- `1` は ℝ の乗法の単位元
      _ = r ^ 0 * r := by rw [pow_zero]                                       -- `a^0 := 1`（`a → r`）を右辺から左辺へ
      _ = r ^ (0 + 1) := (pow_succ r 0).symm                                  -- `a^{m+1} := a^m a`（`a → r`、`m → 0`）を右辺から左辺へ
  | m + 1, r =>
    calc ∏ _j : Fin (m + 2), r
        = (∏ _j : Fin (m + 1), r) * r := Fin.prod_univ_castSucc _             -- `def_finite_product_of_real_numbers`（`r_j → r`）
      _ = r ^ (m + 1) * r := by rw [finite_product_of_constant_real_is_power m r]
                                                                              -- 帰納法の仮定
      _ = r ^ (m + 1 + 1) := (pow_succ r (m + 1)).symm                        -- `a^{m+1} := a^m a`（`a → r`）を右辺から左辺へ

end Ising2D
