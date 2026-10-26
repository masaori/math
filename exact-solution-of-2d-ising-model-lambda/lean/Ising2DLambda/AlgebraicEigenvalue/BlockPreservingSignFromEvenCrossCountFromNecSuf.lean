import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingSignFromEvenCrossCount
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitPermutationSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- The abstract even-remainder power identity specializes to fiber signs. -/
theorem blockPreserving_sign_eq_prod_of_even_cross_count_from_necSuf
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})
    (hcross : Even (blockAcrossFiberInversions block σ).card) :
    blockPermutationSign block σ = ∏ k : K, fiberPermutationSign block σ k := by
  classical
  obtain ⟨m, hm⟩ := hcross
  have hcross_count : (blockAcrossFiberInversions block σ).card = 2 * m := by omega
  have htotal : blockInversionCount block σ =
      (∑ k : K, (fiberInversionPairs block σ k).card) + 2 * m := by
    rw [blockPreserving_inversionCount_fiber_decomposition, hcross_count]
    congr 1
    apply Finset.sum_congr rfl
    intro k _
    exact blockWithinFiberInversions_card_eq_restriction block σ k
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_eq_prod_pow_of_even_remainder
    (-1 : ℤ) (by norm_num) univ
    (fun k : K => (fiberInversionPairs block σ k).card)
    (blockInversionCount block σ) m htotal

end Ising2DLambda.AlgebraicEigenvalue
