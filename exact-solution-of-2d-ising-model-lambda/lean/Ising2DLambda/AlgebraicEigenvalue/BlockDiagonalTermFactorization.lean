import Ising2DLambda.AlgebraicEigenvalue.BlockDiagonalDeterminantFiberReindex
import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingSign
import Ising2DLambda.IntegerMatrix.Determinant

namespace Ising2DLambda.AlgebraicEigenvalue

/-- Each reindexed determinant term splits into the determinant terms of its fibers. -/
theorem blockDiagonal_term_eq_prod_fiber_terms
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K) (B : Matrix J J (Polynomial Qbar))
    (parts : ∀ k : K, Equiv.Perm {j : J // block j = k}) :
    Polynomial.C (((Equiv.Perm.sign
      ((blockPreservingPermutationEquiv block).symm parts).1 : ℤ) : Qbar)) *
      ∏ i : J, B i (((blockPreservingPermutationEquiv block).symm parts).1 i) =
    ∏ k : K,
      Polynomial.C (((Equiv.Perm.sign (parts k) : ℤ) : Qbar)) *
      ∏ i : {v : J // block v = k}, B i.1 ((parts k i).1) := by
  classical
  let σ := (blockPreservingPermutationEquiv block).symm parts
  have hsign : (Equiv.Perm.sign σ.1 : ℤ) =
      ∏ k : K, (Equiv.Perm.sign (parts k) : ℤ) := by
    calc
      (Equiv.Perm.sign σ.1 : ℤ) = blockPermutationSign block σ := by
        rw [← IntegerMatrix.inversionSign_eq_mathlibSign]
        rfl
      _ = ∏ k : K, fiberPermutationSign block σ k :=
        blockPreserving_sign_eq_prod block σ
      _ = ∏ k : K, (Equiv.Perm.sign (parts k) : ℤ) := by
        apply Finset.prod_congr rfl
        intro k _
        have hk : blockRestriction block σ k = parts k := by
          exact blockRestriction_blockGluing block parts k
        calc
          fiberPermutationSign block σ k =
              qbarPermutationSign (blockRestriction block σ k) := by
                simp only [fiberPermutationSign, fiberInversionPairs,
                  qbarPermutationSign]
          _ = qbarPermutationSign (parts k) := by rw [hk]
          _ = (Equiv.Perm.sign (parts k) : ℤ) :=
                qbarPermutationSign_eq_mathlibSign (parts k)
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
    _ = Polynomial.C (((∏ k : K, (Equiv.Perm.sign (parts k) : ℤ) : ℤ) : Qbar)) *
        ∏ k : K, ∏ i : {v : J // block v = k}, B i.1 ((parts k i).1) := by
      change Polynomial.C (((Equiv.Perm.sign σ.1 : ℤ) : Qbar)) *
        (∏ i : J, B i (σ.1 i)) = _
      rw [hsign]
      exact congrArg (fun p : Polynomial Qbar =>
        Polynomial.C (((∏ k : K, (Equiv.Perm.sign (parts k) : ℤ) : ℤ) : Qbar)) * p)
          hentry
    _ = _ := by simp [map_prod, Finset.prod_mul_distrib]

end Ising2DLambda.AlgebraicEigenvalue
