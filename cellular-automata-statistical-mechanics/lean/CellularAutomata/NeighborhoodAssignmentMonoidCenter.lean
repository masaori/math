/-
章「有限近傍割り当てモノイドの中心」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-monoid-center.ts。

中心、向き付き辺の証人、中心の特徴づけ、有限決定を人手証明と同じ順序で
有限舞台上に形式化する。有限集合・有限部分集合・自然数だけを使い、ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentUnionDistributivity

namespace CellularAutomata.NeighborhoodAssignmentMonoidCenter

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentUnionDistributivity

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_neighborhood_assignment_monoid_center` の中心所属。 -/
def IsCentral (N : NeighborhoodAssignment V) : Prop :=
  ∀ M : NeighborhoodAssignment V,
    composedNeighborhood N M = composedNeighborhood M N

/-- `def_single_edge_neighborhood_assignment` の E_{a,b}。 -/
def singleEdge (a b : V) : NeighborhoodAssignment V :=
  fun v => if v = a then {b} else ∅

omit [Fintype V] in
/-- 空近傍割り当ては中心に属する。 -/
theorem empty_isCentral : IsCentral (emptyNeighborhood V) := by
  intro M
  rw [empty_composedNeighborhood, composedNeighborhood_empty]

omit [Fintype V] in
/-- 自己近傍割り当ては中心に属する。 -/
theorem identity_isCentral : IsCentral (identityNeighborhood V) := by
  intro M
  rw [identity_composedNeighborhood, composedNeighborhood_identity]

omit [Fintype V] in
/-- 人手証明の第二段。中心元の辺 q ∈ N(p) は自己ループである。 -/
theorem edge_of_central_is_loop {N : NeighborhoodAssignment V} (hN : IsCentral N)
    {p q : V} (hq : q ∈ N p) : p = q := by
  by_contra hpq
  have hleft : q ∈ composedNeighborhood N (singleEdge q q) p := by
    exact Finset.mem_biUnion.mpr ⟨q, hq, by simp [singleEdge]⟩
  have hcomm := congrFun (hN (singleEdge q q)) p
  rw [hcomm] at hleft
  simpa [composedNeighborhood, singleEdge, hpq] using hleft

omit [Fintype V] in
/-- 人手証明の第三段。空でない中心元は全ての自己ループを持つ。 -/
theorem identity_subset_of_central_ne_empty {N : NeighborhoodAssignment V}
    (hN : IsCentral N) (hne : N ≠ emptyNeighborhood V) :
    ∀ b : V, b ∈ N b := by
  have hex : ∃ p q : V, q ∈ N p := by
    by_contra h
    apply hne
    funext p
    change N p = ∅
    ext q
    constructor
    · intro hq
      exact (h ⟨p, q, hq⟩).elim
    · simp
  obtain ⟨p, q, hq⟩ := hex
  have hpq : p = q := edge_of_central_is_loop hN hq
  have hpp : p ∈ N p := hpq ▸ hq
  intro b
  have hleft : b ∈ composedNeighborhood N (singleEdge p b) p := by
    exact Finset.mem_biUnion.mpr ⟨p, hpp, by simp [singleEdge]⟩
  have hcomm := congrFun (hN (singleEdge p b)) p
  rw [hcomm] at hleft
  simpa [composedNeighborhood, singleEdge] using hleft

omit [Fintype V] in
/-- `claim_neighborhood_assignment_monoid_center_characterization` の点ごとの特徴づけ。 -/
theorem isCentral_iff_empty_or_identity (N : NeighborhoodAssignment V) :
    IsCentral N ↔ N = emptyNeighborhood V ∨ N = identityNeighborhood V := by
  constructor
  · intro hN
    by_cases hne : N = emptyNeighborhood V
    · exact Or.inl hne
    · right
      have hloops := identity_subset_of_central_ne_empty hN hne
      funext v
      ext w
      constructor
      · intro hw
        have hvw : v = w := edge_of_central_is_loop hN hw
        simpa [identityNeighborhood, hvw]
      · intro hw
        have hvw : w = v := by simpa [identityNeighborhood] using hw
        simpa [hvw] using hloops v
  · rintro (rfl | rfl)
    · exact empty_isCentral
    · exact identity_isCentral

/-- 中心の全体を重複なく有限列挙する表。 -/
noncomputable def centerTable : Finset (NeighborhoodAssignment V) :=
  by
    classical
    exact assignmentTable.filter IsCentral

/-- `claim_neighborhood_assignment_monoid_center_finite_decidability`。
    中心所属は二つの有限写像との等号で決定できる。 -/
theorem mem_centerTable_iff (N : NeighborhoodAssignment V) :
    N ∈ centerTable ↔ N = emptyNeighborhood V ∨ N = identityNeighborhood V := by
  classical
  rw [centerTable, Finset.mem_filter]
  simp only [assignmentTable, Finset.mem_univ, true_and]
  exact isCentral_iff_empty_or_identity N

end CellularAutomata.NeighborhoodAssignmentMonoidCenter
