/-
人手証明「開境界正方形の自由エネルギー密度」（`def_open_square_free_energy_density`）の具体版。

正の実数で評価した開境界正方形の分配多項式の実対数を有理数 `1 / L²` 倍するため ℝ に留まる。
周期境界の `freeEnergyDensity` と同じ形（有理数を ℝ へ移してから掛ける。実数の除法は使わない）で
定義し、正値性 `openPartitionValue_pos` で実対数の定義域へ入れる。完備性・極限は使わない。
-/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensity
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequality

namespace Ising2DLambda.ThermodynamicLimit

/-- `def_open_square_free_energy_density`。
`ψ^op_L(t) := ι(1/L²) · log_ℝ(Z^op_{L,L}(t))`。 -/
noncomputable def openSquareFreeEnergyDensity (L : PositiveNatural)
    (t : StrictlyPositiveReal) : ℝ :=
  (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ) *
    realLogarithm ⟨openPartitionValue L.1 L.1 t.1, openPartitionValue_pos L.1 L.1 t.2⟩)

end Ising2DLambda.ThermodynamicLimit
