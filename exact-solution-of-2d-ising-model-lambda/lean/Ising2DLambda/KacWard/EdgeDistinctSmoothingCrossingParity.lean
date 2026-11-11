/-
「辺の重複がない閉歩道の平滑化で横断数の偶奇は交差形式に分かれる」
（`claim_edge_distinct_smoothing_crossing_parity`）を、実際の閉じた非後退辺列
`γ : Fin (m + 1) → OrientedEdge L`（辺の標識が相異なる）と横断する添字 `k < l` について述べる具体版。
住処は有限集合の数え上げ（ℕ）と 𝔽₂ で、ℝ / ℂ は現れない。

人手証明との対応:
- 第一段「`n_{v,0}(γ) = n_{v,1}(γ) = 1`」: `crossing_vertexAxisStraightVisitCount_eq_one`。
- 「`c(γ) + 1 = c_sm(γ; k, l) + n_{v,0}(γ) + n_{v,1}(γ)`（`claim_smoothing_crossing_number_update`）」を
  実際の閉歩道へ当てはめたもの: `closedWalk_smoothing_crossing_number_update`。
  各通過の局所データ（直進か否か、軸）を `closedWalkLocalVisit` で読み、横断数・平滑化後の横断数・
  直進通過数がその局所データの数え上げに一致すること（`closedWalkCrossingNumber_eq_localVisit`・
  `smoothedCrossingNumber_eq_localVisit`・`vertexAxisStraightVisitCount_eq_localVisit`）と、
  選んだ二添字が平滑化後に直進しないこと（`smoothedExit_not_straight_left`・
  `smoothedExit_not_straight_right`。直進なら二つの方向番号が一致して軸が一致する）を使う。
- 「`c_sm = c(γ_A) + c(γ_B) + c_×`（`claim_smoothing_split_crossing_partition`）」:
  `smoothing_split_crossing_partition`。
- 「二本の辺の台は互いに素」「二本の各通過は元の添字の平滑化後の通過と一致し、同じ添字対を数える」:
  `smoothedSplitWalks_edge_disjoint`・`splitMutualCrossingNumber_eq_closedWalkMutualCrossingNumber`。
  二本の辺の標識が相異なること: `smoothedSplitWalkA_edge_injective`・`smoothedSplitWalkB_edge_injective`。
- 「`c_× mod 2 = I_L(C_A, C_B)`（`claim_disjoint_walk_mutual_crossing_intersection`）」:
  `closedWalkMutualCrossingNumber_eq_intersection`。
- 「自然数の等式を二で割った余りを取って代入する」: `edge_distinct_smoothing_crossing_parity`。
-/
import Ising2DLambda.KacWard.EdgeDistinctCrossingStraightVisits
import Ising2DLambda.KacWard.SmoothingCrossingNumberUpdate
import Ising2DLambda.KacWard.SmoothingSplitMutualCrossing
import Ising2DLambda.NecSuf.KacWard.EdgeDistinctSmoothingCrossingParity

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

section LocalVisit

/-- 入辺 `γ r`・出辺 `out r` の通過の局所データ: 一歩の回転が零なら直進、軸が一なら縦。 -/
noncomputable def closedWalkLocalVisit (γ out : Fin (m + 1) → OrientedEdge L) (r : Fin (m + 1)) :
    LocalVisit := by
  classical
  exact ⟨if stepTurning (γ r) (out r) = 0 then .straight else .left,
    decide (directionAxis (directionNumber (γ r)) = 1)⟩

omit [NeZero L] in
theorem closedWalkLocalVisit_straight_iff (γ out : Fin (m + 1) → OrientedEdge L) (r : Fin (m + 1)) :
    (closedWalkLocalVisit γ out r).turn = .straight ↔ stepTurning (γ r) (out r) = 0 := by
  unfold closedWalkLocalVisit
  split_ifs with h <;> simp [h]

