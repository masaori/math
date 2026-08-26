/-
章「近傍割り当ての点ごとの積と合成の非分配性」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-intersection-nondistributivity.ts。

有限舞台、有限近傍割り当て、有限集合の共通部分だけを使う。ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentUnionDistributivity
import CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionNondistributivity

namespace CellularAutomata.NeighborhoodAssignmentIntersectionNondistributivity

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.OrderedNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentUnionDistributivity

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_neighborhood_assignment_pointwise_intersection` の点ごとの積。 -/
def pointwiseIntersection (N M : NeighborhoodAssignment V) : NeighborhoodAssignment V :=
  fun v => N v ∩ M v

/-- `def_full_neighborhood_assignment` の全近傍割り当て。 -/
def fullNeighborhood (V : Type) [Fintype V] [DecidableEq V] : NeighborhoodAssignment V :=
  fun _ => Finset.univ

theorem pointwiseIntersection_comm (N M : NeighborhoodAssignment V) :
    pointwiseIntersection N M = pointwiseIntersection M N := by
  funext v
  exact Finset.inter_comm (N v) (M v)

theorem pointwiseIntersection_assoc (N M L : NeighborhoodAssignment V) :
    pointwiseIntersection (pointwiseIntersection N M) L =
      pointwiseIntersection N (pointwiseIntersection M L) := by
  funext v
  exact Finset.inter_assoc (N v) (M v) (L v)

theorem pointwiseIntersection_idem (N : NeighborhoodAssignment V) :
    pointwiseIntersection N N = N := by
  funext v
  exact Finset.inter_self (N v)

theorem pointwiseIntersection_full_right (N : NeighborhoodAssignment V) :
    pointwiseIntersection N (fullNeighborhood V) = N := by
  funext v
  simp [pointwiseIntersection, fullNeighborhood]

theorem pointwiseIntersection_full_left (N : NeighborhoodAssignment V) :
    pointwiseIntersection (fullNeighborhood V) N = N := by
  rw [pointwiseIntersection_comm]
  exact pointwiseIntersection_full_right N

/-- 人手証明の分配律 `N ⊓ (M ⊔ L) = (N ⊓ M) ⊔ (N ⊓ L)`。 -/
theorem pointwiseIntersection_pointwiseUnion (N M L : NeighborhoodAssignment V) :
    pointwiseIntersection N (pointwiseUnion M L) =
      pointwiseUnion (pointwiseIntersection N M) (pointwiseIntersection N L) := by
  funext v
  ext w
  simp [pointwiseIntersection, pointwiseUnion, and_or_left]

/-- 人手証明の分配律 `N ⊔ (M ⊓ L) = (N ⊔ M) ⊓ (N ⊔ L)`。 -/
theorem pointwiseUnion_pointwiseIntersection (N M L : NeighborhoodAssignment V) :
    pointwiseUnion N (pointwiseIntersection M L) =
      pointwiseIntersection (pointwiseUnion N M) (pointwiseUnion N L) := by
  funext v
  ext w
  simp [pointwiseIntersection, pointwiseUnion, or_and_left]

/-- 点ごとの和は包含順序の上界である。 -/
theorem pointwiseInclusion_union_left (N M : NeighborhoodAssignment V) :
    PointwiseInclusion N (pointwiseUnion N M) := by
  intro v w hw
  simp [pointwiseUnion, hw]

theorem pointwiseInclusion_union_right (N M : NeighborhoodAssignment V) :
    PointwiseInclusion M (pointwiseUnion N M) := by
  intro v w hw
  simp [pointwiseUnion, hw]

/-- 点ごとの和は包含順序の最小上界である。 -/
theorem pointwiseUnion_least {N M L : NeighborhoodAssignment V}
    (hNL : PointwiseInclusion N L) (hML : PointwiseInclusion M L) :
    PointwiseInclusion (pointwiseUnion N M) L := by
  intro v w hw
  rcases Finset.mem_union.mp hw with hwN | hwM
  · exact hNL v hwN
  · exact hML v hwM

/-- 点ごとの積は包含順序の下界である。 -/
theorem pointwiseIntersection_lower_left (N M : NeighborhoodAssignment V) :
    PointwiseInclusion (pointwiseIntersection N M) N := by
  intro v w hw
  exact (Finset.mem_inter.mp hw).1

theorem pointwiseIntersection_lower_right (N M : NeighborhoodAssignment V) :
    PointwiseInclusion (pointwiseIntersection N M) M := by
  intro v w hw
  exact (Finset.mem_inter.mp hw).2

/-- 点ごとの積は包含順序の最大下界である。 -/
theorem pointwiseIntersection_greatest {N M L : NeighborhoodAssignment V}
    (hLN : PointwiseInclusion L N) (hLM : PointwiseInclusion L M) :
    PointwiseInclusion L (pointwiseIntersection N M) := by
  intro v w hw
  exact Finset.mem_inter.mpr ⟨hLN v hw, hLM v hw⟩

/-- `claim_neighborhood_assignment_pointwise_union_intersection_lattice` の
    二つの分配律と最小上界・最大下界。有限性は型の `Fintype` インスタンスが担う。 -/
theorem finite_distributive_lattice_laws :
    (∀ N M L : NeighborhoodAssignment V,
      pointwiseIntersection N (pointwiseUnion M L) =
        pointwiseUnion (pointwiseIntersection N M) (pointwiseIntersection N L)) ∧
    (∀ N M L : NeighborhoodAssignment V,
      pointwiseUnion N (pointwiseIntersection M L) =
        pointwiseIntersection (pointwiseUnion N M) (pointwiseUnion N L)) ∧
    (∀ N M L : NeighborhoodAssignment V,
      PointwiseInclusion N L → PointwiseInclusion M L →
        PointwiseInclusion (pointwiseUnion N M) L) ∧
    (∀ N M L : NeighborhoodAssignment V,
      PointwiseInclusion L N → PointwiseInclusion L M →
        PointwiseInclusion L (pointwiseIntersection N M)) := by
  exact ⟨pointwiseIntersection_pointwiseUnion, pointwiseUnion_pointwiseIntersection,
    fun _ _ _ => pointwiseUnion_least, fun _ _ _ => pointwiseIntersection_greatest⟩

/-! 人手証明の三元舞台と、左右の非分配性を示す近傍割り当て。 -/

abbrev IntersectionWitnessStage := Fin 3

def leftN : NeighborhoodAssignment IntersectionWitnessStage :=
  fun v => if v = 0 then {1} else ∅

def leftM : NeighborhoodAssignment IntersectionWitnessStage :=
  fun v => if v = 0 then {2} else ∅

def leftL : NeighborhoodAssignment IntersectionWitnessStage :=
  fun v => if v = 1 ∨ v = 2 then {0} else ∅

theorem left_failure_lhs_at_a :
    composedNeighborhood (pointwiseIntersection leftN leftM) leftL 0 = ∅ := by
  decide

theorem left_failure_rhs_at_a :
    pointwiseIntersection (composedNeighborhood leftN leftL)
      (composedNeighborhood leftM leftL) 0 = {0} := by
  decide

/-- `claim_composition_not_left_distributive_over_pointwise_intersection`。 -/
theorem composition_not_left_distributive :
    composedNeighborhood (pointwiseIntersection leftN leftM) leftL ≠
      pointwiseIntersection (composedNeighborhood leftN leftL)
        (composedNeighborhood leftM leftL) := by
  intro h
  have hAtA := congrFun h 0
  rw [left_failure_lhs_at_a, left_failure_rhs_at_a] at hAtA
  have hMem : (0 : IntersectionWitnessStage) ∈ (∅ : Finset IntersectionWitnessStage) := by
    rw [hAtA]
    simp
  simpa using hMem

def rightL : NeighborhoodAssignment IntersectionWitnessStage :=
  fun v => if v = 0 then {1, 2} else ∅

def rightN : NeighborhoodAssignment IntersectionWitnessStage :=
  fun v => if v = 1 then {0} else ∅

def rightM : NeighborhoodAssignment IntersectionWitnessStage :=
  fun v => if v = 2 then {0} else ∅

theorem right_failure_lhs_at_a :
    composedNeighborhood rightL (pointwiseIntersection rightN rightM) 0 = ∅ := by
  decide

theorem right_failure_rhs_at_a :
    pointwiseIntersection (composedNeighborhood rightL rightN)
      (composedNeighborhood rightL rightM) 0 = {0} := by
  decide

/-- `claim_composition_not_right_distributive_over_pointwise_intersection`。 -/
theorem composition_not_right_distributive :
    composedNeighborhood rightL (pointwiseIntersection rightN rightM) ≠
      pointwiseIntersection (composedNeighborhood rightL rightN)
        (composedNeighborhood rightL rightM) := by
  intro h
  have hAtA := congrFun h 0
  rw [right_failure_lhs_at_a, right_failure_rhs_at_a] at hAtA
  have hMem : (0 : IntersectionWitnessStage) ∈ (∅ : Finset IntersectionWitnessStage) := by
    rw [hAtA]
    simp
  simpa using hMem

/-- 点ごとの積の全演算表。 -/
def intersectionTable :
    Finset (NeighborhoodAssignment V × NeighborhoodAssignment V × NeighborhoodAssignment V) :=
  Finset.univ.image (fun p : NeighborhoodAssignment V × NeighborhoodAssignment V =>
    (p.1, p.2, pointwiseIntersection p.1 p.2))

theorem mem_intersectionTable (N M : NeighborhoodAssignment V) :
    (N, M, pointwiseIntersection N M) ∈ intersectionTable := by
  simp [intersectionTable]

/-- 左分配律を満たす三つ組の有限表。 -/
def leftDistributiveTriples :
    Finset (NeighborhoodAssignment V × NeighborhoodAssignment V × NeighborhoodAssignment V) :=
  Finset.univ.filter fun p =>
    composedNeighborhood (pointwiseIntersection p.1 p.2.1) p.2.2 =
      pointwiseIntersection (composedNeighborhood p.1 p.2.2)
        (composedNeighborhood p.2.1 p.2.2)

/-- 右分配律を満たす三つ組の有限表。 -/
def rightDistributiveTriples :
    Finset (NeighborhoodAssignment V × NeighborhoodAssignment V × NeighborhoodAssignment V) :=
  Finset.univ.filter fun p =>
    composedNeighborhood p.1 (pointwiseIntersection p.2.1 p.2.2) =
      pointwiseIntersection (composedNeighborhood p.1 p.2.1)
        (composedNeighborhood p.1 p.2.2)

/-- 左分配律を満たすことは、有限表への所属と同値である。 -/
theorem mem_leftDistributiveTriples
    (N M L : NeighborhoodAssignment V) :
    (N, M, L) ∈ leftDistributiveTriples ↔
      composedNeighborhood (pointwiseIntersection N M) L =
        pointwiseIntersection (composedNeighborhood N L) (composedNeighborhood M L) := by
  simp [leftDistributiveTriples]

/-- 右分配律を満たすことは、有限表への所属と同値である。 -/
theorem mem_rightDistributiveTriples
    (L N M : NeighborhoodAssignment V) :
    (L, N, M) ∈ rightDistributiveTriples ↔
      composedNeighborhood L (pointwiseIntersection N M) =
        pointwiseIntersection (composedNeighborhood L N) (composedNeighborhood L M) := by
  simp [rightDistributiveTriples]


/-! ### 必要十分版からの導出

必要十分版は NecSuf/NeighborhoodAssignmentIntersectionNondistributivity.lean にある。
ここでは具体版の各主張が、その特殊化として得られることを示す。 -/

namespace Derivation

open CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionNondistributivity

omit [Fintype V] in
/-- 具体版の点ごとの積は、必要十分版の型をまたぐ積を同じ型に取ったものである。 -/
theorem pointwiseIntersection_eq_necSuf (N M : NeighborhoodAssignment V) :
    pointwiseIntersection N M = hetInter N M := rfl

/-- 具体版の全近傍割り当ては、必要十分版の型をまたぐ全近傍割り当てを
    同じ型に取ったものである。 -/
theorem fullNeighborhood_eq_necSuf :
    fullNeighborhood V = hetFull V V := rfl

omit [Fintype V] in
/-- 具体版の可換律は、必要十分版の可換律の特殊化である。 -/
theorem pointwiseIntersection_comm_of_necSuf (N M : NeighborhoodAssignment V) :
    pointwiseIntersection N M = pointwiseIntersection M N :=
  hetInter_comm N M

omit [Fintype V] in
/-- 具体版の結合律は、必要十分版の結合律の特殊化である。 -/
theorem pointwiseIntersection_assoc_of_necSuf (N M L : NeighborhoodAssignment V) :
    pointwiseIntersection (pointwiseIntersection N M) L =
      pointwiseIntersection N (pointwiseIntersection M L) :=
  hetInter_assoc N M L

omit [Fintype V] in
/-- 具体版の冪等律は、必要十分版の冪等律の特殊化である。 -/
theorem pointwiseIntersection_idem_of_necSuf (N : NeighborhoodAssignment V) :
    pointwiseIntersection N N = N :=
  hetInter_idem N

/-- 具体版の右単位律は、必要十分版の右単位律の特殊化である。
    ここだけ舞台の有限性を落とせない（全近傍を `Finset` として書くため）。 -/
theorem pointwiseIntersection_full_right_of_necSuf (N : NeighborhoodAssignment V) :
    pointwiseIntersection N (fullNeighborhood V) = N :=
  hetInter_full_right N

/-- 具体版の左単位律は、必要十分版の左単位律の特殊化である。 -/
theorem pointwiseIntersection_full_left_of_necSuf (N : NeighborhoodAssignment V) :
    pointwiseIntersection (fullNeighborhood V) N = N :=
  hetInter_full_left N

omit [Fintype V] in
/-- 具体版の第一の分配律は、必要十分版の型をまたぐ分配律を同じ型に取ったものである。 -/
theorem pointwiseIntersection_pointwiseUnion_of_necSuf (N M L : NeighborhoodAssignment V) :
    pointwiseIntersection N (pointwiseUnion M L) =
      pointwiseUnion (pointwiseIntersection N M) (pointwiseIntersection N L) :=
  hetInter_hetUnion N M L

omit [Fintype V] in
/-- 具体版の第二の分配律は、必要十分版の型をまたぐ分配律を同じ型に取ったものである。 -/
theorem pointwiseUnion_pointwiseIntersection_of_necSuf (N M L : NeighborhoodAssignment V) :
    pointwiseUnion N (pointwiseIntersection M L) =
      pointwiseIntersection (pointwiseUnion N M) (pointwiseUnion N L) :=
  hetUnion_hetInter N M L

omit [Fintype V] in
/-- 具体版の最小上界性は、必要十分版の最小上界性の特殊化である。 -/
theorem pointwiseUnion_least_of_necSuf {N M L : NeighborhoodAssignment V}
    (hNL : PointwiseInclusion N L) (hML : PointwiseInclusion M L) :
    PointwiseInclusion (pointwiseUnion N M) L :=
  hetUnion_least hNL hML

omit [Fintype V] in
/-- 具体版の最大下界性は、必要十分版の最大下界性の特殊化である。 -/
theorem pointwiseIntersection_greatest_of_necSuf {N M L : NeighborhoodAssignment V}
    (hLN : PointwiseInclusion L N) (hLM : PointwiseInclusion L M) :
    PointwiseInclusion L (pointwiseIntersection N M) :=
  hetInter_greatest hLN hLM

omit [Fintype V] in
/-- 具体版の分配束の全公理は、必要十分版の全公理の特殊化である。 -/
theorem finite_distributive_lattice_laws_of_necSuf :
    (∀ N M L : NeighborhoodAssignment V,
      pointwiseIntersection N (pointwiseUnion M L) =
        pointwiseUnion (pointwiseIntersection N M) (pointwiseIntersection N L)) ∧
    (∀ N M L : NeighborhoodAssignment V,
      pointwiseUnion N (pointwiseIntersection M L) =
        pointwiseIntersection (pointwiseUnion N M) (pointwiseUnion N L)) ∧
    (∀ N M L : NeighborhoodAssignment V,
      PointwiseInclusion N L → PointwiseInclusion M L →
        PointwiseInclusion (pointwiseUnion N M) L) ∧
    (∀ N M L : NeighborhoodAssignment V,
      PointwiseInclusion L N → PointwiseInclusion L M →
        PointwiseInclusion L (pointwiseIntersection N M)) :=
  distributive_lattice_laws (V := V) (W := V)

/-- 具体版の左の非分配性は、必要十分版の非分配性へ三元舞台の値を入れて得られる。
    必要十分版が要求する `b ≠ c` は、この舞台では `1 ≠ 2` として満たされる。 -/
theorem composition_not_left_distributive_of_necSuf :
    composedNeighborhood (pointwiseIntersection leftN leftM) leftL ≠
      pointwiseIntersection (composedNeighborhood leftN leftL)
        (composedNeighborhood leftM leftL) :=
  hetComp_hetInter_left_ne (0 : IntersectionWitnessStage) 1 2 (by decide) 0
    leftN leftM leftL (by decide) (by decide) (by decide) (by decide)

/-- 具体版の右の非分配性は、必要十分版の非分配性へ三元舞台の値を入れて得られる。
    必要十分版は `b ≠ c` を要求せず、`L(a)` のどの元でも両方には入らないことだけを使う。 -/
theorem composition_not_right_distributive_of_necSuf :
    composedNeighborhood rightL (pointwiseIntersection rightN rightM) ≠
      pointwiseIntersection (composedNeighborhood rightL rightN)
        (composedNeighborhood rightL rightM) :=
  hetComp_hetInter_right_ne (0 : IntersectionWitnessStage) 1 2 0
    rightL rightN rightM (by decide) (by decide) (by decide) (by decide) (by decide)

/-- 具体版の積の演算表は、必要十分版の型をまたぐ表を同じ型に取ったものである。 -/
theorem intersectionTable_eq_necSuf :
    intersectionTable (V := V) = hetInterTable V V := rfl

/-- 具体版の左分配三つ組の表は、必要十分版の表を同じ型に取ったものである。 -/
theorem leftDistributiveTriples_eq_necSuf :
    leftDistributiveTriples (V := V) = hetLeftDistributiveTriples V := rfl

/-- 具体版の右分配三つ組の表は、必要十分版の表を同じ型に取ったものである。 -/
theorem rightDistributiveTriples_eq_necSuf :
    rightDistributiveTriples (V := V) = hetRightDistributiveTriples V := rfl

omit [Fintype V] in
/-- 具体版が `Finset` で要求する等号判定は有限表現のためだけであり、
    点ごとの積そのものは集合として読んでも同じ演算である。 -/
theorem pointwiseIntersection_coe_eq_setInter (N M : NeighborhoodAssignment V) (v : V) :
    ((pointwiseIntersection N M v : Finset V) : Set V) =
      setInter (fun v => ((N v : Finset V) : Set V))
        (fun v => ((M v : Finset V) : Set V)) v :=
  coe_hetInter N M v

/-- 具体版が全近傍割り当てに要求する有限性も有限表現のためだけであり、
    集合として読めば全近傍は `Set.univ` である。 -/
theorem fullNeighborhood_coe_eq_setFull (v : V) :
    ((fullNeighborhood V v : Finset V) : Set V) = setFull V V v :=
  coe_hetFull v

end Derivation

end CellularAutomata.NeighborhoodAssignmentIntersectionNondistributivity
