import Mathlib.Tactic
import Ising2DLambda.KacWard.SeamModePhaseAllDirections
import Ising2DLambda.NecSuf.KacWard.SeamModePhaseAllDirections

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The abstract four-case argument specializes to the four actual seam identities. -/
theorem seamModePhase_allDirections_from_necSuf (L : ℕ) (hL : 1 ≤ L)
    (s : SpinStructure) (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (f : OrientedEdge L) :
    (twistSign s f : Qbar) *
      (varpi ^ (orientedTarget f).2.val * varsigma ^ (orientedTarget f).1.val) =
      directionModeWeight varpi varsigma (directionNumber f) *
        (varpi ^ (orientedSource f).2.val * varsigma ^ (orientedSource f).1.val) := by
  let d := directionNumber f
  let lhs : Qbar := (twistSign s f : Qbar) *
    (varpi ^ (orientedTarget f).2.val * varsigma ^ (orientedTarget f).1.val)
  let base : Qbar := varpi ^ (orientedSource f).2.val * varsigma ^ (orientedSource f).1.val
  have h10 : (1 : ZMod 4) ≠ 0 := by decide
  have h20 : (2 : ZMod 4) ≠ 0 := by decide
  have h21 : (2 : ZMod 4) ≠ 1 := by decide
  have h30 : (3 : ZMod 4) ≠ 0 := by decide
  have h31 : (3 : ZMod 4) ≠ 1 := by decide
  have h32 : (3 : ZMod 4) ≠ 2 := by decide
  apply Ising2DLambda.NecSuf.KacWard.seamModePhase_allDirections_necSuf
    d lhs base (directionModeWeight varpi varsigma)
  · intro hd
    rcases f with ⟨e, rev⟩
    by_cases hh : e.val < L ^ 2 <;> cases rev
    · have h := rightwardSeam_modePhase L hL s varpi varsigma hvarpi e hh
      simp only [lhs, base, d] at hd ⊢
      simp [directionNumber, hh, directionModeWeight, pow_succ] at hd ⊢
      calc
        _ = varpi ^ ((orientedSource (e, false)).2.val + 1) *
              varsigma ^ (orientedSource (e, false)).1.val := h
        _ = _ := by rw [pow_succ]; ring
    · simp [d, directionNumber, hh, h20] at hd
    · simp [d, directionNumber, hh, h10] at hd
    · simp [d, directionNumber, hh, h30] at hd
  · intro hd
    rcases f with ⟨e, rev⟩
    by_cases hh : e.val < L ^ 2 <;> cases rev
    · simp [d, directionNumber, hh] at hd
      exact False.elim ((by decide : (0 : ZMod 4) ≠ 1) hd)
    · simp [d, directionNumber, hh, h21] at hd
    · have h := downwardSeam_modePhase L hL s varpi varsigma hvarsigma e hh
      simp only [lhs, base, d] at hd ⊢
      simp [directionNumber, hh, directionModeWeight, h10] at hd ⊢
      calc
        _ = varpi ^ (orientedSource (e, false)).2.val *
              varsigma ^ ((orientedSource (e, false)).1.val + 1) := h
        _ = _ := by rw [pow_succ]; ring
    · simp [d, directionNumber, hh, h31] at hd
  · intro hd
    rcases f with ⟨e, rev⟩
    by_cases hh : e.val < L ^ 2 <;> cases rev
    · simp [d, directionNumber, hh] at hd
      exact False.elim ((by decide : (0 : ZMod 4) ≠ 2) hd)
    · have h := leftwardSeam_modePhase L hL s varpi varsigma hvarpi e hh
      simpa [lhs, base, d, directionModeWeight, directionNumber, hh, h20, h21] using h
    · simp [d, directionNumber, hh] at hd
      exact False.elim ((by decide : (1 : ZMod 4) ≠ 2) hd)
    · simp [d, directionNumber, hh, h32] at hd
  · intro hd
    rcases f with ⟨e, rev⟩
    by_cases hh : e.val < L ^ 2 <;> cases rev
    · simp [d, directionNumber, hh] at hd
      exact False.elim ((by decide : (0 : ZMod 4) ≠ 3) hd)
    · simp [d, directionNumber, hh] at hd
      exact False.elim ((by decide : (2 : ZMod 4) ≠ 3) hd)
    · simp [d, directionNumber, hh] at hd
      exact False.elim ((by decide : (1 : ZMod 4) ≠ 3) hd)
    · have h := upwardSeam_modePhase L hL s varpi varsigma hvarsigma e hh
      simpa [lhs, base, d, directionModeWeight, directionNumber, hh, h30, h31, h32] using h

end Ising2DLambda.KacWard
