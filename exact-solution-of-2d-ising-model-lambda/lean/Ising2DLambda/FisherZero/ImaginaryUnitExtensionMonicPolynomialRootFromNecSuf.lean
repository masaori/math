/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。
`S := F`、`T := Lin_F(ω)`、`cj := cj_ω`、`cjp := cjp_ω`。`hroot` は
`claim_subfield_polynomial_root_in_imaginary_unit_extension` と `F(ω) = Lin_F(ω)` から、
`hprodS`・`hev` はそれぞれの主張の具体版から渡す。 -/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionMonicPolynomialRoot
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionMonicPolynomialRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_imaginary_unit_extension_monic_polynomial_root` を必要十分版から得る。 -/
theorem imaginaryUnitExtension_monicPolynomial_root_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (p : QbarPoly), p ∈ subfieldCoefficientPolynomials F → Odd n →
      p.coeff n ≠ 0 → (∀ k : ℕ, n < k → p.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z p = 0)
    (omega : Qbar) (homega : omega * omega = -1)
    (d : ℕ) (hd : 1 ≤ d) (g : QbarPoly)
    (hg : ∀ k : ℕ, g.coeff k ∈ imaginaryUnitLinearValues F omega)
    (hbound : ∀ k : ℕ, d < k → g.coeff k = 0) (hlead : g.coeff d = 1) :
    ∃ w : Qbar, w ∈ imaginaryUnitLinearValues F omega ∧ qbarPolyEval w g = 0 := by
  have hK : (Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) : Set Qbar)
      = imaginaryUnitLinearValues F omega := by
    rw [← quadraticLinearValues_eq_adjoin F (-1) omega (F.neg_mem F.one_mem) homega
      (imaginaryUnit_not_mem_orderedSubfield F C hC omega homega)]
    rfl
  obtain ⟨w, hw, hzero⟩ :=
    Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_monicPolynomial_root_necSuf
      (F : Set Qbar) (imaginaryUnitLinearValues F omega) F.zero_mem F.one_mem omega
      (imaginaryUnitConj F omega)
      (fun a b ha hb => imaginaryUnitConj_apply F C hC omega homega a b ha hb)
      (fun z hz => imaginaryUnitConj_mem F C hC omega homega z hz)
      (imaginaryUnitConjPoly F omega)
      (fun g k => imaginaryUnitConjPoly_coeff F C hC omega homega g k)
      (fun g hg => imaginaryUnitExtension_conjugateProduct_subfieldCoefficient F C hC omega homega g hg)
      (fun n f hn hf hfb hfl => by
        obtain ⟨z, hzK, hz⟩ :=
          subfieldPolynomialRoot_inImaginaryUnitExtension F C hC hpositive hodd omega homega
            n hn f hf hfb hfl
        refine ⟨z, by rw [← hK]; exact hzK, ?_⟩
        rw [← qbarPolyEval_eq_eval]; exact hz)
      (fun g hg z hz => by
        obtain ⟨_, hev⟩ := imaginaryUnitExtension_conjugate_evaluation F C hC omega homega g hg z hz
        rw [← qbarPolyEval_eq_eval, ← qbarPolyEval_eq_eval]; exact hev)
      d hd g hg hbound hlead
  exact ⟨w, hw, by rw [qbarPolyEval_eq_eval]; exact hzero⟩

end Ising2DLambda.FisherZero
