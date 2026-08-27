/-
章「自己転置な近傍割り当ての合成閉性」の必要十分版。

具体版（CellularAutomata.SelfTransposeCompositionClosure）と同じ順序で、
合成の自己転置性と可換性の同値、二つの自己転置な証人、二つの合成の値と非等号、
合成が自己転置でないこと、そして合成閉性の有限表による判定を示す。

必要な構造の検査結果:
  - **同値に要る構造は何も無い。** 値を `Set` で表せば、自己転置な二つの割り当ての合成が
    自己転置であることと可換性が同値であることは、型にいかなるインスタンスも要求せずに
    成り立つ（`setComp_selfTranspose_iff_commute`）。人手証明が使うのは、転置が合成順序を
    反転すること、二つの自己転置性の代入、等号の対称性の三つだけである。
  - **始域と終域が同じ型であることは落とせない。** 自己転置性 `Nᵀ = N` も、二つの合成
    `N ⋆ M` と `M ⋆ N` を比較することも、`N` と `M` が同じ型の上の割り当てであることを要求する。
    前々章の転置そのもの（`hetTranspose`）と合成（`hetComp`）は異なる型の間で書けたが、
    この章の主張は書けない。
  - **反例に要るのは、舞台が相異なる二元を持つことだけである。** 具体版は二元舞台 `Fin 2` に
    固定しているが、証人 `setWitnessLoop a`・`setWitnessEdge a b` は任意の型の上で書け、
    自己転置性は `a ≠ b` すら使わずに成り立つ（`setWitnessLoop_selfTranspose`,
    `setWitnessEdge_selfTranspose`）。`a ≠ b` を使うのは、二つの合成の値
    `{b}` と `∅` を分離する段だけである（`setWitness_left_at_a`, `setWitness_right_at_a`）。
    したがって非閉性は、舞台元数が二であることではなく、相異なる二元の存在だけから従う
    （`not_closed_of_exists_ne`）。舞台の有限性も等号判定も使わない。
  - **有限性と等号判定が要るのは `Finset` 表現を選んだ段だけである。**
    `hetTranspose` を `Finset.univ.filter` で書き、順序対を有限表
    `hetCompositionClosedPairTable` として集めるには、走る先の型の有限性 `Fintype V` と
    所属・等号の判定 `DecidableEq V` が要る。これは合成閉性の性質ではなく、
    部分集合と割り当て全体を有限表現するための要求である。
  - **逆向き（舞台が相異なる二元を持たなければ自己転置な割り当てが合成で閉じること）は
    ここでは主張しない。** 人手証明の正本
    structured-latex/content/self-transpose-composition-closure.ts はその向きを述べておらず、
    SageMath の走査（舞台元数 0..3）で観測しただけの事実にとどまっているためである。
  - 状態集合、局所規則、時間、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.SelfTransposeNeighborhoodAssignmentCount

namespace CellularAutomata.NecSuf.SelfTransposeCompositionClosure

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution
open CellularAutomata.NecSuf.SelfTransposeNeighborhoodAssignmentCount

/-! ### 同値（インスタンスを一つも要らない段）

`claim_self_transpose_composition_iff_commute` の人手証明は、転置が合成順序を反転する
等式へ二つの自己転置性を順に代入し、最後に等号の対称性を使うだけである。
この三つはいずれも `Set` 表現で成り立つので、型に何も要求しない。 -/

/-- `claim_self_transpose_composition_iff_commute` の必要十分版。
    人手証明と同じ三段（合成順序の反転・二つの自己転置性の代入・等号の対称性）を辿る。 -/
theorem setComp_selfTranspose_iff_commute {V : Type} (N M : V → Set V)
    (hN : setTranspose N = N) (hM : setTranspose M = M) :
    setTranspose (setComp N M) = setComp N M ↔ setComp N M = setComp M N := by
  rw [setTranspose_setComp, hM, hN]
  exact eq_comm

/-! ### 反例（相異なる二元だけが要る段）

