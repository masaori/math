/-
章「近傍割り当ての点ごとの和と合成の分配性」の必要十分版。

具体版（CellularAutomata.NeighborhoodAssignmentUnionDistributivity）と同じ順序で、
空近傍割り当て、点ごとの和、和の四法則、包含順序の特徴づけ、合成の左右分配、
空近傍の両側吸収、有限な演算表、冪等半環を示す。

必要な構造の検査結果:
  - 和の可換・結合・冪等・単位律には舞台の有限性は要らない。要るのは値の集合の
    合併先の型の等号判定だけであり、それは `Finset` の合併 `∪` の要求である。
  - 和の始域と終域が同じ型である必要も無い。近傍割り当てを型をまたぐ
    `V → Finset W` の形で書いても、四法則はそのまま成り立つ。
  - 包含順序の特徴づけ `N ≼ M ↔ N ⊔ M = M` に要るのは、値の集合の外延性と
    写像の外延性だけである。有限性も、始域と終域が同じ型であることも要らない。
  - 左分配 `(N ⊔ M) ⋆ L = (N ⋆ L) ⊔ (M ⋆ L)` は三つの型 V → W → X をまたいでよい。
    中間の型 W の等号判定は和の側の、終域 X の等号判定は合併 `Finset.biUnion` の
    側の要求である。右分配 `L ⋆ (N ⊔ M) = (L ⋆ N) ⊔ (L ⋆ M)` では終域 X の
    等号判定だけで足り、中間の型 W の等号判定は要らない（和が終域側で取られるため）。
  - 空近傍の両側吸収も型をまたいでよく、有限性を使わない。
  - 等号判定すら本質ではない。部分集合を `Set` で表せば、和・分配・吸収は
    型にいかなるインスタンスも要求しない。`Finset` 版の等号判定は有限表現のための
    ものであり、`Set` 版との対応を橋渡し定理で示す。
  - 有限性が要るのは和の全演算表を作る段だけである。
  - 冪等半環になるのは、和と合成の型がともに閉じる（始域と終域を同じ型に取る）
    ときだけである。
  - 状態集合、局所規則、時間、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.OrderedNeighborhoodAssignmentMonoid

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity

open CellularAutomata.NecSuf.ComposedNeighborhoodClosure
open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.OrderedNeighborhoodAssignmentMonoid

/-! ### 型をまたぐ空近傍割り当てと点ごとの和（有限性を使わない段）

`def_empty_neighborhood_assignment` と `def_neighborhood_assignment_pointwise_union` を、
始域と終域が異なる型でも書けることを確かめる。 -/

/-- 型をまたぐ空近傍割り当て。等号判定も有限性も要求しない。 -/
def hetEmpty (V W : Type) : V → Finset W :=
  fun _ => ∅

/-- 型をまたぐ点ごとの和。要るのは終域の等号判定だけである。 -/
def hetUnion {V W : Type} [DecidableEq W] (N M : V → Finset W) : V → Finset W :=
  fun v => N v ∪ M v

/-- 可換律。舞台の有限性は使わない。 -/
theorem hetUnion_comm {V W : Type} [DecidableEq W] (N M : V → Finset W) :
    hetUnion N M = hetUnion M N := by
  funext v
  exact Finset.union_comm (N v) (M v)

/-- 結合律。舞台の有限性は使わない。 -/
theorem hetUnion_assoc {V W : Type} [DecidableEq W] (N M L : V → Finset W) :
    hetUnion (hetUnion N M) L = hetUnion N (hetUnion M L) := by
  funext v
  exact Finset.union_assoc (N v) (M v) (L v)

/-- 冪等律。舞台の有限性は使わない。 -/
theorem hetUnion_idem {V W : Type} [DecidableEq W] (N : V → Finset W) :
    hetUnion N N = N := by
  funext v
  exact Finset.union_self (N v)

/-- 右単位律。舞台の有限性は使わない。 -/
theorem hetUnion_empty_right {V W : Type} [DecidableEq W] (N : V → Finset W) :
    hetUnion N (hetEmpty V W) = N := by
  funext v
  simp [hetUnion, hetEmpty]

