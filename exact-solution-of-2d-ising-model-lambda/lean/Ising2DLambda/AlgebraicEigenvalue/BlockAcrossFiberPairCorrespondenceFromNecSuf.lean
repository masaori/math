import Ising2DLambda.AlgebraicEigenvalue.BlockAcrossFiberPairCorrespondence
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockAcrossFiberPairCorrespondence

namespace Ising2DLambda.AlgebraicEigenvalue

/-- The concrete fiber-pair correspondence is the specialization of the
    version that does not assume preservation of fibers. -/
theorem blockAcrossFiberPairInversions_card_eq_disagreements_from_necSuf
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})
    (k l : K) (hkl : k < l) :
    (blockAcrossFiberPairInversions block σ k l).card =
      (blockFiberPairDisagreements block σ k l).card := by
  classical
  exact NecSuf.AlgebraicEigenvalue.blockAcrossFiberPairInversions_card_eq_disagreements
    block σ.1 k l hkl

end Ising2DLambda.AlgebraicEigenvalue
