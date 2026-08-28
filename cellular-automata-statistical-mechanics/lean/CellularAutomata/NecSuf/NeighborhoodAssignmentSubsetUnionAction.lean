/-
章「近傍割り当てが部分集合に定める合併作用」の必要十分版。

具体版（CellularAutomata.NeighborhoodAssignmentSubsetUnionAction）と同じ順序で、
合併写像の定義、合成、自己近傍割り当ての恒等作用、一元部分集合からの復元、表現の単射性、
合成冪等性と写像冪等性の同値、有限表現と決定可能性を示す。

必要な構造の検査結果:
  - **合成・恒等作用・復元・単射性・冪等性の同値のいずれにも、舞台の有限性も等号判定も
    要らない。** 部分集合を `Set` で表せば、これらは型にインスタンスを一つも要求せずに
    成り立つ。使うのは合併の所属条件（証人の存在）と集合・写像の外延性だけである。
  - **合成の始域と終域が同じ型である必要もない。** 合併写像を型をまたぐ
    `Set V → Set W` の形で書いても、合成則・復元・単射性はそのまま成り立つ
    （`setUnionMap_setComp`、`setUnionMap_singleton`、`setUnionMap_injective`）。
    同じ型に制限して初めて、恒等作用と冪等性の同値を述べられる。
  - **冪等性の同値に要るのは、合成則と単射性の二つだけである。** 具体版と同じ二方向で、
    順方向は合成則、逆方向は合成則と単射性を使う。有限性を落としても手順は変わらない。
  - **等号判定が要るのは有限表現の段だけである。** 有限部分集合の族を一つの `Finset` へ
    合併する `Finset.biUnion` が合併先の型の等号判定を要求する。これは合併作用の性質では
    なく表現の要求である。
  - **有限性が要るのは元数と全表の列挙、および冪等性の決定手続きの段だけである。**
  - 状態集合、局所規則、時間、順序、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NeighborhoodAssignmentSubsetUnionAction
import CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentSubsetUnionAction

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

/-! ### 合併作用（インスタンスを一つも要らない段） -/

/-- `def_neighborhood_assignment_subset_union_map` の `Set` 版。
    始域と終域の型が異なっていてもよい。 -/
def setUnionMap {V W : Type} (N : V → Set W) (S : Set V) : Set W :=
  {w | ∃ v ∈ S, w ∈ N v}

/-- `claim_neighborhood_assignment_subset_union_map_composition` の必要十分版。
    人手証明と同じ存在量化の並べ替えで U_(N ⋆ M) = U_M ∘ U_N を示す。
    型をまたいでよく、インスタンスを一つも使わない。 -/
theorem setUnionMap_setComp {V W X : Type} (N : V → Set W) (M : W → Set X) :
    setUnionMap (setComp N M) = setUnionMap M ∘ setUnionMap N := by
  funext S
  ext x
  simp only [setUnionMap, setComp, Set.mem_setOf_eq, Function.comp_apply]
  constructor
  · rintro ⟨v, hvS, u, huN, hxM⟩
    exact ⟨u, ⟨v, hvS, huN⟩, hxM⟩
  · rintro ⟨u, ⟨v, hvS, huN⟩, hxM⟩
    exact ⟨v, hvS, u, huN, hxM⟩

/-- `claim_identity_neighborhood_subset_union_map` の必要十分版。
    自己近傍割り当ては恒等写像として作用する。 -/
theorem setUnionMap_setIdentity (V : Type) :
    setUnionMap (setIdentity V) = id := by
  funext S
  ext v
  simp only [setUnionMap, setIdentity, Set.mem_setOf_eq, id_eq]
  constructor
  · rintro ⟨u, huS, hvu⟩
    have : v = u := hvu
    exact this ▸ huS
  · intro hvS
    exact ⟨v, hvS, rfl⟩

/-- `claim_neighborhood_assignment_recovered_from_singletons` の必要十分版。
    型をまたいでよく、インスタンスを一つも使わない。 -/
theorem setUnionMap_singleton {V W : Type} (N : V → Set W) (v : V) :
    setUnionMap N {v} = N v := by
  ext w
  simp only [setUnionMap, Set.mem_setOf_eq, Set.mem_singleton_iff]
  constructor
  · rintro ⟨u, huv, hwu⟩
    exact huv ▸ hwu
  · intro hwv
    exact ⟨v, rfl, hwv⟩

