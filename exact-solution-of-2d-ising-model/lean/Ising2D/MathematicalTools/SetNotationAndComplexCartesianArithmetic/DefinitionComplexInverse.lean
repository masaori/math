/-
# 0 でない複素数の逆数（具体版）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calc_formulae_definition_complex_inverse`、ラベル **`def_complex_inverse`**）

人手は `z ∈ ℂ^×`（`z ≠ 0_ℂ`）について、逆数 `z^{-1} ∈ ℂ^×` を `z w = 1_ℂ` かつ `w z = 1_ℂ` を満たす `w ∈ ℂ^×` と定める
（存在と一意性は `multiplicative_group_of_cc`）。

Lean の `⁻¹` は `0` でも値を持つ（`0⁻¹ = 0`）全域の写像で、人手の写像はその `ℂ∖{0}` への制限に当たる。
`z ≠ 0` のとき Lean の `z⁻¹` が定義の二つの式を満たすことを次の二本で述べる（仮定に人手の定義域 `z ≠ 0` を置く）。
Lean の `z⁻¹` は `z z⁻¹ = 1 ≠ 0` から `0` でない（`ℂ^×` の元である）。二つの式を満たす `ℂ^×` の元は一つしかないので、
Lean の `z⁻¹` は人手の `z^{-1}` と一致する。

- `complex_mul_inv_cancel`: `z z^{-1} = 1_ℂ`（mathlib の `mul_inv_cancel₀`）。
- `complex_inv_mul_cancel`: `z^{-1} z = 1_ℂ`（mathlib の `inv_mul_cancel₀`）。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **`def_complex_inverse`**: `z ≠ 0` のとき `z z^{-1} = 1_ℂ`（`z ∈ ℂ`）。 -/
theorem complex_mul_inv_cancel (z : ℂ) (hz : z ≠ 0) : z * z⁻¹ = 1 := mul_inv_cancel₀ hz

/-- **`def_complex_inverse`**: `z ≠ 0` のとき `z^{-1} z = 1_ℂ`（`z ∈ ℂ`）。 -/
theorem complex_inv_mul_cancel (z : ℂ) (hz : z ≠ 0) : z⁻¹ * z = 1 := inv_mul_cancel₀ hz

end Ising2D
