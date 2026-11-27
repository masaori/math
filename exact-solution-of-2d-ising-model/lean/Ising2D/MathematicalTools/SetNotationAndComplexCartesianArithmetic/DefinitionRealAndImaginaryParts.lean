/-
# ℂ の実部（具体版）

正本: `structured-latex/content/000_calculation_formulae_10_19.ts`
（`calc_formulae_010_definition_real_imag_parts_of_cc`、ラベル **`def_real_imag_parts`**）

## 人手の定義との対応

| 人手 | Lean |
| --- | --- |
| `def_real_imag_parts` の `Re : ℂ → ℝ, (x, y) ↦ x` | `complex_re_mk`（`rfl`） |

人手の `(x, y) ∈ ℂ = ℝ²` は Lean の `⟨x, y⟩ : ℂ` である（`DefinitionComplexNumbers.lean`）。
mathlib の `Complex.re` は構造体 `ℂ` の第 1 成分を取る射影であり、人手の `Re((x, y)) := x` と定義として等しい。
そこで Lean の `Complex.re` をそのまま人手の実部として使う。

人手は同じブロックで虚部 `Im : (x, y) ↦ y` も定めるが、具体版の定義と主張に虚部 `Complex.im` は出ないので、
虚部の具体版は置かない。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **`def_real_imag_parts`**: `Re((x, y)) = x`（`x, y ∈ ℝ`）。 -/
theorem complex_re_mk (x y : ℝ) : (⟨x, y⟩ : ℂ).re = x := rfl

end Ising2D
