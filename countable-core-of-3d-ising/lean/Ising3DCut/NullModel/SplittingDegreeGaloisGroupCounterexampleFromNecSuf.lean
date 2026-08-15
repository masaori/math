/-
具体版が必要十分版の特殊化として得られることの明示。

対象を有理係数の一次多項式 `X - 1` と `X - 2`、データ写像を定数係数、
分解の述語を ℚ 上の分解、次数を ℚ の ℚ 上の次数、Galois 群を
ℚ の ℚ 自己同型に取る。定数係数の相違だけを必要十分版へ渡す。

住処: ℚ、ℚ[X]、有限次元、ℚ 上の代数自己同型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.SplittingDegreeGaloisGroupCounterexample
import Ising3DCut.NecSuf.NullModel.SplittingDegreeGaloisGroupCounterexample

namespace Ising3DCut.NullModel

/-- 二つの一次多項式の定数係数は相異なる。 -/
lemma linearPolynomials_constantCoeff_ne :
    linearPolynomialA.coeff 0 ≠ linearPolynomialB.coeff 0 := by
  norm_num [linearPolynomialA, linearPolynomialB]

/-- `claim_splitting_degree_galois_group_do_not_determine_polynomial` の具体版を
必要十分版から導いたもの。 -/
theorem splittingDegree_galoisGroup_do_not_determine_polynomial_from_necSuf :
    linearPolynomialA ≠ linearPolynomialB ∧
    linearPolynomialA.Splits ∧
    linearPolynomialB.Splits ∧
    Module.finrank ℚ ℚ = 1 ∧
    Subsingleton (ℚ ≃ₐ[ℚ] ℚ) := by
  exact NecSuf.NullModel.splittingDegree_galoisGroup_do_not_determine_polynomial
    linearPolynomialA
    linearPolynomialB
    (fun polynomial ↦ polynomial.coeff 0)
    (fun polynomial ↦ polynomial.Splits)
    (Module.finrank ℚ ℚ)
    linearPolynomials_constantCoeff_ne
    linearPolynomials_split_over_rationals.1
    linearPolynomials_split_over_rationals.2
    rationalSplittingField_degree
    rationalGaloisGroup_subsingleton

end Ising3DCut.NullModel
