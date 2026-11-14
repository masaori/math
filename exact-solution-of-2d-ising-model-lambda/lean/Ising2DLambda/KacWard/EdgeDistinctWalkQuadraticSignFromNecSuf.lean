/-
「辺の重複がない閉歩道の位相は二次符号と横断数で決まる」の具体版 `edgeDistinctWalk_quadraticSign` の結論が、
必要十分版 `edge_distinct_walk_quadratic_sign_necSuf` の特殊化として得られることを示す導出版。
具体版の証明はこのファイルに依存しない。

特殊化: 係数の住処は `Qbar`、族は横断消去の具体版が与える `ClosedNonbacktrackingWalkData L` のリスト、
`a`・`b` はスピン構造の成分の `Bool.toNat`、各項の符号 `χ` は実際の切断線偶奇での巻き付き二次符号、
`P` は台の対ごとの交差形式の和 `chainPairIntersectionSum`。仮定は具体版と同じ前の主張の具体版から得る。
-/
import Ising2DLambda.KacWard.EdgeDistinctWalkQuadraticSign
import Ising2DLambda.NecSuf.KacWard.EdgeDistinctWalkQuadraticSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

variable {L : ℕ} [NeZero L]

theorem edgeDistinctWalk_quadraticSign_from_necSuf {m : ℕ} (s : SpinStructure) {z : Qbar}
    (hz4 : z ^ 4 = -1) (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hinj : Function.Injective fun r => (γ r).1) :
    -(∏ k, ((twistSign s (γ k) : ℤ) : Qbar)) * z ^ cyclicTotalTurning γ hγ =
      ((torusQuadraticSign s.1 s.2
          (decide ((edgeSequenceSeamParities (List.ofFn γ)).1 = 1))
          (decide ((edgeSequenceSeamParities (List.ofFn γ)).2 = 1)) : ℤ) : Qbar) *
        (-1 : Qbar) ^ closedWalkCrossingNumber γ hγ := by
  rcases s with ⟨a, b⟩
  have hz : z ≠ 0 := by
    intro h
    rw [h] at hz4
    norm_num at hz4
  obtain ⟨δs, hne, -, -, hzero, hinjs, hturn, hseam, hcross⟩ :=
    edge_distinct_crossing_elimination_parity γ hγ hinj
  have hseam1 : (edgeSequenceSeamParities (List.ofFn γ)).1 =
      (δs.map fun δ => δ.seam.1).sum % 2 := (congrArg Prod.fst hseam).symm
  have hseam2 : (edgeSequenceSeamParities (List.ofFn γ)).2 =
      (δs.map fun δ => δ.seam.2).sum % 2 := (congrArg Prod.snd hseam).symm
  refine Ising2DLambda.NecSuf.KacWard.edge_distinct_walk_quadratic_sign_necSuf z hz a.toNat b.toNat
    (fun δ => δ.seam.1) (fun δ => δ.seam.2) (·.turning)
    (fun δ => ((torusQuadraticSign a b (decide (δ.seam.1 = 1)) (decide (δ.seam.2 = 1)) : ℤ) : Qbar))
    δs hne _ _ (edgeSequenceSeamParities (List.ofFn γ)).1 (edgeSequenceSeamParities (List.ofFn γ)).2
    _ _ (chainPairIntersectionSum (δs.map (·.support))) ?_ hturn ?_ ?_ ?_ ?_ hcross
  · -- claim_walk_twist_sign_product
    rw [prod_twistSign_eq_list, walkTwistSign_product]
    push_cast
    rfl
  · rw [hseam1, Nat.mod_mod]
  · rw [hseam2, Nat.mod_mod]
  · -- 証明の前半
    intro δ hδ
    exact crossingFreeWalk_quadraticSign (a, b) hz4 δ.walk δ.closed (hinjs δ hδ) (hzero δ hδ)
  · -- 族の二次符号の加法則の反復
    simp only
    rw [hseam1, hseam2]
    exact torusQuadraticSign_walkFamily a b δs hinjs

end Ising2DLambda.KacWard
