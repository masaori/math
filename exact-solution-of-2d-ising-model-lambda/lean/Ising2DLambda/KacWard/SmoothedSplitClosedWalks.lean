/-
「横断の平滑化は二本の閉じた非後退辺列に分ける」（`claim_smoothing_splits_closed_walk`）を、
実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` と横断する添字 `k < l` について述べる具体版。
本文の添字 `r ∈ I_{m+1}` は Lean の `r - 1`（`closedWalkTextIndex`）。

人手証明との対応:
- `def_smoothed_cyclic_total_turning` の冒頭「`r = k` の場合」の確認（始点は横断の頂点の一致から、
  反転でないことは背理法: 反転なら方向番号が二ずれて軸が同じになり、直進の `γ_l → γ_{σ(l)}` と
  合わせて二つの軸が一致する）: `swappedExit_mem_nonbacktrackingSuccessors`。
  `r = l` の場合は対称: `swappedExit_mem_nonbacktrackingSuccessors'`。三つの場合をまとめたものが
  `smoothedExitEdge_mem_nonbacktrackingSuccessors`。
- `def_smoothed_split_edge_sequences` の二本の辺列 `γ_A = (e_{k+1}, …, e_l)`、
  `γ_B = (e_{l+1}, …, e_m, e_1, …, e_k)`: 剰余で添字を読む区間 `closedWalkSegment` で
  `smoothedSplitWalkA`・`smoothedSplitWalkB` と定める（`l = m` の場合分けは剰余が吸収する）。
  位置から添字への写像 `smoothedSplitIndexA`・`smoothedSplitIndexB` が単射で、像がそれぞれ
  `def_smoothing_index_blocks` の `A`・`B` であること（二本が `A`・`B` を一度ずつ尽くすこと）。
- 証明の「内部の連続は元の非後退接続である」: `closedWalkSegment_closed` の第一成分
  （`closedWalkSuccessor_mod` で剰余の一つ先が巡回後続であることを使う）。
- 「`f_l = e_{k+1}` なので `γ_A` は閉じる」「`f_k = e_{σ(l)}` なので `γ_B` も閉じる」:
  `smoothedSplitWalkA_closed`・`smoothedSplitWalkB_closed`。
-/
import Ising2DLambda.KacWard.SmoothedSplitEdgeSequences
import Ising2DLambda.KacWard.DisjointWalkMutualCrossing
import Ising2DLambda.NecSuf.KacWard.SmoothedSplitClosedWalks

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- 方向番号を二つずらしても軸は変わらない。 -/
theorem directionAxis_add_two (d : ZMod 4) : directionAxis (d + 2) = directionAxis d := by
  revert d
  decide

section Swapped

variable {L : ℕ} [NeZero L]

