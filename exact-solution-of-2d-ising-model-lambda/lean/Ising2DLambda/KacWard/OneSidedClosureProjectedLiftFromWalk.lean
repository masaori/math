import Ising2DLambda.KacWard.OneSidedClosureNonbacktracking
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning
import Ising2DLambda.KacWard.OneSidedClosurePointInjectiveFromWalk

namespace Ising2DLambda.KacWard

/-- 射影した辺列を、指定した始点から平面へ持ち上げ直す。 -/
def projectedClosureLift (L : ℕ) [NeZero L] (W : ℕ → ℤ × ℤ)
    (start : ℤ × ℤ) : ℕ → ℤ × ℤ
  | 0 => start
  | j + 1 => projectedClosureLift L W start j +
      orientedEdgeLatticeStep (projectedUnitStep L (W j) (W (j + 1) - W j))

private theorem projectedUnitStep_displacement (L : ℕ) [NeZero L]
    (p u : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)) :
    orientedEdgeLatticeStep (projectedUnitStep L p u) = u := by
  rw [orientedEdgeLatticeStep_eq_directionUnitVector, projectedUnitStep_direction]
  rcases hu with rfl | rfl | rfl | rfl <;>
    norm_num [unitStepDirection, directionUnitVector] <;> decide

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

end Ising2DLambda.KacWard
