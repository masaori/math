import Ising2DLambda.RealEscape.RealizedRationalLogOrderCauchy
import Ising2DLambda.RealEscape.SequenceLowerSetSupRealLimit
import Ising2DLambda.ThermodynamicLimit.PeriodicFreeEnergyDensity

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Filter Topology

/-- 開境界密度の実数極限は、同じ下組を持つ周期境界密度に等しい。 -/
theorem openSquare_realLimit_eq_periodicFreeEnergyDensity_of_le_one {q : ℚ}
    (hq0 : 0 < q) (hq1 : q ≤ 1) :
    ∃ I : ℝ,
      Tendsto (fun L => realizeRational (openSquareDensitySequence q L)) atTop (𝓝 I) ∧
        periodicFreeEnergyDensity q = I := by
  obtain ⟨I, hlim⟩ := exists_realLimit_openSquareDensitySequence_of_le_one hq0 hq1
  refine ⟨I, hlim, ?_⟩
  calc
    periodicFreeEnergyDensity q = sSup (periodicRealizedLowerSet q) :=
      periodicFreeEnergyDensity_eq_sSup q
    _ = sSup (realizeRational '' openSquareDensityLowerSet q) := by
      rw [periodicRealizedLowerSet_eq_openSquare_of_le_one hq0 hq1]
      rfl
    _ = I :=
      (sequence_lowerSet_sup_eq_realLimit (openSquareDensitySequence q) I hlim).2.2

end Ising2DLambda.RealEscape
