import Ising2DLambda.NecSuf.KacWard.AlternatingComponentCover
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceActiveVertices

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue
open scoped symmDiff

variable {J : Type*} [Fintype J]

/-- A retained labelled pair has both endpoints in one alternating component.
    The label is kept when the two matchings contain the same two-element set. -/
theorem taggedDifference_pair_mem_component (D R : PerfectMatching J)
    (T : Set (Set J)) (q : Set J × Bool)
    (hq : q ∈ taggedEdges D T ∆ taggedEdges R ∅)
    (i j : J) (hi : i ∈ q.1) (hj : j ∈ q.1) :
    let A := activeVertices D R T
    let τ : {k : J // k ∈ A} → {k : J // k ∈ A} :=
      fun k => ⟨perfectMatchingMate D k.1,
        (activeVertices_mates D R T k.1 k.2).1⟩
    let υ : {k : J // k ∈ A} → {k : J // k ∈ A} :=
      fun k => ⟨perfectMatchingMate R k.1,
        (activeVertices_mates D R T k.1 k.2).2⟩
    (⟨j, (mem_activeVertices_iff_incident D R T j).2 ⟨q, hq, hj⟩⟩ :
      {k : J // k ∈ A}) ∈
      matchingPairComponent τ υ
        (fun k => Subtype.ext (perfectMatchingMate_involutive D k.1))
        (fun k => Subtype.ext (perfectMatchingMate_involutive R k.1))
        ⟨i, (mem_activeVertices_iff_incident D R T i).2 ⟨q, hq, hi⟩⟩ := by
  classical
  dsimp
  let A := activeVertices D R T
  let τ : {k : J // k ∈ A} → {k : J // k ∈ A} :=
    fun k => ⟨perfectMatchingMate D k.1,
      (activeVertices_mates D R T k.1 k.2).1⟩
  let υ : {k : J // k ∈ A} → {k : J // k ∈ A} :=
    fun k => ⟨perfectMatchingMate R k.1,
      (activeVertices_mates D R T k.1 k.2).2⟩
  let ii : {k : J // k ∈ A} :=
    ⟨i, (mem_activeVertices_iff_incident D R T i).2 ⟨q, hq, hi⟩⟩
  let jj : {k : J // k ∈ A} :=
    ⟨j, (mem_activeVertices_iff_incident D R T j).2 ⟨q, hq, hj⟩⟩
  have hτ : Function.Involutive τ :=
    fun k => Subtype.ext (perfectMatchingMate_involutive D k.1)
  have hυ : Function.Involutive υ :=
    fun k => Subtype.ext (perfectMatchingMate_involutive R k.1)
  have hpair : (j = i ∨ j = perfectMatchingMate D i) ∨
      (j = i ∨ j = perfectMatchingMate R i) := by
    rcases Set.mem_symmDiff.mp hq with ⟨hD, _⟩ | ⟨hR, _⟩
    · obtain ⟨p, hp, hqeq⟩ := hD
      have hip : i ∈ p := by rw [hqeq] at hi; exact hi
      have hjp : j ∈ p := by rw [hqeq] at hj; exact hj
      have hp0 : ({i, perfectMatchingMate D i} : Set J) ∈ D.val :=
        (perfectMatchingMate_spec D i).2
      have heq : p = ({i, perfectMatchingMate D i} : Set J) :=
        (D.property.2 i).unique ⟨hp, hip⟩ ⟨hp0, by simp⟩
      left
      simpa [heq] using hjp
    · obtain ⟨p, hp, hqeq⟩ := hR
      have hip : i ∈ p := by rw [hqeq] at hi; exact hi
      have hjp : j ∈ p := by rw [hqeq] at hj; exact hj
      have hp0 : ({i, perfectMatchingMate R i} : Set J) ∈ R.val :=
        (perfectMatchingMate_spec R i).2
      have heq : p = ({i, perfectMatchingMate R i} : Set J) :=
        (R.property.2 i).unique ⟨hp, hip⟩ ⟨hp0, by simp⟩
      right
      simpa [heq] using hjp
  change jj ∈ matchingPairComponent τ υ hτ hυ ii
  rcases hpair with (h | h) | (h | h)
  · have hsub : jj = ii := Subtype.ext h
    rw [hsub]
    exact (alternatingComponent_cover_necSuf τ υ hτ hυ).1 ii
  · have hsub : jj = τ ii := Subtype.ext h
    rw [hsub]
    exact (alternatingComponent_cover_necSuf τ υ hτ hυ).2.2 ii |>.1
  · have hsub : jj = ii := Subtype.ext h
    rw [hsub]
    exact (alternatingComponent_cover_necSuf τ υ hτ hυ).1 ii
  · have hsub : jj = υ ii := Subtype.ext h
    rw [hsub]
    exact (alternatingComponent_cover_necSuf τ υ hτ hυ).2.2 ii |>.2

end Ising2DLambda.NecSuf.KacWard
