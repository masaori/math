import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationMinimalPeriod
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.FiniteInjectiveMinimalPeriod

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 有限な単射自己写像の帰還を、本文の置換へ特殊化する。 -/
theorem finitePermutation_positive_return_from_necSuf {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (i : J) :
    ∃ n : ℕ, 0 < n ∧ finiteMapIterate σ n i = i :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.finiteInjective_positive_return σ σ.injective i

/-- 二つの定義は同じ自然数の述語に Nat.find を使う。存在証明の違いは proof irrelevance による。 -/
theorem finitePermutationMinimalPeriod_spec_from_necSuf {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (i : J) :
    0 < finitePermutationMinimalPeriod σ i ∧
    finiteMapIterate σ (finitePermutationMinimalPeriod σ i) i = i ∧
    ∀ n : ℕ, 0 < n → finiteMapIterate σ n i = i →
      finitePermutationMinimalPeriod σ i ≤ n := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.finiteInjectiveMinimalPeriod_spec
    σ σ.injective i

end Ising2DLambda.AlgebraicEigenvalue
