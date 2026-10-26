import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingCrossPairCount
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingCrossPairCount

namespace Ising2DLambda.AlgebraicEigenvalue

/-- The concrete order-count equality is the specialization of the relation-only proof. -/
theorem blockPreserving_crossPair_order_count_from_necSuf
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K) (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})
    (k l : K) :
    ((Finset.univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => σ.1 p.1.val < σ.1 p.2.val)).card =
    ((Finset.univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => p.1.val < p.2.val)).card := by
  classical
  exact NecSuf.AlgebraicEigenvalue.blockPreserving_crossPair_count
    block (fun i j : J => i < j) σ k l

end Ising2DLambda.AlgebraicEigenvalue
