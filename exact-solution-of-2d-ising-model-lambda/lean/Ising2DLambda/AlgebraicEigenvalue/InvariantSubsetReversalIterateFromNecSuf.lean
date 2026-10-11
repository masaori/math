import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalIterate
import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PiecewiseIteration

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 実際の部分集合・置換・反転写像で、枝の保存と一歩の一致を供給する。 -/
theorem invariantSubsetReversal_iterate_from_necSuf
    {J : Type*} [Fintype J] [DecidableEq J]
    (C : Finset J) (σ : Equiv.Perm J) (h : ∀ i : J, σ i ∈ C ↔ i ∈ C)
    (n : ℕ) (i : J) :
    (i ∈ C → finiteMapIterate (invariantSubsetReversal C σ h) n i =
      finiteMapIterate σ.symm n i) ∧
    (i ∉ C → finiteMapIterate (invariantSubsetReversal C σ h) n i =
      finiteMapIterate σ n i) := by
  exact NecSuf.AlgebraicEigenvalue.piecewise_iterate_necSuf
    (fun j : J => j ∈ C) σ σ.symm (invariantSubsetReversal C σ h)
    (fun j hj => (inverse_mem_invariantSubset_iff_from_necSuf C σ h j).mpr hj)
    (fun j hj hmem => hj ((h j).mp hmem))
    (fun _ hj => if_pos hj) (fun _ hj => if_neg hj) n i

end Ising2DLambda.AlgebraicEigenvalue
