import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatching
import Mathlib.Data.Set.SymmDiff

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

variable {J : Type*} [Fintype J]

/-- The pair at a point retains its label as separate data. -/
noncomputable def taggedPairAt (D : PerfectMatching J) (T : Set (Set J)) (i : J) :
    Set J × Bool := by
  classical
  let p : Set J := {i, perfectMatchingMate D i}
  exact (p, decide (p ∈ T))

/-- The two-element set and the label are both part of an edge. -/
noncomputable def taggedEdges (D : PerfectMatching J) (T : Set (Set J)) :
    Set (Set J × Bool) := by
  classical
  exact {q | ∃ p ∈ D.val, q = (p, decide (p ∈ T))}

theorem taggedEdges_incident_iff (D : PerfectMatching J) (T : Set (Set J))
    (i : J) (q : Set J × Bool) :
    (q ∈ taggedEdges D T ∧ i ∈ q.1) ↔ q = taggedPairAt D T i := by
  classical
  constructor
  · rintro ⟨⟨p, hp, rfl⟩, hi⟩
    have hp0 : ({i, perfectMatchingMate D i} : Set J) ∈ D.val :=
      (perfectMatchingMate_spec D i).2
    have heq : p = ({i, perfectMatchingMate D i} : Set J) :=
      (D.property.2 i).unique ⟨hp, hi⟩ ⟨hp0, by simp⟩
    subst p
    rfl
  · intro h
    rw [h]
    constructor
    · exact ⟨{i, perfectMatchingMate D i},
        (perfectMatchingMate_spec D i).2, rfl⟩
    · simp [taggedPairAt]

/-- At every point the two incident pairs cancel together, or both survive.
    If every long pair of the first matching belongs to the reference matching,
    a surviving pair of the first matching must have the short label. -/
theorem taggedDifference_local_degree (D R : PerfectMatching J)
    (T : Set (Set J))
    (hLong : ∀ p ∈ D.val, p ∉ T → p ∈ R.val) (i : J) :
    let d := taggedPairAt D T i
    let r := taggedPairAt R ∅ i
    (d = r ∨ (d ≠ r ∧ d.2 = true ∧ r.2 = false)) := by
  classical
  dsimp
  by_cases hshort : ({i, perfectMatchingMate D i} : Set J) ∈ T
  · right
    constructor
    · intro heq
      have htag := congrArg Prod.snd heq
      simp [taggedPairAt, hshort] at htag
    · simp [taggedPairAt, hshort]
  · left
    have hp : ({i, perfectMatchingMate D i} : Set J) ∈ R.val :=
      hLong _ (perfectMatchingMate_spec D i).2 hshort
    have hm : perfectMatchingMate R i = perfectMatchingMate D i :=
      perfectMatchingMate_eq_of_pair R i (perfectMatchingMate D i)
        (perfectMatchingMate_spec D i).1 hp
    simp [taggedPairAt, hshort, hm]

theorem taggedDifference_incident_iff (D R : PerfectMatching J)
    (T : Set (Set J))
    (i : J) (q : Set J × Bool) :
    let d := taggedPairAt D T i
    let r := taggedPairAt R ∅ i
    (q ∈ (taggedEdges D T ∆ taggedEdges R ∅) ∧ i ∈ q.1) ↔
      d ≠ r ∧ (q = d ∨ q = r) := by
  classical
  dsimp
  have hD := taggedEdges_incident_iff D T i q
  have hR := taggedEdges_incident_iff R ∅ i q
  have hdmem : i ∈ (taggedPairAt D T i).1 := by simp [taggedPairAt]
  have hrmem : i ∈ (taggedPairAt R ∅ i).1 := by simp [taggedPairAt]
  constructor
  · rintro ⟨hq, hi⟩
    rcases Set.mem_symmDiff.mp hq with ⟨ha, hb⟩ | ⟨hb, ha⟩
    · have hqd := hD.mp ⟨ha, hi⟩
      refine ⟨?_, Or.inl hqd⟩
      intro heq
      exact hb ((hR.mpr (hqd.trans heq)).1)
    · have hqr := hR.mp ⟨hb, hi⟩
      refine ⟨?_, Or.inr hqr⟩
      intro heq
      exact ha ((hD.mpr (hqr.trans heq.symm)).1)
  · rintro ⟨hne, hq⟩
    rcases hq with hq | hq
    · have hi : i ∈ q.1 := hq ▸ hdmem
      refine ⟨Set.mem_symmDiff.mpr (Or.inl ⟨(hD.mpr hq).1, ?_⟩), hi⟩
      intro hb
      exact hne (hq.symm.trans (hR.mp ⟨hb, hi⟩))
    · have hi : i ∈ q.1 := hq ▸ hrmem
      refine ⟨Set.mem_symmDiff.mpr (Or.inr ⟨(hR.mpr hq).1, ?_⟩), hi⟩
      intro ha
      exact hne ((hD.mp ⟨ha, hi⟩).symm.trans hq)

end Ising2DLambda.NecSuf.KacWard
