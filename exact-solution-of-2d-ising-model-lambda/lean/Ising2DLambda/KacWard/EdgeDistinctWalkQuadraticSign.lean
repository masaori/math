/-
「辺の重複がない閉歩道の位相は二次符号と横断数で決まる」（`claim_edge_distinct_walk_quadratic_sign`）の具体版。
辺の標識が相異なる実際の閉じた非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` と、`z ^ 4 = -1` を満たす
`z : Qbar`（本文の `ζ_8`）について
`−(Π_k ε_{a,b}(e_k)) ζ_8^{t_∘(γ)} = χ_{a,b}(h(γ), v(γ)) (−1)^{c(γ)}`。

人手証明の二つ目の式鎖（横断消去の族全体）との対応（`edgeDistinctWalk_quadraticSign` の `calc`）:
- 一行目 `claim_walk_twist_sign_product`: `walkTwistSign_product`。辺の積 `Π_k` を辺列のリストの積へ移すのは
  有限積の並べ方の対応（`List.prod_ofFn`・`List.map_ofFn`）。
- 二行目「`claim_edge_distinct_crossing_elimination_parity` と整数指数の加法則」: 横断消去の具体版
  `edge_distinct_crossing_elimination_parity` が与える族 `(δ_i)_{1≤i≤n}` の回転数の和と切断線偶奇の式、
  `ζ_8` の整数冪の加法則 `zpow_list_sum`、符号付きの有限積の展開 `walkPhaseFactor_list_prod`。
  `(−1)^{n−1}` と `(−1)^{n}` の積が `−1` であることは `((−1)^{n−1})^2 = 1` から。
- 三行目「上で各 `δ_i` に示した等式」: 前半の具体版 `crossingFreeWalk_quadraticSign`。各 `δ_i` の辺の標識が
  相異なり横断数が零であることは、横断消去の具体版の結論に含まれる。
- 四・五行目「`claim_torus_quadratic_sign_polarization` の反復と切断線偶奇」と「`claim_even_edge_chain_intersection`」:
  族についての二次符号の加法則の反復 `torusQuadraticSign_walkFamily`。`(−1)^{Σ_{i<j} I_L(C_i,C_j)}` の平方が
  `1` であることで右辺へ移す。
- 六行目 `claim_edge_distinct_crossing_elimination_parity`: 横断消去の具体版の横断数の式
  `c(γ) mod 2 = (n − 1) + Σ_{i<j} I_L(C_i, C_j)`（`𝔽₂`）と、`(−1)` の冪の指数の `𝔽₂` での和。
住処は有限集合・`ℕ`・`𝔽₂`・`ℤ`、および `Qbar` の整数冪だけで、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.CrossingFreeWalkQuadraticSign
import Ising2DLambda.KacWard.WalkTwistSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

variable {L : ℕ} [NeZero L]

omit [NeZero L] in
/-- 整数指数の加法則: 零でない `z` の、回転数の有限和を指数とする冪は、各冪の有限積である。 -/
theorem zpow_list_sum {z : Qbar} (hz : z ≠ 0) (δs : List (ClosedNonbacktrackingWalkData L)) :
    z ^ (δs.map (·.turning)).sum = (δs.map fun δ => z ^ δ.turning).prod := by
  induction δs with
  | nil => simp
  | cons δ δs ih =>
    simp only [List.map_cons, List.sum_cons, List.prod_cons]
    rw [zpow_add₀ hz, ih]

omit [NeZero L] in
/-- 辺ごとのねじれ符号の積を、辺列のリストの積へ移す（有限積の並べ方の対応）。 -/
theorem prod_twistSign_eq_list {m : ℕ} (s : SpinStructure) (γ : Fin (m + 1) → OrientedEdge L) :
    (∏ k, ((twistSign s (γ k) : ℤ) : Qbar)) = ((((List.ofFn γ).map (twistSign s)).prod : ℤ) : Qbar) := by
  rw [List.map_ofFn, List.prod_ofFn, Int.cast_prod]
  rfl

/-- `claim_edge_distinct_walk_quadratic_sign`: 辺の標識が相異なる閉歩道 `γ` について
`−(Π_k ε_{a,b}(e_k)) ζ_8^{t_∘(γ)} = χ_{a,b}(h(γ), v(γ)) (−1)^{c(γ)}`。 -/
theorem edgeDistinctWalk_quadraticSign {m : ℕ} (s : SpinStructure) {z : Qbar} (hz4 : z ^ 4 = -1)
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
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
  -- 横断消去で横断のない族 (δ_i)_{1≤i≤n} を得る
  obtain ⟨δs, hne, -, -, hzero, hinjs, hturn, hseam, hcross⟩ :=
    edge_distinct_crossing_elimination_parity γ hγ hinj
  set H := (δs.map fun δ => δ.seam.1).sum with hH
  set V := (δs.map fun δ => δ.seam.2).sum with hV
  set P := chainPairIntersectionSum (δs.map (·.support)) with hP
  obtain ⟨k, hk⟩ : ∃ k, δs.length = k + 1 :=
    ⟨δs.length - 1, (Nat.succ_pred_eq_of_pos (List.length_pos_iff.mpr hne)).symm⟩
  have hseam1 : (edgeSequenceSeamParities (List.ofFn γ)).1 = H % 2 := (congrArg Prod.fst hseam).symm
  have hseam2 : (edgeSequenceSeamParities (List.ofFn γ)).2 = V % 2 := (congrArg Prod.snd hseam).symm
  have hsq : ∀ n : ℕ, (-1 : Qbar) ^ n * (-1 : Qbar) ^ n = 1 := fun n => by
    rw [← mul_pow]; norm_num
  rw [hseam1, hseam2]
  calc -(∏ r, ((twistSign (a, b) (γ r) : ℤ) : Qbar)) * z ^ cyclicTotalTurning γ hγ
      -- claim_walk_twist_sign_product
      = -((-1 : Qbar) ^ (a.toNat * (H % 2) + b.toNat * (V % 2))) * z ^ cyclicTotalTurning γ hγ := by
        rw [prod_twistSign_eq_list, walkTwistSign_product]
        have h1 : ((List.ofFn γ).map horizontalSeamParity).sum % 2 = H % 2 := hseam1
        have h2 : ((List.ofFn γ).map verticalSeamParity).sum % 2 = V % 2 := hseam2
        rw [h1, h2]
        push_cast
        rfl
      -- claim_edge_distinct_crossing_elimination_parity と整数指数の加法則
    _ = (-1 : Qbar) ^ k * (δs.map (walkPhaseFactor a b z)).prod := by
        rw [walkPhaseFactor_list_prod, seamExponent_list_sum, ← hturn, zpow_list_sum hz, hk]
        have hmod : (-1 : Qbar) ^ (a.toNat * (H % 2) + b.toNat * (V % 2)) =
            (-1 : Qbar) ^ (a.toNat * H + b.toNat * V) := by
          rw [neg_one_pow_eq_pow_mod_two (n := a.toNat * (H % 2) + b.toNat * (V % 2)),
            neg_one_pow_eq_pow_mod_two (n := a.toNat * H + b.toNat * V)]
          congr 1
          simp only [Nat.add_mod, Nat.mul_mod, Nat.mod_mod]
        rw [hmod, pow_add (-1 : Qbar) (k + 1), pow_succ (-1 : Qbar) k]
        linear_combination ((-1 : Qbar) ^ (a.toNat * H + b.toNat * V) *
          (δs.map fun δ => z ^ δ.turning).prod) * hsq k
      -- 上で各 δ_i に示した等式（claim_edge_distinct_walk_quadratic_sign の前半）
    _ = (-1 : Qbar) ^ k *
          (δs.map fun δ =>
            ((torusQuadraticSign a b (decide (δ.seam.1 = 1)) (decide (δ.seam.2 = 1)) : ℤ) : Qbar)).prod := by
        congr 2
        refine List.map_congr_left fun δ hδ => ?_
        exact crossingFreeWalk_quadraticSign (a, b) hz4 δ.walk δ.closed (hinjs δ hδ) (hzero δ hδ)
      -- claim_torus_quadratic_sign_polarization の反復と切断線偶奇、claim_even_edge_chain_intersection
    _ = (-1 : Qbar) ^ k * ((-1 : Qbar) ^ P.val *
          ((torusQuadraticSign a b (decide (H % 2 = 1)) (decide (V % 2 = 1)) : ℤ) : Qbar)) := by
        rw [torusQuadraticSign_walkFamily a b δs hinjs]
        linear_combination (-((-1 : Qbar) ^ k *
          (δs.map fun δ =>
            ((torusQuadraticSign a b (decide (δ.seam.1 = 1)) (decide (δ.seam.2 = 1)) : ℤ) :
              Qbar)).prod)) * hsq P.val
      -- claim_edge_distinct_crossing_elimination_parity（横断数の式）
    _ = ((torusQuadraticSign a b (decide (H % 2 = 1)) (decide (V % 2 = 1)) : ℤ) : Qbar) *
          (-1 : Qbar) ^ closedWalkCrossingNumber γ hγ := by
        rw [← neg_one_pow_natCast_zmod_two_val (closedWalkCrossingNumber γ hγ), hcross, hk,
          Nat.add_sub_cancel, neg_one_pow_zmod_two_val_add, neg_one_pow_natCast_zmod_two_val]
        ring

end Ising2DLambda.KacWard
