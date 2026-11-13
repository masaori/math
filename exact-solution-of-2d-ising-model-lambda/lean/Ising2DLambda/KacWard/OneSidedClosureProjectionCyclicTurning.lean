/-
章「Onsager 閉形式への接続」の
「一側閉包のトーラス射影の循環総回転数は正負 4 のいずれかである」
（`claim_one_sided_closure_projection_cyclic_turning`）の具体版。

人手証明と同じく、実際の閉歩道 `γ`（接触対数零、巻き付き非零）から作った一側閉包 `W` について、
閉包の頂点単純性と、射影辺列 `Γ` の平面持ち上げが `W` の一定平行移動であることから、
`Γ` が閉じた非後退辺列で、一周期の持ち上げ点が相異なり、巻き付きが零であることを得る
（`oneSidedClosureProjectionFromWalk_simple_zero_winding`）。それを
`claim_plane_simple_polygon_cyclic_turning` の実際の閉歩道についての具体版
`vertexSimpleWalk_cyclicTotalTurning_four` へ代入する。住処は ℕ と ℤ × ℤ だけである。
-/
import Ising2DLambda.KacWard.OneSidedClosureProjectionWindingFromWalk
import Ising2DLambda.KacWard.PlaneSimplePolygonCyclicTurningOfWalk

namespace Ising2DLambda.KacWard

/-- `claim_one_sided_closure_projection_cyclic_turning` の具体版。 -/
theorem oneSidedClosureProjection_cyclicTurning {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    ∃ k₀ : ℤ, ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      let Γ : Fin (N - 1 + 1) → OrientedEdge L := fun j =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
      ∃ hΓ : closedNonbacktrackingWalk Γ,
        cyclicTotalTurning Γ hΓ = 4 ∨ cyclicTotalTurning Γ hΓ = -4 := by
  -- 閉包の単純性・平行移動・巻き付き零（人手証明の前半）
  obtain ⟨k₀, hsimpleZero⟩ :=
    oneSidedClosureProjectionFromWalk_simple_zero_winding γ hγ hcontact hwind
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hp := hsimpleZero t c ht hc
  dsimp only at hp ⊢
  obtain ⟨hdistinct, hΓ, hv, hh⟩ := hp
  -- 持ち上げ点の相異性と巻き付き零を平面単純多角形の具体版へ代入する
  exact ⟨hΓ, vertexSimpleWalk_cyclicTotalTurning_four _ hΓ hh hv hdistinct⟩

end Ising2DLambda.KacWard
