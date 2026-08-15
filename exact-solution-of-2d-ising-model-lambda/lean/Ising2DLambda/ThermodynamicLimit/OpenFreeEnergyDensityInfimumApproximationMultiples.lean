/-
人手証明「倍数の辺での下限への任意近接（0 < t ≤ 1 の場合）」の具体版。

v < v + ε、v + ε が下界でないこと、反例から一辺 a を取ること、
0 < t ≤ 1 のブロック敷き詰め評価の対数化による ψ_{ka} ≤ ψ_a、
v が下界であることによる v ≤ ψ_{ka} を同じ順で辿る。
-/
import Ising2DLambda.ThermodynamicLimit.OpenFreeEnergyDensityInfimum
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingLogarithm

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_open_free_energy_density_infimum_approximation_multiples_le_one` の具体版。 -/
theorem openFreeEnergyDensity_infimum_approximation_multiples_of_le_one
    (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) (v eps : ℝ)
    (hv : IsGLB (openFreeEnergyDensityValueSet t) v)
    (heps : 0 < eps) :
    ∃ a : PositiveNatural, ∀ k : PositiveNatural,
      v ≤ openSquareFreeEnergyDensity (squareSide a k) t ∧
        openSquareFreeEnergyDensity (squareSide a k) t < v + eps := by
  -- 準備: v < v + ε（順序と加法の両立）
  have hv_lt_upper : v < v + eps := lt_add_of_pos_right v heps
  -- 第一段: v + ε は下界ではない
  have hupper_not_lower :
      v + eps ∉ lowerBounds (openFreeEnergyDensityValueSet t) := by
    intro hupper_lower
    have hupper_le_v : v + eps ≤ v := hv.2 hupper_lower
    exact (not_le_of_gt hv_lt_upper) hupper_le_v
  -- 反例 y と、それを与える一辺 a
  have hexample :
      ∃ y : ℝ, y ∈ openFreeEnergyDensityValueSet t ∧ ¬v + eps ≤ y := by
    by_contra hno_example
    push_neg at hno_example
    apply hupper_not_lower
    intro y hy
    exact hno_example y hy
  obtain ⟨y, hy, hupper_not_le⟩ := hexample
  have hy_lt_upper : y < v + eps := lt_of_not_ge hupper_not_le
  rcases hy with ⟨a, rfl⟩
  refine ⟨a, fun k => ⟨?_, ?_⟩⟩
  -- 第二段: ψ_{ka} ∈ Ψ^op_t なので下界 v 以上である
  · exact hv.1 ⟨squareSide a k, rfl⟩
  -- 第三段: ψ_{ka} ≤ ψ_a < v + ε
  · exact lt_of_le_of_lt
      (openSquareFreeEnergyDensity_blockTiling_bounds_of_le_one a k t ht1).2
      hy_lt_upper

end Ising2DLambda.ThermodynamicLimit