具体版の二元舞台 `Fin 2` と二つの証人を、任意の型の上の二元 `a, b` へ一般化する。
自己転置性は `a ≠ b` を使わずに成り立ち、`a ≠ b` は二つの合成の値を分離する段でだけ要る。 -/

/-- `def_self_transpose_composition_nonclosure_witness` の自己ループの証人の `Set` 版。
    `N(a) = {a}`、それ以外のセルでは空である。 -/
def setWitnessLoop {V : Type} (a : V) : V → Set V :=
  fun v => {w | v = a ∧ w = a}

/-- `def_self_transpose_composition_nonclosure_witness` の二点を結ぶ証人の `Set` 版。
    `M(a) = {b}`、`M(b) = {a}`、それ以外のセルでは空である。 -/
def setWitnessEdge {V : Type} (a b : V) : V → Set V :=
  fun v => {w | (v = a ∧ w = b) ∨ (v = b ∧ w = a)}

/-- `claim_self_transpose_composition_loop_witness_is_self_transpose` の必要十分版。
    所属条件 `v = a ∧ w = a` の連言の対称性だけを使う。`a ≠ b` も有限性も使わない。 -/
theorem setWitnessLoop_selfTranspose {V : Type} (a : V) :
    setTranspose (setWitnessLoop a) = setWitnessLoop a :=
  (setSelfTranspose_iff_symmetricMembership _).2 (by
    intro v w
    constructor
    · rintro ⟨hv, hw⟩; exact ⟨hw, hv⟩
    · rintro ⟨hw, hv⟩; exact ⟨hv, hw⟩)

/-- `claim_self_transpose_composition_edge_witness_is_self_transpose` の必要十分版。
    所属条件の二つの選言を入れ替えるだけを使う。`a ≠ b` も有限性も使わない。 -/
theorem setWitnessEdge_selfTranspose {V : Type} (a b : V) :
    setTranspose (setWitnessEdge a b) = setWitnessEdge a b :=
  (setSelfTranspose_iff_symmetricMembership _).2 (by
    intro v w
    constructor
    · rintro (⟨hv, hw⟩ | ⟨hv, hw⟩)
      · exact Or.inr ⟨hw, hv⟩
      · exact Or.inl ⟨hw, hv⟩
    · rintro (⟨hw, hv⟩ | ⟨hw, hv⟩)
      · exact Or.inr ⟨hv, hw⟩
      · exact Or.inl ⟨hv, hw⟩)

/-- 反例の第一の計算 `(N ⋆ M)(a) = {b}` の必要十分版。
    `N(a) = {a}` から合成の証人が `a` に定まり、`M(a) = {b}` が残る。
    第二の選言 `a = b ∧ x = a` を落とすために `a ≠ b` を使う。 -/
theorem setWitness_left_at_a {V : Type} {a b : V} (hab : a ≠ b) :
    setComp (setWitnessLoop a) (setWitnessEdge a b) a = {b} := by
  ext x
  constructor
  · rintro ⟨u, ⟨-, rfl⟩, hx⟩
    rcases hx with ⟨-, hxb⟩ | ⟨hab', -⟩
    · exact hxb
    · exact absurd hab' hab
  · rintro rfl
    exact ⟨a, ⟨rfl, rfl⟩, Or.inl ⟨rfl, rfl⟩⟩

/-- 反例の第二の計算 `(M ⋆ N)(a) = ∅` の必要十分版。
    `M(a) = {b}` から合成の証人が `b` に定まり、`N(b) = ∅` が残る。
    どちらの段でも `a ≠ b` を使う。 -/
theorem setWitness_right_at_a {V : Type} {a b : V} (hab : a ≠ b) :
    setComp (setWitnessEdge a b) (setWitnessLoop a) a = ∅ := by
  ext x
  constructor
  · rintro ⟨u, hu, ⟨hua, -⟩⟩
    rcases hu with ⟨-, rfl⟩ | ⟨hab', -⟩
    · exact absurd hua.symm hab
    · exact absurd hab' hab
  · intro hx
    exact absurd hx (Set.notMem_empty x)

