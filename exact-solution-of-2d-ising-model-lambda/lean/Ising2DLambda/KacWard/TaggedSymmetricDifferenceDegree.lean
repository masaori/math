import Ising2DLambda.KacWard.NonzeroLongPairReference
import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.NecSuf.KacWard.TaggedSymmetricDifferenceDegree
import Mathlib.Data.Set.SymmDiff

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

/-- A short label is retained even when its underlying pair is a reversal pair. -/
def shortUnderlyingPairs {L : ℕ}
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    Set (Set (OrientedEdge L)) :=
  {q | ∃ p ∈ t, q = {p.1, p.2}}

theorem shortUnderlyingPairs_iff {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (p : OrientedEdge L × OrientedEdge L)
    (hp : p ∈ matchingOrientedPairs D) :
    ({p.1, p.2} : Set (OrientedEdge L)) ∈ shortUnderlyingPairs t ↔ p ∈ t := by
  classical
  constructor
  · rintro ⟨q, hq, heq⟩
    have hmem : p.1 ∈ ({q.1, q.2} : Set (OrientedEdge L)) := by
      rw [← heq]
      simp
    have hpq : p = q := matchingOrientedPairs_disjoint D hp (ht hq) (x := p.1)
      (by simp) (by simpa using hmem)
    rwa [hpq]
  · intro h
    exact ⟨p, h, rfl⟩

/-- The matching pairs retain their short labels as data. -/
noncomputable def concreteTaggedPairs {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    Set (Set (OrientedEdge L) × Bool) := by
  classical
  exact {q | ∃ p ∈ D.val, q = (p, decide (p ∈ shortUnderlyingPairs t))}

/-- Every reference pair has the long label. -/
def concreteReferenceTaggedPairs (L : ℕ) :
    Set (Set (OrientedEdge L) × Bool) :=
  {q | ∃ p ∈ referenceLongPairs L, q = (p, false)}

/-- Symmetric difference is taken after attaching labels. -/
noncomputable def concreteTaggedDifference {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    Set (Set (OrientedEdge L) × Bool) :=
  concreteTaggedPairs D t ∆ concreteReferenceTaggedPairs L

/-- An oriented edge is active when it meets a retained labelled pair. -/
noncomputable def concreteTaggedActiveVertices {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    Set (OrientedEdge L) :=
  {e | ∃ q ∈ concreteTaggedDifference D t, e ∈ q.1}

theorem taggedDifference_local_degree {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (e : OrientedEdge L) :
    let R : PerfectMatching (OrientedEdge L) :=
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
    let d := Ising2DLambda.NecSuf.KacWard.taggedPairAt D
      (shortUnderlyingPairs t) e
    let r := Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ e
    d = r ∨ (d ≠ r ∧ d.2 = true ∧ r.2 = false) := by
  classical
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  have hLong : ∀ q ∈ D.val, q ∉ shortUnderlyingPairs t → q ∈ R.val := by
    intro q hq hn
    obtain ⟨i, j, hij, hqij⟩ := D.property.1 q hq
    obtain ⟨p, hp, hip⟩ := matching_pair_cover D i
    have hpD : ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val :=
      (Finset.mem_filter.mp hp).2.2
    have hpi : i ∈ ({p.1, p.2} : Set (OrientedEdge L)) := by
      rcases hip with h | h <;> simp [h]
    have hqeq : q = ({p.1, p.2} : Set (OrientedEdge L)) := by
      exact (D.property.2 i).unique ⟨hq, by rw [hqij]; simp⟩ ⟨hpD, hpi⟩
    have hpt : p ∉ t := by
      intro hpt
      apply hn
      exact ⟨p, hpt, hqeq⟩
    have hpr := nonzeroLongPair_mem_referenceLongPairs z s D t hterm p
      (Finset.mem_sdiff.mpr ⟨hp, hpt⟩)
    change q ∈ referenceLongPairs L
    rwa [hqeq]
  dsimp
  by_cases hshort : ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈
      shortUnderlyingPairs t
  · right
    constructor
    · intro heq
      have htag := congrArg Prod.snd heq
      simp [Ising2DLambda.NecSuf.KacWard.taggedPairAt, hshort] at htag
    · simp [Ising2DLambda.NecSuf.KacWard.taggedPairAt, hshort]
  · left
    have hp : ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈ R.val :=
      hLong _ (perfectMatchingMate_spec D e).2 hshort
    have hm : perfectMatchingMate R e = perfectMatchingMate D e :=
      perfectMatchingMate_eq_of_pair R e (perfectMatchingMate D e)
        (perfectMatchingMate_spec D e).1 hp
    simp [Ising2DLambda.NecSuf.KacWard.taggedPairAt, hshort]
    exact congrArg (fun x : OrientedEdge L =>
      ({e, x} : Set (OrientedEdge L))) hm.symm

theorem taggedDifference_incident_iff {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (e : OrientedEdge L) (q : Set (OrientedEdge L) × Bool) :
    let R : PerfectMatching (OrientedEdge L) :=
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
    (q ∈ (Ising2DLambda.NecSuf.KacWard.taggedEdges D (shortUnderlyingPairs t) ∆
      Ising2DLambda.NecSuf.KacWard.taggedEdges R ∅) ∧ e ∈ q.1) ↔
      let d := Ising2DLambda.NecSuf.KacWard.taggedPairAt D
        (shortUnderlyingPairs t) e
      let r := Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ e
      d ≠ r ∧ (q = d ∨ q = r) := by
  classical
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let d := Ising2DLambda.NecSuf.KacWard.taggedPairAt D (shortUnderlyingPairs t) e
  let r := Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ e
  have hD (u : Set (OrientedEdge L) × Bool) :
      (u ∈ concreteTaggedPairs D t ∧ e ∈ u.1) ↔ u = d := by
    constructor
    · rintro ⟨⟨p, hp, rfl⟩, he⟩
      have hp0 : ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈ D.val :=
        (perfectMatchingMate_spec D e).2
      have heq : p = ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) :=
        (D.property.2 e).unique ⟨hp, he⟩ ⟨hp0, by simp⟩
      subst p
      rfl
    · intro hu
      rw [hu]
      exact ⟨⟨{e, perfectMatchingMate D e},
        (perfectMatchingMate_spec D e).2, rfl⟩,
        by simp [d, Ising2DLambda.NecSuf.KacWard.taggedPairAt]⟩
  have hR (u : Set (OrientedEdge L) × Bool) :
      (u ∈ concreteReferenceTaggedPairs L ∧ e ∈ u.1) ↔ u = r := by
    constructor
    · rintro ⟨⟨p, hp, rfl⟩, he⟩
      have hp0 : ({e, perfectMatchingMate R e} : Set (OrientedEdge L)) ∈ R.val :=
        (perfectMatchingMate_spec R e).2
      have heq : p = ({e, perfectMatchingMate R e} : Set (OrientedEdge L)) :=
        (R.property.2 e).unique ⟨hp, he⟩ ⟨hp0, by simp⟩
      subst p
      simp [r, Ising2DLambda.NecSuf.KacWard.taggedPairAt]
    · intro hu
      rw [hu]
      exact ⟨⟨{e, perfectMatchingMate R e},
        (perfectMatchingMate_spec R e).2,
        by simp [r, Ising2DLambda.NecSuf.KacWard.taggedPairAt]⟩,
        by simp [r, Ising2DLambda.NecSuf.KacWard.taggedPairAt]⟩
  have hdmem : e ∈ d.1 := by simp [d, Ising2DLambda.NecSuf.KacWard.taggedPairAt]
  have hrmem : e ∈ r.1 := by simp [r, Ising2DLambda.NecSuf.KacWard.taggedPairAt]
  have hEq : concreteTaggedDifference D t =
      Ising2DLambda.NecSuf.KacWard.taggedEdges D (shortUnderlyingPairs t) ∆
        Ising2DLambda.NecSuf.KacWard.taggedEdges R ∅ := by
    ext u
    simp [concreteTaggedDifference, concreteTaggedPairs,
      concreteReferenceTaggedPairs, Ising2DLambda.NecSuf.KacWard.taggedEdges, R]
  dsimp
  rw [← hEq]
  change (q ∈ concreteTaggedPairs D t ∆ concreteReferenceTaggedPairs L ∧ e ∈ q.1) ↔
    d ≠ r ∧ (q = d ∨ q = r)
  constructor
  · rintro ⟨hq, he⟩
    rcases Set.mem_symmDiff.mp hq with ⟨ha, hb⟩ | ⟨hb, ha⟩
    · have hqd := (hD q).mp ⟨ha, he⟩
      refine ⟨?_, Or.inl hqd⟩
      intro heq
      exact hb ((hR q).mpr (hqd.trans heq)).1
    · have hqr := (hR q).mp ⟨hb, he⟩
      refine ⟨?_, Or.inr hqr⟩
      intro heq
      exact ha ((hD q).mpr (hqr.trans heq.symm)).1
  · rintro ⟨hne, hq⟩
    rcases hq with hq | hq
    · have he : e ∈ q.1 := hq ▸ hdmem
      refine ⟨Set.mem_symmDiff.mpr (Or.inl ⟨((hD q).mpr hq).1, ?_⟩), he⟩
      intro hb
      exact hne (hq.symm.trans ((hR q).mp ⟨hb, he⟩))
    · have he : e ∈ q.1 := hq ▸ hrmem
      refine ⟨Set.mem_symmDiff.mpr (Or.inr ⟨((hR q).mpr hq).1, ?_⟩), he⟩
      intro ha
      exact hne (((hD q).mp ⟨ha, he⟩).symm.trans hq)

end Ising2DLambda.KacWard
