import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockAcrossFiberParity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockWithinFiberInversions
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitPermutationSign

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- The parity argument needs only an involutory element of a commutative monoid. -/
theorem blockPreserving_pow_eq_prod_fiber_pow
    {J K M : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    [CommMonoid M] (u : M) (hu : u * u = 1) (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) :
    u ^ inversionCount (· < ·) σ.1 =
      ∏ k : K, u ^ (fiberInversionPairs block (· < ·) σ k).card := by
  classical
  obtain ⟨m, hm⟩ := blockAcrossFiberInversions_card_even block σ
  have hcross : (blockAcrossFiberInversions block (· < ·) σ.1).card = 2 * m := by
    omega
  have htotal : inversionCount (· < ·) σ.1 =
      (∑ k : K, (fiberInversionPairs block (· < ·) σ k).card) + 2 * m := by
    rw [inversionCount_fiber_decomposition block (· < ·) σ.1, hcross]
    congr 1
    apply Finset.sum_congr rfl
    intro k _
    exact blockWithinFiberInversions_card_eq_restriction block (· < ·) σ k
  exact pow_eq_prod_pow_of_even_remainder u hu univ
    (fun k : K => (fiberInversionPairs block (· < ·) σ k).card)
    (inversionCount (· < ·) σ.1) m htotal

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
