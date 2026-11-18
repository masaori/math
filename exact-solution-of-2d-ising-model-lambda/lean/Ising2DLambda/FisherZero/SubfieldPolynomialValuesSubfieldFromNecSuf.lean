/- 必要十分版を Qbar の部分体と `deg_F(y)` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SubfieldPolynomialValuesSubfield
import Ising2DLambda.FisherZero.MinimalVanishingPolynomialDividesFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.SubfieldPolynomialValuesSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の値の全体は、必要十分版の値の全体を `F` へ特殊化したものに等しい。 -/
theorem subfieldPolynomialValues_eq_necSuf (F : Subfield Qbar) (α : Qbar) :
    subfieldPolynomialValues F α =
      Ising2DLambda.NecSuf.FisherZero.polynomialValuesNecSuf (F : Set Qbar) α := by
  ext y
  constructor
  · rintro ⟨g, hg, hgy⟩
    exact ⟨g, hg, by rw [← qbarPolyEval_eq_eval]; exact hgy⟩
  · rintro ⟨g, hg, hgy⟩
    exact ⟨g, hg, by rw [qbarPolyEval_eq_eval]; exact hgy⟩

/-- `claim_qbar_poly_constant_term_shift_decomposition` を必要十分版から得る。 -/
theorem qbarPolyConstantTermShift_from_necSuf (p : QbarPoly) :
    ∃ p' : QbarPoly, (∀ k : ℕ, p'.coeff k = p.coeff (k + 1)) ∧
      p = qbarConst (p.coeff 0) + Polynomial.X * p' :=
  Ising2DLambda.NecSuf.FisherZero.constantTermShift_necSuf p

/-- `claim_subfield_coefficient_polynomials_ring_closed`（積）を必要十分版から得る。 -/
theorem subfieldCoefficientPolynomials_mul_mem_from_necSuf (F : Subfield Qbar) (f g : QbarPoly)
    (hf : f ∈ subfieldCoefficientPolynomials F) (hg : g ∈ subfieldCoefficientPolynomials F) :
    f * g ∈ subfieldCoefficientPolynomials F :=
  Ising2DLambda.NecSuf.FisherZero.coefficientPolynomials_mul_mem_necSuf (F : Set Qbar) F.zero_mem
    (fun _ _ ha hb => F.add_mem ha hb) (fun _ _ ha hb => F.mul_mem ha hb) f g hf hg

/-- `claim_subfield_polynomial_values_contains_subfield` を必要十分版から得る。 -/
theorem subfield_subset_subfieldPolynomialValues_from_necSuf (F : Subfield Qbar) (α c : Qbar)
    (hc : c ∈ F) : c ∈ subfieldPolynomialValues F α := by
  rw [subfieldPolynomialValues_eq_necSuf]
  exact Ising2DLambda.NecSuf.FisherZero.subset_polynomialValues_necSuf (F : Set Qbar) F.zero_mem α c hc

/-- `claim_subfield_polynomial_values_contains_element` を必要十分版から得る。 -/
theorem element_mem_subfieldPolynomialValues_from_necSuf (F : Subfield Qbar) (α : Qbar) :
    α ∈ subfieldPolynomialValues F α := by
  rw [subfieldPolynomialValues_eq_necSuf]
  exact Ising2DLambda.NecSuf.FisherZero.element_mem_polynomialValues_necSuf (F : Set Qbar) F.zero_mem
    F.one_mem α

/-- `claim_subfield_polynomial_values_ring_closed`（積）を必要十分版から得る。 -/
theorem subfieldPolynomialValues_mul_mem_from_necSuf (F : Subfield Qbar) (α y z : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) (hz : z ∈ subfieldPolynomialValues F α) :
    y * z ∈ subfieldPolynomialValues F α := by
  rw [subfieldPolynomialValues_eq_necSuf] at hy hz ⊢
  exact Ising2DLambda.NecSuf.FisherZero.polynomialValues_mul_mem_necSuf (F : Set Qbar) F.zero_mem
    (fun _ _ ha hb => F.add_mem ha hb) (fun _ _ ha hb => F.mul_mem ha hb) α y z hy hz

/-- `claim_subfield_polynomial_values_evaluation_closed` を必要十分版から得る。 -/
theorem subfieldPolynomialValues_eval_mem_from_necSuf (F : Subfield Qbar) (α y : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) (h : QbarPoly)
    (hh : h ∈ subfieldCoefficientPolynomials F) :
    qbarPolyEval y h ∈ subfieldPolynomialValues F α := by
  rw [subfieldPolynomialValues_eq_necSuf] at hy ⊢
  rw [qbarPolyEval_eq_eval]
  exact Ising2DLambda.NecSuf.FisherZero.polynomialValues_eval_mem_necSuf (F : Set Qbar) F.zero_mem
    F.one_mem (fun _ _ ha hb => F.add_mem ha hb) (fun _ _ ha hb => F.mul_mem ha hb) α y hy h hh

/-- `claim_minimal_vanishing_polynomial_constant_term_nonzero` を必要十分版から得る。 -/
theorem minimalVanishingPolynomial_constantTerm_ne_zero_from_necSuf (F : Subfield Qbar) (y : Qbar)
    (hy0 : y ≠ 0) (p : QbarPoly) (hp : p ∈ subfieldCoefficientPolynomials F) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, degreeOverSubfield F y < k → p.coeff k = 0) (hpy : qbarPolyEval y p = 0) :
    p.coeff 0 ≠ 0 :=
  Ising2DLambda.NecSuf.FisherZero.minimalVanishingPolynomial_constantTerm_ne_zero_necSuf
    (F : Set Qbar) y hy0 (degreeOverSubfield F y) (degreeOverSubfield_hmin F y) p hp hp0 htop
    (by rw [← qbarPolyEval_eq_eval]; exact hpy)

/-- `claim_subfield_polynomial_values_is_subfield`（零でない元の逆元）を必要十分版から得る。 -/
theorem subfieldPolynomialValues_inv_mem_from_necSuf (F : Subfield Qbar) (α y : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) (hy0 : y ≠ 0) :
    y⁻¹ ∈ subfieldPolynomialValues F α := by
  obtain ⟨p, hp, hp0, htop, hpy⟩ := degreeOverSubfield_spec F y
  rw [subfieldPolynomialValues_eq_necSuf] at hy ⊢
  exact Ising2DLambda.NecSuf.FisherZero.polynomialValues_inv_mem_necSuf (F : Set Qbar) F.zero_mem
    F.one_mem (fun _ _ ha hb => F.add_mem ha hb) (fun _ _ ha hb => F.mul_mem ha hb)
    (fun _ ha => F.neg_mem ha) (fun _ ha => F.inv_mem ha) α y hy hy0 (degreeOverSubfield F y)
    (degreeOverSubfield_hmin F y) p hp hp0 htop (by rw [← qbarPolyEval_eq_eval]; exact hpy)

end Ising2DLambda.FisherZero
