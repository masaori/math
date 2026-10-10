/-
行列積の有限和の展開へ、具体的な多項式・転倒数の符号・置換を供給する。
具体版の行列式展開定理は使わず、行指定の定義橋と必要十分版で導く。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatrixProductFunctionExpansion

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
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  calc
    Matrix.det (A * B) = ∑ σ : Equiv.Perm J, c σ * ∏ i : J, (A * B) i (σ i) :=
      qbarPolynomial_det_row_expansion (A * B)
    _ = ∑ f : J → J, (∏ i : J, A i (f i)) *
        (∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (f i) (σ i)) :=
      NecSuf.AlgebraicEigenvalue.matrixProduct_functionExpansion_necSuf A B c
        (fun σ i => σ i)

end Ising2DLambda.AlgebraicEigenvalue
