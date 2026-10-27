import Mathlib.Tactic
import Ising2DLambda.KacWard.SuccessorDirectionSelection
import Ising2DLambda.KacWard.SeamModePhaseAllDirections
import Ising2DLambda.KacWard.EndpointModeVector

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The transition sum has one possible successor in the selected direction. -/
theorem transition_on_endpointModeVector (L : ℕ) (hL : 1 ≤ L)
    (z : Qbar) (s : SpinStructure) (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (d : ZMod 4) (e : OrientedEdge L) :
    (kacWardTransitionMatrix L z s).mulVec
      (endpointModeVector L varpi varsigma d) e =
      modeSmallMatrix z varpi varsigma (directionNumber e) d *
        endpointModeVector L varpi varsigma (directionNumber e) e := by
  letI : NeZero L := ⟨by omega⟩
  classical
  obtain ⟨f, ⟨hsource, hd, hnext⟩, _⟩ := successorDirection_selection e d
  have hsum :
      (kacWardTransitionMatrix L z s).mulVec
        (endpointModeVector L varpi varsigma d) e =
      kacWardTransitionMatrix L z s e f * endpointModeVector L varpi varsigma d f := by
    change (∑ g : OrientedEdge L,
      kacWardTransitionMatrix L z s e g * endpointModeVector L varpi varsigma d g) = _
    apply Fintype.sum_eq_single f
    intro g hgf
    by_cases hmem : g ∈ nonbacktrackingSuccessors e
    · by_cases hdir : directionNumber g = d
      · have hsrc : orientedSource g = orientedTarget e :=
          (Finset.mem_filter.mp hmem).2.1.symm
        have heq : g = f := sourceDirection_bijective.1
          (Prod.ext (hsrc.trans hsource.symm) (hdir.trans hd.symm))
        exact False.elim (hgf heq)
      · simp [endpointModeVector, hdir]
    · simp [kacWardTransitionMatrix, hmem]
  by_cases hback : d = directionNumber e + 2
  · have hfnot : f ∉ nonbacktrackingSuccessors e := by
      intro h
      exact (hnext.mp h) hback
    have hsmall : modeSmallMatrix z varpi varsigma (directionNumber e) d = 0 := by
      rw [hback]
      have hneq : ∀ δ : ZMod 4, δ + 2 ≠ δ ∧ δ + 2 ≠ δ + 1 ∧ δ + 2 ≠ δ - 1 := by decide
      obtain ⟨hzero, hone, hthree⟩ := hneq (directionNumber e)
      simp [modeSmallMatrix, hzero, hone, hthree]
    calc
      _ = kacWardTransitionMatrix L z s e f * endpointModeVector L varpi varsigma d f := hsum
      _ = 0 := by simp [kacWardTransitionMatrix, hfnot]
      _ = modeSmallMatrix z varpi varsigma (directionNumber e) d *
          endpointModeVector L varpi varsigma (directionNumber e) e := by rw [hsmall]; ring
  · have hfmem : f ∈ nonbacktrackingSuccessors e := hnext.mpr hback
    have hseam := seamModePhase_allDirections L hL s varpi varsigma
      hvarpi hvarsigma f
    have hphase : rotationPhase z e f * directionModeWeight varpi varsigma d =
        modeSmallMatrix z varpi varsigma (directionNumber e) d := by
      rw [← hd]
      rfl
    calc
      _ = kacWardTransitionMatrix L z s e f * endpointModeVector L varpi varsigma d f := hsum
      _ = ((twistSign s f : Qbar) * rotationPhase z e f) *
          (varpi ^ (orientedTarget f).2.val * varsigma ^ (orientedTarget f).1.val) := by
            simp [kacWardTransitionMatrix, hfmem, endpointModeVector, hd]
      _ = rotationPhase z e f * ((twistSign s f : Qbar) *
          (varpi ^ (orientedTarget f).2.val * varsigma ^ (orientedTarget f).1.val)) := by ring
      _ = rotationPhase z e f * (directionModeWeight varpi varsigma d *
          (varpi ^ (orientedTarget e).2.val * varsigma ^ (orientedTarget e).1.val)) := by
            rw [hseam, hd, hsource]
      _ = modeSmallMatrix z varpi varsigma (directionNumber e) d *
          (varpi ^ (orientedTarget e).2.val * varsigma ^ (orientedTarget e).1.val) := by
            rw [← hphase]; ring
      _ = modeSmallMatrix z varpi varsigma (directionNumber e) d *
          endpointModeVector L varpi varsigma (directionNumber e) e := by
            simp [endpointModeVector]

end Ising2DLambda.KacWard
