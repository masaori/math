/- 既存の必要十分核を臨界点への距離へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.CriticalDistanceSquaredZeroIff
import Ising2DLambda.NecSuf.FisherZero.DistanceSquaredToRational

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem distanceSquaredToCriticalPoint_eq_zero_iff_from_necSuf
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2) (xi : Qbar) :
    distanceSquaredToCriticalPoint data s hs xi = 0 ↔ xi = -1 + s := by
  let ab := realClosedComponents data xi
  let xc := criticalPointRealClosed data s hs
  have hxc : (xc : Qbar) = -1 + s := criticalPointRealClosed_val data s hs
  have hcore :=
    Ising2DLambda.NecSuf.FisherZero.distanceSquaredOfPair_eq_zero_iff_necSuf
      (fun w hw => negOne_not_square_realClosedCarrier data w hw) ab xc
  have hdistance :
      distanceSquaredToCriticalPoint data s hs xi =
        Ising2DLambda.NecSuf.FisherZero.distanceSquaredOfPair ab xc := by
    rfl
  constructor
  · intro hzero
    have hab : ab = (xc, 0) := hcore.mp (by simpa [hdistance] using hzero)
    calc
      xi = ((ab.1 : data.carrier) : Qbar) +
          ((ab.2 : data.carrier) : Qbar) * data.omega := by
            simpa [ab] using realClosedComponents_spec data xi
      _ = (xc : Qbar) + (0 : Qbar) * data.omega := by rw [hab]; rfl
      _ = -1 + s := by simp [hxc]
  · intro hx
    have hxrep : xi = (xc : Qbar) + (0 : Qbar) * data.omega := by
      rw [hx, hxc]
      simp
    have hab : ab = (xc, 0) := by
      change realClosedComponents data xi = (xc, 0)
      exact ((Classical.choose_spec (data.unique_decomposition xi)).2 (xc, 0) hxrep).symm
    rw [hdistance]
    exact hcore.mpr hab

end Ising2DLambda.FisherZero
