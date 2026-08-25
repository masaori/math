/-
章「可逆な大域写像の巡回型」の必要十分版。
具体版は CellularAutomata/ReversibleGlobalMapCycleType.lean。

具体版の証明が実際に使っているのは、台となる型 X が有限であること（Fintype X）と、
その等号が判定できること（DecidableEq X）だけである。次はいずれも使わない。

  * 状態集合が 2 元であること
  * 台が配位型 A^V の形（セルの集合 V 上の関数型）であること
  * 舞台がグラフであること、近傍・局所規則・大域写像であること
  * 元数が 2 の冪であること（総和の主張は Fintype.card X のままで通る）

削れなかった仮定と、その必要な理由。

  * Fintype X : 単射な自己写像を有限置換として読む段（toPerm）、固定点の個数を
    Fintype.card X から数える段（cycleType）、分割の実現で長さの総和が元数を超えない
    という条件を課す段で要る。無限型では単射から全射が従わないので置換にならない。
  * DecidableEq X : 有限多重集合としての巡回型 Equiv.Perm.cycleType を取る段で要る。

証明手順は具体版と同じ順序（置換への読み替え → 固定点を戻した巡回型 → 正値性と総和 →
共役不変性 → 完全性 → 分割の実現 → 商の全単射）で並べ、論法を差し替えていない。
有限集合・自然数・有限多重集合だけで閉じ、R / C は現れない。
-/

import Mathlib.GroupTheory.Perm.Cycle.PossibleTypes

namespace CellularAutomata.NecSuf.ReversibleGlobalMapCycleType

variable {X : Type} [Fintype X] [DecidableEq X]

