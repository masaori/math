import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingInversionDecomposition
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingInversionDecomposition

namespace Ising2DLambda.AlgebraicEigenvalue

theorem blockPreserving_inversionCount_fiber_decomposition_from_necSuf
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K) (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) :
    blockInversionCount block σ =
      (∑ k : K, (blockWithinFiberInversions block σ k).card) +
        (blockAcrossFiberInversions block σ).card := by
  classical
  exact NecSuf.AlgebraicEigenvalue.inversionCount_fiber_decomposition
    block (fun i j : J => i < j) σ.1

end Ising2DLambda.AlgebraicEigenvalue
