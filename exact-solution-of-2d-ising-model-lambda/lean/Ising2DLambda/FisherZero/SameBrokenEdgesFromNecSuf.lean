/- 具体版が必要十分版の特殊化であることの導出。住処: Z。 -/
import Ising2DLambda.FisherZero.SameBrokenEdges
import Ising2DLambda.NecSuf.FisherZero.SameBrokenEdges

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

theorem sameBrokenEdges_eq_or_globalSpinReversal_from_necSuf (L : ℕ) [NeZero L]
    (σ τ : Config L)
    (hbroken : ∀ e : Edge L,
      σ (boundary0 L e) ≠ σ (boundary1 L e) ↔
        τ (boundary0 L e) ≠ τ (boundary1 L e)) :
    τ = σ ∨ τ = globalSpinReversal L σ := by
  exact Ising2DLambda.NecSuf.FisherZero.eq_or_map_of_constant_agreement
    (0, 0) spinReversal σ τ
    (fun v => spinValue_eq_or_reversal (σ v) (τ v))
    (sameBrokenEdges_constantAgreement L σ τ hbroken)

end Ising2DLambda.FisherZero
