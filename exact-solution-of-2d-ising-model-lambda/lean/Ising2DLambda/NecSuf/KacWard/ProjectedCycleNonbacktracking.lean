import Ising2DLambda.NecSuf.KacWard.ProjectedClosedEdgeCycle

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- Only the local short step, long reversal, and involution law are needed. -/
theorem projectedCycle_nonbacktracking (τ υ : FixedPointFreeInvolution J)
    (reverse : J → J) (next : J → J → Prop)
    (hreverse : Function.Involutive reverse)
    (hlong : ∀ j, υ.val j = reverse j)
    (hshort : ∀ j ∈ matchingPairColor τ υ, next (reverse j) (τ.val j))
    (i : J) (hi : i ∈ matchingPairColor τ υ) :
    let σ := matchingPairPermutation τ υ
    ∃ k : ℕ, 0 < k ∧ reverse (finiteMapIterate σ (2 * k) i) = reverse i ∧
      ∀ r : ℕ, r < k →
        next (reverse (finiteMapIterate σ (2 * r) i))
          (reverse (finiteMapIterate σ (2 * (r + 1)) i)) := by
  dsimp
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
  obtain ⟨k, hk, hreturn, hstep⟩ := projectedClosedEdgeCycle τ υ i hi
  have hflip (j : J) : σ j ∈ C ↔ j ∉ C := matchingPairSuccessor_color τ υ j
  have heven (r : ℕ) : finiteMapIterate σ (2 * r) i ∈ C := by
    induction r with
    | zero => simpa [finiteMapIterate, C] using hi
    | succ r ih =>
      let j := finiteMapIterate σ (2 * r) i
      have hodd : σ j ∉ C := by
        intro h
        exact (hflip j).mp h ih
      have hnext : σ (σ j) ∈ C := (hflip (σ j)).mpr hodd
      have hindex : 2 * (r + 1) = 2 + 2 * r := by omega
      rw [hindex, finiteMapIterate_add]
      exact hnext
  refine ⟨k, hk, congrArg reverse hreturn, ?_⟩
  intro r hr
  let e := finiteMapIterate σ (2 * r) i
  let f := finiteMapIterate σ (2 * r + 1) i
  have hshortMate : τ.val e = f := by
    have hstep' : σ e = f := by
      change σ (finiteMapIterate σ (2 * r) i) = finiteMapIterate σ (2 * r + 1) i
      rw [show 2 * r + 1 = 1 + 2 * r by omega, finiteMapIterate_add]
      rfl
    calc
      τ.val e = σ e := by
        change τ.val e = matchingPairSuccessor τ υ e
        rw [matchingPairSuccessor, if_pos (heven r)]
      _ = f := hstep'
  have hlocal := hshort e (heven r)
  rw [hshortMate] at hlocal
  have hnext : reverse (finiteMapIterate σ (2 * (r + 1)) i) = f := by
    rw [← hstep r hr, hlong, hreverse]
  rw [hnext]
  exact hlocal

end Ising2DLambda.NecSuf.KacWard
