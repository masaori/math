/-
「接触点分割の回転位相は交差形式で更新される」（`claim_crossing_free_contact_split_phase`）を、
実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L`（台の辺が相異なり、横断数が零）と
接触対 `k < l` について述べる具体版。本文の `ζ_8` は `z ^ 4 = -1` を満たす `z : Qbar`。
二本 `γ_A`・`γ_B` は `smoothedSplitWalkA`・`smoothedSplitWalkB`（閉性は `contactSplitWalkA_closed`・
`contactSplitWalkB_closed`）。符号の指数は `ZMod 2` の値の整数代表 `ZMod.val` で読む。

人手証明との対応:
- 第一段「接触頂点 `v` の通過は選んだ二つだけで、四半辺は相異なる」: `contact_vertex_passes` と、
  その証明が使う半辺の相異（`pass_halfEdges_ne`・`pass_shared_halfEdge_eq`）を方向番号の六つの不等式に
  まとめた `contact_halfEdge_directions_ne`。
- 「元に横断が無いので、二通過がともに直進して軸が異なることはない」: `crossing_free_no_index_pair_crossing`
  を `k, l` へ当てた `contact_not_straight_straight`。
- 第二段の表（四方向を巡回して最初の入辺を零とする四つの場合）と各行の回転差
  （`claim_contact_split_turning_update` の四つの `τ` を `def_step_turning` の方向差で評価した値）:
  一歩の回転数を方向番号の差で書く `stepTurning_eq_directionStepTurn` と、方向番号の全ての組についての
  有限な場合分け `contact_local_table`。表を巡回で正規化する代わりに、方向番号の四つ組
  `4 ^ 4` 通りを全て調べる（巡回で移り合う組は同じ行に入る）。
- 「各行の回転差は `claim_contact_split_turning_update` の四つの `τ`」を実際の二本へ当てたもの:
  `contact_split_walk_turning_update`（`t_∘(γ_A) + t_∘(γ_B) − t_∘(γ)` は交換した二接続の回転数差）。
  二本の回転数の和を添字区間の和へ戻す段は `contactSplitWalkA_cyclicTotalTurning`・
  `contactSplitWalkB_cyclicTotalTurning`（平滑化の場合の `smoothedSplitWalkA_cyclicTotalTurning` と同じ式鎖で、
  閉性の証明だけが接触の場合のもの）。
- 「分割は選んだ二接続以外の通過を変えない。他の頂点では横断が生じず、選んだ頂点で横断が生じる場合も
  二本の間だけ（`claim_crossing_free_contact_split_children`）」「二本の混合横断は表の最後の値だけ」:
  `contact_split_mutual_crossing_eq_index`（二本の混合横断数は、`γ_A` の位置と `γ_B` の位置の対を
  元の添字の対へ送って数えたもの）と `contact_split_index_mutual_crossing_eq_indicator`
  （その数は、`l` と `k` の平滑化後の通過が横断するとき一、それ以外は零）。
- 「`claim_disjoint_walk_mutual_crossing_intersection` により、この値の偶奇は `I_L(C_A, C_B)` に等しい」:
  `closedWalkMutualCrossingNumber_eq_intersection`。
- 「`D/4 ≡ 1 + I_L(C_A, C_B) (mod 2)`、`ζ_8^4 = −1`」による式鎖と、符号を両辺に掛ける最後の段:
  `crossing_free_contact_split_phase`。
-/
import Ising2DLambda.KacWard.CrossingFreeContactSplitChildren
import Ising2DLambda.KacWard.EdgeDistinctSmoothingCrossingParity
import Ising2DLambda.KacWard.SmoothingCyclicTurningInvarianceWalk

namespace Ising2DLambda.KacWard

open Finset
open Ising2DLambda.PartitionPolynomial
open Ising2DLambda.AlgebraicEigenvalue

variable {L m : ℕ} [NeZero L]

section Local

/-- 方向番号 `d` の入辺から方向番号 `d'` の出辺への一歩の回転数（`def_step_turning` の値の場合分け）。 -/
def directionStepTurn (d d' : ZMod 4) : ℤ :=
  if d' = d then 0
  else if d' = d + 1 then 1
  else if d' = d - 1 then -1
  else 0

omit [NeZero L] in
/-- 非後退の後続辺では、一歩の回転数は二つの方向番号だけで決まる。 -/
theorem stepTurning_eq_directionStepTurn {e f : OrientedEdge L}
    (hf : f ∈ nonbacktrackingSuccessors e) :
    stepTurning e f = directionStepTurn (directionNumber e) (directionNumber f) := by
  unfold stepTurning directionStepTurn
  rw [if_pos hf]

set_option synthInstance.maxSize 100000 in
/-- 接触頂点の表: 入辺の方向番号 `a, b`、元の出辺の方向番号 `a', b'` が、四半辺の相異
（`a + 2 ≠ a'`、`b + 2 ≠ b'`、`a + 2 ≠ b + 2`、`a + 2 ≠ b'`、`a' ≠ b + 2`、`a' ≠ b'`）と
元の二通過が横断しないことを満たすとき、回転差 `D` は、分割後の二通過（`b → a'` と `a → b'`）が横断するなら
零、横断しないなら `4` か `−4` である。`4 ^ 4` 通りの判定の決定可能性のインスタンスが既定の大きさを超えるので、
上限だけを上げる。 -/
theorem contact_local_table : ∀ a b a' b' : ZMod 4,
    a + 2 ≠ a' → b + 2 ≠ b' → a + 2 ≠ b + 2 → a + 2 ≠ b' → a' ≠ b + 2 → a' ≠ b' →
    ¬ (a' = a ∧ b' = b ∧ directionAxis a ≠ directionAxis b) →
    ((directionStepTurn a b' + directionStepTurn b a')
        - (directionStepTurn a a' + directionStepTurn b b') = 0 ∧
        (a' = b ∧ b' = a ∧ directionAxis b ≠ directionAxis a)) ∨
      ((directionStepTurn a b' + directionStepTurn b a')
        - (directionStepTurn a a' + directionStepTurn b b') = 4 ∧
        ¬ (a' = b ∧ b' = a ∧ directionAxis b ≠ directionAxis a)) ∨
      ((directionStepTurn a b' + directionStepTurn b a')
        - (directionStepTurn a a' + directionStepTurn b b') = -4 ∧
        ¬ (a' = b ∧ b' = a ∧ directionAxis b ≠ directionAxis a)) := by
  unfold directionStepTurn directionAxis
  decide

end Local

section Vertex

omit [NeZero L] in
/-- 横断数が零の閉歩道では、相異なる二添字の通過は横断しない（`def_closed_walk_crossing_number`）。 -/
theorem crossing_free_no_index_pair_crossing (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hzero : closedWalkCrossingNumber γ hγ = 0)
    {r s : Fin (m + 1)} (hrs : r ≠ s) :
    ¬ edgeTransverseCrossing (γ r) (γ (closedWalkSuccessor r)) (γ s) (γ (closedWalkSuccessor s)) := by
  classical
  intro hc
  unfold closedWalkCrossingNumber at hzero
  rw [card_eq_zero] at hzero
  rcases lt_or_gt_of_ne hrs with hlt | hlt
  · exact eq_empty_iff_forall_notMem.mp hzero (r, s)
      (mem_filter.mpr ⟨mem_product.mpr ⟨mem_univ _, mem_univ _⟩, hlt, hrs, hc⟩)
  · exact eq_empty_iff_forall_notMem.mp hzero (s, r)
      (mem_filter.mpr ⟨mem_product.mpr ⟨mem_univ _, mem_univ _⟩, hlt, Ne.symm hrs,
        hc.2.1, hc.1, hc.2.2.1.symm, hc.2.2.2.2.1, hc.2.2.2.1, Ne.symm hc.2.2.2.2.2⟩)

/-- 接触頂点の四半辺は相異なる（方向番号の六つの不等式）。 -/
theorem contact_halfEdge_directions_ne (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k ≠ l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    directionNumber (γ k) + 2 ≠ directionNumber (γ (closedWalkSuccessor k)) ∧
      directionNumber (γ l) + 2 ≠ directionNumber (γ (closedWalkSuccessor l)) ∧
      directionNumber (γ k) + 2 ≠ directionNumber (γ l) + 2 ∧
      directionNumber (γ k) + 2 ≠ directionNumber (γ (closedWalkSuccessor l)) ∧
      directionNumber (γ (closedWalkSuccessor k)) ≠ directionNumber (γ l) + 2 ∧
      directionNumber (γ (closedWalkSuccessor k)) ≠ directionNumber (γ (closedWalkSuccessor l)) := by
  have hsep : ∀ d, walkPassUsesHalfEdge γ k d → walkPassUsesHalfEdge γ l d → False :=
    fun d h1 h2 => hkl (pass_shared_halfEdge_eq γ hγ hinj k l d hcontact h1 h2)
  exact ⟨pass_halfEdges_ne γ hγ k, pass_halfEdges_ne γ hγ l,
    fun h => hsep _ (Or.inl rfl) (Or.inl h.symm),
    fun h => hsep _ (Or.inl rfl) (Or.inr h.symm),
    fun h => hsep _ (Or.inr rfl) (Or.inl h.symm),
    fun h => hsep _ (Or.inr rfl) (Or.inr h.symm)⟩

/-- 元に横断が無いので、接触対の二通過がともに直進して軸が異なることはない。 -/
theorem contact_not_straight_straight (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hzero : closedWalkCrossingNumber γ hγ = 0)
    {k l : Fin (m + 1)} (hkl : k ≠ l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    ¬ (directionNumber (γ (closedWalkSuccessor k)) = directionNumber (γ k) ∧
      directionNumber (γ (closedWalkSuccessor l)) = directionNumber (γ l) ∧
      directionAxis (directionNumber (γ k)) ≠ directionAxis (directionNumber (γ l))) := by
  rintro ⟨hk, hl, hax⟩
  apply crossing_free_no_index_pair_crossing γ hγ hzero hkl
  exact ⟨closedWalkPass_valid γ hγ k, closedWalkPass_valid γ hγ l, hcontact,
    (stepTurning_eq_zero_iff _ _ (closedWalkPass_valid γ hγ k)).mpr hk,
    (stepTurning_eq_zero_iff _ _ (closedWalkPass_valid γ hγ l)).mpr hl, hax⟩

omit [NeZero L] in
/-- 接触対の交換した出辺も含め、平滑化後の出辺は常に非後退の後続である。 -/
theorem contactExitEdge_mem_nonbacktrackingSuccessors (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) (r : Fin (m + 1)) :
    smoothedExitEdge γ k l r ∈ nonbacktrackingSuccessors (γ r) := by
  unfold smoothedExitEdge
  split_ifs with hk hl
  · subst hk
    exact contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj hcontact
  · subst hl
    exact contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj hcontact.symm
  · exact closedWalkPass_valid γ hγ r

end Vertex

section Turning

omit [NeZero L] in
open Classical in
/-- `t_∘(γ_A) = Σ_{r ∈ A} τ(e_r, f_r)`（`smoothedSplitWalkA_cyclicTotalTurning` と同じ式鎖）。 -/
theorem contactSplitWalkA_cyclicTotalTurning (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l)
    (hA : closedNonbacktrackingWalk (smoothedSplitWalkA γ hγ k l)) :
    cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) hA
      = ∑ r ∈ univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l),
          stepTurning (γ r) (smoothedExitEdge γ k l r) := by
  calc cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) hA
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

