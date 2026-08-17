/-
「周期境界の密度の下組は開境界正方形の密度の下組に含まれる（q は 1 以下）」の具体版を、
必要十分版 `lowerSetOfSequence_subset_of_pointwise_le_necSuf` の特殊化として導く。
渡すのは推移律（`rationalLogOrderLE_trans`）と、`L ≥ 1` での項ごとの比較
`Ψ_L(q) ≤ Ψ^op_L(q)`（`rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one` の右）だけである。
具体版の二つの下組は必要十分版の下組と `rfl` で一致する。
-/
import Ising2DLambda.ThermodynamicLimit.PeriodicDensityLowerSet
import Ising2DLambda.NecSuf.ThermodynamicLimit.PeriodicDensityLowerSetSubsetOpenSquare

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem periodicDensityLowerSet_subset_openSquareDensityLowerSet_of_le_one_from_necSuf
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    periodicDensityLowerSet q ⊆ openSquareDensityLowerSet q := by
  show NecSuf.ThermodynamicLimit.lowerSetOfSequence rationalLogOrderLE (periodicDensitySequence q) ⊆
    NecSuf.ThermodynamicLimit.lowerSetOfSequence rationalLogOrderLE (openSquareDensitySequence q)
  refine NecSuf.ThermodynamicLimit.lowerSetOfSequence_subset_of_pointwise_le_necSuf rationalLogOrderLE
    (fun hxy hyz => rationalLogOrderLE_trans hxy hyz) _ _ ?_
  intro L hL
  haveI : NeZero L := ⟨by omega⟩
  rw [periodicDensitySequence_of_ne_zero, openSquareDensitySequence_of_ne_zero]
  exact (rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one L hq0 hq1).2

end Ising2DLambda.ThermodynamicLimit
