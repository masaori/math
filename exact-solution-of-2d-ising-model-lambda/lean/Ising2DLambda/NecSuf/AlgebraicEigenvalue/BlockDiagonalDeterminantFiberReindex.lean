import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingPermutationBijection

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- A fiber restriction bijection reindexes an arbitrary finite weighted sum. -/
theorem blockPreserving_weightedSum_reindex
    {J K R : Type*} [Fintype J] [Fintype K] [DecidableEq J] [DecidableEq K]
    [AddCommMonoid R] (block : J → K) (weight : Equiv.Perm J → R) :
    (∑ σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}, weight σ.1) =
      ∑ parts : (∀ k : K, Equiv.Perm {j : J // block j = k}),
        weight ((blockPreservingPermutationEquiv block).symm parts).1 := by
  classical
  exact Fintype.sum_equiv (blockPreservingPermutationEquiv block) _ _ (by
    intro σ
    simp)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
