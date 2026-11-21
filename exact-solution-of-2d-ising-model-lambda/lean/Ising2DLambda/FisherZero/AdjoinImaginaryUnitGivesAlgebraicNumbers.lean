/-
主張「正の元が平方で奇数次の多項式が根を持つ部分体に虚数単位を足すと代数的数の全体になる」
（ラベル `claim_adjoin_imaginary_unit_gives_algebraic_numbers`）の具体版。

  人手証明                                                          このファイル
  準備: n := deg_F(ξ) の零化多項式 p（`def_degree_over_subfield`）       `degreeOverSubfield_spec`
  準備: c := ac_n(p) ≠ 0（`claim_minimal_vanishing_polynomial_leading_coefficient_nonzero`）
                                                                    `minimalVanishingPolynomial_leading_ne_zero`
  準備: c ∈ F、c⁻¹ ∈ F、g := (c⁻¹)^ · p
  (一) ac_k(g) = c⁻¹ · ac_k(p) の四行の式鎖                          `qbarPolyCoeffConstMul`（既存の段）
  (二) ac_k(g) ∈ F ⊂ Lin_F(ω)
  (三) ac_n(g) = 1 の三行の式鎖
  (四) k > n で ac_k(g) = 0 の三行の式鎖
  (五) aev_ξ(g) = 0 の四行の式鎖
  一次因子の積（`claim_imaginary_unit_extension_monic_polynomial_linear_factor_product`）と
  積の根は因子の根（`claim_qbar_linear_factor_product_root_is_listed_root`）で ξ = α(r) ∈ Lin_F(ω)

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionMonicPolynomialLinearFactorProduct
import Ising2DLambda.FisherZero.MinimalVanishingPolynomialDivides
import Ising2DLambda.FisherZero.QbarLinearFactorProductRootIsListedRoot
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorQuotientCoeffBound

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open scoped BigOperators

/-- `claim_adjoin_imaginary_unit_gives_algebraic_numbers` の具体版。任意の `ξ ∈ Qbar` は `Lin_F(ω)` に属する。 -/
theorem adjoinImaginaryUnit_gives_algebraicNumbers
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (p : QbarPoly), p ∈ subfieldCoefficientPolynomials F → Odd n →
      p.coeff n ≠ 0 → (∀ k : ℕ, n < k → p.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z p = 0)
    (omega : Qbar) (homega : omega * omega = -1) (ξ : Qbar) :
    ξ ∈ imaginaryUnitLinearValues F omega := by
  -- 準備: n := deg_F(ξ) の零化多項式 p と、c := ac_n(p) ≠ 0。
  obtain ⟨p, hp, hp0, htop, hpξ⟩ := degreeOverSubfield_spec F ξ
  have hc : p.coeff (degreeOverSubfield F ξ) ≠ 0 :=
    minimalVanishingPolynomial_leading_ne_zero F ξ p hp hp0 htop hpξ
  have hcF : p.coeff (degreeOverSubfield F ξ) ∈ F := hp _
  have hcinvF : (p.coeff (degreeOverSubfield F ξ))⁻¹ ∈ F := F.inv_mem hcF
  -- (一) ac_k(g) = c⁻¹ · ac_k(p)。
  have hcoeff : ∀ k : ℕ, (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹ * p).coeff k
      = (p.coeff (degreeOverSubfield F ξ))⁻¹ * p.coeff k := fun k => qbarPolyCoeffConstMul _ p k
  -- (二) ac_k(g) ∈ F ⊂ Lin_F(ω)（u = u + 0·ω）。
  have hg : ∀ k : ℕ, (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹ * p).coeff k
      ∈ imaginaryUnitLinearValues F omega := by
    intro k
    rw [hcoeff k]
    exact ⟨(p.coeff (degreeOverSubfield F ξ))⁻¹ * p.coeff k, 0, F.mul_mem hcinvF (hp k),
      F.zero_mem, by rw [zero_mul, add_zero]⟩
  -- (三) ac_n(g) = c⁻¹ · c = 1。
  have hlead : (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹ * p).coeff
      (degreeOverSubfield F ξ) = 1 := by
    calc (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹ * p).coeff (degreeOverSubfield F ξ)
        = (p.coeff (degreeOverSubfield F ξ))⁻¹ * p.coeff (degreeOverSubfield F ξ) := hcoeff _
      _ = 1 := inv_mul_cancel₀ hc
  -- (四) k > n で ac_k(g) = c⁻¹ · 0 = 0。
  have hbound : ∀ k : ℕ, degreeOverSubfield F ξ < k →
      (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹ * p).coeff k = 0 := by
    intro k hk
    calc (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹ * p).coeff k
        = (p.coeff (degreeOverSubfield F ξ))⁻¹ * p.coeff k := hcoeff k
      _ = (p.coeff (degreeOverSubfield F ξ))⁻¹ * 0 := by rw [htop k hk]
      _ = 0 := mul_zero _
  -- 一次因子の積を d := n へ当てる。
  obtain ⟨α, hα, hfac⟩ := imaginaryUnitExtension_monicPolynomial_linearFactorProduct F C hC
    hpositive hodd omega homega (degreeOverSubfield F ξ) _ hg hbound hlead
  -- (五) aev_ξ(g) = aev_ξ((c⁻¹)^) · aev_ξ(p) = c⁻¹ · 0 = 0。
  have hgξ : qbarPolyEval ξ (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹ * p) = 0 := by
    calc qbarPolyEval ξ (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹ * p)
        = qbarPolyEval ξ (qbarConst (p.coeff (degreeOverSubfield F ξ))⁻¹) * qbarPolyEval ξ p := by
          rw [qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, Polynomial.eval_mul]
      _ = (p.coeff (degreeOverSubfield F ξ))⁻¹ * qbarPolyEval ξ p := by
          rw [qbarPolyEval_eq_eval ξ (qbarConst _), qbarConst, Polynomial.eval_C]
      _ = (p.coeff (degreeOverSubfield F ξ))⁻¹ * 0 := by rw [hpξ]
      _ = 0 := mul_zero _
  -- 積の根は因子の根: ξ = α(r) ∈ Lin_F(ω)。
  rw [hfac] at hgξ
  obtain ⟨r, _, hr⟩ := qbarLinearFactorProductRootIsListedRoot (degreeOverSubfield F ξ) α ξ hgξ
  rw [hr]
  exact hα r

end Ising2DLambda.FisherZero
