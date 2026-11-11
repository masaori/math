/-
「二本の閉歩道の切断線偶奇の和は元の切断線偶奇に等しい」（`claim_smoothing_split_seam_parity`）を、
実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` と添字 `k < l` について述べる具体版。
二本は `def_smoothed_split_edge_sequences` の `smoothedSplitWalkA`・`smoothedSplitWalkB`、
切断線偶奇は `def_edge_sequence_seam_parities` の `edgeSequenceSeamParities`（辺列を `List.ofFn` で読む）。
住処は ℕ（切断線指示子の有限和と二で割った余り）で、ℝ / ℂ は現れない。
本文の横断の仮定は二本が閉じることにだけ使われ、偶奇の和の等式には要らないので置かない。

人手証明との対応:
- 一つ目の式の一行目「`Σ_{e∈γ_A} c(e) + Σ_{e∈γ_B} c(e) = Σ_{r∈A} c(e_r) + Σ_{r∈B} c(e_r)`
  （二本の辺の並び）」: 位置 `j` の辺が添字 `smoothedSplitIndexA k l j`（`smoothedSplitIndexB k l j`）の
  辺であること（`smoothedSplitWalkA_apply`・`smoothedSplitWalkB_apply`）、位置の写像の単射性
  （`smoothedSplitIndexA_injective`・`smoothedSplitIndexB_injective`）による像の上の和への移し替え、
  像が `A`・`B` であること（`smoothedSplitIndexA_image`・`smoothedSplitIndexB_image`）。
- 一つ目の式の二行目「`B = I_m \ A` と互いに素な有限和の分割」: `Finset.sum_add_sum_compl`。
  以上が `smoothedSplit_seam_sum`。
- 二つ目の式「両辺を二で割った余り」と、`def_edge_sequence_seam_parities` の両成分への適用:
  `closedWalk_smoothing_split_seam_parity`。
-/
import Ising2DLambda.KacWard.SmoothingSplitWalkTurningSum
import Ising2DLambda.KacWard.WalkTwistSign
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitWalkSeamParity

namespace Ising2DLambda.KacWard

open Finset

variable {L m : ℕ}

open Classical in
/-- 切断線指示子 `c` の二本の上の和の和は、元の辺列の上の和である。 -/
theorem smoothedSplit_seam_sum (c : OrientedEdge L → ℕ) (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    (∑ j, c (smoothedSplitWalkA γ hγ k l j)) + ∑ j, c (smoothedSplitWalkB γ hγ k l j)
      = ∑ r, c (γ r) := by
  calc (∑ j, c (smoothedSplitWalkA γ hγ k l j)) + ∑ j, c (smoothedSplitWalkB γ hγ k l j)
      = (∑ j, c (γ (smoothedSplitIndexA k l j))) + ∑ j, c (γ (smoothedSplitIndexB k l j)) := by
        simp only [smoothedSplitWalkA_apply, smoothedSplitWalkB_apply]
    _ = (∑ r ∈ univ.image (smoothedSplitIndexA k l), c (γ r))
          + ∑ r ∈ univ.image (smoothedSplitIndexB k l), c (γ r) := by
        rw [Finset.sum_image (fun x _ y _ h => smoothedSplitIndexA_injective hkl h),
          Finset.sum_image (fun x _ y _ h => smoothedSplitIndexB_injective hkl h)]
    _ = (∑ r ∈ univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l), c (γ r))
          + ∑ r ∈ (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))ᶜ, c (γ r) := by
        rw [smoothedSplitIndexA_image γ hγ hkl, smoothedSplitIndexB_image γ hγ hkl]
    _ = ∑ r, c (γ r) := Finset.sum_add_sum_compl _ _

/-- `((h(γ_A) + h(γ_B)) mod 2, (v(γ_A) + v(γ_B)) mod 2) = (h(γ), v(γ))`。 -/
theorem closedWalk_smoothing_split_seam_parity (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    (((edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkA γ hγ k l))).1
          + (edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkB γ hγ k l))).1) % 2,
      ((edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkA γ hγ k l))).2
          + (edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkB γ hγ k l))).2) % 2)
      = edgeSequenceSeamParities (List.ofFn γ) := by
  simp only [edgeSequenceSeamParities, List.map_ofFn, List.sum_ofFn, Function.comp_apply]
  rw [← Nat.add_mod, ← Nat.add_mod, smoothedSplit_seam_sum horizontalSeamParity γ hγ hkl,
    smoothedSplit_seam_sum verticalSeamParity γ hγ hkl]

/-- 具体版が必要十分版 `split_position_reading_pair_necSuf` の特殊化として得られること。
添字を `Fin (m + 1)`、`A` を `def_smoothing_index_blocks` の `A`、位置の写像を
`smoothedSplitIndexA`・`smoothedSplitIndexB`、値を ℕ、読み取りを二で割った余りに取る。 -/
theorem closedWalk_smoothing_split_seam_parity_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    (((edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkA γ hγ k l))).1
          + (edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkB γ hγ k l))).1) % 2,
      ((edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkA γ hγ k l))).2
          + (edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkB γ hγ k l))).2) % 2)
      = edgeSequenceSeamParities (List.ofFn γ) := by
  classical
  simp only [edgeSequenceSeamParities, List.map_ofFn, List.sum_ofFn, Function.comp_apply,
    smoothedSplitWalkA_apply, smoothedSplitWalkB_apply]
  rw [← Nat.add_mod, ← Nat.add_mod]
  exact Ising2DLambda.NecSuf.KacWard.split_position_reading_pair_necSuf
    (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))
    (fun r => horizontalSeamParity (γ r)) (fun r => verticalSeamParity (γ r)) (· % 2)
    (smoothedSplitIndexA k l) (smoothedSplitIndexB k l)
    (smoothedSplitIndexA_injective hkl) (smoothedSplitIndexB_injective hkl)
    (smoothedSplitIndexA_image γ hγ hkl) (smoothedSplitIndexB_image γ hγ hkl)

end Ising2DLambda.KacWard
