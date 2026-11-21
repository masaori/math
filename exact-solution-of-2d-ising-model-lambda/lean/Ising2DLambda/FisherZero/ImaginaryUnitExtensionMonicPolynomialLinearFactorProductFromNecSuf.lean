/-
具体版 `imaginaryUnitExtension_monicPolynomial_linearFactorProduct` が必要十分版の特殊化として
得られることの導出。値の型を Qbar[t]（積の可換モノイド）、根の型を Qbar、因子を t - x̂、
P を「係数が全て Lin_F(ω)」、S を「Lin_F(ω) に属する」、上界の述語を「その番号より上の係数が零」、
先頭の係数の述語を「その番号の係数が 1」とし、
- hs0 を 0 ∈ Lin_F(ω)（`imaginaryUnitLinearValues_ringClosed`）、
- hbase を `claim_qbar_monic_polynomial_linear_factor_product` の d = 0、
- hstep を一歩の (一)〜(五)（`imaginaryUnitExtension_monicQuotient`）
で埋める。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionMonicPolynomialLinearFactorProduct
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionMonicPolynomialLinearFactorProduct

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open scoped BigOperators

theorem imaginaryUnitExtension_monicPolynomial_linearFactorProduct_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (p : QbarPoly), p ∈ subfieldCoefficientPolynomials F → Odd n →
      p.coeff n ≠ 0 → (∀ k : ℕ, n < k → p.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z p = 0)
    (omega : Qbar) (homega : omega * omega = -1) (d : ℕ) (g : QbarPoly)
    (hg : ∀ k : ℕ, g.coeff k ∈ imaginaryUnitLinearValues F omega)
    (hbound : ∀ k : ℕ, d < k → g.coeff k = 0) (hlead : g.coeff d = 1) :
    ∃ α : ℕ → Qbar, (∀ i : ℕ, α i ∈ imaginaryUnitLinearValues F omega) ∧
      g = ∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i)) := by
  obtain ⟨h0, _, _, _⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  exact Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_monicPolynomial_linearFactorProduct_necSuf
    (fun x => Polynomial.X - qbarConst x)
    (fun p => ∀ k : ℕ, p.coeff k ∈ imaginaryUnitLinearValues F omega)
    (fun x => x ∈ imaginaryUnitLinearValues F omega)
    (fun p m => ∀ k : ℕ, m < k → p.coeff k = 0)
    (fun p m => p.coeff m = 1)
    ⟨0, h0⟩
    (fun f hb hl => by
      obtain ⟨α₀, hα₀⟩ := qbarMonicPolynomialLinearFactorProduct 0 f hb hl
      rw [hα₀, Finset.range_zero, Finset.prod_empty])
    (fun g m hP hb hl =>
      imaginaryUnitExtension_monicQuotient F C hC hpositive hodd omega homega m g hP hb hl)
    d g hg hbound hlead

end Ising2DLambda.FisherZero
