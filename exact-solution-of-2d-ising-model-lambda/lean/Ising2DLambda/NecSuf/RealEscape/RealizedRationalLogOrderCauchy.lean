import Mathlib.Topology.MetricSpace.Cauchy
import Mathlib.Topology.UniformSpace.Real

namespace Ising2DLambda.NecSuf.RealEscape

open Filter Topology

/-- An order Cauchy sequence has a real Cauchy realization when arbitrarily small
positive order bounds exist in the image. -/
theorem cauchySeq_realization_of_orderCauchy
    {G : Type*} [AddCommGroup G]
    (R : G → G → Prop) (ρ : G → ℝ) (l : ℕ → G)
    (hadd : ∀ a b : G, ρ (a + b) = ρ a + ρ b)
    (hzero : ρ 0 = 0)
    (hmono : ∀ a b : G, R a b → ρ a ≤ ρ b)
    (hsmall : ∀ δ : ℝ, 0 < δ → ∃ ε : G, R 0 ε ∧ ε ≠ 0 ∧ ρ ε < δ)
    (hcauchy : ∀ ε : G, R 0 ε → ε ≠ 0 →
      ∃ N : ℕ, ∀ m : ℕ, N ≤ m → ∀ n : ℕ, N ≤ n →
        R (-ε) (l m - l n) ∧ R (l m - l n) ε) :
    CauchySeq (fun L => ρ (l L)) := by
  have hneg (a : G) : ρ (-a) = -ρ a := by
    have h := hadd a (-a)
    rw [add_neg_cancel, hzero] at h
    linarith
  have hsub (a b : G) : ρ (a - b) = ρ a - ρ b := by
    rw [sub_eq_add_neg, hadd, hneg, sub_eq_add_neg]
  apply Metric.cauchySeq_iff.mpr
  intro δ hδ
  obtain ⟨ε, hε0, hεne, hεδ⟩ := hsmall δ hδ
  obtain ⟨N, hN⟩ := hcauchy ε hε0 hεne
  refine ⟨N, ?_⟩
  intro m hm n hn
  obtain ⟨hlow, hupp⟩ := hN m hm n hn
  have hlowr := hmono _ _ hlow
  have huppr := hmono _ _ hupp
  rw [Real.dist_eq]
  apply abs_lt.mpr
  constructor
  · rw [hneg, hsub] at hlowr
    linarith
  · rw [hsub] at huppr
    linarith

/-- The real limit follows solely from completeness once the order bounds transfer. -/
theorem exists_realLimit_of_orderCauchy
    {G : Type*} [AddCommGroup G]
    (R : G → G → Prop) (ρ : G → ℝ) (l : ℕ → G)
    (hadd : ∀ a b : G, ρ (a + b) = ρ a + ρ b)
    (hzero : ρ 0 = 0)
    (hmono : ∀ a b : G, R a b → ρ a ≤ ρ b)
    (hsmall : ∀ δ : ℝ, 0 < δ → ∃ ε : G, R 0 ε ∧ ε ≠ 0 ∧ ρ ε < δ)
    (hcauchy : ∀ ε : G, R 0 ε → ε ≠ 0 →
      ∃ N : ℕ, ∀ m : ℕ, N ≤ m → ∀ n : ℕ, N ≤ n →
        R (-ε) (l m - l n) ∧ R (l m - l n) ε) :
    ∃ I : ℝ, Tendsto (fun L => ρ (l L)) atTop (𝓝 I) := by
  exact cauchySeq_tendsto_of_complete
    (cauchySeq_realization_of_orderCauchy R ρ l hadd hzero hmono hsmall hcauchy)

end Ising2DLambda.NecSuf.RealEscape
