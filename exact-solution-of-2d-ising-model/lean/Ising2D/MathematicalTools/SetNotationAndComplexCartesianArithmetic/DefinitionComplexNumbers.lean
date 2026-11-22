/-
# `ℂ` の定義・虚数単位・`ℝ → ℂ` の包含写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
- `calc_formulae_006_definition_of_cc`（ラベル **`definition_of_cc`**）
- `calc_formulae_definition_imaginary_unit`（ラベル **`def_imaginary_unit`**）
- `calc_formulae_007_inclusion_rr_to_cc`（ラベル **`inclusion_rr_to_cc`**）

## 人手の定義との対応

人手は `𝐂 := 𝐑²` を台集合とし、和 `(a,b) +_ℂ (c,d) := (a + c, b + d)` と積 `(a,b) ·_ℂ (c,d) := (ac − bd, ad + bc)` を入れる。
Lean の `ℂ` は実部と虚部の二つの `ℝ` を欄に持つ構造体で、人手の `(a, b) ∈ 𝐑²` は構成子 `⟨a, b⟩ : ℂ` である。

| 人手 | Lean |
| --- | --- |
| `𝐂 = 𝐑²` の二つの元が等しいのは、第 1 成分どうしと第 2 成分どうしが等しいとき | `complex_mk_eq_mk_iff` |
| `definition_of_cc` の和 | `complex_mk_add_mk`（mathlib の `ℂ` の和の定義の式そのもので `rfl`） |
| `definition_of_cc` の積 | `complex_mk_mul_mk`（mathlib の `ℂ` の積の定義の式そのもので `rfl`） |
| `def_imaginary_unit` の `i := (0_ℝ, 1_ℝ)` | `complex_I_eq_mk`（`rfl`） |
| `inclusion_rr_to_cc` の `ι_{ℝ→ℂ}(x) := (x, 0)` | `complex_ofReal_eq_mk`（`rfl`。人手の `r_ℂ` は Lean の `(r : ℂ)`） |
| `inclusion_rr_to_cc` の略記の `0_ℂ := (0_ℝ)_ℂ`・`1_ℂ := (1_ℝ)_ℂ` | `complex_zero_eq_ofReal_zero`・`complex_one_eq_ofReal_one`（`rfl`） |

和と積と `i` と `ι_{ℝ→ℂ}` は、mathlib の定義が人手の定義の式と定義として等しいので、Lean の `+`・`*`・`Complex.I`・`Complex.ofReal` を
そのまま人手の記号として使う。Lean の `ℂ` の `0`・`1` も mathlib で `((0 : ℝ) : ℂ)`・`((1 : ℝ) : ℂ)` と定義されており、
人手の `0_ℂ`・`1_ℂ` と定義として等しい。積の第 1 成分の差 `ac − bd` は `def_real_difference` の `ℝ` の差である。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **`definition_of_cc`** の台集合 `𝐂 = 𝐑²`: 二つの元 `(a, b)`・`(c, d)` が等しいのは、`a = c` かつ `b = d` のときである
（直積の元の等号は成分ごとに見る規則は `set_and_algebra_notation`）。 -/
theorem complex_mk_eq_mk_iff (a b c d : ℝ) : (⟨a, b⟩ : ℂ) = ⟨c, d⟩ ↔ a = c ∧ b = d :=
  ⟨fun h => ⟨congrArg Complex.re h, congrArg Complex.im h⟩, fun h => h.1 ▸ h.2 ▸ rfl⟩

/-- **`definition_of_cc`** の和: `(a, b) +_ℂ (c, d) = (a + c, b + d)`。 -/
theorem complex_mk_add_mk (a b c d : ℝ) : (⟨a, b⟩ : ℂ) + ⟨c, d⟩ = ⟨a + c, b + d⟩ := rfl

/-- **`definition_of_cc`** の積: `(a, b) ·_ℂ (c, d) = (a c − b d, a d + b c)`。 -/
theorem complex_mk_mul_mk (a b c d : ℝ) :
    (⟨a, b⟩ : ℂ) * ⟨c, d⟩ = ⟨a * c - b * d, a * d + b * c⟩ := rfl

/-- **`def_imaginary_unit`**: `i = (0_ℝ, 1_ℝ)`。 -/
theorem complex_I_eq_mk : Complex.I = ⟨0, 1⟩ := rfl

/-- **`inclusion_rr_to_cc`**: `ι_{ℝ→ℂ}(x) = (x, 0)`。 -/
theorem complex_ofReal_eq_mk (x : ℝ) : (x : ℂ) = ⟨x, 0⟩ := rfl

/-- **`inclusion_rr_to_cc`** の略記の `0_ℂ := (0_ℝ)_ℂ`。 -/
theorem complex_zero_eq_ofReal_zero : (0 : ℂ) = ((0 : ℝ) : ℂ) := rfl

/-- **`inclusion_rr_to_cc`** の略記の `1_ℂ := (1_ℝ)_ℂ`。 -/
theorem complex_one_eq_ofReal_one : (1 : ℂ) = ((1 : ℝ) : ℂ) := rfl

end Ising2D
