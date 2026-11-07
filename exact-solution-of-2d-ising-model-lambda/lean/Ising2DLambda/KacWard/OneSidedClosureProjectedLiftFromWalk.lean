import Ising2DLambda.KacWard.OneSidedClosureNonbacktracking
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning
import Ising2DLambda.KacWard.OneSidedClosurePointInjectiveFromWalk
import Ising2DLambda.KacWard.PlaneSimpleCycleTorusProjection

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 射影した辺列を、指定した始点から平面へ持ち上げ直す。 -/
def projectedClosureLift (L : ℕ) [NeZero L] (W : ℕ → ℤ × ℤ)
    (start : ℤ × ℤ) : ℕ → ℤ × ℤ
  | 0 => start
  | j + 1 => projectedClosureLift L W start j +
      orientedEdgeLatticeStep (projectedUnitStep L (W j) (W (j + 1) - W j))

/-- 射影辺列の `planeLift` は、同じ始点からの再持ち上げと各点で一致する。 -/
theorem planeLift_projectedUnitStep_eq_projectedClosureLift (L m : ℕ) [NeZero L]
    (W : ℕ → ℤ × ℤ) :
    let Γ : Fin (m + 1) → OrientedEdge L := fun j =>
      projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
    ∀ j : Fin (m + 2),
      planeLift Γ j = projectedClosureLift L W (planeLift Γ 0) j.val := by
  dsimp only
  let Γ : Fin (m + 1) → OrientedEdge L := fun j =>
    projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
  intro j
  induction j using Fin.induction with
  | zero => rfl
  | succ i ih =>
      rw [planeLift_succ Γ i, ih]
      rfl

/-- The lift of a projected unit-step edge sequence inherits distinctness of its
reconstructed plane points before the closing endpoint. -/
theorem planeLift_projectedUnitStep_injective (L m : ℕ) [NeZero L]
    (W : ℕ → ℤ × ℤ)
    (hdistinct : ∀ i < m + 1, ∀ j < m + 1,
      projectedClosureLift L W
        (planeLift (fun k : Fin (m + 1) =>
          projectedUnitStep L (W k.val) (W (k.val + 1) - W k.val)) 0) i =
      projectedClosureLift L W
        (planeLift (fun k : Fin (m + 1) =>
          projectedUnitStep L (W k.val) (W (k.val + 1) - W k.val)) 0) j → i = j) :
    Function.Injective (fun i : Fin (m + 1) =>
      planeLift (fun k : Fin (m + 1) =>
        projectedUnitStep L (W k.val) (W (k.val + 1) - W k.val)) i.castSucc) := by
  intro i j hij
  have hi := planeLift_projectedUnitStep_eq_projectedClosureLift L m W i.castSucc
  have hj := planeLift_projectedUnitStep_eq_projectedClosureLift L m W j.castSucc
  have heq := hdistinct i.val i.isLt j.val j.isLt (by
    simpa only [Fin.val_castSucc] using hi.symm.trans (hij.trans hj))
  exact Fin.ext heq

theorem projectedUnitStep_displacement (L : ℕ) [NeZero L]
    (p u : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)) :
    orientedEdgeLatticeStep (projectedUnitStep L p u) = u := by
  rw [orientedEdgeLatticeStep_eq_directionUnitVector, projectedUnitStep_direction]
  rcases hu with rfl | rfl | rfl | rfl <;>
    norm_num [unitStepDirection, directionUnitVector] <;> decide

