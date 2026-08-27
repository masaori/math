/-
章「自己転置な近傍割り当ての個数」の必要十分版。

具体版（CellularAutomata.SelfTransposeNeighborhoodAssignmentCount）と同じ順序で、
自己転置性と所属の対称性の同値、非順序対符号と復元、両合成が恒等であること、全単射、
非順序対の個数、自己転置な近傍割り当ての個数、有限表による判定を示す。

必要な構造の検査結果:
  - **符号化と全単射に要る構造は何も無い。** 値を `Set` で表せば、自己転置性
    `Nᵀ = N` と所属の対称性の同値、非順序対 `Sym2 V` への符号化、`Sym2 V` の部分集合からの
    復元、二つの合成が恒等であること、そして両者が与える全単射は、型にいかなる
    インスタンスも要求せずに成り立つ（`setPairEncodingEquiv`）。
    人手証明が使うのは所属の向きの反転、`{v,w} = {w,v}`、外延性だけである。
  - **始域と終域が同じ型であることは、この章では落とせない。** 自己転置性 `Nᵀ = N` は
    `N` と `Nᵀ` が同じ型に住むことを要求する。前章の転置そのもの（`hetTranspose`）は
    異なる型の間で書けたが、自己転置性の主張は書けない。
  - **有限性が要るのは個数を数える段だけである。** 非順序対の個数
    `card (Sym2 V) = n(n+1)/2` と自己転置な近傍割り当ての個数 `2^(n(n+1)/2)` には
    `Fintype V` が要る。ここで `DecidableEq V` は要らない（`card_sym2_choose`,
    `card_sym2`, `card_setSelfTranspose`）。個数は命題なので、部分集合の有限表現に要る
    判定は古典的に取れば足り、仮定として立てる必要が無い。
  - **等号判定 `DecidableEq V` が要るのは `Finset` 表現を選んだ段だけである。**
    `hetPairEncoding` を `Finset.univ.filter` で書き、自己転置な割り当てを有限表
    `hetSelfTransposeTable` として集めるには、所属判定と `Sym2 V` 上の判定が要る。
    これは自己転置性の性質ではなく、部分集合を有限表現するための要求である。
  - 状態集合、局所規則、時間、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution
import Mathlib.Data.Sym.Card

namespace CellularAutomata.NecSuf.SelfTransposeNeighborhoodAssignmentCount

open CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution

/-! ### 何のインスタンスも要らない段（`Set` 表現）

自己転置性の特徴づけ、非順序対符号、復元、全単射は、型にいかなる構造も要求しない。 -/

/-- `def_self_transpose_neighborhood_assignment` の `Set` 版。
    始域と終域が同じ型であることだけが要る。 -/
