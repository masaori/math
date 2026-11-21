import Ising2DLambda.RealEscape.OpenSquareLimitPeriodicDensity
import Ising2DLambda.RealEscape.SequenceLowerSetSupRealLimitFromNecSuf
import Ising2DLambda.RealEscape.RealizedRationalLogOrderCauchyFromNecSuf

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Filter Topology

/-- 下組の上限の必要十分版から、同じ開境界と周期境界の結論を導く。 -/
theorem openSquare_realLimit_eq_periodicFreeEnergyDensity_of_le_one_from_necSuf {q : ℚ}
    (hq0 : 0 < q) (hq1 : q ≤ 1) :
    ∃ I : ℝ,
      Tendsto (fun L => realizeRational (openSquareDensitySequence q L)) atTop (𝓝 I) ∧
        periodicFreeEnergyDensity q = I := by
  obtain ⟨I, hlim⟩ := exists_realLimit_openSquareDensitySequence_of_le_one_from_necSuf hq0 hq1
  refine ⟨I, hlim, ?_⟩
  calc
    periodicFreeEnergyDensity q = sSup (periodicRealizedLowerSet q) :=
      periodicFreeEnergyDensity_eq_sSup q
    _ = sSup (realizeRational '' openSquareDensityLowerSet q) := by
      rw [periodicRealizedLowerSet_eq_openSquare_of_le_one hq0 hq1]
      rfl
    _ = I :=
      (sequence_lowerSet_sup_eq_realLimit_from_necSuf
        (openSquareDensitySequence q) I hlim).2.2

end Ising2DLambda.RealEscape
