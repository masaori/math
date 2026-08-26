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

end CellularAutomata.NeighborhoodAssignmentTransposeInvolution