/-- 実際の閉歩道から作った一側閉包の各歩は単位格子歩である。 -/
theorem oneSidedClosureFromWalk_unit_steps {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ) (t c : ℕ) (ht : 0 < t) (hc : 0 < c) :
    let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
    let N := oneSidedClosureLength (m + 1) L
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
    ∀ j < N, W (j + 1) - W j = (0, 1) ∨
      W (j + 1) - W j = (1, 0) ∨
      W (j + 1) - W j = (0, -1) ∨
      W (j + 1) - W j = (-1, 0) := by
  have hstep (j : ℕ) (hj : j < m + 1) :
      planeLiftIntegerBase γ ((j : ℤ) + 1) =
        planeLiftIntegerBase γ j +
          orientedEdgeLatticeStep (γ ⟨(j : ZMod (m + 1)).val,
            ZMod.val_lt (j : ZMod (m + 1))⟩) := by
    simpa [ZMod.val_natCast, Nat.mod_eq_of_lt hj] using
      planeLiftIntegerBase_step γ j hj
  have hsum : 0 < (horizontalDirectedWindingNumber γ).natAbs +
      (verticalDirectedWindingNumber γ).natAbs := by
    by_contra h
    have hh : horizontalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    have hv : verticalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    exact hwind (Prod.ext hh hv)
  exact oneSidedClosurePoint_unit_steps (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
    (fun j => γ ⟨j.val, ZMod.val_lt j⟩) hstep
    (planeLiftIntegerBase_endpoint γ hγ)
    (by rw [← Nat.mul_add]; exact Nat.mul_pos (NeZero.pos L) hsum)
    (Nat.mul_pos ht hsum) hc

/-- 実際の一側閉包の射影辺列を持ち上げ直した点は、閉包点列の一定平行移動である。 -/
theorem oneSidedClosureProjectedLiftFromWalk_translation {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ) (t c : ℕ) (ht : 0 < t) (hc : 0 < c)
    (start : ℤ × ℤ) :
    let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
    let N := oneSidedClosureLength (m + 1) L
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
    ∀ j ≤ N, projectedClosureLift L W start j = start + W j - W 0 := by
  dsimp only
  let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
  let N := oneSidedClosureLength (m + 1) L
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
  have hstep (j : ℕ) (hj : j < m + 1) :
      planeLiftIntegerBase γ ((j : ℤ) + 1) =
        planeLiftIntegerBase γ j +
          orientedEdgeLatticeStep (γ ⟨(j : ZMod (m + 1)).val,
            ZMod.val_lt (j : ZMod (m + 1))⟩) := by
    simpa [ZMod.val_natCast, Nat.mod_eq_of_lt hj] using
      planeLiftIntegerBase_step γ j hj
  have hsum : 0 < (horizontalDirectedWindingNumber γ).natAbs +
      (verticalDirectedWindingNumber γ).natAbs := by
    by_contra h
    have hh : horizontalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    have hv : verticalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    exact hwind (Prod.ext hh hv)
  have hunit := oneSidedClosurePoint_unit_steps (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
    (fun j => γ ⟨j.val, ZMod.val_lt j⟩) hstep
    (planeLiftIntegerBase_endpoint γ hγ)
    (by rw [← Nat.mul_add]; exact Nat.mul_pos (NeZero.pos L) hsum)
    (Nat.mul_pos ht hsum) hc
  intro j hj
  induction j with
  | zero => simp [projectedClosureLift]
  | succ j ih =>
      have hjN : j < N := by omega
      have hstep := projectedUnitStep_displacement L (W j) (W (j + 1) - W j)
        (hunit j hjN)
      rw [projectedClosureLift, hstep, ih (by omega)]
      dsimp only [W] at *
      ext <;> simp only [Prod.fst_add, Prod.snd_add, Prod.fst_sub, Prod.snd_sub] <;> omega

/-- 実際の一側閉包の射影辺列を持ち上げ直すと、終点は始点に戻る。 -/
theorem oneSidedClosureProjectedLiftFromWalk_closed {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ) (t c : ℕ) (ht : 0 < t) (hc : 0 < c)
    (start : ℤ × ℤ) :
    let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
    let N := oneSidedClosureLength (m + 1) L
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
    projectedClosureLift L W start N = start := by
  dsimp only
  let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
  let N := oneSidedClosureLength (m + 1) L
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
  have htranslation := oneSidedClosureProjectedLiftFromWalk_translation
    γ hγ hwind k₀ t c ht hc start N (by omega)
  have hW : W N = W 0 := by
    let wh := horizontalDirectedWindingNumber γ
    let wv := verticalDirectedWindingNumber γ
    let p := fun i : ℕ => periodicPlaneLift (m + 1) (planeLiftIntegerBase γ) L wv wh (k₀ + i)
    let S := p 0
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    let q := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
    let r := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
    let s := iteratedTransverseStaircase wh wv S
    have hN : N = c * (m + 1) + 2 * b + c * n := by
      dsimp [N, oneSidedClosureLength, b, n, wh, wv]
      omega
    rw [hN]
    change oneSidedPeriodicLiftClosure p q r s (c * (m + 1)) b (c * n)
      (c * (m + 1) + 2 * b + c * n) =
        oneSidedPeriodicLiftClosure p q r s (c * (m + 1)) b (c * n) 0
    have ha : 0 < c * (m + 1) := Nat.mul_pos hc (by omega)
    have hna : ¬c * (m + 1) + 2 * b + c * n < c * (m + 1) := by omega
    have hnab : ¬c * (m + 1) + 2 * b + c * n < c * (m + 1) + b := by omega
    have hnabc : ¬c * (m + 1) + 2 * b + c * n < c * (m + 1) + b + c * n := by omega
    simp [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath,
      ha, hna, hnab, hnabc, s, S, iteratedTransverseStaircase,
      iteratedStaircase, windingTransverseStaircase, twoPhaseStaircase]
  rw [htranslation]
  change start + W N - W 0 = start
  rw [hW]
  ext <;> simp

/-- 実際の閉歩道から作った射影辺列の持ち上げ点は、終点を除いて相異なる。 -/
theorem oneSidedClosureProjectedLiftFromWalk_injective {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (start : ℤ × ℤ) :
    ∃ k₀ : ℤ, ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      ∀ i < N, ∀ j < N,
        projectedClosureLift L W start i = projectedClosureLift L W start j → i = j := by
  obtain ⟨k₀, hsimple⟩ :=
    oneSidedClosurePointFromWalk_injective γ hγ hcontact hwind
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  dsimp only
  intro i hi j hj hij
  have htranslation := oneSidedClosureProjectedLiftFromWalk_translation
    γ hγ hwind k₀ t c ht hc start
  have hi' := htranslation i (by omega)
  have hj' := htranslation j (by omega)
  rw [hi', hj'] at hij
  have hW : oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c i =
      oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c j := by
    have hfst := congrArg Prod.fst hij
    have hsnd := congrArg Prod.snd hij
    ext <;>
      simp only [Prod.fst_add, Prod.snd_add, Prod.fst_sub, Prod.snd_sub] at * <;>
      omega
  exact hsimple t c ht hc i hi j hj hW

/-- The actual plane lift of the projected one-sided closure has distinct points
before its closing endpoint. -/
theorem oneSidedClosureProjectionFromWalk_planeLift_injective_of_point_injective
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hsimple : ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      ∀ i < N, ∀ j < N, W i = W j → i = j) :
    ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      Function.Injective (fun i : Fin (N - 1 + 1) =>
        planeLift (fun j : Fin (N - 1 + 1) =>
          projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)) i.castSucc) := by
  intro t c ht hc
  let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
  let N := oneSidedClosureLength (m + 1) L
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
  apply planeLift_projectedUnitStep_injective L (N - 1) W
  intro i hi j hj hij
  have htranslation := oneSidedClosureProjectedLiftFromWalk_translation
    γ hγ hwind k₀ t c ht hc
    (planeLift (fun j : Fin (N - 1 + 1) =>
      projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)) 0)
  have hN : N - 1 + 1 = N := by
    dsimp [N, oneSidedClosureLength]
    have hsum : 0 < (horizontalDirectedWindingNumber γ).natAbs +
        (verticalDirectedWindingNumber γ).natAbs := by
      by_contra h
      have hh : horizontalDirectedWindingNumber γ = 0 :=
        Int.natAbs_eq_zero.mp (by omega)
      have hv : verticalDirectedWindingNumber γ = 0 :=
        Int.natAbs_eq_zero.mp (by omega)
      exact hwind (Prod.ext hh hv)
    have hb := Nat.mul_pos ht hsum
    omega
  have hi' := htranslation i (by omega)
  have hj' := htranslation j (by omega)
  rw [hi', hj'] at hij
  have hW : W i = W j := by
    calc
      W i = (planeLift (fun j : Fin (N - 1 + 1) =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)) 0 +
        W i - W 0) -
        planeLift (fun j : Fin (N - 1 + 1) =>
          projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)) 0 + W 0 := by abel
      _ = (planeLift (fun j : Fin (N - 1 + 1) =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)) 0 +
        W j - W 0) -
        planeLift (fun j : Fin (N - 1 + 1) =>
          projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)) 0 + W 0 := by
            rw [hij]
      _ = W j := by abel
  exact hsimple t c ht hc i (by omega) j (by omega) hW

