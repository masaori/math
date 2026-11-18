import Ising2DLambda.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 平方根が部分体の外にあれば、非零の二次係数表示のノルムは零でない。 -/
theorem quadraticNorm_ne_zero (F : Subfield Qbar) (a b c₀ c₁ : Qbar)
    (_ha : a ∈ F) (hc₀ : c₀ ∈ F) (hc₁ : c₁ ∈ F)
    (hbF : b ∉ F) (hb : b * b = a) (hz : c₀ + c₁ * b ≠ 0) :
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
  have hdiv : b = c₀ / c₁ := by
    apply (eq_div_iff hc₁0).2
    calc
      b * c₁ = c₁ * b := mul_comm b c₁
      _ = c₀ := (sub_eq_zero.mp hsub).symm
  exact hbF (hdiv ▸ F.div_mem hc₀ hc₁)

end Ising2DLambda.FisherZero
