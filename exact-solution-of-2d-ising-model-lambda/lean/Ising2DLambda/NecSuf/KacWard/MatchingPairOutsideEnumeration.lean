import Mathlib.Data.Finset.Sort

namespace Ising2DLambda.NecSuf.KacWard

attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 活動点の外にある完全マッチングの対を、第一端点の昇順に並べる。 -/
noncomputable def matchingPairOutsideEnumeration (mate : J → J) (A : Set J) :
    List (J × J) :=
  ((Finset.univ.filter (fun e : J => e ∉ A ∧ e < mate e)).sort (· ≤ ·)).map
    (fun e => (e, mate e))

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
