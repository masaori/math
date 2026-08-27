/-
章「有限近傍割り当てモノイドの中心」の必要十分版。

具体版（CellularAutomata.NeighborhoodAssignmentMonoidCenter）と同じ順序で、
空近傍と自己近傍の中心所属、中心元の辺が自己ループであること、空でない中心元が全ての
自己ループを持つこと、中心が空近傍と自己近傍だけからなる特徴づけ、有限列挙を示す。

必要な構造の検査結果:
  - **舞台の有限性も等号判定も要らない。** 値を `Set` で表せば、中心の特徴づけは型に
    インスタンスを一つも要求せずに成り立つ（`setIsCentral_iff_empty_or_identity`）。
    具体版が `Fintype V` と `DecidableEq V` を仮定しているのは、近傍を `Finset` で表すこと
    （`Finset.biUnion` が終域の等号判定を要求する）と、中心を有限列挙することのためであって、
    特徴づけそのものが有限性を要求しているのではない。
  - **証人にも等号判定は要らない。** 具体版の一辺の証人 `singleEdge a b` は
    `if v = a then {b} else ∅` と書かれるため等号判定を使うが、`Set` では
    `{x | v = a ∧ x = b}` と書けるので命題の等号だけで済む（`setSingleEdge`）。
    証人の値が `p ≠ q` のとき空になることも、この形では連言の第一成分としてそのまま出る。
  - **始域と終域が同じ型であることは落とせない。** 中心の定義が `N ⋆ M` と `M ⋆ N` を
    比較するため、型をまたぐ合成では中心そのものが書けない。
  - **舞台が空でも成り立つ。** 空舞台では `setEmpty V V = setIdentity V` であり、
    特徴づけの右辺は一元集合になる。証明は元を取ってから進むので空舞台でも通る。
  - **`N ≠ O_V` は第三段でだけ要る。** 第二段（中心元の辺は自己ループ）は空でない仮定を
    使わず、任意の中心元と任意の辺について成り立つ。
  - **有限性が要るのは中心の有限列挙の段だけである。** 中心所属を二つの写像との等号へ
    帰着させる段までは有限性を使わない（`hetIsCentral_iff_empty_or_identity`）。
  - 状態集合、局所規則、時間、順序、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NeighborhoodAssignmentMonoidCenter
import CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentMonoidCenter

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity

/-! ### 特徴づけ（インスタンスを一つも要らない段）

`def_neighborhood_assignment_monoid_center` と
`claim_neighborhood_assignment_monoid_center_characterization` を、
有限性も等号判定も持たない型の上で書く。 -/

/-- `def_neighborhood_assignment_monoid_center` の `Set` 版。
    型にインスタンスを一つも要求しない。 -/
def SetIsCentral {V : Type} (N : V → Set V) : Prop :=
  ∀ M : V → Set V, setComp N M = setComp M N

/-- `def_single_edge_neighborhood_assignment` の `Set` 版。
    等号判定を要求せず、命題の等号だけで書ける。 -/
def setSingleEdge {V : Type} (a b : V) : V → Set V :=
  fun v => {x | v = a ∧ x = b}

/-- 人手証明の第一段の前半。空近傍割り当ては中心に属する（吸収律の二つの向き）。 -/
theorem setEmpty_isCentral (V : Type) : SetIsCentral (setEmpty V V) := by
  intro M
  rw [setEmpty_setComp, setComp_setEmpty]

/-- 人手証明の第一段の後半。自己近傍割り当ては中心に属する（単位律の二つの向き）。 -/
theorem setIdentity_isCentral (V : Type) : SetIsCentral (setIdentity V) := by
  intro M
  rw [setIdentity_setComp, setComp_setIdentity]

/-- 人手証明の第二段。中心元の辺 q ∈ N(p) は自己ループである。
    空でない仮定は使わない。 -/
