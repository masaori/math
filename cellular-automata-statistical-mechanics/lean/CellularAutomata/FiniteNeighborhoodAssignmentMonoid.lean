/-
章「有限近傍割り当ての合成モノイド」の Lean 具体版。
人手証明の正本は structured-latex/content/finite-neighborhood-assignment-monoid.ts。

対応表（人手証明 → この file）
  def_finite_neighborhood_assignment_space
    `NeighborhoodAssignment`
  def_identity_neighborhood_assignment
    `identityNeighborhood`
  claim_identity_neighborhood_assignment_is_composition_identity
    `identity_composedNeighborhood`, `composedNeighborhood_identity`
  claim_composed_neighborhood_associative
    `composedNeighborhood_assoc`
  claim_finite_neighborhood_assignments_form_monoid
    `instMonoidNeighborhoodAssignment`
  claim_finite_neighborhood_assignment_monoid_cardinality_decidable
    `card_neighborhoodAssignment`, `assignmentTable`, `compositionTable`,
    `mem_compositionTable`
  def_noncommutative_neighborhood_assignment_witness
    `noncommutativeN`, `noncommutativeM`
  claim_neighborhood_assignment_composition_not_commutative
    `noncommutative_witness`

住処: 有限型、有限部分集合、有限写像、自然数だけ。ℝ / ℂ は現れない。
必要十分版と具体版からの導出は未着手である。
-/
import CellularAutomata.ComposedNeighborhoodClosure

namespace CellularAutomata.FiniteNeighborhoodAssignmentMonoid

open CellularAutomata.ComposedNeighborhoodClosure

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_finite_neighborhood_assignment_space` の有限舞台上の近傍割り当て全体。 -/
abbrev NeighborhoodAssignment (V : Type) [DecidableEq V] := V → Finset V

/-- `def_identity_neighborhood_assignment` の自己近傍割り当て I_V(v) = {v}。 -/
def identityNeighborhood (V : Type) [DecidableEq V] : NeighborhoodAssignment V :=
  fun v => {v}

omit [Fintype V] in
/-- `claim_identity_neighborhood_assignment_is_composition_identity` の左単位律。 -/
theorem identity_composedNeighborhood (N : NeighborhoodAssignment V) :
    composedNeighborhood (identityNeighborhood V) N = N := by
  funext v
  simp [composedNeighborhood, identityNeighborhood]

omit [Fintype V] in
/-- `claim_identity_neighborhood_assignment_is_composition_identity` の右単位律。 -/
theorem composedNeighborhood_identity (N : NeighborhoodAssignment V) :
    composedNeighborhood N (identityNeighborhood V) = N := by
  funext v
  ext w
  simp [composedNeighborhood, identityNeighborhood]

omit [Fintype V] in
/-- `claim_composed_neighborhood_associative`。二重の存在量化を同じ順序で展開する。 -/
theorem composedNeighborhood_assoc (N M L : NeighborhoodAssignment V) :
    composedNeighborhood (composedNeighborhood N M) L =
      composedNeighborhood N (composedNeighborhood M L) := by
  funext v
  ext w
  simp only [composedNeighborhood, Finset.mem_biUnion]
  constructor
  · rintro ⟨u, ⟨r, hrN, huM⟩, hwL⟩
    exact ⟨r, hrN, u, huM, hwL⟩
  · rintro ⟨r, hrN, u, huM, hwL⟩
    exact ⟨u, ⟨r, hrN, huM⟩, hwL⟩

/-- `claim_finite_neighborhood_assignments_form_monoid`。
    積は合成近傍、単位元は自己近傍割り当てである。 -/
instance instMonoidNeighborhoodAssignment : Monoid (NeighborhoodAssignment V) where
  mul := composedNeighborhood
  one := identityNeighborhood V
  mul_assoc := composedNeighborhood_assoc
  one_mul := identity_composedNeighborhood
  mul_one := composedNeighborhood_identity

/-- `claim_finite_neighborhood_assignment_monoid_cardinality_decidable` の元数。
    |N(V)| = (2^|V|)^|V| = 2^(|V|*|V|)。 -/
theorem card_neighborhoodAssignment :
    Fintype.card (NeighborhoodAssignment V) =
      2 ^ (Fintype.card V * Fintype.card V) := by
  simp [NeighborhoodAssignment, Fintype.card_finset, pow_mul]

/-- 全ての近傍割り当てを重複なく有限列挙する表。 -/
def assignmentTable : Finset (NeighborhoodAssignment V) := Finset.univ

/-- 全ての順序対とその積を有限列挙する合成表。 -/
def compositionTable :
    Finset (NeighborhoodAssignment V × NeighborhoodAssignment V × NeighborhoodAssignment V) :=
  Finset.univ.image (fun p : NeighborhoodAssignment V × NeighborhoodAssignment V =>
    (p.1, p.2, p.1 * p.2))

/-- 合成表は任意の二つの近傍割り当てと、その合成近傍を含む。 -/
theorem mem_compositionTable (N M : NeighborhoodAssignment V) :
    (N, M, N * M) ∈ compositionTable := by
  simp [compositionTable]

/-! 人手証明の三元舞台 V_nc = {a,b,c} と二つの近傍割り当て。 -/

abbrev NoncommutativeStage := Fin 3

def noncommutativeN : NeighborhoodAssignment NoncommutativeStage :=
  fun v => if v = 0 then {1} else ∅

def noncommutativeM : NeighborhoodAssignment NoncommutativeStage :=
  fun v => if v = 1 then {2} else ∅

/-- 人手証明の第一の計算: (N ⋆ M)(a) = {c}。 -/
theorem noncommutative_left_at_a :
    composedNeighborhood noncommutativeN noncommutativeM 0 = {2} := by
  decide

/-- 人手証明の第二の計算: (M ⋆ N)(a) = ∅。 -/
theorem noncommutative_right_at_a :
    composedNeighborhood noncommutativeM noncommutativeN 0 = ∅ := by
  decide

/-- `claim_neighborhood_assignment_composition_not_commutative` の有限反例。 -/
theorem noncommutative_witness :
    composedNeighborhood noncommutativeN noncommutativeM ≠
      composedNeighborhood noncommutativeM noncommutativeN := by
  intro h
  have hAtA := congrFun h 0
  rw [noncommutative_left_at_a, noncommutative_right_at_a] at hAtA
  exact Finset.singleton_ne_empty 2 hAtA

end CellularAutomata.FiniteNeighborhoodAssignmentMonoid