omit [NeZero L] in
open Classical in
/-- `t_∘(γ_B) = Σ_{r ∈ B} τ(e_r, f_r)`（`smoothedSplitWalkB_cyclicTotalTurning` と同じ式鎖）。 -/
theorem contactSplitWalkB_cyclicTotalTurning (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l)
    (hB : closedNonbacktrackingWalk (smoothedSplitWalkB γ hγ k l)) :
    cyclicTotalTurning (smoothedSplitWalkB γ hγ k l) hB
      = ∑ r ∈ (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))ᶜ,
          stepTurning (γ r) (smoothedExitEdge γ k l r) := by
  calc cyclicTotalTurning (smoothedSplitWalkB γ hγ k l) hB
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

omit [NeZero L] in
/-- `claim_contact_split_turning_update` を実際の二本へ当てたもの:
`t_∘(γ_A) + t_∘(γ_B) − t_∘(γ) = (τ(e_k, e_{σ(l)}) + τ(e_l, e_{σ(k)})) − (τ(e_k, e_{σ(k)}) + τ(e_l, e_{σ(l)}))`。 -/
theorem contact_split_walk_turning_update (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l)
    (hA : closedNonbacktrackingWalk (smoothedSplitWalkA γ hγ k l))
    (hB : closedNonbacktrackingWalk (smoothedSplitWalkB γ hγ k l)) :
    cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) hA
        + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l) hB - cyclicTotalTurning γ hγ =
      (stepTurning (γ k) (γ (closedWalkSuccessor l)) + stepTurning (γ l) (γ (closedWalkSuccessor k)))
        - (stepTurning (γ k) (γ (closedWalkSuccessor k))
          + stepTurning (γ l) (γ (closedWalkSuccessor l))) := by
  classical
  have hne : k ≠ l := ne_of_lt hkl
  have hexit_k : smoothedExitEdge γ k l k = γ (closedWalkSuccessor l) := by
    unfold smoothedExitEdge
    rw [if_pos rfl]
  have hexit_l : smoothedExitEdge γ k l l = γ (closedWalkSuccessor k) := by
    unfold smoothedExitEdge
    rw [if_neg (Ne.symm hne), if_pos rfl]
  calc cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) hA
        + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l) hB - cyclicTotalTurning γ hγ
      = ∑ r : Fin (m + 1), stepTurning (γ r) (smoothedExitEdge γ k l r)
          - ∑ r : Fin (m + 1), stepTurning (γ r) (γ (closedWalkSuccessor r)) := by
        rw [contactSplitWalkA_cyclicTotalTurning γ hγ hkl hA,
          contactSplitWalkB_cyclicTotalTurning γ hγ hkl hB, Finset.sum_add_sum_compl,
          cyclicTotalTurning_eq_sum_successor γ hγ]
    _ = (∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (smoothedExitEdge γ k l r)
            + (stepTurning (γ k) (smoothedExitEdge γ k l k)
              + stepTurning (γ l) (smoothedExitEdge γ k l l)))
          - (∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (γ (closedWalkSuccessor r))
            + (stepTurning (γ k) (γ (closedWalkSuccessor k))
              + stepTurning (γ l) (γ (closedWalkSuccessor l)))) := by
        rw [sum_split_two_indices _ hne, sum_split_two_indices _ hne]
    _ = (∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (γ (closedWalkSuccessor r))
            + (stepTurning (γ k) (γ (closedWalkSuccessor l))
              + stepTurning (γ l) (γ (closedWalkSuccessor k))))
          - (∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (γ (closedWalkSuccessor r))
            + (stepTurning (γ k) (γ (closedWalkSuccessor k))
              + stepTurning (γ l) (γ (closedWalkSuccessor l)))) := by
        rw [hexit_k, hexit_l]
        congr 2
        refine Finset.sum_congr rfl fun r hr => ?_
        obtain ⟨hrl, hr'⟩ := mem_erase.mp hr
        obtain ⟨hrk, -⟩ := mem_erase.mp hr'
        rw [smoothedExitEdge_of_ne γ hrk hrl]
    _ = (stepTurning (γ k) (γ (closedWalkSuccessor l)) + stepTurning (γ l) (γ (closedWalkSuccessor k)))
          - (stepTurning (γ k) (γ (closedWalkSuccessor k))
            + stepTurning (γ l) (γ (closedWalkSuccessor l))) := by
        ring

