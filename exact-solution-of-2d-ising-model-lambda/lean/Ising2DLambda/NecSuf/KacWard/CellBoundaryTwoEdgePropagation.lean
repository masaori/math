import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Balance and two-edge support alone force the incoming and outgoing weighted
coefficients to agree. -/
theorem two_edge_coefficient_propagation {E : Type*} [Fintype E] [DecidableEq E]
    (coefficient divergence : E → ℤ) (incoming outgoing : E)
    (hinout : incoming ≠ outgoing)
    (hbalance : (∑ edge : E, coefficient edge * divergence edge) = 0)
    (hsupport : ∀ edge : E, edge ≠ incoming → edge ≠ outgoing →
      coefficient edge * divergence edge = 0)
    (incomingSign outgoingSign : ℤ)
    (hin : divergence incoming = -incomingSign)
    (hout : divergence outgoing = outgoingSign) :
    coefficient incoming * incomingSign =
      coefficient outgoing * outgoingSign := by
  let f : E → ℤ := fun edge => coefficient edge * divergence edge
  have hsub : ({incoming, outgoing} : Finset E) ⊆ Finset.univ := by simp
  have hsum : (∑ edge ∈ ({incoming, outgoing} : Finset E), f edge) =
      ∑ edge : E, f edge := by
    apply Finset.sum_subset hsub
    intro edge _ hnot
    have hnein : edge ≠ incoming := by
      intro heq
      exact hnot (by simp [heq])
    have hneout : edge ≠ outgoing := by
      intro heq
      exact hnot (by simp [heq])
    exact hsupport edge hnein hneout
  have htwo : f incoming + f outgoing = 0 := by
    rw [← hsum] at hbalance
    simpa [f, hinout] using hbalance
  simp only [f, hin, hout] at htwo
  linear_combination -htwo

end Ising2DLambda.NecSuf.KacWard
