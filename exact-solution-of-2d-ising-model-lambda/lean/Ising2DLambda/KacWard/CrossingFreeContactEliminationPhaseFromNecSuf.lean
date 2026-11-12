/-
「横断のない閉歩道の回転位相は頂点単純閉路族の位相と交差形式に還元される」の具体版
`crossing_free_contact_elimination_phase` の結論が、必要十分版 `contact_elimination_family_necSuf` の
特殊化として得られることを示す導出版。具体版の証明はこのファイルに依存しない。

特殊化: 対象は `ClosedNonbacktrackingWalkData L`、`good` は辺の標識が相異なり横断数が零であること、
測度は接触対数 `contactPairCount`、台は `closedWalkSupport`、位相は `z ^ t_∘`（`G = Qbar` の乗法）、
`R = 𝔽₂`、符号は `x ↦ (−1)^{x.val}`、切断線偶奇は ℕ の値を二で割った余りで読む。分割の公理は一回の
接触点分割の具体版の各補題から得る。結論の `n = 0` は `contactPairCount_eq_zero_iff_pass_vertices_injective`
で通過する頂点の相異へ読み替える。
-/
import Mathlib.Data.Nat.ModEq
import Ising2DLambda.KacWard.CrossingFreeContactEliminationPhase
import Ising2DLambda.KacWard.EdgeDistinctCrossingEliminationParityFromNecSuf
import Ising2DLambda.NecSuf.KacWard.CrossingFreeContactEliminationPhase

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

variable {L : ℕ} [NeZero L]

/-- 具体版が必要十分版 `contact_elimination_family_necSuf` の特殊化として得られること。 -/
theorem crossing_free_contact_elimination_phase_from_necSuf {z : Qbar} (hz4 : z ^ 4 = -1) {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hinj : Function.Injective fun r => (γ r).1) (hzero : closedWalkCrossingNumber γ hγ = 0) :
    ContactEliminationFamily z γ hγ := by
  have hz : z ≠ 0 := by
    intro h
    rw [h] at hz4
    norm_num at hz4
  have hsplit : ∀ δ : ClosedNonbacktrackingWalkData L,
      ((Function.Injective fun r => (δ.walk r).1) ∧ δ.crossing = 0) →
      0 < contactPairCount δ.walk δ.closed →
      ∃ a b : ClosedNonbacktrackingWalkData L,
        ((Function.Injective fun r => (a.walk r).1) ∧ a.crossing = 0) ∧
        ((Function.Injective fun r => (b.walk r).1) ∧ b.crossing = 0) ∧
        contactPairCount a.walk a.closed + contactPairCount b.walk b.closed
          < contactPairCount δ.walk δ.closed ∧
        Disjoint a.support b.support ∧ a.support ∪ b.support = δ.support ∧
        (a.seam.1 + b.seam.1) % 2 = δ.seam.1 % 2 ∧ (a.seam.2 + b.seam.2) % 2 = δ.seam.2 % 2 ∧
        z ^ δ.turning = (-1 : Qbar) ^ (1 + evenEdgeChainIntersection L a.support b.support).val
          * (z ^ a.turning * z ^ b.turning) := by
    rintro ⟨n, δ, hδ⟩ ⟨hδinj, hδzero⟩ hpos
    obtain ⟨k, l, hkl, hcontact⟩ := exists_contact_pair_of_contactPairCount_pos δ hδ hpos
    have hs := closedWalk_smoothing_split_seam_parity δ hδ hkl
    obtain ⟨hzA, hzB⟩ := crossing_free_contact_split_children δ hδ hδinj hδzero hkl hcontact
    refine ⟨⟨_, _, contactSplitWalkA_closed δ hδ hδinj hkl hcontact⟩,
      ⟨_, _, contactSplitWalkB_closed δ hδ hδinj hkl hcontact⟩,
      ⟨smoothedSplitWalkA_edge_injective δ hδ hδinj hkl, hzA⟩,
      ⟨smoothedSplitWalkB_edge_injective δ hδ hδinj hkl, hzB⟩,
      contact_split_walks_pair_descent δ hδ hδinj hkl hcontact,
      smoothedSplitWalks_support_disjoint δ hδ hδinj hkl,
      smoothedSplitWalks_support_union δ hδ hkl, ?_, ?_, ?_⟩
    · have h1 := congrArg Prod.fst hs
      simp only [ClosedNonbacktrackingWalkData.seam] at h1 ⊢
      rw [h1, edgeSequenceSeamParities, Nat.mod_mod]
    · have h2 := congrArg Prod.snd hs
      simp only [ClosedNonbacktrackingWalkData.seam] at h2 ⊢
      rw [h2, edgeSequenceSeamParities, Nat.mod_mod]
    · simp only [ClosedNonbacktrackingWalkData.turning, ClosedNonbacktrackingWalkData.support]
      rw [← zpow_add₀ hz]
      exact crossing_free_contact_split_phase hz4 δ hδ hδinj hδzero hkl hcontact
  obtain ⟨δs, hne, hgood, hdisj, hunion, hseam, hphase⟩ :=
    Ising2DLambda.NecSuf.KacWard.contact_elimination_family_necSuf
      (fun δ : ClosedNonbacktrackingWalkData L =>
        (Function.Injective fun r => (δ.walk r).1) ∧ δ.crossing = 0)
      (·.support) (fun δ => contactPairCount δ.walk δ.closed) (fun δ => z ^ δ.turning)
      (fun δ => δ.seam.1) (fun δ => δ.seam.2)
      (fun x : ℕ => x % 2) (evenEdgeChainIntersection L) (fun x : ZMod 2 => (-1 : Qbar) ^ x.val)
      (by simp) neg_one_pow_zmod_two_val_add
      (fun x x' y h => Nat.ModEq.add_right y h)
      evenEdgeChainIntersection_empty_left evenEdgeChainIntersection_empty_right
      evenEdgeChainIntersection_union_left evenEdgeChainIntersection_union_right
      hsplit ⟨m, γ, hγ⟩ ⟨hinj, hzero⟩
  refine ⟨δs, hne, ?_, hdisj, (chainListUnion_eq_finsetListUnion _).trans hunion, ?_, ?_⟩
  · intro δ hδ
    obtain ⟨⟨hδinj, hδzero⟩, hδn⟩ := hgood δ hδ
    exact ⟨hδinj, (contactPairCount_eq_zero_iff_pass_vertices_injective δ.walk δ.closed).mp hδn,
      hδzero⟩
  · rw [hseam]
    simp [ClosedNonbacktrackingWalkData.seam, edgeSequenceSeamParities]
  · rw [chainPairIntersectionSum_eq_finsetListPairSum]
    exact hphase

end Ising2DLambda.KacWard
