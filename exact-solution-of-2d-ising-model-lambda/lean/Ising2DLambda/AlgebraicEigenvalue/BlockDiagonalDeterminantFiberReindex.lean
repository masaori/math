import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingPermutationBijection

namespace Ising2DLambda.AlgebraicEigenvalue

/-- Reindex the surviving determinant terms by one permutation per fiber. -/
theorem blockDiagonal_det_eq_sum_fiber_permutation_families
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K) (B : Matrix J J (Polynomial Qbar))
    (hoff : ∀ i j, block i ≠ block j → B i j = 0) :
    Matrix.det B =
      ∑ parts : (∀ k : K, Equiv.Perm {j : J // block j = k}),
        Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign
          (fun i j : J => i < j)
          ((blockPreservingPermutationEquiv block).symm parts).1 : ℤ) : Qbar) *
          ∏ i : J, B i (((blockPreservingPermutationEquiv block).symm parts).1 i) := by
  classical
  rw [blockDiagonal_det_eq_sum_preserving block B hoff]
  let term : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
      ∏ i : J, B i (σ i)
  change (∑ σ ∈ blockPreservingPermutations block, term σ) = _
  calc
    (∑ σ ∈ blockPreservingPermutations block, term σ) =
        ∑ σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}, term σ.1 := by
      simpa only [blockPreservingPermutations, Finset.subtype_univ] using
        (Finset.sum_subtype_eq_sum_filter
          (s := (Finset.univ : Finset (Equiv.Perm J)))
          (p := fun σ => ∀ j, block (σ j) = block j) (f := term)).symm
    _ = ∑ parts : (∀ k : K, Equiv.Perm {j : J // block j = k}),
          term ((blockPreservingPermutationEquiv block).symm parts).1 := by
      exact Fintype.sum_equiv (blockPreservingPermutationEquiv block) _ _ (by
        intro σ
        simp)
    _ = _ := rfl

end Ising2DLambda.AlgebraicEigenvalue
