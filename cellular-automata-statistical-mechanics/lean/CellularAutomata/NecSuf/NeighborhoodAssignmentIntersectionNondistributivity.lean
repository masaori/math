/-
章「近傍割り当ての点ごとの積と合成の非分配性」の必要十分版。

具体版（CellularAutomata.NeighborhoodAssignmentIntersectionNondistributivity）と同じ順序で、
点ごとの積、全近傍割り当て、積の四法則、二つの分配律、包含順序の最小上界と最大下界、
左右の非分配性の反例、有限な演算表を示す。

必要な構造の検査結果:
  - 積の可換・結合・冪等律には舞台の有限性は要らない。要るのは値の集合の
    共通部分を取る先の型の等号判定だけであり、それは `Finset` の共通部分 `∩` の要求である。
  - 積の始域と終域が同じ型である必要も無い。近傍割り当てを型をまたぐ
    `V → Finset W` の形で書いても、可換・結合・冪等律はそのまま成り立つ。
  - **単位律だけは終域の型の有限性を要する。** 全近傍割り当ての値 `Finset.univ` を
    `Finset` として書くには `Fintype` が要る。これは積そのものの性質ではなく、
    最大元を有限表現するための要求である。実際、値を `Set` で表せば全近傍は
    `Set.univ` として何のインスタンスも無しに書け、単位律も成り立つ（`setInter_full_right`）。
    削れなかったのは `Finset` 表現を選んだ場合だけである。
  - 二つの分配律（積の和に対する分配、和の積に対する分配）にも有限性は要らず、
    終域の等号判定だけで足りる。始域と終域が異なる型でもよい。
  - 包含順序に関する和の最小上界性・積の最大下界性は、値の集合の所属判定だけを使う。
    有限性も、始域と終域が同じ型であることも要らない。
  - 等号判定すら本質ではない。部分集合を `Set` で表せば、積・分配・上下界は
    型にいかなるインスタンスも要求しない。`Finset` 版の等号判定は有限表現のための
    ものであり、`Set` 版との対応を橋渡し定理で示す。
  - 左の非分配性に要るのは、始域に一点 `a`、中間の型に相異なる二点 `b ≠ c`、
    終域に一点 `z` があり、`N(a)={b}`、`M(a)={c}`、`z∈L(b)`、`z∈L(c)` となることだけである。
    三つの型はすべて異なってよく、いずれも有限である必要はない。**`b ≠ c` は削れない**:
    `b = c` なら `N(a)∩M(a)={b}` となり左辺にも `z` が入って等号が成り立つ。
  - 右の非分配性に要るのは、`b,c∈L(a)`、`z∈N(b)`、`z∈M(c)`、および
    `L(a)` のどの元 `u` でも `z` が `N(u)` と `M(u)` の両方には入らないこと、だけである。
    ここでは `b ≠ c` を仮定しなくてよい（最後の条件から従う）。有限性も要らない。
  - 有限性が要るのは積の全演算表と分配性の有限表を作る段だけである。
  - 状態集合、局所規則、時間、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionNondistributivity

open CellularAutomata.NecSuf.ComposedNeighborhoodClosure
open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.OrderedNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity

/-! ### 型をまたぐ点ごとの積と全近傍割り当て

`def_neighborhood_assignment_pointwise_intersection` と
`def_full_neighborhood_assignment` を、始域と終域が異なる型でも書けることを確かめる。 -/

/-- 型をまたぐ点ごとの積。要るのは終域の等号判定だけである。 -/
def hetInter {V W : Type} [DecidableEq W] (N M : V → Finset W) : V → Finset W :=
  fun v => N v ∩ M v

/-- 型をまたぐ全近傍割り当て。ここで初めて終域の有限性が要る。
    これは積の性質ではなく、最大元を `Finset` として書くための要求である。 -/
def hetFull (V W : Type) [Fintype W] : V → Finset W :=
  fun _ => Finset.univ

