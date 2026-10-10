/-
多項式行列式のスカラー倍の具体版。
行指定の置換展開から、積の分離・定数の積・因子の移動・和の括り出しを九等号で辿る。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 本文の九等号を Polynomial Qbar 上で独立に辿る。
非空性は本文の対象に合わせた仮定であり、有限和・有限積の計算自体には使わない。 -/
theorem qbarPolynomial_det_smul
    {J : Type*} [Fintype J] [LinearOrder J] [Nonempty J]
    (c : Polynomial Qbar) (A : Matrix J J (Polynomial Qbar)) :
    Matrix.det (c • A) = c ^ Fintype.card J * Matrix.det A := by
  classical
  let w : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  calc
    Matrix.det (c • A) = ∑ σ : Equiv.Perm J, w σ * ∏ i : J, (c • A) i (σ i) :=
      qbarPolynomial_det_row_expansion (c • A)
    _ = ∑ σ : Equiv.Perm J, w σ * ∏ i : J, c * A i (σ i) := rfl
    _ = ∑ σ : Equiv.Perm J, w σ * ((∏ _i : J, c) * ∏ i : J, A i (σ i)) := by
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact congrArg (w σ * ·) Finset.prod_mul_distrib
    _ = ∑ σ : Equiv.Perm J, w σ * (c ^ Fintype.card J * ∏ i : J, A i (σ i)) := by
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact congrArg (fun z => w σ * (z * ∏ i : J, A i (σ i))) (Finset.prod_const c)
    _ = ∑ σ : Equiv.Perm J, (w σ * c ^ Fintype.card J) * ∏ i : J, A i (σ i) := by
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact (mul_assoc _ _ _).symm
    _ = ∑ σ : Equiv.Perm J, (c ^ Fintype.card J * w σ) * ∏ i : J, A i (σ i) := by
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact congrArg (· * ∏ i : J, A i (σ i)) (mul_comm (w σ) (c ^ Fintype.card J))
    _ = ∑ σ : Equiv.Perm J, c ^ Fintype.card J * (w σ * ∏ i : J, A i (σ i)) := by
      refine Finset.sum_congr rfl ?_
      intro σ _
      exact mul_assoc _ _ _
    _ = c ^ Fintype.card J * ∑ σ : Equiv.Perm J, w σ * ∏ i : J, A i (σ i) :=
      (Finset.mul_sum _ _ _).symm
    _ = c ^ Fintype.card J * Matrix.det A :=
      congrArg (c ^ Fintype.card J * ·) (qbarPolynomial_det_row_expansion A).symm

end Ising2DLambda.AlgebraicEigenvalue
