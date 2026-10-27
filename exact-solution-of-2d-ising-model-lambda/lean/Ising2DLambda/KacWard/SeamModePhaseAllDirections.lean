import Mathlib.Tactic
import Ising2DLambda.KacWard.ModeSmallMatrix
import Ising2DLambda.KacWard.RightwardSeamModePhase
import Ising2DLambda.KacWard.DownwardSeamModePhase
import Ising2DLambda.KacWard.LeftwardSeamModePhase
import Ising2DLambda.KacWard.UpwardSeamModePhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The four seam calculations give one identity for every actual oriented edge. -/
theorem seamModePhase_allDirections (L : ℕ) (hL : 1 ≤ L) (s : SpinStructure)
    (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (f : OrientedEdge L) :
    (twistSign s f : Qbar) *
      (varpi ^ (orientedTarget f).2.val * varsigma ^ (orientedTarget f).1.val) =
      directionModeWeight varpi varsigma (directionNumber f) *
        (varpi ^ (orientedSource f).2.val * varsigma ^ (orientedSource f).1.val) := by
  have h10 : (1 : ZMod 4) ≠ 0 := by decide
  have h20 : (2 : ZMod 4) ≠ 0 := by decide
  have h21 : (2 : ZMod 4) ≠ 1 := by decide
  have h30 : (3 : ZMod 4) ≠ 0 := by decide
  have h31 : (3 : ZMod 4) ≠ 1 := by decide
  have h32 : (3 : ZMod 4) ≠ 2 := by decide
  -- The four branches follow the four cited seam identities in the human proof.
  -- Only the forward branches additionally use the power addition law.
  rcases f with ⟨e, reverse⟩
  by_cases hh : e.val < L ^ 2
  · cases reverse
    · have h := rightwardSeam_modePhase L hL s varpi varsigma hvarpi e hh
      have hw : directionModeWeight varpi varsigma (directionNumber (e, false)) = varpi := by
        simp [directionModeWeight, directionNumber, hh, h10, h20, h21, h30, h31, h32]
      rw [hw]
      calc
        _ = varpi ^ ((orientedSource (e, false)).2.val + 1) *
              varsigma ^ (orientedSource (e, false)).1.val := h
        _ = _ := by rw [pow_succ]; ring
    · have h := leftwardSeam_modePhase L hL s varpi varsigma hvarpi e hh
      have hw : directionModeWeight varpi varsigma (directionNumber (e, true)) = varpi⁻¹ := by
        simp [directionModeWeight, directionNumber, hh, h10, h20, h21, h30, h31, h32]
      rw [hw]
      exact h
  · cases reverse
    · have h := downwardSeam_modePhase L hL s varpi varsigma hvarsigma e hh
      have hw : directionModeWeight varpi varsigma (directionNumber (e, false)) = varsigma := by
        simp [directionModeWeight, directionNumber, hh, h10, h20, h21, h30, h31, h32]
      rw [hw]
      calc
        _ = varpi ^ (orientedSource (e, false)).2.val *
              varsigma ^ ((orientedSource (e, false)).1.val + 1) := h
        _ = _ := by rw [pow_succ]; ring
    · have h := upwardSeam_modePhase L hL s varpi varsigma hvarsigma e hh
      have hw : directionModeWeight varpi varsigma (directionNumber (e, true)) = varsigma⁻¹ := by
        simp [directionModeWeight, directionNumber, hh, h10, h20, h21, h30, h31, h32]
      rw [hw]
      exact h

end Ising2DLambda.KacWard
