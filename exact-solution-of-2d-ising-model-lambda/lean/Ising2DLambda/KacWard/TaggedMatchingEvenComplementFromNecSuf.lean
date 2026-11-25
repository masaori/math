/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingEvenComplement

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.FisherZero
  Ising2DLambda.PartitionPolynomial

/-- The generic partition statement specializes to oriented edges and their sources. -/
theorem taggedMatching_local_pair_unique_from_necSuf {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (v : Vertex L) (h : OrientedEdge L) :
    (h.1 ∈ taggedComplementEdges D t ∧ orientedSource h = v) ↔
      ∃! p : OrientedEdge L × OrientedEdge L,
        p ∈ t ∧ orientedSource p.1 = v ∧ (h = p.1 ∨ h = p.2) := by
  classical
  obtain ⟨hLong, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  exact Ising2DLambda.NecSuf.KacWard.local_pair_unique_of_partition
    t Prod.fst Prod.snd orientedSource
    (fun h => h.1 ∈ taggedComplementEdges D t)
    (fun h => complement_iff_short_endpoint D t ht hLong h)
    (fun p hp => (hShort p hp).1.symm)
    (by
      intro p hp q hq x hxp hxq
      have hxp' : x ∈ [p.1, p.2] := by rcases hxp with rfl | rfl <;> simp
      have hxq' : x ∈ [q.1, q.2] := by rcases hxq with rfl | rfl <;> simp
      exact matchingOrientedPairs_disjoint D (ht hp) (ht hq) hxp' hxq')
    v h

/-- The concrete statement is obtained from the endpoint partition argument. -/
theorem taggedMatching_mate_outside_complement_from_necSuf {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (h : OrientedEdge L) (hh : h.1 ∉ taggedComplementEdges D t) :
    perfectMatchingMate D h = reversal h := by
  classical
  obtain ⟨hLong, _⟩ := taggedMatching_nonzero_term_support z s D t hterm
  exact Ising2DLambda.NecSuf.KacWard.mate_outside_selected_eq_reverse
    (matchingOrientedPairs D) t Prod.fst Prod.snd
    (perfectMatchingMate D) reversal
    (fun k => k.1 ∈ taggedComplementEdges D t)
    (matching_pair_cover D)
    (by
      intro p hp
      have hp' := (Finset.mem_filter.mp hp).2
      exact perfectMatchingMate_eq_of_pair D p.1 p.2 hp'.1.ne' hp'.2)
    (perfectMatchingMate_involutive D) reversal_involutive
    (by
      intro p hpt
      exact ⟨(complement_iff_short_endpoint D t ht hLong p.1).2
        ⟨p, hpt, Or.inl rfl⟩,
        (complement_iff_short_endpoint D t ht hLong p.2).2
        ⟨p, hpt, Or.inr rfl⟩⟩)
    hLong h hh

end Ising2DLambda.KacWard
