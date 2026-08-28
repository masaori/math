/-
章「合併作用の像は合併保存写像の全体である」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-union-preserving-image.ts。

人手証明と同じ対象・仮定・順序で形式化する。すなわち
  合併保存の定義 → 合併写像が空集合を保つ → 合併写像が二元の合併を保つ
  → 合併保存写像は一元部分集合での値で決まる → 像の特徴づけ
  → 表現の一意性 → 個数 → 有限決定
の順に並べる。有限舞台、有限近傍割り当て、有限部分集合、自然数だけを使い、
ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentSubsetUnionAction

namespace CellularAutomata.NeighborhoodAssignmentUnionPreservingImage

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentSubsetUnionAction

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_union_preserving_subset_map` の合併保存写像。
    人手証明と同じく二条件の連言として書く（近傍割り当てを参照しない）。 -/
def UnionPreserving (Φ : SubsetSpace V → SubsetSpace V) : Prop :=
  Φ ∅ = ∅ ∧ ∀ S T : SubsetSpace V, Φ (S ∪ T) = Φ S ∪ Φ T

omit [Fintype V] in
/-- `claim_subset_union_map_preserves_empty`。
    人手証明どおり w ∈ U_N(∅) ⟺ ∃ v ∈ ∅, w ∈ N(v) ⟺ ⊥ ⟺ w ∈ ∅ をたどる。 -/
theorem subsetUnionMap_preserves_empty (N : NeighborhoodAssignment V) :
    subsetUnionMap N ∅ = ∅ := by
  ext w
  simp [subsetUnionMap]

omit [Fintype V] in
/-- `claim_subset_union_map_preserves_union`。
    人手証明どおり存在量化と論理和の交換で示す。 -/
theorem subsetUnionMap_preserves_union (N : NeighborhoodAssignment V)
    (S T : SubsetSpace V) :
    subsetUnionMap N (S ∪ T) = subsetUnionMap N S ∪ subsetUnionMap N T := by
  ext w
  simp only [subsetUnionMap, Finset.mem_biUnion, Finset.mem_union]
  constructor
  · rintro ⟨v, hv | hv, hw⟩
    · exact Or.inl ⟨v, hv, hw⟩
    · exact Or.inr ⟨v, hv, hw⟩
  · rintro (⟨v, hv, hw⟩ | ⟨v, hv, hw⟩)
    · exact ⟨v, Or.inl hv, hw⟩
    · exact ⟨v, Or.inr hv, hw⟩

omit [Fintype V] in
/-- 合併写像は合併保存である（上の二つの claim をまとめただけ）。 -/
theorem unionPreserving_subsetUnionMap (N : NeighborhoodAssignment V) :
    UnionPreserving (subsetUnionMap N) :=
  ⟨subsetUnionMap_preserves_empty N, subsetUnionMap_preserves_union N⟩

omit [Fintype V] in
/-- `claim_union_preserving_map_determined_by_singletons`。
    人手証明と同じ |S| についての帰納法（`Finset.induction_on` は
    S = S' ∪ {u}、|S'| = |S| - 1 の分解にあたる）。 -/
theorem unionPreserving_determined_by_singletons
    {Φ : SubsetSpace V → SubsetSpace V} (hΦ : UnionPreserving Φ)
    (S : SubsetSpace V) :
    Φ S = S.biUnion (fun v => Φ {v}) := by
  classical
  induction S using Finset.induction_on with
  | empty =>
      -- |S| = 0 の場合。Φ(∅) = ∅ = 空な添字集合上の合併。
      calc
        Φ ∅ = ∅ := hΦ.1
        _ = (∅ : SubsetSpace V).biUnion (fun v => Φ {v}) := by simp
  | insert u S' hu ih =>
      -- |S| = n + 1 の場合。S = S' ∪ {u}、u ∉ S'。
      have hsplit : insert u S' = S' ∪ {u} := by
        ext x; simp
      calc
        Φ (insert u S')
            = Φ (S' ∪ {u}) := by rw [hsplit]
        _ = Φ S' ∪ Φ {u} := hΦ.2 S' {u}
        _ = S'.biUnion (fun v => Φ {v}) ∪ Φ {u} := by rw [ih]
        _ = (S' ∪ {u}).biUnion (fun v => Φ {v}) := by
              ext w; simp [Finset.mem_biUnion, or_comm]
        _ = (insert u S').biUnion (fun v => Φ {v}) := by rw [hsplit]

omit [Fintype V] in
/-- `claim_subset_union_map_image_is_union_preserving_maps`。
    合併保存であることと、ある近傍割り当ての合併作用であることは同値。 -/
theorem unionPreserving_iff_exists_neighborhoodAssignment
    (Φ : SubsetSpace V → SubsetSpace V) :
    UnionPreserving Φ ↔ ∃ N : NeighborhoodAssignment V, Φ = subsetUnionMap N := by
  constructor
  · -- (⟹) N(v) := Φ({v}) と置く。
    intro hΦ
    refine ⟨fun v => Φ {v}, ?_⟩
    funext S
    calc
      Φ S = S.biUnion (fun v => Φ {v}) :=
            unionPreserving_determined_by_singletons hΦ S
      _ = subsetUnionMap (fun v => Φ {v}) S := rfl
  · -- (⟸) 合併写像は二条件を満たす。
    rintro ⟨N, rfl⟩
    exact unionPreserving_subsetUnionMap N

omit [Fintype V] in
/-- `claim_union_preserving_map_representation_unique` の一意性。
    人手証明どおり合併作用の単射性（前章）から出す。 -/
theorem representation_unique {Φ : SubsetSpace V → SubsetSpace V}
    {N M : NeighborhoodAssignment V}
    (hN : Φ = subsetUnionMap N) (hM : Φ = subsetUnionMap M) : N = M :=
  subsetUnionMap_injective (hN ▸ hM : subsetUnionMap N = subsetUnionMap M)

omit [Fintype V] in
/-- `claim_union_preserving_map_representation_unique` の値の表示 N(v) = Φ({v})。 -/
theorem representation_value {Φ : SubsetSpace V → SubsetSpace V}
    {N : NeighborhoodAssignment V} (hN : Φ = subsetUnionMap N) (v : V) :
    N v = Φ {v} := by
  calc
    N v = subsetUnionMap N {v} := (subsetUnionMap_singleton N v).symm
    _ = Φ {v} := by rw [hN]

/-- `claim_union_preserving_map_finite_decidable`。
    有限舞台では合併保存性が有限回の所属判定で決定できる。 -/
instance instDecidableUnionPreserving (Φ : SubsetSpace V → SubsetSpace V) :
    Decidable (UnionPreserving Φ) := by
  unfold UnionPreserving
  infer_instance

/-- 合併保存写像を有限に集めた表 UP(V)。 -/
def unionPreservingTable : Finset (SubsetSpace V → SubsetSpace V) :=
  Finset.univ.filter (fun Φ => UnionPreserving Φ)

/-- 表は合併保存写像をちょうど集めている。 -/
theorem mem_unionPreservingTable (Φ : SubsetSpace V → SubsetSpace V) :
    Φ ∈ unionPreservingTable ↔ UnionPreserving Φ := by
  simp [unionPreservingTable]

/-- `claim_union_preserving_map_count` の前段。
    UP(V) は N ↦ U_N の像に一致する（単射性と全射性は上の二定理）。 -/
theorem unionPreservingTable_eq_image :
    unionPreservingTable (V := V)
      = Finset.univ.image (subsetUnionMap (V := V)) := by
  ext Φ
  rw [mem_unionPreservingTable]
  simp only [Finset.mem_image, Finset.mem_univ, true_and]
  constructor
  · intro hΦ
    obtain ⟨N, hN⟩ := (unionPreserving_iff_exists_neighborhoodAssignment Φ).1 hΦ
    exact ⟨N, hN.symm⟩
  · rintro ⟨N, rfl⟩
    exact unionPreserving_subsetUnionMap N

/-- `claim_union_preserving_map_count`。|UP(V)| = 2^(|V|*|V|)。 -/
theorem card_unionPreservingTable :
    (unionPreservingTable (V := V)).card = 2 ^ (Fintype.card V * Fintype.card V) := by
  calc
    (unionPreservingTable (V := V)).card
        = (Finset.univ.image (subsetUnionMap (V := V))).card := by
          rw [unionPreservingTable_eq_image]
    _ = (Finset.univ : Finset (NeighborhoodAssignment V)).card :=
          Finset.card_image_of_injective _ subsetUnionMap_injective
    _ = Fintype.card (NeighborhoodAssignment V) := rfl
    _ = 2 ^ (Fintype.card V * Fintype.card V) := card_neighborhoodAssignment

/-- `claim_union_preserving_map_finite_decidable` の構成部分。
    真の場合に取る近傍割り当ては Φ の一元部分集合での値で与えられる。 -/
def representingNeighborhood (Φ : SubsetSpace V → SubsetSpace V) :
    NeighborhoodAssignment V := fun v => Φ {v}

omit [Fintype V] in
/-- 構成した近傍割り当ては実際に Φ を与える。 -/
theorem subsetUnionMap_representingNeighborhood
    {Φ : SubsetSpace V → SubsetSpace V} (hΦ : UnionPreserving Φ) :
    subsetUnionMap (representingNeighborhood Φ) = Φ := by
  funext S
  exact (unionPreserving_determined_by_singletons hΦ S).symm

end CellularAutomata.NeighborhoodAssignmentUnionPreservingImage
