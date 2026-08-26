/-
章「近傍割り当ての点ごとの和と合成の分配性」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-union-distributivity.ts。

有限舞台、有限近傍割り当て、有限集合の合併だけを使う。ℝ / ℂ は現れない。
-/
import CellularAutomata.OrderedNeighborhoodAssignmentMonoid
import CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity

namespace CellularAutomata.NeighborhoodAssignmentUnionDistributivity

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.OrderedNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity

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


/-! ### 必要十分版からの導出

必要十分版は NecSuf/NeighborhoodAssignmentUnionDistributivity.lean にある。
ここでは具体版の各主張が、その特殊化として得られることを示す。 -/

namespace Derivation

omit [Fintype V] in
/-- 具体版の空近傍割り当ては、必要十分版の型をまたぐ空近傍割り当てを
    同じ型に取ったものである。 -/
theorem emptyNeighborhood_eq_necSuf :
    emptyNeighborhood V = hetEmpty V V := rfl

omit [Fintype V] in
/-- 具体版の点ごとの和は、必要十分版の型をまたぐ和を同じ型に取ったものである。 -/
theorem pointwiseUnion_eq_necSuf (N M : NeighborhoodAssignment V) :
    pointwiseUnion N M = hetUnion N M := rfl

omit [Fintype V] in
/-- 具体版の可換律は、必要十分版の可換律の特殊化である。 -/
theorem pointwiseUnion_comm_of_necSuf (N M : NeighborhoodAssignment V) :
    pointwiseUnion N M = pointwiseUnion M N :=
  hetUnion_comm N M

omit [Fintype V] in
/-- 具体版の結合律は、必要十分版の結合律の特殊化である。 -/
theorem pointwiseUnion_assoc_of_necSuf (N M L : NeighborhoodAssignment V) :
    pointwiseUnion (pointwiseUnion N M) L = pointwiseUnion N (pointwiseUnion M L) :=
  hetUnion_assoc N M L

omit [Fintype V] in
/-- 具体版の冪等律は、必要十分版の冪等律の特殊化である。 -/
theorem pointwiseUnion_idem_of_necSuf (N : NeighborhoodAssignment V) :
    pointwiseUnion N N = N :=
  hetUnion_idem N

omit [Fintype V] in
/-- 具体版の右単位律は、必要十分版の右単位律の特殊化である。 -/
theorem pointwiseUnion_empty_right_of_necSuf (N : NeighborhoodAssignment V) :
    pointwiseUnion N (emptyNeighborhood V) = N :=
  hetUnion_empty_right N

omit [Fintype V] in
/-- 具体版の左単位律は、必要十分版の左単位律の特殊化である。 -/
theorem pointwiseUnion_empty_left_of_necSuf (N : NeighborhoodAssignment V) :
    pointwiseUnion (emptyNeighborhood V) N = N :=
  hetUnion_empty_left N

omit [Fintype V] in
/-- 具体版の包含順序の特徴づけは、必要十分版の特徴づけの特殊化である。 -/
theorem pointwiseInclusion_iff_union_eq_of_necSuf (N M : NeighborhoodAssignment V) :
    PointwiseInclusion N M ↔ pointwiseUnion N M = M :=
  hetInclusion_iff_hetUnion_eq N M

omit [Fintype V] in
/-- 具体版の第一の分配律は、必要十分版の型をまたぐ分配律を同じ型に取ったものである。 -/
theorem pointwiseUnion_composedNeighborhood_of_necSuf (N M L : NeighborhoodAssignment V) :
    composedNeighborhood (pointwiseUnion N M) L =
      pointwiseUnion (composedNeighborhood N L) (composedNeighborhood M L) :=
  hetUnion_hetComp N M L

omit [Fintype V] in
/-- 具体版の第二の分配律は、必要十分版の型をまたぐ分配律を同じ型に取ったものである。
    必要十分版はこちらでは中間の型の等号判定を要求していない。 -/
theorem composedNeighborhood_pointwiseUnion_of_necSuf (L N M : NeighborhoodAssignment V) :
    composedNeighborhood L (pointwiseUnion N M) =
      pointwiseUnion (composedNeighborhood L N) (composedNeighborhood L M) :=
  hetComp_hetUnion L N M

omit [Fintype V] in
/-- 具体版の左吸収は、必要十分版の左吸収の特殊化である。 -/
theorem empty_composedNeighborhood_of_necSuf (N : NeighborhoodAssignment V) :
    composedNeighborhood (emptyNeighborhood V) N = emptyNeighborhood V :=
  hetEmpty_hetComp N

omit [Fintype V] in
/-- 具体版の右吸収は、必要十分版の右吸収の特殊化である。 -/
theorem composedNeighborhood_empty_of_necSuf (N : NeighborhoodAssignment V) :
    composedNeighborhood N (emptyNeighborhood V) = emptyNeighborhood V :=
  hetComp_hetEmpty N

/-- 具体版の和の演算表は、必要十分版の型をまたぐ表を同じ型に取ったものである。 -/
theorem unionTable_eq_necSuf :
    unionTable (V := V) = hetUnionTable V V := rfl

omit [Fintype V] in
/-- 具体版の冪等半環の全公理は、必要十分版の全公理の特殊化である。 -/
theorem finite_idempotent_semiring_laws_of_necSuf :
    (∀ N : NeighborhoodAssignment V, pointwiseUnion (emptyNeighborhood V) N = N) ∧
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
      composedNeighborhood N (emptyNeighborhood V) = emptyNeighborhood V) :=
  idempotent_semiring_laws (V := V)

omit [Fintype V] in
/-- 具体版が `Finset` で要求する等号判定は有限表現のためだけであり、
    点ごとの和そのものは集合として読んでも同じ演算である。 -/
theorem pointwiseUnion_coe_eq_setUnion (N M : NeighborhoodAssignment V) (v : V) :
    ((pointwiseUnion N M v : Finset V) : Set V) =
      setUnion (fun v => ((N v : Finset V) : Set V))
        (fun v => ((M v : Finset V) : Set V)) v :=
  coe_hetUnion N M v

end Derivation

end CellularAutomata.NeighborhoodAssignmentUnionDistributivity