end Turning

section Mutual

omit [NeZero L] in
open Classical in
/-- 二本の混合横断数は、`γ_A` の位置と `γ_B` の位置の対を元の添字の対へ送って数えたもの
（`def_split_mutual_crossing_number` の数え上げ）に等しい。 -/
theorem contact_split_mutual_crossing_eq_index (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l))
    (hA : closedNonbacktrackingWalk (smoothedSplitWalkA γ hγ k l))
    (hB : closedNonbacktrackingWalk (smoothedSplitWalkB γ hγ k l)) :
    closedWalkMutualCrossingNumber (smoothedSplitWalkA γ hγ k l) hA
        (smoothedSplitWalkB γ hγ k l) hB =
      splitMutualCrossingNumber γ hγ k l := by
  unfold splitMutualCrossingNumber closedWalkMutualCrossingNumber
  apply Finset.card_bij (fun q _ => (smoothedSplitIndexA k l q.1, smoothedSplitIndexB k l q.2))
  · intro q hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hq
    rw [smoothedSplitWalkA_successor γ hγ hkl, smoothedSplitWalkB_successor γ hγ hkl,
      smoothedSplitWalkA_apply, smoothedSplitWalkB_apply] at hq
    obtain ⟨_, _, h1, h2, h3, h4⟩ := hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
    exact ⟨(smoothedSplitIndexA_range γ hγ hkl _).2 ⟨_, rfl⟩,
      (smoothedSplitIndexB_range γ hγ hkl _).2 ⟨_, rfl⟩, h1, h2, h3, h4⟩
  · intro q _ q' _ h
    simp only [Prod.mk.injEq] at h
    exact Prod.ext (smoothedSplitIndexA_injective hkl h.1) (smoothedSplitIndexB_injective hkl h.2)
  · intro r hr
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hr
    obtain ⟨hrA, hsB, h1, h2, h3, h4⟩ := hr
    obtain ⟨i, hi⟩ := (smoothedSplitIndexA_range γ hγ hkl r.1).1 hrA
    obtain ⟨j, hj⟩ := (smoothedSplitIndexB_range γ hγ hkl r.2).1 hsB
    refine ⟨(i, j), ?_, ?_⟩
    · simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
      rw [smoothedSplitWalkA_successor γ hγ hkl, smoothedSplitWalkB_successor γ hγ hkl,
        smoothedSplitWalkA_apply, smoothedSplitWalkB_apply, hi, hj]
      exact ⟨contactExitEdge_mem_nonbacktrackingSuccessors γ hγ hinj hcontact _,
        contactExitEdge_mem_nonbacktrackingSuccessors γ hγ hinj hcontact _, h1, h2, h3, h4⟩
    · simp only [hi, hj]

