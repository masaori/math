/-
章「合併作用の像は合併保存写像の全体である」の Lean 必要十分版。

必要な構造の検査結果:
  - 合併保存の二条件、合併作用が二条件を満たすこと、一元部分集合からの復元、
    像の特徴づけ、表現の一意性には舞台の有限性を要しない。
  - 有限部分集合を使うため、始域と終域の等号判定だけを要する。
  - 始域と終域は異なる型でよい。自己写像であることも二値状態も要らない。
  - 舞台の有限性は、全ての部分集合写像の列挙、個数、合併保存性の有限決定にだけ要る。
  - 状態集合、局所規則、時間、順序、 R / C は使わない。
-/
import CellularAutomata.NeighborhoodAssignmentUnionPreservingImage
import CellularAutomata.NecSuf.NeighborhoodAssignmentSubsetUnionAction

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentUnionPreservingImage

open CellularAutomata.NecSuf.NeighborhoodAssignmentSubsetUnionAction

variable {V W : Type} [DecidableEq V] [DecidableEq W]

/-- 合併保存の二条件。始域と終域は異なる型でよい。 -/
def FiniteUnionPreserving (Phi : Finset V → Finset W) : Prop :=
  Phi ∅ = ∅ ∧ ∀ S T : Finset V, Phi (S ∪ T) = Phi S ∪ Phi T

/-- 合併作用は空集合を保つ。 -/
theorem hetUnionMap_preserves_empty (N : V → Finset W) :
    hetUnionMap N ∅ = ∅ := by
  ext w
  simp [hetUnionMap]

/-- 合併作用は二元の合併を保つ。 -/
theorem hetUnionMap_preserves_union (N : V → Finset W) (S T : Finset V) :
    hetUnionMap N (S ∪ T) = hetUnionMap N S ∪ hetUnionMap N T := by
  ext w
  simp only [hetUnionMap, Finset.mem_biUnion, Finset.mem_union]
  constructor
  · rintro ⟨v, hv | hv, hw⟩
    · exact Or.inl ⟨v, hv, hw⟩
    · exact Or.inr ⟨v, hv, hw⟩
  · rintro (⟨v, hv, hw⟩ | ⟨v, hv, hw⟩)
    · exact ⟨v, Or.inl hv, hw⟩
    · exact ⟨v, Or.inr hv, hw⟩

/-- 合併作用は合併保存である。 -/
theorem finiteUnionPreserving_hetUnionMap (N : V → Finset W) :
    FiniteUnionPreserving (hetUnionMap N) :=
  ⟨hetUnionMap_preserves_empty N, hetUnionMap_preserves_union N⟩

