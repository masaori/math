/-
# 0 の平方根は 0（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_sqrt_of_real_zero_is_zero`、ラベル **`sqrt_of_real_zero_is_zero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `0^2 = 0·0`（`square_of_real_number_is_product`（`r → 0`）） | `h0` の `calc` の 1 段目 |
| `0·0 = 0`（ℝ で `0·x = 0` の `x → 0`） | `h0` の `calc` の 2 段目 |
| `definition_of_sqrt_r_positive`（`x → 0`）の `y → 0` が `0 ≥ 0` と `0^2 = 0` を満たし、そのような `y` はただ一つ | `Real.sqrt_eq_iff_eq_sq` に `0 ≥ 0`（2 か所）と `h0` を渡す段 |

- 人手の `√·^{(ℝ_{≥0})}`（`definition_of_sqrt_r_positive`）は Lean の `Real.sqrt` である。
  「`y ≥ 0 ∧ y^2 = x` を満たす `y` はただ一つで、それが `√x`」は、`x ≥ 0`・`y ≥ 0` のとき `√x = y ↔ x = y^2` を述べる
  `Real.sqrt_eq_iff_eq_sq` で読む（`ClaimSqrtOfRealOneIsOne.lean` と同じ）。mathlib の `Real.sqrt_zero` は使わない。
- 人手の二乗は `def_power_of_real_number` の冪で、Lean の `^ 2`（`Monoid.npow`）である。

必要十分版は置かない。主張は `ℝ_{≥0}` の上の特定の写像 `√·`（`definition_of_sqrt_r_positive`）の具体値についての主張であり、
抽象度を上げる対象の構造を持たない（`ClaimSqrtOfRealOneIsOne.lean` と同じ扱い）。`r^2 = r r` の必要十分版は
`Ising2D/NecSuf/SquareIsProduct.lean` にある。
-/
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct

namespace Ising2D

/-- **人手 `sqrt_of_real_zero_is_zero`**: `√0 = 0`。 -/
theorem sqrt_of_real_zero_is_zero : Real.sqrt 0 = 0 := by
  have h0 : (0 : ℝ) ^ 2 = 0 :=
    calc (0 : ℝ) ^ 2
        = 0 * 0 := square_of_real_number_is_product 0                        -- `square_of_real_number_is_product`（`r → 0`）
      _ = 0 := zero_mul 0                                                      -- ℝ で `0·x = 0`（`x → 0`）
  exact (Real.sqrt_eq_iff_eq_sq le_rfl le_rfl).mpr h0.symm                     -- `definition_of_sqrt_r_positive`（`x → 0`）の `y → 0` が `0 ≥ 0` と `0^2 = 0` を満たし、そのような `y` はただ一つ

end Ising2D
