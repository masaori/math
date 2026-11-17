/-
人手証明の主張「部分体を係数とする多項式は、最高次の係数が零でない多項式で割れる」
（ラベル `claim_subfield_coefficient_polynomial_division`）の具体版。

  人手証明                                        このファイル
  単項式の係数の段（ac_i(ĉ t^m)）                 `qbarPolyCoeffConstMulPow`（既存の具体版）
  単項式を掛けた係数の段（ac_k(ĉ t^m f)）         `subfieldConstMulPowMulCoeff`
  帰納法の主張 P(d)（割る必要のない場合と一歩）   `subfieldCoefficientPolynomialDivision_bound`
  結論（係数の尽きる番号 d を取って P(d) を当てる） `subfieldCoefficientPolynomialDivision`

mathlib の除法（`Polynomial.divByMonic`・`EuclideanDomain`）へは委ねない。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomials
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyMonomialDecomposition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 単項式を掛けた係数の段。`ac_k(ĉ t^m f)` は `m ≤ k` なら `c · ac_{k-m}(f)`、`k < m` なら零元。 -/
theorem subfieldConstMulPowMulCoeff (c : Qbar) (m : ℕ) (f : QbarPoly) (k : ℕ) :
    (qbarConst c * Polynomial.X ^ m * f).coeff k = if m ≤ k then c * f.coeff (k - m) else 0 := by
  -- 第 1 の等号（積の係数の定義）。
  rw [Polynomial.coeff_mul]
  split_ifs with hmk
  · -- m ≤ k: i = m の項を分け、残りの項を単項式の係数の段で零にする。
    rw [Finset.sum_eq_single ((m, k - m) : ℕ × ℕ)]
    · rw [qbarPolyCoeffConstMulPow, if_pos rfl]
    · intro b hb hne
      have hb' : b.1 + b.2 = k := Finset.mem_antidiagonal.mp hb
      have hb1 : b.1 ≠ m := by
        intro h0
        exact hne (Prod.ext h0 (by simp only; omega))
      rw [qbarPolyCoeffConstMulPow, if_neg hb1, zero_mul]
    · intro hnot
      exact absurd (Finset.mem_antidiagonal.mpr (by omega : m + (k - m) = k)) hnot
  · -- k < m: 全ての項で i ≤ k < m なので、単項式の係数の段を各項へ同時に当てる。
    apply Finset.sum_eq_zero
    intro b hb
    have hb' : b.1 + b.2 = k := Finset.mem_antidiagonal.mp hb
    have hb1 : b.1 ≠ m := by omega
    rw [qbarPolyCoeffConstMulPow, if_neg hb1, zero_mul]

