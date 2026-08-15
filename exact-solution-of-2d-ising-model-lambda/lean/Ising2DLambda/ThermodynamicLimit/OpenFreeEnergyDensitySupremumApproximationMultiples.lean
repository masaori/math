/-
人手証明「倍数の辺での上限への任意近接（1 ≤ t の場合）」の具体版。

u - ε < u、u - ε が上界でないこと、反例から一辺 a を取ること、
1 ≤ t のブロック敷き詰め評価の対数化による ψ_a ≤ ψ_{ka}、
u が上界であることによる ψ_{ka} ≤ u を同じ順で辿る。
-/
import Ising2DLambda.ThermodynamicLimit.OpenFreeEnergyDensitySupremum
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingLogarithm
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensitySupremumApproximation

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_open_free_energy_density_supremum_approximation_multiples_one_le` の具体版。 -/
theorem openFreeEnergyDensity_supremum_approximation_multiples_of_one_le
    (t : StrictlyPositiveReal) (ht : 1 ≤ t.1) (u eps : ℝ)
    (hu : IsRealSetSupremum (openFreeEnergyDensityValueSet t) u)
    (heps : 0 < eps) :
    ∃ a : PositiveNatural, ∀ k : PositiveNatural,
      u - eps < openSquareFreeEnergyDensity (squareSide a k) t ∧
        openSquareFreeEnergyDensity (squareSide a k) t ≤ u := by
  -- 準備: u - ε < u（順序と加法の両立）
  have hlower_lt_u : u - eps < u := sub_lt_self u heps
  -- 第一段: u - ε は上界ではない
  have hlower_not_upper :
      ¬IsRealSetUpperBound (openFreeEnergyDensityValueSet t) (u - eps) := by
    intro hlower_upper
    have hu_le_lower : u ≤ u - eps := hu.2 (u - eps) hlower_upper
    exact (not_le_of_gt hlower_lt_u) hu_le_lower
  -- 反例 y と、それを与える一辺 a
  have hexample :
      ∃ y : ℝ, y ∈ openFreeEnergyDensityValueSet t ∧ ¬y ≤ u - eps := by
    by_contra hno_example
    push_neg at hno_example
    apply hlower_not_upper
    intro y hy
    exact hno_example y hy
  obtain ⟨y, hy, hy_not_le⟩ := hexample
  have hlower_lt_y : u - eps < y := lt_of_not_ge hy_not_le
  rcases hy with ⟨a, rfl⟩
  refine ⟨a, fun k => ⟨?_, ?_⟩⟩
  -- 第二段: u - ε < ψ_a ≤ ψ_{ka}（1 ≤ t のブロック敷き詰め評価の対数化の第一の不等式）
  · exact lt_of_lt_of_le hlower_lt_y
      (openSquareFreeEnergyDensity_blockTiling_bounds_of_one_le a k t ht).1
  -- 第三段: ψ_{ka} ∈ Ψ^op_t なので上界 u で抑えられる
  · exact hu.1 _ ⟨squareSide a k, rfl⟩

end Ising2DLambda.ThermodynamicLimit
