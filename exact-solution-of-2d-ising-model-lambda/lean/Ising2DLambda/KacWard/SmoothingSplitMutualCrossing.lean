/-
平滑化の混合横断数 `c_×(γ; k, l)`（`def_split_mutual_crossing_number`）が、平滑化で分かれる二本の閉歩道
`γ_A`・`γ_B` の混合横断数（`claim_disjoint_walk_mutual_crossing_intersection` の `c_mut`）に等しいことの具体版。
実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` と横断する添字 `k < l` について述べる。

人手証明（`claim_edge_distinct_smoothing_crossing_parity` の証明の「二本の各通過は元の添字の平滑化後の通過と
一致する。従って混合横断と二本の巡回後続写像による混合横断は、同じ添字対を数える」）との対応:
- 「二本の各通過は元の添字の平滑化後の通過と一致する」: 各位置の辺は `smoothedSplitWalkA_apply`・
  `smoothedSplitWalkB_apply`、その後続は `smoothedSplitWalkA_successor`・`smoothedSplitWalkB_successor`。
- 「同じ添字対を数える」: 位置の対 `(i, j)` を添字の対 `(p_A(i), p_B(j))` へ送る全単射
  （単射性は `smoothedSplitIndexA_injective`・`smoothedSplitIndexB_injective`、像は
  `smoothedSplitIndexA_range`・`smoothedSplitIndexB_range`）。横断の接続の条件は
  `smoothedExitEdge_mem_nonbacktrackingSuccessors` が与える。
-/
import Ising2DLambda.KacWard.SmoothingSplitCrossingPartition
import Ising2DLambda.KacWard.DisjointWalkMutualCrossing
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitMutualCrossing

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

open Classical in
/-- `c_×(γ; k, l) = c_mut(γ_A, γ_B)`。 -/
theorem splitMutualCrossingNumber_eq_closedWalkMutualCrossingNumber
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    splitMutualCrossingNumber γ hγ k l =
      closedWalkMutualCrossingNumber (smoothedSplitWalkA γ hγ k l)
        (smoothedSplitWalkA_closed γ hγ hcross hkl) (smoothedSplitWalkB γ hγ k l)
        (smoothedSplitWalkB_closed γ hγ hcross hkl) := by
  unfold splitMutualCrossingNumber closedWalkMutualCrossingNumber
  symm
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
      exact ⟨smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross _,
        smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross _, h1, h2, h3, h4⟩
    · simp only [hi, hj]

/-- 具体版が必要十分版の特殊化として得られることの記録（接続は非後退の後続、直進は一歩の回転が零、
軸は方向番号の軸）。 -/
theorem splitMutualCrossingNumber_eq_closedWalkMutualCrossingNumber_from_necSuf
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    splitMutualCrossingNumber γ hγ k l =
      closedWalkMutualCrossingNumber (smoothedSplitWalkA γ hγ k l)
        (smoothedSplitWalkA_closed γ hγ hcross hkl) (smoothedSplitWalkB γ hγ k l)
        (smoothedSplitWalkB_closed γ hγ hcross hkl) := by
  rw [splitMutualCrossingNumber_from_necSuf]
  have h := Ising2DLambda.NecSuf.KacWard.splitMutualCrossingNumber_eq_closedWalkMutual_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) γ orientedTarget (fun e f => stepTurning e f = 0)
    (fun e => directionAxis (directionNumber e))
    (fun r => smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross r) hkl
  rw [← h]
  rfl

end Ising2DLambda.KacWard
