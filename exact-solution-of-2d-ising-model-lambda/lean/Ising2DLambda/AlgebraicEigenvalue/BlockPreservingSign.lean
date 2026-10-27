import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingSignFromEvenCrossCount
import Ising2DLambda.AlgebraicEigenvalue.BlockAcrossFiberParity

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- A block-preserving permutation has the product of its fiber signs. -/
theorem blockPreserving_sign_eq_prod
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) :
    blockPermutationSign block σ = ∏ k : K, fiberPermutationSign block σ k := by
  have hcross : Even (blockAcrossFiberInversions block σ).card :=
    blockAcrossFiberInversions_card_even block σ
  exact blockPreserving_sign_eq_prod_of_even_cross_count block σ hcross

end Ising2DLambda.AlgebraicEigenvalue
