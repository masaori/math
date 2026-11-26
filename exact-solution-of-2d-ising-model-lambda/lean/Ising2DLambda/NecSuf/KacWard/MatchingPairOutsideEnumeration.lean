import Mathlib.Data.Finset.Sort

namespace Ising2DLambda.NecSuf.KacWard

attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 活動点の外にある完全マッチングの対を、第一端点の昇順に並べる。 -/
noncomputable def matchingPairOutsideEnumeration (mate : J → J) (A : Set J) :
    List (J × J) :=
  ((Finset.univ.filter (fun e : J => e ∉ A ∧ e < mate e)).sort (· ≤ ·)).map
    (fun e => (e, mate e))

/-- 列挙した対の端点は活動点の外にある。 -/
theorem matchingPairOutsideEnumeration_outside (mate : J → J) (A : Set J)
    (hinv : ∀ e, mate (mate e) = e)
    (hclosed : ∀ e, e ∈ A → mate e ∈ A)
    (x : J)
    (hx : x ∈ (matchingPairOutsideEnumeration mate A).flatMap (fun p => [p.1, p.2])) :
    x ∉ A := by
  obtain ⟨p, hp, hxp⟩ := List.mem_flatMap.mp hx
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp hp
  have he' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp he)).2
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hxp
  rcases hxp with rfl | rfl
  · exact he'.1
  · intro hm
    apply he'.1
    simpa only [hinv] using hclosed (mate e) hm

/-- 不動点のない対合で列挙した対の端点は互いに異なる。 -/
theorem matchingPairOutsideEnumeration_nodup (mate : J → J) (A : Set J)
    (hfix : ∀ e, mate e ≠ e) (hinv : ∀ e, mate (mate e) = e) :
    ((matchingPairOutsideEnumeration mate A).flatMap fun p => [p.1, p.2]).Nodup := by
  unfold matchingPairOutsideEnumeration
  rw [List.flatMap_map]
  apply List.nodup_flatMap.mpr
  refine ⟨fun e _ => ?_, ?_⟩
  · simpa using (hfix e).symm
  · apply List.Nodup.pairwise_of_forall_ne (Finset.sort_nodup _ _)
    intro a ha b hb hab
    have ha' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp ha)).2.2
    have hb' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp hb)).2.2
    intro x hxa hxb
    simp only [List.mem_cons, List.not_mem_nil, or_false] at hxa hxb
    have key : a = b ∨ a = mate b ∨ mate a = b ∨ mate a = mate b := by
      rcases hxa with h1 | h1 <;> rcases hxb with h2 | h2 <;> rw [h1] at h2 <;> simp [h2]
    rcases key with h | h | h | h
    · exact hab h
    · have hb2 : mate a = b := by rw [h, hinv]
      rw [hb2] at ha'
      rw [← h] at hb'
      exact absurd (ha'.trans hb') (lt_irrefl _)
    · have hb2 : mate b = a := by rw [← h, hinv]
      rw [h] at ha'
      rw [hb2] at hb'
      exact absurd (ha'.trans hb') (lt_irrefl _)
    · exact hab (by rw [← hinv a, h, hinv])

/-- 活動点の外で二つのマッチングの相手が一致すれば、列挙した各対は両方に属する。 -/
theorem matchingPairOutsideEnumeration_spec (D D₀ : Set (Set J)) (mate mate₀ : J → J)
    (A : Set J)
    (hD : ∀ e, ({e, mate e} : Set J) ∈ D)
    (hD₀ : ∀ e, ({e, mate₀ e} : Set J) ∈ D₀)
    (hout : ∀ e, e ∉ A → mate₀ e = mate e) :
    ∀ p ∈ matchingPairOutsideEnumeration mate A,
      p.1 < p.2 ∧ ({p.1, p.2} : Set J) ∈ D ∧ ({p.1, p.2} : Set J) ∈ D₀ := by
  intro p hp
  obtain ⟨e, he, rfl⟩ := List.mem_map.mp hp
  have he' := (Finset.mem_filter.mp ((Finset.mem_sort _).mp he)).2
  refine ⟨he'.2, hD e, ?_⟩
  rw [← hout e he'.1]
  exact hD₀ e

end Ising2DLambda.NecSuf.KacWard
