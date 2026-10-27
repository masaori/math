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

end Ising2DLambda.KacWard
