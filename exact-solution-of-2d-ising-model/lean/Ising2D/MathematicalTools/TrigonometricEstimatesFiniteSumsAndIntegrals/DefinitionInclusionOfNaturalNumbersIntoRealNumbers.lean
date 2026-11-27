/-
# ℕ から ℝ への包含写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_inclusion_nn_to_rr`、ラベル **`inclusion_nn_to_rr`**）

人手は `ι_{ℕ→ℝ} : ℕ → ℝ` を、名前の付いた二つの写像の合成 `ι_{ℕ→ℝ}(n) := ι_{ℤ→ℝ}(ι_{ℕ→ℤ}(n))` と定める
（`inclusion_nn_to_zz`・`inclusion_zz_to_rr`）。具体版 `inclusionNNtoRR` も同じ合成で定める。

Lean の ℕ から ℝ への写像 `Nat.cast` との一致は、補題一本 `inclusionNNtoRR_eq_natCast` で示す。
ほかの具体版は ℕ の元を ℝ へ送るのに `Nat.cast` を使っているので、人手の `ι_{ℕ→ℝ}` を引く段はこの補題を通して
`Nat.cast` の形へ移す。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionInclusionOfNaturalNumbersIntoIntegers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionInclusionOfIntegersIntoRealNumbers

namespace Ising2D

/-- **`inclusion_nn_to_rr`**: `ι_{ℕ→ℝ}(n) := ι_{ℤ→ℝ}(ι_{ℕ→ℤ}(n))`。 -/
noncomputable def inclusionNNtoRR (n : ℕ) : ℝ :=
  inclusionZZtoRR (inclusionNNtoZZ n)

/-- **`inclusion_nn_to_rr`**: 具体版 `inclusionNNtoRR` は Lean の `Nat.cast`（ℕ → ℝ）と一致する。
合成の二つの写像を、それぞれの一致の補題で Lean の写像へ移す。 -/
theorem inclusionNNtoRR_eq_natCast (n : ℕ) : inclusionNNtoRR n = (n : ℝ) :=
  calc inclusionNNtoRR n = inclusionZZtoRR (inclusionNNtoZZ n) := rfl
                                                          -- `ι_{ℕ→ℝ}` の定義
    _ = inclusionZZtoRR (n : ℤ) := by rw [inclusionNNtoZZ_eq_natCast]
                                                          -- `ι_{ℕ→ℤ}` と `Nat.cast`（ℕ → ℤ）の一致
    _ = ((n : ℤ) : ℝ) := inclusionZZtoRR_eq_intCast (n : ℤ)
                                                          -- `ι_{ℤ→ℝ}` と `Int.cast`（ℤ → ℝ）の一致
    _ = (n : ℝ) := Int.cast_natCast n                     -- Lean の `Int.cast` の `Nat.cast n` の値

end Ising2D
