/- 必要十分版を実閉部分体の具体的なデータへ特殊化する導出。住処: Q と Qbar。 -/
import Ising2DLambda.FisherZero.DistanceSquaredToRational
import Ising2DLambda.NecSuf.FisherZero.DistanceSquaredToRational

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 距離の二乗の零性を、二係数表示についての必要十分版から導く。 -/
theorem distanceSquaredToRational_eq_zero_iff_from_necSuf
    (data : RealClosedSubfieldData) (xi : Qbar) (q : ℚ) :
    distanceSquaredToRational data xi q = 0 ↔ xi = (q : Qbar) := by
  let ab := realClosedComponents data xi
  let qR : data.carrier := ⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩
  have hcore :=
    Ising2DLambda.NecSuf.FisherZero.distanceSquaredOfPair_eq_zero_iff_necSuf
      (fun w hw => negOne_not_square_realClosedCarrier data w hw) ab qR
  have hdistance :
      distanceSquaredToRational data xi q =
        Ising2DLambda.NecSuf.FisherZero.distanceSquaredOfPair ab qR := by
    rfl
  constructor
  · intro hzero
    have hab : ab = (qR, 0) := hcore.mp (by simpa [hdistance] using hzero)
    calc
      xi = ((ab.1 : data.carrier) : Qbar) +
          ((ab.2 : data.carrier) : Qbar) * data.omega := by
            simpa [ab] using realClosedComponents_spec data xi
      _ = (qR : Qbar) + (0 : Qbar) * data.omega := by rw [hab]; rfl
      _ = (q : Qbar) := by simp [qR]
  · intro hxiq
    have hqrep : (q : Qbar) = (qR : Qbar) + (0 : Qbar) * data.omega := by simp [qR]
    have hab : ab = (qR, 0) := by
      change realClosedComponents data xi = (qR, 0)
      exact ((Classical.choose_spec (data.unique_decomposition xi)).2 (qR, 0) (by
        rw [hxiq]
        exact hqrep)).symm
    rw [hdistance]
    exact hcore.mpr hab

end Ising2DLambda.FisherZero