/-- 二つの証人は可換でない。値 `{b}` と `∅` の分離だけを使う。 -/
theorem setWitness_noncommute {V : Type} {a b : V} (hab : a ≠ b) :
    setComp (setWitnessLoop a) (setWitnessEdge a b) ≠
      setComp (setWitnessEdge a b) (setWitnessLoop a) := by
  intro h
  have hAtA := congrFun h a
  rw [setWitness_left_at_a hab, setWitness_right_at_a hab] at hAtA
  exact Set.singleton_ne_empty b hAtA

/-- `claim_self_transpose_neighborhood_assignments_not_composition_closed` の必要十分版。
    自己転置な二つの証人の合成は自己転置でない。 -/
theorem setWitness_composition_not_selfTranspose {V : Type} {a b : V} (hab : a ≠ b) :
    setTranspose (setComp (setWitnessLoop a) (setWitnessEdge a b)) ≠
      setComp (setWitnessLoop a) (setWitnessEdge a b) := by
  intro h
  exact setWitness_noncommute hab
    ((setComp_selfTranspose_iff_commute _ _ (setWitnessLoop_selfTranspose a)
      (setWitnessEdge_selfTranspose a b)).1 h)

/-- 非閉性に要る仮定は、舞台が相異なる二元を持つことだけである。
    舞台の有限性も等号判定も使わない。 -/
theorem not_closed_of_exists_ne {V : Type} (h : ∃ a b : V, a ≠ b) :
    ∃ N M : V → Set V,
      setTranspose N = N ∧ setTranspose M = M ∧
        setTranspose (setComp N M) ≠ setComp N M := by
  obtain ⟨a, b, hab⟩ := h
  exact ⟨setWitnessLoop a, setWitnessEdge a b,
    setWitnessLoop_selfTranspose a, setWitnessEdge_selfTranspose a b,
    setWitness_composition_not_selfTranspose hab⟩

/-! ### 有限表現を選んだ段（有限性と等号判定が要る）

`Finset` で部分集合を表すと、転置を `Finset.univ.filter` で書くために有限性と等号判定が要る。
これは合成閉性の性質ではなく表現の要求であることを、同じ順序の証明で示す。 -/

section FinsetStage

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 同値の有限表現版。証明手順は `Set` 版と同じ三段である。 -/
theorem hetComp_selfTranspose_iff_commute (N M : V → Finset V)
    (hN : hetTranspose N = N) (hM : hetTranspose M = M) :
    hetTranspose (hetComp N M) = hetComp N M ↔ hetComp N M = hetComp M N := by
  rw [hetTranspose_hetComp, hM, hN]
  exact eq_comm

/-- 自己ループの証人の有限表現版。 -/
def hetWitnessLoop (a : V) : V → Finset V :=
  fun v => if v = a then {a} else ∅

/-- 二点を結ぶ証人の有限表現版。 -/
def hetWitnessEdge (a b : V) : V → Finset V :=
  fun v => if v = a then {b} else if v = b then {a} else ∅

/-- 有限表現の自己ループの証人は `Set` 版と一致する。有限性と等号判定が表現のためだけに
    要ることの根拠である。 -/
theorem coe_hetWitnessLoop (a v : V) :
    ((hetWitnessLoop a v : Finset V) : Set V) = setWitnessLoop a v := by
  ext w
  by_cases hv : v = a <;> simp [hetWitnessLoop, setWitnessLoop, hv]

