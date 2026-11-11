/-
「平滑化後の横断数は二本の閉歩道の横断数と混合横断数の和である」の必要十分版。
辺・横断・閉歩道は使わず、有限集合を排他的な二つの述語で三つに分けると
元の個数が三つの個数の和になることだけを使う。排他性（両方の述語を同時に
満たす元が無いこと）は、人手証明の「各対は A×A・B×B・混合のちょうど一つに
属する」に対応し、削ると第二の filter が第一と重なって和が過剰になるため必要である。

`smoothing_split_crossing_partition_necSuf` は、具体版
`Ising2DLambda.KacWard.smoothing_split_crossing_partition` と同じ手順（三分割、`p_A` の単調な全単射、
`p_B` による順序なし二元集合の全単射、混合対の置き直し）を、辺・格子・方向を取り去って述べる。
使う仮定は次の二つだけである。
- 平滑化後の各出辺が接続であること（`hexit`）。二本の閉歩道の横断は接続の条件を含むので
  （`straightCrossing`）、これを削ると `C^sm` の対が二本の横断に戻らず、`c(γ_A) ≤ |C_AA|` しか言えない。
- `k < l`。二本の区間の位置の写像の単射性と像（ブロック `A`・`B`）に使う。
直進の関係 `straight`、終点 `target`、軸 `axis` には何の性質も要らない（交換の対称性は等号と `≠` の対称性だけ）。
-/
import Mathlib.Data.Finset.Card
import Ising2DLambda.NecSuf.KacWard.SmoothedSplitClosedWalks
import Ising2DLambda.NecSuf.KacWard.ClosedWalkCrossingNumber
import Ising2DLambda.NecSuf.KacWard.SmoothedCrossingNumber
import Ising2DLambda.NecSuf.KacWard.SplitMutualCrossingNumber

namespace Ising2DLambda.NecSuf.KacWard

/-- 排他的な二つの述語による三分割で、有限集合の個数は三つの個数の和になる。 -/
theorem three_way_filter_card_necSuf {α : Type} (S : Finset α)
    (p q : α → Prop) [DecidablePred p] [DecidablePred q]
    (hpq : ∀ a ∈ S, ¬(p a ∧ q a)) :
    S.card = (S.filter p).card + (S.filter q).card
      + (S.filter fun a => ¬ p a ∧ ¬ q a).card := by
  -- 人手証明の「互いに素な有限集合の分割」を、p での二分割と
  -- その否定側の q での二分割の二段で行う。
  have h1 : (S.filter p).card + (S.filter fun a => ¬ p a).card = S.card :=
    Finset.card_filter_add_card_filter_not (p := p)
  have h2 : ((S.filter fun a => ¬ p a).filter q).card
      + ((S.filter fun a => ¬ p a).filter fun a => ¬ q a).card
      = (S.filter fun a => ¬ p a).card :=
    Finset.card_filter_add_card_filter_not (p := q)
  have h3 : (S.filter fun a => ¬ p a).filter q = S.filter q := by
    ext a
    simp only [Finset.mem_filter]
    exact ⟨fun h => ⟨h.1.1, h.2⟩,
      fun h => ⟨⟨h.1, fun hp => hpq a h.1 ⟨hp, h.2⟩⟩, h.2⟩⟩
  have h4 : (S.filter fun a => ¬ p a).filter (fun a => ¬ q a)
      = S.filter fun a => ¬ p a ∧ ¬ q a := by
    ext a
    simp only [Finset.mem_filter]
    exact ⟨fun h => ⟨h.1.1, h.1.2, h.2⟩, fun h => ⟨⟨h.1, h.2.1⟩, h.2.2⟩⟩
  rw [h3, h4] at h2
  omega



section SplitCrossing

/-- 接続 `Next` と直進 `straight` と軸 `axis` による二つの通過の横断。 -/
def straightCrossing {E V A : Type*} (Next : E → E → Prop) (target : E → V)
    (straight : E → E → Prop) (axis : E → A) (e f e' f' : E) : Prop :=
  Next e f ∧ Next e' f' ∧ target e = target e' ∧ straight e f ∧ straight e' f' ∧ axis e ≠ axis e'

