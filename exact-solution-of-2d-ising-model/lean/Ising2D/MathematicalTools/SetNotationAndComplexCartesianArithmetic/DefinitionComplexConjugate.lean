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

Lean の `starRingEnd ℂ` を `z` に当てた `(starRingEnd ℂ) z` も、定義を開くと `star z` になる（mathlib の `starRingEnd_apply` は `rfl`）。
`(starRingEnd ℂ) z` は環の準同型を関数として当てる形で、環の準同型は本文に定義が無いので、許可の一覧には `star` だけを載せる。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **`def_complex_conjugate`**: `\overline{(x, y)} = (x, -y)`（`x, y ∈ ℝ`）。 -/
theorem complex_star_mk (x y : ℝ) : star (⟨x, y⟩ : ℂ) = ⟨x, -y⟩ := rfl

end Ising2D
