/-
主張「虚数単位を足した体を係数とする最高次の係数が一の多項式は、その体の元を根とする一次因子の積である」
（ラベル `claim_imaginary_unit_extension_monic_polynomial_linear_factor_product`）の具体版。

人手証明と同じ d についての帰納法（任意の g について）である。

  人手証明                                                          このファイル
  出発点: `claim_qbar_monic_polynomial_linear_factor_product` を d = 0 へ当て、
          g = 空積 = 1 = 空積（三行の式鎖）。α(i) := 0 ∈ Lin_F(ω)        `zero` の場合
  一歩 (一) 根 w ∈ Lin_F(ω)（`claim_imaginary_unit_extension_monic_polynomial_root`）
  一歩 (二) 因数定理の商 q と g = (t - ŵ)q（`claim_qbar_factor_theorem`）
  一歩 (三) 商の係数は Lin_F(ω)（`claim_imaginary_unit_extension_factor_quotient_coefficient`）
  一歩 (四) k > d で ac_k(q) = 0（`claim_qbar_factor_quotient_coeff_bound`）
  一歩 (五) ac_d(q) = ac_{d+1}((t - ŵ)q) = ac_{d+1}(g) = 1 の三行の式鎖
                                                                    `imaginaryUnitExtension_monicQuotient`
  一歩: 帰納法の仮定で α'、α の定め方と所属、結論の五行の式鎖     `succ` の場合

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionMonicPolynomialRoot
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionFactorQuotientCoefficient
import Ising2DLambda.FisherZero.QbarMonicPolynomialLinearFactorProduct
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorTheorem
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorQuotientCoeffBound
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorLeadingCoeff

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open scoped BigOperators

/-- 一歩の (一)〜(五)。番号 `d + 1` の係数が 1 で係数が `Lin_F(ω)` の `g` は、根 `w ∈ Lin_F(ω)` と、
係数が `Lin_F(ω)` で番号 `d` の係数が 1 の商 `q` に分かれる。 -/
theorem imaginaryUnitExtension_monicQuotient
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (p : QbarPoly), p ∈ subfieldCoefficientPolynomials F → Odd n →
      p.coeff n ≠ 0 → (∀ k : ℕ, n < k → p.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z p = 0)
    (omega : Qbar) (homega : omega * omega = -1)
    (d : ℕ) (g : QbarPoly)
    (hg : ∀ k : ℕ, g.coeff k ∈ imaginaryUnitLinearValues F omega)
    (hbound : ∀ k : ℕ, d + 1 < k → g.coeff k = 0) (hlead : g.coeff (d + 1) = 1) :
    ∃ w : Qbar, ∃ q : QbarPoly, w ∈ imaginaryUnitLinearValues F omega ∧
      g = (Polynomial.X - qbarConst w) * q ∧
      (∀ j : ℕ, q.coeff j ∈ imaginaryUnitLinearValues F omega) ∧
      (∀ k : ℕ, d < k → q.coeff k = 0) ∧ q.coeff d = 1 := by
  -- (一) 根の存在を番号 d + 1 ≥ 1 へ当てる。
  obtain ⟨w, hw, hroot⟩ := imaginaryUnitExtension_monicPolynomial_root F C hC hpositive hodd
    omega homega (d + 1) (by omega) g hg hbound hlead
  -- (二) 因数定理の商 q。
  have hfact := qbarFactorTheorem g w (d + 1) hbound hroot
  refine ⟨w, ∑ k ∈ Finset.range (d + 1 + 1), qbarConst (g.coeff k) * qbarPolyPowDiffSum w k,
    hw, hfact, ?_, ?_, ?_⟩
  · -- (三) 商の係数の所属。
    intro j
    exact imaginaryUnitExtension_factor_quotient_coefficient F omega homega g hg w hw (d + 1) j
  · -- (四) k > d、すなわち k ≥ d + 1 で商の係数は零。
    intro k hk
    exact qbarFactorQuotientCoeffBound g w (d + 1) k (by omega)
  · -- (五) 三行の式鎖。
    have hqbound : ∀ k : ℕ, d < k →
        (∑ k ∈ Finset.range (d + 1 + 1),
          qbarConst (g.coeff k) * qbarPolyPowDiffSum w k).coeff k = 0 := by
      intro k hk
      exact qbarFactorQuotientCoeffBound g w (d + 1) k (by omega)
    calc (∑ k ∈ Finset.range (d + 1 + 1),
            qbarConst (g.coeff k) * qbarPolyPowDiffSum w k).coeff d
        = ((Polynomial.X - qbarConst w) * ∑ k ∈ Finset.range (d + 1 + 1),
            qbarConst (g.coeff k) * qbarPolyPowDiffSum w k).coeff (d + 1) :=
          (qbarPolyLinearFactorLeadingCoeff w _ d hqbound).symm
      _ = g.coeff (d + 1) := by rw [← hfact]
      _ = 1 := hlead