/-- 帰納法の主張 `P(d)`: 番号 `d` 以上の係数が零の `g ∈ F[t]` は `h` で割れる（`d` についての帰納法）。 -/
theorem subfieldCoefficientPolynomialDivision_bound (F : Subfield Qbar) (h : QbarPoly) (n : ℕ)
    (hh : h ∈ subfieldCoefficientPolynomials F) (hn : h.coeff n ≠ 0)
    (htop : ∀ k : ℕ, n < k → h.coeff k = 0) (d : ℕ) :
    ∀ g : QbarPoly, g ∈ subfieldCoefficientPolynomials F → (∀ k : ℕ, d ≤ k → g.coeff k = 0) →
      ∃ u r : QbarPoly, u ∈ subfieldCoefficientPolynomials F ∧ r ∈ subfieldCoefficientPolynomials F ∧
        g = u * h + r ∧ ∀ k : ℕ, n ≤ k → r.coeff k = 0 := by
  -- 割る必要のない場合（e ≤ n）: u := 0、r := g。
  have noDivision : ∀ e : ℕ, e ≤ n → ∀ g : QbarPoly, g ∈ subfieldCoefficientPolynomials F →
      (∀ k : ℕ, e ≤ k → g.coeff k = 0) →
      ∃ u r : QbarPoly, u ∈ subfieldCoefficientPolynomials F ∧ r ∈ subfieldCoefficientPolynomials F ∧
        g = u * h + r ∧ ∀ k : ℕ, n ≤ k → r.coeff k = 0 := by
    intro e he g hg hgz
    refine ⟨0, g, fun k => ?_, hg, ?_, fun k hk => hgz k (le_trans he hk)⟩
    · rw [Polynomial.coeff_zero]
      exact F.zero_mem
    · rw [zero_mul, zero_add]
  induction d with
  | zero => exact noDivision 0 (Nat.zero_le n)
  | succ d ih =>
    intro g hg hgz
    by_cases hdn : d + 1 ≤ n
    · exact noDivision (d + 1) hdn g hg hgz
    · -- 帰納法の一歩（d ≥ n）。c := ac_d(g) / ac_n(h)、m := d - n、g' := g - ĉ t^m h。
      have hnd : n ≤ d := by omega
      have hcF : g.coeff d / h.coeff n ∈ F := F.div_mem (hg d) (hh n)
      have hsF : qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n)
          ∈ subfieldCoefficientPolynomials F := by
        intro i
        rw [qbarPolyCoeffConstMulPow]
        split_ifs
        · exact hcF
        · exact F.zero_mem
      have hg'coeff : ∀ k : ℕ,
          (g - qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n) * h).coeff k
            = g.coeff k - (if d - n ≤ k then g.coeff d / h.coeff n * h.coeff (k - (d - n)) else 0) := by
        intro k
        rw [Polynomial.coeff_sub, subfieldConstMulPowMulCoeff]
      have hg'F : g - qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n) * h
          ∈ subfieldCoefficientPolynomials F := by
        intro k
        rw [hg'coeff]
        split_ifs
        · exact F.sub_mem (hg k) (F.mul_mem hcF (hh _))
        · exact F.sub_mem (hg k) F.zero_mem
      have hg'z : ∀ k : ℕ, d ≤ k →
          (g - qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n) * h).coeff k = 0 := by
        intro k hk
        rcases Nat.lt_or_ge d k with hlt | hle
        · -- k ≥ d + 1: 0 - c · 0 = 0
          rw [hg'coeff, if_pos (by omega), hgz k hlt, htop (k - (d - n)) (by omega), mul_zero,
            sub_zero]
        · -- k = d: ac_d(g) - (ac_d(g) / ac_n(h)) · ac_n(h) = 0
          have hkd : k = d := le_antisymm hle hk
          rw [hg'coeff, if_pos (by omega), show k - (d - n) = n by omega, hkd,
            div_mul_cancel₀ _ hn, sub_self]
      obtain ⟨u', r, hu'F, hrF, hg'eq, hrz⟩ := ih _ hg'F hg'z
      refine ⟨u' + qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n), r, ?_, hrF, ?_, hrz⟩
      · intro k
        rw [Polynomial.coeff_add]
        exact F.add_mem (hu'F k) (hsF k)
      · calc g = (g - qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n) * h)
                + qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n) * h :=
              (sub_add_cancel _ _).symm
          _ = u' * h + r + qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n) * h := by
              rw [← hg'eq]
          _ = (u' + qbarConst (g.coeff d / h.coeff n) * Polynomial.X ^ (d - n)) * h + r := by
              rw [add_mul, add_right_comm]

/-- `claim_subfield_coefficient_polynomial_division` の具体版。係数の尽きる番号として
`natDegree g + 1` を取り、`P(d)` を当てる。 -/
theorem subfieldCoefficientPolynomialDivision (F : Subfield Qbar) (h : QbarPoly) (n : ℕ)
    (hh : h ∈ subfieldCoefficientPolynomials F) (hn : h.coeff n ≠ 0)
    (htop : ∀ k : ℕ, n < k → h.coeff k = 0) (g : QbarPoly)
    (hg : g ∈ subfieldCoefficientPolynomials F) :
    ∃ u r : QbarPoly, u ∈ subfieldCoefficientPolynomials F ∧ r ∈ subfieldCoefficientPolynomials F ∧
      g = u * h + r ∧ ∀ k : ℕ, n ≤ k → r.coeff k = 0 :=
  subfieldCoefficientPolynomialDivision_bound F h n hh hn htop (g.natDegree + 1) g hg
    (fun _ hk => Polynomial.coeff_eq_zero_of_natDegree_lt (by omega))

end Ising2DLambda.FisherZero
