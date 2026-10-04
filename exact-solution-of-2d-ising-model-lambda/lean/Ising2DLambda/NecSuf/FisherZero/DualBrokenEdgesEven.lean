/-
「破れた辺の双対像は偶部分グラフである」の必要十分版。
格子・配位・整数環を外し、端点数の局所和、四つの辺の符号、
四頂点の平方が一であることを残す。可換性は因子を平方へまとめるために要る。
符号元の二乗が一であることと一でないことは、指数の偶奇を判定するために要る。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 本文末尾の自然数の偶奇を、非自明な対合元の冪で判定する。 -/
lemma involution_pow_eq_one_iff_even {M : Type*} [Monoid M] (ε : M)
    (hsquare : ε * ε = 1) (hne : ε ≠ 1) (n : ℕ) : ε ^ n = 1 ↔ Even n := by
  have htwo : ε ^ 2 = 1 := by simpa only [pow_two] using hsquare
  constructor
  · intro hpow
    rcases Nat.even_or_odd n with heven | ⟨k, hk⟩
    · exact heven
    · have hodd : ε ^ n = ε := by
        rw [hk, pow_add, pow_mul, htwo, one_pow, pow_one, one_mul]
      exact (hne (hodd.symm.trans hpow)).elim
  · rintro ⟨k, hk⟩
    rw [hk, ← two_mul, pow_mul, htwo, one_pow]

/-- 本文の局所計数、冪の分解、辺スピン積、平方への整理、偶奇判定を同じ順に行う。
指示子が零か一かは符号の等式を作る側だけで必要なので、ここでは自然数でよい。
加法・順序・逆元は符号を値とする側では使わない。 -/
theorem four_signs_even_necSuf {M : Type*} [CommMonoid M]
    (ε s₀ s₁ s₂ s₃ : M) (d q₁ q₂ q₃ q₄ : ℕ)
    (heps : ε * ε = 1) (hne : ε ≠ 1)
    (hcount : d = q₁ + q₂ + q₃ + q₄)
    (h₁ : ε ^ q₁ = s₁ * s₂) (h₂ : ε ^ q₂ = s₃ * s₂)
    (h₃ : ε ^ q₃ = s₀ * s₃) (h₄ : ε ^ q₄ = s₀ * s₁)
    (hs₀ : s₀ * s₀ = 1) (hs₁ : s₁ * s₁ = 1)
    (hs₂ : s₂ * s₂ = 1) (hs₃ : s₃ * s₃ = 1) : Even d := by
  have hpow : ε ^ d = 1 := by
    calc
      ε ^ d = ε ^ (q₁ + q₂ + q₃ + q₄) := by rw [hcount]
      _ = ε ^ q₁ * ε ^ q₂ * ε ^ q₃ * ε ^ q₄ := by
        rw [pow_add, pow_add, pow_add]
      _ = (s₁ * s₂) * (s₃ * s₂) * (s₀ * s₃) * (s₀ * s₁) := by
        rw [h₁, h₂, h₃, h₄]
      _ = (s₀ * s₀) * (s₁ * s₁) * (s₂ * s₂) * (s₃ * s₃) := by ac_rfl
      _ = 1 * 1 * 1 * 1 := by rw [hs₀, hs₁, hs₂, hs₃]
      _ = 1 := by rw [one_mul, one_mul, one_mul]
  exact (involution_pow_eq_one_iff_even ε heps hne d).mp hpow

end Ising2DLambda.NecSuf.FisherZero
