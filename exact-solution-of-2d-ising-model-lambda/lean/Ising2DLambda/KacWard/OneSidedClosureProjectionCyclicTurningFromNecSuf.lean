/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版 `translated_injective_path_whitney_turning_necSuf` の点の型を ℤ × ℤ、添字を `N` 未満の自然数、
閉包を実際の一側閉包 `W`、持ち上げを射影辺列の平面への再持ち上げ、
離散 Whitney の結論を実際の閉歩道についての具体版 `vertexSimpleWalk_cyclicTotalTurning_four` に取ると、
具体版 `oneSidedClosureProjection_cyclicTurning` と同じ主張を得る。
-/
import Ising2DLambda.KacWard.OneSidedClosureProjectionCyclicTurning
import Ising2DLambda.NecSuf.KacWard.OneSidedClosureProjectionCyclicTurning

namespace Ising2DLambda.KacWard

/-- `claim_one_sided_closure_projection_cyclic_turning` を必要十分版から導く。 -/
theorem oneSidedClosureProjection_cyclicTurning_from_necSuf {L m : ℕ} [NeZero L]
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
  obtain ⟨k₀, hsimple⟩ := oneSidedClosurePointFromWalk_injective γ hγ hcontact hwind
  have hprojection :=
    oneSidedClosureProjectionFromWalk_closedNonbacktracking_of_point_injective
      γ hγ hwind k₀ hsimple
  have hzero := oneSidedClosureProjectionFromWalk_winding_zero_of_projection
    γ hγ hwind k₀ hprojection
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hz := hzero t c ht hc
  have hs := hsimple t c ht hc
  dsimp only at hz hs ⊢
  obtain ⟨hΓ, hv, hh⟩ := hz
  refine ⟨hΓ, ?_⟩
  let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
  let N := oneSidedClosureLength (m + 1) L
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
  let start := planeLift (fun j : Fin (N - 1 + 1) =>
    projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)) 0
  have hN : N - 1 + 1 = N := by
    dsimp [N, oneSidedClosureLength]
    have hsum : 0 < (horizontalDirectedWindingNumber γ).natAbs +
        (verticalDirectedWindingNumber γ).natAbs := by
      by_contra h
      have hh0 : horizontalDirectedWindingNumber γ = 0 :=
        Int.natAbs_eq_zero.mp (by omega)
      have hv0 : verticalDirectedWindingNumber γ = 0 :=
        Int.natAbs_eq_zero.mp (by omega)
      exact hwind (Prod.ext hh0 hv0)
    have hb := Nat.mul_pos ht hsum
    omega
  have htranslation := oneSidedClosureProjectedLiftFromWalk_translation
    γ hγ hwind k₀ t c ht hc start
  apply Ising2DLambda.NecSuf.KacWard.translated_injective_path_whitney_turning_necSuf
    {i : ℕ | i < N} W (projectedClosureLift L W start) (start - W 0)
  · intro i hi j hj hij
    exact hs i hi j hj hij
  · intro i hi
    have hi' := htranslation i (le_of_lt hi)
    rw [hi']
    abel
  · intro hlift
    apply vertexSimpleWalk_cyclicTotalTurning_four _ hΓ hh hv
    apply planeLift_projectedUnitStep_injective L (N - 1) W
    intro i hi j hj hij
    exact hlift (show i < N by omega) (show j < N by omega) hij

end Ising2DLambda.KacWard