omit [NeZero L] in
theorem closedWalkLocalVisit_vertical_ne_iff (γ out out' : Fin (m + 1) → OrientedEdge L)
    (r s : Fin (m + 1)) :
    (closedWalkLocalVisit γ out r).vertical ≠ (closedWalkLocalVisit γ out' s).vertical ↔
      directionAxis (directionNumber (γ r)) ≠ directionAxis (directionNumber (γ s)) := by
  have htable : ∀ x y : ZMod 2, (decide (x = 1) ≠ decide (y = 1)) ↔ x ≠ y := by decide
  exact htable _ _

omit [NeZero L] in
theorem closedWalkLocalVisit_vertical_eq_iff (γ out : Fin (m + 1) → OrientedEdge L)
    (r : Fin (m + 1)) (a : ZMod 2) :
    (closedWalkLocalVisit γ out r).vertical = decide (a = 1) ↔
      directionAxis (directionNumber (γ r)) = a := by
  have htable : ∀ x y : ZMod 2, (decide (x = 1) = decide (y = 1)) ↔ x = y := by decide
  exact htable _ _

end LocalVisit

section Update

omit [NeZero L] in
open Classical in
/-- 横断数は、出辺を巡回後続に取った局所データの添字対の横断の数え上げに等しい
（通過の出辺は常に非後退の後続なので、`def_index_pair_crossing` の接続の条件は常に満たされる）。 -/
theorem closedWalkCrossingNumber_eq_localVisit (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    closedWalkCrossingNumber γ hγ =
      ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
        p.1 < p.2 ∧ IndexCrossing (fun r => orientedTarget (γ r))
          (closedWalkLocalVisit γ fun r => γ (closedWalkSuccessor r)) p.1 p.2).card := by
  unfold closedWalkCrossingNumber
  congr 1
  ext p
  simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
  unfold indexPairCrossing edgeTransverseCrossing IndexCrossing TransverseCrossing
  rw [closedWalkLocalVisit_straight_iff, closedWalkLocalVisit_straight_iff,
    closedWalkLocalVisit_vertical_ne_iff]
  constructor
  · rintro ⟨hlt, -, -, -, hv, hs1, hs2, hax⟩
    exact ⟨hlt, hv, hs1, hs2, hax⟩
  · rintro ⟨hlt, hv, hs1, hs2, hax⟩
    exact ⟨hlt, ne_of_lt hlt, closedWalkPass_valid γ hγ p.1, closedWalkPass_valid γ hγ p.2,
      hv, hs1, hs2, hax⟩

omit [NeZero L] in
open Classical in
/-- 平滑化後の横断数は、出辺を平滑化後の出辺に取った局所データの数え上げに等しい。 -/
theorem smoothedCrossingNumber_eq_localVisit (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedCrossingNumber γ hγ k l =
      ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
        p.1 < p.2 ∧ IndexCrossing (fun r => orientedTarget (γ r))
          (closedWalkLocalVisit γ (smoothedExitEdge γ k l)) p.1 p.2).card := by
  unfold smoothedCrossingNumber
  congr 1
  ext p
  simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
  unfold IndexCrossing TransverseCrossing
  rw [closedWalkLocalVisit_straight_iff, closedWalkLocalVisit_straight_iff,
    closedWalkLocalVisit_vertical_ne_iff]

omit [NeZero L] in
open Classical in
/-- 直進通過数 `n_{v,a}(γ)` は、局所データの頂点・直進・軸による数え上げに等しい。 -/
theorem vertexAxisStraightVisitCount_eq_localVisit (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (v : Vertex L) (a : ZMod 2) :
    vertexAxisStraightVisitCount γ hγ v a =
      (Finset.univ.filter fun r : Fin (m + 1) => orientedTarget (γ r) = v ∧
        (closedWalkLocalVisit γ (fun r => γ (closedWalkSuccessor r)) r).turn = .straight ∧
        (closedWalkLocalVisit γ (fun r => γ (closedWalkSuccessor r)) r).vertical =
          decide (a = 1)).card := by
  unfold vertexAxisStraightVisitCount
  congr 1
  ext r
  simp only [Finset.mem_filter, Finset.mem_univ, true_and, closedWalkPassVertex, closedWalkPass]
  rw [closedWalkLocalVisit_straight_iff, closedWalkLocalVisit_vertical_eq_iff]

/-- 選んだ添字 `k` は平滑化後に直進しない（直進なら `dir(f_l) = dir(e_k)` で、`f_l` は `e_l` と
同じ方向なので、二つの軸が一致して横断に反する）。 -/
theorem smoothedExit_not_straight_left (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l) :
    stepTurning (γ k) (smoothedExitEdge γ k l k) ≠ 0 := by
  intro h
  have hmem := smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross k
  rw [stepTurning_eq_zero_iff _ _ hmem] at h
  unfold smoothedExitEdge at h
  rw [if_pos rfl] at h
  obtain ⟨-, hl⟩ := crossing_straight γ hγ hcross
  exact hcross.2.2.2.2.2.2 (by rw [← h, hl])

/-- 選んだ添字 `l` は平滑化後に直進しない（`k` の場合と対称）。 -/
theorem smoothedExit_not_straight_right (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l) :
    stepTurning (γ l) (smoothedExitEdge γ k l l) ≠ 0 := by
  intro h
  have hmem := smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross l
  rw [stepTurning_eq_zero_iff _ _ hmem] at h
  unfold smoothedExitEdge at h
  rw [if_neg (Ne.symm hcross.1), if_pos rfl] at h
  obtain ⟨hk, -⟩ := crossing_straight γ hγ hcross
  exact hcross.2.2.2.2.2.2 (by rw [← h, hk])

/-- `claim_smoothing_crossing_number_update` を実際の閉歩道へ当てはめたもの:
`c(γ) + 1 = c_sm(γ; k, l) + n_{v,0}(γ) + n_{v,1}(γ)`（`v` は横断の頂点）。 -/
theorem closedWalk_smoothing_crossing_number_update (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l) :
    closedWalkCrossingNumber γ hγ + 1 =
      smoothedCrossingNumber γ hγ k l
        + vertexAxisStraightVisitCount γ hγ (orientedTarget (γ k)) 0
        + vertexAxisStraightVisitCount γ hγ (orientedTarget (γ k)) 1 := by
  classical
  have hIndex : IndexCrossing (fun r => orientedTarget (γ r))
      (closedWalkLocalVisit γ fun r => γ (closedWalkSuccessor r)) k l := by
    obtain ⟨-, -, -, hv, hs1, hs2, hax⟩ := hcross
    refine ⟨hv, ?_, ?_, ?_⟩
    · exact (closedWalkLocalVisit_straight_iff _ _ _).mpr hs1
    · exact (closedWalkLocalVisit_straight_iff _ _ _).mpr hs2
    · exact (closedWalkLocalVisit_vertical_ne_iff _ _ _ _ _).mpr hax
  have hother : ∀ r, r ≠ k → r ≠ l →
      closedWalkLocalVisit γ (smoothedExitEdge γ k l) r =
        closedWalkLocalVisit γ (fun r => γ (closedWalkSuccessor r)) r := by
    intro r hrk hrl
    simp only [closedWalkLocalVisit, smoothedExitEdge, if_neg hrk, if_neg hrl]
  have ha : (closedWalkLocalVisit γ (smoothedExitEdge γ k l) k).turn ≠ .straight := by
    rw [Ne, closedWalkLocalVisit_straight_iff]
    exact smoothedExit_not_straight_left γ hγ hcross
  have hb : (closedWalkLocalVisit γ (smoothedExitEdge γ k l) l).turn ≠ .straight := by
    rw [Ne, closedWalkLocalVisit_straight_iff]
    exact smoothedExit_not_straight_right γ hγ hcross
  have h := smoothing_crossing_number_update (fun r => orientedTarget (γ r))
    (closedWalkLocalVisit γ fun r => γ (closedWalkSuccessor r))
    (closedWalkLocalVisit γ (smoothedExitEdge γ k l)) k l hIndex hother ha hb
  rw [closedWalkCrossingNumber_eq_localVisit, smoothedCrossingNumber_eq_localVisit,
    vertexAxisStraightVisitCount_eq_localVisit, vertexAxisStraightVisitCount_eq_localVisit]
  have h0 : decide ((0 : ZMod 2) = 1) = false := by decide
  have h1 : decide ((1 : ZMod 2) = 1) = true := by decide
  rw [h0, h1]
  convert h using 3

end Update

section Split

omit [NeZero L] in
/-- `γ_A` の辺の標識は相異なる。 -/
theorem smoothedSplitWalkA_edge_injective (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k < l) :
    Function.Injective fun i => (smoothedSplitWalkA γ hγ k l i).1 :=
  fun _ _ h => smoothedSplitIndexA_injective hkl (hinj h)

omit [NeZero L] in
/-- `γ_B` の辺の標識は相異なる。 -/
theorem smoothedSplitWalkB_edge_injective (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k < l) :
    Function.Injective fun j => (smoothedSplitWalkB γ hγ k l j).1 :=
  fun _ _ h => smoothedSplitIndexB_injective hkl (hinj h)

omit [NeZero L] in
/-- 二本の辺の台は互いに素である（位置の添字は `A` と `B = I \ A` に分かれ、元の辺の標識は相異なる）。 -/
theorem smoothedSplitWalks_edge_disjoint (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k < l) (i j) :
    (smoothedSplitWalkA γ hγ k l i).1 ≠ (smoothedSplitWalkB γ hγ k l j).1 := by
  intro h
  have hij : smoothedSplitIndexA k l i = smoothedSplitIndexB k l j := hinj h
  have hA := (smoothedSplitIndexA_range γ hγ hkl _).2 ⟨i, rfl⟩
  have hB := (smoothedSplitIndexB_range γ hγ hkl _).2 ⟨j, rfl⟩
  rw [hij] at hA
  exact hB hA

end Split

/-- `claim_edge_distinct_smoothing_crossing_parity`:
`c(γ) mod 2 = ((c(γ_A) + c(γ_B) + 1) mod 2) + I_L(C_A, C_B)`（𝔽₂）。 -/
theorem edge_distinct_smoothing_crossing_parity (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    (closedWalkCrossingNumber γ hγ : ZMod 2) =
      ((closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
            (smoothedSplitWalkA_closed γ hγ hcross hkl)
          + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
            (smoothedSplitWalkB_closed γ hγ hcross hkl) + 1 : ℕ) : ZMod 2)
        + evenEdgeChainIntersection L (closedWalkSupport (smoothedSplitWalkA γ hγ k l))
            (closedWalkSupport (smoothedSplitWalkB γ hγ k l)) := by
  -- 第一段: n_{v,0}(γ) = n_{v,1}(γ) = 1
  have hn0 := crossing_vertexAxisStraightVisitCount_eq_one γ hγ hinj hcross 0
  have hn1 := crossing_vertexAxisStraightVisitCount_eq_one γ hγ hinj hcross 1
  -- c(γ) + 1 = c_sm + n_{v,0} + n_{v,1}
  have hupdate := closedWalk_smoothing_crossing_number_update γ hγ hcross
  -- c(γ_A) + c(γ_B) + c_× = c_sm
  have hpartition := smoothing_split_crossing_partition γ hγ hcross hkl
  -- c_× = c_mut(γ_A, γ_B)
  have hmutual := splitMutualCrossingNumber_eq_closedWalkMutualCrossingNumber γ hγ hcross hkl
  -- c_mut(γ_A, γ_B) mod 2 = I_L(C_A, C_B)
  have hintersection := closedWalkMutualCrossingNumber_eq_intersection
    (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
    (smoothedSplitWalkB γ hγ k l) (smoothedSplitWalkB_closed γ hγ hcross hkl)
    (smoothedSplitWalkA_edge_injective γ hγ hinj hkl)
    (smoothedSplitWalkB_edge_injective γ hγ hinj hkl)
    (smoothedSplitWalks_edge_disjoint γ hγ hinj hkl)
  -- 自然数の加法の消去律: c(γ) = c(γ_A) + c(γ_B) + 1 + c_×
  have hcancel : closedWalkCrossingNumber γ hγ =
      closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
          (smoothedSplitWalkA_closed γ hγ hcross hkl)
        + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
          (smoothedSplitWalkB_closed γ hγ hcross hkl) + 1
        + splitMutualCrossingNumber γ hγ k l := by
    omega
  -- 二で割った余りを取って代入する
  rw [hcancel, Nat.cast_add, hmutual, hintersection]

/-- 具体版が必要十分版の特殊化として得られることの記録（`R = 𝔽₂`、五つの等式は上の具体版の各段）。 -/
theorem edge_distinct_smoothing_crossing_parity_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    (closedWalkCrossingNumber γ hγ : ZMod 2) =
      ((closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
            (smoothedSplitWalkA_closed γ hγ hcross hkl)
          + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
            (smoothedSplitWalkB_closed γ hγ hcross hkl) + 1 : ℕ) : ZMod 2)
        + evenEdgeChainIntersection L (closedWalkSupport (smoothedSplitWalkA γ hγ k l))
            (closedWalkSupport (smoothedSplitWalkB γ hγ k l)) :=
  Ising2DLambda.NecSuf.KacWard.edge_distinct_smoothing_crossing_parity_necSuf _ _ _ _ _ _ _ _ _
    (crossing_vertexAxisStraightVisitCount_eq_one γ hγ hinj hcross 0)
    (crossing_vertexAxisStraightVisitCount_eq_one γ hγ hinj hcross 1)
    (closedWalk_smoothing_crossing_number_update γ hγ hcross)
    (smoothing_split_crossing_partition γ hγ hcross hkl)
    (splitMutualCrossingNumber_eq_closedWalkMutualCrossingNumber γ hγ hcross hkl)
    (closedWalkMutualCrossingNumber_eq_intersection
      (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      (smoothedSplitWalkB γ hγ k l) (smoothedSplitWalkB_closed γ hγ hcross hkl)
      (smoothedSplitWalkA_edge_injective γ hγ hinj hkl)
      (smoothedSplitWalkB_edge_injective γ hγ hinj hkl)
      (smoothedSplitWalks_edge_disjoint γ hγ hinj hkl))

end Ising2DLambda.KacWard
