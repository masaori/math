/-
章「近傍割り当ての転置対合」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-transpose-involution.ts。

対応表（人手証明 → この file）
  def_neighborhood_assignment_transpose
    `transpose`
  claim_neighborhood_assignment_transpose_membership
    `mem_transpose`
  claim_neighborhood_assignment_transpose_involutive
    `transpose_transpose`
  claim_neighborhood_assignment_transpose_reverses_composition
    `transpose_composedNeighborhood`
  claim_neighborhood_assignment_transpose_preserves_lattice_operations
    `transpose_pointwiseUnion`, `transpose_pointwiseIntersection`,
    `transpose_identityNeighborhood`
  claim_neighborhood_assignment_transpose_finitely_decidable
    `transposeTable`, `mem_transposeTable`, `transpose_bijective`

有限舞台、有限近傍割り当て、有限集合の所属判定だけを使う。ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentIntersectionNondistributivity
import CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution

namespace CellularAutomata.NeighborhoodAssignmentTransposeInvolution

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentUnionDistributivity
open CellularAutomata.NeighborhoodAssignmentIntersectionNondistributivity

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_neighborhood_assignment_transpose` の
    `Nᵀ(w) = {v ∈ V | w ∈ N(v)}`。 -/
def transpose (N : NeighborhoodAssignment V) : NeighborhoodAssignment V :=
  fun w => Finset.univ.filter fun v => w ∈ N v

/-- `claim_neighborhood_assignment_transpose_membership`。
    転置の定義を一段だけ展開する。 -/
theorem mem_transpose (N : NeighborhoodAssignment V) (v w : V) :
    v ∈ transpose N w ↔ w ∈ N v := by
  simp [transpose]

/-- `claim_neighborhood_assignment_transpose_involutive`。
    人手証明と同じく所属の向きの反転を二回使い、外延性で等号を得る。 -/
theorem transpose_transpose (N : NeighborhoodAssignment V) :
    transpose (transpose N) = N := by
  funext v
  ext w
  rw [mem_transpose, mem_transpose]

/-- `claim_neighborhood_assignment_transpose_reverses_composition`。
    合成の証人 `u` の二つの所属条件を転置で反転し、合成順序を逆にする。 -/
theorem transpose_composedNeighborhood (N M : NeighborhoodAssignment V) :
    transpose (composedNeighborhood N M) =
      composedNeighborhood (transpose M) (transpose N) := by
  funext v
  ext w
  rw [mem_transpose]
  simp only [composedNeighborhood, Finset.mem_biUnion]
  constructor
  · rintro ⟨u, huN, hvM⟩
    exact ⟨u, (mem_transpose M u v).2 hvM, (mem_transpose N w u).2 huN⟩
  · rintro ⟨u, huMT, hwNT⟩
    exact ⟨u, (mem_transpose N w u).1 hwNT, (mem_transpose M u v).1 huMT⟩

/-- `claim_neighborhood_assignment_transpose_preserves_lattice_operations` の点ごとの和。 -/
theorem transpose_pointwiseUnion (N M : NeighborhoodAssignment V) :
    transpose (pointwiseUnion N M) = pointwiseUnion (transpose N) (transpose M) := by
  funext v
  ext w
  simp [mem_transpose, pointwiseUnion]

/-- `claim_neighborhood_assignment_transpose_preserves_lattice_operations` の点ごとの積。 -/
theorem transpose_pointwiseIntersection (N M : NeighborhoodAssignment V) :
    transpose (pointwiseIntersection N M) =
      pointwiseIntersection (transpose N) (transpose M) := by
  funext v
  ext w
  simp [mem_transpose, pointwiseIntersection]

/-- `claim_neighborhood_assignment_transpose_preserves_lattice_operations` の自己近傍割り当て。 -/
theorem transpose_identityNeighborhood :
    transpose (identityNeighborhood V) = identityNeighborhood V := by
  funext v
  ext w
  simp [mem_transpose, identityNeighborhood, eq_comm]

/-- 転置写像の全演算表。 -/
def transposeTable :
    Finset (NeighborhoodAssignment V × NeighborhoodAssignment V) :=
  Finset.univ.image fun N : NeighborhoodAssignment V => (N, transpose N)

/-- 転置表は任意の近傍割り当てとその転置を含む。 -/
theorem mem_transposeTable (N : NeighborhoodAssignment V) :
    (N, transpose N) ∈ transposeTable := by
  simp [transposeTable]

/-- 対合性から、有限表が表す転置写像は全単射である。 -/
theorem transpose_bijective :
    Function.Bijective (transpose : NeighborhoodAssignment V → NeighborhoodAssignment V) := by
  constructor
  · intro N M h
    have hT := congrArg transpose h
    simpa [transpose_transpose] using hT
  · intro N
    exact ⟨transpose N, transpose_transpose N⟩

/-! ### 必要十分版からの導出

以下は、上の具体版の定義・定理が必要十分版
（`NecSuf.NeighborhoodAssignmentTransposeInvolution`）を
始域と終域を同じ有限舞台に取ることで得られることを示す。 -/

namespace Derivation

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity
open CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionNondistributivity
open CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution

/-- 具体版の転置は、必要十分版の型をまたぐ転置を同じ型に取ったものである。 -/
theorem transpose_eq_necSuf (N : NeighborhoodAssignment V) :
    transpose N = hetTranspose N := rfl

/-- 具体版の所属同値は、必要十分版の特殊化である。 -/
theorem mem_transpose_of_necSuf (N : NeighborhoodAssignment V) (v w : V) :
    v ∈ transpose N w ↔ w ∈ N v :=
  mem_hetTranspose N v w

/-- 具体版の対合性は、必要十分版の特殊化である。 -/
theorem transpose_transpose_of_necSuf (N : NeighborhoodAssignment V) :
    transpose (transpose N) = N :=
  hetTranspose_hetTranspose N

/-- 具体版の合成順序の反転は、必要十分版の三つの型を同じ舞台に取ったものである。 -/
theorem transpose_composedNeighborhood_of_necSuf (N M : NeighborhoodAssignment V) :
    transpose (composedNeighborhood N M) =
      composedNeighborhood (transpose M) (transpose N) :=
  hetTranspose_hetComp N M

/-- 具体版の点ごとの和の保存は、必要十分版の特殊化である。 -/
theorem transpose_pointwiseUnion_of_necSuf (N M : NeighborhoodAssignment V) :
    transpose (pointwiseUnion N M) = pointwiseUnion (transpose N) (transpose M) :=
  hetTranspose_hetUnion N M

/-- 具体版の点ごとの積の保存は、必要十分版の特殊化である。 -/
theorem transpose_pointwiseIntersection_of_necSuf (N M : NeighborhoodAssignment V) :
    transpose (pointwiseIntersection N M) =
      pointwiseIntersection (transpose N) (transpose M) :=
  hetTranspose_hetInter N M

/-- 具体版の自己近傍割り当ての保存は、必要十分版の特殊化である。 -/
theorem transpose_identityNeighborhood_of_necSuf :
    transpose (_root_.CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V) =
      _root_.CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V :=
  hetTranspose_identityNeighborhood

/-- 具体版の全単射性は、必要十分版の特殊化である。 -/
theorem transpose_bijective_of_necSuf :
    Function.Bijective (transpose : NeighborhoodAssignment V → NeighborhoodAssignment V) :=
  hetTranspose_bijective

/-- 具体版の転置表は、必要十分版の表を同じ型に取ったものである。 -/
theorem transposeTable_eq_necSuf :
    (transposeTable : Finset (NeighborhoodAssignment V × NeighborhoodAssignment V)) =
      hetTransposeTable V V := rfl

/-- 具体版の表への所属は、必要十分版の特殊化である。 -/
theorem mem_transposeTable_of_necSuf (N : NeighborhoodAssignment V) :
    (N, transpose N) ∈ (transposeTable : Finset (NeighborhoodAssignment V × NeighborhoodAssignment V)) :=
  mem_hetTransposeTable N

end Derivation

end CellularAutomata.NeighborhoodAssignmentTransposeInvolution