/-- `claim_neighborhood_assignment_subset_union_map_injective` の必要十分版。
    一元部分集合からの復元だけを使う。型をまたいでよい。 -/
theorem setUnionMap_injective {V W : Type} :
    Function.Injective (setUnionMap (V := V) (W := W)) := by
  intro N M h
  funext v
  calc
    N v = setUnionMap N {v} := (setUnionMap_singleton N v).symm
    _ = setUnionMap M {v} := congrFun h {v}
    _ = M v := setUnionMap_singleton M v

/-- `claim_neighborhood_assignment_idempotent_iff_subset_union_map_idempotent` の必要十分版。
    具体版と同じ二方向で、合成則と単射性だけを使う。有限性も等号判定も使わない。 -/
theorem setComp_idempotent_iff_setUnionMap_idempotent {V : Type} (N : V → Set V) :
    setComp N N = N ↔ setUnionMap N ∘ setUnionMap N = setUnionMap N := by
  constructor
  · intro hIdem
    rw [← setUnionMap_setComp N N, hIdem]
  · intro hIdem
    apply setUnionMap_injective
    rw [setUnionMap_setComp]
    exact hIdem

/-! ### 有限表現（等号判定が要る段） -/

/-- 有限表現版の合併写像。合併先の型の等号判定だけを要求する。 -/
def hetUnionMap {V W : Type} [DecidableEq W] (N : V → Finset W) (S : Finset V) : Finset W :=
  S.biUnion N

/-- 有限表現版と `Set` 版の橋渡し。 -/
theorem coe_hetUnionMap {V W : Type} [DecidableEq W] (N : V → Finset W) (S : Finset V) :
    ((hetUnionMap N S : Finset W) : Set W) =
      setUnionMap (fun v => ((N v : Finset W) : Set W)) ((S : Finset V) : Set V) := by
  ext w
  simp [hetUnionMap, setUnionMap]

/-- 有限表現版の合成則。証明手順は `Set` 版と同じ存在量化の並べ替えである。 -/
theorem hetUnionMap_hetComp {V W X : Type} [DecidableEq W] [DecidableEq X]
    (N : V → Finset W) (M : W → Finset X) :
    hetUnionMap (hetComp N M) = hetUnionMap M ∘ hetUnionMap N := by
  funext S
  ext x
  simp only [hetUnionMap, hetComp, Finset.mem_biUnion, Function.comp_apply]
  constructor
  · rintro ⟨v, hvS, u, huN, hxM⟩
    exact ⟨u, ⟨v, hvS, huN⟩, hxM⟩
  · rintro ⟨u, ⟨v, hvS, huN⟩, hxM⟩
    exact ⟨v, hvS, u, huN, hxM⟩

/-- 有限表現版の恒等作用。 -/
theorem hetUnionMap_identityNeighborhood (V : Type) [DecidableEq V] :
    hetUnionMap (identityNeighborhood V) = id := by
  funext S
  ext v
  simp [hetUnionMap, identityNeighborhood]

/-- 有限表現版の一元部分集合からの復元。 -/
theorem hetUnionMap_singleton {V W : Type} [DecidableEq V] [DecidableEq W]
    (N : V → Finset W) (v : V) : hetUnionMap N {v} = N v := by
  ext w
  simp [hetUnionMap]

/-- 有限表現版の単射性。 -/
theorem hetUnionMap_injective {V W : Type} [DecidableEq V] [DecidableEq W] :
    Function.Injective (hetUnionMap (V := V) (W := W)) := by
  intro N M h
  funext v
  calc
    N v = hetUnionMap N {v} := (hetUnionMap_singleton N v).symm
    _ = hetUnionMap M {v} := congrFun h {v}
    _ = M v := hetUnionMap_singleton M v

/-- 有限表現版の冪等性の同値。手順は `Set` 版と同じ二方向である。 -/
theorem hetComp_idempotent_iff_hetUnionMap_idempotent {V : Type} [DecidableEq V]
    (N : V → Finset V) :
    hetComp N N = N ↔ hetUnionMap N ∘ hetUnionMap N = hetUnionMap N := by
  constructor
  · intro hIdem
    rw [← hetUnionMap_hetComp N N, hIdem]
  · intro hIdem
    apply hetUnionMap_injective
    rw [hetUnionMap_hetComp]
    exact hIdem

