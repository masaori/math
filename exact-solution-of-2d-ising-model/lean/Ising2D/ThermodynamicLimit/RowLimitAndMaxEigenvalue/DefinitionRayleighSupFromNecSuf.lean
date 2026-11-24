/-
# `𝓡`・`c(M) := sup 𝓡`（必要十分版からの導出）

具体版 `DefinitionRayleighSup.lean` の `Ising2D.rayleighSet`・`rayleighSup`（人手 `def_rayleigh_sup`）と、必要十分版
`Ising2D/NecSuf/RayleighSupAndSectorRayleighSup.lean` の `NecSuf.rayleighSet'`・`rayleighSup'` は、同じ式で定義した同じ集合・同じ値である
（ノルムの一致は `RealMatrixBilinearFormAndNormFromNecSuf.lean` の `vecNorm_eq_vecNorm_necSuf`）。
必要十分版の主張から具体版を導くときは、この一致で具体版の `rayleighSup` へ読み替える。

必要十分版の側で係数を上げた補題（`NecSuf.quad_smul'`（可換半環）、上界の 6 行・2 行・4 行の `NecSuf.abs_bilinear_term_le_abs_entry'`・
`abs_bilinear_row_of_unit_components_le_row_abs_sum'`・`bilinear_le_abs_entry_sum'`（順序環））は、係数を `ℝ` にすると具体版の
`quad_smul`・`abs_bilinear_term_le_abs_entry`・`abs_bilinear_row_le_row_abs_sum`・`bilinear_le_abs_entry_sum` と同じ主張になる
（下の `*_of_necSuf`。具体版のファイルはこれを import せず、人手の鎖と 1 対 1 の自前の証明を持つ）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.DefinitionRayleighSup
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNormFromNecSuf
import Ising2D.NecSuf.RayleighSupAndSectorRayleighSup

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

/-- 具体版の `𝓡` は、必要十分版の `𝓡` と一致する（同じ式の定義）。 -/
theorem rayleighSet_eq_rayleighSet_necSuf (W : Matrix n n ℝ) : rayleighSet W = NecSuf.rayleighSet' W :=
  rfl

/-- 具体版の `c(M) = sup 𝓡` は、必要十分版の `sup 𝓡` と一致する（同じ式の定義）。 -/
theorem rayleighSup_eq_rayleighSup_necSuf (W : Matrix n n ℝ) : rayleighSup W = NecSuf.rayleighSup' W :=
  rfl

/-- 具体版 `quad_smul` は、必要十分版 `NecSuf.quad_smul'` の係数を `ℝ` にしたもの。 -/
theorem quad_smul_of_necSuf (A : Matrix n n ℝ) (c : ℝ) (x : n → ℝ) :
    (c • x) ⬝ᵥ A *ᵥ (c • x) = c ^ 2 * (x ⬝ᵥ A *ᵥ x) :=
  NecSuf.quad_smul' A c x

/-- 具体版 `abs_bilinear_term_le_abs_entry` は、必要十分版 `NecSuf.abs_bilinear_term_le_abs_entry'` の係数を `ℝ` にしたもの。 -/
theorem abs_bilinear_term_le_abs_entry_of_necSuf (W : Matrix n n ℝ) (x : n → ℝ) (hx : ∀ k, |x k| ≤ 1) (i j : n) :
    |x i * W i j * x j| ≤ |W i j| :=
  NecSuf.abs_bilinear_term_le_abs_entry' W x hx i j

/-- 具体版 `abs_bilinear_row_le_row_abs_sum` は、必要十分版 `NecSuf.abs_bilinear_row_of_unit_components_le_row_abs_sum'` の係数を `ℝ` にしたもの。 -/
theorem abs_bilinear_row_le_row_abs_sum_of_necSuf (W : Matrix n n ℝ) (x : n → ℝ) (hx : ∀ k, |x k| ≤ 1) (i : n) :
    |∑ j, x i * W i j * x j| ≤ ∑ j, |W i j| :=
  NecSuf.abs_bilinear_row_of_unit_components_le_row_abs_sum' W x hx i

/-- 具体版 `bilinear_le_abs_entry_sum` は、必要十分版 `NecSuf.bilinear_le_abs_entry_sum'` の係数を `ℝ` にしたもの。 -/
theorem bilinear_le_abs_entry_sum_of_necSuf (W : Matrix n n ℝ) (x : n → ℝ) (hx : ∀ k, |x k| ≤ 1) :
    x ⬝ᵥ W *ᵥ x ≤ ∑ i, ∑ j, |W i j| :=
  NecSuf.bilinear_le_abs_entry_sum' W x hx

end Ising2D
