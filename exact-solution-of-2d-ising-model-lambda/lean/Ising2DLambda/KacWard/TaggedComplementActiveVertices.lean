import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceActiveVertices
import Ising2DLambda.KacWard.TaggedDifferenceActiveVertices
import Ising2DLambda.KacWard.TaggedComplementActiveVerticesConcrete
import Ising2DLambda.KacWard.ReferenceLongMate

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff
attribute [local instance] Classical.propDecidable

/-- The activity predicate obtained by comparing labelled pairs is exactly
    incidence with the concrete tagged symmetric difference. -/
theorem taggedActiveByLabels_eq_concreteTaggedActiveVertices {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    taggedActiveByLabels D t = concreteTaggedActiveVertices D t := by
  classical
  ext e
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let d : Set (OrientedEdge L) × Bool :=
    ({e, perfectMatchingMate D e},
      decide (({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈ shortUnderlyingPairs t))
  let r : Set (OrientedEdge L) × Bool := ({e, reversal e}, false)
  have hRmate : perfectMatchingMate R e = reversal e := referenceLongMate_eq_reversal e
  have hD (q : Set (OrientedEdge L) × Bool) :
      q ∈ concreteTaggedPairs D t ∧ e ∈ q.1 ↔ q = d := by
    constructor
    · rintro ⟨⟨p, hp, rfl⟩, he⟩
      have hunique : p = ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) :=
        (D.property.2 e).unique ⟨hp, he⟩
          ⟨(perfectMatchingMate_spec D e).2, by simp⟩
      subst p
      rfl
    · intro hq
      rw [hq]
      exact ⟨⟨{e, perfectMatchingMate D e},
        (perfectMatchingMate_spec D e).2, rfl⟩, by simp [d]⟩
  have hR (q : Set (OrientedEdge L) × Bool) :
      q ∈ concreteReferenceTaggedPairs L ∧ e ∈ q.1 ↔ q = r := by
    constructor
    · rintro ⟨⟨p, hp, rfl⟩, he⟩
      have hunique : p = ({e, perfectMatchingMate R e} : Set (OrientedEdge L)) :=
        (R.property.2 e).unique ⟨hp, he⟩
          ⟨(perfectMatchingMate_spec R e).2, by simp⟩
      subst p
      simp [r, hRmate]
    · intro hq
      rw [hq]
      exact ⟨⟨{e, reversal e}, by
        change ({e, reversal e} : Set (OrientedEdge L)) ∈ R.val
        rw [← hRmate]
        exact (perfectMatchingMate_spec R e).2, rfl⟩, by simp [r]⟩
  have hdmem : e ∈ d.1 := by simp [d]
  have hrmem : e ∈ r.1 := by simp [r]
  change d ≠ r ↔
    ∃ q ∈ (concreteTaggedPairs D t ∆ concreteReferenceTaggedPairs L), e ∈ q.1
  constructor
  · intro hne
    refine ⟨d, Set.mem_symmDiff.mpr (Or.inl ⟨((hD d).mpr rfl).1, ?_⟩), hdmem⟩
    intro hr
    exact hne ((hR d).mp ⟨hr, hdmem⟩)
  · rintro ⟨q, hq, he⟩
    rcases Set.mem_symmDiff.mp hq with ⟨hqD, hqR⟩ | ⟨hqR, hqD⟩
    · have hqd := (hD q).mp ⟨hqD, he⟩
      intro heq
      exact hqR ((hR q).mpr (hqd.trans heq)).1
    · have hqr := (hR q).mp ⟨hqR, he⟩
      intro heq
      exact hqD ((hD q).mpr (hqr.trans heq.symm)).1

/-- For an actual nonzero tagged matching, membership of the base edge in the
    complement agrees with the labelled activity of either orientation. -/
theorem taggedComplement_iff_active_concrete {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (e : OrientedEdge L) :
    e.1 ∈ taggedComplementEdges D t ↔ e ∈ taggedActiveByLabels D t := by
  classical
  have hLong := (taggedMatching_nonzero_term_support z s D t hterm).1
  have hPendpoint := complement_iff_short_endpoint D t ht hLong e
  -- The unique matching pair at e identifies complement membership with its short label.
  have hPshort : e.1 ∈ taggedComplementEdges D t ↔
      ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈ shortUnderlyingPairs t := by
    rw [hPendpoint]
    constructor
    · rintro ⟨p, hp, he⟩
      have hpair : ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) =
          {p.1, p.2} := by
        have hmate := perfectMatchingMate_eq_of_pair D p.1 p.2
          (Finset.mem_filter.mp (ht hp)).2.1.ne' (Finset.mem_filter.mp (ht hp)).2.2
        rcases he with rfl | rfl
        · rw [hmate]
        · rw [← hmate, perfectMatchingMate_involutive, Set.pair_comm]
      rw [hpair]
      exact (shortUnderlyingPairs_iff D t ht p (ht hp)).2 hp
    · intro hshort
      obtain ⟨p, hp, he⟩ := matching_pair_cover D e
      have hpair : ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) =
          {p.1, p.2} := by
        have hmate := perfectMatchingMate_eq_of_pair D p.1 p.2
          (Finset.mem_filter.mp hp).2.1.ne' (Finset.mem_filter.mp hp).2.2
        rcases he with rfl | rfl
        · rw [hmate]
        · rw [← hmate, perfectMatchingMate_involutive, Set.pair_comm]
      rw [hpair] at hshort
      exact ⟨p, (shortUnderlyingPairs_iff D t ht p hp).1 hshort, he⟩
  -- The short label of the unique pair at e is activity in the tagged symmetric difference.
  rw [taggedActiveByLabels_eq_concreteTaggedActiveVertices]
  exact hPshort.trans (taggedDifference_active_iff_short z s D t hterm e).symm

end Ising2DLambda.KacWard
