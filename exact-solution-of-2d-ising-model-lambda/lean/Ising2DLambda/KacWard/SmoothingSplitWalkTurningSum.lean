/-
「二本の閉歩道の循環総回転数の和は元の循環総回転数に等しい」（`claim_smoothing_split_turning_sum`）の
二つの準備と合併の段を、実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` と横断する添字
`k < l` について述べる具体版。住処は ℤ（一歩の回転数の有限和）で、ℝ / ℂ は現れない。
本文の添字 `r ∈ I_{m+1}` は Lean の `r - 1`（`closedWalkTextIndex`）。`τ(e_r, f_r)` は
`stepTurning (γ r) (smoothedExitEdge γ k l r)`。

人手証明との対応:
- 第一の準備の一行目・二行目「`t_∘(γ_A) = t(γ_A) + τ(e_l, e_{k+1})`」「`= Σ_s τ(e_{k+s}, e_{k+s+1}) + …`」:
  `cyclicTotalTurning_eq`・`edgeSequenceTotalTurning_eq`。
- 三行目・四行目「添字の置換 `r = k + s`」「`claim_smoothing_splits_closed_walk` の各接続」:
  位置 `j` の項が添字 `smoothedSplitIndexA k l j` の項 `τ(e_r, f_r)` に等しいこと
  （内部の位置は `smoothedSplitWalkA_inner_turning`、閉じる位置は `smoothedSplitWalkA_closing_turning`）。
  Lean では接続の書き換えを先に、添字の置換（単射 `smoothedSplitIndexA_injective` と像
  `smoothedSplitIndexA_range` による和の移し替え）を後に行う。
- 五行目「`A` と有限和の項の合併」: `Fin.sum_univ_castSucc` と `Finset.sum_image`
  （`smoothedSplitWalkA_cyclicTotalTurning`）。
- 第二の準備（`γ_B`）も同じ形（`smoothedSplitWalkB_*`）。本文の `l < m` と `l = m` の場合分けは、
  添字を剰余で読む区間が吸収する（位置の値の場合分けは `mod_succ_of_lt_double`）。
- 合わせる段の一行目・二行目「準備の二式」「`B = I_m \ A` と互いに素な有限和の分割」と
  三行目「`= t_sm(γ; k, l)`（`def_smoothed_cyclic_total_turning`）」:
  `smoothing_split_walk_turning_sum`。
- 最後の行「`= t_∘(γ)`（`claim_smoothing_cyclic_turning_invariance`）」はこのファイルの外である。
  その主張の具体版は局所データの列について述べているので、実際の閉歩道への当てはめを別に置く。
-/
import Ising2DLambda.KacWard.SmoothedSplitClosedWalks
import Ising2DLambda.KacWard.SmoothedCyclicTotalTurning
import Ising2DLambda.KacWard.CyclicTotalTurning
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitWalkTurningSum

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L m : ℕ}

/-- 区間の一つ先の位置の辺は、その位置が指す添字の巡回後続の辺である。 -/
theorem closedWalkSegment_succ (γ : Fin (m + 1) → OrientedEdge L) (s n : ℕ) (j : Fin n) :
    closedWalkSegment γ s n j.succ =
      γ (closedWalkSuccessor ⟨(s + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩) := by
  rw [closedWalkSuccessor_mod]
  simp [closedWalkSegment, Nat.add_assoc]

/-- 選んだ二添字以外では、平滑化後の出辺は元の巡回後続の辺である。 -/
theorem smoothedExitEdge_of_ne (γ : Fin (m + 1) → OrientedEdge L) {k l r : Fin (m + 1)}
    (hrk : r ≠ k) (hrl : r ≠ l) :
    smoothedExitEdge γ k l r = γ (closedWalkSuccessor r) := by
  unfold smoothedExitEdge
  rw [if_neg hrk, if_neg hrl]

/-- `γ_A` の内部の位置 `j` の一歩は、添字 `k + 1 + j` の項 `τ(e_r, f_r)` である。 -/
theorem smoothedSplitWalkA_inner_turning (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l)
    (j : Fin (l.val - k.val - 1)) :
    stepTurning (smoothedSplitWalkA γ hγ k l j.castSucc) (smoothedSplitWalkA γ hγ k l j.succ)
      = stepTurning (γ (smoothedSplitIndexA k l j.castSucc))
          (smoothedExitEdge γ k l (smoothedSplitIndexA k l j.castSucc)) := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hj := j.isLt
  have hv : (smoothedSplitIndexA k l j.castSucc).val = k.val + 1 + j.val := by
    simp only [smoothedSplitIndexA, Fin.val_castSucc]
    exact Nat.mod_eq_of_lt (by omega)
  have hrk : smoothedSplitIndexA k l j.castSucc ≠ k := fun h => by
    have := congrArg Fin.val h; omega
  have hrl : smoothedSplitIndexA k l j.castSucc ≠ l := fun h => by
    have := congrArg Fin.val h; omega
  rw [smoothedExitEdge_of_ne γ hrk hrl, smoothedSplitWalkA_apply]
  exact congrArg _ (closedWalkSegment_succ γ (k.val + 1) (l.val - k.val - 1) j)

/-- `γ_A` の閉じる一歩（末辺 `e_l` から始辺 `e_{k+1}`）は、添字 `l` の項 `τ(e_l, f_l)` である。 -/
theorem smoothedSplitWalkA_closing_turning (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    stepTurning (smoothedSplitWalkA γ hγ k l (Fin.last _)) (smoothedSplitWalkA γ hγ k l 0)
      = stepTurning (γ (smoothedSplitIndexA k l (Fin.last _)))
          (smoothedExitEdge γ k l (smoothedSplitIndexA k l (Fin.last _))) := by
  have hk : k.val < l.val := hkl
  have hlast : smoothedSplitIndexA k l (Fin.last _) = l := by
    apply Fin.ext
    simp only [smoothedSplitIndexA, Fin.val_last]
    rw [show k.val + 1 + (l.val - k.val - 1) = l.val by omega]
    exact Nat.mod_eq_of_lt l.isLt
  have hfirst : smoothedSplitWalkA γ hγ k l 0 = γ (closedWalkSuccessor k) := by
    have hsucc := closedWalkSuccessor_mod (m := m) k.val
    rw [show (⟨k.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = k from
      Fin.ext (Nat.mod_eq_of_lt k.isLt)] at hsucc
    rw [hsucc]
    simp [smoothedSplitWalkA, closedWalkSegment]
  have hexit : smoothedExitEdge γ k l l = γ (closedWalkSuccessor k) := by
    unfold smoothedExitEdge
    rw [if_neg (Fin.ne_of_gt hkl), if_pos rfl]
  rw [hlast, hfirst, hexit, smoothedSplitWalkA_apply, hlast]

/-- `γ_B` の内部の位置 `j` の一歩は、添字 `l + 1 + j`（剰余で読む）の項 `τ(e_r, f_r)` である。 -/
theorem smoothedSplitWalkB_inner_turning (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l)
    (j : Fin (m - l.val + k.val)) :
    stepTurning (smoothedSplitWalkB γ hγ k l j.castSucc) (smoothedSplitWalkB γ hγ k l j.succ)
      = stepTurning (γ (smoothedSplitIndexB k l j.castSucc))
          (smoothedExitEdge γ k l (smoothedSplitIndexB k l j.castSucc)) := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hj := j.isLt
  have hv := mod_succ_of_lt_double (m := m) (x := l.val + 1 + j.val) (by omega)
  have hval : (smoothedSplitIndexB k l j.castSucc).val = (l.val + 1 + j.val) % (m + 1) := by
    simp only [smoothedSplitIndexB, Fin.val_castSucc]
  have hrk : smoothedSplitIndexB k l j.castSucc ≠ k := fun h => by
    have := congrArg Fin.val h
    rw [hval, hv] at this
    split_ifs at this <;> omega
  have hrl : smoothedSplitIndexB k l j.castSucc ≠ l := fun h => by
    have := congrArg Fin.val h
    rw [hval, hv] at this
    split_ifs at this <;> omega
  rw [smoothedExitEdge_of_ne γ hrk hrl, smoothedSplitWalkB_apply]
  exact congrArg _ (closedWalkSegment_succ γ (l.val + 1) (m - l.val + k.val) j)

/-- `γ_B` の閉じる一歩（末辺 `e_k` から始辺 `e_{σ(l)}`）は、添字 `k` の項 `τ(e_k, f_k)` である。 -/
theorem smoothedSplitWalkB_closing_turning (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    stepTurning (smoothedSplitWalkB γ hγ k l (Fin.last _)) (smoothedSplitWalkB γ hγ k l 0)
      = stepTurning (γ (smoothedSplitIndexB k l (Fin.last _)))
          (smoothedExitEdge γ k l (smoothedSplitIndexB k l (Fin.last _))) := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hlast : smoothedSplitIndexB k l (Fin.last _) = k := by
    apply Fin.ext
    simp only [smoothedSplitIndexB, Fin.val_last]
    rw [show l.val + 1 + (m - l.val + k.val) = (m + 1) + k.val by omega, Nat.add_mod_left]
    exact Nat.mod_eq_of_lt k.isLt
  have hfirst : smoothedSplitWalkB γ hγ k l 0 = γ (closedWalkSuccessor l) := by
    have hsucc := closedWalkSuccessor_mod (m := m) l.val
    rw [show (⟨l.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = l from
      Fin.ext (Nat.mod_eq_of_lt l.isLt)] at hsucc
    rw [hsucc]
    simp [smoothedSplitWalkB, closedWalkSegment]
  have hexit : smoothedExitEdge γ k l k = γ (closedWalkSuccessor l) := by
    unfold smoothedExitEdge
    rw [if_pos rfl]
  rw [hlast, hfirst, hexit, smoothedSplitWalkB_apply, hlast]

open Classical in
/-- `γ_A` の位置から添字への写像の像は、有限集合として `A` である。 -/
theorem smoothedSplitIndexA_image (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    univ.image (smoothedSplitIndexA k l) =
      univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l) := by
  ext r
  simp only [mem_image, mem_univ, true_and, mem_filter]
  exact (smoothedSplitIndexA_range γ hγ hkl r).symm

open Classical in
/-- `γ_B` の位置から添字への写像の像は、有限集合として `B = I_m \ A` である。 -/
theorem smoothedSplitIndexB_image (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    univ.image (smoothedSplitIndexB k l) =
      (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))ᶜ := by
  ext r
  simp only [mem_image, mem_univ, true_and, mem_compl, mem_filter]
  exact (smoothedSplitIndexB_range γ hγ hkl r).symm

variable [NeZero L]

open Classical in
/-- 第一の準備: `t_∘(γ_A) = Σ_{r ∈ A} τ(e_r, f_r)`。 -/
theorem smoothedSplitWalkA_cyclicTotalTurning (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      = ∑ r ∈ univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l),
          stepTurning (γ r) (smoothedExitEdge γ k l r) := by
  calc cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      = (∑ j : Fin (l.val - k.val - 1),
            stepTurning (smoothedSplitWalkA γ hγ k l j.castSucc)
              (smoothedSplitWalkA γ hγ k l j.succ))
          + stepTurning (smoothedSplitWalkA γ hγ k l (Fin.last _))
              (smoothedSplitWalkA γ hγ k l 0) := by
        rw [cyclicTotalTurning_eq, edgeSequenceTotalTurning_eq]
    _ = (∑ j : Fin (l.val - k.val - 1),
            stepTurning (γ (smoothedSplitIndexA k l j.castSucc))
              (smoothedExitEdge γ k l (smoothedSplitIndexA k l j.castSucc)))
          + stepTurning (γ (smoothedSplitIndexA k l (Fin.last _)))
              (smoothedExitEdge γ k l (smoothedSplitIndexA k l (Fin.last _))) := by
        rw [Finset.sum_congr rfl (fun j _ => smoothedSplitWalkA_inner_turning γ hγ hkl j),
          smoothedSplitWalkA_closing_turning γ hγ hkl]
    _ = ∑ j : Fin (l.val - k.val - 1 + 1),
          stepTurning (γ (smoothedSplitIndexA k l j))
            (smoothedExitEdge γ k l (smoothedSplitIndexA k l j)) := by
        rw [Fin.sum_univ_castSucc]
    _ = ∑ r ∈ univ.image (smoothedSplitIndexA k l),
          stepTurning (γ r) (smoothedExitEdge γ k l r) := by
        rw [Finset.sum_image (fun x _ y _ h => smoothedSplitIndexA_injective hkl h)]
    _ = ∑ r ∈ univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l),
          stepTurning (γ r) (smoothedExitEdge γ k l r) := by
        rw [smoothedSplitIndexA_image γ hγ hkl]

open Classical in
/-- 第二の準備: `t_∘(γ_B) = Σ_{r ∈ B} τ(e_r, f_r)`。 -/
theorem smoothedSplitWalkB_cyclicTotalTurning (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    cyclicTotalTurning (smoothedSplitWalkB γ hγ k l) (smoothedSplitWalkB_closed γ hγ hcross hkl)
      = ∑ r ∈ (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))ᶜ,
          stepTurning (γ r) (smoothedExitEdge γ k l r) := by
  calc cyclicTotalTurning (smoothedSplitWalkB γ hγ k l) (smoothedSplitWalkB_closed γ hγ hcross hkl)
      = (∑ j : Fin (m - l.val + k.val),
            stepTurning (smoothedSplitWalkB γ hγ k l j.castSucc)
              (smoothedSplitWalkB γ hγ k l j.succ))
          + stepTurning (smoothedSplitWalkB γ hγ k l (Fin.last _))
              (smoothedSplitWalkB γ hγ k l 0) := by
        rw [cyclicTotalTurning_eq, edgeSequenceTotalTurning_eq]
    _ = (∑ j : Fin (m - l.val + k.val),
            stepTurning (γ (smoothedSplitIndexB k l j.castSucc))
              (smoothedExitEdge γ k l (smoothedSplitIndexB k l j.castSucc)))
          + stepTurning (γ (smoothedSplitIndexB k l (Fin.last _)))
              (smoothedExitEdge γ k l (smoothedSplitIndexB k l (Fin.last _))) := by
        rw [Finset.sum_congr rfl (fun j _ => smoothedSplitWalkB_inner_turning γ hγ hkl j),
          smoothedSplitWalkB_closing_turning γ hγ hkl]
    _ = ∑ j : Fin (m - l.val + k.val + 1),
          stepTurning (γ (smoothedSplitIndexB k l j))
            (smoothedExitEdge γ k l (smoothedSplitIndexB k l j)) := by
        rw [Fin.sum_univ_castSucc]
    _ = ∑ r ∈ univ.image (smoothedSplitIndexB k l),
          stepTurning (γ r) (smoothedExitEdge γ k l r) := by
        rw [Finset.sum_image (fun x _ y _ h => smoothedSplitIndexB_injective hkl h)]
    _ = ∑ r ∈ (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))ᶜ,
          stepTurning (γ r) (smoothedExitEdge γ k l r) := by
        rw [smoothedSplitIndexB_image γ hγ hkl]

/-- 二つの準備を合わせ、互いに素な有限和の分割で `t_∘(γ_A) + t_∘(γ_B) = t_sm(γ; k, l)`。 -/
theorem smoothing_split_walk_turning_sum (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l)
          (smoothedSplitWalkB_closed γ hγ hcross hkl)
      = smoothedCyclicTotalTurning γ hγ k l := by
  classical
  calc cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
        + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l)
            (smoothedSplitWalkB_closed γ hγ hcross hkl)
      = (∑ r ∈ univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l),
            stepTurning (γ r) (smoothedExitEdge γ k l r))
          + ∑ r ∈ (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))ᶜ,
            stepTurning (γ r) (smoothedExitEdge γ k l r) := by
        rw [smoothedSplitWalkA_cyclicTotalTurning γ hγ hcross hkl,
          smoothedSplitWalkB_cyclicTotalTurning γ hγ hcross hkl]
    _ = ∑ r : Fin (m + 1), stepTurning (γ r) (smoothedExitEdge γ k l r) :=
        Finset.sum_add_sum_compl _ _
    _ = smoothedCyclicTotalTurning γ hγ k l := rfl

/-- 具体版が必要十分版 `split_cyclic_sum_necSuf` の特殊化として得られること。
添字を `Fin (m + 1)`、`A` を `def_smoothing_index_blocks` の `A`、位置の写像を
`smoothedSplitIndexA`・`smoothedSplitIndexB`、各項を一歩の回転数に取る。 -/
theorem smoothing_split_walk_turning_sum_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l)
          (smoothedSplitWalkB_closed γ hγ hcross hkl)
      = smoothedCyclicTotalTurning γ hγ k l := by
  classical
  rw [cyclicTotalTurning_eq, edgeSequenceTotalTurning_eq, cyclicTotalTurning_eq,
    edgeSequenceTotalTurning_eq]
  exact Ising2DLambda.NecSuf.KacWard.split_cyclic_sum_necSuf
    (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))
    (fun r => stepTurning (γ r) (smoothedExitEdge γ k l r))
    (smoothedSplitIndexA k l) (smoothedSplitIndexB k l)
    (smoothedSplitIndexA_injective hkl) (smoothedSplitIndexB_injective hkl)
    (smoothedSplitIndexA_image γ hγ hkl) (smoothedSplitIndexB_image γ hγ hkl)
    _ _ _ _
    (fun j => smoothedSplitWalkA_inner_turning γ hγ hkl j)
    (smoothedSplitWalkA_closing_turning γ hγ hkl)
    (fun j => smoothedSplitWalkB_inner_turning γ hγ hkl j)
    (smoothedSplitWalkB_closing_turning γ hγ hkl)

end Ising2DLambda.KacWard
