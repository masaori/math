/-
章「有限近傍割り当ての合成モノイド」の必要十分版。

具体版（CellularAutomata.FiniteNeighborhoodAssignmentMonoid）と同じ順序で、
自己近傍割り当て、両側単位律、結合律、モノイド構造、元数、非可換性を示す。

必要な構造の検査結果:
  - 単位律・結合律には舞台の有限性は要らない。要るのは合併先の型の等号判定だけであり、
    それは有限部分集合の族を一つの `Finset` へ合併する `Finset.biUnion` の要求である。
  - 合成の始域と終域が同じ型である必要も無い。近傍割り当てを型をまたぐ
    `V → Finset W` の形で書いても、単位律と結合律はそのまま成り立つ。
    同じ型に制限して初めてモノイドになる。
  - 等号判定すら本質ではない。部分集合を `Set` で表せば、合成・単位律・結合律は
    型にいかなるインスタンスも要求しない。`Finset` 版の等号判定は有限表現のための
    ものであり、`Set` 版との対応を橋渡し定理で示す。
  - 有限性が要るのは元数と全列挙（合成表）の段だけである。
  - 非可換性に必要十分なのは舞台が二元以上を持つことである。二元の明示反例で
    十分であり、逆に舞台が高々一元なら合成は必ず可換になる。
  - 状態集合、局所規則、時間、順序、演算、ℝ / ℂ はいずれも使わない。
-/
import Mathlib.Data.Fintype.Powerset
import Mathlib.Data.Fintype.BigOperators
import CellularAutomata.NecSuf.ComposedNeighborhoodClosure

namespace CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

open CellularAutomata.NecSuf.ComposedNeighborhoodClosure

/-! ### 型をまたぐ合成（有限性を使わない段）

`def_composed_neighborhood` の合成を、始域と終域が異なる型でも書けることを確かめる。
`Finset.biUnion` は合併先の型の等号判定だけを要求する。 -/

/-- 型をまたぐ近傍割り当ての合成 (N ⋆ M)(v) = ⋃_{u ∈ N(v)} M(u)。 -/
def hetComp {V W X : Type} [DecidableEq X]
    (N : V → Finset W) (M : W → Finset X) : V → Finset X :=
  fun v => (N v).biUnion M

/-- `def_identity_neighborhood_assignment` の自己近傍割り当て I_V(v) = {v}。 -/
def identityNeighborhood (V : Type) [DecidableEq V] : V → Finset V :=
  fun v => {v}

/-- 型をまたぐ合成は、同じ型に制限すると
    `NecSuf.ComposedNeighborhoodClosure.composedNeighborhood` に一致する。 -/
theorem hetComp_eq_composedNeighborhood {V : Type} [DecidableEq V] (N M : V → Finset V) :
    hetComp N M = composedNeighborhood N M :=
  rfl

/-- 左単位律。舞台の有限性は使わない。 -/
theorem identity_hetComp {V W : Type} [DecidableEq V] [DecidableEq W]
    (N : V → Finset W) : hetComp (identityNeighborhood V) N = N := by
  funext v
  simp [hetComp, identityNeighborhood]

/-- 右単位律。舞台の有限性は使わない。 -/
theorem hetComp_identity {V W : Type} [DecidableEq W]
    (N : V → Finset W) : hetComp N (identityNeighborhood W) = N := by
  funext v
  ext w
  simp [hetComp, identityNeighborhood]

/-- 結合律。人手証明どおり二重の存在量化を同じ順序で展開する。
    舞台の有限性は使わず、合併先の型の等号判定だけを使う。 -/
theorem hetComp_assoc {V W X Y : Type} [DecidableEq X] [DecidableEq Y]
    (N : V → Finset W) (M : W → Finset X) (L : X → Finset Y) :
    hetComp (hetComp N M) L = hetComp N (hetComp M L) := by
  funext v
  ext w
  simp only [hetComp, Finset.mem_biUnion]
  constructor
  · rintro ⟨u, ⟨r, hrN, huM⟩, hwL⟩
    exact ⟨r, hrN, u, huM, hwL⟩
  · rintro ⟨r, hrN, u, huM, hwL⟩
    exact ⟨u, ⟨r, hrN, huM⟩, hwL⟩