/-- 可換律。有限性は使わない。 -/
theorem hetInter_comm {V W : Type} [DecidableEq W] (N M : V → Finset W) :
    hetInter N M = hetInter M N := by
  funext v
  exact Finset.inter_comm (N v) (M v)

/-- 結合律。有限性は使わない。 -/
theorem hetInter_assoc {V W : Type} [DecidableEq W] (N M L : V → Finset W) :
    hetInter (hetInter N M) L = hetInter N (hetInter M L) := by
  funext v
  exact Finset.inter_assoc (N v) (M v) (L v)

/-- 冪等律。有限性は使わない。 -/
theorem hetInter_idem {V W : Type} [DecidableEq W] (N : V → Finset W) :
    hetInter N N = N := by
  funext v
  exact Finset.inter_self (N v)

/-- 右単位律。ここだけ終域の有限性を使う。 -/
theorem hetInter_full_right {V W : Type} [Fintype W] [DecidableEq W] (N : V → Finset W) :
    hetInter N (hetFull V W) = N := by
  funext v
  simp [hetInter, hetFull]

/-- 左単位律。人手証明どおり可換律から従う。 -/
theorem hetInter_full_left {V W : Type} [Fintype W] [DecidableEq W] (N : V → Finset W) :
    hetInter (hetFull V W) N = N := by
  rw [hetInter_comm]
  exact hetInter_full_right N

/-- 人手証明の分配律 `N ⊓ (M ⊔ L) = (N ⊓ M) ⊔ (N ⊓ L)` の型をまたぐ版。
    有限性は要らず、終域の等号判定だけで足りる。 -/
theorem hetInter_hetUnion {V W : Type} [DecidableEq W] (N M L : V → Finset W) :
    hetInter N (hetUnion M L) = hetUnion (hetInter N M) (hetInter N L) := by
  funext v
  ext w
  simp [hetInter, hetUnion, and_or_left]

/-- 人手証明の分配律 `N ⊔ (M ⊓ L) = (N ⊔ M) ⊓ (N ⊔ L)` の型をまたぐ版。 -/
theorem hetUnion_hetInter {V W : Type} [DecidableEq W] (N M L : V → Finset W) :
    hetUnion N (hetInter M L) = hetInter (hetUnion N M) (hetUnion N L) := by
  funext v
  ext w
  simp [hetInter, hetUnion, or_and_left]

/-- 点ごとの和は包含順序の上界である。 -/
theorem hetInclusion_hetUnion_left {V W : Type} [DecidableEq W] (N M : V → Finset W) :
    HetInclusion N (hetUnion N M) := by
  intro v w hw
  simp [hetUnion, hw]

theorem hetInclusion_hetUnion_right {V W : Type} [DecidableEq W] (N M : V → Finset W) :
    HetInclusion M (hetUnion N M) := by
  intro v w hw
  simp [hetUnion, hw]

/-- 点ごとの和は包含順序の最小上界である。有限性は使わない。 -/
theorem hetUnion_least {V W : Type} [DecidableEq W] {N M L : V → Finset W}
    (hNL : HetInclusion N L) (hML : HetInclusion M L) :
    HetInclusion (hetUnion N M) L := by
  intro v w hw
  rcases Finset.mem_union.mp hw with hwN | hwM
  · exact hNL v hwN
  · exact hML v hwM

/-- 点ごとの積は包含順序の下界である。 -/
theorem hetInter_lower_left {V W : Type} [DecidableEq W] (N M : V → Finset W) :
    HetInclusion (hetInter N M) N := by
  intro v w hw
  exact (Finset.mem_inter.mp hw).1

theorem hetInter_lower_right {V W : Type} [DecidableEq W] (N M : V → Finset W) :
    HetInclusion (hetInter N M) M := by
  intro v w hw
  exact (Finset.mem_inter.mp hw).2

