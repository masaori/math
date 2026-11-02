/-
行列積の具体的な添字写像展開から、必要十分版の符号による表示を導く。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 順序は転倒数の符号の指定に、置換は列指定に用いる。
可換半環には Polynomial Qbar を取り、行列式の乗法性を使わない。 -/
theorem qbarPolynomial_det_mul_function_expansion_from_necSuf
    {J : Type*} [Fintype J] [LinearOrder J] [Nonempty J]
    (A B : Matrix J J (Polynomial Qbar)) :
    Matrix.det (A * B) = ∑ f : J → J, (∏ i : J, A i (f i)) *
      (∑ σ : Equiv.Perm J,
        Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
          ∏ i : J, B (f i) (σ i)) := by
  classical
  rw [qbarPolynomial_det_mul_function_expansion]
  apply Finset.sum_congr rfl
  intro f _
  apply congrArg ((∏ i : J, A i (f i)) * ·)
  apply Finset.sum_congr rfl
  intro σ _
  congr 1
  exact congrArg (fun z : ℤ => Polynomial.C (z : Qbar))
    ((qbarPermutationSign_eq_mathlibSign σ).trans
      (IntegerMatrix.inversionSign_eq_mathlibSign σ).symm)

end Ising2DLambda.AlgebraicEigenvalue
