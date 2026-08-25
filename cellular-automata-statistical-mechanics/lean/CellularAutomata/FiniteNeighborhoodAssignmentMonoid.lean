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

必要十分版は NecSuf/FiniteNeighborhoodAssignmentMonoid.lean、そこからの導出は
このファイル末尾の `Derivation` 名前空間に置く。

住処: 有限型、有限部分集合、有限写像、自然数だけ。ℝ / ℂ は現れない。
-/
import CellularAutomata.ComposedNeighborhoodClosure
import CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

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

/-! ### 必要十分版からの導出

必要十分版は舞台の有限性を単位律・結合律・モノイド構造から外し、要る構造を
合併先の型の等号判定だけに絞っている。さらに合成の始域と終域が同じ型である必要も無く、
部分集合を `Set` で表せば等号判定すら要らない。有限性は元数と合成表の段だけで要る。
非可換性については、具体版が使う三元舞台は必要でなく、二元で十分かつ必要である。 -/

namespace Derivation

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

omit [Fintype V] in
/-- 具体版の自己近傍割り当ては、必要十分版のそれと同じ写像である。 -/
theorem identityNeighborhood_eq :
    identityNeighborhood V =
      _root_.CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V :=
  rfl

omit [Fintype V] in
/-- 具体版の左単位律は、必要十分版の型をまたぐ左単位律を同じ型に取ったものである。 -/
theorem identity_composedNeighborhood_of_necSuf (N : NeighborhoodAssignment V) :
    composedNeighborhood (identityNeighborhood V) N = N :=
  identity_hetComp N

omit [Fintype V] in
/-- 具体版の右単位律は、必要十分版の型をまたぐ右単位律を同じ型に取ったものである。 -/
theorem composedNeighborhood_identity_of_necSuf (N : NeighborhoodAssignment V) :
    composedNeighborhood N (identityNeighborhood V) = N :=
  hetComp_identity N

omit [Fintype V] in
/-- 具体版の結合律は、必要十分版の型をまたぐ結合律を同じ型に取ったものである。 -/
theorem composedNeighborhood_assoc_of_necSuf (N M L : NeighborhoodAssignment V) :
    composedNeighborhood (composedNeighborhood N M) L =
      composedNeighborhood N (composedNeighborhood M L) :=
  hetComp_assoc N M L

omit [Fintype V] in
/-- 具体版のモノイドの積・単位元は、必要十分版のモノイド構造のそれと一致する。 -/
theorem monoid_mul_eq_necSuf (N M : NeighborhoodAssignment V) :
    N * M =
      (_root_.CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid.neighborhoodAssignmentMonoid
        (V := V)).mul N M :=
  rfl

omit [Fintype V] in
theorem monoid_one_eq_necSuf :
    (1 : NeighborhoodAssignment V) =
      (_root_.CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid.neighborhoodAssignmentMonoid
        (V := V)).one :=
  rfl

/-- 具体版の元数は、必要十分版の元数を始域と終域が同じ場合に取ったものである。 -/
theorem card_neighborhoodAssignment_of_necSuf :
    Fintype.card (NeighborhoodAssignment V) =
      2 ^ (Fintype.card V * Fintype.card V) :=
  card_assignment (V := V) (W := V)

/-- 具体版の合成表への所属は、必要十分版の合成表への所属と同じ主張である。 -/
theorem mem_compositionTable_of_necSuf (N M : NeighborhoodAssignment V) :
    (N, M, composedNeighborhood N M) ∈
      _root_.CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid.compositionTable V :=
  _root_.CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid.mem_compositionTable N M

/-- 具体版は三元舞台の反例を使うが、必要十分版が示すとおり二元で足りる。 -/
theorem noncommutative_two_element_suffices :
    composedNeighborhood twoElementN twoElementM ≠
      composedNeighborhood twoElementM twoElementN :=
  twoElement_noncommutative

/-- 逆向きの必要性: 舞台が高々一元なら合成は可換になる。
    したがって具体版の反例が二元以上の舞台を要求することは落とせない。 -/
theorem noncommutative_needs_two_elements {W : Type} [DecidableEq W] [Subsingleton W]
    (N M : NeighborhoodAssignment W) :
    composedNeighborhood N M = composedNeighborhood M N :=
  comp_comm_of_subsingleton N M

end Derivation

end CellularAutomata.FiniteNeighborhoodAssignmentMonoid
