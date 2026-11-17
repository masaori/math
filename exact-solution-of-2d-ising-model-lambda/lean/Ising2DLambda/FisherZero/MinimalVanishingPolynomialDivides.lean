/-
定義「部分体を係数とする多項式に元を代入した値の全体」（ラベル `def_subfield_polynomial_values`）、
主張「部分体上の次数より上の係数を持たない零化多項式は零である」
（ラベル `claim_vanishing_polynomial_below_degree_is_zero`）、
主張「最小次数の零化多項式は、元を根とする部分体係数の多項式を全て割り切る」
（ラベル `claim_minimal_vanishing_polynomial_divides`）、
主張「代入した値の全体の各元は、次数未満の係数しか持たない多項式の値である」
（ラベル `claim_subfield_polynomial_values_reduced_representation`）の具体版。

  人手証明                                          このファイル
  次数未満の零化多項式が零（n = 0 と n ≥ 1）        `vanishingPolynomial_below_degree_eq_zero`
  最小次数の零化多項式の最高次の係数が零でない段    `minimalVanishingPolynomial_leading_ne_zero`
  除法・余りの値・余りが零                          `minimalVanishingPolynomial_dvd`
  除法・値の一致                                    `subfieldPolynomialValues_reduced`

除法は本文の除法の具体版 `subfieldCoefficientPolynomialDivision` を引く。
代入が和と積を保つことは `def_qbar_poly_evaluation` の約束（`Polynomial.eval_add`・`eval_mul`）。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomialDivision

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_subfield_polynomial_values` の具体版。`Val_F(α) = {aev_α(g) | g ∈ F[t]}`。 -/
def subfieldPolynomialValues (F : Subfield Qbar) (α : Qbar) : Set Qbar :=
  {y | ∃ g : QbarPoly, g ∈ subfieldCoefficientPolynomials F ∧ qbarPolyEval α g = y}

/-- `claim_vanishing_polynomial_below_degree_is_zero` の具体版。`k ≥ deg_F(α)` で係数が零の
`q ∈ F[t]` が `α` を根とするなら `q = 0`。 -/
theorem vanishingPolynomial_below_degree_eq_zero (F : Subfield Qbar) (α : Qbar) (q : QbarPoly)
    (hq : q ∈ subfieldCoefficientPolynomials F) (hqα : qbarPolyEval α q = 0)
    (hz : ∀ k : ℕ, degreeOverSubfield F α ≤ k → q.coeff k = 0) : q = 0 := by
  by_contra hq0
  rcases Nat.eq_zero_or_pos (degreeOverSubfield F α) with h0 | hpos
  · -- deg_F(α) = 0: 全ての係数が零なので q = 0 で、q ≠ 0 に反する。
    exact hq0 (Polynomial.ext fun k => by rw [Polynomial.coeff_zero]; exact hz k (by omega))
  · -- deg_F(α) ≥ 1: deg_F(α) - 1 ∈ D_F(α) となり、最小性に反する。
    have hle := degreeOverSubfield_le F α (degreeOverSubfield F α - 1) q hq hq0
      (fun k hk => hz k (by omega)) hqα
    omega

/-- 本文の段「`ac_n(p) ≠ 0`」。`n = deg_F(α)` を係数の上界とする零化多項式 `p` の番号 `n` の係数は零でない。 -/
theorem minimalVanishingPolynomial_leading_ne_zero (F : Subfield Qbar) (α : Qbar) (p : QbarPoly)
    (hp : p ∈ subfieldCoefficientPolynomials F) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, degreeOverSubfield F α < k → p.coeff k = 0) (hpα : qbarPolyEval α p = 0) :
    p.coeff (degreeOverSubfield F α) ≠ 0 := by
  intro hc
  apply hp0
  apply vanishingPolynomial_below_degree_eq_zero F α p hp hpα
  intro k hk
  rcases Nat.eq_or_lt_of_le hk with heq | hlt
  · rw [← heq]; exact hc
  · exact htop k hlt

/-- `claim_minimal_vanishing_polynomial_divides` の具体版。 -/
theorem minimalVanishingPolynomial_dvd (F : Subfield Qbar) (α : Qbar) (p : QbarPoly)
    (hp : p ∈ subfieldCoefficientPolynomials F) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, degreeOverSubfield F α < k → p.coeff k = 0) (hpα : qbarPolyEval α p = 0)
    (f : QbarPoly) (hf : f ∈ subfieldCoefficientPolynomials F) (hfα : qbarPolyEval α f = 0) :
    ∃ u : QbarPoly, u ∈ subfieldCoefficientPolynomials F ∧ f = u * p := by
  -- 除法: f = u · p + r、k ≥ deg_F(α) で ac_k(r) = 0。
  obtain ⟨u, r, hu, hr, hfeq, hrz⟩ := subfieldCoefficientPolynomialDivision F p
    (degreeOverSubfield F α) hp
    (minimalVanishingPolynomial_leading_ne_zero F α p hp hp0 htop hpα) htop f hf
  -- 余りの値: aev_α(r) = aev_α(f) - aev_α(u) · aev_α(p) = 0 - aev_α(u) · 0 = 0。
  have hrα : qbarPolyEval α r = 0 := by
    calc qbarPolyEval α r
        = qbarPolyEval α f - qbarPolyEval α u * qbarPolyEval α p := by
          simp only [hfeq, qbarPolyEval_eq_eval, Polynomial.eval_add, Polynomial.eval_mul]
          ring
      _ = 0 - qbarPolyEval α u * 0 := by rw [hfα, hpα]
      _ = 0 := by ring
  -- 余りは零。
  have hr0 : r = 0 := vanishingPolynomial_below_degree_eq_zero F α r hr hrα hrz
  exact ⟨u, hu, by rw [hfeq, hr0, add_zero]⟩

/-- `claim_subfield_polynomial_values_reduced_representation` の具体版。 -/
theorem subfieldPolynomialValues_reduced (F : Subfield Qbar) (α y : Qbar)
    (hy : y ∈ subfieldPolynomialValues F α) :
    ∃ g : QbarPoly, g ∈ subfieldCoefficientPolynomials F ∧
      (∀ k : ℕ, degreeOverSubfield F α ≤ k → g.coeff k = 0) ∧ qbarPolyEval α g = y := by
  obtain ⟨f, hf, hfy⟩ := hy
  -- deg_F(α) ∈ D_F(α) の証人 p。
  obtain ⟨p, hp, hp0, htop, hpα⟩ := degreeOverSubfield_spec F α
  obtain ⟨u, r, _, hr, hfeq, hrz⟩ := subfieldCoefficientPolynomialDivision F p
    (degreeOverSubfield F α) hp
    (minimalVanishingPolynomial_leading_ne_zero F α p hp hp0 htop hpα) htop f hf
  refine ⟨r, hr, hrz, ?_⟩
  -- y = aev_α(f) = aev_α(u) · aev_α(p) + aev_α(r) = aev_α(u) · 0 + aev_α(r) = aev_α(r)。
  calc qbarPolyEval α r
      = qbarPolyEval α u * 0 + qbarPolyEval α r := by ring
    _ = qbarPolyEval α u * qbarPolyEval α p + qbarPolyEval α r := by rw [hpα]
    _ = qbarPolyEval α f := by
        simp only [hfeq, qbarPolyEval_eq_eval, Polynomial.eval_add, Polynomial.eval_mul]
    _ = y := hfy

end Ising2DLambda.FisherZero