/-- `C^sm` の三条件。 -/
def smoothedCrossingCondition {E V A : Type*} {m : ℕ} (γ : Fin (m + 1) → E) (target : E → V)
    (straight : E → E → Prop) (axis : E → A) (k l r s : Fin (m + 1)) : Prop :=
  target (γ r) = target (γ s) ∧ straight (γ r) (smoothedSuccessorEdge γ k l r) ∧
    straight (γ s) (smoothedSuccessorEdge γ k l s) ∧ axis (γ r) ≠ axis (γ s)

variable {E V A : Type*} {m : ℕ}

theorem smoothedCrossingCondition_symm_necSuf {γ : Fin (m + 1) → E} {target : E → V}
    {straight : E → E → Prop} {axis : E → A} {k l r s : Fin (m + 1)}
    (h : smoothedCrossingCondition γ target straight axis k l r s) :
    smoothedCrossingCondition γ target straight axis k l s r :=
  ⟨h.1.symm, h.2.2.1, h.2.1, Ne.symm h.2.2.2⟩

theorem smoothedCrossingCondition_ne_necSuf {γ : Fin (m + 1) → E} {target : E → V}
    {straight : E → E → Prop} {axis : E → A} {k l r s : Fin (m + 1)}
    (h : smoothedCrossingCondition γ target straight axis k l r s) : r ≠ s := by
  rintro rfl
  exact h.2.2.2 rfl

open Classical in
/-- `C^sm`。 -/
noncomputable def smoothedCrossingPairs (γ : Fin (m + 1) → E) (target : E → V)
    (straight : E → E → Prop) (axis : E → A) (k l : Fin (m + 1)) :
    Finset (Fin (m + 1) × Fin (m + 1)) :=
  (Finset.univ ×ˢ Finset.univ).filter fun p =>
    p.1 < p.2 ∧ smoothedCrossingCondition γ target straight axis k l p.1 p.2

theorem smoothedCrossingNumber_eq_card_necSuf (γ : Fin (m + 1) → E) (target : E → V)
    (straight : E → E → Prop) (axis : E → A) (k l : Fin (m + 1)) :
    smoothedCrossingNumber γ target straight axis k l =
      (smoothedCrossingPairs γ target straight axis k l).card := by
  unfold smoothedCrossingNumber smoothedCrossingPairs smoothedCrossingCondition
  congr 1
  ext p
  simp only [Finset.mem_filter]

