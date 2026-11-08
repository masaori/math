/-
# 1 の冪は 1（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimPowerOfRealOneIsOne.lean`
（人手 `power_of_real_one_is_one`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimPowerOfRealOneIsOneFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `m = 0` の 1 段（`a^0 = 1`） | `one_pow'` の `0` の節 |
| `m → m + 1` の 3 段（`a^{m+1} = a^m a` → 帰納法の仮定 → `1·1 = 1`） | `one_pow'` の `m + 1` の節（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、冪の定義の 2 つの式と `1·1 = 1`（帰納法の段の 3 段目）だけである。
  積の結合則・可換則、和、順序は効いていない。
- `Monoid R` は mathlib の冪 `^`（`Monoid.npow`）と、その定義の式 `pow_zero`・`pow_succ` を使うためだけに要る
  （`FiniteProductOfConstantIsPower.lean` と同じ事情）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`power_of_real_one_is_one`** の必要十分版: `1^m = 1`。 -/
theorem one_pow' {R : Type*} [Monoid R] : ∀ m : ℕ, (1 : R) ^ m = 1
  | 0 => pow_zero 1                                                           -- `a^0 = 1`
  | m + 1 =>
    calc (1 : R) ^ (m + 1)
        = 1 ^ m * 1 := pow_succ 1 m                                           -- `a^{m+1} = a^m a`
      _ = 1 * 1 := by rw [one_pow' m]                                         -- 帰納法の仮定
      _ = 1 := one_mul 1                                                      -- `1·1 = 1`

end Ising2D.NecSuf
