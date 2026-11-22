/- 反転した第一色の辺列が非後退であることの具体版が、必要十分版の交互閉路の計算の特殊化であることの導出。 -/
import Ising2DLambda.KacWard.ProjectedCycleNonbacktracking
import Ising2DLambda.KacWard.ProjectedClosedEdgeCycleFromNecSuf
import Ising2DLambda.NecSuf.KacWard.ProjectedCycleNonbacktracking

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- The general alternating-cycle calculation specializes to actual oriented edges. -/
theorem taggedActive_projectedCycle_nonbacktracking_from_necSuf {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (i : {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)}) :
    let τ := shortInvolution D t
    let υ := longInvolution D t
    let m := matchingPairComponentMinimum τ υ i
    let σ := matchingPairPermutation τ υ
    ∃ k : ℕ, 0 < k ∧
      reversal (finiteMapIterate σ (2 * k) m).val = reversal m.val ∧
      ∀ r : ℕ, r < k →
        reversal (finiteMapIterate σ (2 * (r + 1)) m).val ∈
          nonbacktrackingSuccessors
            (reversal (finiteMapIterate σ (2 * r) m).val) := by
  classical
  dsimp
  let τ := shortInvolution D t
  let υ := longInvolution D t
  let m := matchingPairComponentMinimum τ υ i
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
  have hcomponent : m ∈ matchingPairComponent τ υ i :=
    matchingPairComponentMinimum_mem τ υ i
  have hbase : matchingPairComponentMinimum τ υ m = m :=
    matchingPairComponentMinimum_basepoint τ υ i m hcomponent
  have hm : m ∈ C := by
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    rw [hbase]
    exact finitePermutationOrbit_self_mem _ m
  have hrev (j : _) : (υ.val j).val = reversal j.val := by
    change perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) j.val = _
    exact referenceLongMate_eq_reversal _
  have hlocal (j : _) (_ : j ∈ C) :
      (τ.val j).val ∈ nonbacktrackingSuccessors (υ.val j).val := by
    change perfectMatchingMate D j.val ∈ nonbacktrackingSuccessors (υ.val j).val
    rw [hrev]
    apply taggedActive_shortMate_mem_nonbacktrackingSuccessors z s D t ht hterm j.val
    rw [concreteTaggedActiveVertices_eq_activeVertices D t]
    exact j.property
  obtain ⟨k, hk, hreturn, hsteps⟩ :=
    Ising2DLambda.NecSuf.KacWard.projectedCycle_nonbacktracking
      τ υ υ.val
      (fun a b => b.val ∈ nonbacktrackingSuccessors a.val)
      υ.property.2 (fun _ => rfl) hlocal m hm
  refine ⟨k, hk, ?_, ?_⟩
  · simpa only [hrev] using congrArg Subtype.val hreturn
  · intro r hr
    have h := hsteps r hr
    change (υ.val (finiteMapIterate σ (2 * (r + 1)) m)).val ∈
      nonbacktrackingSuccessors
        (υ.val (finiteMapIterate σ (2 * r) m)).val at h
    rwa [hrev, hrev] at h

end Ising2DLambda.KacWard