/-- 左単位律。人手証明どおり可換律から従う。 -/
theorem hetUnion_empty_left {V W : Type} [DecidableEq W] (N : V → Finset W) :
    hetUnion (hetEmpty V W) N = N := by
  rw [hetUnion_comm]
  exact hetUnion_empty_right N

/-- `claim_neighborhood_assignment_inclusion_iff_union_eq` の型をまたぐ版。
    要るのは値の集合の外延性と写像の外延性だけで、有限性は要らない。 -/
theorem hetInclusion_iff_hetUnion_eq {V W : Type} [DecidableEq W] (N M : V → Finset W) :
    HetInclusion N M ↔ hetUnion N M = M := by
  constructor
  · intro h
    funext v
    exact Finset.union_eq_right.mpr (h v)
  · intro h v w hw
    have hwUnion : w ∈ hetUnion N M v := by
      simp [hetUnion, hw]
    rw [h] at hwUnion
    exact hwUnion

/-- 人手証明の第一の分配律の型をまたぐ版。始域 V、中間 W、終域 X が異なってよい。
    中間の型 W の等号判定は和の側の、終域 X の等号判定は合併の側の要求である。 -/
theorem hetUnion_hetComp {V W X : Type} [DecidableEq W] [DecidableEq X]
    (N M : V → Finset W) (L : W → Finset X) :
    hetComp (hetUnion N M) L = hetUnion (hetComp N L) (hetComp M L) := by
  funext v
  ext w
  simp only [hetComp, hetUnion, Finset.mem_biUnion, Finset.mem_union]
  constructor
  · rintro ⟨u, huN | huM, hwL⟩
    · exact Or.inl ⟨u, huN, hwL⟩
    · exact Or.inr ⟨u, huM, hwL⟩
  · rintro (⟨u, huN, hwL⟩ | ⟨u, huM, hwL⟩)
    · exact ⟨u, Or.inl huN, hwL⟩
    · exact ⟨u, Or.inr huM, hwL⟩

/-- 人手証明の第二の分配律の型をまたぐ版。ここでは和が終域側で取られるため、
    中間の型 W の等号判定は要らず、終域 X の等号判定だけで足りる。 -/
theorem hetComp_hetUnion {V W X : Type} [DecidableEq X]
    (L : V → Finset W) (N M : W → Finset X) :
    hetComp L (hetUnion N M) = hetUnion (hetComp L N) (hetComp L M) := by
  funext v
  ext w
  simp only [hetComp, hetUnion, Finset.mem_biUnion, Finset.mem_union]
  constructor
  · rintro ⟨u, huL, hwN | hwM⟩
    · exact Or.inl ⟨u, huL, hwN⟩
    · exact Or.inr ⟨u, huL, hwM⟩
  · rintro (⟨u, huL, hwN⟩ | ⟨u, huL, hwM⟩)
    · exact ⟨u, huL, Or.inl hwN⟩
    · exact ⟨u, huL, Or.inr hwM⟩

/-- 左からの吸収。空集合を添字とする合併は空である。有限性は使わない。 -/
theorem hetEmpty_hetComp {V W X : Type} [DecidableEq X] (N : W → Finset X) :
    hetComp (hetEmpty V W) N = hetEmpty V X := by
  funext v
  simp [hetComp, hetEmpty]

/-- 右からの吸収。空集合だけの合併は空である。有限性は使わない。 -/
theorem hetComp_hetEmpty {V W X : Type} [DecidableEq X] (N : V → Finset W) :
    hetComp N (hetEmpty W X) = hetEmpty V X := by
  funext v
  ext w
  simp [hetComp, hetEmpty]

/-! ### 等号判定を落とす検査

部分集合を `Set` で表すと、和・分配・吸収はインスタンスを一つも要求しない。
`Finset` 版の等号判定は有限表現のためだけに要る。 -/

/-- `Set` 値の空近傍割り当て。 -/
def setEmpty (V W : Type) : V → Set W := fun _ => (∅ : Set W)

