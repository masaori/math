/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomials
import Ising2DLambda.NecSuf.FisherZero.SubfieldCoefficientPolynomials

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_subfield_contains_rationals` を必要十分版から得る。 -/
theorem ratCast_mem_subfield_from_necSuf (F : Subfield Qbar) (q : ℚ) : (q : Qbar) ∈ F :=
  Ising2DLambda.NecSuf.FisherZero.ratCast_mem_necSuf (F : Set Qbar) F.zero_mem F.one_mem
    (fun _ _ ha hb => F.add_mem ha hb) (fun _ ha => F.neg_mem ha)
    (fun _ _ ha hb => F.div_mem ha hb) q

/-- `claim_subfield_coefficient_vanishing_polynomial_exists` を必要十分版から得る。
有理数の像が `F` に属することは、具体版の主張 `ratCast_mem_subfield` から渡す。 -/
theorem subfieldCoefficientVanishingPolynomial_exists_from_necSuf (F : Subfield Qbar) (α : Qbar) :
    ∃ f : QbarPoly, f ∈ subfieldCoefficientPolynomials F ∧ f ≠ 0 ∧ qbarPolyEval α f = 0 := by
  obtain ⟨f, hf, hf0, hfα⟩ :=
    Ising2DLambda.NecSuf.FisherZero.vanishingPolynomial_exists_necSuf
      (algebraMap ℚ Qbar).injective (F : Set Qbar)
      (fun r => by rw [eq_ratCast]; exact ratCast_mem_subfield F r) α
      (Algebra.IsAlgebraic.isAlgebraic α)
  exact ⟨f, hf, hf0, by rw [qbarPolyEval_eq_eval]; exact hfα⟩

end Ising2DLambda.FisherZero
