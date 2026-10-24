import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutation
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEntryProduct
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 後続写像の二場合で成分積を第一色と第二色へ分ける。 -/
theorem matchingPairEntryProduct (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar)) :
    (∏ i : J, A i (matchingPairPermutation τ υ i)) =
      (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ), A i (τ.val i)) *
        (∏ i ∈ Finset.univ.filter (· ∉ matchingPairColor τ υ), A i (υ.val i)) := by
  classical
  let C := matchingPairColor τ υ
  let f : J → Polynomial Qbar := fun i => A i (matchingPairPermutation τ υ i)
  calc
    (∏ i : J, f i) =
        (∏ i ∈ Finset.univ.filter (· ∈ C), f i) *
          (∏ i ∈ Finset.univ.filter (· ∉ C), f i) :=
      (Finset.prod_filter_mul_prod_filter_not Finset.univ (· ∈ C) f).symm
    _ = (∏ i ∈ Finset.univ.filter (· ∈ C), A i (τ.val i)) *
          (∏ i ∈ Finset.univ.filter (· ∉ C), A i (υ.val i)) := by
      congr 1
      · apply Finset.prod_congr rfl
        intro i hi
        have hC : i ∈ C := (Finset.mem_filter.mp hi).2
        change i ∈ matchingPairColor τ υ at hC
        simp [f, matchingPairPermutation, matchingPairSuccessor, hC]
      · apply Finset.prod_congr rfl
        intro i hi
        have hC : i ∉ C := (Finset.mem_filter.mp hi).2
        change i ∉ matchingPairColor τ υ at hC
        simp [f, matchingPairPermutation, matchingPairSuccessor, hC]

/-- 必要十分版を実際の二つの相手写像へ代入した等式。 -/
theorem matchingPairEntryProduct_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar)) :
    (∏ i : J, A i (matchingPairPermutation τ υ i)) =
      (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ), A i (τ.val i)) *
        (∏ i ∈ Finset.univ.filter (· ∉ matchingPairColor τ υ), A i (υ.val i)) := by
  classical
  apply NecSuf.AlgebraicEigenvalue.matchingPairEntryProduct_necSuf
    (matchingPairColor τ υ) (matchingPairPermutation τ υ) τ.val υ.val A
  intro i
  rfl

end Ising2DLambda.AlgebraicEigenvalue