open Classical in
/-- 第一の準備: `A`・`B` のちょうど一方に属することによる三分割。 -/
theorem smoothedCrossingPairs_card_partition_necSuf (γ : Fin (m + 1) → E) (target : E → V)
    (straight : E → E → Prop) (axis : E → A) (k l : Fin (m + 1)) :
    (smoothedCrossingPairs γ target straight axis k l).card =
      ((smoothedCrossingPairs γ target straight axis k l).filter fun p =>
          p.1 ∈ smoothingIndexBlockA k l ∧ p.2 ∈ smoothingIndexBlockA k l).card
      + ((smoothedCrossingPairs γ target straight axis k l).filter fun p =>
          p.1 ∈ smoothingIndexBlockB k l ∧ p.2 ∈ smoothingIndexBlockB k l).card
      + ((smoothedCrossingPairs γ target straight axis k l).filter fun p =>
          (p.1 ∈ smoothingIndexBlockA k l ∧ p.2 ∈ smoothingIndexBlockB k l) ∨
            (p.1 ∈ smoothingIndexBlockB k l ∧ p.2 ∈ smoothingIndexBlockA k l)).card := by
  set S := smoothedCrossingPairs γ target straight axis k l
  set A := smoothingIndexBlockA k l
  set B := smoothingIndexBlockB k l
  have hB : ∀ r, r ∈ B ↔ r ∉ A := fun _ => Iff.rfl
  have h1 := Finset.card_filter_add_card_filter_not (s := S)
    (p := fun p : Fin (m + 1) × Fin (m + 1) => p.1 ∈ A ∧ p.2 ∈ A)
  have h2 := Finset.card_filter_add_card_filter_not
    (s := S.filter fun p : Fin (m + 1) × Fin (m + 1) => ¬(p.1 ∈ A ∧ p.2 ∈ A))
    (p := fun p : Fin (m + 1) × Fin (m + 1) => p.1 ∈ B ∧ p.2 ∈ B)
  have h3 : (S.filter fun p : Fin (m + 1) × Fin (m + 1) => ¬(p.1 ∈ A ∧ p.2 ∈ A)).filter
      (fun p => p.1 ∈ B ∧ p.2 ∈ B) = S.filter fun p => p.1 ∈ B ∧ p.2 ∈ B := by
    ext p
    simp only [Finset.mem_filter, hB]
    tauto
  have h4 : (S.filter fun p : Fin (m + 1) × Fin (m + 1) => ¬(p.1 ∈ A ∧ p.2 ∈ A)).filter
      (fun p => ¬(p.1 ∈ B ∧ p.2 ∈ B)) =
        S.filter fun p => (p.1 ∈ A ∧ p.2 ∈ B) ∨ (p.1 ∈ B ∧ p.2 ∈ A) := by
    ext p
    simp only [Finset.mem_filter, hB]
    tauto
  rw [h3, h4] at h2
  omega

