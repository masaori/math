/-
# 実数の商と、0 でない実数の乗法の逆元（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_real_quotient`、ラベル **`def_real_quotient`**）

人手は `y, z ∈ ℝ`、`z ≠ 0_ℝ` について商を `y/z := y z^{-1}` と定める。`z^{-1}` は `set_and_algebra_notation` が
外から持ち込んだ逆数 `(·)^{-1}_ℝ : ℝ∖{0_ℝ} → ℝ` の値で、`z ≠ 0_ℝ ⇒ (z z^{-1} = 1_ℝ かつ z^{-1} z = 1_ℝ)` を満たす。

Lean の `⁻¹` と `/` は `0` でも値を持つ（`0⁻¹ = 0`）全域の写像で、人手の写像はその `ℝ∖{0}` への制限に当たる。
人手が使うのは `z ≠ 0` の値だけなので、Lean の `⁻¹`・`/` を人手の `(·)^{-1}_ℝ`・商として使い、
`z ≠ 0` での一致を次の二本で述べる（どちらも仮定に人手の定義域 `z ≠ 0` を置く）。

- `real_div_eq_mul_inv`: 商の定義の式 `y/z = y z^{-1}`。Lean の `/` は `y * z⁻¹` と定義として等しいので、仮定は使わない。
- `real_mul_inv_cancel`: 逆元の式 `z z^{-1} = 1_ℝ`（mathlib の `mul_inv_cancel₀`）。人手の証明が `def_real_quotient` の乗法の逆元として引く段で使う。
  逆の向き `z^{-1} z = 1_ℝ` と、`set_and_algebra_notation` の逆元の式を直接引く段は、まだ mathlib の `inv_mul_cancel₀`・`mul_inv_cancel₀` で読んでいる。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`def_real_quotient`**: `z ≠ 0` のとき `y/z = y z^{-1}`（`y, z ∈ ℝ`）。仮定は人手の商の定義域で、Lean の証明は使わない。 -/
theorem real_div_eq_mul_inv (y z : ℝ) (_hz : z ≠ 0) : y / z = y * z⁻¹ := div_eq_mul_inv y z

/-- `def_real_quotient` の `z^{-1}`（`set_and_algebra_notation` の逆数）が満たす式: `z ≠ 0` のとき `z z^{-1} = 1`。 -/
theorem real_mul_inv_cancel (z : ℝ) (hz : z ≠ 0) : z * z⁻¹ = 1 := mul_inv_cancel₀ hz

end Ising2D
