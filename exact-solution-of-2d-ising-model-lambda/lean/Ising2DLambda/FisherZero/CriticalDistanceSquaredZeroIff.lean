/-
人手証明 `claim_critical_distance_squared_zero_iff_equal` の具体版。
有理点版と同じ背理法を、実閉部分体の元 `x_c` に適用する。
住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.DistanceSquaredToCriticalPoint

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 臨界点への距離の二乗が零であることと、臨界点との一致は同値である。 -/
theorem distanceSquaredToCriticalPoint_eq_zero_iff
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2) (xi : Qbar) :
    distanceSquaredToCriticalPoint data s hs xi = 0 ↔ xi = -1 + s := by
  let ab := realClosedComponents data xi
  let a := ab.1
  let b := ab.2
  let xc := criticalPointRealClosed data s hs
  have hxc : (xc : Qbar) = -1 + s := criticalPointRealClosed_val data s hs
  have hxi : xi = (a : Qbar) + (b : Qbar) * data.omega := by
    simpa [ab, a, b] using realClosedComponents_spec data xi
  constructor
  · intro hdsq
    have hsum : (a - xc) * (a - xc) + b * b = 0 := by
      simpa [distanceSquaredToCriticalPoint, ab, a, b, xc] using hdsq
    have hb : b = 0 := by
      by_contra hbne
      let w : data.carrier := (a - xc) * b⁻¹
      have hsq : (a - xc) * (a - xc) = -(b * b) :=
        eq_neg_of_add_eq_zero_left hsum
      have hw_sq : w * w = -1 := by
        calc
          w * w = ((a - xc) * b⁻¹) * ((a - xc) * b⁻¹) := by rfl
          _ = ((a - xc) * (a - xc)) * (b⁻¹ * b⁻¹) := by ring
          _ = (-(b * b)) * (b⁻¹ * b⁻¹) := by rw [hsq]
          _ = -((b * b⁻¹) * (b * b⁻¹)) := by ring
          _ = -(1 * 1) := by rw [mul_inv_cancel₀ hbne]
          _ = -1 := by ring
      have hw : w ≠ 0 := by
        intro hwzero
        have : (0 : data.carrier) = -1 := by simpa [hwzero] using hw_sq
        exact one_ne_zero (neg_eq_zero.mp this.symm)
      exact negOne_not_square_realClosedCarrier data w hw hw_sq
    have ha : a = xc := by
      have hsquare : (a - xc) * (a - xc) = 0 := by simpa [hb] using hsum
      exact sub_eq_zero.mp (mul_self_eq_zero.mp hsquare)
    calc
      xi = (a : Qbar) + (b : Qbar) * data.omega := hxi
      _ = (xc : Qbar) + (0 : Qbar) * data.omega := by rw [ha, hb]; rfl
      _ = -1 + s := by simp [hxc]
  · intro hx
    have hxrep : xi = (xc : Qbar) + (0 : Qbar) * data.omega := by
      rw [hx, hxc]
      simp
    have hab : ab = (xc, 0) := by
      change realClosedComponents data xi = (xc, 0)
      exact ((Classical.choose_spec (data.unique_decomposition xi)).2 (xc, 0) hxrep).symm
    simp [distanceSquaredToCriticalPoint, ab, xc, hab]

end Ising2DLambda.FisherZero
