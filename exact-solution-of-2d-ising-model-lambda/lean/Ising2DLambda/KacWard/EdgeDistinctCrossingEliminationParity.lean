/-
「横断消去の帰納法は位相と切断線偶奇と交差形式を保つ」（`claim_edge_distinct_crossing_elimination_parity`）の
具体版。辺の標識が相異なる実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` について、
横断のない閉じた非後退辺列の族 `(δ_i)` を、平滑化 `smoothedSplitWalkA`・`smoothedSplitWalkB` を
横断数についての整礎帰納法で繰り返して作る。住処は ℕ・ℤ・𝔽₂ = `ZMod 2` と有限集合で、ℝ / ℂ は現れない。

族 `(δ_i)_{1≤i≤n}` は長さ付きの閉じた非後退辺列 `ClosedNonbacktrackingWalkData L` のリストで表し、
`n` はリストの長さ、台の合併は `chainListUnion`、`Σ_{1≤i<j≤n} I_L(C_i, C_j)` は `chainPairIntersectionSum`
（先頭の台と後ろの各台の交差形式の和を、後ろの列について再帰的に足したもの）で表す。

人手証明との対応:
- 「`c(γ) = 0` なら `n = 1`、`δ_1 = γ`」: `edge_distinct_crossing_elimination_parity` の基底。
- 「`def_closed_walk_crossing_number` から横断する添字 `k < l` を選ぶ」:
  `exists_indexPairCrossing_of_crossingNumber_pos`。
- 「`C_A ∩ C_B = ∅` かつ `C_A ∪ C_B = C_γ`」: `smoothedSplitWalks_support_disjoint`・
  `smoothedSplitWalks_support_union`。
- 「`claim_smoothing_split_crossing_descent` により各子の横断数は元より小さい」:
  `smoothing_split_crossing_descent`。二本の辺の標識が相異なることは `smoothedSplitWalkA_edge_injective`・
  `smoothedSplitWalkB_edge_injective`。
- 「両族を連結して `(δ_i)_{1≤i≤p+q}` と置く。連結族の台も互いに素で元の台を尽くす」:
  リストの連結 `αs ++ βs`、`chainListUnion_append`、`subset_chainListUnion`。
- 回転数の式の一行目「有限和の分割」: `List.sum_append`。二行目「二本への帰納法の仮定」、
  三行目 `claim_smoothing_split_turning_sum`: `closedWalk_smoothing_split_turning_sum`。
- 切断線偶奇の式の一行目「有限和の分割と二本への帰納法の仮定」: `List.sum_append` と `Nat.add_mod`
  （二で割った余りは和の余りの和の余り）と帰納法の仮定。二行目 `claim_smoothing_split_seam_parity`:
  `closedWalk_smoothing_split_seam_parity`。
- 「交差形式の分配」`I_L(C_A,C_B) = Σ_i Σ_j I_L(C_{α_i},C_{β_j})`: `evenEdgeChainIntersection_chainListUnion`
  （`evenEdgeChainIntersection_union_left`・`evenEdgeChainIntersection_union_right` を互いに素な列へ繰り返す。
  空の辺鎖の値が零であることは `evenEdgeChainIntersection_biUnion_left` の空の族）。
- 横断数の式の一行目 `claim_edge_distinct_smoothing_crossing_parity`: `edge_distinct_smoothing_crossing_parity`。
  二行目「二本への帰納法の仮定」、三行目「上の交差形式の分配と有限和の分割」:
  `chainPairIntersectionSum_append` と `evenEdgeChainIntersection_chainListUnion`。
-/
import Ising2DLambda.KacWard.SmoothingSplitCrossingDescent
import Ising2DLambda.KacWard.SmoothingSplitWalkSeamParity
import Ising2DLambda.KacWard.SmoothingCyclicTurningInvarianceWalk
import Ising2DLambda.KacWard.EvenEdgeChainIntersectionDisjointUnion

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L : ℕ}

/-- 長さ `len + 1` の閉じた非後退辺列（族 `(δ_i)` の一項）。 -/
structure ClosedNonbacktrackingWalkData (L : ℕ) where
  len : ℕ
  walk : Fin (len + 1) → OrientedEdge L
  closed : closedNonbacktrackingWalk walk

/-- 辺の台 `C_δ`。 -/
def ClosedNonbacktrackingWalkData.support (δ : ClosedNonbacktrackingWalkData L) :
    Finset (Edge L) :=
  closedWalkSupport δ.walk

/-- 横断数 `c(δ)`。 -/
noncomputable def ClosedNonbacktrackingWalkData.crossing (δ : ClosedNonbacktrackingWalkData L) :
    ℕ :=
  closedWalkCrossingNumber δ.walk δ.closed

/-- 循環総回転数 `t_∘(δ)`。 -/
def ClosedNonbacktrackingWalkData.turning (δ : ClosedNonbacktrackingWalkData L) : ℤ :=
  cyclicTotalTurning δ.walk δ.closed

/-- 切断線偶奇 `(h(δ), v(δ))`。 -/
def ClosedNonbacktrackingWalkData.seam (δ : ClosedNonbacktrackingWalkData L) : ℕ × ℕ :=
  edgeSequenceSeamParities (List.ofFn δ.walk)

/-- 辺鎖の列の合併 `⋃_i C_i`。 -/
def chainListUnion : List (Finset (Edge L)) → Finset (Edge L)
  | [] => ∅
  | C :: Cs => C ∪ chainListUnion Cs

/-- 辺鎖の列の対ごとの交差形式の和 `Σ_{1≤i<j≤n} I_L(C_i, C_j)`。 -/
def chainPairIntersectionSum [NeZero L] : List (Finset (Edge L)) → ZMod 2
  | [] => 0
  | C :: Cs => (Cs.map fun D => evenEdgeChainIntersection L C D).sum + chainPairIntersectionSum Cs

/-- 二つの辺鎖の列の間の交差形式の和 `Σ_i Σ_j I_L(C_i, D_j)`。 -/
def chainCrossIntersectionSum [NeZero L] (Cs Ds : List (Finset (Edge L))) : ZMod 2 :=
  (Cs.map fun C => (Ds.map fun D => evenEdgeChainIntersection L C D).sum).sum

section Lists

theorem chainListUnion_append (Cs Ds : List (Finset (Edge L))) :
    chainListUnion (Cs ++ Ds) = chainListUnion Cs ∪ chainListUnion Ds := by
  induction Cs with
  | nil => simp [chainListUnion]
  | cons C Cs ih => simp [chainListUnion, ih, Finset.union_assoc]

theorem subset_chainListUnion {Cs : List (Finset (Edge L))} {C : Finset (Edge L)} (h : C ∈ Cs) :
    C ⊆ chainListUnion Cs := by
  induction Cs with
  | nil => simp at h
  | cons D Cs ih =>
    rcases List.mem_cons.mp h with rfl | h
    · exact Finset.subset_union_left
    · exact (ih h).trans Finset.subset_union_right

theorem disjoint_chainListUnion {C : Finset (Edge L)} {Ds : List (Finset (Edge L))}
    (h : ∀ D ∈ Ds, Disjoint C D) : Disjoint C (chainListUnion Ds) := by
  induction Ds with
  | nil => simp [chainListUnion]
  | cons D Ds ih =>
    simp only [chainListUnion, Finset.disjoint_union_right]
    exact ⟨h D List.mem_cons_self, ih fun D' hD' => h D' (List.mem_cons_of_mem _ hD')⟩

/-- 対ごとの和は連結で「各列の中の和」と「列の間の和」に分かれる（有限和の分割）。 -/
theorem chainPairIntersectionSum_append [NeZero L] (Cs Ds : List (Finset (Edge L))) :
    chainPairIntersectionSum (Cs ++ Ds) =
      chainPairIntersectionSum Cs + chainPairIntersectionSum Ds + chainCrossIntersectionSum Cs Ds := by
  induction Cs with
  | nil => simp [chainPairIntersectionSum, chainCrossIntersectionSum]
  | cons C Cs ih =>
    simp only [List.cons_append, chainPairIntersectionSum, ih, chainCrossIntersectionSum,
      List.map_append, List.sum_append, List.map_cons, List.sum_cons]
    abel

end Lists

section Intersection

variable [NeZero L]

/-- 空の辺鎖の交差形式は零である（空の族への分配）。 -/
theorem evenEdgeChainIntersection_empty_left (D : Finset (Edge L)) :
    evenEdgeChainIntersection L ∅ D = 0 := by
  have h := evenEdgeChainIntersection_biUnion_left (∅ : Finset ℕ) (fun _ => (∅ : Finset (Edge L)))
    (by simp) D
  simpa using h

/-- 空の辺鎖の交差形式は零である（第二引数）。 -/
theorem evenEdgeChainIntersection_empty_right (C : Finset (Edge L)) :
    evenEdgeChainIntersection L C ∅ = 0 := by
  have h := evenEdgeChainIntersection_biUnion_right C (∅ : Finset ℕ)
    (fun _ => (∅ : Finset (Edge L))) (by simp)
  simpa using h

/-- 第一引数の分配: 互いに素な列の合併について `I_L(⋃_i C_i, D) = Σ_i I_L(C_i, D)`。 -/
theorem evenEdgeChainIntersection_chainListUnion_left {Cs : List (Finset (Edge L))}
    (hCs : Cs.Pairwise Disjoint) (D : Finset (Edge L)) :
    evenEdgeChainIntersection L (chainListUnion Cs) D =
      (Cs.map fun C => evenEdgeChainIntersection L C D).sum := by
  induction Cs with
  | nil => simp [chainListUnion, evenEdgeChainIntersection_empty_left]
  | cons C Cs ih =>
    obtain ⟨hC, hCs'⟩ := List.pairwise_cons.mp hCs
    simp only [chainListUnion, List.map_cons, List.sum_cons]
    rw [evenEdgeChainIntersection_union_left _ _ _ (disjoint_chainListUnion hC), ih hCs']

/-- 第二引数の分配: 互いに素な列の合併について `I_L(C, ⋃_j D_j) = Σ_j I_L(C, D_j)`。 -/
theorem evenEdgeChainIntersection_chainListUnion_right (C : Finset (Edge L))
    {Ds : List (Finset (Edge L))} (hDs : Ds.Pairwise Disjoint) :
    evenEdgeChainIntersection L C (chainListUnion Ds) =
      (Ds.map fun D => evenEdgeChainIntersection L C D).sum := by
  induction Ds with
  | nil => simp [chainListUnion, evenEdgeChainIntersection_empty_right]
  | cons D Ds ih =>
    obtain ⟨hD, hDs'⟩ := List.pairwise_cons.mp hDs
    simp only [chainListUnion, List.map_cons, List.sum_cons]
    rw [evenEdgeChainIntersection_union_right _ _ _ (disjoint_chainListUnion hD), ih hDs']

/-- 本文の一行「交差形式の分配」: `I_L(⋃_i C_i, ⋃_j D_j) = Σ_i Σ_j I_L(C_i, D_j)`。 -/
theorem evenEdgeChainIntersection_chainListUnion {Cs Ds : List (Finset (Edge L))}
    (hCs : Cs.Pairwise Disjoint) (hDs : Ds.Pairwise Disjoint) :
    evenEdgeChainIntersection L (chainListUnion Cs) (chainListUnion Ds) =
      chainCrossIntersectionSum Cs Ds := by
  rw [evenEdgeChainIntersection_chainListUnion_left hCs, chainCrossIntersectionSum]
  congr 1
  exact List.map_congr_left fun C _ => evenEdgeChainIntersection_chainListUnion_right C hDs

end Intersection

section Split

variable {m : ℕ}

/-- 横断数が正なら、横断する添字 `k < l` がある（`def_closed_walk_crossing_number`）。 -/
theorem exists_indexPairCrossing_of_crossingNumber_pos (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hpos : 0 < closedWalkCrossingNumber γ hγ) :
    ∃ k l : Fin (m + 1), k < l ∧ indexPairCrossing γ hγ k l := by
  classical
  unfold closedWalkCrossingNumber at hpos
  obtain ⟨p, hp⟩ := Finset.card_pos.mp hpos
  exact ⟨p.1, p.2, (Finset.mem_filter.mp hp).2⟩

/-- 二本の辺の台の合併は元の台である（`B = I \ A`）。 -/
theorem smoothedSplitWalks_support_union (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    closedWalkSupport (smoothedSplitWalkA γ hγ k l) ∪ closedWalkSupport (smoothedSplitWalkB γ hγ k l)
      = closedWalkSupport γ := by
  ext e
  simp only [closedWalkSupport, mem_union, mem_image, mem_univ, true_and, smoothedSplitWalkA_apply,
    smoothedSplitWalkB_apply]
  constructor
  · rintro (⟨j, rfl⟩ | ⟨j, rfl⟩)
    · exact ⟨_, rfl⟩
    · exact ⟨_, rfl⟩
  · rintro ⟨r, rfl⟩
    by_cases hr : r ∈ smoothingIndexBlockA γ hγ k l
    · obtain ⟨j, hj⟩ := (smoothedSplitIndexA_range γ hγ hkl r).1 hr
      exact Or.inl ⟨j, by rw [hj]⟩
    · obtain ⟨j, hj⟩ := (smoothedSplitIndexB_range γ hγ hkl r).1 hr
      exact Or.inr ⟨j, by rw [hj]⟩

/-- 元の辺の標識が相異なれば、二本の辺の台は互いに素である。 -/
theorem smoothedSplitWalks_support_disjoint (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k < l) :
    Disjoint (closedWalkSupport (smoothedSplitWalkA γ hγ k l))
      (closedWalkSupport (smoothedSplitWalkB γ hγ k l)) := by
  rw [Finset.disjoint_left]
  intro e heA heB
  simp only [closedWalkSupport, mem_image, mem_univ, true_and] at heA heB
  obtain ⟨i, rfl⟩ := heA
  obtain ⟨j, hj⟩ := heB
  exact smoothedSplitWalks_edge_disjoint γ hγ hinj hkl i j hj.symm

end Split

/-- 本文の主張の結論: 横断のない閉じた非後退辺列の族 `(δ_i)_{1≤i≤n}`（`n ≥ 1`。各項の辺の標識は相異なる）があり、台は互いに素で
合併は `C_γ`、回転数の和は `t_∘(γ)`、切断線偶奇の和は `(h(γ), v(γ))`、
`c(γ) mod 2 = (n - 1) + Σ_{i<j} I_L(C_i, C_j)`（𝔽₂）。 -/
def CrossingEliminationFamily [NeZero L] {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) : Prop :=
  ∃ δs : List (ClosedNonbacktrackingWalkData L), δs ≠ [] ∧
    (δs.map (·.support)).Pairwise Disjoint ∧
    chainListUnion (δs.map (·.support)) = closedWalkSupport γ ∧
    (∀ δ ∈ δs, δ.crossing = 0) ∧
    (∀ δ ∈ δs, Function.Injective fun r => (δ.walk r).1) ∧
    (δs.map (·.turning)).sum = cyclicTotalTurning γ hγ ∧
    ((δs.map fun δ => δ.seam.1).sum % 2, (δs.map fun δ => δ.seam.2).sum % 2) =
      edgeSequenceSeamParities (List.ofFn γ) ∧
    (closedWalkCrossingNumber γ hγ : ZMod 2) =
      ((δs.length - 1 : ℕ) : ZMod 2) + chainPairIntersectionSum (δs.map (·.support))

/-- `claim_edge_distinct_crossing_elimination_parity`: 辺の標識が相異なる閉じた非後退辺列は、
横断数についての整礎帰納法で、本文の性質を持つ横断のない族へ分かれる。 -/
theorem edge_distinct_crossing_elimination_parity [NeZero L] {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hinj : Function.Injective fun r => (γ r).1) :
    CrossingEliminationFamily γ hγ := by
  -- c(γ) ∈ ℕ に関する整礎帰納法
  suffices H : ∀ N : ℕ, ∀ {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
      (hγ : closedNonbacktrackingWalk γ), (Function.Injective fun r => (γ r).1) →
      closedWalkCrossingNumber γ hγ = N → CrossingEliminationFamily γ hγ from
    H _ γ hγ hinj rfl
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
  intro m γ hγ hinj hN
  rcases Nat.eq_zero_or_pos N with h0 | hpos
  · -- c(γ) = 0 なら n = 1、δ_1 = γ
    refine ⟨[⟨m, γ, hγ⟩], List.cons_ne_nil _ _, List.pairwise_singleton _ _, ?_, ?_, ?_, ?_, ?_, ?_⟩
    · simp [chainListUnion, ClosedNonbacktrackingWalkData.support]
    · intro δ hδ
      rw [List.mem_singleton.mp hδ]
      exact hN.trans h0
    · -- δ_1 = γ の辺の標識は相異なる
      intro δ hδ
      rw [List.mem_singleton.mp hδ]
      exact hinj
    · simp [ClosedNonbacktrackingWalkData.turning]
    · simp [ClosedNonbacktrackingWalkData.seam, edgeSequenceSeamParities]
    · simp [chainPairIntersectionSum, hN, h0]
  · -- 横断する添字 k < l を選ぶ
    obtain ⟨k, l, hkl, hcross⟩ :=
      exists_indexPairCrossing_of_crossingNumber_pos γ hγ (hN ▸ hpos)
    -- 二本 γ_A・γ_B
    set γA := smoothedSplitWalkA γ hγ k l with hγA
    set γB := smoothedSplitWalkB γ hγ k l with hγB
    have hA := smoothedSplitWalkA_closed γ hγ hcross hkl
    have hB := smoothedSplitWalkB_closed γ hγ hcross hkl
    -- 各子の横断数は元より小さい
    have hdesc := smoothing_split_crossing_descent γ hγ hcross hkl
    have hltA : closedWalkCrossingNumber γA hA < N :=
      hN ▸ lt_of_le_of_lt (Nat.le_add_right _ _) hdesc
    have hltB : closedWalkCrossingNumber γB hB < N :=
      hN ▸ lt_of_le_of_lt (Nat.le_add_left _ _) hdesc
    -- 帰納法を二本へ適用する
    obtain ⟨αs, hαne, hαdisj, hαunion, hαzero, hαinj, hαturn, hαseam, hαcross⟩ :=
      ih _ hltA γA hA (smoothedSplitWalkA_edge_injective γ hγ hinj hkl) rfl
    obtain ⟨βs, hβne, hβdisj, hβunion, hβzero, hβinj, hβturn, hβseam, hβcross⟩ :=
      ih _ hltB γB hB (smoothedSplitWalkB_edge_injective γ hγ hinj hkl) rfl
    -- 二本の台の分割 C_A ∩ C_B = ∅、C_A ∪ C_B = C_γ
    have hABdisj := smoothedSplitWalks_support_disjoint γ hγ hinj hkl
    have hABunion := smoothedSplitWalks_support_union γ hγ hkl
    -- 両族を連結して (δ_i)_{1≤i≤p+q} と置く
    refine ⟨αs ++ βs, by simp [hαne], ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
    · -- 連結族の台も互いに素
      rw [List.map_append, List.pairwise_append]
      refine ⟨hαdisj, hβdisj, fun C hC D hD => ?_⟩
      have hCA : C ⊆ closedWalkSupport γA := hαunion ▸ subset_chainListUnion hC
      have hDB : D ⊆ closedWalkSupport γB := hβunion ▸ subset_chainListUnion hD
      exact Finset.disjoint_of_subset_left hCA (Finset.disjoint_of_subset_right hDB hABdisj)
    · -- 連結族の台は元の台を尽くす
      rw [List.map_append, chainListUnion_append, hαunion, hβunion, hABunion]
    · intro δ hδ
      rcases List.mem_append.mp hδ with h | h
      · exact hαzero δ h
      · exact hβzero δ h
    · -- 連結族の各項の辺の標識は相異なる（二本への帰納法の仮定）
      intro δ hδ
      rcases List.mem_append.mp hδ with h | h
      · exact hαinj δ h
      · exact hβinj δ h
    · -- Σ t_∘(δ_i) = Σ t_∘(α_i) + Σ t_∘(β_j) = t_∘(γ_A) + t_∘(γ_B) = t_∘(γ)
      calc ((αs ++ βs).map (·.turning)).sum
          = (αs.map (·.turning)).sum + (βs.map (·.turning)).sum := by
            rw [List.map_append, List.sum_append]
        _ = cyclicTotalTurning γA hA + cyclicTotalTurning γB hB := by rw [hαturn, hβturn]
        _ = cyclicTotalTurning γ hγ := closedWalk_smoothing_split_turning_sum γ hγ hcross hkl
    · -- ⊕(h(δ_i), v(δ_i)) = (h(γ_A), v(γ_A)) ⊕ (h(γ_B), v(γ_B)) = (h(γ), v(γ))
      have hαh := congrArg Prod.fst hαseam
      have hαv := congrArg Prod.snd hαseam
      have hβh := congrArg Prod.fst hβseam
      have hβv := congrArg Prod.snd hβseam
      simp only at hαh hαv hβh hβv
      calc (((αs ++ βs).map fun δ => δ.seam.1).sum % 2, ((αs ++ βs).map fun δ => δ.seam.2).sum % 2)
          = ((((αs.map fun δ => δ.seam.1).sum % 2) + ((βs.map fun δ => δ.seam.1).sum % 2)) % 2,
              (((αs.map fun δ => δ.seam.2).sum % 2) + ((βs.map fun δ => δ.seam.2).sum % 2)) % 2) := by
            rw [List.map_append, List.sum_append, List.map_append, List.sum_append, Nat.add_mod,
              Nat.add_mod ((αs.map fun δ => δ.seam.2).sum)]
        _ = (((edgeSequenceSeamParities (List.ofFn γA)).1
                + (edgeSequenceSeamParities (List.ofFn γB)).1) % 2,
              ((edgeSequenceSeamParities (List.ofFn γA)).2
                + (edgeSequenceSeamParities (List.ofFn γB)).2) % 2) := by
            rw [hαh, hαv, hβh, hβv]
        _ = edgeSequenceSeamParities (List.ofFn γ) := closedWalk_smoothing_split_seam_parity γ hγ hkl
    · -- c(γ) mod 2 = c(γ_A) + c(γ_B) + 1 + I_L(C_A, C_B) = (p + q - 1) + Σ_{i<j} I_L(C_i, C_j)
      have hp : 1 ≤ αs.length := List.length_pos_iff.mpr hαne
      have hq : 1 ≤ βs.length := List.length_pos_iff.mpr hβne
      have hlen : (αs ++ βs).length - 1 = (αs.length - 1) + (βs.length - 1) + 1 := by
        rw [List.length_append]; omega
      have hdist : evenEdgeChainIntersection L (closedWalkSupport γA) (closedWalkSupport γB) =
          chainCrossIntersectionSum (αs.map (·.support)) (βs.map (·.support)) := by
        rw [← hαunion, ← hβunion]
        exact evenEdgeChainIntersection_chainListUnion hαdisj hβdisj
      calc (closedWalkCrossingNumber γ hγ : ZMod 2)
          = ((closedWalkCrossingNumber γA hA + closedWalkCrossingNumber γB hB + 1 : ℕ) : ZMod 2)
              + evenEdgeChainIntersection L (closedWalkSupport γA) (closedWalkSupport γB) :=
            edge_distinct_smoothing_crossing_parity γ hγ hinj hcross hkl
        _ = (((αs.length - 1 : ℕ) : ZMod 2) + chainPairIntersectionSum (αs.map (·.support)))
              + (((βs.length - 1 : ℕ) : ZMod 2) + chainPairIntersectionSum (βs.map (·.support))) + 1
              + chainCrossIntersectionSum (αs.map (·.support)) (βs.map (·.support)) := by
            rw [Nat.cast_add, Nat.cast_add, Nat.cast_one, ← hαcross, ← hβcross, hdist]
        _ = (((αs ++ βs).length - 1 : ℕ) : ZMod 2)
              + chainPairIntersectionSum ((αs ++ βs).map (·.support)) := by
            rw [hlen, List.map_append, chainPairIntersectionSum_append]
            push_cast
            ring

end Ising2DLambda.KacWard