def SetSelfTranspose (V : Type) := {N : V → Set V // setTranspose N = N}

/-- `claim_self_transpose_iff_symmetric_membership` の必要十分版。
    人手証明と同じく転置の所属同値を各方向に一度ずつ使う。 -/
theorem setSelfTranspose_iff_symmetricMembership {V : Type} (N : V → Set V) :
    setTranspose N = N ↔ ∀ v w : V, (w ∈ N v ↔ v ∈ N w) := by
  constructor
  · intro h v w
    calc
      w ∈ N v ↔ w ∈ setTranspose N v := by rw [h]
      _ ↔ v ∈ N w := mem_setTranspose N w v
  · intro h
    funext v
    ext w
    calc
      w ∈ setTranspose N v ↔ v ∈ N w := mem_setTranspose N w v
      _ ↔ w ∈ N v := (h v w).symm

/-- `def_self_transpose_pair_encoding` の所属述語。
    自己転置性により `s(v,w)` の表示順序に依存しない。 -/
def setPairSelected {V : Type} (N : SetSelfTranspose V) : Sym2 V → Prop :=
  Sym2.lift ⟨fun v w => w ∈ N.1 v, fun v w => by
    apply propext
    exact (setSelfTranspose_iff_symmetricMembership N.1).1 N.2 v w⟩

/-- `def_self_transpose_pair_encoding` の `Set` 版。 -/
def setPairEncoding {V : Type} (N : SetSelfTranspose V) : Set (Sym2 V) :=
  {z | setPairSelected N z}

@[simp] theorem mk_mem_setPairEncoding {V : Type} (N : SetSelfTranspose V) (v w : V) :
    s(v, w) ∈ setPairEncoding N ↔ w ∈ N.1 v := Iff.rfl

/-- `def_pair_set_neighborhood_reconstruction` の `Set` 版。 -/
def setPairReconstruction {V : Type} (B : Set (Sym2 V)) : V → Set V :=
  fun v => {w | s(v, w) ∈ B}

@[simp] theorem mem_setPairReconstruction {V : Type} (B : Set (Sym2 V)) (v w : V) :
    w ∈ setPairReconstruction B v ↔ s(v, w) ∈ B := Iff.rfl

/-- 復元した割り当ての所属は対称である。使うのは `s(v,w) = s(w,v)` だけである。 -/
theorem setPairReconstruction_symmetricMembership {V : Type} (B : Set (Sym2 V)) (v w : V) :
    w ∈ setPairReconstruction B v ↔ v ∈ setPairReconstruction B w := by
  rw [mem_setPairReconstruction, mem_setPairReconstruction]
  rw [Sym2.eq_swap]

/-- 復元した割り当ては自己転置である。 -/
theorem setPairReconstruction_selfTranspose {V : Type} (B : Set (Sym2 V)) :
    setTranspose (setPairReconstruction B) = setPairReconstruction B :=
  (setSelfTranspose_iff_symmetricMembership (setPairReconstruction B)).2
    (setPairReconstruction_symmetricMembership B)

/-- `claim_self_transpose_pair_encoding_bijection` の必要十分版。
    インスタンスを一つも使わずに、二つの合成が恒等写像であることを示す。 -/
def setPairEncodingEquiv {V : Type} : SetSelfTranspose V ≃ Set (Sym2 V) where
  toFun := setPairEncoding
  invFun := fun B => ⟨setPairReconstruction B, setPairReconstruction_selfTranspose B⟩
  left_inv := by
    intro N
    apply Subtype.ext
    funext v
    ext w
    simp
  right_inv := by
    intro B
    ext z
    induction z using Sym2.inductionOn with
    | _ v w => simp

/-! ### 個数を数える段（有限性だけが要る）

非順序対の個数と自己転置な割り当ての個数には `Fintype V` だけが要り、
`DecidableEq V` は要らない。 -/

/-- `claim_unordered_cell_pair_count` の第一の等号の必要十分版。 -/
theorem card_sym2_choose {V : Type} [Fintype V] :
    Fintype.card (Sym2 V) = Fintype.card V + (Fintype.card V).choose 2 := by
  rw [Sym2.card]
  simp [Nat.choose_succ_succ']

/-- `claim_unordered_cell_pair_count` の最終表示の必要十分版。 -/
theorem card_sym2 {V : Type} [Fintype V] :
    Fintype.card (Sym2 V) = Fintype.card V * (Fintype.card V + 1) / 2 := by
  rw [Sym2.card, Nat.choose_two_right]
  simp only [Nat.add_sub_cancel]
  rw [Nat.mul_comm]

noncomputable instance instFintypeSetSelfTranspose {V : Type} [Fintype V] :
    Fintype (SetSelfTranspose V) :=
  Fintype.ofEquiv (Set (Sym2 V)) setPairEncodingEquiv.symm

/-- `claim_self_transpose_neighborhood_assignment_count` の必要十分版。
    符号化全単射、部分集合の個数、非順序対の個数を人手証明と同じ順に使う。 -/
theorem card_setSelfTranspose {V : Type} [Fintype V] :
    Fintype.card (SetSelfTranspose V) =
      2 ^ (Fintype.card V * (Fintype.card V + 1) / 2) := by
  rw [Fintype.card_congr setPairEncodingEquiv, Fintype.card_set, card_sym2]

/-! ### 有限表現を選んだ段（等号判定が要る）

`Finset` で部分集合を表すと、所属判定と `Sym2 V` 上の判定に等号判定が要る。
これは自己転置性の性質ではなく表現の要求であることを、`Set` 版との橋渡しで示す。 -/

section FinsetStage

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `Finset` 表現の自己転置な近傍割り当て。 -/
def HetSelfTranspose (V : Type) [Fintype V] [DecidableEq V] :=
  {N : V → Finset V // hetTranspose N = N}

/-- 有限表現でも自己転置性は所属の対称性と同値である。 -/
theorem hetSelfTranspose_iff_symmetricMembership (N : V → Finset V) :
    hetTranspose N = N ↔ ∀ v w : V, (w ∈ N v ↔ v ∈ N w) := by
  constructor
  · intro h v w
    calc
      w ∈ N v ↔ w ∈ hetTranspose N v := by rw [h]
      _ ↔ v ∈ N w := mem_hetTranspose N w v
  · intro h
    funext v
    ext w
    calc
      w ∈ hetTranspose N v ↔ v ∈ N w := mem_hetTranspose N w v
      _ ↔ w ∈ N v := (h v w).symm

/-- 有限表現の符号の所属述語。 -/
def hetPairSelected (N : HetSelfTranspose V) : Sym2 V → Prop :=
  Sym2.lift ⟨fun v w => w ∈ N.1 v, fun v w => by
    apply propext
    exact (hetSelfTranspose_iff_symmetricMembership N.1).1 N.2 v w⟩

/-- 有限表現の符号。`Finset.univ.filter` を書くために有限性と判定が要る。 -/
noncomputable def hetPairEncoding (N : HetSelfTranspose V) : Finset (Sym2 V) := by
  classical
  exact Finset.univ.filter (hetPairSelected N)

@[simp] theorem mk_mem_hetPairEncoding (N : HetSelfTranspose V) (v w : V) :
    s(v, w) ∈ hetPairEncoding N ↔ w ∈ N.1 v := by
  simp [hetPairEncoding, hetPairSelected, Sym2.lift_mk]

/-- 有限表現の復元。 -/
def hetPairReconstruction (B : Finset (Sym2 V)) : V → Finset V :=
  fun v => Finset.univ.filter fun w => s(v, w) ∈ B

@[simp] theorem mem_hetPairReconstruction (B : Finset (Sym2 V)) (v w : V) :
    w ∈ hetPairReconstruction B v ↔ s(v, w) ∈ B := by
  simp [hetPairReconstruction]

theorem hetPairReconstruction_symmetricMembership (B : Finset (Sym2 V)) (v w : V) :
    w ∈ hetPairReconstruction B v ↔ v ∈ hetPairReconstruction B w := by
  rw [mem_hetPairReconstruction, mem_hetPairReconstruction]
  rw [Sym2.eq_swap]

theorem hetPairReconstruction_selfTranspose (B : Finset (Sym2 V)) :
    hetTranspose (hetPairReconstruction B) = hetPairReconstruction B :=
  (hetSelfTranspose_iff_symmetricMembership (hetPairReconstruction B)).2
    (hetPairReconstruction_symmetricMembership B)

/-- 有限表現でも符号と復元は互いに逆である。 -/
noncomputable def hetPairEncodingEquiv : HetSelfTranspose V ≃ Finset (Sym2 V) where
  toFun := hetPairEncoding
  invFun := fun B => ⟨hetPairReconstruction B, hetPairReconstruction_selfTranspose B⟩
  left_inv := by
    intro N
    apply Subtype.ext
    funext v
    ext w
    simp
  right_inv := by
    intro B
    ext z
    induction z using Sym2.inductionOn with
    | _ v w => simp

noncomputable instance instFintypeHetSelfTranspose : Fintype (HetSelfTranspose V) :=
  Fintype.ofEquiv (Finset (Sym2 V)) hetPairEncodingEquiv.symm

/-- 有限表現での個数。`Set` 版と同じ値になる。 -/
theorem card_hetSelfTranspose :
    Fintype.card (HetSelfTranspose V) =
      2 ^ (Fintype.card V * (Fintype.card V + 1) / 2) := by
  rw [Fintype.card_congr hetPairEncodingEquiv, Fintype.card_finset, card_sym2]

/-- 自己転置な近傍割り当ての有限表。 -/
def hetSelfTransposeTable : Finset (V → Finset V) :=
  Finset.univ.filter fun N => hetTranspose N = N

/-- 有限表への所属判定は自己転置性の判定と一致する。 -/
@[simp] theorem mem_hetSelfTransposeTable (N : V → Finset V) :
    N ∈ (hetSelfTransposeTable : Finset (V → Finset V)) ↔ hetTranspose N = N := by
  simp [hetSelfTransposeTable]

end FinsetStage

end CellularAutomata.NecSuf.SelfTransposeNeighborhoodAssignmentCount
