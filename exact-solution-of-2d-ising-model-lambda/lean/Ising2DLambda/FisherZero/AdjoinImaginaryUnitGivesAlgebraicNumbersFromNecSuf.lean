/-
具体版 `adjoinImaginaryUnit_gives_algebraicNumbers` が必要十分版の特殊化として得られることの導出。
K を Qbar、S を F、T を Lin_F(ω) とし、
- S ⊆ T を u = u + 0·ω、S の積での閉性と逆元を部分体であることで、
- hfactor を `claim_imaginary_unit_extension_monic_polynomial_linear_factor_product` の具体版で、
- p を `def_degree_over_subfield`（`degreeOverSubfield_spec`）、番号 deg_F(ξ) の係数の非零性を
  `minimalVanishingPolynomial_leading_ne_zero` で
埋める。
-/
import Ising2DLambda.FisherZero.AdjoinImaginaryUnitGivesAlgebraicNumbers
import Ising2DLambda.NecSuf.FisherZero.AdjoinImaginaryUnitGivesAlgebraicNumbers

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open scoped BigOperators

theorem adjoinImaginaryUnit_gives_algebraicNumbers_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (p : QbarPoly), p ∈ subfieldCoefficientPolynomials F → Odd n →
      p.coeff n ≠ 0 → (∀ k : ℕ, n < k → p.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z p = 0)
    (omega : Qbar) (homega : omega * omega = -1) (ξ : Qbar) :
    ξ ∈ imaginaryUnitLinearValues F omega := by
  obtain ⟨p, hp, hp0, htop, hpξ⟩ := degreeOverSubfield_spec F ξ
  exact Ising2DLambda.NecSuf.FisherZero.adjoinImaginaryUnit_gives_algebraicNumbers_necSuf
    (F : Set Qbar) (imaginaryUnitLinearValues F omega)
    (fun a ha => ⟨a, 0, ha, F.zero_mem, by rw [zero_mul, add_zero]⟩)
    (fun a b ha hb => F.mul_mem ha hb)
    (fun c hc hc0 => ⟨c⁻¹, F.inv_mem hc, inv_mul_cancel₀ hc0⟩)
    (fun d g hg hb hl =>
      imaginaryUnitExtension_monicPolynomial_linearFactorProduct F C hC hpositive hodd omega
        homega d g hg hb hl)
    ξ (degreeOverSubfield F ξ) p hp
    (minimalVanishingPolynomial_leading_ne_zero F ξ p hp hp0 htop hpξ) htop
    (by rw [← qbarPolyEval_eq_eval]; exact hpξ)

end Ising2DLambda.FisherZero
