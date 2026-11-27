import Ising2DLambda.KacWard.ProjectedPlaneCycleLiftOfWalk

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
  have hclosed : W N = W 0 := oneSidedClosureFromWalk_closed γ k₀ t c hc
  have hunit := oneSidedClosureFromWalk_unit_steps γ hγ hwind k₀ t c ht hc
  have hresult := projectedPlaneCycleLift_translation_and_winding_zero_ofWalk L m' W
    (by simpa [hm'] using hclosed)
    (by intro j hj; exact hunit j (by simpa [hm'] using hj))
    hwalk
  exact ⟨hwalk, by simpa [Γ, hm'] using hresult.2.2⟩

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
  have hprojection :=
    oneSidedClosureProjectionFromWalk_closedNonbacktracking_of_point_injective
      γ hγ hwind k₀ hsimple
  have hzero := oneSidedClosureProjectionFromWalk_winding_zero_of_projection
    γ hγ hwind k₀ hprojection
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hz := hzero t c ht hc
  dsimp only at hz ⊢
  obtain ⟨hwalk, hv, hh⟩ := hz
  refine ⟨?_, hwalk, hv, hh⟩
  let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
  let N := oneSidedClosureLength (m + 1) L
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
  have hsum : 0 < (horizontalDirectedWindingNumber γ).natAbs +
      (verticalDirectedWindingNumber γ).natAbs := by
    by_contra h
    have hh0 : horizontalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    have hv0 : verticalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    exact hwind (Prod.ext hh0 hv0)
  have hN : N - 1 + 1 = N := by
    dsimp [N, oneSidedClosureLength]
    have hb := Nat.mul_pos ht hsum
    omega
  -- 射影の平面持ち上げは閉包点列の平行移動である
  have htranslation := (projectedPlaneCycleLift_translation_and_winding_zero_ofWalk L (N - 1) W
    (by rw [hN]; exact oneSidedClosureFromWalk_closed γ k₀ t c hc)
    (by
      intro j hj
      exact oneSidedClosureFromWalk_unit_steps γ hγ hwind k₀ t c ht hc j (by omega))
    hwalk).1
  -- 持ち上げ点が一致すれば閉包点が一致し、閉包の単純性から添字が一致する
  intro i j hij
  have hi := htranslation i.castSucc
  have hj := htranslation j.castSucc
  dsimp only at hij
  rw [hi, hj] at hij
  have hW : W i.val = W j.val := by
    have hfst := congrArg Prod.fst hij
    have hsnd := congrArg Prod.snd hij
    simp only [Fin.val_castSucc, Prod.fst_add, Prod.snd_add, Prod.fst_sub,
      Prod.snd_sub] at hfst hsnd
    exact Prod.ext (by omega) (by omega)
  exact Fin.ext (hsimple t c ht hc i.val (by omega) j.val (by omega) hW)

end Ising2DLambda.KacWard
