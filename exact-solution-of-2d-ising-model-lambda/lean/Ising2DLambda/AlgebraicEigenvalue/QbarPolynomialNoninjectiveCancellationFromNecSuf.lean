import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialNoninjectiveCancellation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.NoninjectivePermutationSum

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 非単射性の衝突対と具体的な符号係数を、負号の移送則とともに抽象的な置換和へ供給する。 -/
theorem qbarPolynomial_noninjective_inner_sum_zero_from_necSuf
    {J : Type*} [Fintype J] [LinearOrder J]
    (B : Matrix J J (Polynomial Qbar)) (f : J → J) (h : ¬Function.Injective f) :
    (∑ σ : Equiv.Perm J,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, B (f i) (σ i)) = 0 := by
  classical
  obtain ⟨a, b, hf, hab⟩ := Function.not_injective_iff.mp h
  exact NecSuf.AlgebraicEigenvalue.permutation_row_sum_collision_zero_necSuf
    (fun r s => neg_mul r s) B f a b hab hf
    (fun σ => Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign
      (fun i j : J => i < j) σ : ℤ) : Qbar))
    (qbarPolynomial_sign_right_transposition_neg a b hab)

end Ising2DLambda.AlgebraicEigenvalue
