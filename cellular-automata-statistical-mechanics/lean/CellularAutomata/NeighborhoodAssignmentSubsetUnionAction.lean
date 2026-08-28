/-
章「近傍割り当てが部分集合に定める合併作用」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-subset-union-action.ts。

有限舞台、有限近傍割り当て、有限部分集合だけを使う。ℝ / ℂ は現れない。
-/
import CellularAutomata.FiniteNeighborhoodAssignmentMonoid

namespace CellularAutomata.NeighborhoodAssignmentSubsetUnionAction

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_finite_stage_subset_space` の有限舞台の部分集合全体。 -/
abbrev SubsetSpace (V : Type) [DecidableEq V] := Finset V

/-- `def_neighborhood_assignment_subset_union_map` の
    U_N(S) = ⋃_{v ∈ S} N(v)。 -/
def subsetUnionMap (N : NeighborhoodAssignment V) (S : SubsetSpace V) : SubsetSpace V :=
  S.biUnion N

omit [Fintype V] in
/-- `claim_neighborhood_assignment_subset_union_map_composition`。
    人手証明と同じ存在量化の並べ替えで U_(N ⋆ M) = U_M ∘ U_N を示す。 -/
theorem subsetUnionMap_composedNeighborhood (N M : NeighborhoodAssignment V) :
    subsetUnionMap (composedNeighborhood N M) = subsetUnionMap M ∘ subsetUnionMap N := by
  funext S
  ext w
  simp only [subsetUnionMap, composedNeighborhood, Finset.mem_biUnion, Function.comp_apply]
  constructor
  · rintro ⟨v, hvS, u, huN, hwM⟩
    exact ⟨u, ⟨v, hvS, huN⟩, hwM⟩
  · rintro ⟨u, ⟨v, hvS, huN⟩, hwM⟩
    exact ⟨v, hvS, u, huN, hwM⟩

omit [Fintype V] in
/-- `claim_identity_neighborhood_subset_union_map`。 -/
theorem subsetUnionMap_identityNeighborhood :
    subsetUnionMap (identityNeighborhood V) = id := by
  funext S
  ext w
  simp [subsetUnionMap, identityNeighborhood]

omit [Fintype V] in
/-- `claim_neighborhood_assignment_recovered_from_singletons`。 -/
theorem subsetUnionMap_singleton (N : NeighborhoodAssignment V) (v : V) :
    subsetUnionMap N {v} = N v := by
  ext w
  simp [subsetUnionMap]

omit [Fintype V] in
/-- `claim_neighborhood_assignment_subset_union_map_injective`。 -/
theorem subsetUnionMap_injective :
    Function.Injective (subsetUnionMap (V := V)) := by
  intro N M h
  funext v
  calc
    N v = subsetUnionMap N {v} := (subsetUnionMap_singleton N v).symm
    _ = subsetUnionMap M {v} := congrFun h {v}
    _ = M v := subsetUnionMap_singleton M v

omit [Fintype V] in
/-- `claim_neighborhood_assignment_idempotent_iff_subset_union_map_idempotent`。 -/
theorem composedNeighborhood_idempotent_iff_subsetUnionMap_idempotent
    (N : NeighborhoodAssignment V) :
    composedNeighborhood N N = N ↔ subsetUnionMap N ∘ subsetUnionMap N = subsetUnionMap N := by
  constructor
  · intro h
    rw [← subsetUnionMap_composedNeighborhood N N, h]
  · intro h
    apply subsetUnionMap_injective
    rw [subsetUnionMap_composedNeighborhood]
    exact h

/-- `def_finite_stage_subset_space` の元数 |Sub(V)| = 2^|V|。 -/
theorem card_subsetSpace :
    Fintype.card (SubsetSpace V) = 2 ^ Fintype.card V := by
  exact Fintype.card_finset

/-- `claim_neighborhood_assignment_subset_union_map_finite_decidable` の全表。 -/
def subsetUnionMapTable (N : NeighborhoodAssignment V) :
    Finset (SubsetSpace V × SubsetSpace V) :=
  Finset.univ.image (fun S => (S, subsetUnionMap N S))

/-- 全表は任意の入力とその合併像を含む。 -/
theorem mem_subsetUnionMapTable (N : NeighborhoodAssignment V) (S : SubsetSpace V) :
    (S, subsetUnionMap N S) ∈ subsetUnionMapTable N := by
  simp [subsetUnionMapTable]

/-- 合併写像の冪等性は有限舞台上で決定可能である。 -/
instance instDecidableSubsetUnionMapIdempotent (N : NeighborhoodAssignment V) :
    Decidable (subsetUnionMap N ∘ subsetUnionMap N = subsetUnionMap N) :=
  inferInstance

end CellularAutomata.NeighborhoodAssignmentSubsetUnionAction