theorem set_edge_of_central_is_loop {V : Type} {N : V → Set V} (hN : SetIsCentral N)
    {p q : V} (hq : q ∈ N p) : p = q := by
  by_contra hpq
  have hleft : q ∈ setComp N (setSingleEdge q q) p := ⟨q, hq, rfl, rfl⟩
  have hcomm := congrFun (hN (setSingleEdge q q)) p
  rw [hcomm] at hleft
  obtain ⟨u, hu, _⟩ := hleft
  exact hpq hu.1

/-- 人手証明の第三段。空でない中心元は全ての自己ループを持つ。 -/
theorem set_identity_subset_of_central_ne_empty {V : Type} {N : V → Set V}
    (hN : SetIsCentral N) (hne : N ≠ setEmpty V V) :
    ∀ b : V, b ∈ N b := by
  have hex : ∃ p q : V, q ∈ N p := by
    by_contra h
    apply hne
    funext p
    ext q
    constructor
    · intro hq
      exact (h ⟨p, q, hq⟩).elim
    · intro hq
      exact hq.elim
  obtain ⟨p, q, hq⟩ := hex
  have hpq : p = q := set_edge_of_central_is_loop hN hq
  subst hpq
  intro b
  have hleft : b ∈ setComp N (setSingleEdge p b) p := ⟨p, hq, rfl, rfl⟩
  have hcomm := congrFun (hN (setSingleEdge p b)) p
  rw [hcomm] at hleft
  obtain ⟨u, hu, hb⟩ := hleft
  rw [hu.2] at hb
  exact hb

/-- `claim_neighborhood_assignment_monoid_center_characterization` の必要十分版。
    舞台の有限性も等号判定も使わない。 -/
theorem setIsCentral_iff_empty_or_identity {V : Type} (N : V → Set V) :
    SetIsCentral N ↔ N = setEmpty V V ∨ N = setIdentity V := by
  constructor
  · intro hN
    by_cases hne : N = setEmpty V V
    · exact Or.inl hne
    · right
      have hloops := set_identity_subset_of_central_ne_empty hN hne
      funext v
      ext w
      constructor
      · intro hw
        have hvw : v = w := set_edge_of_central_is_loop hN hw
        exact hvw.symm
      · intro hw
        have hwv : w = v := hw
        rw [hwv]
        exact hloops v
  · rintro (rfl | rfl)
    · exact setEmpty_isCentral V
    · exact setIdentity_isCentral V

/-! ### 有限表現を選んだ段（等号判定が要る）

部分集合を `Finset` で表すと、合成 `hetComp` を `Finset.biUnion` で書くために終域の
等号判定が要る。証人 `hetSingleEdge` も場合分けのために等号判定を要る。
これは中心の性質ではなく表現の要求であることを、同じ順序の証明で示す。 -/

section FinsetStage

variable {V : Type} [DecidableEq V]

/-- `def_neighborhood_assignment_monoid_center` の有限表現版。 -/
def HetIsCentral (N : V → Finset V) : Prop :=
  ∀ M : V → Finset V, hetComp N M = hetComp M N

/-- `def_single_edge_neighborhood_assignment` の有限表現版。
    場合分けのために等号判定が要る。 -/
def hetSingleEdge (a b : V) : V → Finset V :=
  fun v => if v = a then {b} else ∅

/-- 有限表現版の空近傍割り当ての中心所属。 -/
theorem hetEmpty_isCentral : HetIsCentral (hetEmpty V V) := by
  intro M
  rw [hetEmpty_hetComp, hetComp_hetEmpty]

/-- 有限表現版の自己近傍割り当ての中心所属。 -/
theorem hetIdentity_isCentral : HetIsCentral (identityNeighborhood V) := by
  intro M
  rw [identity_hetComp, hetComp_identity]

