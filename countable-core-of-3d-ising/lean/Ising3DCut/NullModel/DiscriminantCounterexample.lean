/-
人手証明の主張「判別式だけでは多項式を決めない」
（ラベル `claim_discriminant_does_not_determine_polynomial`）の具体版。

人手証明とこのファイルの対応:

  A(X) = X^2 - X と B(X) = X^2 + X は相異なる   `quadraticPolynomials_ne`
  A と B を相異なる一次因子へ分解する             `quadraticPolynomials_factor`
  二次式の整数係数から判別式を計算する             `quadraticDiscriminants_eq_one`
  相異なる二式が同じ判別式を持つ                   `discriminant_does_not_determine_polynomial`

住処: ℤ、ℤ[X] のみ。ℝ / ℂ は現れない。
-/
import Mathlib

namespace Ising3DCut.NullModel

noncomputable def discriminantPolynomialA : Polynomial ℤ :=
  Polynomial.X ^ 2 - Polynomial.X

noncomputable def discriminantPolynomialB : Polynomial ℤ :=
  Polynomial.X ^ 2 + Polynomial.X

/-- 二次式 `aX² + bX + c` の係数から整数 `b² - 4ac` を作る。 -/
def quadraticDiscriminant (p : Polynomial ℤ) : ℤ :=
  p.coeff 1 ^ 2 - 4 * p.coeff 2 * p.coeff 0

/-- 一次係数が `-1` と `1` なので、二つの二次多項式は相異なる。 -/
lemma quadraticPolynomials_ne : discriminantPolynomialA ≠ discriminantPolynomialB := by
  intro h
  have hcoeff := congrArg (fun p : Polynomial ℤ => p.coeff 1) h
  norm_num [discriminantPolynomialA, discriminantPolynomialB] at hcoeff

/-- 二つの二次式は、それぞれ相異なる二つの一次因子へ分解する。 -/
lemma quadraticPolynomials_factor :
    discriminantPolynomialA = Polynomial.X * (Polynomial.X - Polynomial.C 1) ∧
    discriminantPolynomialB = Polynomial.X * (Polynomial.X + Polynomial.C 1) ∧
    Polynomial.X ≠ (Polynomial.X - Polynomial.C (1 : ℤ)) ∧
    Polynomial.X ≠ (Polynomial.X + Polynomial.C (1 : ℤ)) := by
  constructor
  · simp [discriminantPolynomialA, pow_two, mul_sub]
  constructor
  · simp [discriminantPolynomialB, pow_two, mul_add]
  constructor <;> intro h
  · have hcoeff := congrArg (fun p : Polynomial ℤ => p.coeff 0) h
    norm_num at hcoeff
  · have hcoeff := congrArg (fun p : Polynomial ℤ => p.coeff 0) h
    norm_num at hcoeff

/-- 係数公式 `b² - 4ac` により、両方の判別式は整数 `1` である。 -/
lemma quadraticDiscriminants_eq_one :
    quadraticDiscriminant discriminantPolynomialA = 1 ∧
    quadraticDiscriminant discriminantPolynomialB = 1 := by
  norm_num [quadraticDiscriminant, discriminantPolynomialA, discriminantPolynomialB]

/-- `claim_discriminant_does_not_determine_polynomial` の具体版。 -/
theorem discriminant_does_not_determine_polynomial :
    discriminantPolynomialA ≠ discriminantPolynomialB ∧
    quadraticDiscriminant discriminantPolynomialA =
      quadraticDiscriminant discriminantPolynomialB := by
  exact ⟨quadraticPolynomials_ne,
    quadraticDiscriminants_eq_one.1.trans quadraticDiscriminants_eq_one.2.symm⟩

end Ising3DCut.NullModel
