import Mathlib.Tactic
import Ising2DLambda.KacWard.TransitionOnEndpointModeVector
import Ising2DLambda.KacWard.TwistedFourierMatrix
import Ising2DLambda.KacWard.ModeBlockMatrix

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem transition_fourier_intertwining {L : ℕ} [NeZero L]
    (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    kacWardTransitionMatrix L z s * twistedFourierMatrix s κ =
      twistedFourierMatrix s κ * modeBlockMatrix z s κ := by
  classical
  letI : Fintype {m // m ∈ fourierModeIndexSet L s} :=
    Fintype.ofEquiv (OrientedEdge L) κ
  apply Matrix.ext
  intro e h
  let m := κ h
  let d := directionNumber e
  let selected : {m // m ∈ fourierModeIndexSet L s} :=
    ⟨(m.val.1, m.val.2.1, d), m.property⟩
  have hleft :
      (kacWardTransitionMatrix L z s * twistedFourierMatrix s κ) e h =
        modeSmallMatrix z m.val.1 m.val.2.1 d m.val.2.2 *
          endpointModeVector L m.val.1 m.val.2.1 d e := by
    change (kacWardTransitionMatrix L z s).mulVec
      (endpointModeVector L m.val.1 m.val.2.1 m.val.2.2) e = _
    exact transition_on_endpointModeVector L (Nat.pos_of_ne_zero (NeZero.ne L))
      z s m.val.1 m.val.2.1 m.property.1 m.property.2 m.val.2.2 e
  have hright :
      (twistedFourierMatrix s κ * modeBlockMatrix z s κ) e h =
        endpointModeVector L m.val.1 m.val.2.1 d e *
          modeSmallMatrix z m.val.1 m.val.2.1 d m.val.2.2 := by
    rw [Matrix.mul_apply]
    change (∑ g : OrientedEdge L,
      endpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 e *
        modeBlockMatrix z s κ g h) = _
    rw [Fintype.sum_equiv κ (fun g : OrientedEdge L =>
      endpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 e *
        modeBlockMatrix z s κ g h)
      (fun n : {m // m ∈ fourierModeIndexSet L s} =>
        endpointModeVector L n.val.1 n.val.2.1 n.val.2.2 e *
          modeBlockMatrix z s κ (κ.symm n) h) (by intro g; simp)]
    calc
      _ = endpointModeVector L selected.val.1 selected.val.2.1 selected.val.2.2 e *
          modeBlockMatrix z s κ (κ.symm selected) h := by
        apply Fintype.sum_eq_single selected
        intro n hn
        by_cases hm : n.val.1 = m.val.1 ∧ n.val.2.1 = m.val.2.1
        · by_cases hd : n.val.2.2 = d
          · have heq : n = selected := by
              apply Subtype.ext
              rcases hm with ⟨h₁, h₂⟩
              exact Prod.ext h₁ (Prod.ext h₂ hd)
            exact (hn heq).elim
          · have hne : directionNumber e ≠ n.val.2.2 :=
              Ne.symm (by simpa [d] using hd)
            simp [endpointModeVector, hne]
        · simp [modeBlockMatrix, m, hm]
      _ = _ := by
        simp [selected, m, d, modeBlockMatrix, endpointModeVector]
  rw [hleft, hright]
  ring

end Ising2DLambda.KacWard
