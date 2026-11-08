/-
# 1 の平方根は 1（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_sqrt_of_real_one_is_one`、ラベル **`sqrt_of_real_one_is_one`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `1^2 = 1` の 1 行（`power_of_real_one_is_one`（`m → 2`）） | `h1` |
| `definition_of_sqrt_r_positive`（`x → 1`）の `y → 1` が `1 ≥ 0` と `1^2 = 1` を満たし、そのような `y` はただ一つ | `Real.sqrt_eq_iff_eq_sq` に `1 ≥ 0`（2 か所）と `h1` を渡す段 |

- 人手の `√·^{(ℝ_{≥0})}`（`definition_of_sqrt_r_positive`）は Lean の `Real.sqrt` である。
  「`y ≥ 0 ∧ y^2 = x` を満たす `y` はただ一つで、それが `√x`」は、`x ≥ 0`・`y ≥ 0` のとき `√x = y ↔ x = y^2` を述べる
  `Real.sqrt_eq_iff_eq_sq` で読む。mathlib の `Real.sqrt_one` は使わない。
- 人手の二乗は `def_power_of_real_number` の冪で、Lean の `^ 2`（`Monoid.npow`）である。

必要十分版は置かない。主張は `ℝ_{≥0}` の上の特定の写像 `√·`（`definition_of_sqrt_r_positive`）の具体値についての主張であり、
抽象度を上げる対象の構造を持たない（`ClaimVPlusRealEntries.lean` と同じ扱い）。使うのは `√1` が定義の条件
`y ≥ 0 ∧ y^2 = 1` を満たすことと、その条件を満たす `y` の一意性で、`sqrt_nonnegative_existence_uniqueness` の存在の構成
（上限性質）の中身には立ち入らない。`1^2 = 1` の必要十分版は `Ising2D/NecSuf/PowerOfOneIsOne.lean` にある。
-/
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimPowerOfRealOneIsOne

namespace Ising2D

/-- **人手 `sqrt_of_real_one_is_one`**: `√1 = 1`。 -/
theorem sqrt_of_real_one_is_one : Real.sqrt 1 = 1 := by
  have h1 : (1 : ℝ) ^ 2 = 1 := power_of_real_one_is_one 2                    -- `power_of_real_one_is_one`（`m → 2`）
  exact (Real.sqrt_eq_iff_eq_sq zero_le_one zero_le_one).mpr h1.symm         -- `definition_of_sqrt_r_positive`（`x → 1`）の `y → 1` が `1 ≥ 0` と `1^2 = 1` を満たし、そのような `y` はただ一つ

end Ising2D
