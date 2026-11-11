/-
「横断の平滑化は循環総回転数を保つ」（`claim_smoothing_cyclic_turning_invariance`）を、
実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` と横断する添字 `k, l` について述べる具体版。
住処は ℤ（一歩の回転数の有限和）で、ℝ / ℂ は現れない。
本文の添字 `r ∈ I_{m+1}` は Lean の `r - 1`、本文の `σ` は `closedWalkSuccessor`、
`τ(e_r, f_r)` は `stepTurning (γ r) (smoothedExitEdge γ k l r)`。

人手証明との対応:
- 第一の準備「横断の直進性により `τ(e_k, e_{σ(k)}) = 0`、`τ(e_l, e_{σ(l)}) = 0`」:
  `indexPairCrossing` の第二成分 `edgeTransverseCrossing` の第四・第五成分。
- 第二の準備の四つの接続: 横断の第一・第二成分（元の接続）と、
  `def_smoothed_cyclic_total_turning` の確認 `swappedExit_mem_nonbacktrackingSuccessors`（交換分）。
- 「`claim_reconnection_turning_difference` を `e = e_k`、`e' = e_l`、`f = e_{σ(k)}`、`f' = e_{σ(l)}` に適用」:
  `edge_reconnection_turning_difference`。その主張の具体版 `reconnection_turning_difference` は方向番号と
  回転を仮定で受けるので、ここでは実際の向き付き辺について同じ証明（`step_advances_direction` の
  四つの適用 → 二つの鎖 → 剰余の一致 → 4 の整除 → 値域）を書く。
- 「`−S ∈ {−4,0,4}`、`S ∈ {−4,0,4}`、`−2 ≤ S ≤ 2` から `S = 0`」: `stepTurning_mem` の場合分けと整数の線型算術。
- 式変形の一行目〜六行目（二項を分ける → `f_r` の定義 → `S = 0` → 第一の準備 → 二項を戻す）:
  `sum_split_two_indices` と `smoothedExitEdge_of_ne`。
- 七行目〜九行目（`σ` の定義、`def_total_turning`、`def_cyclic_total_turning`）:
  `cyclicTotalTurning_eq_sum_successor`。
- 本文の `k < l` は証明に使わないので、仮定は横断（`k ≠ l` を含む）だけにした。

`claim_smoothing_split_turning_sum` の最後の行との合成を `closedWalk_smoothing_split_turning_sum` に置く。
-/
import Ising2DLambda.KacWard.SmoothingSplitWalkTurningSum
import Ising2DLambda.NecSuf.KacWard.SmoothingCyclicTurningInvarianceWalk

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L m : ℕ}

/-- 一歩の回転数は 0, 1, -1 のいずれかである（`def_step_turning` の値の場合分け）。 -/
theorem stepTurning_mem (e f : OrientedEdge L) :
    stepTurning e f = 0 ∨ stepTurning e f = 1 ∨ stepTurning e f = -1 := by
  unfold stepTurning
  split_ifs <;> simp

/-- 巡回後続で書いた和は循環総回転数である（`def_closed_walk_passes` の `σ`、`def_total_turning`、
`def_cyclic_total_turning`）。 -/
theorem cyclicTotalTurning_eq_sum_successor (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    ∑ r : Fin (m + 1), stepTurning (γ r) (γ (closedWalkSuccessor r)) = cyclicTotalTurning γ hγ := by
  rw [Fin.sum_univ_castSucc]
  have hinner : ∀ j : Fin m, closedWalkSuccessor (Fin.castSucc j) = Fin.succ j := by
    intro j
    simp [closedWalkSuccessor, Fin.ext_iff]
  have hlast : closedWalkSuccessor (Fin.last m) = 0 := by
    simp [closedWalkSuccessor]
  simp only [hinner, hlast, cyclicTotalTurning_eq, edgeSequenceTotalTurning_eq]

/-- 有限和から相異なる二添字の項を分ける。 -/
theorem sum_split_two_indices (g : Fin (m + 1) → ℤ) {k l : Fin (m + 1)} (hkl : k ≠ l) :
    ∑ r : Fin (m + 1), g r = ∑ r ∈ (univ.erase k).erase l, g r + (g k + g l) := by
  have hlmem : l ∈ univ.erase k := mem_erase.mpr ⟨Ne.symm hkl, mem_univ l⟩
  rw [← sum_erase_add _ g (mem_univ k), ← sum_erase_add _ g hlmem]
  ring

variable [NeZero L]

/-- 接続の組み替えの回転差は −4, 0, 4 に限る（`claim_reconnection_turning_difference`）を、
実際の向き付き辺の四つの接続について述べたもの。 -/
theorem edge_reconnection_turning_difference {e e' f f' : OrientedEdge L}
    (hef : f ∈ nonbacktrackingSuccessors e) (he'f' : f' ∈ nonbacktrackingSuccessors e')
    (hef' : f' ∈ nonbacktrackingSuccessors e) (he'f : f ∈ nonbacktrackingSuccessors e') :
    (stepTurning e f + stepTurning e' f') - (stepTurning e f' + stepTurning e' f) = -4 ∨
      (stepTurning e f + stepTurning e' f') - (stepTurning e f' + stepTurning e' f) = 0 ∨
      (stepTurning e f + stepTurning e' f') - (stepTurning e f' + stepTurning e' f) = 4 := by
  -- 組 (e→f, e'→f') の接続での展開
  have h1 : directionNumber f + directionNumber f' =
      (directionNumber e + directionNumber e') +
        directionResidueProjection (stepTurning e f + stepTurning e' f') := by
    rw [step_advances_direction e f hef, step_advances_direction e' f' he'f',
      directionResidueProjection_add, add_add_add_comm]
  -- 組 (e→f', e'→f) の接続での展開
  have h2 : directionNumber f + directionNumber f' =
      (directionNumber e + directionNumber e') +
        directionResidueProjection (stepTurning e f' + stepTurning e' f) := by
    rw [step_advances_direction e' f he'f, step_advances_direction e f' hef',
      directionResidueProjection_add, add_add_add_comm, add_comm (directionNumber e'),
      add_comm (directionResidueProjection (stepTurning e' f))]
  -- 左辺が同じなので π₄(S₁) = π₄(S₂)
  have hcong : directionResidueProjection (stepTurning e f + stepTurning e' f') =
      directionResidueProjection (stepTurning e f' + stepTurning e' f) :=
    add_left_cancel (h1.symm.trans h2)
  -- π₄(D) = 0 から 4 ∣ D
  have hzero : (((stepTurning e f + stepTurning e' f') - (stepTurning e f' + stepTurning e' f) : ℤ)
      : ZMod 4) = 0 := by
    rw [Int.cast_sub]
    exact sub_eq_zero.mpr hcong
  have hdvd := (ZMod.intCast_zmod_eq_zero_iff_dvd _ 4).mp hzero
  -- 一歩の回転数の値域から −4 ≤ D ≤ 4
  rcases stepTurning_mem e f with h₁ | h₁ | h₁ <;>
    rcases stepTurning_mem e' f' with h₂ | h₂ | h₂ <;>
    rcases stepTurning_mem e f' with h₃ | h₃ | h₃ <;>
    rcases stepTurning_mem e' f with h₄ | h₄ | h₄ <;>
    omega

/-- 横断の平滑化は循環総回転数を保つ: `t_sm(γ; k, l) = t_∘(γ)`（実際の閉歩道についての具体版）。 -/
theorem closedWalk_smoothing_cyclic_turning_invariance (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) :
    smoothedCyclicTotalTurning γ hγ k l = cyclicTotalTurning γ hγ := by
  obtain ⟨hkl, hcr⟩ := hcross
  -- 第一の準備（横断の直進性）と、第二の準備の四つの接続
  -- （交換分は `def_smoothed_cyclic_total_turning` の確認）
  have hk := hcr.1
  have hl := hcr.2.1
  have h0k := hcr.2.2.2.1
  have h0l := hcr.2.2.2.2.1
  have hkl' := swappedExit_mem_nonbacktrackingSuccessors hcr
  have hlk' := swappedExit_mem_nonbacktrackingSuccessors' hcr
  -- `claim_reconnection_turning_difference` の適用
  have hD := edge_reconnection_turning_difference hk hl hkl' hlk'
  -- 第一の準備と値域から S = 0
  have hS : stepTurning (γ k) (γ (closedWalkSuccessor l))
      + stepTurning (γ l) (γ (closedWalkSuccessor k)) = 0 := by
    rcases stepTurning_mem (γ k) (γ (closedWalkSuccessor l)) with h | h | h <;>
      rcases stepTurning_mem (γ l) (γ (closedWalkSuccessor k)) with h' | h' | h' <;>
      omega
  have hexk : smoothedExitEdge γ k l k = γ (closedWalkSuccessor l) := by
    unfold smoothedExitEdge
    rw [if_pos rfl]
  have hexl : smoothedExitEdge γ k l l = γ (closedWalkSuccessor k) := by
    unfold smoothedExitEdge
    rw [if_neg (Ne.symm hkl), if_pos rfl]
  have hrest : ∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (smoothedExitEdge γ k l r)
      = ∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (γ (closedWalkSuccessor r)) := by
    apply sum_congr rfl
    intro r hr
    rw [smoothedExitEdge_of_ne γ (ne_of_mem_erase (mem_of_mem_erase hr)) (ne_of_mem_erase hr)]
  calc smoothedCyclicTotalTurning γ hγ k l
      = ∑ r : Fin (m + 1), stepTurning (γ r) (smoothedExitEdge γ k l r) := rfl
    _ = ∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (smoothedExitEdge γ k l r)
          + (stepTurning (γ k) (smoothedExitEdge γ k l k)
            + stepTurning (γ l) (smoothedExitEdge γ k l l)) :=
        sum_split_two_indices _ hkl
    _ = ∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (γ (closedWalkSuccessor r))
          + (stepTurning (γ k) (γ (closedWalkSuccessor l))
            + stepTurning (γ l) (γ (closedWalkSuccessor k))) := by
        rw [hrest, hexk, hexl]
    _ = ∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (γ (closedWalkSuccessor r)) := by
        rw [hS, add_zero]
    _ = ∑ r ∈ (univ.erase k).erase l, stepTurning (γ r) (γ (closedWalkSuccessor r))
          + (stepTurning (γ k) (γ (closedWalkSuccessor k))
            + stepTurning (γ l) (γ (closedWalkSuccessor l))) := by
        rw [h0k, h0l, add_zero, add_zero]
    _ = ∑ r : Fin (m + 1), stepTurning (γ r) (γ (closedWalkSuccessor r)) :=
        (sum_split_two_indices _ hkl).symm
    _ = cyclicTotalTurning γ hγ := cyclicTotalTurning_eq_sum_successor γ hγ

/-- 具体版が必要十分版 `smoothing_cyclic_turning_invariance_walk_necSuf` の特殊化として得られること。
辺を向き付き辺、方向を `ZMod 4` の方向番号、`π` を剰余への射影に取る。 -/
theorem closedWalk_smoothing_cyclic_turning_invariance_from_necSuf
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) :
    smoothedCyclicTotalTurning γ hγ k l = cyclicTotalTurning γ hγ := by
  rw [smoothedCyclicTotalTurning_from_necSuf, cyclicTotalTurning_from_necSuf]
  obtain ⟨hkl, hcr⟩ := hcross
  exact Ising2DLambda.NecSuf.KacWard.smoothing_cyclic_turning_invariance_walk_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) stepTurning directionNumber
    (Int.castAddHom (ZMod 4))
    (fun D h => (ZMod.intCast_zmod_eq_zero_iff_dvd D 4).mp h)
    stepTurning_mem
    (fun e f hf => step_advances_direction e f hf)
    γ hkl hcr.1 hcr.2.1
    (swappedExit_mem_nonbacktrackingSuccessors hcr)
    (swappedExit_mem_nonbacktrackingSuccessors' hcr) hcr.2.2.2.1 hcr.2.2.2.2.1

/-- `claim_smoothing_split_turning_sum` の全体: 二本の閉歩道の循環総回転数の和は `t_∘(γ)` に等しい。
合わせる段（`smoothing_split_walk_turning_sum`）と最後の行（この主張）の合成。 -/
theorem closedWalk_smoothing_split_turning_sum (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l)
          (smoothedSplitWalkB_closed γ hγ hcross hkl)
      = cyclicTotalTurning γ hγ := by
  rw [smoothing_split_walk_turning_sum γ hγ hcross hkl,
    closedWalk_smoothing_cyclic_turning_invariance γ hγ hcross]

end Ising2DLambda.KacWard