/-- `Set` 値の点ごとの和。型にインスタンスを一つも要求しない。 -/
def setUnion {V W : Type} (N M : V → Set W) : V → Set W :=
  fun v => N v ∪ M v

theorem setUnion_comm {V W : Type} (N M : V → Set W) :
    setUnion N M = setUnion M N := by
  funext v
  exact Set.union_comm (N v) (M v)

theorem setUnion_assoc {V W : Type} (N M L : V → Set W) :
    setUnion (setUnion N M) L = setUnion N (setUnion M L) := by
  funext v
  exact Set.union_assoc (N v) (M v) (L v)

theorem setUnion_idem {V W : Type} (N : V → Set W) : setUnion N N = N := by
  funext v
  exact Set.union_self (N v)

theorem setUnion_empty_right {V W : Type} (N : V → Set W) :
    setUnion N (setEmpty V W) = N := by
  funext v
  simp [setUnion, setEmpty]

theorem setUnion_empty_left {V W : Type} (N : V → Set W) :
    setUnion (setEmpty V W) N = N := by
  rw [setUnion_comm]
  exact setUnion_empty_right N

/-- `Set` 版の包含順序の特徴づけ。等号判定も有限性も使わない。 -/
theorem setInclusion_iff_setUnion_eq {V W : Type} (N M : V → Set W) :
    SetInclusion N M ↔ setUnion N M = M := by
  constructor
  · intro h
    funext v
    exact Set.union_eq_self_of_subset_left (h v)
  · intro h v w hw
    have hwUnion : w ∈ setUnion N M v := Or.inl hw
    rw [h] at hwUnion
    exact hwUnion

/-- `Set` 版の第一の分配律。インスタンスを一つも使わない。 -/
theorem setUnion_setComp {V W X : Type}
    (N M : V → Set W) (L : W → Set X) :
    setComp (setUnion N M) L = setUnion (setComp N L) (setComp M L) := by
  funext v
  ext w
  constructor
  · rintro ⟨u, huN | huM, hwL⟩
    · exact Or.inl ⟨u, huN, hwL⟩
    · exact Or.inr ⟨u, huM, hwL⟩
  · rintro (⟨u, huN, hwL⟩ | ⟨u, huM, hwL⟩)
    · exact ⟨u, Or.inl huN, hwL⟩
    · exact ⟨u, Or.inr huM, hwL⟩

/-- `Set` 版の第二の分配律。インスタンスを一つも使わない。 -/
theorem setComp_setUnion {V W X : Type}
    (L : V → Set W) (N M : W → Set X) :
    setComp L (setUnion N M) = setUnion (setComp L N) (setComp L M) := by
  funext v
  ext w
  constructor
  · rintro ⟨u, huL, hwN | hwM⟩
    · exact Or.inl ⟨u, huL, hwN⟩
    · exact Or.inr ⟨u, huL, hwM⟩
  · rintro (⟨u, huL, hwN⟩ | ⟨u, huL, hwM⟩)
    · exact ⟨u, huL, Or.inl hwN⟩
    · exact ⟨u, huL, Or.inr hwM⟩

theorem setEmpty_setComp {V W X : Type} (N : W → Set X) :
    setComp (setEmpty V W) N = setEmpty V X := by
  funext v
  ext w
  constructor
  · rintro ⟨u, hu, _⟩
    exact hu.elim
  · intro hw
    exact hw.elim

theorem setComp_setEmpty {V W X : Type} (N : V → Set W) :
    setComp N (setEmpty W X) = setEmpty V X := by
  funext v
  ext w
  constructor
  · rintro ⟨u, _, hw⟩
    exact hw.elim
  · intro hw
    exact hw.elim

/-- 橋渡し: `Finset` 版の和を集合として読むと `Set` 版の和に一致する。
    すなわち等号判定は有限表現のためだけに要る。 -/
theorem coe_hetUnion {V W : Type} [DecidableEq W] (N M : V → Finset W) (v : V) :
    ((hetUnion N M v : Finset W) : Set W) =
      setUnion (fun v => ((N v : Finset W) : Set W))
        (fun v => ((M v : Finset W) : Set W)) v := by
  ext w
  simp [hetUnion, setUnion]

