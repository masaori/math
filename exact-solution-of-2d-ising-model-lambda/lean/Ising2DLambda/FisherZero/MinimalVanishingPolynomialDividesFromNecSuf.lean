/- 必要十分版を Qbar の部分体と `deg_F(α)` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.MinimalVanishingPolynomialDivides
import Ising2DLambda.NecSuf.FisherZero.MinimalVanishingPolynomialDivides

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `deg_F(α)` は必要十分版の最小性の仮定 `hmin` を満たす（`degreeOverSubfield_le`）。 -/
theorem degreeOverSubfield_hmin (F : Subfield Qbar) (α : Qbar) :
    ∀ (d : ℕ) (q : QbarPoly), (∀ k : ℕ, q.coeff k ∈ F) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval α = 0 → degreeOverSubfield F α ≤ d :=
  fun d q hq hq0 hbound hqα =>
    degreeOverSubfield_le F α d q hq hq0 hbound (by rw [qbarPolyEval_eq_eval]; exact hqα)

/-- `claim_vanishing_polynomial_below_degree_is_zero` を必要十分版から得る。 -/
theorem vanishingPolynomial_below_degree_eq_zero_from_necSuf (F : Subfield Qbar) (α : Qbar)
    (q : QbarPoly) (hq : q ∈ subfieldCoefficientPolynomials F) (hqα : qbarPolyEval α q = 0)
    (hz : ∀ k : ℕ, degreeOverSubfield F α ≤ k → q.coeff k = 0) : q = 0 :=
  Ising2DLambda.NecSuf.FisherZero.vanishingPolynomial_below_degree_eq_zero_necSuf (F : Set Qbar) α
    (degreeOverSubfield F α) (degreeOverSubfield_hmin F α) q hq
    (by rw [← qbarPolyEval_eq_eval]; exact hqα) hz

/-- `claim_minimal_vanishing_polynomial_divides` を必要十分版から得る。 -/
theorem minimalVanishingPolynomial_dvd_from_necSuf (F : Subfield Qbar) (α : Qbar) (p : QbarPoly)
    (hp : p ∈ subfieldCoefficientPolynomials F) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, degreeOverSubfield F α < k → p.coeff k = 0) (hpα : qbarPolyEval α p = 0)
    (f : QbarPoly) (hf : f ∈ subfieldCoefficientPolynomials F) (hfα : qbarPolyEval α f = 0) :
    ∃ u : QbarPoly, u ∈ subfieldCoefficientPolynomials F ∧ f = u * p :=
  Ising2DLambda.NecSuf.FisherZero.minimalVanishingPolynomial_dvd_necSuf (F : Set Qbar) F.zero_mem
    (fun _ _ ha hb => F.add_mem ha hb) (fun _ _ ha hb => F.sub_mem ha hb)
    (fun _ _ ha hb => F.mul_mem ha hb) (fun _ _ ha hb => F.div_mem ha hb) α
    (degreeOverSubfield F α) (degreeOverSubfield_hmin F α) p hp hp0 htop
    (by rw [← qbarPolyEval_eq_eval]; exact hpα) f hf (by rw [← qbarPolyEval_eq_eval]; exact hfα)

/-- `claim_subfield_polynomial_values_reduced_representation` を必要十分版から得る。 -/
theorem subfieldPolynomialValues_reduced_from_necSuf (F : Subfield Qbar) (α y : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) :
    ∃ g : QbarPoly, g ∈ subfieldCoefficientPolynomials F ∧
      (∀ k : ℕ, degreeOverSubfield F α ≤ k → g.coeff k = 0) ∧ qbarPolyEval α g = y := by
  obtain ⟨f, hf, hfy⟩ := hy
  obtain ⟨p, hp, hp0, htop, hpα⟩ := degreeOverSubfield_spec F α
  obtain ⟨g, hg, hgz, hgα⟩ :=
    Ising2DLambda.NecSuf.FisherZero.polynomialValues_reduced_necSuf (F : Set Qbar) F.zero_mem
      (fun _ _ ha hb => F.add_mem ha hb) (fun _ _ ha hb => F.sub_mem ha hb)
      (fun _ _ ha hb => F.mul_mem ha hb) (fun _ _ ha hb => F.div_mem ha hb) α
      (degreeOverSubfield F α) (degreeOverSubfield_hmin F α) p hp hp0 htop
      (by rw [← qbarPolyEval_eq_eval]; exact hpα) f hf
  exact ⟨g, hg, hgz, by rw [qbarPolyEval_eq_eval, hgα, ← qbarPolyEval_eq_eval, hfy]⟩

end Ising2DLambda.FisherZero