/-- 点ごとの積は包含順序の最大下界である。有限性は使わない。 -/
theorem hetInter_greatest {V W : Type} [DecidableEq W] {N M L : V → Finset W}
    (hLN : HetInclusion L N) (hLM : HetInclusion L M) :
    HetInclusion L (hetInter N M) := by
  intro v w hw
  exact Finset.mem_inter.mpr ⟨hLN v hw, hLM v hw⟩

/-- `claim_neighborhood_assignment_pointwise_union_intersection_lattice` の必要十分版。
    二つの分配律と最小上界・最大下界を同時に記録する。舞台の有限性は要らず、
    要るのは終域の等号判定だけである。 -/
theorem distributive_lattice_laws {V W : Type} [DecidableEq W] :
    (∀ N M L : V → Finset W,
      hetInter N (hetUnion M L) = hetUnion (hetInter N M) (hetInter N L)) ∧
    (∀ N M L : V → Finset W,
      hetUnion N (hetInter M L) = hetInter (hetUnion N M) (hetUnion N L)) ∧
    (∀ N M L : V → Finset W,
      HetInclusion N L → HetInclusion M L → HetInclusion (hetUnion N M) L) ∧
    (∀ N M L : V → Finset W,
      HetInclusion L N → HetInclusion L M → HetInclusion L (hetInter N M)) :=
  ⟨hetInter_hetUnion, hetUnion_hetInter, fun _ _ _ => hetUnion_least,
    fun _ _ _ => hetInter_greatest⟩

/-! ### 等号判定と有限性を落とす検査

部分集合を `Set` で表すと、積・全近傍・分配・上下界はインスタンスを一つも要求しない。
とくに全近傍が `Set.univ` として書けるので、単位律に終域の有限性は本質ではなく、
`Finset` 表現のためだけに要ることが分かる。 -/

/-- `Set` 値の点ごとの積。型にインスタンスを一つも要求しない。 -/
def setInter {V W : Type} (N M : V → Set W) : V → Set W :=
  fun v => N v ∩ M v

/-- `Set` 値の全近傍割り当て。有限性を要求しない。 -/
def setFull (V W : Type) : V → Set W := fun _ => (Set.univ : Set W)

theorem setInter_comm {V W : Type} (N M : V → Set W) :
    setInter N M = setInter M N := by
  funext v
  exact Set.inter_comm (N v) (M v)

theorem setInter_assoc {V W : Type} (N M L : V → Set W) :
    setInter (setInter N M) L = setInter N (setInter M L) := by
  funext v
  exact Set.inter_assoc (N v) (M v) (L v)

theorem setInter_idem {V W : Type} (N : V → Set W) : setInter N N = N := by
  funext v
  exact Set.inter_self (N v)

/-- `Set` 版の右単位律。有限性を使わない。 -/
theorem setInter_full_right {V W : Type} (N : V → Set W) :
    setInter N (setFull V W) = N := by
  funext v
  simp [setInter, setFull]

theorem setInter_full_left {V W : Type} (N : V → Set W) :
    setInter (setFull V W) N = N := by
  rw [setInter_comm]
  exact setInter_full_right N

/-- `Set` 版の第一の分配律。インスタンスを一つも使わない。 -/
theorem setInter_setUnion {V W : Type} (N M L : V → Set W) :
    setInter N (setUnion M L) = setUnion (setInter N M) (setInter N L) := by
  funext v
  exact Set.inter_union_distrib_left (N v) (M v) (L v)

/-- `Set` 版の第二の分配律。インスタンスを一つも使わない。 -/
theorem setUnion_setInter {V W : Type} (N M L : V → Set W) :
    setUnion N (setInter M L) = setInter (setUnion N M) (setUnion N L) := by
  funext v
  exact Set.union_inter_distrib_left (N v) (M v) (L v)

/-- `Set` 版の最大下界性。インスタンスを一つも使わない。 -/
theorem setInter_greatest {V W : Type} {N M L : V → Set W}
    (hLN : SetInclusion L N) (hLM : SetInclusion L M) :
    SetInclusion L (setInter N M) := by
  intro v w hw
  exact ⟨hLN v hw, hLM v hw⟩

