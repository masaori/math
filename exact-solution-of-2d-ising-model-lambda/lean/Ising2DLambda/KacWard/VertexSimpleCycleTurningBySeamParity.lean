/-
章「Onsager 閉形式への接続」の
「頂点単純閉路の循環総回転数は切断線偶奇で決まる」
（`claim_vertex_simple_cycle_turning_by_seam_parity`）の具体版。

人手証明と同じ二場合に分ける。
- 切断線偶奇 `(h(γ), v(γ)) = (0, 0)` なら、巻き付きは零
  （`claim_vertex_simple_zero_seam_winding` の具体版）、一周期の持ち上げ点は相異なる
  （`claim_vertex_simple_plane_lift_points_distinct` の具体版）ので、
  `claim_plane_simple_polygon_cyclic_turning` を実際の閉歩道へ当てた具体版から `t∘(γ) ∈ {4, -4}`。
- 切断線偶奇が零でないなら、巻き付きが零だと仮定すると巻き付き数の偶奇
  （`claim_directed_winding_parity` の具体版）から切断線偶奇が零になって矛盾するので巻き付きは零でなく、
  `claim_nonzero_winding_simple_cycle_turning_zero` の具体版から `t∘(γ) = 0`。
住処は ℤ（と二を法とした剰余）だけである。
-/
import Ising2DLambda.KacWard.VertexSimpleZeroSeamWinding
import Ising2DLambda.KacWard.VertexSimplePlaneLiftDistinct
import Ising2DLambda.KacWard.PlaneSimplePolygonCyclicTurningOfWalk
import Ising2DLambda.KacWard.DirectedWindingParity
import Ising2DLambda.KacWard.NonzeroWindingSimpleCycleTurningZero

namespace Ising2DLambda.KacWard

/-- 二未満の自然数は、二を法とした剰余類が零なら零である。
切断線偶奇の各成分は `% 2` を取った値なので二未満である。 -/
theorem natLtTwo_eq_zero_of_cast_zmod_two_eq_zero (n : ℕ) (hn : n < 2)
    (h : (n : ZMod 2) = 0) : n = 0 := by
  interval_cases n
  · rfl
  · exact absurd h (by decide)

/-- `claim_vertex_simple_cycle_turning_by_seam_parity` の具体版。 -/
theorem vertexSimpleCycle_cyclicTotalTurning_by_seamParity {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) :
    (edgeSequenceSeamParities (List.ofFn γ) = (0, 0) →
        cyclicTotalTurning γ hγ = 4 ∨ cyclicTotalTurning γ hγ = -4) ∧
      (edgeSequenceSeamParities (List.ofFn γ) ≠ (0, 0) →
        cyclicTotalTurning γ hγ = 0) := by
  constructor
  · -- 切断線偶奇が零の場合
    intro hseam
    have hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0 := by
      have h := congrArg Prod.fst hseam
      rw [edgeSequenceSeamParities] at h
      simp only [List.map_ofFn, List.sum_ofFn] at h
      exact h
    have hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0 := by
      have h := congrArg Prod.snd hseam
      rw [edgeSequenceSeamParities] at h
      simp only [List.map_ofFn, List.sum_ofFn] at h
      exact h
    -- (w_h(γ), w_v(γ)) = (0, 0)（claim_vertex_simple_zero_seam_winding）
    obtain ⟨hwh, hwv⟩ := vertexSimple_zero_seam_winding L m γ hγ hcontact hh hv
    -- 一周期の持ち上げ点は相異なる（claim_vertex_simple_plane_lift_points_distinct）
    have hdistinct := vertexSimplePlaneLift_points_distinct γ hγ hcontact
    -- t∘(γ) ∈ {4, -4}（claim_plane_simple_polygon_cyclic_turning）
    exact vertexSimpleWalk_cyclicTotalTurning_four γ hγ hwh hwv hdistinct
  · -- 切断線偶奇が零でない場合
    intro hseam
    have hwind : (horizontalDirectedWindingNumber γ,
        verticalDirectedWindingNumber γ) ≠ (0, 0) := by
      intro hzero
      have hwh : horizontalDirectedWindingNumber γ = 0 := congrArg Prod.fst hzero
      have hwv : verticalDirectedWindingNumber γ = 0 := congrArg Prod.snd hzero
      -- (h(γ), v(γ)) = (w_h(γ) mod 2, w_v(γ) mod 2) = (0, 0)（claim_directed_winding_parity）
      have ph := horizontalDirectedWindingNumber_parity γ hγ
      have pv := verticalDirectedWindingNumber_parity γ hγ
      rw [hwh, Int.cast_zero] at ph
      rw [hwv, Int.cast_zero] at pv
      apply hseam
      have h1 : (edgeSequenceSeamParities (List.ofFn γ)).1 = 0 :=
        natLtTwo_eq_zero_of_cast_zmod_two_eq_zero _
          (by rw [edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num)) ph.symm
      have h2 : (edgeSequenceSeamParities (List.ofFn γ)).2 = 0 :=
        natLtTwo_eq_zero_of_cast_zmod_two_eq_zero _
          (by rw [edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num)) pv.symm
      exact Prod.ext h1 h2
    -- t∘(γ) = 0（claim_nonzero_winding_simple_cycle_turning_zero）
    exact nonzeroWindingSimpleCycle_cyclicTotalTurning_zero γ hγ hcontact hwind

end Ising2DLambda.KacWard
