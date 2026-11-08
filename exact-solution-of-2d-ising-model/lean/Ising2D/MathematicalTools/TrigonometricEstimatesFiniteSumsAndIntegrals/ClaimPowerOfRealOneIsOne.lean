/-
# 実数の 1 の冪は 1（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_power_of_real_one_is_one`、ラベル **`power_of_real_one_is_one`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 0` の 1 行（`a^0 := 1`） | `power_of_real_one_is_one` の `0` の節 |
| `m → m+1` の 3 行（`a^{m+1} := a^m a` → 帰納法の仮定 → `1` は乗法の単位元） | `m + 1` の節の `calc` の 3 段 |

- 人手の `m ∈ ℤ_{≥0}` は Lean の `m : ℕ` である。
- 人手の冪（`def_power_of_real_number`）は mathlib の `a ^ m`（`Monoid.npow`）で、定義の 2 つの式は `pow_zero`・`pow_succ` で読む。
  mathlib の `one_pow` は使わない。

必要十分版は `Ising2D/NecSuf/PowerOfOneIsOne.lean`、具体版をその系として導くのは
`ClaimPowerOfRealOneIsOneFromNecSuf.lean`。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `power_of_real_one_is_one`**: `1^m = 1`（`m` についての帰納法）。 -/
theorem power_of_real_one_is_one : ∀ m : ℕ, (1 : ℝ) ^ m = 1
  | 0 => pow_zero 1                                                           -- `a^0 := 1`（`a → 1`）
  | m + 1 =>
    calc (1 : ℝ) ^ (m + 1)
        = 1 ^ m * 1 := pow_succ 1 m                                           -- `a^{m+1} := a^m a`（`a → 1`）
      _ = 1 * 1 := by rw [power_of_real_one_is_one m]                         -- 帰納法の仮定
      _ = 1 := one_mul 1                                                      -- `1` は ℝ の乗法の単位元

end Ising2D