/-- 橋渡し: `Finset` 版の積を集合として読むと `Set` 版の積に一致する。
    すなわち等号判定は有限表現のためだけに要る。 -/
theorem coe_hetInter {V W : Type} [DecidableEq W] (N M : V → Finset W) (v : V) :
    ((hetInter N M v : Finset W) : Set W) =
      setInter (fun v => ((N v : Finset W) : Set W))
        (fun v => ((M v : Finset W) : Set W)) v := by
  ext w
  simp [hetInter, setInter]

/-- 橋渡し: `Finset` 版の全近傍割り当てを集合として読むと `Set` 版に一致する。
    有限性はこの読み替えのためだけに要る。 -/
theorem coe_hetFull {V W : Type} [Fintype W] (v : V) :
    ((hetFull V W v : Finset W) : Set W) = setFull V W v := by
  ext w
  simp [hetFull, setFull]

/-- 既製の演算との一致を述べる橋渡し定理（自前の証明を置いたうえでの一本）。
    `Set` 値の点ごとの積は、`V → Set W` の既定の下限 `⊓` と同じ写像である。 -/
theorem setInter_eq_inf {V W : Type} (N M : V → Set W) :
    setInter N M = N ⊓ M := rfl

/-! ### 左右の非分配性（有限性も同型性も要らない段）

具体版の三元舞台の反例が、実際には何を使っているかを取り出す。
三つの型 V, W, X はすべて異なってよく、いずれも有限でなくてよい。 -/

/-- `claim_composition_not_left_distributive_over_pointwise_intersection` の必要十分版。
    始域の一点 `a`、中間の型の相異なる二点 `b ≠ c`、終域の一点 `z` があり、
    `N(a)={b}`、`M(a)={c}`、`z∈L(b)`、`z∈L(c)` であれば左分配は破れる。
    `b ≠ c` は削れない: `b = c` なら `N(a)∩M(a)={b}` となり左辺にも `z` が入る。 -/
theorem hetComp_hetInter_left_ne {V W X : Type} [DecidableEq W] [DecidableEq X]
    (a : V) (b c : W) (hbc : b ≠ c) (z : X)
    (N M : V → Finset W) (L : W → Finset X)
    (hN : N a = {b}) (hM : M a = {c}) (hLb : z ∈ L b) (hLc : z ∈ L c) :
    hetComp (hetInter N M) L ≠ hetInter (hetComp N L) (hetComp M L) := by
  intro h
  have hRight : z ∈ hetInter (hetComp N L) (hetComp M L) a := by
    refine Finset.mem_inter.mpr ⟨?_, ?_⟩
    · refine Finset.mem_biUnion.mpr ⟨b, ?_, hLb⟩
      rw [hN]
      exact Finset.mem_singleton_self b
    · refine Finset.mem_biUnion.mpr ⟨c, ?_, hLc⟩
      rw [hM]
      exact Finset.mem_singleton_self c
  have hEq := congrFun h a
  rw [← hEq] at hRight
  obtain ⟨u, hu, _⟩ := Finset.mem_biUnion.mp hRight
  have huN : u ∈ N a := (Finset.mem_inter.mp hu).1
  have huM : u ∈ M a := (Finset.mem_inter.mp hu).2
  rw [hN, Finset.mem_singleton] at huN
  rw [hM, Finset.mem_singleton] at huM
  refine hbc ?_
  rw [← huN]
  exact huM

/-- `claim_composition_not_right_distributive_over_pointwise_intersection` の必要十分版。
    `b,c∈L(a)`、`z∈N(b)`、`z∈M(c)` であり、`L(a)` のどの元でも `z` が
    `N` 側と `M` 側の両方には入らないなら、右分配は破れる。
    ここでは `b ≠ c` を仮定しない（最後の条件から従う）。 -/
