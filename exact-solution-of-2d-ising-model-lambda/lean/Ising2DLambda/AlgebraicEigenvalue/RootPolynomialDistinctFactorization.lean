/-
「根の多項式は相異なる根の一次因子を順に取り出せる」の具体版。
人手証明の正本は `claim_root_polynomial_distinct_factorization` である。

人手証明と同じ j についての帰納法である。準備の 4 補題は本文の準備の段に対応する。

  人手証明                                     このファイル
  出発点の係数の上界（4 段の鎖）               `rootPolynomialCoeffBound`
  出発点の先頭の係数（4 段の鎖）               `rootPolynomial_coeff_top`（既存）
  「代数閉性により根が存在する」の段           `rootPolynomialDistinctFactorizationRootExists`
    （Qbar の定義＝ℚ の代数閉包が持つ性質 `IsAlgClosed.exists_root` で引く。
      次数 1 以上は先頭の係数 1 ≠ 0 から出す）
  因数定理・商の係数上界・先頭の係数の維持     `rootPolynomialDistinctFactorizationQuotient`
    （`qbarFactorTheorem`・`qbarFactorQuotientCoeffBound`・
      `qbarPolyLinearFactorLeadingCoeff` を同じ商 q へ当てる）
  分解を評価して w(j)^n = 1 を得る段           `rootPolynomialLinearFactorRootMem`
  取り出し（r3）・積の係数上界（r1）・
  取り出した根との相異性（d4b2c3）             帰納法の一歩の `hxne`

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyExtractedRootDistinct
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyProductCoeffBound
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorLeadingCoeff

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

/-- 出発点の準備: `f = t^n - 1` の係数は番号 `n` より上で零である
（人手証明の出発点の 4 段の鎖）。 -/
theorem rootPolynomialCoeffBound (n : ℕ) :
    ∀ k : ℕ, n < k → (rootPolynomial n).coeff k = 0 := by
  intro k hk
  have hkn : ¬ k = n := by omega
  have hk0 : ¬ k = 0 := by omega
  rw [rootPolynomial, Polynomial.coeff_add,
    qbarPolyIndeterminatePowerCoefficient n k, if_neg hkn,
    qbarConst, Polynomial.coeff_C, if_neg hk0, zero_add]

/-- 一歩の準備（代数閉性）: 番号 `m ≥ 1` の係数が 1 の多項式は根を持つ。
本文の「`def_algebraic_numbers` の代数閉性により根が存在する」の段。
次数が 0 でないことは、係数 1 ≠ 0 が次数の下界 `m ≥ 1` を与えることから出す。 -/
theorem rootPolynomialDistinctFactorizationRootExists (g : QbarPoly) (m : ℕ)
    (hm : 1 ≤ m) (hlead : g.coeff m = 1) :
    ∃ x : Qbar, qbarPolyEval x g = 0 := by
  have hgne : g.coeff m ≠ 0 := by rw [hlead]; exact one_ne_zero
  have hdeg : g.degree ≠ 0 := by
    intro h0
    have h1 : ((m : ℕ) : WithBot ℕ) ≤ g.degree :=
      Polynomial.le_degree_of_ne_zero hgne
    rw [h0] at h1
    have h2 : m ≤ 0 := by exact_mod_cast h1
    omega
  obtain ⟨x, hx⟩ := IsAlgClosed.exists_root g hdeg
  exact ⟨x, by rw [qbarPolyEval_eq_eval]; exact hx⟩

