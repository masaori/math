import Ising2DLambda.KacWard.PeriodicLiftStepRepetition
import Ising2DLambda.NecSuf.KacWard.PeriodicLiftStepRepetition

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem periodicPlaneLift_step_remainder_from_necSuf
    (m L : ℕ) (hm : 0 < m) (base : ℤ → ℤ × ℤ) (wv wh k₀ i : ℤ) :
    periodicPlaneLift m base L wv wh (k₀ + i + 1) -
        periodicPlaneLift m base L wv wh (k₀ + i) =
      periodicPlaneLift m base L wv wh (k₀ + i % m + 1) -
        periodicPlaneLift m base L wv wh (k₀ + i % m) := by
  have hm0 : (m : ℤ) ≠ 0 := by omega
  exact integerPeriodicLift_step_remainder_necSuf (m : ℤ) hm0 base
    (windingShift L wv wh) k₀ i

end Ising2DLambda.KacWard
