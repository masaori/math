/- 一周期の回転和の同定を、整数格子と整数の回転表へ特殊化する。 -/
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem periodicPlaneLift_periodTurning_from_necSuf
    (m L : ℕ) [NeZero m] (base : ℤ → ℤ × ℤ) (wv wh : ℤ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh) (k₀ : ℤ) :
    cyclicAdjacentSum latticeStepTurning m
        (fun j => periodicPlaneLift m base L wv wh (k₀ + j + 1) -
          periodicPlaneLift m base L wv wh (k₀ + j)) =
      ∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1))) := by
  calc
    _ = ∑ j : ZMod m, latticeStepTurning (orientedEdgeLatticeStep (γ j))
        (orientedEdgeLatticeStep (γ (j + 1))) :=
      integerPeriodicLift_periodAdjacentSum_necSuf m base (windingShift L wv wh)
        (fun j => orientedEdgeLatticeStep (γ j)) latticeStepTurning hstep hend k₀
    _ = _ := by
      apply Finset.sum_congr rfl
      intro j _
      exact orientedEdgeLatticeStep_turning _ _

end Ising2DLambda.KacWard