/-- 橋渡し: `Finset` 版の空近傍割り当てを集合として読むと `Set` 版に一致する。 -/
theorem coe_hetEmpty {V W : Type} (v : V) :
    ((hetEmpty V W v : Finset W) : Set W) = setEmpty V W v := by
  ext w
  simp [hetEmpty, setEmpty]

/-- 既製の演算との一致を述べる橋渡し定理（自前の証明を置いたうえでの一本）。
    `Set` 値の点ごとの和は、`V → Set W` の既定の上限 `⊔` と同じ写像である。 -/
theorem setUnion_eq_sup {V W : Type} (N M : V → Set W) :
    setUnion N M = N ⊔ M := rfl

/-! ### 有限な演算表（有限性が要る段）

和の全演算表を作る段で初めて有限性が要る。ここでも要るのは始域の有限性と
終域の等号判定であり、そこから写像全体が有限型になる。 -/

/-- 型をまたぐ和の全演算表。始域と終域が異なっていてもよい。 -/
def hetUnionTable (V W : Type) [Fintype V] [Fintype W] [DecidableEq V] [DecidableEq W] :
    Finset ((V → Finset W) × (V → Finset W) × (V → Finset W)) :=
  Finset.univ.image (fun p : (V → Finset W) × (V → Finset W) =>
    (p.1, p.2, hetUnion p.1 p.2))

/-- 和の表は任意の二つの近傍割り当てと、その点ごとの和を含む。 -/
theorem mem_hetUnionTable {V W : Type} [Fintype V] [Fintype W] [DecidableEq V] [DecidableEq W]
    (N M : V → Finset W) :
    (N, M, hetUnion N M) ∈ hetUnionTable V W := by
  simp [hetUnionTable]

/-! ### 冪等半環（和と合成の型をともに閉じた段）

和と合成の両方を同じ集合の上の演算として持つには、始域と終域を同じ型に取る必要がある。 -/

/-- `claim_finite_neighborhood_assignments_form_idempotent_semiring` の必要十分版。
    和の冪等可換モノイド律、左右分配、空近傍の両側吸収を同時に記録する。
    舞台の有限性は要らず、要るのは合併先の等号判定だけである。 -/
theorem idempotent_semiring_laws {V : Type} [DecidableEq V] :
    (∀ N : V → Finset V, hetUnion (hetEmpty V V) N = N) ∧
    (∀ N M : V → Finset V, hetUnion N M = hetUnion M N) ∧
    (∀ N M L : V → Finset V,
      hetUnion (hetUnion N M) L = hetUnion N (hetUnion M L)) ∧
    (∀ N : V → Finset V, hetUnion N N = N) ∧
    (∀ N M L : V → Finset V, composedNeighborhood (hetUnion N M) L =
      hetUnion (composedNeighborhood N L) (composedNeighborhood M L)) ∧
    (∀ L N M : V → Finset V, composedNeighborhood L (hetUnion N M) =
      hetUnion (composedNeighborhood L N) (composedNeighborhood L M)) ∧
    (∀ N : V → Finset V,
      composedNeighborhood (hetEmpty V V) N = hetEmpty V V) ∧
    (∀ N : V → Finset V,
      composedNeighborhood N (hetEmpty V V) = hetEmpty V V) := by
  refine ⟨hetUnion_empty_left, hetUnion_comm, hetUnion_assoc, hetUnion_idem, ?_, ?_, ?_, ?_⟩
  · intro N M L
    rw [← hetComp_eq_composedNeighborhood, ← hetComp_eq_composedNeighborhood,
      ← hetComp_eq_composedNeighborhood]
    exact hetUnion_hetComp N M L
  · intro L N M
    rw [← hetComp_eq_composedNeighborhood, ← hetComp_eq_composedNeighborhood,
      ← hetComp_eq_composedNeighborhood]
    exact hetComp_hetUnion L N M
  · intro N
    rw [← hetComp_eq_composedNeighborhood]
    exact hetEmpty_hetComp N
  · intro N
    rw [← hetComp_eq_composedNeighborhood]
    exact hetComp_hetEmpty N

end CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity
