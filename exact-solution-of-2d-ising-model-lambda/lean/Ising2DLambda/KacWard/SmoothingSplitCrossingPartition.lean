/-
「平滑化後の横断数は二本の閉歩道の横断数と混合横断数の和である」
（`claim_smoothing_split_crossing_partition`）を、実際の閉じた非後退辺列
`γ : Fin (m + 1) → OrientedEdge L` と横断する添字 `k < l` について述べる具体版。
本文の添字 `r ∈ I_{m+1}` は Lean の `r - 1`（`closedWalkTextIndex`）、本文の位置 `i` は Lean の `i - 1`。

人手証明との対応:
- `C^sm` の三条件: `smoothedCrossingCondition`。`C^sm`: `smoothedCrossingPairs`
  （`smoothedCrossingNumber_eq_card` で `def_smoothed_crossing_number` と一致）。
- 第一の準備（`A`・`B` のちょうど一方に属することによる三分割）: `smoothedCrossingPairs_card_partition`。
- 第二の準備の「`γ_A` の位置 `i` の通過は `e_{p_A(i)} → f_{p_A(i)}`」: `smoothedSplitWalkA_successor`。
  `γ_B` について同様: `smoothedSplitWalkB_successor`。これらと `def_index_pair_crossing`・
  `def_transverse_crossing` から、二本での横断が三条件に一致すること: `indexPairCrossing_iff_of_positions`
  （非後退の条件は `smoothedExitEdge_mem_nonbacktrackingSuccessors` が与える）。
- 「`p_A` は狭義単調増加」: `smoothedSplitIndexA_lt_iff`。`c(γ_A) = |C_AA|`: `closedWalkCrossingNumber_splitWalkA`。
- 「順序なし二元集合の全単射」による `c(γ_B) = |C_BB|`: `closedWalkCrossingNumber_splitWalkB`。
- 三条件の交換での対称性: `smoothedCrossingCondition_symm`（二辺の終点の一致・二つの直進・軸の相異の各々の対称性）。
- 第三の準備（`C_×` の対を `A` 側を第一成分に置き直す全単射）: `splitMutualCrossingNumber_eq_mixed`。
- 合成: `smoothing_split_crossing_partition`。
-/
import Ising2DLambda.KacWard.SmoothedSplitClosedWalks
import Ising2DLambda.KacWard.ClosedWalkCrossingNumber
import Ising2DLambda.KacWard.SmoothedCrossingNumber
import Ising2DLambda.KacWard.SplitMutualCrossingNumber
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitCrossingPartition

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

section Condition

variable {L m : ℕ}

/-- `C^sm` の三条件: 二つの通過が同じ頂点で、平滑化後の出辺へ直進し、進入方向の軸が異なる。 -/
def smoothedCrossingCondition (γ : Fin (m + 1) → OrientedEdge L) (k l r s : Fin (m + 1)) : Prop :=
  orientedTarget (γ r) = orientedTarget (γ s) ∧
    stepTurning (γ r) (smoothedExitEdge γ k l r) = 0 ∧
    stepTurning (γ s) (smoothedExitEdge γ k l s) = 0 ∧
    directionAxis (directionNumber (γ r)) ≠ directionAxis (directionNumber (γ s))

/-- 三条件は二つの添字の交換で対称である。 -/
theorem smoothedCrossingCondition_symm {γ : Fin (m + 1) → OrientedEdge L} {k l r s : Fin (m + 1)}
    (h : smoothedCrossingCondition γ k l r s) : smoothedCrossingCondition γ k l s r :=
  ⟨h.1.symm, h.2.2.1, h.2.1, Ne.symm h.2.2.2⟩

/-- 三条件を満たす二つの添字は異なる（同じ添字なら軸が一致する）。 -/
theorem smoothedCrossingCondition_ne {γ : Fin (m + 1) → OrientedEdge L} {k l r s : Fin (m + 1)}
    (h : smoothedCrossingCondition γ k l r s) : r ≠ s := by
  rintro rfl
  exact h.2.2.2 rfl

open Classical in
/-- `def_smoothed_crossing_number` の添字対の集合 `C^sm`。 -/
noncomputable def smoothedCrossingPairs (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : Finset (Fin (m + 1) × Fin (m + 1)) :=
  (Finset.univ ×ˢ Finset.univ).filter fun p =>
    p.1 < p.2 ∧ smoothedCrossingCondition γ k l p.1 p.2

theorem smoothedCrossingNumber_eq_card (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedCrossingNumber γ hγ k l = (smoothedCrossingPairs γ hγ k l).card := by
  unfold smoothedCrossingNumber smoothedCrossingPairs smoothedCrossingCondition
  congr 1
  ext p
  simp only [Finset.mem_filter]

theorem mem_smoothingIndexBlockB_iff (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockB γ hγ k l ↔ r ∉ smoothingIndexBlockA γ hγ k l := Iff.rfl

open Classical in
/-- 第一の準備: `A` と `B` のちょうど一方に属することによる `C^sm` の三分割
（`|C^sm| = |C_AA| + |C_BB| + |C_×|`）。 -/
theorem smoothedCrossingPairs_card_partition (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    (smoothedCrossingPairs γ hγ k l).card =
      ((smoothedCrossingPairs γ hγ k l).filter fun p =>
          p.1 ∈ smoothingIndexBlockA γ hγ k l ∧ p.2 ∈ smoothingIndexBlockA γ hγ k l).card
      + ((smoothedCrossingPairs γ hγ k l).filter fun p =>
          p.1 ∈ smoothingIndexBlockB γ hγ k l ∧ p.2 ∈ smoothingIndexBlockB γ hγ k l).card
      + ((smoothedCrossingPairs γ hγ k l).filter fun p =>
          (p.1 ∈ smoothingIndexBlockA γ hγ k l ∧ p.2 ∈ smoothingIndexBlockB γ hγ k l) ∨
            (p.1 ∈ smoothingIndexBlockB γ hγ k l ∧ p.2 ∈ smoothingIndexBlockA γ hγ k l)).card := by
  set S := smoothedCrossingPairs γ hγ k l
  set A := smoothingIndexBlockA γ hγ k l
  set B := smoothingIndexBlockB γ hγ k l
  have h1 := Finset.card_filter_add_card_filter_not (s := S)
    (p := fun p : Fin (m + 1) × Fin (m + 1) => p.1 ∈ A ∧ p.2 ∈ A)
  have h2 := Finset.card_filter_add_card_filter_not
    (s := S.filter fun p : Fin (m + 1) × Fin (m + 1) => ¬(p.1 ∈ A ∧ p.2 ∈ A))
    (p := fun p : Fin (m + 1) × Fin (m + 1) => p.1 ∈ B ∧ p.2 ∈ B)
  have h3 : (S.filter fun p : Fin (m + 1) × Fin (m + 1) => ¬(p.1 ∈ A ∧ p.2 ∈ A)).filter
      (fun p => p.1 ∈ B ∧ p.2 ∈ B) = S.filter fun p => p.1 ∈ B ∧ p.2 ∈ B := by
    ext p
    simp only [Finset.mem_filter, B, mem_smoothingIndexBlockB_iff]
    tauto
  have h4 : (S.filter fun p : Fin (m + 1) × Fin (m + 1) => ¬(p.1 ∈ A ∧ p.2 ∈ A)).filter
      (fun p => ¬(p.1 ∈ B ∧ p.2 ∈ B)) =
        S.filter fun p => (p.1 ∈ A ∧ p.2 ∈ B) ∨ (p.1 ∈ B ∧ p.2 ∈ A) := by
    ext p
    simp only [Finset.mem_filter, B, mem_smoothingIndexBlockB_iff]
    tauto
  rw [h3, h4] at h2
  omega

end Condition

section Successor

variable {L m : ℕ}

/-- 巡回後続の値は、一つ先の剰余である。 -/
theorem closedWalkSuccessor_val (r : Fin (m + 1)) :
    (closedWalkSuccessor r).val = (r.val + 1) % (m + 1) := by
  have h := closedWalkSuccessor_mod (m := m) r.val
  have hr : (⟨r.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = r :=
    Fin.ext (Nat.mod_eq_of_lt r.isLt)
  rw [hr] at h
  rw [h]

/-- `γ_A` の位置 `j` の後続は、平滑化後の出辺 `f_{p_A(j)}` である
（内部では元の後続、終辺 `e_l` では付け替えた `f_l = e_{k+1}`）。 -/
theorem smoothedSplitWalkA_successor (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l)
    (j : Fin (l.val - k.val - 1 + 1)) :
    smoothedSplitWalkA γ hγ k l (closedWalkSuccessor j) =
      smoothedExitEdge γ k l (smoothedSplitIndexA k l j) := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hj := j.isLt
  have hv : (smoothedSplitIndexA k l j).val = k.val + 1 + j.val := by
    simp only [smoothedSplitIndexA]
    exact Nat.mod_eq_of_lt (by omega)
  have hne_k : smoothedSplitIndexA k l j ≠ k := fun h => by
    have := congrArg Fin.val h
    omega
  rw [smoothedSplitWalkA_apply]
  unfold smoothedExitEdge
  rw [if_neg hne_k]
  by_cases hjn : j.val < l.val - k.val - 1
  · have hne_l : smoothedSplitIndexA k l j ≠ l := fun h => by
      have := congrArg Fin.val h
      omega
    rw [if_neg hne_l]
    congr 1
    apply Fin.ext
    rw [closedWalkSuccessor_val]
    simp only [smoothedSplitIndexA]
    rw [closedWalkSuccessor_val, Nat.mod_eq_of_lt (show j.val + 1 < l.val - k.val - 1 + 1 by omega),
      Nat.mod_eq_of_lt (show k.val + 1 + j.val < m + 1 by omega)]
    rw [Nat.mod_eq_of_lt (show k.val + 1 + (j.val + 1) < m + 1 by omega),
      Nat.mod_eq_of_lt (show k.val + 1 + j.val + 1 < m + 1 by omega)]
    omega
  · have heq_l : smoothedSplitIndexA k l j = l := Fin.ext (by omega)
    rw [if_pos heq_l]
    congr 1
    apply Fin.ext
    simp only [smoothedSplitIndexA]
    rw [closedWalkSuccessor_val, closedWalkSuccessor_val,
      show j.val + 1 = l.val - k.val - 1 + 1 by omega, Nat.mod_self]

/-- `γ_B` の位置 `j` の後続は、平滑化後の出辺 `f_{p_B(j)}` である
（内部では元の後続、終辺 `e_k` では付け替えた `f_k = e_{σ(l)}`）。 -/
theorem smoothedSplitWalkB_successor (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l)
    (j : Fin (m - l.val + k.val + 1)) :
    smoothedSplitWalkB γ hγ k l (closedWalkSuccessor j) =
      smoothedExitEdge γ k l (smoothedSplitIndexB k l j) := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hj := j.isLt
  have hv := mod_succ_of_lt_double (m := m) (x := l.val + 1 + j.val) (by omega)
  rw [smoothedSplitWalkB_apply]
  unfold smoothedExitEdge
  by_cases hjn : j.val < m - l.val + k.val
  · have hne_k : smoothedSplitIndexB k l j ≠ k := fun h => by
      have h' := congrArg Fin.val h
      simp only [smoothedSplitIndexB] at h'
      rw [hv] at h'
      split_ifs at h' <;> omega
    have hne_l : smoothedSplitIndexB k l j ≠ l := fun h => by
      have h' := congrArg Fin.val h
      simp only [smoothedSplitIndexB] at h'
      rw [hv] at h'
      split_ifs at h' <;> omega
    rw [if_neg hne_k, if_neg hne_l]
    congr 1
    apply Fin.ext
    simp only [smoothedSplitIndexB]
    rw [closedWalkSuccessor_val, closedWalkSuccessor_val,
      Nat.mod_eq_of_lt (show j.val + 1 < m - l.val + k.val + 1 by omega)]
    change _ = ((l.val + 1 + j.val) % (m + 1) + 1) % (m + 1)
    rw [Nat.mod_add_mod]
    congr 1
  · have heq_k : smoothedSplitIndexB k l j = k := by
      apply Fin.ext
      simp only [smoothedSplitIndexB]
      rw [hv, if_neg (by omega)]
      omega
    rw [if_pos heq_k]
    congr 1
    apply Fin.ext
    simp only [smoothedSplitIndexB]
    rw [closedWalkSuccessor_val, closedWalkSuccessor_val,
      show j.val + 1 = m - l.val + k.val + 1 by omega, Nat.mod_self]

end Successor

section Crossing

variable {L m : ℕ} [NeZero L]

/-- 位置の写像 `p` で元の辺列を読み、各位置の後続が平滑化後の出辺 `f_{p(i)}` である閉歩道 `δ` では、
位置対の横断（`def_index_pair_crossing`・`def_transverse_crossing`）は `p` で写した添字対の三条件に一致する。
非後退の条件は平滑化後の出辺について常に成り立つ。 -/
theorem indexPairCrossing_iff_of_positions (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l)
    {n : ℕ} (δ : Fin (n + 1) → OrientedEdge L) (hδ : closedNonbacktrackingWalk δ)
    (p : Fin (n + 1) → Fin (m + 1)) (hpos : ∀ j, δ j = γ (p j))
    (hsucc : ∀ j, δ (closedWalkSuccessor j) = smoothedExitEdge γ k l (p j)) (i j : Fin (n + 1)) :
    indexPairCrossing δ hδ i j ↔ smoothedCrossingCondition γ k l (p i) (p j) := by
  unfold indexPairCrossing edgeTransverseCrossing
  rw [hsucc i, hsucc j, hpos i, hpos j]
  constructor
  · rintro ⟨_, _, _, h1, h2, h3, h4⟩
    exact ⟨h1, h2, h3, h4⟩
  · intro h
    refine ⟨fun hij => smoothedCrossingCondition_ne h (by rw [hij]),
      smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross _,
      smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross _, h.1, h.2.1, h.2.2.1, h.2.2.2⟩

/-- `p_A` は狭義単調増加である。 -/
theorem smoothedSplitIndexA_lt_iff {k l : Fin (m + 1)} (hkl : k < l)
    (i j : Fin (l.val - k.val - 1 + 1)) :
    smoothedSplitIndexA k l i < smoothedSplitIndexA k l j ↔ i < j := by
  have hk : k.val < l.val := hkl
  have hl := l.isLt
  have hi := i.isLt
  have hj := j.isLt
  rw [Fin.lt_def, Fin.lt_def]
  simp only [smoothedSplitIndexA]
  rw [Nat.mod_eq_of_lt (by omega), Nat.mod_eq_of_lt (by omega)]
  omega

open Classical in
/-- `c(γ_A) = |C_AA|`: 位置対 `(i, j)` を `(p_A(i), p_A(j))` へ送る全単射。 -/
theorem closedWalkCrossingNumber_splitWalkA (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l)
    (hkl : k < l) (hA : closedNonbacktrackingWalk (smoothedSplitWalkA γ hγ k l)) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l) hA =
      ((smoothedCrossingPairs γ hγ k l).filter fun p =>
          p.1 ∈ smoothingIndexBlockA γ hγ k l ∧ p.2 ∈ smoothingIndexBlockA γ hγ k l).card := by
  have hiff := indexPairCrossing_iff_of_positions γ hγ hcross (smoothedSplitWalkA γ hγ k l) hA
    (smoothedSplitIndexA k l) (smoothedSplitWalkA_apply γ hγ k l)
    (smoothedSplitWalkA_successor γ hγ hkl)
  unfold closedWalkCrossingNumber
  apply Finset.card_bij (fun q _ => (smoothedSplitIndexA k l q.1, smoothedSplitIndexA k l q.2))
  · intro q hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hq
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and]
    exact ⟨⟨(smoothedSplitIndexA_lt_iff hkl _ _).2 hq.1, (hiff _ _).1 hq.2⟩,
      (smoothedSplitIndexA_range γ hγ hkl _).2 ⟨_, rfl⟩,
      (smoothedSplitIndexA_range γ hγ hkl _).2 ⟨_, rfl⟩⟩
  · intro q _ q' _ h
    simp only [Prod.mk.injEq] at h
    exact Prod.ext (smoothedSplitIndexA_injective hkl h.1) (smoothedSplitIndexA_injective hkl h.2)
  · intro r hr
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and] at hr
    obtain ⟨⟨hlt, hc⟩, hrA, hsA⟩ := hr
    obtain ⟨i, hi⟩ := (smoothedSplitIndexA_range γ hγ hkl r.1).1 hrA
    obtain ⟨j, hj⟩ := (smoothedSplitIndexA_range γ hγ hkl r.2).1 hsA
    refine ⟨(i, j), ?_, ?_⟩
    · simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
      rw [← hi, ← hj] at hlt hc
      exact ⟨(smoothedSplitIndexA_lt_iff hkl _ _).1 hlt, (hiff _ _).2 hc⟩
    · simp only [hi, hj]

open Classical in
/-- `c(γ_B) = |C_BB|`: 位置の順序なし二元集合 `{i, j}` を `{p_B(i), p_B(j)}` へ送る全単射
（各二元集合を小さい方を第一成分とする代表で数える）。 -/
theorem closedWalkCrossingNumber_splitWalkB (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l)
    (hkl : k < l) (hB : closedNonbacktrackingWalk (smoothedSplitWalkB γ hγ k l)) :
    closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l) hB =
      ((smoothedCrossingPairs γ hγ k l).filter fun p =>
          p.1 ∈ smoothingIndexBlockB γ hγ k l ∧ p.2 ∈ smoothingIndexBlockB γ hγ k l).card := by
  have hiff := indexPairCrossing_iff_of_positions γ hγ hcross (smoothedSplitWalkB γ hγ k l) hB
    (smoothedSplitIndexB k l) (smoothedSplitWalkB_apply γ hγ k l)
    (smoothedSplitWalkB_successor γ hγ hkl)
  have hinj := smoothedSplitIndexB_injective (m := m) hkl
  unfold closedWalkCrossingNumber
  apply Finset.card_bij (fun q _ =>
    if smoothedSplitIndexB k l q.1 < smoothedSplitIndexB k l q.2 then
      (smoothedSplitIndexB k l q.1, smoothedSplitIndexB k l q.2)
    else (smoothedSplitIndexB k l q.2, smoothedSplitIndexB k l q.1))
  · intro q hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hq
    have hc := (hiff _ _).1 hq.2
    have hmem1 := (smoothedSplitIndexB_range γ hγ hkl (smoothedSplitIndexB k l q.1)).2 ⟨_, rfl⟩
    have hmem2 := (smoothedSplitIndexB_range γ hγ hkl (smoothedSplitIndexB k l q.2)).2 ⟨_, rfl⟩
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and]
    split_ifs with hlt
    · exact ⟨⟨hlt, hc⟩, hmem1, hmem2⟩
    · have hne := smoothedCrossingCondition_ne hc
      exact ⟨⟨lt_of_le_of_ne (not_lt.mp hlt) (Ne.symm hne), smoothedCrossingCondition_symm hc⟩,
        hmem2, hmem1⟩
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
    obtain ⟨i, hi⟩ := (smoothedSplitIndexB_range γ hγ hkl r.1).1 hrB
    obtain ⟨j, hj⟩ := (smoothedSplitIndexB_range γ hγ hkl r.2).1 hsB
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
        exact ⟨hij', (hiff _ _).2 (smoothedCrossingCondition_symm hc)⟩
      · simp only
        rw [if_neg (by rw [hi, hj]; exact not_lt.mpr hlt.le), hi, hj]

