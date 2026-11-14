/-
「辺の重複がない閉歩道の位相は二次符号と横断数で決まる」（`claim_edge_distinct_walk_quadratic_sign`）の
証明の前半（一つの `δ_i` を固定した式鎖）の具体版: 辺の標識が相異なり横断数が零の、実際の閉じた非後退辺列
`δ : Fin (m + 1) → OrientedEdge L` について、`𝔽₂` の切断線偶奇 `(h(δ), v(δ))` と `z ^ 4 = -1` を満たす
`z : Qbar`（本文の `ζ_8`）で
`−(−1)^{a h(δ) + b v(δ)} ζ_8^{t_∘(δ)} = χ_{a,b}(h(δ), v(δ))`。

人手証明の四行との対応（`crossingFreeWalk_quadraticSign` の `calc`）:
- 一行目「`claim_crossing_free_contact_elimination_phase` と整数指数の加法則」: 接触消去の具体版
  `crossing_free_contact_elimination_phase` が与える頂点単純な族 `(α_j)_{1≤j≤p}` の位相の式と、
  符号付きの有限積の展開 `walkPhaseFactor_list_prod`（`−(−1)^{e_j}` を `p` 個掛けると `(−1)^{p + Σ_j e_j}`）。
  左辺の符号の指数 `a h(δ) + b v(δ)` と `Σ_j (a h(α_j) + b v(α_j))` が二を法として等しいことは、
  同じ具体版の切断線偶奇の式 `(Σ_j h(α_j) mod 2, Σ_j v(α_j) mod 2) = (h(δ), v(δ))` から従う。
- 二行目「`claim_vertex_simple_orbit_quadratic_sign` を各子へ適用」: `vertexSimpleOrbit_quadraticSign`。
  各子の接触対数が零であることは、通過する頂点が相異なることの言い換え
  `contactPairCount_eq_zero_iff_pass_vertices_injective`。
- 三・四行目「`claim_even_edge_chain_intersection`」と「`claim_torus_quadratic_sign_polarization` の反復と
  切断線偶奇」: 族についての二次符号の加法則の反復 `torusQuadraticSign_walkFamily`。
住処は有限集合・`ℕ`・`𝔽₂`・`ℤ`、および `Qbar` の整数冪だけで、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.WalkFamilyQuadraticSignProduct
import Ising2DLambda.KacWard.VertexSimpleOrbitQuadraticSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

variable {L : ℕ} [NeZero L]

/-- 閉歩道 `δ` の位相因子 `−(−1)^{a h(δ) + b v(δ)} ζ_8^{t_∘(δ)}`。 -/
noncomputable def walkPhaseFactor (a b : Bool) (z : Qbar) (δ : ClosedNonbacktrackingWalkData L) : Qbar :=
  -((-1 : Qbar) ^ (a.toNat * δ.seam.1 + b.toNat * δ.seam.2)) * z ^ δ.turning

omit [NeZero L] in
/-- 整数指数の加法則: 位相因子の有限積は `(−1)^{p + Σ_j (a h(α_j) + b v(α_j))} Π_j ζ_8^{t_∘(α_j)}`。 -/
theorem walkPhaseFactor_list_prod (a b : Bool) (z : Qbar) (αs : List (ClosedNonbacktrackingWalkData L)) :
    (αs.map (walkPhaseFactor a b z)).prod =
      (-1 : Qbar) ^ (αs.length + (αs.map fun α => a.toNat * α.seam.1 + b.toNat * α.seam.2).sum) *
        (αs.map fun α => z ^ α.turning).prod := by
  induction αs with
  | nil => simp
  | cons α αs ih =>
    simp only [List.map_cons, List.prod_cons, List.length_cons, List.sum_cons, ih, walkPhaseFactor]
    simp only [pow_add, pow_one]
    ring

omit [NeZero L] in
/-- 族の符号の指数の和は `a Σ_j h(α_j) + b Σ_j v(α_j)`（有限和の線型性）。 -/
theorem seamExponent_list_sum (a b : Bool) (αs : List (ClosedNonbacktrackingWalkData L)) :
    (αs.map fun α => a.toNat * α.seam.1 + b.toNat * α.seam.2).sum =
      a.toNat * (αs.map fun α => α.seam.1).sum + b.toNat * (αs.map fun α => α.seam.2).sum := by
  rw [List.sum_map_add, List.sum_map_mul_left, List.sum_map_mul_left]

