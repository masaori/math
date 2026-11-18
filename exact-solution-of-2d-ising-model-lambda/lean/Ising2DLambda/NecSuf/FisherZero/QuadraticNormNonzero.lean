import Ising2DLambda.FisherZero.QuadraticNormNonzero

namespace Ising2DLambda.NecSuf.FisherZero

/-- 必要なのは体と、係数集合が除法で閉じることだけである。 -/
theorem quadraticNorm_ne_zero_necSuf {K : Type*} [Field K] (S : Set K)
    (hdiv : ∀ x y : K, x ∈ S → y ∈ S → x / y ∈ S)
    (a b u v : K) (hu : u ∈ S) (hv : v ∈ S)
    (hbS : b ∉ S) (hb : b * b = a) (hz : u + v * b ≠ 0) :
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
  have hdiv_eq : b = u / v := by
    apply (eq_div_iff hv0).2
    calc
      b * v = v * b := mul_comm b v
      _ = u := (sub_eq_zero.mp hsub).symm
  exact hbS (hdiv_eq ▸ hdiv u v hu hv)

end Ising2DLambda.NecSuf.FisherZero
