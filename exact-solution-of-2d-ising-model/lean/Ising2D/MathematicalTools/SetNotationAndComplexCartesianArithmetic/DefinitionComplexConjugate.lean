/-
# 複素共役（具体版）

正本: `structured-latex/content/005_exp_conjugation_proof.ts`
- `exp_conjugation_definition_complex_conjugate_and_real_part`（ラベル **`def_complex_conjugate`**）

## 人手の定義との対応

| 人手 | Lean |
| --- | --- |
| `def_complex_conjugate` の `\overline{(x,y)} := (x,-y)` | `complex_star_mk`（`rfl`） |

人手の `(x, y) ∈ 𝐂 = 𝐑²` は Lean の `⟨x, y⟩ : ℂ` である（`DefinitionComplexNumbers.lean`）。
mathlib の `ℂ` の `star` は `star z := ⟨z.re, -z.im⟩` と定義されており、人手の `\overline{(x,y)} := (x,-y)` と定義として等しい。
そこで Lean の `star`（`ℂ` の上のもの）をそのまま人手の複素共役として使う。式の `-y` は `ℝ` の符号反転である。

具体版の定義と主張は、共役を `star z` で書く。mathlib の `conj z`（環の準同型 `starRingEnd ℂ` を `z` に当てる形）では書かない。
環の準同型は本文に定義が無いからである。証明の中で `conj` の形の mathlib の補題を使う段は、`starRingEnd_apply`（`rfl`）で行き来する。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **`def_complex_conjugate`**: `\overline{(x, y)} = (x, -y)`（`x, y ∈ ℝ`）。 -/
theorem complex_star_mk (x y : ℝ) : star (⟨x, y⟩ : ℂ) = ⟨x, -y⟩ := rfl

end Ising2D