/-- `claim_imaginary_unit_extension_monic_polynomial_linear_factor_product` の具体版。 -/
theorem imaginaryUnitExtension_monicPolynomial_linearFactorProduct
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (p : QbarPoly), p ∈ subfieldCoefficientPolynomials F → Odd n →
      p.coeff n ≠ 0 → (∀ k : ℕ, n < k → p.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z p = 0)
    (omega : Qbar) (homega : omega * omega = -1) (d : ℕ) :
    ∀ g : QbarPoly, (∀ k : ℕ, g.coeff k ∈ imaginaryUnitLinearValues F omega) →
      (∀ k : ℕ, d < k → g.coeff k = 0) → g.coeff d = 1 →
      ∃ α : ℕ → Qbar, (∀ i : ℕ, α i ∈ imaginaryUnitLinearValues F omega) ∧
        g = ∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i)) := by
  -- 0 ∈ F と 0 = 0 + 0·ω から 0 ∈ Lin_F(ω)。
  have h0 : (0 : Qbar) ∈ imaginaryUnitLinearValues F omega :=
    ⟨0, 0, F.zero_mem, F.zero_mem, by ring⟩
  induction d with
  | zero =>
      intro g _ hbound hlead
      -- 出発点: α(i) := 0 ∈ Lin_F(ω)。
      refine ⟨fun _ => 0, fun _ => h0, ?_⟩
      obtain ⟨α₀, hα₀⟩ := qbarMonicPolynomialLinearFactorProduct 0 g hbound hlead
      calc g = ∏ i ∈ Finset.range 0, (Polynomial.X - qbarConst (α₀ i)) := hα₀
        _ = 1 := by rw [Finset.range_zero, Finset.prod_empty]
        _ = ∏ i ∈ Finset.range 0, (Polynomial.X - qbarConst ((fun _ => (0 : Qbar)) i)) := by
            rw [Finset.range_zero, Finset.prod_empty]
  | succ d ih =>
      intro g hg hbound hlead
      -- 一歩の (一)〜(五)。
      obtain ⟨w, q, hw, hfact, hq, hqbound, hqlead⟩ :=
        imaginaryUnitExtension_monicQuotient F C hC hpositive hodd omega homega d g hg hbound hlead
      -- 帰納法の仮定を q へ当てる。
      obtain ⟨α', hα'mem, hα'⟩ := ih q hq hqbound hqlead
      refine ⟨fun i => if i = d then w else α' i, ?_, ?_⟩
      · -- α の値の所属。
        intro i
        by_cases hid : i = d
        · simp only [if_pos hid]; exact hw
        · simp only [if_neg hid]; exact hα'mem i
      · have hprod :
            (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α' i)))
              = ∏ i ∈ Finset.range d,
                  (Polynomial.X - qbarConst ((fun i => if i = d then w else α' i) i)) := by
          refine Finset.prod_congr rfl (fun i hi => ?_)
          have hid : ¬ i = d := by
            have := Finset.mem_range.mp hi
            omega
          simp only [if_neg hid]
        calc
          g = (Polynomial.X - qbarConst w) * q := hfact
          _ = (Polynomial.X - qbarConst w)
                * ∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α' i)) := by
                -- 第二の等号: α' の取り方。
                rw [← hα']
          _ = (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α' i)))
                * (Polynomial.X - qbarConst w) := by
                -- 第三の等号: 積の可換則。
                rw [mul_comm]
          _ = (∏ i ∈ Finset.range d,
                  (Polynomial.X - qbarConst ((fun i => if i = d then w else α' i) i)))
                * (Polynomial.X - qbarConst ((fun i => if i = d then w else α' i) d)) := by
                -- 第四の等号: i < d で α(i) = α'(i)、α(d) = w。
                rw [← hprod]; simp only [↓reduceIte]
          _ = ∏ i ∈ Finset.range (d + 1),
                (Polynomial.X - qbarConst ((fun i => if i = d then w else α' i) i)) := by
                -- 第五の等号: 番号の小さい因子から順に掛ける有限積の約束。
                rw [Finset.prod_range_succ]

end Ising2DLambda.FisherZero
