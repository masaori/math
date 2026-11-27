/-
# ℕ から ℂ への包含写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_inclusion_nn_to_cc`、ラベル **`inclusion_nn_to_cc`**）

人手は `ι_{ℕ→ℂ} : ℕ → ℂ` を、名前の付いた三つの写像の合成 `ι_{ℕ→ℂ}(n) := (ι_{ℤ→ℝ}(ι_{ℕ→ℤ}(n)))_ℂ` と定める
（`inclusion_nn_to_zz`・`inclusion_zz_to_rr`・`inclusion_rr_to_cc`）。具体版 `inclusionNNtoCC` も同じ合成で定める。

Lean の ℕ から ℂ への写像 `Nat.cast` との一致は、補題一本 `inclusionNNtoCC_eq_natCast` で示す。
ほかの具体版は ℕ の元を ℂ へ送るのに `Nat.cast` を使っているので、人手の `ι_{ℕ→ℂ}` を引く段はこの補題を通して
`Nat.cast` の形へ移す。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionInclusionOfNaturalNumbersIntoIntegers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionInclusionOfIntegersIntoRealNumbers

namespace Ising2D

/-- **`inclusion_nn_to_cc`**: `ι_{ℕ→ℂ}(n) := (ι_{ℤ→ℝ}(ι_{ℕ→ℤ}(n)))_ℂ`。 -/
noncomputable def inclusionNNtoCC (n : ℕ) : ℂ :=
  ((inclusionZZtoRR (inclusionNNtoZZ n) : ℝ) : ℂ)

/-- **`inclusion_nn_to_cc`**: 具体版 `inclusionNNtoCC` は Lean の `Nat.cast`（ℕ → ℂ）と一致する。
合成の三つの写像を、それぞれの一致の補題で Lean の写像へ移す。 -/
theorem inclusionNNtoCC_eq_natCast (n : ℕ) : inclusionNNtoCC n = (n : ℂ) :=
  calc inclusionNNtoCC n = ((inclusionZZtoRR (inclusionNNtoZZ n) : ℝ) : ℂ) := rfl
                                                          -- `ι_{ℕ→ℂ}` の定義
    _ = ((inclusionZZtoRR (n : ℤ) : ℝ) : ℂ) := by rw [inclusionNNtoZZ_eq_natCast]
                                                          -- `ι_{ℕ→ℤ}` と `Nat.cast`（ℕ → ℤ）の一致
    _ = (((n : ℤ) : ℝ) : ℂ) := by rw [inclusionZZtoRR_eq_intCast]
                                                          -- `ι_{ℤ→ℝ}` と `Int.cast`（ℤ → ℝ）の一致
    _ = ((n : ℝ) : ℂ) := by rw [Int.cast_natCast]         -- Lean の `Int.cast` の `Nat.cast n` の値
    _ = (n : ℂ) := Complex.ofReal_natCast n               -- Lean の `Nat.cast`（ℕ → ℂ）は `(Nat.cast n : ℝ)` の `Complex.ofReal` の像

end Ising2D