/-- 実際の閉歩道から作った射影辺列の持ち上げ点は、終点を除いて相異なる。 -/
theorem oneSidedClosureProjectionFromWalk_planeLift_injective {L m : ℕ} [NeZero L]
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
      Function.Injective (fun i : Fin (N - 1 + 1) =>
        planeLift (fun j : Fin (N - 1 + 1) =>
          projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)) i.castSucc) := by
  obtain ⟨k₀, hsimple⟩ := oneSidedClosurePointFromWalk_injective γ hγ hcontact hwind
  exact ⟨k₀, oneSidedClosureProjectionFromWalk_planeLift_injective_of_point_injective
    γ hγ hwind k₀ hsimple⟩

/-- A point-simple one-sided closure projects to a closed nonbacktracking walk. -/
theorem oneSidedClosureProjectionFromWalk_closedNonbacktracking_of_point_injective
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hsimple : ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      ∀ i < N, ∀ j < N, W i = W j → i = j) :
    ∀ t c : ℕ, 0 < t → 0 < c →
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
        edge k ≠ reversal (edge j)) := by
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
  have hN : 3 ≤ N := by
    dsimp [N, oneSidedClosureLength]
    have hb := Nat.mul_pos ht hsum
    have hm : 0 < c * (m + 1) := Nat.mul_pos hc (by omega)
    omega
  letI : NeZero N := ⟨by omega⟩
  have hunit (j : Fin N) :
      W (j.val + 1) - W j.val = (0, 1) ∨
      W (j.val + 1) - W j.val = (1, 0) ∨
      W (j.val + 1) - W j.val = (0, -1) ∨
      W (j.val + 1) - W j.val = (-1, 0) :=
    oneSidedClosureFromWalk_unit_steps γ hγ hwind k₀ t c ht hc j.val j.isLt
  have hclosed : W N = W 0 := by
    have ht' := oneSidedClosureProjectedLiftFromWalk_translation
      γ hγ hwind k₀ t c ht hc (0, 0) N (by omega)
    have hc' := oneSidedClosureProjectedLiftFromWalk_closed
      γ hγ hwind k₀ t c ht hc (0, 0)
    dsimp only at hc'
    rw [ht'] at hc'
    have hfst := congrArg Prod.fst hc'
    have hsnd := congrArg Prod.snd hc'
    have hfst' : (W N).1 = (W 0).1 := by
      have h : (W N).1 - (W 0).1 = 0 := by simpa [W] using hfst
      omega
    have hsnd' : (W N).2 = (W 0).2 := by
      have h : (W N).2 - (W 0).2 = 0 := by simpa [W] using hsnd
      omega
    exact Prod.ext hfst' hsnd'
  have hsimple' (i j : Fin N) (hij : i ≠ j) : W i.val ≠ W j.val := by
    intro heq
    exact hij (Fin.ext (hsimple t c ht hc i.val i.isLt j.val j.isLt heq))
  have hprojection :=
    planeUnitPathTorusProjection_closedNonbacktracking L N hN
      (fun j : Fin (N + 1) => W j.val)
      (by intro j; exact hunit j)
      (by simpa using hclosed)
      (by intro i j hij; exact hsimple' i j hij)
  dsimp only at hprojection ⊢
  refine ⟨hprojection.1, ?_, ?_⟩
  · intro j k hk
    have hkj : k = j + 1 := Fin.ext (by simpa [Fin.val_add] using hk)
    subst k
    exact hprojection.2.1 j
  · intro j k hk
    have hkj : k = j + 1 := Fin.ext (by simpa [Fin.val_add] using hk)
    subst k
    exact hprojection.2.2 j

/-- 実際の閉歩道から作った一側閉包の射影辺列は巡回接続し、反転しない。 -/
theorem oneSidedClosureProjectionFromWalk_closedNonbacktracking {L m : ℕ} [NeZero L]
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
      let edge := planeUnitPathTorusProjection L N (fun j : Fin (N + 1) => W j.val)
      (∀ j : Fin N,
        orientedSource (edge j) = planeVertexProjection L (W j.val) ∧
        orientedTarget (edge j) = planeVertexProjection L (W (j.val + 1))) ∧
      (∀ j k : Fin N, k.val = (j.val + 1) % N →
        orientedTarget (edge j) = orientedSource (edge k)) ∧
      (∀ j k : Fin N, k.val = (j.val + 1) % N →
        edge k ≠ reversal (edge j)) := by
  obtain ⟨k₀, hsimple⟩ :=
    oneSidedClosurePointFromWalk_injective γ hγ hcontact hwind
  exact ⟨k₀, oneSidedClosureProjectionFromWalk_closedNonbacktracking_of_point_injective
    γ hγ hwind k₀ hsimple⟩

end Ising2DLambda.KacWard
