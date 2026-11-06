import Mathlib.Data.Finset.Sum
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Only injective edge occurrences, two-valued orientation weights, matching
support, and constant oriented boundary coefficient are needed. -/
theorem signed_boundary_of_injective_support {I E : Type*} [Fintype I] [DecidableEq E]
    (base : I → E) (sign : I → ℤ) (boundary : E → ℤ) (first : I)
    (hinj : Function.Injective base)
    (hvalues : ∀ edge, boundary edge ∈ ({-1, 0, 1} : Finset ℤ))
    (hsupport : ∀ edge, boundary edge ≠ 0 ↔ ∃ k, base k = edge)
    (hsign : ∀ k, sign k ∈ ({-1, 1} : Finset ℤ))
    (hconstant : ∀ k, boundary (base k) * sign k =
      boundary (base first) * sign first) :
    ∃ ε : ℤ, ε ∈ ({-1, 1} : Finset ℤ) ∧
      ∀ edge, boundary edge =
        ε * ∑ k : I, if base k = edge then sign k else 0 := by
  classical
  have hfirst : boundary (base first) ≠ 0 :=
    (hsupport (base first)).mpr ⟨first, rfl⟩
  have hvalue : boundary (base first) ∈ ({-1, 1} : Finset ℤ) := by
    have hv := hvalues (base first)
    simp only [Finset.mem_insert, Finset.mem_singleton] at hv ⊢
    rcases hv with hneg | hzero | hone
    · exact Or.inl hneg
    · exact False.elim (hfirst hzero)
    · exact Or.inr hone
  let ε := boundary (base first) * sign first
  refine ⟨ε, ?_, ?_⟩
  · have hs := hsign first
    simp only [Finset.mem_insert, Finset.mem_singleton] at hs hvalue ⊢
    rcases hvalue with hc | hc <;> rcases hs with hd | hd <;> simp [ε, hc, hd]
  intro edge
  by_cases hpass : ∃ k, base k = edge
  · obtain ⟨k, hk⟩ := hpass
    have hsum : (∑ j : I, if base j = edge then sign j else 0) = sign k := by
      rw [Finset.sum_eq_single k]
      · simp [hk]
      · intro j _ hj
        have hne : base j ≠ edge := by
          rw [← hk]
          exact hinj.ne hj
        simp [hne]
      · simp
    have hsquare : sign k * sign k = 1 := by
      have hs := hsign k
      simp only [Finset.mem_insert, Finset.mem_singleton] at hs
      rcases hs with hneg | hone
      · simp [hneg]
      · simp [hone]
    have hcoeff : boundary edge = ε * sign k := by
      rw [← hk]
      calc
        boundary (base k) = (boundary (base k) * sign k) * sign k := by
          rw [mul_assoc, hsquare, mul_one]
        _ = ε * sign k := by rw [hconstant k]
    simpa [hsum] using hcoeff
  · have hzero : boundary edge = 0 := by
      by_contra hc
      exact hpass ((hsupport edge).mp hc)
    have hsum : (∑ k : I, if base k = edge then sign k else 0) = 0 := by
      simp [not_exists.mp hpass]
    rw [hzero, hsum]
    ring

end Ising2DLambda.NecSuf.KacWard