/-- `claim_edge_distinct_walk_quadratic_sign` の証明の前半: 辺の標識が相異なり横断のない閉歩道 `δ` について
`−(−1)^{a h(δ) + b v(δ)} ζ_8^{t_∘(δ)} = χ_{a,b}(h(δ), v(δ))`。 -/
theorem crossingFreeWalk_quadraticSign {m : ℕ} (s : SpinStructure) {z : Qbar} (hz4 : z ^ 4 = -1)
    (δ : Fin (m + 1) → OrientedEdge L) (hδ : closedNonbacktrackingWalk δ)
    (hinj : Function.Injective fun r => (δ r).1) (hzero : closedWalkCrossingNumber δ hδ = 0) :
    -((-1 : Qbar) ^ (s.1.toNat * (edgeSequenceSeamParities (List.ofFn δ)).1 +
          s.2.toNat * (edgeSequenceSeamParities (List.ofFn δ)).2)) *
        z ^ cyclicTotalTurning δ hδ =
      ((torusQuadraticSign s.1 s.2
          (decide ((edgeSequenceSeamParities (List.ofFn δ)).1 = 1))
          (decide ((edgeSequenceSeamParities (List.ofFn δ)).2 = 1)) : ℤ) : Qbar) := by
  rcases s with ⟨a, b⟩
  -- 接触消去で頂点単純な族 (α_j)_{1≤j≤p} を得る
  obtain ⟨αs, hne, hgood, -, -, hseam, hphase⟩ :=
    crossing_free_contact_elimination_phase hz4 δ hδ hinj hzero
  set H := (αs.map fun α => α.seam.1).sum with hH
  set V := (αs.map fun α => α.seam.2).sum with hV
  set P := chainPairIntersectionSum (αs.map (·.support)) with hP
  rw [← hseam]
  obtain ⟨k, hk⟩ : ∃ k, αs.length = k + 1 :=
    ⟨αs.length - 1, (Nat.succ_pred_eq_of_pos (List.length_pos_iff.mpr hne)).symm⟩
  calc -((-1 : Qbar) ^ ((a, b).1.toNat * (H % 2) + (a, b).2.toNat * (V % 2))) *
        z ^ cyclicTotalTurning δ hδ
      -- claim_crossing_free_contact_elimination_phase と整数指数の加法則
      = (-1 : Qbar) ^ P.val * (αs.map (walkPhaseFactor a b z)).prod := by
        rw [hphase, walkPhaseFactor_list_prod, seamExponent_list_sum, neg_one_pow_zmod_two_val_add,
          neg_one_pow_natCast_zmod_two_val, hk, Nat.add_sub_cancel]
        have hmod : (-1 : Qbar) ^ (a.toNat * (H % 2) + b.toNat * (V % 2)) =
            (-1 : Qbar) ^ (a.toNat * H + b.toNat * V) := by
          rw [neg_one_pow_eq_pow_mod_two (n := a.toNat * (H % 2) + b.toNat * (V % 2)),
            neg_one_pow_eq_pow_mod_two (n := a.toNat * H + b.toNat * V)]
          congr 1
          simp only [Nat.add_mod, Nat.mul_mod, Nat.mod_mod]
        simp only
        rw [hmod, pow_add, pow_add, pow_succ]
        ring
      -- claim_vertex_simple_orbit_quadratic_sign を各子へ適用
    _ = (-1 : Qbar) ^ P.val *
          (αs.map fun α =>
            ((torusQuadraticSign a b (decide (α.seam.1 = 1)) (decide (α.seam.2 = 1)) : ℤ) : Qbar)).prod := by
        congr 2
        refine List.map_congr_left fun α hα => ?_
        exact vertexSimpleOrbit_quadraticSign (a, b) hz4 α.walk α.closed
          ((contactPairCount_eq_zero_iff_pass_vertices_injective α.walk α.closed).mpr (hgood α hα).2.1)
      -- claim_even_edge_chain_intersection と claim_torus_quadratic_sign_polarization の反復
    _ = ((torusQuadraticSign a b (decide (H % 2 = 1)) (decide (V % 2 = 1)) : ℤ) : Qbar) :=
        (torusQuadraticSign_walkFamily a b αs fun α hα => (hgood α hα).1).symm

end Ising2DLambda.KacWard