/-- 横断 `(e → f, e' → f')` で、`e` の出辺を `f'` に付け替えた接続は非後退である。 -/
theorem swappedExit_mem_nonbacktrackingSuccessors {e f e' f' : OrientedEdge L}
    (h : edgeTransverseCrossing e f e' f') : f' ∈ nonbacktrackingSuccessors e := by
  obtain ⟨_, hf', htgt, _, hst', hax⟩ := h
  have hf'' := Finset.mem_filter.mp hf'
  refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, htgt.trans hf''.2.1, fun hrev => hax ?_⟩
  calc directionAxis (directionNumber e)
      = directionAxis (directionNumber e + 2) := (directionAxis_add_two _).symm
    _ = directionAxis (directionNumber (reversal e)) := by rw [directionNumber_reversal]
    _ = directionAxis (directionNumber f') := by rw [hrev]
    _ = directionAxis (directionNumber e') := by
        rw [(stepTurning_eq_zero_iff e' f' hf').1 hst']

/-- 対称な場合: `e'` の出辺を `f` に付け替えた接続も非後退である。 -/
theorem swappedExit_mem_nonbacktrackingSuccessors' {e f e' f' : OrientedEdge L}
    (h : edgeTransverseCrossing e f e' f') : f ∈ nonbacktrackingSuccessors e' := by
  obtain ⟨hf, hf', htgt, hst, hst', hax⟩ := h
  exact swappedExit_mem_nonbacktrackingSuccessors
    ⟨hf', hf, htgt.symm, hst', hst, Ne.symm hax⟩

/-- 平滑化後の出辺はどの添字でも非後退接続である（`def_smoothed_cyclic_total_turning` の冒頭）。 -/
theorem smoothedExitEdge_mem_nonbacktrackingSuccessors {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l) (r : Fin (m + 1)) :
    smoothedExitEdge γ k l r ∈ nonbacktrackingSuccessors (γ r) := by
  unfold smoothedExitEdge
  by_cases hrk : r = k
  · subst hrk
    rw [if_pos rfl]
    exact swappedExit_mem_nonbacktrackingSuccessors hcross.2
  · rw [if_neg hrk]
    by_cases hrl : r = l
    · subst hrl
      rw [if_pos rfl]
      exact swappedExit_mem_nonbacktrackingSuccessors' hcross.2
    · rw [if_neg hrl]
      exact closedWalkPass_valid γ hγ r

theorem swappedExit_mem_nonbacktrackingSuccessors_from_necSuf {e f e' f' : OrientedEdge L}
    (h : edgeTransverseCrossing e f e' f') : f' ∈ nonbacktrackingSuccessors e := by
  obtain ⟨_, hf', htgt, _, hst', hax⟩ := h
  have hf'' := Finset.mem_filter.mp hf'
  have hstraight : ∀ a b : OrientedEdge L, orientedSource b = orientedTarget a →
      b ≠ reversal a → stepTurning a b = 0 → directionNumber b = directionNumber a :=
    fun a b hs hr ht => (stepTurning_eq_zero_iff a b
      (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hs.symm, hr⟩)).1 ht
  have h := Ising2DLambda.NecSuf.KacWard.swappedExit_next_necSuf
    orientedSource orientedTarget reversal directionNumber (· + 2) directionAxis
    (fun a b => stepTurning a b = 0) directionNumber_reversal directionAxis_add_two
    hstraight htgt hf''.2.1.symm hf''.2.2 hst' hax
  exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, h.1.symm, h.2⟩

end Swapped

section Segment

variable {L m : ℕ}

/-- 剰余で読んだ添字の巡回後続は、一つ先の剰余である。 -/
theorem closedWalkSuccessor_mod (x : ℕ) :
    closedWalkSuccessor (⟨x % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) =
      ⟨(x + 1) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ := by
  have hlt : x % (m + 1) < m + 1 := Nat.mod_lt _ (Nat.succ_pos m)
  have hadd : (x + 1) % (m + 1) = (x % (m + 1) + 1) % (m + 1) := by
    rw [Nat.add_comm (x % (m + 1)) 1, Nat.add_mod_mod, Nat.add_comm]
  unfold closedWalkSuccessor
  split_ifs with h
  · have h' : x % (m + 1) < m := h
    apply Fin.ext
    change x % (m + 1) + 1 = (x + 1) % (m + 1)
    rw [hadd, Nat.mod_eq_of_lt (show x % (m + 1) + 1 < m + 1 by omega)]
  · have h' : ¬ x % (m + 1) < m := h
    have hm : x % (m + 1) = m := by omega
    apply Fin.ext
    change 0 = (x + 1) % (m + 1)
    rw [hadd, hm, Nat.mod_self]

/-- 閉歩道の区間 `(e_s, e_{s+1}, …, e_{s+n})`（Lean の添字を剰余で読む）。 -/
def closedWalkSegment (γ : Fin (m + 1) → OrientedEdge L) (s n : ℕ) :
    Fin (n + 1) → OrientedEdge L :=
  fun j => γ ⟨(s + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩

/-- 閉歩道の区間は、終辺から始辺への接続が非後退なら閉じた非後退辺列である。
内部の接続は元の歩道の通過である。 -/
theorem closedWalkSegment_closed (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (s n : ℕ)
    (hclose : γ ⟨s % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ ∈
      nonbacktrackingSuccessors (γ ⟨(s + n) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩)) :
    closedNonbacktrackingWalk (closedWalkSegment γ s n) := by
  refine ⟨fun j => ?_, ?_⟩
  · have h := closedWalkPass_valid γ hγ ⟨(s + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩
    simp only [closedWalkPass] at h
    rw [closedWalkSuccessor_mod] at h
    simpa [closedWalkSegment, Nat.add_assoc] using h
  · simpa [closedWalkSegment] using hclose

theorem closedWalkSegment_from_necSuf (γ : Fin (m + 1) → OrientedEdge L) (s n : ℕ) :
    closedWalkSegment γ s n = Ising2DLambda.NecSuf.KacWard.cyclicSegment γ s n := rfl

theorem closedWalkSegment_closed_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (s n : ℕ)
    (hclose : γ ⟨s % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ ∈
      nonbacktrackingSuccessors (γ ⟨(s + n) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩)) :
    closedNonbacktrackingWalk (closedWalkSegment γ s n) :=
  Ising2DLambda.NecSuf.KacWard.cyclicSegment_closed_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) γ
    (fun r => closedWalkPass_valid γ hγ r) s n hclose

end Segment

section Split

variable {L m : ℕ}

/-- `γ_A` の位置 `j`（零始まり）が指す `γ` の添字 `k + 1 + j`。 -/
def smoothedSplitIndexA (k l : Fin (m + 1)) (j : Fin (l.val - k.val - 1 + 1)) : Fin (m + 1) :=
  ⟨(k.val + 1 + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩

/-- `γ_B` の位置 `j`（零始まり）が指す `γ` の添字 `l + 1 + j`（剰余で読む）。 -/
def smoothedSplitIndexB (k l : Fin (m + 1)) (j : Fin (m - l.val + k.val + 1)) : Fin (m + 1) :=
  ⟨(l.val + 1 + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩

/-- `def_smoothed_split_edge_sequences` の `γ_A = (e_{k+1}, …, e_l)`。 -/
def smoothedSplitWalkA (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    Fin (l.val - k.val - 1 + 1) → OrientedEdge L :=
  closedWalkSegment γ (k.val + 1) (l.val - k.val - 1)

/-- `def_smoothed_split_edge_sequences` の `γ_B = (e_{l+1}, …, e_m, e_1, …, e_k)`。 -/
def smoothedSplitWalkB (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    Fin (m - l.val + k.val + 1) → OrientedEdge L :=
  closedWalkSegment γ (l.val + 1) (m - l.val + k.val)

theorem smoothedSplitWalkA_apply (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) (j : Fin (l.val - k.val - 1 + 1)) :
    smoothedSplitWalkA γ hγ k l j = γ (smoothedSplitIndexA k l j) := rfl

theorem smoothedSplitWalkB_apply (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) (j : Fin (m - l.val + k.val + 1)) :
    smoothedSplitWalkB γ hγ k l j = γ (smoothedSplitIndexB k l j) := rfl

/-- `x < 2(m+1)` なら `x mod (m+1)` は `x` か `x - (m+1)`。 -/
theorem mod_succ_of_lt_double {x : ℕ} (hx : x < 2 * (m + 1)) :
    x % (m + 1) = if x < m + 1 then x else x - (m + 1) := by
  split_ifs with h
  · exact Nat.mod_eq_of_lt h
  · rw [Nat.mod_eq_sub_mod (by omega), Nat.mod_eq_of_lt (by omega)]

/-- `γ_A` の位置から添字への写像は単射である。 -/
theorem smoothedSplitIndexA_injective {k l : Fin (m + 1)} (hkl : k < l) :
    Function.Injective (smoothedSplitIndexA k l) := by
  intro i j h
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hi := i.isLt
  have hj := j.isLt
  have h' := congrArg Fin.val h
  simp only [smoothedSplitIndexA] at h'
  rw [Nat.mod_eq_of_lt (by omega), Nat.mod_eq_of_lt (by omega)] at h'
  exact Fin.ext (by omega)

/-- `γ_A` の位置から添字への写像の像は `A` である。 -/
theorem smoothedSplitIndexA_range (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) (r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockA γ hγ k l ↔ ∃ j, smoothedSplitIndexA k l j = r := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  change ((closedWalkTextIndex k).val < (closedWalkTextIndex r).val ∧
    (closedWalkTextIndex r).val ≤ (closedWalkTextIndex l).val) ↔ _
  rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]
  constructor
  · rintro ⟨hkr, hrl⟩
    have hkr' : k.val < r.val := hkr
    have hrl' : r.val ≤ l.val := hrl
    refine ⟨⟨r.val - k.val - 1, by omega⟩, Fin.ext ?_⟩
    simp only [smoothedSplitIndexA]
    rw [Nat.mod_eq_of_lt (by omega)]
    omega
  · rintro ⟨j, rfl⟩
    have hj := j.isLt
    have hv : (smoothedSplitIndexA k l j).val = k.val + 1 + j.val := by
      simp only [smoothedSplitIndexA]
      exact Nat.mod_eq_of_lt (by omega)
    exact ⟨show k.val < _ by omega, show _ ≤ l.val by omega⟩

/-- `γ_B` の位置から添字への写像は単射である。 -/
theorem smoothedSplitIndexB_injective {k l : Fin (m + 1)} (hkl : k < l) :
    Function.Injective (smoothedSplitIndexB k l) := by
  intro i j h
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hi := i.isLt
  have hj := j.isLt
  have h' := congrArg Fin.val h
  simp only [smoothedSplitIndexB] at h'
  rw [mod_succ_of_lt_double (by omega), mod_succ_of_lt_double (by omega)] at h'
  apply Fin.ext
  split_ifs at h' <;> omega

/-- `γ_B` の位置から添字への写像の像は `B` である。 -/
theorem smoothedSplitIndexB_range (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) (r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockB γ hγ k l ↔ ∃ j, smoothedSplitIndexB k l j = r := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hr := r.isLt
  rw [smoothingIndexBlockB_membership]
  constructor
  · intro hB
    rcases hB with hrk | hlr
    · have hrk' : r.val ≤ k.val := hrk
      refine ⟨⟨m - l.val + r.val, by omega⟩, Fin.ext ?_⟩
      simp only [smoothedSplitIndexB]
      rw [mod_succ_of_lt_double (by omega), if_neg (by omega)]
      omega
    · have hlr' : l.val < r.val := hlr
      refine ⟨⟨r.val - l.val - 1, by omega⟩, Fin.ext ?_⟩
      simp only [smoothedSplitIndexB]
      rw [Nat.mod_eq_of_lt (by omega)]
      omega
  · rintro ⟨j, rfl⟩
    have hj := j.isLt
    have hv := mod_succ_of_lt_double (m := m) (x := l.val + 1 + j.val) (by omega)
    change (smoothedSplitIndexB k l j) ≤ k ∨ l < smoothedSplitIndexB k l j
    rw [Fin.le_def, Fin.lt_def]
    simp only [smoothedSplitIndexB]
    rw [hv]
    split_ifs <;> omega

theorem smoothedSplitWalkA_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedSplitWalkA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.cyclicSegment γ (k.val + 1) (l.val - k.val - 1) := rfl

theorem smoothedSplitWalkB_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedSplitWalkB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.cyclicSegment γ (l.val + 1) (m - l.val + k.val) := rfl

variable [NeZero L]

/-- `γ_A` は閉じた非後退辺列である（終辺 `e_l` から始辺 `e_{k+1}` へは付け替えた接続 `f_l`）。 -/
theorem smoothedSplitWalkA_closed (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    closedNonbacktrackingWalk (smoothedSplitWalkA γ hγ k l) := by
  apply closedWalkSegment_closed γ hγ
  have hk' : k.val < l.val := hkl
  have hk : (⟨k.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = k :=
    Fin.ext (Nat.mod_eq_of_lt k.isLt)
  have hsucc := closedWalkSuccessor_mod (m := m) k.val
  rw [hk] at hsucc
  have hlast : (⟨(k.val + 1 + (l.val - k.val - 1)) % (m + 1),
      Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = l := by
    apply Fin.ext
    simp only
    rw [show k.val + 1 + (l.val - k.val - 1) = l.val by omega]
    exact Nat.mod_eq_of_lt l.isLt
  rw [hlast, ← hsucc]
  exact swappedExit_mem_nonbacktrackingSuccessors' hcross.2

/-- `γ_B` は閉じた非後退辺列である（終辺 `e_k` から始辺 `e_{σ(l)}` へは付け替えた接続 `f_k`）。 -/
theorem smoothedSplitWalkB_closed (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    closedNonbacktrackingWalk (smoothedSplitWalkB γ hγ k l) := by
  apply closedWalkSegment_closed γ hγ
  have hk' : k.val < l.val := hkl
  have hl' := l.isLt
  have hl : (⟨l.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = l :=
    Fin.ext (Nat.mod_eq_of_lt l.isLt)
  have hsucc := closedWalkSuccessor_mod (m := m) l.val
  rw [hl] at hsucc
  have hlast : (⟨(l.val + 1 + (m - l.val + k.val)) % (m + 1),
      Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = k := by
    apply Fin.ext
    simp only
    rw [show l.val + 1 + (m - l.val + k.val) = (m + 1) + k.val by omega, Nat.add_mod_left]
    exact Nat.mod_eq_of_lt k.isLt
  rw [hlast, ← hsucc]
  exact swappedExit_mem_nonbacktrackingSuccessors hcross.2

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothedSplitWalks_closed_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    closedNonbacktrackingWalk (smoothedSplitWalkA γ hγ k l) ∧
      closedNonbacktrackingWalk (smoothedSplitWalkB γ hγ k l) :=
  Ising2DLambda.NecSuf.KacWard.smoothedSplitSegments_closed_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) γ
    (fun r => closedWalkPass_valid γ hγ r) hkl
    (swappedExit_mem_nonbacktrackingSuccessors hcross.2)
    (swappedExit_mem_nonbacktrackingSuccessors' hcross.2)

end Split

end Ising2DLambda.KacWard
