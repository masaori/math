import Ising2DLambda.NecSuf.KacWard.DualEndpointModeVector
import Ising2DLambda.NecSuf.KacWard.EndpointModeVector

namespace Ising2DLambda.NecSuf.KacWard

open BigOperators

theorem distinctDirection_dualInner_zero_necSuf
    {E R : Type*} [Fintype E] [DecidableEq E] [DivisionSemiring R]
    (row column : E → ℕ) (direction : E → ZMod 4)
    (varpi varsigma varpi' varsigma' : R) (δ δ' : ZMod 4)
    (hne : δ ≠ δ') :
    ∑ e : E,
      dualEndpointModeVector row column direction varpi varsigma δ e *
        endpointModeVector row column direction varpi' varsigma' δ' e = 0 := by
  apply Finset.sum_eq_zero
  intro e _
  by_cases hδ : direction e = δ
  · have hδ' : direction e ≠ δ' := by
      intro heq
      exact hne (hδ.symm.trans heq)
    simp only [dualEndpointModeVector, endpointModeVector,
      if_pos hδ, if_neg hδ', mul_zero]
  · simp only [dualEndpointModeVector, if_neg hδ, zero_mul]

end Ising2DLambda.NecSuf.KacWard
