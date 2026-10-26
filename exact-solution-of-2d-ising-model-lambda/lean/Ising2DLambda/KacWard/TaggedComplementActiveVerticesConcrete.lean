import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceDegree

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- The actual tagged pair at an oriented edge is compared with its reference
    reversal pair. The Bool label remains distinct when the two supports agree. -/
noncomputable def taggedActiveByLabels {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : Set (OrientedEdge L) :=
  {e | (({e, perfectMatchingMate D e},
      decide (({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈
        shortUnderlyingPairs t)) : Set (OrientedEdge L) × Bool) ≠
      (({e, reversal e}, false) : Set (OrientedEdge L) × Bool)}

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
  constructor
  -- The label remains true even if the short pair has the same support as the reference pair.
  · intro hP
    have hs := hPshort.mp hP
    change (({e, perfectMatchingMate D e}, decide
      (({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈ shortUnderlyingPairs t)) :
      Set (OrientedEdge L) × Bool) ≠ ({e, reversal e}, false)
    intro hEq
    have hb := congrArg Prod.snd hEq
    simp [hs] at hb
  -- Outside the complement, the unique pair is a long reversal pair with label false.
  · intro ha
    by_contra hnotP
    have hnotShort : ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∉
        shortUnderlyingPairs t := fun hs => hnotP (hPshort.mpr hs)
    have hmate := taggedMatching_mate_outside_complement z s D t ht hterm e hnotP
    have hnotShort' : ({e, reversal e} : Set (OrientedEdge L)) ∉
        shortUnderlyingPairs t := by simpa only [hmate] using hnotShort
    exact ha (by simp [hmate, hnotShort'])

end Ising2DLambda.KacWard