omit [NeZero L] in
open Classical in
/-- 第三の準備 `c_×(γ; k, l) = |C_×|`: `C_×` の対を、`A` に属する側を第一成分に置き直す全単射。 -/
theorem splitMutualCrossingNumber_eq_mixed (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    splitMutualCrossingNumber γ hγ k l =
      ((smoothedCrossingPairs γ hγ k l).filter fun p =>
          (p.1 ∈ smoothingIndexBlockA γ hγ k l ∧ p.2 ∈ smoothingIndexBlockB γ hγ k l) ∨
            (p.1 ∈ smoothingIndexBlockB γ hγ k l ∧ p.2 ∈ smoothingIndexBlockA γ hγ k l)).card := by
  unfold splitMutualCrossingNumber
  symm
  apply Finset.card_bij (fun q _ =>
    if q.1 ∈ smoothingIndexBlockA γ hγ k l then (q.1, q.2) else (q.2, q.1))
  · intro q hq
    simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and, mem_smoothingIndexBlockB_iff] at hq
    obtain ⟨⟨_, hc⟩, hmix⟩ := hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and,
      mem_smoothingIndexBlockB_iff]
    split_ifs with h1
    · exact ⟨h1, by tauto, hc⟩
    · have hc' := smoothedCrossingCondition_symm hc
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
    have hc : smoothedCrossingCondition γ k l r.1 r.2 := hc'
    have hne := smoothedCrossingCondition_ne hc
    have hsA : r.2 ∉ smoothingIndexBlockA γ hγ k l := hsB
    rcases lt_or_gt_of_ne hne with hlt | hlt
    · refine ⟨(r.1, r.2), ?_, ?_⟩
      · simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
          true_and]
        exact ⟨⟨hlt, hc⟩, Or.inl ⟨hrA, hsB⟩⟩
      · simp only [if_pos hrA]
    · refine ⟨(r.2, r.1), ?_, ?_⟩
      · simp only [smoothedCrossingPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
          true_and]
        exact ⟨⟨hlt, smoothedCrossingCondition_symm hc⟩, Or.inr ⟨hsB, hrA⟩⟩
      · simp only [if_neg hsA]