/-- 一歩の準備: 因数定理の明示的な商 `q` は、分解・係数の上界 `m - 1`・
先頭の係数 1 を同時に満たす。本文の一歩で `q` に確かめる 3 条件をまとめた段
（`qbarFactorTheorem`・`qbarFactorQuotientCoeffBound`・
`qbarPolyLinearFactorLeadingCoeff` の適用）。 -/
theorem rootPolynomialDistinctFactorizationQuotient (g : QbarPoly) (x : Qbar) (m : ℕ)
    (hm : 1 ≤ m) (hbound : ∀ k : ℕ, m < k → g.coeff k = 0) (hlead : g.coeff m = 1)
    (hroot : qbarPolyEval x g = 0) :
    ∃ q : QbarPoly,
      g = (Polynomial.X - qbarConst x) * q ∧
      (∀ k : ℕ, m - 1 < k → q.coeff k = 0) ∧
      q.coeff (m - 1) = 1 := by
  have hfact := qbarFactorTheorem g x m hbound hroot
  refine ⟨∑ k ∈ Finset.range (m + 1),
    qbarConst (g.coeff k) * qbarPolyPowDiffSum x k, hfact, ?_, ?_⟩
  · intro k hk
    exact qbarFactorQuotientCoeffBound g x m k (by omega)
  · -- 先頭の係数の維持: ac_m(g) = ac_{m-1}(q)。
    have hqbound : ∀ k : ℕ, m - 1 < k →
        (∑ k ∈ Finset.range (m + 1),
          qbarConst (g.coeff k) * qbarPolyPowDiffSum x k).coeff k = 0 := by
      intro k hk
      exact qbarFactorQuotientCoeffBound g x m k (by omega)
    have hl := qbarPolyLinearFactorLeadingCoeff x
      (∑ k ∈ Finset.range (m + 1),
        qbarConst (g.coeff k) * qbarPolyPowDiffSum x k) (m - 1) hqbound
    have hm' : m - 1 + 1 = m := by omega
    rw [hm'] at hl
    calc
      (∑ k ∈ Finset.range (m + 1),
          qbarConst (g.coeff k) * qbarPolyPowDiffSum x k).coeff (m - 1)
          = ((Polynomial.X - qbarConst x)
              * ∑ k ∈ Finset.range (m + 1),
                  qbarConst (g.coeff k) * qbarPolyPowDiffSum x k).coeff m := hl.symm
      _ = g.coeff m := by rw [← hfact]
      _ = 1 := hlead

/-- 一歩の準備: `f = t^n - 1` の一次因子の根は 1 の `n` 乗根である。
本文の「分解へ `aev_{w(j)}` を当てて `w(j)^n = 1` を得る」2 つの鎖の段。 -/
theorem rootPolynomialLinearFactorRootMem (n : ℕ) (x : Qbar) (C : QbarPoly)
    (hf : rootPolynomial n = (Polynomial.X - qbarConst x) * C) :
    x ∈ RootOfUnity n := by
  have hfx : qbarPolyEval x (rootPolynomial n) = 0 := by
    rw [hf, qbarPolyEval_eq_eval]
    simp [qbarConst]
  have hval : qbarPolyEval x (rootPolynomial n) = x ^ n + (-1) := by
    rw [rootPolynomial, qbarPolyEval_eq_eval]
    simp [qbarConst]
  rw [hval] at hfx
  have hfx' : x ^ n - 1 = 0 := by rw [sub_eq_add_neg]; exact hfx
  show x ^ n = 1
  exact sub_eq_zero.mp hfx'

/-- 人手証明の本体。`j ≤ n` について、互いに相異なる `j` 個の 1 の `n` 乗根と、
係数の上界 `n - j`・先頭の係数 1 の商 `g` による分解が存在する（`j` についての帰納法）。 -/
theorem rootPolynomialDistinctFactorization (n : ℕ) (hn : 1 ≤ n) :
    ∀ j : ℕ, j ≤ n →
      ∃ (w : ℕ → Qbar) (g : QbarPoly),
        (∀ i : ℕ, i < j → w i ∈ RootOfUnity n) ∧
        (∀ i i' : ℕ, i < j → i' < j → i ≠ i' → w i ≠ w i') ∧
        rootPolynomial n
          = (∏ i ∈ Finset.range j, (Polynomial.X - qbarConst (w i))) * g ∧
        (∀ k : ℕ, n - j < k → g.coeff k = 0) ∧
        g.coeff (n - j) = 1 := by
  intro j
  induction j with
  | zero =>
      -- 出発点: 根の列は空、g := f。
      intro _
      refine ⟨fun _ => 1, rootPolynomial n, ?_, ?_, ?_, ?_, ?_⟩
      · intro i hi; exact absurd hi (Nat.not_lt_zero i)
      · intro i i' hi _ _; exact absurd hi (Nat.not_lt_zero i)
      · rw [Finset.range_zero, Finset.prod_empty, one_mul]
      · intro k hk
        exact rootPolynomialCoeffBound n k (by omega)
      · exact rootPolynomial_coeff_top n (by omega)
  | succ j ih =>
      intro hj1
      have hjn : j < n := by omega
      obtain ⟨w, g, hmem, hdist, hdecomp, hbound, hlead⟩ := ih (by omega)
      have hm1 : 1 ≤ n - j := by omega
      -- 代数閉性により g の根 x を取る。
      obtain ⟨x, hroot⟩ :=
        rootPolynomialDistinctFactorizationRootExists g (n - j) hm1 hlead
      -- 因数定理の明示的な商 q と、その係数の上界・先頭の係数。
      obtain ⟨q, hfact, hqbound', hqlead'⟩ :=
        rootPolynomialDistinctFactorizationQuotient g x (n - j) hm1 hbound hlead hroot
      have hqbound : ∀ k : ℕ, n - (j + 1) < k → q.coeff k = 0 := by
        intro k hk
        exact hqbound' k (by omega)
      have hqlead : q.coeff (n - (j + 1)) = 1 := by
        have h : n - (j + 1) = n - j - 1 := by omega
        rw [h]
        exact hqlead'
      -- 新しい根の所属: f = (t - x̂)((∏ ...) q) と並べ替えて評価の段を当てる。
      have hxmem : x ∈ RootOfUnity n := by
        refine rootPolynomialLinearFactorRootMem n x
          ((∏ i ∈ Finset.range j, (Polynomial.X - qbarConst (w i))) * q) ?_
        rw [hdecomp, hfact, mul_left_comm]
      -- 相異性: 既出の根の一次因子を取り出し（r3）、残り B と g の積へ
      -- 積の係数上界（r1）を当てて、取り出した根との相異性（d4b2c3）で出す。
      have hxne : ∀ i : ℕ, i < j → x ≠ w i := by
        intro i hij
        obtain ⟨B, hB, hBbound⟩ := qbarPolyLinearFactorProductExtract w j i hij
        have hhbound : ∀ k : ℕ, n < k → (B * g).coeff k = 0 := by
          intro k hk
          exact qbarPolyProductCoeffBound B g (j - 1) (n - j) hBbound hbound k (by omega)
        have hfeq : rootPolynomial n
            = (Polynomial.X - qbarConst (w i)) * (B * g) := by
          rw [hdecomp, hB, mul_assoc]
        exact qbarPolyExtractedRootDistinct n hn (w i) (hmem i hij) (B * g) B g
          hhbound hfeq rfl x hroot
      -- 根の列へ x を加え、商を q に替える。
      refine ⟨fun i => if i = j then x else w i, q, ?_, ?_, ?_, hqbound, hqlead⟩
      · intro i hi
        by_cases hij : i = j
        · simp only [if_pos hij]; exact hxmem
        · simp only [if_neg hij]; exact hmem i (by omega)
      · intro i i' hi hi' hne
        by_cases hij : i = j
        · have hij' : ¬ i' = j := by omega
          simp only [if_pos hij, if_neg hij']
          exact hxne i' (by omega)
        · by_cases hij' : i' = j
          · simp only [if_neg hij, if_pos hij']
            exact Ne.symm (hxne i (by omega))
          · simp only [if_neg hij, if_neg hij']
            exact hdist i i' (by omega) (by omega) hne
      · -- 分解の等式（有限積の約束により最後の因子を掛ける）。
        have hprodeq :
            (∏ i ∈ Finset.range (j + 1),
              (Polynomial.X - qbarConst (if i = j then x else w i)))
            = (∏ i ∈ Finset.range j, (Polynomial.X - qbarConst (w i)))
                * (Polynomial.X - qbarConst x) := by
          rw [Finset.prod_range_succ, if_pos rfl]
          congr 1
          refine Finset.prod_congr rfl (fun i hi => ?_)
          have hij : ¬ i = j := by
            have := Finset.mem_range.mp hi
            omega
          rw [if_neg hij]
        calc
          rootPolynomial n
              = (∏ i ∈ Finset.range j, (Polynomial.X - qbarConst (w i))) * g :=
                hdecomp
          _ = (∏ i ∈ Finset.range j, (Polynomial.X - qbarConst (w i)))
                * ((Polynomial.X - qbarConst x) * q) := by rw [← hfact]
          _ = ((∏ i ∈ Finset.range j, (Polynomial.X - qbarConst (w i)))
                * (Polynomial.X - qbarConst x)) * q := by rw [mul_assoc]
          _ = (∏ i ∈ Finset.range (j + 1),
                (Polynomial.X - qbarConst (if i = j then x else w i))) * q := by
              rw [hprodeq]

end Ising2DLambda.AlgebraicEigenvalue