/-- 接触点分割の二本の混合横断の数え上げは、`l`（`γ_A` 側、出辺 `e_{σ(k)}`）と `k`（`γ_B` 側、出辺
`e_{σ(l)}`）の通過がともに直進して軸が異なるとき一、それ以外は零である。接触頂点の通過は `k, l` だけ
（`contact_vertex_passes`）で、`k ∉ A`、`l ∉ B`。他の頂点の通過は出辺が元と同じなので、
そこでの横断は元の横断になり、`c(γ) = 0` に反する。 -/
theorem contact_split_index_mutual_crossing_eq_indicator (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    (hzero : closedWalkCrossingNumber γ hγ = 0)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    splitMutualCrossingNumber γ hγ k l =
      if directionNumber (γ (closedWalkSuccessor k)) = directionNumber (γ l) ∧
          directionNumber (γ (closedWalkSuccessor l)) = directionNumber (γ k) ∧
          directionAxis (directionNumber (γ l)) ≠ directionAxis (directionNumber (γ k))
      then 1 else 0 := by
  classical
  have hne : k ≠ l := ne_of_lt hkl
  have hlA : l ∈ smoothingIndexBlockA γ hγ k l := by
    change (closedWalkTextIndex k).val < (closedWalkTextIndex l).val ∧
      (closedWalkTextIndex l).val ≤ (closedWalkTextIndex l).val
    rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]
    exact ⟨hkl, le_refl _⟩
  have hkB : k ∈ smoothingIndexBlockB γ hγ k l := by
    rw [smoothingIndexBlockB_membership]
    exact Or.inl (le_refl _)
  have hexit_k : smoothedExitEdge γ k l k = γ (closedWalkSuccessor l) := by
    unfold smoothedExitEdge
    rw [if_pos rfl]
  have hexit_l : smoothedExitEdge γ k l l = γ (closedWalkSuccessor k) := by
    unfold smoothedExitEdge
    rw [if_neg (Ne.symm hne), if_pos rfl]
  -- 数え上げの集合は `(l, k)` だけを含みうる。
  have hsub : ∀ p : Fin (m + 1) × Fin (m + 1),
      (p.1 ∈ smoothingIndexBlockA γ hγ k l ∧ p.2 ∈ smoothingIndexBlockB γ hγ k l ∧
        orientedTarget (γ p.1) = orientedTarget (γ p.2) ∧
        stepTurning (γ p.1) (smoothedExitEdge γ k l p.1) = 0 ∧
        stepTurning (γ p.2) (smoothedExitEdge γ k l p.2) = 0 ∧
        directionAxis (directionNumber (γ p.1)) ≠ directionAxis (directionNumber (γ p.2))) →
      p = (l, k) := by
    rintro ⟨r, s⟩ ⟨hrA, hsB, hv, h1, h2, hax⟩
    have hrs : r ≠ s := fun h => by
      subst h
      exact hsB hrA
    have hrk : r ≠ k := fun h => by
      subst h
      exact hkB hrA
    have hsl : s ≠ l := fun h => by
      subst h
      exact hsB hlA
    by_cases hrv : orientedTarget (γ r) = orientedTarget (γ k)
    · -- 接触頂点: `r = l`、`s = k`。
      rcases contact_vertex_passes γ hγ hinj hne hcontact r hrv with h | h
      · exact (hrk h).elim
      · rcases contact_vertex_passes γ hγ hinj hne hcontact s (hv.symm.trans hrv) with h' | h'
        · exact Prod.ext h h'
        · exact (hsl h').elim
    · -- 他の頂点: 出辺は元と同じで、元の横断になる。
      have hrl : r ≠ l := fun h => hrv (by rw [h, hcontact])
      have hsk : s ≠ k := fun h => hrv (by rw [hv, h])
      have hsl' : s ≠ l := hsl
      exfalso
      apply crossing_free_no_index_pair_crossing γ hγ hzero hrs
      rw [smoothedExitEdge_of_ne γ hrk hrl] at h1
      rw [smoothedExitEdge_of_ne γ hsk hsl'] at h2
      exact ⟨closedWalkPass_valid γ hγ r, closedWalkPass_valid γ hγ s, hv, h1, h2, hax⟩
  have hlk_iff : ((l ∈ smoothingIndexBlockA γ hγ k l ∧ k ∈ smoothingIndexBlockB γ hγ k l ∧
        orientedTarget (γ l) = orientedTarget (γ k) ∧
        stepTurning (γ l) (smoothedExitEdge γ k l l) = 0 ∧
        stepTurning (γ k) (smoothedExitEdge γ k l k) = 0 ∧
        directionAxis (directionNumber (γ l)) ≠ directionAxis (directionNumber (γ k)))) ↔
      (directionNumber (γ (closedWalkSuccessor k)) = directionNumber (γ l) ∧
        directionNumber (γ (closedWalkSuccessor l)) = directionNumber (γ k) ∧
        directionAxis (directionNumber (γ l)) ≠ directionAxis (directionNumber (γ k))) := by
    rw [hexit_k, hexit_l,
      stepTurning_eq_zero_iff _ _ (contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj
        hcontact.symm),
      stepTurning_eq_zero_iff _ _ (contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj
        hcontact)]
    exact ⟨fun h => ⟨h.2.2.2.1, h.2.2.2.2.1, h.2.2.2.2.2⟩,
      fun h => ⟨hlA, hkB, hcontact.symm, h.1, h.2.1, h.2.2⟩⟩
  unfold splitMutualCrossingNumber
  split_ifs with hP
  · rw [Finset.card_eq_one]
    refine ⟨(l, k), ?_⟩
    ext p
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and,
      Finset.mem_singleton]
    constructor
    · exact hsub p
    · rintro rfl
      exact hlk_iff.mpr hP
  · rw [Finset.card_eq_zero]
    apply Finset.eq_empty_of_forall_notMem
    intro p hp
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hp
    have hpl := hsub p hp
    subst hpl
    exact hP (hlk_iff.mp hp)

end Mutual

/-- `claim_crossing_free_contact_split_phase`:
`ζ_8^{t_∘(γ)} = (−1)^{1 + I_L(C_A, C_B)} ζ_8^{t_∘(γ_A) + t_∘(γ_B)}`（符号の指数は `ZMod 2` の値の整数代表）。 -/
theorem crossing_free_contact_split_phase {z : Qbar} (hz4 : z ^ 4 = -1)
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    (hzero : closedWalkCrossingNumber γ hγ = 0)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    z ^ cyclicTotalTurning γ hγ =
      (-1 : Qbar) ^ (1 + evenEdgeChainIntersection L
          (closedWalkSupport (smoothedSplitWalkA γ hγ k l))
          (closedWalkSupport (smoothedSplitWalkB γ hγ k l))).val *
        z ^ (cyclicTotalTurning (smoothedSplitWalkA γ hγ k l)
              (contactSplitWalkA_closed γ hγ hinj hkl hcontact)
            + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l)
              (contactSplitWalkB_closed γ hγ hinj hkl hcontact)) := by
  classical
  have hne : k ≠ l := ne_of_lt hkl
  set hA := contactSplitWalkA_closed γ hγ hinj hkl hcontact
  set hB := contactSplitWalkB_closed γ hγ hinj hkl hcontact
  have hz : z ≠ 0 := by
    intro h
    rw [h] at hz4
    norm_num at hz4
  have hz4' : z ^ (4 : ℤ) = -1 := by
    rw [show (4 : ℤ) = ((4 : ℕ) : ℤ) from rfl, zpow_natCast, hz4]
  -- 四つの接続の回転数を方向番号で書く。
  have hkk : stepTurning (γ k) (γ (closedWalkSuccessor k)) = directionStepTurn
      (directionNumber (γ k)) (directionNumber (γ (closedWalkSuccessor k))) :=
    stepTurning_eq_directionStepTurn (closedWalkPass_valid γ hγ k)
  have hll : stepTurning (γ l) (γ (closedWalkSuccessor l)) = directionStepTurn
      (directionNumber (γ l)) (directionNumber (γ (closedWalkSuccessor l))) :=
    stepTurning_eq_directionStepTurn (closedWalkPass_valid γ hγ l)
  have hkl' := stepTurning_eq_directionStepTurn
    (contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj hcontact)
  have hlk' := stepTurning_eq_directionStepTurn
    (contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj hcontact.symm)
  -- 回転差 D と、表の最後の値（混合横断数）。
  have hupdate := contact_split_walk_turning_update γ hγ hkl hA hB
  have hmutual := contact_split_mutual_crossing_eq_index γ hγ hinj hkl hcontact hA hB
  have hindicator := contact_split_index_mutual_crossing_eq_indicator γ hγ hinj hzero hkl hcontact
  have hintersection := closedWalkMutualCrossingNumber_eq_intersection
    (smoothedSplitWalkA γ hγ k l) hA (smoothedSplitWalkB γ hγ k l) hB
    (smoothedSplitWalkA_edge_injective γ hγ hinj hkl)
    (smoothedSplitWalkB_edge_injective γ hγ hinj hkl)
    (smoothedSplitWalks_edge_disjoint γ hγ hinj hkl)
  rw [hmutual, hindicator] at hintersection
  rw [← hintersection]
  rw [hkk, hll, hkl', hlk'] at hupdate
  obtain ⟨d1, d2, d3, d4, d5, d6⟩ := contact_halfEdge_directions_ne γ hγ hinj hne hcontact
  have hnc := contact_not_straight_straight γ hγ hzero hne hcontact
  set tA := cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) hA
  set tB := cyclicTotalTurning (smoothedSplitWalkB γ hγ k l) hB
  set t := cyclicTotalTurning γ hγ
  rcases contact_local_table _ _ _ _ d1 d2 d3 d4 d5 d6 hnc with ⟨hD, hP⟩ | ⟨hD, hP⟩ | ⟨hD, hP⟩
  · -- 回転差 0、分割後の混合横断 1: 符号の指数は 1 + 1 = 0。
    rw [if_pos hP]
    have hsum : tA + tB = t := by omega
    rw [hsum]
    have h11 : ((1 : ZMod 2) + ((1 : ℕ) : ZMod 2)).val = 0 := by decide
    rw [h11, pow_zero, one_mul]
  · -- 回転差 4、分割後の混合横断 0: 符号の指数は 1。
    rw [if_neg hP]
    have hsum : tA + tB = t + 4 := by omega
    rw [hsum, zpow_add₀ hz, hz4']
    have h10 : ((1 : ZMod 2) + ((0 : ℕ) : ZMod 2)).val = 1 := by decide
    rw [h10]
    ring
  · -- 回転差 −4、分割後の混合横断 0: 符号の指数は 1。
    rw [if_neg hP]
    have hsum : tA + tB = t + (-4) := by omega
    rw [hsum, zpow_add₀ hz, zpow_neg, hz4']
    have h10 : ((1 : ZMod 2) + ((0 : ℕ) : ZMod 2)).val = 1 := by decide
    rw [h10]
    norm_num

end Ising2DLambda.KacWard
