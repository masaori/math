/-
人手証明の「零点と有理点の距離の二乗」の具体版。

固定した実閉部分体の一意表示 xi = a + b * omega を使い、
dsq(xi,q) = (a-q)^2 + b^2 を定め、その零性が xi = q と同値であることを
本文と同じ背理法で示す。

住処: Q と Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.RealAlgebraicOrder

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_distance_squared_to_rational` で使う一意表示の係数。 -/
noncomputable def realClosedComponents (data : RealClosedSubfieldData) (xi : Qbar) :
    data.carrier × data.carrier :=
  Classical.choose (data.unique_decomposition xi)

/-- 選んだ係数は元の代数的数を表示する。 -/
theorem realClosedComponents_spec (data : RealClosedSubfieldData) (xi : Qbar) :
    xi = ((realClosedComponents data xi).1 : Qbar) +
      ((realClosedComponents data xi).2 : Qbar) * data.omega :=
  (Classical.choose_spec (data.unique_decomposition xi)).1

/-- `def_distance_squared_to_rational` の具体版。 -/
noncomputable def distanceSquaredToRational
    (data : RealClosedSubfieldData) (xi : Qbar) (q : ℚ) : data.carrier :=
  let ab := realClosedComponents data xi
  let qR : data.carrier := ⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩
  (ab.1 - qR) * (ab.1 - qR) + ab.2 * ab.2

/-- `claim_distance_squared_zero_iff_equal` の具体版。 -/
theorem distanceSquaredToRational_eq_zero_iff
    (data : RealClosedSubfieldData) (xi : Qbar) (q : ℚ) :
    distanceSquaredToRational data xi q = 0 ↔ xi = (q : Qbar) := by
  let ab := realClosedComponents data xi
  let a := ab.1
  let b := ab.2
  let qR : data.carrier := ⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩
  have hxi : xi = (a : Qbar) + (b : Qbar) * data.omega := by
    simpa [ab, a, b] using realClosedComponents_spec data xi
  constructor
  · intro hdsq
    have hsum : (a - qR) * (a - qR) + b * b = 0 := by
      simpa [distanceSquaredToRational, ab, a, b, qR] using hdsq
    have hb : b = 0 := by
      by_contra hbne
      let w : data.carrier := (a - qR) * b⁻¹
      have hsq : (a - qR) * (a - qR) = -(b * b) := by
        exact eq_neg_of_add_eq_zero_left hsum
      have hw_sq : w * w = -1 := by
        calc
          w * w = ((a - qR) * b⁻¹) * ((a - qR) * b⁻¹) := by rfl
          _ = ((a - qR) * (a - qR)) * (b⁻¹ * b⁻¹) := by ring
          _ = (-(b * b)) * (b⁻¹ * b⁻¹) := by rw [hsq]
          _ = -((b * b⁻¹) * (b * b⁻¹)) := by ring
          _ = -(1 * 1) := by rw [mul_inv_cancel₀ hbne]
          _ = -1 := by ring
      have hw : w ≠ 0 := by
        intro hwzero
        have : (0 : data.carrier) = -1 := by simpa [hwzero] using hw_sq
        exact one_ne_zero (neg_eq_zero.mp this.symm)
      exact negOne_not_square_realClosedCarrier data w hw hw_sq
    have ha : a = qR := by
      have hsquare : (a - qR) * (a - qR) = 0 := by simpa [hb] using hsum
      have hdiff : a - qR = 0 := mul_self_eq_zero.mp hsquare
      exact sub_eq_zero.mp hdiff
    calc
      xi = (a : Qbar) + (b : Qbar) * data.omega := hxi
      _ = (qR : Qbar) + (0 : Qbar) * data.omega := by rw [ha, hb]; rfl
      _ = (q : Qbar) := by simp [qR]
  · intro hxiq
    have hqrep : (q : Qbar) = (qR : Qbar) + (0 : Qbar) * data.omega := by simp [qR]
    have hab : ab = (qR, 0) := by
      change realClosedComponents data xi = (qR, 0)
      exact ((Classical.choose_spec (data.unique_decomposition xi)).2 (qR, 0) (by
        rw [hxiq]
        exact hqrep)).symm
    simp [distanceSquaredToRational, ab, qR, hab]

end Ising2DLambda.FisherZero
