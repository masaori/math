/-
「横断消去の帰納法は位相と切断線偶奇と交差形式を保つ」の具体版 `edge_distinct_crossing_elimination_parity` の結論が、
必要十分版 `crossing_elimination_family_necSuf` の特殊化として得られることを示す導出版。
具体版の証明はこのファイルに依存しない。

特殊化: 対象は `ClosedNonbacktrackingWalkData L`、`good` は辺の標識が相異なること、台は `closedWalkSupport`、
横断数・回転数は実際の閉歩道の値、切断線偶奇は ℕ の値を二で割った余りで読み（`hread` は `Nat.ModEq.add_right`）、
`R = 𝔽₂`、交差形式は `evenEdgeChainIntersection`。分割の公理は一回の平滑化の具体版の各補題から得る。
-/
import Mathlib.Data.Nat.ModEq
import Ising2DLambda.KacWard.EdgeDistinctCrossingEliminationParity
import Ising2DLambda.NecSuf.KacWard.EdgeDistinctCrossingEliminationParity

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L : ℕ}

/-- 具体版の列の合併は、必要十分版の列の合併である（定義の対応）。 -/
theorem chainListUnion_eq_finsetListUnion (Cs : List (Finset (Edge L))) :
    chainListUnion Cs = Ising2DLambda.NecSuf.KacWard.finsetListUnion Cs := by
  induction Cs with
  | nil => rfl
  | cons C Cs ih => simp [chainListUnion, Ising2DLambda.NecSuf.KacWard.finsetListUnion, ih]

/-- 具体版の対ごとの和は、必要十分版の対ごとの和に交差形式を代入したものである（定義の対応）。 -/
theorem chainPairIntersectionSum_eq_finsetListPairSum [NeZero L] (Cs : List (Finset (Edge L))) :
    chainPairIntersectionSum Cs =
      Ising2DLambda.NecSuf.KacWard.finsetListPairSum (evenEdgeChainIntersection L) Cs := by
  induction Cs with
  | nil => rfl
  | cons C Cs ih =>
    simp [chainPairIntersectionSum, Ising2DLambda.NecSuf.KacWard.finsetListPairSum, ih]

/-- 具体版が必要十分版 `crossing_elimination_family_necSuf` の特殊化として得られること。 -/
theorem edge_distinct_crossing_elimination_parity_from_necSuf [NeZero L] {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hinj : Function.Injective fun r => (γ r).1) :
    CrossingEliminationFamily γ hγ := by
  have hsplit : ∀ δ : ClosedNonbacktrackingWalkData L,
      (Function.Injective fun r => (δ.walk r).1) → 0 < δ.crossing →
      ∃ a b : ClosedNonbacktrackingWalkData L,
        (Function.Injective fun r => (a.walk r).1) ∧ (Function.Injective fun r => (b.walk r).1) ∧
        a.crossing + b.crossing < δ.crossing ∧ Disjoint a.support b.support ∧
        a.support ∪ b.support = δ.support ∧ a.turning + b.turning = δ.turning ∧
        (a.seam.1 + b.seam.1) % 2 = δ.seam.1 % 2 ∧ (a.seam.2 + b.seam.2) % 2 = δ.seam.2 % 2 ∧
        (δ.crossing : ZMod 2) = ((a.crossing + b.crossing + 1 : ℕ) : ZMod 2)
          + evenEdgeChainIntersection L a.support b.support := by
    rintro ⟨n, δ, hδ⟩ hδinj hpos
    obtain ⟨k, l, hkl, hcross⟩ := exists_indexPairCrossing_of_crossingNumber_pos δ hδ hpos
    have hs := closedWalk_smoothing_split_seam_parity δ hδ hkl
    refine ⟨⟨_, _, smoothedSplitWalkA_closed δ hδ hcross hkl⟩,
      ⟨_, _, smoothedSplitWalkB_closed δ hδ hcross hkl⟩,
      smoothedSplitWalkA_edge_injective δ hδ hδinj hkl,
      smoothedSplitWalkB_edge_injective δ hδ hδinj hkl,
      smoothing_split_crossing_descent δ hδ hcross hkl,
      smoothedSplitWalks_support_disjoint δ hδ hδinj hkl,
      smoothedSplitWalks_support_union δ hδ hkl,
      closedWalk_smoothing_split_turning_sum δ hδ hcross hkl, ?_, ?_,
      edge_distinct_smoothing_crossing_parity δ hδ hδinj hcross hkl⟩
    · have h1 := congrArg Prod.fst hs
      simp only [ClosedNonbacktrackingWalkData.seam] at h1 ⊢
      rw [h1, edgeSequenceSeamParities, Nat.mod_mod]
    · have h2 := congrArg Prod.snd hs
      simp only [ClosedNonbacktrackingWalkData.seam] at h2 ⊢
      rw [h2, edgeSequenceSeamParities, Nat.mod_mod]
  obtain ⟨δs, hne, hdisj, hunion, hzero, hgood, hturn, hseam, hcross⟩ :=
    Ising2DLambda.NecSuf.KacWard.crossing_elimination_family_necSuf
      (fun δ : ClosedNonbacktrackingWalkData L => Function.Injective fun r => (δ.walk r).1)
      (·.support) (·.crossing) (·.turning) (fun δ => δ.seam.1) (fun δ => δ.seam.2)
      (fun x : ℕ => x % 2) (evenEdgeChainIntersection L)
      (fun x x' y h => Nat.ModEq.add_right y h)
      evenEdgeChainIntersection_empty_left evenEdgeChainIntersection_empty_right
      evenEdgeChainIntersection_union_left evenEdgeChainIntersection_union_right
      hsplit ⟨m, γ, hγ⟩ hinj
  refine ⟨δs, hne, hdisj, (chainListUnion_eq_finsetListUnion _).trans hunion, hzero, hgood, hturn,
    ?_, ?_⟩
  · rw [hseam]
    simp [ClosedNonbacktrackingWalkData.seam, edgeSequenceSeamParities]
  · rw [chainPairIntersectionSum_eq_finsetListPairSum]
    exact hcross

end Ising2DLambda.KacWard
