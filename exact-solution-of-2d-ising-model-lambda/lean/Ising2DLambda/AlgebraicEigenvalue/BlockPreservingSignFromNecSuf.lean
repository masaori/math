import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingSignFromEvenCrossCountFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.BlockAcrossFiberParity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- The general involutory-power identity gives the integer sign identity. -/
theorem blockPreserving_sign_eq_prod_from_necSuf
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) :
    blockPermutationSign block σ = ∏ k : K, fiberPermutationSign block σ k := by
  have hcross : Even (blockAcrossFiberInversions block σ).card :=
    blockAcrossFiberInversions_card_even block σ
  exact blockPreserving_sign_eq_prod_of_even_cross_count_from_necSuf block σ hcross

end Ising2DLambda.AlgebraicEigenvalue
