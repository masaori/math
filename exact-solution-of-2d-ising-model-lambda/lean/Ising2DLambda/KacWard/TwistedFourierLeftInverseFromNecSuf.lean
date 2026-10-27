/- `claim_twisted_fourier_left_inverse` の必要十分版からの導出。 -/
import Ising2DLambda.KacWard.TwistedFourierLeftInverse
import Ising2DLambda.NecSuf.KacWard.TwistedFourierLeftInverse
import Ising2DLambda.KacWard.DualTwistedFourierMatrixFromNecSuf
import Ising2DLambda.KacWard.TwistedFourierMatrixFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open BigOperators

theorem twistedFourier_leftInverse_from_necSuf {L : ℕ} [NeZero L]
    (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    twistedFourierInverseCandidate s κ * twistedFourierMatrix s κ = 1 := by
  classical
  let ψ : {m // m ∈ fourierModeIndexSet L s} → OrientedEdge L → Qbar :=
    fun m e => endpointModeVector L m.val.1 m.val.2.1 m.val.2.2 e
  let ψbar : {m // m ∈ fourierModeIndexSet L s} → OrientedEdge L → Qbar :=
    fun m e => dualEndpointModeVector L m.val.1 m.val.2.1 m.val.2.2 e
  have hL : (L : Qbar) ≠ 0 := by exact_mod_cast (NeZero.ne L)
  have hscale : (L : Qbar) ^ 2 ≠ 0 := pow_ne_zero _ hL
  have hinner (m n : {m // m ∈ fourierModeIndexSet L s}) :
      (∑ e : OrientedEdge L, ψbar m e * ψ n e) =
        if m = n then (L : Qbar) ^ 2 else 0 := by
    have hm : m.val.1 ∈ horizontalTwistedModes L s ∧
        m.val.2.1 ∈ verticalTwistedModes L s := m.property
    have hn : n.val.1 ∈ horizontalTwistedModes L s ∧
        n.val.2.1 ∈ verticalTwistedModes L s := n.property
    by_cases hd : m.val.2.2 = n.val.2.2
    · have heq : (m.val.1 = n.val.1 ∧ m.val.2.1 = n.val.2.1) ↔ m = n := by
        constructor
        · rintro ⟨hfirst, hsecond⟩
          exact Subtype.ext (Prod.ext hfirst (Prod.ext hsecond hd))
        · intro hmn
          exact ⟨congrArg (fun x : {m // m ∈ fourierModeIndexSet L s} => x.val.1) hmn,
            congrArg (fun x : {m // m ∈ fourierModeIndexSet L s} => x.val.2.1) hmn⟩
      dsimp [ψ, ψbar]
      rw [← hd]
      simpa only [heq] using
        sameDirection_dualInner_orthogonality s m.val.1 m.val.2.1 n.val.1 n.val.2.1
          m.val.2.2 hm.1 hm.2 hn.1 hn.2
    · dsimp [ψ, ψbar]
      rw [distinctDirection_dualInner_zero m.val.1 m.val.2.1 n.val.1 n.val.2.1
        m.val.2.2 n.val.2.2 hd]
      have hmn : m ≠ n := fun heq => hd (congrArg (fun x => x.val.2.2) heq)
      simp [hmn]
  have h := Ising2DLambda.NecSuf.KacWard.fourier_leftInverse_necSuf
    κ ψ ψbar ((L : Qbar) ^ 2) hscale hinner
  rw [twistedFourierInverseCandidate_from_necSuf,
    twistedFourierMatrix_from_necSuf]
  simpa only [ψ, ψbar, inv_pow] using h

end Ising2DLambda.KacWard
