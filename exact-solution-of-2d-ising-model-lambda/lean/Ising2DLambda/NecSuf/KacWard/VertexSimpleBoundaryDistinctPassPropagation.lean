import Ising2DLambda.NecSuf.KacWard.CellBoundaryTwoEdgePropagation
import Ising2DLambda.NecSuf.KacWard.VertexSimpleBoundaryOtherEdgesZero

namespace Ising2DLambda.NecSuf.KacWard

/-- At a simple passage, support of the boundary on the walk reduces vertex balance
to the two distinct passage edges. No lattice geometry is used in this reduction. -/
theorem vertexSimple_distinct_pass_coefficient_propagation
    {m : ℕ} {E V B : Type*} [DecidableEq V] [Fintype B] [DecidableEq B]
    (γ : Fin (m + 1) → E) (source target : E → V)
    (hstep : ∀ k : Fin m, target (γ k.castSucc) = source (γ k.succ))
    (hclose : target (γ (Fin.last m)) = source (γ 0))
    (hinj : Function.Injective (target ∘ γ))
    (k next : Fin (m + 1)) (hnext : source (γ next) = target (γ k))
    (base : E → B) (coeff incidence : B → ℤ)
    (hsupport : ∀ b, coeff b ≠ 0 → ∃ j, base (γ j) = b)
    (hincident : ∀ e, incidence (base e) ≠ 0 →
      source e = target (γ k) ∨ target e = target (γ k))
    (hdistinct : base (γ k) ≠ base (γ next))
    (hbalance : (∑ b : B, coeff b * incidence b) = 0)
    (incomingSign outgoingSign : ℤ)
    (hin : incidence (base (γ k)) = -incomingSign)
    (hout : incidence (base (γ next)) = outgoingSign) :
    coeff (base (γ k)) * incomingSign =
      coeff (base (γ next)) * outgoingSign := by
  have hother : ∀ b : B, b ≠ base (γ k) → b ≠ base (γ next) →
      coeff b * incidence b = 0 := by
    intro b hfirst hsecond
    exact vertexSimple_other_edge_contribution_zero γ source target
      hstep hclose hinj k next hnext base coeff incidence
      hsupport hincident b hfirst hsecond
  exact two_edge_coefficient_propagation coeff incidence
    (base (γ k)) (base (γ next)) hdistinct hbalance hother
    incomingSign outgoingSign hin hout

end Ising2DLambda.NecSuf.KacWard