/-! ### モノイド構造（同じ型に制限した段） -/

/-- `claim_finite_neighborhood_assignments_form_monoid`。
    同じ型に制限した合成と自己近傍割り当てがモノイドをなす。有限性は使わない。
    具体版が同じ型に別のモノイド構造を宣言するため、ここでは instance にしない。 -/
def neighborhoodAssignmentMonoid {V : Type} [DecidableEq V] :
    Monoid (V → Finset V) where
  mul := composedNeighborhood
  one := identityNeighborhood V
  mul_assoc N M L := by
    show composedNeighborhood (composedNeighborhood N M) L =
      composedNeighborhood N (composedNeighborhood M L)
    rw [← hetComp_eq_composedNeighborhood, ← hetComp_eq_composedNeighborhood,
      ← hetComp_eq_composedNeighborhood, ← hetComp_eq_composedNeighborhood]
    exact hetComp_assoc N M L
  one_mul N := by
    show composedNeighborhood (identityNeighborhood V) N = N
    rw [← hetComp_eq_composedNeighborhood]
    exact identity_hetComp N
  mul_one N := by
    show composedNeighborhood N (identityNeighborhood V) = N
    rw [← hetComp_eq_composedNeighborhood]
    exact hetComp_identity N

/-! ### 等号判定を落とす検査

部分集合を `Set` で表すと、合成・単位律・結合律はいかなるインスタンスも要求しない。
`Finset` 版の等号判定は有限表現のためだけに要る。 -/

/-- `Set` 値の近傍割り当ての合成。型にインスタンスを一つも要求しない。 -/
def setComp {V W X : Type} (N : V → Set W) (M : W → Set X) : V → Set X :=
  fun v => {x | ∃ u ∈ N v, x ∈ M u}

/-- `Set` 値の自己近傍割り当て。等号判定を要求しない。 -/
def setIdentity (V : Type) : V → Set V := fun v => {v}

theorem setIdentity_setComp {V W : Type} (N : V → Set W) :
    setComp (setIdentity V) N = N := by
  funext v
  ext w
  constructor
  · rintro ⟨u, hu, hw⟩
    have : u = v := hu
    exact this ▸ hw
  · intro hw
    exact ⟨v, rfl, hw⟩

theorem setComp_setIdentity {V W : Type} (N : V → Set W) :
    setComp N (setIdentity W) = N := by
  funext v
  ext w
  constructor
  · rintro ⟨u, hu, hw⟩
    have : w = u := hw
    exact this ▸ hu
  · intro hw
    exact ⟨w, hw, rfl⟩

theorem setComp_assoc {V W X Y : Type}
    (N : V → Set W) (M : W → Set X) (L : X → Set Y) :
    setComp (setComp N M) L = setComp N (setComp M L) := by
  funext v
  ext w
  constructor
  · rintro ⟨u, ⟨r, hrN, huM⟩, hwL⟩
    exact ⟨r, hrN, u, huM, hwL⟩
  · rintro ⟨r, hrN, u, huM, hwL⟩
    exact ⟨u, ⟨r, hrN, huM⟩, hwL⟩

/-- 橋渡し: `Finset` 版の合成を集合として読むと `Set` 版の合成に一致する。
    すなわち等号判定は有限表現のためだけに要る。 -/
theorem coe_hetComp {V W X : Type} [DecidableEq X]
    (N : V → Finset W) (M : W → Finset X) (v : V) :
    ((hetComp N M v : Finset X) : Set X) =
      setComp (fun v => ((N v : Finset W) : Set W)) (fun u => ((M u : Finset X) : Set X)) v := by
  ext x
  simp [hetComp, setComp]

