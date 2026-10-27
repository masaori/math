import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingPermutationBijection

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- Reindex a finite product by the fibers and then split the sigma product. -/
theorem blockGluing_entryProduct_fiberProduct
    {J K R : Type*} [Fintype J] [Fintype K] [DecidableEq J] [DecidableEq K]
    [CommMonoid R] (block : J → K) (entry : J → J → R)
    (parts : ∀ k : K, Equiv.Perm {j : J // block j = k}) :
    (∏ i : J, entry i ((blockGluing block parts).1 i)) =
      ∏ k : K, ∏ i : {j : J // block j = k}, entry i.1 ((parts k i).1) := by
  classical
  calc
    (∏ i : J, entry i ((blockGluing block parts).1 i)) =
        ∏ p : Σ k : K, {j : J // block j = k},
          entry p.2.1 ((parts p.1 p.2).1) := by
      exact Fintype.prod_equiv (Equiv.sigmaFiberEquiv block).symm _ _ (by
        intro i
        rfl)
    _ = ∏ k : K, ∏ i : {j : J // block j = k}, entry i.1 ((parts k i).1) := by
      exact Fintype.prod_sigma (fun p : Σ k : K, {j : J // block j = k} =>
        entry p.2.1 ((parts p.1 p.2).1))

/-- Only multiplicativity and the fiber product decomposition are needed for a term. -/
theorem blockGluing_weightedTerm_fiberProduct
    {J K R : Type*} [Fintype J] [Fintype K] [DecidableEq J] [DecidableEq K]
    [CommMonoid R] (block : J → K) (entry : J → J → R)
    (parts : ∀ k : K, Equiv.Perm {j : J // block j = k})
    (wholeSign : R) (fiberSign : K → R)
    (hsign : wholeSign = ∏ k : K, fiberSign k) :
    wholeSign * (∏ i : J, entry i ((blockGluing block parts).1 i)) =
      ∏ k : K, fiberSign k *
        (∏ i : {j : J // block j = k}, entry i.1 ((parts k i).1)) := by
  calc
    wholeSign * (∏ i : J, entry i ((blockGluing block parts).1 i)) =
        (∏ k : K, fiberSign k) *
          (∏ i : J, entry i ((blockGluing block parts).1 i)) := by rw [hsign]
    _ = (∏ k : K, fiberSign k) *
          (∏ k : K, ∏ i : {j : J // block j = k},
            entry i.1 ((parts k i).1)) := by
      rw [blockGluing_entryProduct_fiberProduct]
    _ = ∏ k : K, fiberSign k *
          (∏ i : {j : J // block j = k}, entry i.1 ((parts k i).1)) := by
      rw [Finset.prod_mul_distrib]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
