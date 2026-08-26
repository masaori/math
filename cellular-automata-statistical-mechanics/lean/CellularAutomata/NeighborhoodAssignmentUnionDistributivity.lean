/-
章「近傍割り当ての点ごとの和と合成の分配性」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-union-distributivity.ts。

有限舞台、有限近傍割り当て、有限集合の合併だけを使う。ℝ / ℂ は現れない。
-/
import CellularAutomata.OrderedNeighborhoodAssignmentMonoid

namespace CellularAutomata.NeighborhoodAssignmentUnionDistributivity

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.OrderedNeighborhoodAssignmentMonoid

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_empty_neighborhood_assignment` の空近傍割り当て。 -/
def emptyNeighborhood (V : Type) [DecidableEq V] : NeighborhoodAssignment V :=
  fun _ => ∅

/-- `def_neighborhood_assignment_pointwise_union` の点ごとの和。 -/
def pointwiseUnion (N M : NeighborhoodAssignment V) : NeighborhoodAssignment V :=
  fun v => N v ∪ M v

omit [Fintype V] in
theorem pointwiseUnion_comm (N M : NeighborhoodAssignment V) :
    pointwiseUnion N M = pointwiseUnion M N := by
  funext v
  exact Finset.union_comm (N v) (M v)

omit [Fintype V] in
theorem pointwiseUnion_assoc (N M L : NeighborhoodAssignment V) :
    pointwiseUnion (pointwiseUnion N M) L = pointwiseUnion N (pointwiseUnion M L) := by
  funext v
  exact Finset.union_assoc (N v) (M v) (L v)

omit [Fintype V] in
theorem pointwiseUnion_idem (N : NeighborhoodAssignment V) : pointwiseUnion N N = N := by
  funext v
  exact Finset.union_self (N v)

omit [Fintype V] in
theorem pointwiseUnion_empty_right (N : NeighborhoodAssignment V) :
    pointwiseUnion N (emptyNeighborhood V) = N := by
  funext v
  simp [pointwiseUnion, emptyNeighborhood]

omit [Fintype V] in
theorem pointwiseUnion_empty_left (N : NeighborhoodAssignment V) :
    pointwiseUnion (emptyNeighborhood V) N = N := by
  rw [pointwiseUnion_comm]
  exact pointwiseUnion_empty_right N

omit [Fintype V] in
/-- `claim_neighborhood_assignment_inclusion_iff_union_eq`。 -/
theorem pointwiseInclusion_iff_union_eq (N M : NeighborhoodAssignment V) :
    PointwiseInclusion N M ↔ pointwiseUnion N M = M := by
  constructor
  · intro h
    funext v
    exact Finset.union_eq_right.mpr (h v)
  · intro h v w hw
    have hwUnion : w ∈ pointwiseUnion N M v := by
      simp [pointwiseUnion, hw]
    rw [h] at hwUnion
    exact hwUnion

omit [Fintype V] in
/-- 人手証明の第一の分配律 `(N ⊔ M) ⋆ L = (N ⋆ L) ⊔ (M ⋆ L)`。 -/
theorem pointwiseUnion_composedNeighborhood (N M L : NeighborhoodAssignment V) :
    composedNeighborhood (pointwiseUnion N M) L =
      pointwiseUnion (composedNeighborhood N L) (composedNeighborhood M L) := by
  funext v
  ext w
  simp only [composedNeighborhood, pointwiseUnion, Finset.mem_biUnion, Finset.mem_union]
  constructor
  · rintro ⟨u, huN | huM, hwL⟩
    · exact Or.inl ⟨u, huN, hwL⟩
    · exact Or.inr ⟨u, huM, hwL⟩
  · rintro (⟨u, huN, hwL⟩ | ⟨u, huM, hwL⟩)
    · exact ⟨u, Or.inl huN, hwL⟩
    · exact ⟨u, Or.inr huM, hwL⟩

omit [Fintype V] in
/-- 人手証明の第二の分配律 `L ⋆ (N ⊔ M) = (L ⋆ N) ⊔ (L ⋆ M)`。 -/
theorem composedNeighborhood_pointwiseUnion (L N M : NeighborhoodAssignment V) :
    composedNeighborhood L (pointwiseUnion N M) =
      pointwiseUnion (composedNeighborhood L N) (composedNeighborhood L M) := by
  funext v
  ext w
  simp only [composedNeighborhood, pointwiseUnion, Finset.mem_biUnion, Finset.mem_union]
  constructor
  · rintro ⟨u, huL, hwN | hwM⟩
    · exact Or.inl ⟨u, huL, hwN⟩
    · exact Or.inr ⟨u, huL, hwM⟩
  · rintro (⟨u, huL, hwN⟩ | ⟨u, huL, hwM⟩)
    · exact ⟨u, huL, Or.inl hwN⟩
    · exact ⟨u, huL, Or.inr hwM⟩

omit [Fintype V] in
theorem empty_composedNeighborhood (N : NeighborhoodAssignment V) :
    composedNeighborhood (emptyNeighborhood V) N = emptyNeighborhood V := by
  funext v
  simp [composedNeighborhood, emptyNeighborhood]

omit [Fintype V] in
theorem composedNeighborhood_empty (N : NeighborhoodAssignment V) :
    composedNeighborhood N (emptyNeighborhood V) = emptyNeighborhood V := by
  funext v
  ext w
  simp [composedNeighborhood, emptyNeighborhood]

/-- 点ごとの和の全演算表。 -/
def unionTable :
    Finset (NeighborhoodAssignment V × NeighborhoodAssignment V × NeighborhoodAssignment V) :=
  Finset.univ.image (fun p : NeighborhoodAssignment V × NeighborhoodAssignment V =>
    (p.1, p.2, pointwiseUnion p.1 p.2))

theorem mem_unionTable (N M : NeighborhoodAssignment V) :
    (N, M, pointwiseUnion N M) ∈ unionTable := by
  simp [unionTable]

omit [Fintype V] in
/-- `claim_finite_neighborhood_assignments_form_idempotent_semiring` の全公理。
    合成表は既出の `compositionTable`、和の表は `unionTable` で有限決定される。 -/
theorem finite_idempotent_semiring_laws :
    (pointwiseUnion (emptyNeighborhood V) = id) ∧
    (∀ N M : NeighborhoodAssignment V, pointwiseUnion N M = pointwiseUnion M N) ∧
    (∀ N M L : NeighborhoodAssignment V,
      pointwiseUnion (pointwiseUnion N M) L = pointwiseUnion N (pointwiseUnion M L)) ∧
    (∀ N : NeighborhoodAssignment V, pointwiseUnion N N = N) ∧
    (∀ N M L : NeighborhoodAssignment V, composedNeighborhood (pointwiseUnion N M) L =
      pointwiseUnion (composedNeighborhood N L) (composedNeighborhood M L)) ∧
    (∀ L N M : NeighborhoodAssignment V, composedNeighborhood L (pointwiseUnion N M) =
      pointwiseUnion (composedNeighborhood L N) (composedNeighborhood L M)) ∧
    (∀ N : NeighborhoodAssignment V,
      composedNeighborhood (emptyNeighborhood V) N = emptyNeighborhood V) ∧
    (∀ N : NeighborhoodAssignment V,
      composedNeighborhood N (emptyNeighborhood V) = emptyNeighborhood V) := by
  refine ⟨?_, pointwiseUnion_comm, pointwiseUnion_assoc, pointwiseUnion_idem,
    pointwiseUnion_composedNeighborhood, composedNeighborhood_pointwiseUnion,
    empty_composedNeighborhood, composedNeighborhood_empty⟩
  funext N
  exact pointwiseUnion_empty_left N

end CellularAutomata.NeighborhoodAssignmentUnionDistributivity
