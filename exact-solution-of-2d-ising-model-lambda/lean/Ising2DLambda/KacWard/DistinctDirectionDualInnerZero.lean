import Ising2DLambda.KacWard.DualEndpointModeVector

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open BigOperators

theorem distinctDirection_dualInner_zero {L : ℕ}
    (varpi varsigma varpi' varsigma' : Qbar) (δ δ' : ZMod 4)
    (hne : δ ≠ δ') :
    ∑ e : OrientedEdge L,
      dualEndpointModeVector L varpi varsigma δ e *
        endpointModeVector L varpi' varsigma' δ' e = 0 := by
  apply Finset.sum_eq_zero
  intro e _
  by_cases hδ : directionNumber e = δ
  · have hδ' : directionNumber e ≠ δ' := by
      intro heq
      exact hne (hδ.symm.trans heq)
    simp only [dualEndpointModeVector, endpointModeVector,
      if_pos hδ, if_neg hδ', mul_zero]
  · simp only [dualEndpointModeVector, if_neg hδ, zero_mul]

end Ising2DLambda.KacWard
