/-
具体版が必要十分版の特殊化として得られることの明示。

対象を二つの整係数二次式、観測を一次係数、分解述語を具体版で示した
相異なる一次因子への分解、判別式データを係数公式 `b² - 4ac` に取る。
-/
import Ising3DCut.NullModel.DiscriminantCounterexample
import Ising3DCut.NecSuf.NullModel.DiscriminantCounterexample

namespace Ising3DCut.NullModel

/-- 二つの二次式の一次係数は相異なる。 -/
lemma quadraticPolynomials_linearCoeff_ne :
    discriminantPolynomialA.coeff 1 ≠ discriminantPolynomialB.coeff 1 := by
  norm_num [discriminantPolynomialA, discriminantPolynomialB]

/-- 相異なる一次因子への分解を表す述語。 -/
def factorsIntoDistinctLinearParts (p : Polynomial ℤ) : Prop :=
  (p = Polynomial.X * (Polynomial.X - Polynomial.C 1) ∧
    Polynomial.X ≠ (Polynomial.X - Polynomial.C (1 : ℤ))) ∨
  (p = Polynomial.X * (Polynomial.X + Polynomial.C 1) ∧
    Polynomial.X ≠ (Polynomial.X + Polynomial.C (1 : ℤ)))

/-- `claim_discriminant_does_not_determine_polynomial` を必要十分版から導く。 -/
theorem discriminant_does_not_determine_polynomial_from_necSuf :
    discriminantPolynomialA ≠ discriminantPolynomialB ∧
      factorsIntoDistinctLinearParts discriminantPolynomialA ∧
      factorsIntoDistinctLinearParts discriminantPolynomialB ∧
      quadraticDiscriminant discriminantPolynomialA =
        quadraticDiscriminant discriminantPolynomialB := by
  apply NecSuf.NullModel.discriminant_does_not_determine_object
    discriminantPolynomialA
    discriminantPolynomialB
    (fun polynomial ↦ polynomial.coeff 1)
    factorsIntoDistinctLinearParts
    quadraticDiscriminant
    quadraticPolynomials_linearCoeff_ne
  · exact Or.inl ⟨quadraticPolynomials_factor.1, quadraticPolynomials_factor.2.2.1⟩
  · exact Or.inr ⟨quadraticPolynomials_factor.2.1, quadraticPolynomials_factor.2.2.2⟩
  · exact quadraticDiscriminants_eq_one.1.trans quadraticDiscriminants_eq_one.2.symm

end Ising3DCut.NullModel
