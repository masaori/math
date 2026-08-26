/-
章「点ごとの積に対する合成の非分配反例の最小舞台」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-intersection-minimal-counterexample.ts。

有限舞台、有限近傍割り当て、有限集合の共通部分だけを使う。ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentIntersectionNondistributivity

namespace CellularAutomata.NeighborhoodAssignmentIntersectionMinimalCounterexample

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentIntersectionNondistributivity

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `claim_subsingleton_neighborhood_composition_equals_intersection`。
    人手証明どおり、合成近傍の証人を舞台の唯一の元へ同定し、逆向きでは `w` を証人に取る。 -/
theorem subsingleton_composition_equals_intersection
    (hcard : Fintype.card V ≤ 1) (N M : NeighborhoodAssignment V) :
    composedNeighborhood N M = pointwiseIntersection N M := by
  letI : Subsingleton V := Fintype.card_le_one_iff_subsingleton.mp hcard
  funext v
  ext w
  constructor
  · intro hw
    rcases Finset.mem_biUnion.mp hw with ⟨u, huN, hwM⟩
    exact Finset.mem_inter.mpr ⟨
      by simpa only [Subsingleton.elim u w] using huN,
      by simpa only [Subsingleton.elim u v] using hwM⟩
  · intro hw
    rcases Finset.mem_inter.mp hw with ⟨hwN, hwM⟩
    exact Finset.mem_biUnion.mpr ⟨w, hwN,
      by simpa only [Subsingleton.elim v w] using hwM⟩

/-- 一元以下の舞台での左分配律。三つの合成を前定理で点ごとの積へ書き換える。 -/
theorem subsingleton_left_distributive
    (hcard : Fintype.card V ≤ 1) (N M L : NeighborhoodAssignment V) :
    composedNeighborhood (pointwiseIntersection N M) L =
      pointwiseIntersection (composedNeighborhood N L) (composedNeighborhood M L) := by
  rw [subsingleton_composition_equals_intersection hcard]
  rw [subsingleton_composition_equals_intersection hcard]
  rw [subsingleton_composition_equals_intersection hcard]
  funext v
  exact Finset.inter_inter_distrib_right (N v) (M v) (L v)

/-- 一元以下の舞台での右分配律。三つの合成を前定理で点ごとの積へ書き換える。 -/
theorem subsingleton_right_distributive
    (hcard : Fintype.card V ≤ 1) (L N M : NeighborhoodAssignment V) :
    composedNeighborhood L (pointwiseIntersection N M) =
      pointwiseIntersection (composedNeighborhood L N) (composedNeighborhood L M) := by
  rw [subsingleton_composition_equals_intersection hcard]
  rw [subsingleton_composition_equals_intersection hcard]
  rw [subsingleton_composition_equals_intersection hcard]
  funext v
  exact Finset.inter_inter_distrib_left (L v) (N v) (M v)

/-- `claim_subsingleton_neighborhood_composition_distributes_over_intersection`。 -/
theorem subsingleton_distributive
    (hcard : Fintype.card V ≤ 1) (N M L : NeighborhoodAssignment V) :
    composedNeighborhood (pointwiseIntersection N M) L =
        pointwiseIntersection (composedNeighborhood N L) (composedNeighborhood M L) ∧
      composedNeighborhood L (pointwiseIntersection N M) =
        pointwiseIntersection (composedNeighborhood L N) (composedNeighborhood L M) := by
  exact ⟨subsingleton_left_distributive hcard N M L,
    subsingleton_right_distributive hcard L N M⟩

/-! 人手証明の二元舞台と、左右の非分配性を示す近傍割り当て。 -/

abbrev TwoCellStage := Fin 2

def leftN : NeighborhoodAssignment TwoCellStage :=
  fun v => if v = 1 then {0} else ∅

def leftM : NeighborhoodAssignment TwoCellStage :=
  fun v => if v = 1 then {1} else ∅

def leftL : NeighborhoodAssignment TwoCellStage :=
  fun _ => {0}

theorem two_cell_left_lhs_at_b :
    composedNeighborhood (pointwiseIntersection leftN leftM) leftL 1 = ∅ := by
  decide

theorem two_cell_left_rhs_at_b :
    pointwiseIntersection (composedNeighborhood leftN leftL)
      (composedNeighborhood leftM leftL) 1 = {0} := by
  decide

theorem two_cell_left_failure :
    composedNeighborhood (pointwiseIntersection leftN leftM) leftL ≠
      pointwiseIntersection (composedNeighborhood leftN leftL)
        (composedNeighborhood leftM leftL) := by
  intro h
  have hAtB := congrFun h 1
  rw [two_cell_left_lhs_at_b, two_cell_left_rhs_at_b] at hAtB
  simpa using hAtB

def rightN : NeighborhoodAssignment TwoCellStage :=
  fun v => if v = 1 then {0} else ∅

def rightM : NeighborhoodAssignment TwoCellStage :=
  fun v => if v = 0 then {0} else ∅

def rightL : NeighborhoodAssignment TwoCellStage :=
  fun v => if v = 1 then {0, 1} else ∅

theorem two_cell_right_lhs_at_b :
    composedNeighborhood rightL (pointwiseIntersection rightN rightM) 1 = ∅ := by
  decide

theorem two_cell_right_rhs_at_b :
    pointwiseIntersection (composedNeighborhood rightL rightN)
      (composedNeighborhood rightL rightM) 1 = {0} := by
  decide

theorem two_cell_right_failure :
    composedNeighborhood rightL (pointwiseIntersection rightN rightM) ≠
      pointwiseIntersection (composedNeighborhood rightL rightN)
        (composedNeighborhood rightL rightM) := by
  intro h
  have hAtB := congrFun h 1
  rw [two_cell_right_lhs_at_b, two_cell_right_rhs_at_b] at hAtB
  simpa using hAtB

theorem two_cell_stage_card : Fintype.card TwoCellStage = 2 := by
  decide

/-- `theorem_minimal_cell_count_for_composition_intersection_nondistributivity`。
    一元以下での非存在と、二元舞台での左右それぞれの存在を一つにまとめる。 -/
theorem minimal_cell_count_for_composition_intersection_nondistributivity :
    (∀ (W : Type) [Fintype W] [DecidableEq W], Fintype.card W ≤ 1 →
      ∀ N M L : NeighborhoodAssignment W,
        composedNeighborhood (pointwiseIntersection N M) L =
            pointwiseIntersection (composedNeighborhood N L) (composedNeighborhood M L) ∧
          composedNeighborhood L (pointwiseIntersection N M) =
            pointwiseIntersection (composedNeighborhood L N) (composedNeighborhood L M)) ∧
    Fintype.card TwoCellStage = 2 ∧
    composedNeighborhood (pointwiseIntersection leftN leftM) leftL ≠
      pointwiseIntersection (composedNeighborhood leftN leftL)
        (composedNeighborhood leftM leftL) ∧
    composedNeighborhood rightL (pointwiseIntersection rightN rightM) ≠
      pointwiseIntersection (composedNeighborhood rightL rightN)
        (composedNeighborhood rightL rightM) := by
  exact ⟨fun _ _ _ hcard N M L => subsingleton_distributive hcard N M L,
    two_cell_stage_card, two_cell_left_failure, two_cell_right_failure⟩

end CellularAutomata.NeighborhoodAssignmentIntersectionMinimalCounterexample
