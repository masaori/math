import Ising2DLambda.NecSuf.KacWard.ProjectedClosedEdgeCycleCore

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J]

/-- Only the local short step, long reversal, and involution law are needed. -/
theorem projectedCycle_nonbacktracking (σ : Equiv.Perm J) (τ υ : J → J)
    (C : J → Prop) (hflip : ∀ j, C (σ j) ↔ ¬ C j)
    (hsecond : ∀ j, ¬ C j → σ j = υ j)
    (hfirst : ∀ j, C j → σ j = τ j)
    (reverse : J → J) (next : J → J → Prop)
    (hreverse : Function.Involutive reverse)
    (hlong : ∀ j, υ j = reverse j)
    (hshort : ∀ j, C j → next (reverse j) (τ j))
    (i : J) (hi : C i) :
    ∃ k : ℕ, 0 < k ∧ reverse (σ^[2 * k] i) = reverse i ∧
      ∀ r : ℕ, r < k →
        next (reverse (σ^[2 * r] i))
          (reverse (σ^[2 * (r + 1)] i)) := by
  obtain ⟨k, hk, hreturn, hstep⟩ :=
    projectedClosedEdgeCycleCore σ υ C hflip hsecond i hi
  have heven (r : ℕ) : C (σ^[2 * r] i) := by
    induction r with
    | zero => simpa using hi
    | succ r ih =>
      let j := σ^[2 * r] i
      have hodd : ¬ C (σ j) := by
        intro h
        exact (hflip j).mp h ih
      have hnext : C (σ (σ j)) := (hflip (σ j)).mpr hodd
      have hindex : 2 * (r + 1) = 2 + 2 * r := by omega
      rw [hindex, iterate_add_necSuf]
      exact hnext
  refine ⟨k, hk, congrArg reverse hreturn, ?_⟩
  intro r hr
  let e := σ^[2 * r] i
  let f := σ^[2 * r + 1] i
  have hshortMate : τ e = f := by
    have hstep' : σ e = f := by
      change σ (σ^[2 * r] i) = σ^[2 * r + 1] i
      rw [show 2 * r + 1 = 1 + 2 * r by omega, iterate_add_necSuf]
      rfl
    calc
      τ e = σ e := (hfirst e (heven r)).symm
      _ = f := hstep'
  have hlocal := hshort e (heven r)
  rw [hshortMate] at hlocal
  have hnext : reverse (σ^[2 * (r + 1)] i) = f := by
    rw [← hstep r hr, hlong, hreverse]
  rw [hnext]
  exact hlocal

end Ising2DLambda.NecSuf.KacWard
