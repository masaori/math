import Ising2DLambda.KacWard.ProjectedClosedEdgeCycle
import Ising2DLambda.KacWard.TaggedShortPairSuccessor
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceActiveVertices
import Ising2DLambda.NecSuf.KacWard.ProjectedCycleNonbacktracking

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue

/-- At an active edge of a nonzero tagged term, the short mate follows its reversal. -/
private theorem active_shortMate_successor {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (e : OrientedEdge L)
    (he : e ∈ Ising2DLambda.NecSuf.KacWard.activeVertices D
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
      (shortUnderlyingPairs t)) :
    perfectMatchingMate D e ∈ nonbacktrackingSuccessors (reversal e) := by
  classical
  have hincident := (Ising2DLambda.NecSuf.KacWard.mem_activeVertices_iff_incident
    D ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
    (shortUnderlyingPairs t) e).mp he
  have hshort := (taggedDifference_active_iff_short z s D t hterm e).mp hincident
  obtain ⟨p, hp, hcover⟩ := matching_pair_cover D e
  have hp' := (Finset.mem_filter.mp hp).2
  have hmate : perfectMatchingMate D p.1 = p.2 :=
    perfectMatchingMate_eq_of_pair D p.1 p.2 hp'.1.ne' hp'.2
  have hset : ({p.1, p.2} : Set (OrientedEdge L)) =
      {e, perfectMatchingMate D e} := by
    rcases hcover with rfl | rfl
    · rw [hmate]
    · have hback : perfectMatchingMate D p.2 = p.1 := by
        rw [← hmate]
        exact perfectMatchingMate_involutive D p.1
      rw [hback, Set.pair_comm]
  have hpt : p ∈ t := (shortUnderlyingPairs_iff D t ht p hp).mp (hset ▸ hshort)
  have hlocal := (taggedMatching_nonzero_term_support z s D t hterm).2 p hpt
  apply (mem_nonbacktrackingSuccessors_reversal e (perfectMatchingMate D e)).2
  rcases hcover with rfl | rfl
  · rw [hmate]
    exact ⟨hlocal.1, hlocal.2⟩
  · have hback : perfectMatchingMate D p.2 = p.1 := by
      rw [← hmate]
      exact perfectMatchingMate_involutive D p.1
    rw [hback]
    exact ⟨hlocal.1.symm, hp'.1.ne⟩

attribute [local instance] Classical.propDecidable

/-- Reversing each first-colour edge gives a cyclic legal edge walk. -/
theorem taggedActive_projectedCycle_nonbacktracking {L : ℕ} (z : Qbar)
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
  obtain ⟨k, hk, hreturn, hlong⟩ := taggedActive_projectedClosedEdgeCycle D t i
  have hcomponent : m ∈ matchingPairComponent τ υ i :=
    matchingPairComponentMinimum_mem τ υ i
  have hbase : matchingPairComponentMinimum τ υ m = m :=
    matchingPairComponentMinimum_basepoint τ υ i m hcomponent
  have hm : m ∈ C := by
    change m ∈ finitePermutationOrbit (matchingPairStep τ υ)
      (matchingPairComponentMinimum τ υ m)
    rw [hbase]
    exact finitePermutationOrbit_self_mem _ m
  have hflip (j : _) : σ j ∈ C ↔ j ∉ C := matchingPairSuccessor_color τ υ j
  have heven (r : ℕ) : finiteMapIterate σ (2 * r) m ∈ C := by
    induction r with
    | zero => simpa [finiteMapIterate, C] using hm
    | succ r ih =>
      let j := finiteMapIterate σ (2 * r) m
      have hodd : σ j ∉ C := by
        intro h
        exact (hflip j).mp h ih
      have hnext : σ (σ j) ∈ C := (hflip (σ j)).mpr hodd
      have hindex : 2 * (r + 1) = 2 + 2 * r := by omega
      rw [hindex, finiteMapIterate_add]
      exact hnext
  refine ⟨k, hk, congrArg (fun j => reversal j.val) hreturn, ?_⟩
  intro r hr
  let e := finiteMapIterate σ (2 * r) m
  let f := finiteMapIterate σ (2 * r + 1) m
  have hshort : τ.val e = f := by
    have hstep : σ e = f := by
      change σ (finiteMapIterate σ (2 * r) m) = finiteMapIterate σ (2 * r + 1) m
      rw [show 2 * r + 1 = 1 + 2 * r by omega, finiteMapIterate_add]
      rfl
    calc
      τ.val e = σ e := by
        change τ.val e = matchingPairSuccessor τ υ e
        rw [matchingPairSuccessor, if_pos (heven r)]
      _ = f := hstep
  have hmate : perfectMatchingMate D e.val = f.val := congrArg Subtype.val hshort
  have hnext := active_shortMate_successor z s D t ht hterm e.val e.property
  rw [hmate] at hnext
  have hrev : reversal (finiteMapIterate σ (2 * (r + 1)) m).val = f.val := by
    rw [hlong r hr, reversal_involutive]
  rw [hrev]
  exact hnext

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
    exact active_shortMate_successor z s D t ht hterm j.val j.property
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
