/-
有限積のスカラー倍の必要十分版へ、具体的な多項式・転倒数の符号・置換を供給する。
行指定の行列式への橋と成分定義でつなぎ、具体版のスカラー倍定理は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.WeightedProductScale

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 有理数体の代数閉包を係数とする多項式では、指定因子による左乗法は
零と加法を保つ。行列式の置換展開を除く計算は必要十分版から導く。 -/
theorem qbarPolynomial_det_smul_from_necSuf
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
    _ = c ^ Fintype.card J * ∑ σ : Equiv.Perm J, w σ * ∏ i : J, A i (σ i) :=
      NecSuf.AlgebraicEigenvalue.weightedProduct_scale_necSuf c w (fun σ i => A i (σ i))
        (mul_zero _) (fun u v => mul_add _ u v)
    _ = c ^ Fintype.card J * Matrix.det A :=
      congrArg (c ^ Fintype.card J * ·) (qbarPolynomial_det_row_expansion A).symm

end Ising2DLambda.AlgebraicEigenvalue
