/-
主張「正の元が平方で奇数次の多項式が根を持つ部分体に虚数単位を足した体を係数とする、
最高次の係数が一の多項式は、その体に根を持つ」
（ラベル `claim_imaginary_unit_extension_monic_polynomial_root`）の具体版。

  人手証明                                                          このファイル
  準備 (一) cj_ω(0) = 0（三行の式鎖）                                 `imaginaryUnitConj_zero`
  準備 (一) cj_ω(1) = 1（三行の式鎖）                                 `imaginaryUnitConj_one`
  準備 (二) k > d での ac_k(cjp_ω(g)) = 0、ac_d(cjp_ω(g)) = 1            `hbound'`・`hlead'`
  準備 (三) h := g·cjp_ω(g) ∈ F[t]                                    `hF`
  準備 (四) k > d + d での ac_k(h) = 0、ac_{d+d}(h) = 1（四行の式鎖）   `hhbound`・`hhlead`
  準備 (五) K = F(ω) = Lin_F(ω)                                       `hK`
  主張: h の根 z、aev_z(g)·aev_z(cjp_ω(g)) = 0 の三行の式鎖、場合分け   末尾

本文の K = F(ω) は `Subfield.closure (F ∪ {ω})`。住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionConjugateEvaluation
import Ising2DLambda.FisherZero.SubfieldPolynomialRootInImaginaryUnitExtension
import Ising2DLambda.FisherZero.ImaginaryUnitOutsideOrderedSubfield
import Ising2DLambda.FisherZero.QuadraticLinearValuesAdjoin
import Ising2DLambda.FisherZero.OddDegreePolynomialHasOddDegreeRoot
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyProductCoeffBound
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 準備 (一) の後半: `cj_ω(1) = 1`。 -/
theorem imaginaryUnitConj_one
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) :
    imaginaryUnitConj F omega 1 = 1 := by
  calc imaginaryUnitConj F omega 1 = imaginaryUnitConj F omega (1 + 0 * omega) := by ring_nf
    _ = 1 - 0 * omega := imaginaryUnitConj_apply F C hC omega homega 1 0 F.one_mem F.zero_mem
    _ = 1 := by ring

/-- `claim_imaginary_unit_extension_monic_polynomial_root` の具体版。 -/
theorem imaginaryUnitExtension_monicPolynomial_root
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
  -- 準備 (二): 三行の式鎖を二つ。
  have hbound' : ∀ k : ℕ, d < k → (imaginaryUnitConjPoly F omega g).coeff k = 0 := by
    intro k hk
    calc (imaginaryUnitConjPoly F omega g).coeff k
        = imaginaryUnitConj F omega (g.coeff k) := imaginaryUnitConjPoly_coeff F C hC omega homega g k
      _ = imaginaryUnitConj F omega 0 := by rw [hbound k hk]
      _ = 0 := imaginaryUnitConj_zero F C hC omega homega
  have hlead' : (imaginaryUnitConjPoly F omega g).coeff d = 1 := by
    calc (imaginaryUnitConjPoly F omega g).coeff d
        = imaginaryUnitConj F omega (g.coeff d) := imaginaryUnitConjPoly_coeff F C hC omega homega g d
      _ = imaginaryUnitConj F omega 1 := by rw [hlead]
      _ = 1 := imaginaryUnitConj_one F C hC omega homega
  -- 準備 (三): `claim_imaginary_unit_extension_conjugate_product_subfield_coefficient`。
  have hF : g * imaginaryUnitConjPoly F omega g ∈ subfieldCoefficientPolynomials F :=
    imaginaryUnitExtension_conjugateProduct_subfieldCoefficient F C hC omega homega g hg
  -- 準備 (四): `claim_qbar_poly_product_coeff_bound` と四行の式鎖。
  have hhbound : ∀ k : ℕ, d + d < k → (g * imaginaryUnitConjPoly F omega g).coeff k = 0 :=
    qbarPolyProductCoeffBound g _ d d hbound hbound'
  have hhlead : (g * imaginaryUnitConjPoly F omega g).coeff (d + d) = 1 := by
    calc (g * imaginaryUnitConjPoly F omega g).coeff (d + d)
        = g.coeff d * (imaginaryUnitConjPoly F omega g).coeff d :=
          qbarPolyProductTopCoeff g _ d d hbound hbound'
      _ = 1 * 1 := by rw [hlead, hlead']
      _ = 1 := one_mul 1
  -- 準備 (五): `claim_imaginary_unit_outside_ordered_subfield` と
  -- `claim_square_root_adjoined_subfield_equals_linear_values`（a := -1, b := ω）。
  have hK : (Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) : Set Qbar)
      = imaginaryUnitLinearValues F omega := by
    rw [← quadraticLinearValues_eq_adjoin F (-1) omega (F.neg_mem F.one_mem) homega
      (imaginaryUnit_not_mem_orderedSubfield F C hC omega homega)]
    rfl
  -- 主張: `claim_subfield_polynomial_root_in_imaginary_unit_extension` を d + d と h へ。
  obtain ⟨z, hzK, hz⟩ := subfieldPolynomialRoot_inImaginaryUnitExtension F C hC hpositive hodd
    omega homega (d + d) (by omega) (g * imaginaryUnitConjPoly F omega g) hF hhbound hhlead
  have hzL : z ∈ imaginaryUnitLinearValues F omega := by rw [← hK]; exact hzK
  -- 三行の式鎖（aev_z は積を保つ: `def_qbar_poly_evaluation` の約束）。
  have hprod : qbarPolyEval z g * qbarPolyEval z (imaginaryUnitConjPoly F omega g) = 0 := by
    calc qbarPolyEval z g * qbarPolyEval z (imaginaryUnitConjPoly F omega g)
        = qbarPolyEval z (g * imaginaryUnitConjPoly F omega g) := by
          rw [qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, Polynomial.eval_mul]
      _ = 0 := hz
  by_cases hgz : qbarPolyEval z g = 0
  · -- aev_z(g) = 0 の場合: w := z。
    exact ⟨z, hzL, hgz⟩
  · -- aev_z(g) ≠ 0 の場合: `claim_qbar_no_zero_divisors` と w := cj_ω(z)。
    have hcz : qbarPolyEval z (imaginaryUnitConjPoly F omega g) = 0 := qbarNoZeroDivisors hgz hprod
    refine ⟨imaginaryUnitConj F omega z, imaginaryUnitConj_mem F C hC omega homega z hzL, ?_⟩
    obtain ⟨_, hev⟩ := imaginaryUnitExtension_conjugate_evaluation F C hC omega homega g hg z hzL
    calc qbarPolyEval (imaginaryUnitConj F omega z) g
        = imaginaryUnitConj F omega (qbarPolyEval z (imaginaryUnitConjPoly F omega g)) := hev
      _ = imaginaryUnitConj F omega 0 := by rw [hcz]
      _ = 0 := imaginaryUnitConj_zero F C hC omega homega

end Ising2DLambda.FisherZero
