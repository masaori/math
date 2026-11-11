/-
「平滑化で分けた二本の横断数の和は元より小さい」（`claim_smoothing_split_crossing_descent`）を、
実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` と横断する添字 `k < l` について述べる具体版。
住処は有限集合の数え上げ（ℕ）で、ℝ / ℂ は現れない。辺の標識が相異なることは仮定しない。

人手証明との対応:
- 「選んだ二つの通過は横断するので、横断頂点 v で互いに異なる二軸を直進する。従って
  1 ≤ n_{v,0}(γ)、1 ≤ n_{v,1}(γ)」: `crossing_vertexAxisStraightVisitCount_pos`
  （軸 `a` が `k` の軸なら `k`、そうでなければ `l` の軸なので `l` が数えられる）。
- 「`= c_sm + n_{v,0} + n_{v,1}`（`claim_smoothing_split_crossing_partition`）」:
  `smoothing_split_crossing_partition`。
- 「`= c(γ) + 1`（`claim_smoothing_crossing_number_update`）」:
  `closedWalk_smoothing_crossing_number_update`。
- 不等式の鎖と「自然数の順序でこの不等式から」: `smoothing_split_crossing_descent` の `omega`。
-/
import Ising2DLambda.KacWard.EdgeDistinctSmoothingCrossingParity
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitCrossingDescent

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

omit [NeZero L] in
/-- 横断の頂点 `v` で各軸の直進通過数は一以上である（`1 ≤ n_{v,a}(γ)`）。 -/
theorem crossing_vertexAxisStraightVisitCount_pos (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (a : ZMod 2) :
    1 ≤ vertexAxisStraightVisitCount γ hγ (orientedTarget (γ k)) a := by
  classical
  obtain ⟨-, -, -, hv, hsk, hsl, haxis⟩ := hcross
  have htwo : ∀ x y z : ZMod 2, x ≠ y → z = x ∨ z = y := by decide
  unfold vertexAxisStraightVisitCount
  simp only [closedWalkPassVertex, closedWalkPass]
  rcases htwo _ _ a haxis with ha | ha
  · exact card_pos.mpr ⟨k, mem_filter.mpr ⟨mem_univ _, rfl, hsk, ha.symm⟩⟩
  · exact card_pos.mpr ⟨l, mem_filter.mpr ⟨mem_univ _, hv.symm, hsl, ha.symm⟩⟩

/-- `claim_smoothing_split_crossing_descent`: `c(γ_A) + c(γ_B) < c(γ)`。 -/
theorem smoothing_split_crossing_descent (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
        (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
        (smoothedSplitWalkB_closed γ hγ hcross hkl)
      < closedWalkCrossingNumber γ hγ := by
  -- 1 ≤ n_{v,0}(γ)、1 ≤ n_{v,1}(γ)
  have hn0 := crossing_vertexAxisStraightVisitCount_pos γ hγ hcross 0
  have hn1 := crossing_vertexAxisStraightVisitCount_pos γ hγ hcross 1
  -- c(γ_A) + c(γ_B) + c_× = c_sm
  have hpartition := smoothing_split_crossing_partition γ hγ hcross hkl
  -- c_sm + n_{v,0} + n_{v,1} = c(γ) + 1
  have hupdate := closedWalk_smoothing_crossing_number_update γ hγ hcross
  -- 不等式の鎖と自然数の順序
  omega

omit [NeZero L] in
/-- 具体版の第一段が必要十分版 `crossing_straightVisitCount_pos_necSuf` の特殊化として得られること。
通過の添字を歩道の添字、頂点を入辺の終点、直進を一歩の回転数が零、軸を入辺の方向の軸に取る。 -/
theorem crossing_vertexAxisStraightVisitCount_pos_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (a : ZMod 2) :
    1 ≤ vertexAxisStraightVisitCount γ hγ (orientedTarget (γ k)) a := by
  classical
  unfold vertexAxisStraightVisitCount
  simp only [closedWalkPassVertex, closedWalkPass]
  exact Ising2DLambda.NecSuf.KacWard.crossing_straightVisitCount_pos_necSuf
    (fun r => orientedTarget (γ r))
    (fun r => stepTurning (γ r) (γ (closedWalkSuccessor r)) = 0)
    (fun r => directionAxis (directionNumber (γ r)))
    (by decide) k l hcross.2.2.2.1 hcross.2.2.2.2.1 hcross.2.2.2.2.2.1 hcross.2.2.2.2.2.2 a

/-- 具体版が必要十分版 `smoothing_split_crossing_descent_necSuf` の特殊化として得られること
（四つの自然数の関係は上の具体版の各段）。 -/
theorem smoothing_split_crossing_descent_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
        (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
        (smoothedSplitWalkB_closed γ hγ hcross hkl)
      < closedWalkCrossingNumber γ hγ :=
  Ising2DLambda.NecSuf.KacWard.smoothing_split_crossing_descent_necSuf _ _ _ _ _ _
    (smoothing_split_crossing_partition γ hγ hcross hkl)
    (closedWalk_smoothing_crossing_number_update γ hγ hcross)
    (crossing_vertexAxisStraightVisitCount_pos γ hγ hcross 0)
    (crossing_vertexAxisStraightVisitCount_pos γ hγ hcross 1)

end Ising2DLambda.KacWard
