/-
章「自己転置な近傍割り当て全体の合成閉性の特徴づけ」の必要十分版。

具体版（CellularAutomata.SelfTransposeCompositionTotalClosureCharacterization）と同じ順序で、
全ての自己転置な近傍割り当てが合成で閉じることと、舞台が相異なる二元を持たないことの同値を示す。

必要な構造の検査結果:
  - **舞台の有限性も等号判定も要らない。** 値を `Set` で表せば、閉性と `Subsingleton V` の
    同値は型にいかなるインスタンスも要求せずに成り立つ
    （`setAllSelfTransposeCompositionClosed_iff_subsingleton`）。具体版は舞台元数の条件を
    `Fintype.card V ≤ 1` と書いているが、これは有限舞台での `Subsingleton V` の言い換えに
    すぎず、主張そのものが有限性を要求しているのではない。
  - **順方向に要るのは前章の非閉性だけである。** 相異なる二元から作る自己ループと二点辺の
    証人は前章の必要十分版
    （`NecSuf.SelfTransposeCompositionClosure.not_closed_of_exists_ne`）で既に任意の型の上に
    書かれており、本章の順方向はその対偶に `¬ Subsingleton V → Nontrivial V` を挟むだけである。
  - **逆方向に要るのは `Subsingleton V` だけである。** 合成の所属条件の交換は、合成の証人 `u` と
    出力側の元 `w` を入力セル `v` へ移す二回の `Subsingleton.elim` と、連言の交換だけで済む
    （`setComp_comm_of_subsingleton`）。自己転置性は逆方向のこの段では使わず、
    前章の同値へ渡す最後の一段でだけ使う。
  - **`Subsingleton V` は `V` が空である場合も含む。** 空舞台では割り当ての値も全て空で、
    閉性は自明に成り立つ。上の証明は `v` を取ってから元を潰すので、空舞台でも
    そのまま通る（全称量化が空虚に真になる）。
  - **有限性と等号判定が要るのは `Finset` 表現を選んだ段だけである。**
    転置 `hetTranspose` を `Finset.univ.filter` で書き、合成 `hetComp` を `Finset.biUnion` で
    書くために `Fintype V` と `DecidableEq V` が要る。これは閉性の性質ではなく、
    部分集合を有限表現するための要求である（`hetAllSelfTransposeCompositionClosed_iff_subsingleton`）。
  - 状態集合、局所規則、時間、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.SelfTransposeCompositionTotalClosureCharacterization
import CellularAutomata.NecSuf.SelfTransposeCompositionClosure

namespace CellularAutomata.NecSuf.SelfTransposeCompositionTotalClosureCharacterization

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution
open CellularAutomata.NecSuf.SelfTransposeCompositionClosure

/-! ### 同値（インスタンスを一つも要らない段）

`def_all_self_transpose_assignments_composition_closed` と
`claim_all_self_transpose_assignments_composition_closed_iff_subsingleton` を、
有限性も等号判定も持たない型の上で書く。 -/

/-- `def_all_self_transpose_assignments_composition_closed` の `Set` 版。
    型にインスタンスを一つも要求しない。 -/
def SetAllSelfTransposeCompositionClosed (V : Type) : Prop :=
  ∀ N M : V → Set V,
    setTranspose N = N → setTranspose M = M →
      setTranspose (setComp N M) = setComp N M

/-- 舞台が相異なる二元を持たなければ、任意の二つの割り当ては可換である。
    人手証明の逆向きの所属条件の連鎖に対応する。自己転置性は使わない。 -/
theorem setComp_comm_of_subsingleton {V : Type} [Subsingleton V] (N M : V → Set V) :
    setComp N M = setComp M N := by
  funext v
  ext w
  constructor
  · rintro ⟨u, huN, hwM⟩
    have huv : u = v := Subsingleton.elim u v
    have hwv : w = v := Subsingleton.elim w v
    rw [huv] at huN hwM
    rw [hwv] at hwM
    rw [hwv]
    exact ⟨v, hwM, huN⟩
  · rintro ⟨u, huM, hwN⟩
    have huv : u = v := Subsingleton.elim u v
    have hwv : w = v := Subsingleton.elim w v
    rw [huv] at huM hwN
    rw [hwv] at hwN
    rw [hwv]
    exact ⟨v, hwN, huM⟩

/-- `claim_all_self_transpose_assignments_composition_closed_iff_subsingleton` の必要十分版。
    順方向は前章の非閉性（相異なる二元だけを使う）へ帰着し、
    逆方向は `Subsingleton V` からの可換性を前章の同値へ渡す。
    舞台の有限性も等号判定も使わない。 -/
theorem setAllSelfTransposeCompositionClosed_iff_subsingleton (V : Type) :
    SetAllSelfTransposeCompositionClosed V ↔ Subsingleton V := by
  constructor
  · intro hClosed
    by_contra hSubsingleton
    letI : Nontrivial V := not_subsingleton_iff_nontrivial.mp hSubsingleton
    obtain ⟨N, M, hN, hM, hNot⟩ := not_closed_of_exists_ne (exists_pair_ne V)
    exact hNot (hClosed N M hN hM)
  · intro hSubsingleton N M hN hM
    exact (setComp_selfTranspose_iff_commute N M hN hM).2 (setComp_comm_of_subsingleton N M)

/-! ### 有限表現を選んだ段（有限性と等号判定が要る）

`Finset` で部分集合を表すと、転置と合成を書くために有限性と等号判定が要る。
これは閉性の性質ではなく表現の要求であることを、同じ順序の証明で示す。 -/

