/-
人手証明の主張「分解体の次数と Galois 群だけでは多項式を決めない」
（ラベル `claim_splitting_degree_galois_group_do_not_determine_polynomial`）の具体版。

人手証明とこのファイルの対応:

  A(X) = X - 1 と B(X) = X - 2 は相異なる    `linearPolynomials_ne`
  A の根は 1、B の根は 2                     `linearPolynomials_roots`
  どちらも ℚ 上で分解する                     `linearPolynomials_split_over_rationals`
  分解体としての ℚ の次数は 1                 `rationalSplittingField_degree`
  ℚ の ℚ 自己同型は恒等写像だけ               `rationalGaloisGroup_subsingleton`
  二つのデータだけでは多項式を決めない         `splittingDegree_galoisGroup_do_not_determine_polynomial`

住処: ℚ、ℚ[X]、有限次元、ℚ 上の代数自己同型のみ。ℝ / ℂ は現れない。
-/
import Mathlib

namespace Ising3DCut.NullModel

noncomputable def linearPolynomialA : Polynomial ℚ :=
  Polynomial.X - Polynomial.C 1

noncomputable def linearPolynomialB : Polynomial ℚ :=
  Polynomial.X - Polynomial.C 2

/-- 定数係数が異なるので、二つの一次多項式は相異なる。 -/
lemma linearPolynomials_ne : linearPolynomialA ≠ linearPolynomialB := by
  intro h
  have hcoeff := congrArg (fun p : Polynomial ℚ => p.coeff 0) h
  norm_num [linearPolynomialA, linearPolynomialB] at hcoeff

/-- 二つの一次多項式の根は、それぞれ有理数 1 と 2 である。 -/
lemma linearPolynomials_roots :
    linearPolynomialA.eval 1 = 0 ∧ linearPolynomialB.eval 2 = 0 := by
  norm_num [linearPolynomialA, linearPolynomialB]

/-- 二つの多項式は、どちらも ℚ 上で既に一次式へ分解する。 -/
lemma linearPolynomials_split_over_rationals :
    linearPolynomialA.Splits ∧ linearPolynomialB.Splits := by
  constructor
  · simpa [linearPolynomialA, sub_eq_add_neg] using
      Polynomial.Splits.X_add_C (-1 : ℚ)
  · simpa [linearPolynomialB, sub_eq_add_neg] using
      Polynomial.Splits.X_add_C (-2 : ℚ)

/-- 分解体として用いる ℚ 自身の ℚ 上の次数は 1 である。 -/
lemma rationalSplittingField_degree : Module.finrank ℚ ℚ = 1 := by
  exact Module.finrank_self ℚ

/-- ℚ を各点で固定する ℚ 自己同型は恒等写像だけである。 -/
lemma rationalGaloisGroup_subsingleton : Subsingleton (ℚ ≃ₐ[ℚ] ℚ) := by
  constructor
  intro σ τ
  ext q
  exact (σ.commutes q).trans (τ.commutes q).symm

/-- `claim_splitting_degree_galois_group_do_not_determine_polynomial` の具体版。 -/
theorem splittingDegree_galoisGroup_do_not_determine_polynomial :
    linearPolynomialA ≠ linearPolynomialB ∧
    linearPolynomialA.Splits ∧
    linearPolynomialB.Splits ∧
    Module.finrank ℚ ℚ = 1 ∧
    Subsingleton (ℚ ≃ₐ[ℚ] ℚ) := by
  exact ⟨linearPolynomials_ne,
    linearPolynomials_split_over_rationals.1,
    linearPolynomials_split_over_rationals.2,
    rationalSplittingField_degree,
    rationalGaloisGroup_subsingleton⟩

end Ising3DCut.NullModel