/-! ### 元数と決定可能性（有限性が要る段） -/

/-- `def_finite_stage_subset_space` の元数。舞台の有限性と等号判定が要る。 -/
theorem card_finset {V : Type} [Fintype V] [DecidableEq V] :
    Fintype.card (Finset V) = 2 ^ Fintype.card V := Fintype.card_finset

/-- 有限表現版の全表。舞台の有限性が要る。 -/
def hetUnionMapTable {V W : Type} [Fintype V] [DecidableEq V] [DecidableEq W]
    (N : V → Finset W) : Finset (Finset V × Finset W) :=
  Finset.univ.image (fun S => (S, hetUnionMap N S))

theorem mem_hetUnionMapTable {V W : Type} [Fintype V] [DecidableEq V] [DecidableEq W]
    (N : V → Finset W) (S : Finset V) :
    (S, hetUnionMap N S) ∈ hetUnionMapTable N := by
  simp [hetUnionMapTable]

/-- 写像冪等性の決定可能性。入力の全列挙に舞台の有限性が要る。 -/
instance instDecidableHetUnionMapIdempotent {V : Type} [Fintype V] [DecidableEq V]
    (N : V → Finset V) :
    Decidable (hetUnionMap N ∘ hetUnionMap N = hetUnionMap N) :=
  inferInstance

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.NeighborhoodAssignmentSubsetUnionAction
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.ComposedNeighborhoodClosure

variable {V : Type} [Fintype V] [DecidableEq V]

omit [Fintype V] in
theorem subsetUnionMap_eq_hetUnionMap (N : NeighborhoodAssignment V) :
    subsetUnionMap N = hetUnionMap N := rfl

omit [Fintype V] in
/-- 具体版の合成則は、必要十分版の有限表現版の特殊化である。 -/
theorem subsetUnionMap_composedNeighborhood_of_necSuf (N M : NeighborhoodAssignment V) :
    subsetUnionMap (composedNeighborhood N M) = subsetUnionMap M ∘ subsetUnionMap N :=
  hetUnionMap_hetComp N M

omit [Fintype V] in
/-- 具体版の恒等作用は、必要十分版の特殊化である。 -/
theorem subsetUnionMap_identityNeighborhood_of_necSuf :
    subsetUnionMap
        (CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V) = id :=
  hetUnionMap_identityNeighborhood V

omit [Fintype V] in
/-- 具体版の復元は、必要十分版の特殊化である。 -/
theorem subsetUnionMap_singleton_of_necSuf (N : NeighborhoodAssignment V) (v : V) :
    subsetUnionMap N {v} = N v :=
  hetUnionMap_singleton N v

omit [Fintype V] in
/-- 具体版の単射性は、必要十分版の特殊化である。 -/
theorem subsetUnionMap_injective_of_necSuf :
    Function.Injective (subsetUnionMap (V := V)) :=
  hetUnionMap_injective

omit [Fintype V] in
/-- 具体版の冪等性の同値は、必要十分版の特殊化である。 -/
theorem composedNeighborhood_idempotent_iff_subsetUnionMap_idempotent_of_necSuf
    (N : NeighborhoodAssignment V) :
    composedNeighborhood N N = N ↔ subsetUnionMap N ∘ subsetUnionMap N = subsetUnionMap N :=
  hetComp_idempotent_iff_hetUnionMap_idempotent N

/-- 具体版の元数は、必要十分版の特殊化である。 -/
theorem card_subsetSpace_of_necSuf :
    Fintype.card (SubsetSpace V) = 2 ^ Fintype.card V :=
  card_finset

/-- 具体版の有限決定は、必要十分版の決定可能性インスタンスの特殊化である。 -/
theorem finite_decidable_of_necSuf (N : NeighborhoodAssignment V) :
    (subsetUnionMap N ∘ subsetUnionMap N = subsetUnionMap N) ∨
      ¬ (subsetUnionMap N ∘ subsetUnionMap N = subsetUnionMap N) :=
  @Decidable.em _ (instDecidableHetUnionMapIdempotent N)

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentSubsetUnionAction
