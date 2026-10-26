import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingCrossPairParity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingCrossPairParity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- The order comparison is a decidable relation on the concrete finite index set. -/
theorem blockPreserving_crossPair_order_disagreement_even_from_necSuf
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K) (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})
    (k l : K) :
    Even (((Finset.univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => (p.1.val < p.2.val) != (σ.1 p.1.val < σ.1 p.2.val))).card) := by
  classical
  exact NecSuf.AlgebraicEigenvalue.blockPreserving_crossPair_disagreement_even
    block (fun i j : J => i < j) σ k l

end Ising2DLambda.AlgebraicEigenvalue
