/- `claim_twisted_fourier_left_inverse` の具体版。 -/
import Ising2DLambda.KacWard.DualTwistedFourierMatrix
import Ising2DLambda.KacWard.DistinctDirectionDualInnerZero
import Ising2DLambda.KacWard.SameDirectionDualInnerOrthogonality
import Mathlib

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open BigOperators

theorem twistedFourier_leftInverse {L : ℕ} [NeZero L] (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    twistedFourierInverseCandidate s κ * twistedFourierMatrix s κ = 1 := by
  classical
  apply Matrix.ext
  intro g h
  let m := (κ g).val
  let n := (κ h).val
  have hm : m.1 ∈ horizontalTwistedModes L s ∧
      m.2.1 ∈ verticalTwistedModes L s := (κ g).property
  have hn : n.1 ∈ horizontalTwistedModes L s ∧
      n.2.1 ∈ verticalTwistedModes L s := (κ h).property
  have hinner :
      (∑ e : OrientedEdge L,
        dualEndpointModeVector L m.1 m.2.1 m.2.2 e *
          endpointModeVector L n.1 n.2.1 n.2.2 e) =
        if m = n then (L : Qbar) ^ 2 else 0 := by
    by_cases hd : m.2.2 = n.2.2
    · rw [← hd]
      have heq : (m.1 = n.1 ∧ m.2.1 = n.2.1) ↔ m = n := by
        constructor
        · rintro ⟨hfirst, hsecond⟩
          exact Prod.ext hfirst (Prod.ext hsecond hd)
        · intro hmn
          exact ⟨congrArg Prod.fst hmn, congrArg (fun x => x.2.1) hmn⟩
      simpa only [heq] using
        sameDirection_dualInner_orthogonality s m.1 m.2.1 n.1 n.2.1 m.2.2
          hm.1 hm.2 hn.1 hn.2
    · rw [distinctDirection_dualInner_zero m.1 m.2.1 n.1 n.2.1 m.2.2 n.2.2 hd]
      have hmn : m ≠ n := fun heq => hd (congrArg (fun x => x.2.2) heq)
      simp [hmn]
  have hL : (L : Qbar) ≠ 0 := by exact_mod_cast (NeZero.ne L)
  rw [Matrix.one_apply]
  simp only [Matrix.mul_apply, twistedFourierInverseCandidate,
    dualTwistedFourierMatrix, twistedFourierMatrix, Matrix.smul_apply, smul_eq_mul]
  simp_rw [mul_assoc]
  rw [← Finset.mul_sum, hinner]
  by_cases hgh : g = h
  · subst hgh
    simp [m, n, hL]
  · have hmn : m ≠ n := by
      intro heq
      apply hgh
      exact κ.injective (Subtype.ext heq)
    simp [hmn, hgh]

end Ising2DLambda.KacWard