/-- `claim_smoothing_split_crossing_partition`:
`c(γ_A) + c(γ_B) + c_×(γ; k, l) = c_sm(γ; k, l)`。 -/
theorem smoothing_split_crossing_partition (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l)
    (hkl : k < l) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
          (smoothedSplitWalkB_closed γ hγ hcross hkl)
      + splitMutualCrossingNumber γ hγ k l =
      smoothedCrossingNumber γ hγ k l := by
  rw [closedWalkCrossingNumber_splitWalkA γ hγ hcross hkl,
    closedWalkCrossingNumber_splitWalkB γ hγ hcross hkl,
    splitMutualCrossingNumber_eq_mixed γ hγ k l,
    smoothedCrossingNumber_eq_card γ hγ k l,
    smoothedCrossingPairs_card_partition γ hγ k l]

/-- 具体版が必要十分版の特殊化として得られることの記録（接続は非後退の後続、直進は一歩の回転が零、
軸は方向番号の軸。平滑化後の出辺の接続は `smoothedExitEdge_mem_nonbacktrackingSuccessors`）。 -/
theorem smoothing_split_crossing_partition_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l)
    (hkl : k < l) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
          (smoothedSplitWalkB_closed γ hγ hcross hkl)
      + splitMutualCrossingNumber γ hγ k l =
      smoothedCrossingNumber γ hγ k l := by
  rw [closedWalkCrossingNumber_from_necSuf, closedWalkCrossingNumber_from_necSuf,
    smoothedSplitWalkA_from_necSuf, smoothedSplitWalkB_from_necSuf,
    splitMutualCrossingNumber_from_necSuf, smoothedCrossingNumber_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.smoothing_split_crossing_partition_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) γ orientedTarget (fun e f => stepTurning e f = 0)
    (fun e => directionAxis (directionNumber e))
    (fun r => smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross r) hkl

end Crossing

end Ising2DLambda.KacWard