/-- 有限型上の単射な自己写像全体。二値状態・セル・近傍は要らない。 -/
def InjSelfMap (X : Type) [Fintype X] [DecidableEq X] :=
  {F : X → X // Function.Injective F}

instance : CoeFun (InjSelfMap X) (fun _ => X → X) :=
  ⟨fun F => F.1⟩

/-- 有限型上の単射な自己写像を、同じ写像を持つ有限置換として読む。 -/
noncomputable def toPerm (F : InjSelfMap X) : Equiv.Perm X :=
  Equiv.ofBijective F.1 ((Fintype.bijective_iff_injective_and_card F.1).2 ⟨F.2, rfl⟩)

@[simp]
theorem toPerm_apply (F : InjSelfMap X) (x : X) : toPerm F x = F.1 x := rfl

/-- 固定点を含む巡回型。Mathlib の巡回型は非自明周期だけを集めるので、
    固定点の個数だけ 1 を明示的に加える。 -/
noncomputable def cycleType (F : InjSelfMap X) : Multiset ℕ :=
  (toPerm F).cycleType +
    Multiset.replicate (Fintype.card X - (toPerm F).cycleType.sum) 1

/-- 巡回型から 1 を除けば、非自明周期だけを持つ Mathlib の巡回型へ戻る。 -/
theorem filter_cycleType (F : InjSelfMap X) :
    (cycleType F).filter (fun n => 2 ≤ n) = (toPerm F).cycleType := by
  classical
  rw [cycleType, Multiset.filter_add]
  have hmain : (toPerm F).cycleType.filter (fun n => 2 ≤ n) = (toPerm F).cycleType := by
    apply Multiset.filter_eq_self.2
    intro n hn
    exact Equiv.Perm.two_le_of_mem_cycleType hn
  rw [hmain]
  have hrep :
      (Multiset.replicate (Fintype.card X - (toPerm F).cycleType.sum) 1).filter
        (fun n => 2 ≤ n) = 0 := by
    induction (Fintype.card X - (toPerm F).cycleType.sum) with
    | zero => simp
    | succ k ih => simp [Multiset.replicate_succ, ih]
  rw [hrep, add_zero]

/-- 巡回型の各要素は正の自然数である。 -/
theorem cycleType_members_positive (F : InjSelfMap X) {n : ℕ} (hn : n ∈ cycleType F) :
    1 ≤ n := by
  classical
  rw [cycleType, Multiset.mem_add] at hn
  rcases hn with hn | hn
  · exact (Equiv.Perm.two_le_of_mem_cycleType hn).trans' (by omega)
  · rw [Multiset.mem_replicate] at hn
    omega

/-- 巡回型の重複度つき和は台の元数に等しい。2 の冪であることは使わない。 -/
theorem cycleType_sum (F : InjSelfMap X) :
    (cycleType F).sum = Fintype.card X := by
  classical
  have hle : (toPerm F).cycleType.sum ≤ Fintype.card X :=
    Equiv.Perm.sum_cycleType_le (toPerm F)
  have hsum (k : ℕ) : (Multiset.replicate k 1 : Multiset ℕ).sum = k := by
    induction k with
    | zero => simp
    | succ k ih => simp [Multiset.replicate_succ, ih, Nat.add_comm]
  rw [cycleType, Multiset.sum_add, hsum]
  exact Nat.add_sub_of_le hle

/-- 同じ台の上の二つの単射な自己写像の間の共役全単射。 -/
def Conj (F G : InjSelfMap X) : Prop :=
  ∃ h : X ≃ X, ∀ x, h (F.1 x) = G.1 (h x)

/-- 共役全単射は、対応する有限置換を群論的な共役で結ぶ。 -/
theorem perm_conj_eq {F G : InjSelfMap X} {h : X ≃ X}
    (hcomm : ∀ x, h (F.1 x) = G.1 (h x)) :
    h * toPerm F * h⁻¹ = toPerm G := by
  apply Equiv.ext
  intro x
  simpa using hcomm (h⁻¹ x)

/-- 共役全単射は巡回型を保存する。 -/
theorem cycleType_eq_of_conj {F G : InjSelfMap X} (hFG : Conj F G) :
    cycleType F = cycleType G := by
  classical
  obtain ⟨h, hcomm⟩ := hFG
  have hperm := perm_conj_eq hcomm
  have hnontrivial : (toPerm F).cycleType = (toPerm G).cycleType := by
    rw [← hperm, Equiv.Perm.cycleType_conj]
  simp [cycleType, hnontrivial]

/-- 巡回型の一致から共役全単射を構成できる。 -/
theorem conj_of_cycleType_eq {F G : InjSelfMap X} (hct : cycleType F = cycleType G) :
    Conj F G := by
  classical
  have hnontrivial : (toPerm F).cycleType = (toPerm G).cycleType := by
    rw [← filter_cycleType F, ← filter_cycleType G, hct]
  have his : IsConj (toPerm F) (toPerm G) :=
    Equiv.Perm.isConj_iff_cycleType_eq.2 hnontrivial
  obtain ⟨h, hconj⟩ := isConj_iff.1 his
  refine ⟨h, ?_⟩
  intro x
  have hx := congrArg (fun p : Equiv.Perm X => p (h x)) hconj
  simpa using hx

/-- 巡回型は単射な自己写像の共役に関する完全不変量である。 -/
theorem conj_iff_cycleType_eq (F G : InjSelfMap X) :
    Conj F G ↔ cycleType F = cycleType G :=
  ⟨cycleType_eq_of_conj, conj_of_cycleType_eq⟩

/-- 台の元数の正の自然数への分割。 -/
def CardPartition (X : Type) [Fintype X] [DecidableEq X] :=
  {m : Multiset ℕ // (∀ n ∈ m, 1 ≤ n) ∧ m.sum = Fintype.card X}

/-- 正の要素だけを持つ有限多重集合は、1 の部分と 2 以上の部分に分解する。
    ここには有限性も等号判定も要らない。 -/
theorem positive_multiset_decomposition (m : Multiset ℕ) (hpos : ∀ n ∈ m, 1 ≤ n) :
    m.filter (fun n => 2 ≤ n) + Multiset.replicate (m.count 1) 1 = m := by
  classical
  have hcomp : m.filter (fun n => ¬ 2 ≤ n) = m.filter (Eq 1) := by
    apply Multiset.filter_congr
    intro n hn
    constructor
    · intro hnlt
      have := hpos n hn
      omega
    · intro hn1
      omega
  have hrep : m.filter (fun n => ¬ 2 ≤ n) = Multiset.replicate (m.count 1) 1 :=
    hcomp.trans (Multiset.filter_eq m 1)
  calc
    m.filter (fun n => 2 ≤ n) + Multiset.replicate (m.count 1) 1
        = m.filter (fun n => 2 ≤ n) + m.filter (fun n => ¬ 2 ≤ n) := by rw [hrep]
    _ = m := Multiset.filter_add_not (p := fun n : ℕ => 2 ≤ n) m

/-- 台の元を `Fintype.equivFin` で一列に並べ、指定された長さごとの
連続した有限列へ切り分ける。人手証明の分割構成そのものである。 -/
theorem explicit_disjoint_blocks (lengths : List ℕ)
    (hsum : lengths.sum ≤ Fintype.card X) :
    ∃ blocks : List (List X),
      blocks.map List.length = lengths ∧
      (∀ block ∈ blocks, block.Nodup) ∧
      blocks.Pairwise List.Disjoint := by
  let liftIndex (n : ℕ) (hn : n < Fintype.card X) : Fin (Fintype.card X) := ⟨n, hn⟩
  let liftRange (range : List ℕ) (hrange : ∀ n ∈ range, n < Fintype.card X) :
      List (Fin (Fintype.card X)) := List.pmap liftIndex range hrange
  have hrange_lt : ∀ range ∈ lengths.ranges, ∀ n ∈ range, n < Fintype.card X := by
    intro range hrange n hn
    apply lt_of_lt_of_le _ hsum
    rw [← List.mem_mem_ranges_iff_lt_sum]
    exact ⟨range, hrange, hn⟩
  let liftedRanges := lengths.ranges.pmap liftRange hrange_lt
  have hlifted_value : ∀ (range : List ℕ) (hrange : range ∈ lengths.ranges),
      (liftRange range (hrange_lt range hrange)).map Fin.valEmbedding = range := by
    intro range hrange
    conv_rhs => rw [← List.map_id range]
    rw [List.map_pmap]
    simp [liftIndex, Fin.valEmbedding_apply, List.pmap_eq_map, List.map_id']
  refine ⟨liftedRanges.map (List.map (Fintype.equivFin X).symm), ?_, ?_, ?_⟩
  · rw [← List.ranges_length lengths]
    simp only [liftedRanges, liftRange, List.map_pmap, List.length_pmap,
      List.pmap_eq_map]
  · intro block hblock
    rw [List.mem_map] at hblock
    obtain ⟨finBlock, hfinBlock, rfl⟩ := hblock
    apply List.Nodup.map (Equiv.injective _)
    obtain ⟨range, hrange, rfl⟩ := List.mem_pmap.mp hfinBlock
    apply List.Nodup.of_map
    rw [hlifted_value range hrange]
    exact List.ranges_nodup hrange
  · refine List.Pairwise.map _ (fun left right => List.disjoint_map (Equiv.injective _)) ?_
    apply List.Pairwise.pmap (List.ranges_disjoint lengths)
    intro left hleft right hright hlr
    apply List.disjoint_pmap
    · intro a b ha hb hab
      simpa only [liftIndex, Fin.mk_eq_mk] using hab
    exact hlr

/-- 台の元数の各分割は、同じ台の上の単射な自己写像の巡回型として実現する。 -/
theorem exists_cycleType_eq_partition (p : CardPartition X) :
    ∃ F : InjSelfMap X, cycleType F = p.1 := by
  classical
  let m := p.1.filter (fun n => 2 ≤ n)
  have hmpos : ∀ n ∈ p.1, 1 ≤ n := p.2.1
  have hsum_split : p.1.sum = m.sum + p.1.count 1 := by
    calc p.1.sum
        = (m + Multiset.replicate (p.1.count 1) 1).sum := by
            exact congrArg Multiset.sum (positive_multiset_decomposition p.1 hmpos).symm
      _ = m.sum + p.1.count 1 := by simp
  have hmsum : m.sum ≤ Fintype.card X := by
    rw [← p.2.2, hsum_split]
    omega
  have hmmem : ∀ n ∈ m, 2 ≤ n := by
    intro n hn
    exact (Multiset.mem_filter.1 hn).2
  have hlist_sum : m.toList.sum ≤ Fintype.card X := by
    simpa only [Multiset.sum_toList] using hmsum
  obtain ⟨blocks, hlengths, hnodup, hdisjoint⟩ := explicit_disjoint_blocks m.toList hlist_sum
  let g : Equiv.Perm X := List.prod (blocks.map fun block => List.formPerm block)
  have hblock_two : ∀ block ∈ blocks, 2 ≤ block.length := by
    intro block hblock
    apply hmmem block.length
    rw [← Multiset.mem_toList, ← hlengths, List.mem_map]
    exact ⟨block, hblock, rfl⟩
  have hg : g.cycleType = m := by
    rw [Equiv.Perm.cycleType_eq _ rfl]
    · rw [← Multiset.coe_toList m]
      apply congrArg
      rw [List.map_map, ← hlengths]
      apply List.map_congr_left
      intro block hblock
      simp only [Function.comp_apply]
      rw [List.support_formPerm_of_nodup block (hnodup block hblock)]
      · exact List.toFinset_card_of_nodup (hnodup block hblock)
      · grind
    · simpa using fun block hblock =>
        List.isCycle_formPerm (hnodup block hblock) (hblock_two block hblock)
    · rw [List.pairwise_map]
      apply List.Pairwise.imp_of_mem _ hdisjoint
      intro left right hleft hright hlr
      rw [List.formPerm_disjoint_iff
        (hnodup left hleft) (hnodup right hright)
        (hblock_two left hleft) (hblock_two right hright)]
      exact hlr
  let F : InjSelfMap X := ⟨g, g.injective⟩
  refine ⟨F, ?_⟩
  have hto : toPerm F = g := Equiv.ext (fun _ => rfl)
  have hfixed : Fintype.card X - m.sum = p.1.count 1 := by
    have hcard : Fintype.card X = p.1.sum := p.2.2.symm
    calc
      Fintype.card X - m.sum = p.1.sum - m.sum := congrArg (fun n => n - m.sum) hcard
      _ = p.1.count 1 := by omega
  rw [cycleType, hto, hg, hfixed]
  exact positive_multiset_decomposition p.1 hmpos

/-- 単射な自己写像の共役関係が作る同値関係。 -/
def conjSetoid : Setoid (InjSelfMap X) where
  r := Conj
  iseqv := by
    refine ⟨?_, ?_, ?_⟩
    · intro F
      exact ⟨Equiv.refl _, fun _ => rfl⟩
    · intro F G hFG
      obtain ⟨h, hcomm⟩ := hFG
      refine ⟨h.symm, fun x => ?_⟩
      apply h.injective
      simpa using (hcomm (h.symm x)).symm
    · intro F G H hFG hGH
      obtain ⟨h, hcomm⟩ := hFG
      obtain ⟨k, kcomm⟩ := hGH
      refine ⟨h.trans k, fun x => ?_⟩
      exact (congrArg k (hcomm x)).trans (kcomm (h x))

/-- 単射な自己写像の共役類。 -/
def ConjClass (X : Type) [Fintype X] [DecidableEq X] :=
  Quotient (conjSetoid (X := X))

/-- 共役類から分割への写像。共役不変性が代表非依存性を与える。 -/
noncomputable def quotientCycleType : ConjClass X → CardPartition X :=
  Quotient.lift
    (fun F => ⟨cycleType F, (fun n hn => cycleType_members_positive F hn), cycleType_sum F⟩)
    (fun F G hFG => Subtype.ext (cycleType_eq_of_conj hFG))

@[simp]
theorem quotientCycleType_mk (F : InjSelfMap X) :
    (quotientCycleType (Quotient.mk (conjSetoid (X := X)) F)).1 = cycleType F := rfl

theorem quotientCycleType_injective : Function.Injective (quotientCycleType (X := X)) := by
  intro K L hKL
  induction K using Quotient.inductionOn with
  | h F =>
    induction L using Quotient.inductionOn with
    | h G =>
      apply Quotient.sound
      exact conj_of_cycleType_eq (congrArg Subtype.val hKL)

theorem quotientCycleType_surjective : Function.Surjective (quotientCycleType (X := X)) := by
  intro p
  obtain ⟨F, hF⟩ := exists_cycleType_eq_partition p
  refine ⟨Quotient.mk (conjSetoid (X := X)) F, ?_⟩
  apply Subtype.ext
  exact hF

/-- 単射な自己写像の共役類と、台の元数の正の自然数への分割との全単射。 -/
noncomputable def conjClassEquivPartitions : ConjClass X ≃ CardPartition X :=
  Equiv.ofBijective quotientCycleType ⟨quotientCycleType_injective, quotientCycleType_surjective⟩

end CellularAutomata.NecSuf.ReversibleGlobalMapCycleType