section FinsetStage

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_all_self_transpose_assignments_composition_closed` の有限表現版。 -/
def HetAllSelfTransposeCompositionClosed (V : Type) [Fintype V] [DecidableEq V] : Prop :=
  ∀ N M : V → Finset V,
    hetTranspose N = N → hetTranspose M = M →
      hetTranspose (hetComp N M) = hetComp N M

omit [Fintype V] in
/-- 有限表現の二つの証人は可換でない。値 `{b}` と `∅` の分離だけを使う。 -/
theorem hetWitness_noncommute {a b : V} (hab : a ≠ b) :
    hetComp (hetWitnessLoop a) (hetWitnessEdge a b) ≠
      hetComp (hetWitnessEdge a b) (hetWitnessLoop a) := by
  intro h
  have hAtA := congrFun h a
  have hMem := congrArg (fun S : Finset V => b ∈ S) hAtA
  have hba : b ≠ a := Ne.symm hab
  simp [hetComp, hetWitnessLoop, hetWitnessEdge, hba] at hMem

/-- 有限表現でも、相異なる二元があれば自己転置な二つの証人の合成は自己転置でない。 -/
theorem het_not_closed_of_exists_ne (h : ∃ a b : V, a ≠ b) :
    ∃ N M : V → Finset V,
      hetTranspose N = N ∧ hetTranspose M = M ∧
        hetTranspose (hetComp N M) ≠ hetComp N M := by
  obtain ⟨a, b, hab⟩ := h
  refine ⟨hetWitnessLoop a, hetWitnessEdge a b,
    hetWitnessLoop_selfTranspose a, hetWitnessEdge_selfTranspose a b, ?_⟩
  intro hSelfTranspose
  exact hetWitness_noncommute hab
    ((hetComp_selfTranspose_iff_commute _ _ (hetWitnessLoop_selfTranspose a)
      (hetWitnessEdge_selfTranspose a b)).1 hSelfTranspose)

/-- 有限表現版の同値。証明手順は `Set` 版と同じ二方向である。 -/
theorem hetAllSelfTransposeCompositionClosed_iff_subsingleton :
    HetAllSelfTransposeCompositionClosed V ↔ Subsingleton V := by
  constructor
  · intro hClosed
    by_contra hSubsingleton
    letI : Nontrivial V := not_subsingleton_iff_nontrivial.mp hSubsingleton
    obtain ⟨N, M, hN, hM, hNot⟩ := het_not_closed_of_exists_ne (exists_pair_ne V)
    exact hNot (hClosed N M hN hM)
  · intro hSubsingleton N M hN hM
    refine (hetComp_selfTranspose_iff_commute N M hN hM).2 ?_
    funext v
    ext w
    simp only [hetComp, Finset.mem_biUnion]
    constructor
    · rintro ⟨u, huN, hwM⟩
      have huv : u = v := Subsingleton.elim u v
      have hwv : w = v := Subsingleton.elim w v
      rw [huv] at huN hwM
      rw [hwv] at hwM
      rw [hwv]
      exact ⟨v, hwM, huN⟩
    · rintro ⟨u, huM, hwN⟩
      have huv : u = v := Subsingleton.elim u v
      have hwv : w = v := Subsingleton.elim w v
      rw [huv] at huM hwN
      rw [hwv] at hwN
      rw [hwv]
      exact ⟨v, hwN, huM⟩

/-- 有限舞台では、有限表現版の閉性は `Set` 版の閉性と同値である。
    どちらも `Subsingleton V` と同値であることから従う。 -/
theorem hetAll_iff_setAll :
    HetAllSelfTransposeCompositionClosed V ↔ SetAllSelfTransposeCompositionClosed V := by
  rw [hetAllSelfTransposeCompositionClosed_iff_subsingleton,
    setAllSelfTransposeCompositionClosed_iff_subsingleton]

end FinsetStage

/-! ### 具体版の導出

具体版の述語は有限表現版の述語そのものであり、具体版の同値は有限表現版の同値と
`Fintype.card V ≤ 1 ↔ Subsingleton V` の合成として得られる。 -/

section Derivation

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.SelfTransposeCompositionTotalClosureCharacterization

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 具体版の閉性の述語は、必要十分版の有限表現の述語と同じものである。 -/
theorem allSelfTransposeCompositionClosed_eq_het :
    AllSelfTransposeCompositionClosed V = HetAllSelfTransposeCompositionClosed V :=
  rfl

/-- 具体版
    `allSelfTransposeCompositionClosed_iff_card_le_one` は、必要十分版の同値の特殊化である。 -/
theorem allSelfTransposeCompositionClosed_iff_card_le_one_of_necSuf :
    AllSelfTransposeCompositionClosed V ↔ Fintype.card V ≤ 1 := by
  rw [allSelfTransposeCompositionClosed_eq_het,
    hetAllSelfTransposeCompositionClosed_iff_subsingleton]
  exact ⟨fun h => Fintype.card_le_one_iff_subsingleton.mpr h,
    fun h => Fintype.card_le_one_iff_subsingleton.mp h⟩

/-- 具体版の二つの証人が可換でないことは、必要十分版の有限表現の非可換性の特殊化である。 -/
theorem witnesses_noncommute_of_necSuf {a b : V} (hab : a ≠ b) :
    composedNeighborhood (loopWitness a) (edgeWitness a b) ≠
      composedNeighborhood (edgeWitness a b) (loopWitness a) :=
  hetWitness_noncommute hab

end Derivation

end CellularAutomata.NecSuf.SelfTransposeCompositionTotalClosureCharacterization