theorem hetComp_hetInter_right_ne {V W X : Type} [DecidableEq W] [DecidableEq X]
    (a : V) (b c : W) (z : X)
    (L : V → Finset W) (N M : W → Finset X)
    (hb : b ∈ L a) (hc : c ∈ L a) (hNb : z ∈ N b) (hMc : z ∈ M c)
    (hNoBoth : ∀ u ∈ L a, ¬(z ∈ N u ∧ z ∈ M u)) :
    hetComp L (hetInter N M) ≠ hetInter (hetComp L N) (hetComp L M) := by
  intro h
  have hRight : z ∈ hetInter (hetComp L N) (hetComp L M) a := by
    refine Finset.mem_inter.mpr ⟨?_, ?_⟩
    · exact Finset.mem_biUnion.mpr ⟨b, hb, hNb⟩
    · exact Finset.mem_biUnion.mpr ⟨c, hc, hMc⟩
  have hEq := congrFun h a
  rw [← hEq] at hRight
  obtain ⟨u, hu, hzu⟩ := Finset.mem_biUnion.mp hRight
  exact hNoBoth u hu ⟨(Finset.mem_inter.mp hzu).1, (Finset.mem_inter.mp hzu).2⟩

/-! ### 有限な演算表（有限性が要る段）

積の全演算表と、分配性を満たす三つ組の有限表を作る段で初めて有限性が要る。 -/

/-- 型をまたぐ積の全演算表。始域と終域が異なっていてもよい。 -/
def hetInterTable (V W : Type) [Fintype V] [Fintype W] [DecidableEq V] [DecidableEq W] :
    Finset ((V → Finset W) × (V → Finset W) × (V → Finset W)) :=
  Finset.univ.image (fun p : (V → Finset W) × (V → Finset W) =>
    (p.1, p.2, hetInter p.1 p.2))

/-- 積の表は任意の二つの近傍割り当てと、その点ごとの積を含む。 -/
theorem mem_hetInterTable {V W : Type} [Fintype V] [Fintype W] [DecidableEq V] [DecidableEq W]
    (N M : V → Finset W) :
    (N, M, hetInter N M) ∈ hetInterTable V W := by
  simp [hetInterTable]

/-- 左分配律を満たす三つ組の有限表。合成の型が閉じる必要があるため同じ型に取る。 -/
def hetLeftDistributiveTriples (V : Type) [Fintype V] [DecidableEq V] :
    Finset ((V → Finset V) × (V → Finset V) × (V → Finset V)) :=
  Finset.univ.filter fun p =>
    hetComp (hetInter p.1 p.2.1) p.2.2 =
      hetInter (hetComp p.1 p.2.2) (hetComp p.2.1 p.2.2)

/-- 右分配律を満たす三つ組の有限表。 -/
def hetRightDistributiveTriples (V : Type) [Fintype V] [DecidableEq V] :
    Finset ((V → Finset V) × (V → Finset V) × (V → Finset V)) :=
  Finset.univ.filter fun p =>
    hetComp p.1 (hetInter p.2.1 p.2.2) =
      hetInter (hetComp p.1 p.2.1) (hetComp p.1 p.2.2)

/-- 左分配律を満たすことは、有限表への所属と同値である。 -/
theorem mem_hetLeftDistributiveTriples {V : Type} [Fintype V] [DecidableEq V]
    (N M L : V → Finset V) :
    (N, M, L) ∈ hetLeftDistributiveTriples V ↔
      hetComp (hetInter N M) L = hetInter (hetComp N L) (hetComp M L) := by
  simp [hetLeftDistributiveTriples]

/-- 右分配律を満たすことは、有限表への所属と同値である。 -/
theorem mem_hetRightDistributiveTriples {V : Type} [Fintype V] [DecidableEq V]
    (L N M : V → Finset V) :
    (L, N, M) ∈ hetRightDistributiveTriples V ↔
      hetComp L (hetInter N M) = hetInter (hetComp L N) (hetComp L M) := by
  simp [hetRightDistributiveTriples]

end CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionNondistributivity
