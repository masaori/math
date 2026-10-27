import Ising2DLambda.AlgebraicEigenvalue.BlockDiagonalDeterminantFiberReindex
import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockDiagonalTermFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

/-- Each reindexed determinant term splits into the determinant terms of its fibers. -/
theorem blockDiagonal_term_eq_prod_fiber_terms
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K) (B : Matrix J J (Polynomial Qbar))
    (parts : ∀ k : K, Equiv.Perm {j : J // block j = k}) :
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign
      (fun i j : J => i < j)
      ((blockPreservingPermutationEquiv block).symm parts).1 : ℤ) : Qbar) *
      ∏ i : J, B i (((blockPreservingPermutationEquiv block).symm parts).1 i) =
    ∏ k : K,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign
        (fun i j : {v : J // block v = k} => i < j) (parts k) : ℤ) : Qbar) *
      ∏ i : {v : J // block v = k}, B i.1 ((parts k i).1) := by
  classical
  let σ := (blockPreservingPermutationEquiv block).symm parts
  have hsign : NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ.1 =
      ∏ k : K, NecSuf.AlgebraicEigenvalue.sign
        (fun i j : {v : J // block v = k} => i < j) (parts k) := by
    calc
      NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ.1 =
          blockPermutationSign block σ := by rfl
      _ = ∏ k : K, fiberPermutationSign block σ k :=
        blockPreserving_sign_eq_prod block σ
      _ = ∏ k : K, NecSuf.AlgebraicEigenvalue.sign
          (fun i j : {v : J // block v = k} => i < j) (parts k) := by
        apply Finset.prod_congr rfl
        intro k _
        have hk : blockRestriction block σ k = parts k := by
          exact blockRestriction_blockGluing block parts k
        simp only [fiberPermutationSign, fiberInversionPairs,
          NecSuf.AlgebraicEigenvalue.sign, NecSuf.AlgebraicEigenvalue.inversionCount,
          NecSuf.AlgebraicEigenvalue.orderedPairs]
        rw [hk]
        congr 1
        congr 1
        ext p
        simp
  have hentry : (∏ i : J, B i (σ.1 i)) =
      ∏ k : K, ∏ i : {j : J // block j = k}, B i.1 ((parts k i).1) := by
    calc
      (∏ i : J, B i (σ.1 i)) =
          ∏ p : Σ k : K, {j : J // block j = k},
            B p.2.1 ((parts p.1 p.2).1) := by
        exact Fintype.prod_equiv (Equiv.sigmaFiberEquiv block).symm _ _ (by
          intro i
          rfl)
      _ = ∏ k : K, ∏ i : {j : J // block j = k},
            B i.1 ((parts k i).1) := by
        exact Fintype.prod_sigma (fun p : Σ k : K, {j : J // block j = k} =>
          B p.2.1 ((parts p.1 p.2).1))
  calc
    _ = Polynomial.C ((∏ k : K, NecSuf.AlgebraicEigenvalue.sign
          (fun i j : {v : J // block v = k} => i < j) (parts k) : ℤ) : Qbar) *
        ∏ k : K, ∏ i : {v : J // block v = k}, B i.1 ((parts k i).1) := by
      change Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign
          (fun i j : J => i < j) σ.1 : ℤ) : Qbar) *
        (∏ i : J, B i (σ.1 i)) = _
      rw [hsign]
      exact congrArg (fun p : Polynomial Qbar =>
        Polynomial.C ((∏ k : K, NecSuf.AlgebraicEigenvalue.sign
          (fun i j : {v : J // block v = k} => i < j) (parts k) : ℤ) : Qbar) * p)
          hentry
    _ = _ := by simp [map_prod, Finset.prod_mul_distrib]

end Ising2DLambda.AlgebraicEigenvalue
