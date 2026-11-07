import Ising2DLambda.KacWard.ProjectedClosedUnitPathWinding

namespace Ising2DLambda.KacWard

/-- A one-sided closure projection with a fixed cut point has zero winding. -/
theorem oneSidedClosureProjectionFromWalk_winding_zero_of_projection
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hprojection : ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      let edge := planeUnitPathTorusProjection L N (fun j : Fin (N + 1) => W j.val)
      (∀ j : Fin N,
        orientedSource (edge j) = planeVertexProjection L (W j.val) ∧
        orientedTarget (edge j) = planeVertexProjection L (W (j.val + 1))) ∧
      (∀ j k : Fin N, k.val = (j.val + 1) % N →
        orientedTarget (edge j) = orientedSource (edge k)) ∧
      (∀ j k : Fin N, k.val = (j.val + 1) % N →
        edge k ≠ reversal (edge j))) :
    ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      let Γ : Fin (N - 1 + 1) → OrientedEdge L := fun j =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
      closedNonbacktrackingWalk Γ ∧
      verticalDirectedWindingNumber Γ = 0 ∧ horizontalDirectedWindingNumber Γ = 0 := by
  intro t c ht hc
  dsimp only
  let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
  let N := oneSidedClosureLength (m + 1) L
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
  have hsum : 0 < (horizontalDirectedWindingNumber γ).natAbs +
      (verticalDirectedWindingNumber γ).natAbs := by
    by_contra h
    have hh : horizontalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    have hv : verticalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    exact hwind (Prod.ext hh hv)
  have hN : 0 < N := by
    dsimp [N, oneSidedClosureLength]
    have hb := Nat.mul_pos ht hsum
    omega
  let m' := N - 1
  have hm' : m' + 1 = N := Nat.sub_add_cancel hN
  letI : NeZero N := ⟨hN.ne'⟩
  let Γ : Fin (m' + 1) → OrientedEdge L := fun j =>
    projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
  have hp := hprojection t c ht hc
  dsimp only at hp
  have hΓ (j : Fin (m' + 1)) :
      Γ j = planeUnitPathTorusProjection L N
        (fun i : Fin (N + 1) => W i.val) (Fin.cast hm' j) := by
    simp [Γ, planeUnitPathTorusProjection]
  have hwalk : closedNonbacktrackingWalk Γ := by
    constructor
    · intro j
      have hj : (Fin.cast hm' (Fin.succ j)).val =
          ((Fin.cast hm' (Fin.castSucc j)).val + 1) % N := by
        simp only [Fin.val_cast, Fin.val_succ, Fin.val_castSucc]
        rw [Nat.mod_eq_of_lt (by simpa [← hm'] using (Fin.succ j).isLt)]
      have hs := hp.2.1 (Fin.cast hm' (Fin.castSucc j))
        (Fin.cast hm' (Fin.succ j)) hj
      have hr := hp.2.2 (Fin.cast hm' (Fin.castSucc j))
        (Fin.cast hm' (Fin.succ j)) hj
      rw [← hΓ (Fin.castSucc j), ← hΓ (Fin.succ j)] at hs hr
      exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hs, hr⟩
    · have hj : (0 : Fin N).val =
          ((Fin.cast hm' (Fin.last m')).val + 1) % N := by
        simp only [Fin.val_zero, Fin.val_cast, Fin.val_last]
        rw [← hm']
        simp
      have hs := hp.2.1 (Fin.cast hm' (Fin.last m')) 0 hj
      have hr := hp.2.2 (Fin.cast hm' (Fin.last m')) 0 hj
      have hz : Γ (0 : Fin (m' + 1)) = planeUnitPathTorusProjection L N
          (fun i : Fin (N + 1) => W i.val) 0 := by
        simpa using hΓ (0 : Fin (m' + 1))
      rw [← hΓ (Fin.last m'), ← hz] at hs hr
      exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hs, hr⟩
  have hclosed : W N = W 0 := by
    have ht' := oneSidedClosureProjectedLiftFromWalk_translation
      γ hγ hwind k₀ t c ht hc (0, 0) N (le_refl N)
    have hc' := oneSidedClosureProjectedLiftFromWalk_closed
      γ hγ hwind k₀ t c ht hc (0, 0)
    dsimp only at hc'
    rw [ht'] at hc'
    have hfst := congrArg Prod.fst hc'
    have hsnd := congrArg Prod.snd hc'
    exact Prod.ext (by simpa [W] using sub_eq_zero.mp hfst)
      (by simpa [W] using sub_eq_zero.mp hsnd)
  have hunit := oneSidedClosureFromWalk_unit_steps γ hγ hwind k₀ t c ht hc
  have hresult := projectedClosedUnitPath_winding_zero L m' W
    (by simpa [hm'] using hclosed)
    (by intro j hj; exact hunit j (by simpa [hm'] using hj))
    hwalk
  exact ⟨hwalk, by simpa [Γ, hm'] using hresult⟩

/-- 実際の閉歩道から作った一側閉包の射影辺列は巻き付きが零である。 -/
theorem oneSidedClosureProjectionFromWalk_winding_zero {L m : ℕ} [NeZero L]
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
      closedNonbacktrackingWalk Γ ∧
      verticalDirectedWindingNumber Γ = 0 ∧ horizontalDirectedWindingNumber Γ = 0 := by
  obtain ⟨k₀, hprojection⟩ :=
    oneSidedClosureProjectionFromWalk_closedNonbacktracking γ hγ hcontact hwind
  exact ⟨k₀, oneSidedClosureProjectionFromWalk_winding_zero_of_projection
    γ hγ hwind k₀ hprojection⟩

/-- The same cut point witnesses distinct lift points and zero winding. -/
theorem oneSidedClosureProjectionFromWalk_simple_zero_winding
    {L m : ℕ} [NeZero L]
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
      Function.Injective (fun i : Fin (N - 1 + 1) => planeLift Γ i.castSucc) ∧
      closedNonbacktrackingWalk Γ ∧
      verticalDirectedWindingNumber Γ = 0 ∧
      horizontalDirectedWindingNumber Γ = 0 := by
  obtain ⟨k₀, hsimple⟩ := oneSidedClosurePointFromWalk_injective γ hγ hcontact hwind
  have hinj := oneSidedClosureProjectionFromWalk_planeLift_injective_of_point_injective
    γ hγ hwind k₀ hsimple
  have hprojection :=
    oneSidedClosureProjectionFromWalk_closedNonbacktracking_of_point_injective
      γ hγ hwind k₀ hsimple
  have hzero := oneSidedClosureProjectionFromWalk_winding_zero_of_projection
    γ hγ hwind k₀ hprojection
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  exact ⟨hinj t c ht hc, hzero t c ht hc⟩

end Ising2DLambda.KacWard