/-- 有限表現の二点を結ぶ証人の所属条件。`Set` 版の所属条件と同じ選言である。 -/
theorem mem_hetWitnessEdge (a b v w : V) :
    w ∈ hetWitnessEdge a b v ↔ ((v = a ∧ w = b) ∨ (v = b ∧ w = a)) := by
  unfold hetWitnessEdge
  split_ifs with h1 h2
  · simp only [Finset.mem_singleton]
    constructor
    · intro hw
      exact Or.inl ⟨h1, hw⟩
    · rintro (⟨-, hw⟩ | ⟨hvb, hw⟩)
      · exact hw
      · rw [hw, ← h1, hvb]
  · simp only [Finset.mem_singleton]
    constructor
    · intro hw
      exact Or.inr ⟨h2, hw⟩
    · rintro (⟨hv, -⟩ | ⟨-, hw⟩)
      · exact absurd hv h1
      · exact hw
  · constructor
    · intro hw
      exact absurd hw (Finset.notMem_empty w)
    · rintro (⟨hv, -⟩ | ⟨hv, -⟩)
      · exact absurd hv h1
      · exact absurd hv h2

/-- 有限表現の二点を結ぶ証人は `Set` 版と一致する。 -/
theorem coe_hetWitnessEdge (a b v : V) :
    ((hetWitnessEdge a b v : Finset V) : Set V) = setWitnessEdge a b v := by
  ext w
  simp only [Finset.mem_coe, setWitnessEdge, Set.mem_setOf_eq]
  exact mem_hetWitnessEdge a b v w

/-- 有限表現の自己ループの証人は自己転置である。 -/
theorem hetWitnessLoop_selfTranspose (a : V) :
    hetTranspose (hetWitnessLoop a) = hetWitnessLoop a :=
  (hetSelfTranspose_iff_symmetricMembership _).2 (by
    intro v w
    by_cases hv : v = a <;> by_cases hw : w = a <;>
      simp [hetWitnessLoop, hv, hw])

/-- 有限表現の二点を結ぶ証人は自己転置である。証明手順は `Set` 版と同じく、
    所属条件の二つの選言を入れ替えるだけである。 -/
theorem hetWitnessEdge_selfTranspose (a b : V) :
    hetTranspose (hetWitnessEdge a b) = hetWitnessEdge a b :=
  (hetSelfTranspose_iff_symmetricMembership _).2 (by
    intro v w
    rw [mem_hetWitnessEdge, mem_hetWitnessEdge]
    constructor
    · rintro (⟨hv, hw⟩ | ⟨hv, hw⟩)
      · exact Or.inr ⟨hw, hv⟩
      · exact Or.inl ⟨hw, hv⟩
    · rintro (⟨hw, hv⟩ | ⟨hw, hv⟩)
      · exact Or.inr ⟨hv, hw⟩
      · exact Or.inl ⟨hv, hw⟩)

/-- 自己転置な二つの割り当てのうち、合成が自己転置になる順序対の有限表。
    有限性と等号判定は、この表を作るためだけに要る。 -/
def hetCompositionClosedPairTable :
    Finset ((V → Finset V) × (V → Finset V)) :=
  Finset.univ.filter fun p =>
    hetTranspose p.1 = p.1 ∧
    hetTranspose p.2 = p.2 ∧
    hetComp p.1 p.2 = hetComp p.2 p.1

/-- `claim_self_transpose_composition_closure_finitely_decidable` の必要十分版。
    有限表への所属は、二つの自己転置性と合成の自己転置性の合接と一致する。 -/
theorem mem_hetCompositionClosedPairTable (N M : V → Finset V) :
    (N, M) ∈ hetCompositionClosedPairTable ↔
      hetTranspose N = N ∧ hetTranspose M = M ∧
        hetTranspose (hetComp N M) = hetComp N M := by
  simp only [hetCompositionClosedPairTable, Finset.mem_filter, Finset.mem_univ, true_and]
  constructor
  · rintro ⟨hN, hM, hCommute⟩
    exact ⟨hN, hM, (hetComp_selfTranspose_iff_commute N M hN hM).2 hCommute⟩
  · rintro ⟨hN, hM, hSelfTranspose⟩
    exact ⟨hN, hM, (hetComp_selfTranspose_iff_commute N M hN hM).1 hSelfTranspose⟩

end FinsetStage

end CellularAutomata.NecSuf.SelfTransposeCompositionClosure