theorem cyclicSuccessor_val_necSuf (r : Fin (m + 1)) :
    (cyclicSuccessor r).val = (r.val + 1) % (m + 1) := by
  have h := cyclicSuccessor_mod_necSuf (m := m) r.val
  have hr : (⟨r.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = r :=
    Fin.ext (Nat.mod_eq_of_lt r.isLt)
  rw [hr] at h
  rw [h]

theorem mod_succ_of_lt_double_necSuf {x : ℕ} (hx : x < 2 * (m + 1)) :
    x % (m + 1) = if x < m + 1 then x else x - (m + 1) := by
  split_ifs with h
  · exact Nat.mod_eq_of_lt h
  · rw [Nat.mod_eq_sub_mod (by omega), Nat.mod_eq_of_lt (by omega)]

/-- 第一の区間の位置 `j` が指す添字 `k + 1 + j`。 -/
def splitIndexA (k l : Fin (m + 1)) (j : Fin (l.val - k.val - 1 + 1)) : Fin (m + 1) :=
  ⟨(k.val + 1 + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩

/-- 第二の区間の位置 `j` が指す添字 `l + 1 + j`（剰余で読む）。 -/
def splitIndexB (k l : Fin (m + 1)) (j : Fin (m - l.val + k.val + 1)) : Fin (m + 1) :=
  ⟨(l.val + 1 + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩

theorem splitIndexA_lt_iff_necSuf {k l : Fin (m + 1)} (hkl : k < l)
    (i j : Fin (l.val - k.val - 1 + 1)) :
    splitIndexA k l i < splitIndexA k l j ↔ i < j := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hi := i.isLt
  have hj := j.isLt
  rw [Fin.lt_def, Fin.lt_def]
  simp only [splitIndexA]
  rw [Nat.mod_eq_of_lt (by omega), Nat.mod_eq_of_lt (by omega)]
  omega

theorem splitIndexA_injective_necSuf {k l : Fin (m + 1)} (hkl : k < l) :
    Function.Injective (splitIndexA k l) := by
  intro i j h
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hi := i.isLt
  have hj := j.isLt
  have h' := congrArg Fin.val h
  simp only [splitIndexA] at h'
  rw [Nat.mod_eq_of_lt (by omega), Nat.mod_eq_of_lt (by omega)] at h'
  exact Fin.ext (by omega)

theorem splitIndexA_range_necSuf {k l : Fin (m + 1)} (hkl : k < l) (r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockA k l ↔ ∃ j, splitIndexA k l j = r := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  change (k < r ∧ r ≤ l) ↔ _
  constructor
  · rintro ⟨hkr, hrl⟩
    have hkr' : k.val < r.val := hkr
    have hrl' : r.val ≤ l.val := hrl
    refine ⟨⟨r.val - k.val - 1, by omega⟩, Fin.ext ?_⟩
    simp only [splitIndexA]
    rw [Nat.mod_eq_of_lt (by omega)]
    omega
  · rintro ⟨j, rfl⟩
    have hj := j.isLt
    have hv : (splitIndexA k l j).val = k.val + 1 + j.val := by
      simp only [splitIndexA]
      exact Nat.mod_eq_of_lt (by omega)
    exact ⟨show k.val < _ by omega, show _ ≤ l.val by omega⟩

theorem splitIndexB_injective_necSuf {k l : Fin (m + 1)} (hkl : k < l) :
    Function.Injective (splitIndexB k l) := by
  intro i j h
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hi := i.isLt
  have hj := j.isLt
  have h' := congrArg Fin.val h
  simp only [splitIndexB] at h'
  rw [mod_succ_of_lt_double_necSuf (by omega), mod_succ_of_lt_double_necSuf (by omega)] at h'
  apply Fin.ext
  split_ifs at h' <;> omega

theorem splitIndexB_range_necSuf {k l : Fin (m + 1)} (hkl : k < l) (r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockB k l ↔ ∃ j, splitIndexB k l j = r := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hr := r.isLt
  rw [smoothingIndexBlockB_membership]
  constructor
  · intro hB
    rcases hB with hrk | hlr
    · have hrk' : r.val ≤ k.val := hrk
      refine ⟨⟨m - l.val + r.val, by omega⟩, Fin.ext ?_⟩
      simp only [splitIndexB]
      rw [mod_succ_of_lt_double_necSuf (by omega), if_neg (by omega)]
      omega
    · have hlr' : l.val < r.val := hlr
      refine ⟨⟨r.val - l.val - 1, by omega⟩, Fin.ext ?_⟩
      simp only [splitIndexB]
      rw [Nat.mod_eq_of_lt (by omega)]
      omega
  · rintro ⟨j, rfl⟩
    have hj := j.isLt
    have hv := mod_succ_of_lt_double_necSuf (m := m) (x := l.val + 1 + j.val) (by omega)
    change (splitIndexB k l j) ≤ k ∨ l < splitIndexB k l j
    rw [Fin.le_def, Fin.lt_def]
    simp only [splitIndexB]
    rw [hv]
    split_ifs <;> omega

/-- 第一の区間の位置 `j` の後続は、平滑化後の出辺 `f_{p_A(j)}` である。 -/
theorem splitSegmentA_successor_necSuf (γ : Fin (m + 1) → E) {k l : Fin (m + 1)} (hkl : k < l)
    (j : Fin (l.val - k.val - 1 + 1)) :
    cyclicSegment γ (k.val + 1) (l.val - k.val - 1) (cyclicSuccessor j) =
      smoothedSuccessorEdge γ k l (splitIndexA k l j) := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hj := j.isLt
  have hv : (splitIndexA k l j).val = k.val + 1 + j.val := by
    simp only [splitIndexA]
    exact Nat.mod_eq_of_lt (by omega)
  have hne_k : splitIndexA k l j ≠ k := fun h => by
    have := congrArg Fin.val h
    omega
  change γ (splitIndexA k l (cyclicSuccessor j)) = _
  unfold smoothedSuccessorEdge
  rw [if_neg hne_k]
  by_cases hjn : j.val < l.val - k.val - 1
  · have hne_l : splitIndexA k l j ≠ l := fun h => by
      have := congrArg Fin.val h
      omega
    rw [if_neg hne_l]
    congr 1
    apply Fin.ext
    rw [cyclicSuccessor_val_necSuf]
    simp only [splitIndexA]
    rw [cyclicSuccessor_val_necSuf,
      Nat.mod_eq_of_lt (show j.val + 1 < l.val - k.val - 1 + 1 by omega),
      Nat.mod_eq_of_lt (show k.val + 1 + j.val < m + 1 by omega)]
    rw [Nat.mod_eq_of_lt (show k.val + 1 + (j.val + 1) < m + 1 by omega),
      Nat.mod_eq_of_lt (show k.val + 1 + j.val + 1 < m + 1 by omega)]
    omega
  · have heq_l : splitIndexA k l j = l := Fin.ext (by omega)
    rw [if_pos heq_l]
    congr 1
    apply Fin.ext
    simp only [splitIndexA]
    rw [cyclicSuccessor_val_necSuf, cyclicSuccessor_val_necSuf,
      show j.val + 1 = l.val - k.val - 1 + 1 by omega, Nat.mod_self]

/-- 第二の区間の位置 `j` の後続は、平滑化後の出辺 `f_{p_B(j)}` である。 -/
theorem splitSegmentB_successor_necSuf (γ : Fin (m + 1) → E) {k l : Fin (m + 1)} (hkl : k < l)
    (j : Fin (m - l.val + k.val + 1)) :
    cyclicSegment γ (l.val + 1) (m - l.val + k.val) (cyclicSuccessor j) =
      smoothedSuccessorEdge γ k l (splitIndexB k l j) := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hj := j.isLt
  have hv := mod_succ_of_lt_double_necSuf (m := m) (x := l.val + 1 + j.val) (by omega)
  change γ (splitIndexB k l (cyclicSuccessor j)) = _
  unfold smoothedSuccessorEdge
  by_cases hjn : j.val < m - l.val + k.val
  · have hne_k : splitIndexB k l j ≠ k := fun h => by
      have h' := congrArg Fin.val h
      simp only [splitIndexB] at h'
      rw [hv] at h'
      split_ifs at h' <;> omega
    have hne_l : splitIndexB k l j ≠ l := fun h => by
      have h' := congrArg Fin.val h
      simp only [splitIndexB] at h'
      rw [hv] at h'
      split_ifs at h' <;> omega
    rw [if_neg hne_k, if_neg hne_l]
    congr 1
    apply Fin.ext
    simp only [splitIndexB]
    rw [cyclicSuccessor_val_necSuf, cyclicSuccessor_val_necSuf,
      Nat.mod_eq_of_lt (show j.val + 1 < m - l.val + k.val + 1 by omega)]
    change _ = ((l.val + 1 + j.val) % (m + 1) + 1) % (m + 1)
    rw [Nat.mod_add_mod]
    congr 1
  · have heq_k : splitIndexB k l j = k := by
      apply Fin.ext
      simp only [splitIndexB]
      rw [hv, if_neg (by omega)]
      omega
    rw [if_pos heq_k]
    congr 1
    apply Fin.ext
    simp only [splitIndexB]
    rw [cyclicSuccessor_val_necSuf, cyclicSuccessor_val_necSuf,
      show j.val + 1 = m - l.val + k.val + 1 by omega, Nat.mod_self]

/-- 位置の写像 `p` で読む閉歩道 `δ` の横断は、`p` で写した添字対の三条件に一致する。 -/
theorem indexPairCrossing_iff_of_positions_necSuf (Next : E → E → Prop) (γ : Fin (m + 1) → E)
    (target : E → V) (straight : E → E → Prop) (axis : E → A) {k l : Fin (m + 1)}
    (hexit : ∀ r, Next (γ r) (smoothedSuccessorEdge γ k l r))
    {n : ℕ} (δ : Fin (n + 1) → E) (p : Fin (n + 1) → Fin (m + 1)) (hpos : ∀ j, δ j = γ (p j))
    (hsucc : ∀ j, δ (cyclicSuccessor j) = smoothedSuccessorEdge γ k l (p j)) (i j : Fin (n + 1)) :
    indexPairCrossing (straightCrossing Next target straight axis) δ i j ↔
      smoothedCrossingCondition γ target straight axis k l (p i) (p j) := by
  unfold indexPairCrossing straightCrossing
  rw [hsucc i, hsucc j, hpos i, hpos j]
  constructor
  · rintro ⟨_, _, _, h1, h2, h3, h4⟩
    exact ⟨h1, h2, h3, h4⟩
  · intro h
    exact ⟨fun hij => smoothedCrossingCondition_ne_necSuf h (by rw [hij]),
      hexit _, hexit _, h.1, h.2.1, h.2.2.1, h.2.2.2⟩

open Classical in
/-- `c(γ_A) = |C_AA|`。 -/
theorem closedWalkCrossingNumber_splitSegmentA_necSuf (Next : E → E → Prop) (γ : Fin (m + 1) → E)
    (target : E → V) (straight : E → E → Prop) (axis : E → A) {k l : Fin (m + 1)}
    (hexit : ∀ r, Next (γ r) (smoothedSuccessorEdge γ k l r)) (hkl : k < l) :
    closedWalkCrossingNumber (straightCrossing Next target straight axis)
        (cyclicSegment γ (k.val + 1) (l.val - k.val - 1)) =
      ((smoothedCrossingPairs γ target straight axis k l).filter fun p =>
          p.1 ∈ smoothingIndexBlockA k l ∧ p.2 ∈ smoothingIndexBlockA k l).card := by
  have hiff := indexPairCrossing_iff_of_positions_necSuf Next γ target straight axis hexit
    (cyclicSegment γ (k.val + 1) (l.val - k.val - 1)) (splitIndexA k l) (fun _ => rfl)
    (splitSegmentA_successor_necSuf γ hkl)
  unfold closedWalkCrossingNumber
  apply Finset.card_bij (fun q _ => (splitIndexA k l q.1, splitIndexA k l q.2))
  · intro q hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hq
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and]
    exact ⟨⟨(splitIndexA_lt_iff_necSuf hkl _ _).2 hq.1, (hiff _ _).1 hq.2⟩,
      (splitIndexA_range_necSuf hkl _).2 ⟨_, rfl⟩,
      (splitIndexA_range_necSuf hkl _).2 ⟨_, rfl⟩⟩
  · intro q _ q' _ h
    simp only [Prod.mk.injEq] at h
    exact Prod.ext (splitIndexA_injective_necSuf hkl h.1) (splitIndexA_injective_necSuf hkl h.2)
  · intro r hr
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and] at hr
    obtain ⟨⟨hlt, hc⟩, hrA, hsA⟩ := hr
    obtain ⟨i, hi⟩ := (splitIndexA_range_necSuf hkl r.1).1 hrA
    obtain ⟨j, hj⟩ := (splitIndexA_range_necSuf hkl r.2).1 hsA
    refine ⟨(i, j), ?_, ?_⟩
    · simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
      rw [← hi, ← hj] at hlt hc
      exact ⟨(splitIndexA_lt_iff_necSuf hkl _ _).1 hlt, (hiff _ _).2 hc⟩
    · simp only [hi, hj]

open Classical in
/-- `c(γ_B) = |C_BB|`（順序なし二元集合の全単射）。 -/
theorem closedWalkCrossingNumber_splitSegmentB_necSuf (Next : E → E → Prop) (γ : Fin (m + 1) → E)
    (target : E → V) (straight : E → E → Prop) (axis : E → A) {k l : Fin (m + 1)}
    (hexit : ∀ r, Next (γ r) (smoothedSuccessorEdge γ k l r)) (hkl : k < l) :
    closedWalkCrossingNumber (straightCrossing Next target straight axis)
        (cyclicSegment γ (l.val + 1) (m - l.val + k.val)) =
      ((smoothedCrossingPairs γ target straight axis k l).filter fun p =>
          p.1 ∈ smoothingIndexBlockB k l ∧ p.2 ∈ smoothingIndexBlockB k l).card := by
  have hiff := indexPairCrossing_iff_of_positions_necSuf Next γ target straight axis hexit
    (cyclicSegment γ (l.val + 1) (m - l.val + k.val)) (splitIndexB k l) (fun _ => rfl)
    (splitSegmentB_successor_necSuf γ hkl)
  have hinj := splitIndexB_injective_necSuf (m := m) hkl
  unfold closedWalkCrossingNumber
  apply Finset.card_bij (fun q _ =>
    if splitIndexB k l q.1 < splitIndexB k l q.2 then
      (splitIndexB k l q.1, splitIndexB k l q.2)
    else (splitIndexB k l q.2, splitIndexB k l q.1))
  · intro q hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hq
    have hc := (hiff _ _).1 hq.2
    have hmem1 := (splitIndexB_range_necSuf hkl (splitIndexB k l q.1)).2 ⟨_, rfl⟩
    have hmem2 := (splitIndexB_range_necSuf hkl (splitIndexB k l q.2)).2 ⟨_, rfl⟩
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and]
    split_ifs with hlt
    · exact ⟨⟨hlt, hc⟩, hmem1, hmem2⟩
    · have hne := smoothedCrossingCondition_ne_necSuf hc
      exact ⟨⟨lt_of_le_of_ne (not_lt.mp hlt) (Ne.symm hne),
        smoothedCrossingCondition_symm_necSuf hc⟩, hmem2, hmem1⟩
  · intro q hq q' hq' h
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hq hq'
    split_ifs at h with h1 h2 h2 <;> simp only [Prod.mk.injEq] at h
    · exact Prod.ext (hinj h.1) (hinj h.2)
    · have e1 := hinj h.1
      have e2 := hinj h.2
      exact absurd (hq.1.trans (e2 ▸ hq'.1)) (by rw [e1]; exact lt_irrefl _)
    · have e1 := hinj h.1
      have e2 := hinj h.2
      exact absurd (hq.1.trans (e1 ▸ hq'.1)) (by rw [← e2]; exact lt_irrefl _)
    · exact Prod.ext (hinj h.2) (hinj h.1)
  · intro r hr
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and] at hr
    obtain ⟨⟨hlt, hc⟩, hrB, hsB⟩ := hr
    obtain ⟨i, hi⟩ := (splitIndexB_range_necSuf hkl r.1).1 hrB
    obtain ⟨j, hj⟩ := (splitIndexB_range_necSuf hkl r.2).1 hsB
    have hij : i ≠ j := fun h => by
      subst h
      rw [hi] at hj
      rw [hj] at hlt
      exact lt_irrefl _ hlt
    rcases lt_or_gt_of_ne hij with hij' | hij'
    · refine ⟨(i, j), ?_, ?_⟩
      · simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
        rw [← hi, ← hj] at hc
        exact ⟨hij', (hiff _ _).2 hc⟩
      · simp only
        rw [if_pos (by rw [hi, hj]; exact hlt), hi, hj]
    · refine ⟨(j, i), ?_, ?_⟩
      · simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
        rw [← hi, ← hj] at hc
        exact ⟨hij', (hiff _ _).2 (smoothedCrossingCondition_symm_necSuf hc)⟩
      · simp only
        rw [if_neg (by rw [hi, hj]; exact not_lt.mpr hlt.le), hi, hj]

open Classical in
/-- 第三の準備: `C_×` の対を、`A` に属する側を第一成分に置き直す全単射。 -/
theorem splitMutualCrossingNumber_eq_mixed_necSuf (γ : Fin (m + 1) → E) (target : E → V)
    (straight : E → E → Prop) (axis : E → A) (k l : Fin (m + 1)) :
    splitMutualCrossingNumber γ target straight axis k l =
      ((smoothedCrossingPairs γ target straight axis k l).filter fun p =>
          (p.1 ∈ smoothingIndexBlockA k l ∧ p.2 ∈ smoothingIndexBlockB k l) ∨
            (p.1 ∈ smoothingIndexBlockB k l ∧ p.2 ∈ smoothingIndexBlockA k l)).card := by
  have hB : ∀ r, r ∈ smoothingIndexBlockB k l ↔ r ∉ smoothingIndexBlockA k l := fun _ => Iff.rfl
  unfold splitMutualCrossingNumber
  symm
  apply Finset.card_bij (fun q _ =>
    if q.1 ∈ smoothingIndexBlockA k l then (q.1, q.2) else (q.2, q.1))
  · intro q hq
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and, hB] at hq
    obtain ⟨⟨_, hc⟩, hmix⟩ := hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and, hB]
    split_ifs with h1
    · exact ⟨h1, by tauto, hc⟩
    · have hc' := smoothedCrossingCondition_symm_necSuf hc
      exact ⟨by tauto, h1, hc'⟩
  · intro q hq q' hq' h
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and] at hq hq'
    split_ifs at h with h1 h2 h2 <;> simp only [Prod.mk.injEq] at h
    · exact Prod.ext h.1 h.2
    · exact absurd (hq.1.1.trans (h.2 ▸ hq'.1.1)) (by rw [h.1]; exact lt_irrefl _)
    · exact absurd (hq.1.1.trans (h.1 ▸ hq'.1.1)) (by rw [← h.2]; exact lt_irrefl _)
    · exact Prod.ext h.2 h.1
  · intro r hr
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hr
    obtain ⟨hrA, hsB, hc'⟩ := hr
    have hc : smoothedCrossingCondition γ target straight axis k l r.1 r.2 := hc'
    have hne := smoothedCrossingCondition_ne_necSuf hc
    have hsA : r.2 ∉ smoothingIndexBlockA k l := hsB
    rcases lt_or_gt_of_ne hne with hlt | hlt
    · refine ⟨(r.1, r.2), ?_, ?_⟩
      · simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
          true_and]
        exact ⟨⟨hlt, hc⟩, Or.inl ⟨hrA, hsB⟩⟩
      · simp only [if_pos hrA]
    · refine ⟨(r.2, r.1), ?_, ?_⟩
      · simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
          true_and]
        exact ⟨⟨hlt, smoothedCrossingCondition_symm_necSuf hc⟩, Or.inr ⟨hsB, hrA⟩⟩
      · simp only [if_neg hsA]

/-- 「平滑化後の横断数は二本の閉歩道の横断数と混合横断数の和である」の必要十分版。 -/
theorem smoothing_split_crossing_partition_necSuf (Next : E → E → Prop) (γ : Fin (m + 1) → E)
    (target : E → V) (straight : E → E → Prop) (axis : E → A) {k l : Fin (m + 1)}
    (hexit : ∀ r, Next (γ r) (smoothedSuccessorEdge γ k l r)) (hkl : k < l) :
    closedWalkCrossingNumber (straightCrossing Next target straight axis)
        (cyclicSegment γ (k.val + 1) (l.val - k.val - 1))
      + closedWalkCrossingNumber (straightCrossing Next target straight axis)
          (cyclicSegment γ (l.val + 1) (m - l.val + k.val))
      + splitMutualCrossingNumber γ target straight axis k l =
      smoothedCrossingNumber γ target straight axis k l := by
  rw [closedWalkCrossingNumber_splitSegmentA_necSuf Next γ target straight axis hexit hkl,
    closedWalkCrossingNumber_splitSegmentB_necSuf Next γ target straight axis hexit hkl,
    splitMutualCrossingNumber_eq_mixed_necSuf γ target straight axis k l,
    smoothedCrossingNumber_eq_card_necSuf γ target straight axis k l,
    smoothedCrossingPairs_card_partition_necSuf γ target straight axis k l]

end SplitCrossing

end Ising2DLambda.NecSuf.KacWard