/-- 橋渡し: `Finset` 版の自己近傍割り当てを集合として読むと `Set` 版に一致する。 -/
theorem coe_identityNeighborhood {V : Type} [DecidableEq V] (v : V) :
    ((identityNeighborhood V v : Finset V) : Set V) = setIdentity V v := by
  ext x
  simp [identityNeighborhood, setIdentity]

/-! ### 元数と全列挙（有限性が要る段） -/

/-- `claim_finite_neighborhood_assignment_monoid_cardinality_decidable` の元数。
    ここで初めて舞台の有限性が要る。始域と終域が異なっていてもよい。
    始域側の等号判定は写像全体に有限型構造を与えるためのものである。 -/
theorem card_assignment {V W : Type} [Fintype V] [Fintype W] [DecidableEq V] [DecidableEq W] :
    Fintype.card (V → Finset W) = 2 ^ (Fintype.card V * Fintype.card W) := by
  simp [Fintype.card_finset, ← pow_mul, mul_comm]

/-- 全ての近傍割り当てを重複なく有限列挙する表。 -/
def assignmentTable (V : Type) [Fintype V] [DecidableEq V] : Finset (V → Finset V) :=
  Finset.univ

/-- 全ての順序対とその積を有限列挙する合成表。 -/
def compositionTable (V : Type) [Fintype V] [DecidableEq V] :
    Finset ((V → Finset V) × (V → Finset V) × (V → Finset V)) :=
  Finset.univ.image (fun p : (V → Finset V) × (V → Finset V) =>
    (p.1, p.2, composedNeighborhood p.1 p.2))

/-- 合成表は任意の二つの近傍割り当てと、その合成近傍を含む。 -/
theorem mem_compositionTable {V : Type} [Fintype V] [DecidableEq V]
    (N M : V → Finset V) :
    (N, M, composedNeighborhood N M) ∈ compositionTable V := by
  simp [compositionTable]

/-! ### 非可換性に必要十分な舞台の大きさ

具体版は三元舞台の反例を使うが、必要なのは二元だけである。
逆に舞台が高々一元なら合成は必ず可換になる。 -/

/-- 二元舞台の第一の近傍割り当て。 -/
def twoElementN : Fin 2 → Finset (Fin 2) := fun v => if v = 0 then {1} else ∅

/-- 二元舞台の第二の近傍割り当て。 -/
def twoElementM : Fin 2 → Finset (Fin 2) := fun v => if v = 1 then {1} else ∅

theorem twoElement_left_at_zero :
    composedNeighborhood twoElementN twoElementM 0 = {1} := by
  decide

theorem twoElement_right_at_zero :
    composedNeighborhood twoElementM twoElementN 0 = ∅ := by
  decide

/-- `claim_neighborhood_assignment_composition_not_commutative` は二元舞台で既に成り立つ。 -/
theorem twoElement_noncommutative :
    composedNeighborhood twoElementN twoElementM ≠
      composedNeighborhood twoElementM twoElementN := by
  intro h
  have hAtZero := congrFun h 0
  rw [twoElement_left_at_zero, twoElement_right_at_zero] at hAtZero
  exact Finset.singleton_ne_empty 1 hAtZero

/-- 逆向き: 舞台が高々一元なら合成は必ず可換である。
    したがって非可換性には二元以上が必要である。 -/
theorem comp_comm_of_subsingleton {V : Type} [DecidableEq V] [Subsingleton V]
    (N M : V → Finset V) :
    composedNeighborhood N M = composedNeighborhood M N := by
  funext v
  ext w
  simp only [composedNeighborhood, Finset.mem_biUnion]
  have eUV : ∀ a b : V, a = b := fun a b => Subsingleton.elim a b
  constructor
  · rintro ⟨u, hu, hw⟩
    rw [eUV u v] at hu
    rw [eUV u v, eUV w v] at hw
    rw [eUV w v]
    exact ⟨v, hw, hu⟩
  · rintro ⟨u, hu, hw⟩
    rw [eUV u v] at hu
    rw [eUV u v, eUV w v] at hw
    rw [eUV w v]
    exact ⟨v, hw, hu⟩

end CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