/-- 合併保存写像は一元部分集合での値だけで決まる。有限性は要らない。 -/
theorem finiteUnionPreserving_determined_by_singletons
    {Phi : Finset V -> Finset W} (hPhi : FiniteUnionPreserving Phi) (S : Finset V) :
    Phi S = S.biUnion (fun v => Phi {v}) := by
  induction S using Finset.induction_on with
  | empty =>
      calc
        Phi ∅ = ∅ := hPhi.1
        _ = (∅ : Finset V).biUnion (fun v => Phi {v}) := by simp
  | insert u S' hu ih =>
      have hsplit : insert u S' = S' ∪ {u} := by
        ext x
        simp
      calc
        Phi (insert u S') = Phi (S' ∪ {u}) := by rw [hsplit]
        _ = Phi S' ∪ Phi {u} := hPhi.2 S' {u}
        _ = S'.biUnion (fun v => Phi {v}) ∪ Phi {u} := by rw [ih]
        _ = (S' ∪ {u}).biUnion (fun v => Phi {v}) := by
          ext w
          simp [Finset.mem_biUnion, or_comm]
        _ = (insert u S').biUnion (fun v => Phi {v}) := by rw [hsplit]

/-- 合併保存と、ある有限近傍割り当ての合併作用であることは同値。 -/
theorem finiteUnionPreserving_iff_exists_assignment (Phi : Finset V -> Finset W) :
    FiniteUnionPreserving Phi ↔ ∃ N : V → Finset W, Phi = hetUnionMap N := by
  constructor
  . intro hPhi
    refine ⟨fun v => Phi {v}, ?_⟩
    funext S
    exact finiteUnionPreserving_determined_by_singletons hPhi S
  . rintro ⟨N, rfl⟩
    exact finiteUnionPreserving_hetUnionMap N

/-- 合併作用による表現は一意である。 -/
theorem representation_unique {Phi : Finset V → Finset W} {N M : V → Finset W}
    (hN : Phi = hetUnionMap N) (hM : Phi = hetUnionMap M) : N = M :=
  hetUnionMap_injective (hN ▸ hM : hetUnionMap N = hetUnionMap M)

/-- 表現する割り当ての値は一元部分集合での像である。 -/
theorem representation_value {Phi : Finset V → Finset W} {N : V → Finset W}
    (hN : Phi = hetUnionMap N) (v : V) : N v = Phi {v} := by
  calc
    N v = hetUnionMap N {v} := (hetUnionMap_singleton N v).symm
    _ = Phi {v} := by rw [hN]

/-! ### 有限性が要る列挙・個数・決定 -/

section Finite

variable [Fintype V]

instance instDecidableFiniteUnionPreserving (Phi : Finset V → Finset W) :
    Decidable (FiniteUnionPreserving Phi) := by
  unfold FiniteUnionPreserving
  infer_instance

def finiteUnionPreservingTable : Finset (Finset V -> Finset V) :=
  Finset.univ.filter FiniteUnionPreserving

theorem mem_finiteUnionPreservingTable (Phi : Finset V -> Finset V) :
    Phi ∈ finiteUnionPreservingTable ↔ FiniteUnionPreserving Phi := by
  simp [finiteUnionPreservingTable]

theorem finiteUnionPreservingTable_eq_image :
    finiteUnionPreservingTable (V := V) =
      Finset.univ.image (hetUnionMap (V := V) (W := V)) := by
  ext Phi
  rw [mem_finiteUnionPreservingTable]
  simp only [Finset.mem_image, Finset.mem_univ, true_and]
  constructor
  . intro hPhi
    obtain ⟨N, hN⟩ := (finiteUnionPreserving_iff_exists_assignment Phi).1 hPhi
    exact ⟨N, hN.symm⟩
  . rintro ⟨N, rfl⟩
    exact finiteUnionPreserving_hetUnionMap N

theorem card_finiteUnionPreservingTable :
    (finiteUnionPreservingTable (V := V)).card =
      2 ^ (Fintype.card V * Fintype.card V) := by
  calc
    (finiteUnionPreservingTable (V := V)).card =
        (Finset.univ.image (hetUnionMap (V := V) (W := V))).card := by
          rw [finiteUnionPreservingTable_eq_image]
    _ = (Finset.univ : Finset (V -> Finset V)).card :=
          Finset.card_image_of_injective _ hetUnionMap_injective
    _ = Fintype.card (V -> Finset V) := rfl
    _ = 2 ^ (Fintype.card V * Fintype.card V) := by
          rw [Fintype.card_fun, Fintype.card_finset, Nat.pow_mul]

end Finite

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.NeighborhoodAssignmentUnionPreservingImage
open CellularAutomata.NeighborhoodAssignmentSubsetUnionAction
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid

variable {X : Type} [Fintype X] [DecidableEq X]

omit [Fintype X] in
theorem UnionPreserving_eq_FiniteUnionPreserving
    (Phi : SubsetSpace X -> SubsetSpace X) :
    UnionPreserving Phi = FiniteUnionPreserving Phi := rfl

omit [Fintype X] in
theorem unionPreserving_subsetUnionMap_of_necSuf (N : NeighborhoodAssignment X) :
    UnionPreserving (subsetUnionMap N) :=
  finiteUnionPreserving_hetUnionMap N

omit [Fintype X] in
theorem unionPreserving_determined_by_singletons_of_necSuf
    {Phi : SubsetSpace X -> SubsetSpace X} (hPhi : UnionPreserving Phi) (S : SubsetSpace X) :
    Phi S = S.biUnion (fun v => Phi {v}) :=
  finiteUnionPreserving_determined_by_singletons hPhi S

omit [Fintype X] in
theorem unionPreserving_iff_exists_neighborhoodAssignment_of_necSuf
    (Phi : SubsetSpace X -> SubsetSpace X) :
    UnionPreserving Phi ↔
      ∃ N : NeighborhoodAssignment X, Phi = subsetUnionMap N :=
  finiteUnionPreserving_iff_exists_assignment Phi

omit [Fintype X] in
theorem representation_unique_of_necSuf
    {Phi : SubsetSpace X -> SubsetSpace X} {N M : NeighborhoodAssignment X}
    (hN : Phi = subsetUnionMap N) (hM : Phi = subsetUnionMap M) : N = M :=
  representation_unique hN hM

omit [Fintype X] in
theorem representation_value_of_necSuf
    {Phi : SubsetSpace X -> SubsetSpace X} {N : NeighborhoodAssignment X}
    (hN : Phi = subsetUnionMap N) (v : X) : N v = Phi {v} :=
  representation_value hN v

theorem card_unionPreservingTable_of_necSuf :
    (unionPreservingTable (V := X)).card = 2 ^ (Fintype.card X * Fintype.card X) := by
  change (finiteUnionPreservingTable (V := X)).card = _
  exact card_finiteUnionPreservingTable

theorem finite_decidable_of_necSuf (Phi : SubsetSpace X -> SubsetSpace X) :
    UnionPreserving Phi ∨ ¬ UnionPreserving Phi :=
  @Decidable.em _ (instDecidableFiniteUnionPreserving Phi)

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentUnionPreservingImage
