/-
重み付き有限積の和の制限へ、実際の多項式行列・置換・固定点を供給する。
具体版の消去定理は呼ばず、不動点なしの置換集合の定義だけを共有する。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFixedPoints
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.WeightedProductFilterZero

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 具体版の転倒数による符号を必要十分版の符号へ移す。 -/
theorem qbarPolynomial_fixedPointFree_sum_sign_from_necSuf
    {J : Type*} [Fintype J] [LinearOrder J]
    (A : Matrix J J (Polynomial Qbar)) :
    (∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((qbarPermutationSign σ : ℤ) : Qbar) * ∏ i : J, A i (σ i)) =
    ∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i) := by
  classical
  apply Finset.sum_congr rfl
  intro σ _
  exact congrArg (fun z : ℤ => Polynomial.C (z : Qbar) * ∏ i : J, A i (σ i))
    ((qbarPermutationSign_eq_mathlibSign σ).trans
      (IntegerMatrix.inversionSign_eq_mathlibSign σ).symm)

theorem qbarPolynomial_det_eq_sum_fixedPointFree_from_necSuf
    {J : Type*} [Fintype J] [LinearOrder J]
    (A : Matrix J J (Polynomial Qbar)) (hdiag : ∀ i : J, A i i = 0) :
    Matrix.det A = ∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i) := by
  classical
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  have hZeroFactor : ∀ σ ∈ (univ : Finset (Equiv.Perm J)),
      ¬ (∀ i : J, σ i ≠ i) → ∃ j ∈ (univ : Finset J), A j (σ j) = 0 := by
    intro σ _ hNotAll
    obtain ⟨j, hj⟩ := not_forall.mp hNotAll
    have hfixed : σ j = j := not_not.mp hj
    refine ⟨j, mem_univ j, ?_⟩
    calc
      A j (σ j) = A j j := congrArg (A j) hfixed
      _ = 0 := hdiag j
  calc
    Matrix.det A = ∑ σ : Equiv.Perm J, c σ * ∏ i : J, A i (σ i) :=
      qbarPolynomial_det_row_expansion_from_necSuf A
    _ = ∑ σ ∈ fixedPointFreePermutations J, c σ * ∏ i : J, A i (σ i) := by
      simpa only [fixedPointFreePermutations] using
        NecSuf.AlgebraicEigenvalue.weightedProduct_filter_zero_necSuf univ univ c
        (fun σ i => A i (σ i)) (fun σ => ∀ i : J, σ i ≠ i)
        (fun r => zero_mul r) hZeroFactor

end Ising2DLambda.AlgebraicEigenvalue