/-- 有限表現版の第二段。証明手順は `Set` 版と同じである。 -/
theorem het_edge_of_central_is_loop {N : V → Finset V} (hN : HetIsCentral N)
    {p q : V} (hq : q ∈ N p) : p = q := by
  by_contra hpq
  have hleft : q ∈ hetComp N (hetSingleEdge q q) p :=
    Finset.mem_biUnion.mpr ⟨q, hq, by simp [hetSingleEdge]⟩
  have hcomm := congrFun (hN (hetSingleEdge q q)) p
  rw [hcomm] at hleft
  simpa [hetComp, hetSingleEdge, hpq] using hleft

/-- 有限表現版の第三段。証明手順は `Set` 版と同じである。 -/
theorem het_identity_subset_of_central_ne_empty {N : V → Finset V}
    (hN : HetIsCentral N) (hne : N ≠ hetEmpty V V) :
    ∀ b : V, b ∈ N b := by
  have hex : ∃ p q : V, q ∈ N p := by
    by_contra h
    apply hne
    funext p
    ext q
    constructor
    · intro hq
      exact (h ⟨p, q, hq⟩).elim
    · simp [hetEmpty]
  obtain ⟨p, q, hq⟩ := hex
  have hpq : p = q := het_edge_of_central_is_loop hN hq
  subst hpq
  intro b
  have hleft : b ∈ hetComp N (hetSingleEdge p b) p :=
    Finset.mem_biUnion.mpr ⟨p, hq, by simp [hetSingleEdge]⟩
  have hcomm := congrFun (hN (hetSingleEdge p b)) p
  rw [hcomm] at hleft
  simp [hetComp, hetSingleEdge] at hleft
  exact hleft

/-- 有限表現版の特徴づけ。舞台の有限性はここでも使わない。 -/
theorem hetIsCentral_iff_empty_or_identity (N : V → Finset V) :
    HetIsCentral N ↔ N = hetEmpty V V ∨ N = identityNeighborhood V := by
  constructor
  · intro hN
    by_cases hne : N = hetEmpty V V
    · exact Or.inl hne
    · right
      have hloops := het_identity_subset_of_central_ne_empty hN hne
      funext v
      ext w
      constructor
      · intro hw
        have hvw : v = w := het_edge_of_central_is_loop hN hw
        simp [identityNeighborhood, hvw]
      · intro hw
        have hwv : w = v := by simpa [identityNeighborhood] using hw
        simpa [hwv] using hloops v
  · rintro (rfl | rfl)
    · exact hetEmpty_isCentral
    · exact hetIdentity_isCentral

/-! 有限表現と `Set` 表現の橋渡し。等号判定が有限表現のためだけに要ることを示す。 -/

/-- 有限表現の割り当てを集合として読む写像。 -/
def coeAssignment (N : V → Finset V) : V → Set V :=
  fun v => ((N v : Finset V) : Set V)

omit [DecidableEq V] in
theorem coeAssignment_eq_setEmpty_iff (N : V → Finset V) :
    coeAssignment N = setEmpty V V ↔ N = hetEmpty V V := by
  constructor
  · intro h
    funext v
    apply Finset.coe_injective
    rw [coe_hetEmpty]
    exact congrFun h v
  · intro h
    funext v
    rw [coeAssignment, h, coe_hetEmpty]

theorem coeAssignment_eq_setIdentity_iff (N : V → Finset V) :
    coeAssignment N = setIdentity V ↔ N = identityNeighborhood V := by
  constructor
  · intro h
    funext v
    apply Finset.coe_injective
    rw [coe_identityNeighborhood]
    exact congrFun h v
  · intro h
    funext v
    rw [coeAssignment, h, coe_identityNeighborhood]

/-- 有限表現の中心所属は、集合として読んだ割り当ての中心所属と同値である。
    どちらも「空近傍または自己近傍であること」と同値であることから従う。 -/
