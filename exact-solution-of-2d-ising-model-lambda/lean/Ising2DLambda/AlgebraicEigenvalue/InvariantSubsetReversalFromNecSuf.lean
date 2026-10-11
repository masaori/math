/-
述語の反転へ実際の有限集合 C の所属述語と具体的な置換を供給する。
具体版の証明は呼ばず、写像・置換の定義が一致することだけを使う。
-/
import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversal
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversal

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [DecidableEq J]

omit [Fintype J] [DecidableEq J] in
theorem inverse_mem_invariantSubset_iff_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    σ.symm i ∈ C ↔ i ∈ C := by
  exact NecSuf.AlgebraicEigenvalue.inverse_invariantPredicate_iff
    (fun j : J => j ∈ C) σ h i

theorem invariantSubsetBackward_forward_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    invariantSubsetBackward C σ (invariantSubsetForward C σ i) = i := by
  exact NecSuf.AlgebraicEigenvalue.invariantPredicateBackward_forward
    (fun j : J => j ∈ C) σ h i

theorem invariantSubsetForward_backward_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    invariantSubsetForward C σ (invariantSubsetBackward C σ i) = i := by
  exact NecSuf.AlgebraicEigenvalue.invariantPredicateForward_backward
    (fun j : J => j ∈ C) σ h i

theorem invariantSubsetReversal_mem_iff_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    invariantSubsetReversal C σ h i ∈ C ↔ i ∈ C := by
  exact NecSuf.AlgebraicEigenvalue.invariantPredicateReversal_mem_iff
    (fun j : J => j ∈ C) σ h i

theorem invariantSubsetReversal_twice_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) :
    invariantSubsetReversal C (invariantSubsetReversal C σ h)
      (invariantSubsetReversal_mem_iff_from_necSuf C σ h) = σ := by
  exact NecSuf.AlgebraicEigenvalue.invariantPredicateReversal_twice
    (fun j : J => j ∈ C) σ h

end Ising2DLambda.AlgebraicEigenvalue
