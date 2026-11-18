import Ising2DLambda.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 平方根が部分体の外にあれば、非零の二次係数表示のノルムは零でない。 -/
theorem quadraticNorm_ne_zero (F : Subfield Qbar) (a b u v : Qbar)
    (_ha : a ∈ F) (hu : u ∈ F) (hv : v ∈ F)
    (hbF : b ∉ F) (hb : b * b = a) (hz : u + v * b ≠ 0) :
    u * u - a * (v * v) ≠ 0 := by
  intro hnorm
  have hv0 : v ≠ 0 := by
    intro hvzero
    have hu2 : u * u = 0 := by simpa [hvzero] using hnorm
    have huzero : u = 0 := (mul_eq_zero.mp hu2).elim id id
    exact hz (by simp [huzero, hvzero])
  have hprod : (u + v * b) * (u - v * b) = 0 := by
    calc
      (u + v * b) * (u - v * b) = u * u - (b * b) * (v * v) := by ring
      _ = u * u - a * (v * v) := by rw [hb]
      _ = 0 := hnorm
  have hsub : u - v * b = 0 := (mul_eq_zero.mp hprod).resolve_left hz
  have hdiv : b = u / v := by
    apply (eq_div_iff hv0).2
    calc
      b * v = v * b := mul_comm b v
      _ = u := (sub_eq_zero.mp hsub).symm
  exact hbF (hdiv ▸ F.div_mem hu hv)

end Ising2DLambda.FisherZero