theorem hetIsCentral_iff_setIsCentral (N : V → Finset V) :
    HetIsCentral N ↔ SetIsCentral (coeAssignment N) := by
  rw [hetIsCentral_iff_empty_or_identity, setIsCentral_iff_empty_or_identity,
    coeAssignment_eq_setEmpty_iff, coeAssignment_eq_setIdentity_iff]

end FinsetStage

/-! ### 有限列挙（舞台の有限性が要る段）

中心の全体を重複なく並べる表を作る段で初めて舞台の有限性が要る。
中心所属の判定そのものには有限性は要らない。 -/

section EnumerationStage

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 中心の全体を重複なく有限列挙する表。ここで初めて舞台の有限性が要る。 -/
noncomputable def hetCenterTable : Finset (V → Finset V) :=
  by
    classical
    exact Finset.univ.filter HetIsCentral

/-- 表への所属は二つの有限写像との等号で決定できる。 -/
theorem mem_hetCenterTable_iff (N : V → Finset V) :
    N ∈ hetCenterTable ↔ N = hetEmpty V V ∨ N = identityNeighborhood V := by
  classical
  rw [hetCenterTable, Finset.mem_filter]
  simp only [Finset.mem_univ, true_and]
  exact hetIsCentral_iff_empty_or_identity N

end EnumerationStage

/-! ### 具体版の導出

具体版の述語は有限表現版の述語そのものであり、具体版の各主張は有限表現版の特殊化として
得られる。 -/

section Derivation

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentUnionDistributivity
open CellularAutomata.NeighborhoodAssignmentMonoidCenter

variable {V : Type} [Fintype V] [DecidableEq V]

omit [Fintype V] in
/-- 具体版の中心所属の述語は、必要十分版の有限表現の述語と同じものである。 -/
theorem isCentral_eq_het (N : NeighborhoodAssignment V) :
    IsCentral N = HetIsCentral N :=
  rfl

omit [Fintype V] in
/-- 具体版の一辺の証人は、必要十分版の有限表現の証人と同じものである。 -/
theorem singleEdge_eq_het (a b : V) :
    singleEdge a b = hetSingleEdge a b :=
  rfl

omit [Fintype V] in
/-- 具体版 `edge_of_central_is_loop` は、必要十分版の第二段の特殊化である。 -/
theorem edge_of_central_is_loop_of_necSuf {N : NeighborhoodAssignment V}
    (hN : IsCentral N) {p q : V} (hq : q ∈ N p) : p = q :=
  het_edge_of_central_is_loop hN hq

omit [Fintype V] in
/-- 具体版 `identity_subset_of_central_ne_empty` は、必要十分版の第三段の特殊化である。 -/
theorem identity_subset_of_central_ne_empty_of_necSuf {N : NeighborhoodAssignment V}
    (hN : IsCentral N) (hne : N ≠ emptyNeighborhood V) :
    ∀ b : V, b ∈ N b :=
  het_identity_subset_of_central_ne_empty hN hne

omit [Fintype V] in
/-- 具体版 `isCentral_iff_empty_or_identity` は、必要十分版の特徴づけの特殊化である。 -/
theorem isCentral_iff_empty_or_identity_of_necSuf (N : NeighborhoodAssignment V) :
    IsCentral N ↔
      N = emptyNeighborhood V ∨
        N = CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V :=
  hetIsCentral_iff_empty_or_identity N

/-- 具体版 `mem_centerTable_iff` は、必要十分版の特徴づけから得られる。 -/
theorem mem_centerTable_iff_of_necSuf (N : NeighborhoodAssignment V) :
    N ∈ centerTable ↔
      N = emptyNeighborhood V ∨
        N = CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V := by
  classical
  rw [centerTable, Finset.mem_filter]
  simp only [CellularAutomata.FiniteNeighborhoodAssignmentMonoid.assignmentTable,
    Finset.mem_univ, true_and]
  exact isCentral_iff_empty_or_identity_of_necSuf N

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentMonoidCenter
