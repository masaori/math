import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 必要なのは体と、係数集合が除法で閉じることだけである。 -/
theorem quadraticNorm_ne_zero_necSuf {K : Type*} [Field K] (S : Set K)
    (hdiv : ∀ x y : K, x ∈ S → y ∈ S → x / y ∈ S)
    (a b c₀ c₁ : K) (hc₀ : c₀ ∈ S) (hc₁ : c₁ ∈ S)
    (hbS : b ∉ S) (hb : b * b = a) (hz : c₀ + c₁ * b ≠ 0) :
    c₀ * c₀ - a * (c₁ * c₁) ≠ 0 := by
  intro hnorm
  have hc₁0 : c₁ ≠ 0 := by
    intro hc₁zero
    have hc₀2 : c₀ * c₀ = 0 := by simpa [hc₁zero] using hnorm
    have hc₀zero : c₀ = 0 := (mul_eq_zero.mp hc₀2).elim id id
    exact hz (by simp [hc₀zero, hc₁zero])
  have hprod : (c₀ + c₁ * b) * (c₀ - c₁ * b) = 0 := by
    calc
      (c₀ + c₁ * b) * (c₀ - c₁ * b) = c₀ * c₀ - (b * b) * (c₁ * c₁) := by ring
      _ = c₀ * c₀ - a * (c₁ * c₁) := by rw [hb]
      _ = 0 := hnorm
  have hsub : c₀ - c₁ * b = 0 := (mul_eq_zero.mp hprod).resolve_left hz
  have hdiv_eq : b = c₀ / c₁ := by
    apply (eq_div_iff hc₁0).2
    calc
      b * c₁ = c₁ * b := mul_comm b c₁
      _ = c₀ := (sub_eq_zero.mp hsub).symm
  exact hbS (hdiv_eq ▸ hdiv c₀ c₁ hc₀ hc₁)

end Ising2DLambda.NecSuf.FisherZero
