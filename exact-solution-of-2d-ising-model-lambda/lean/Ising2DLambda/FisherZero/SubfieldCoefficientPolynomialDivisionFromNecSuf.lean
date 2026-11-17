/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomialDivision
import Ising2DLambda.NecSuf.FisherZero.SubfieldCoefficientPolynomialDivision

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_subfield_coefficient_polynomial_division` を必要十分版から得る。 -/
theorem subfieldCoefficientPolynomialDivision_from_necSuf (F : Subfield Qbar) (h : QbarPoly) (n : ℕ)
    (hh : h ∈ subfieldCoefficientPolynomials F) (hn : h.coeff n ≠ 0)
    (htop : ∀ k : ℕ, n < k → h.coeff k = 0) (g : QbarPoly)
    (hg : g ∈ subfieldCoefficientPolynomials F) :
    ∃ u r : QbarPoly, u ∈ subfieldCoefficientPolynomials F ∧ r ∈ subfieldCoefficientPolynomials F ∧
      g = u * h + r ∧ ∀ k : ℕ, n ≤ k → r.coeff k = 0 :=
  Ising2DLambda.NecSuf.FisherZero.polynomialDivision_necSuf (F : Set Qbar) F.zero_mem
    (fun _ _ ha hb => F.add_mem ha hb) (fun _ _ ha hb => F.sub_mem ha hb)
    (fun _ _ ha hb => F.mul_mem ha hb) (fun _ _ ha hb => F.div_mem ha hb) h n hh hn htop g hg

end Ising2DLambda.FisherZero
