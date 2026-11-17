/-
「部分体を係数とする多項式は、最高次の係数が零でない多項式で割れる」の必要十分版。

具体版と同じ段（単項式の係数、単項式を掛けた係数、係数の尽きる番号 `d` についての帰納法、結論）で示す。
部分集合 `S` について使うのは、零元を含むこと、和・差・積で閉じること、零でない元による商で閉じることだけである。
単位元を含むこと・符号反転・逆元の閉性は使わない。
台は除法環であれば足りる。最高次の係数 `ac_n(h)` で割った `c` が `c · ac_n(h) = ac_d(g)` を満たすことにだけ
除法を使い（`div_mul_cancel₀`）、積の可換性は使わない（単項式は `h` の左から掛ける）。
単項式の係数の段と単項式を掛けた係数の段は、半環の多項式で成り立つ。
`h` の最高次の番号より上の係数が零であることは、`k ≥ d + 1` で `g'` の係数が消える段に要る。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient
import Mathlib.Algebra.Polynomial.Degree.Operations

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

/-- 単項式の係数の段（具体版 `qbarPolyCoeffConstMulPow` と同じ段）。 -/
theorem constMulPowCoeff_necSuf {K : Type*} [Semiring K] (c : K) (m i : ℕ) :
    (C c * X ^ m : K[X]).coeff i = if i = m then c else 0 := by
  rw [Polynomial.coeff_mul, Finset.sum_eq_single ((0, i) : ℕ × ℕ)]
  · rw [Polynomial.coeff_C_zero,
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.indeterminate_power_coefficient_necSuf]
    by_cases hi : i = m
    · simp [hi]
    · simp [hi]
  · intro b hb hne
    have hb' : b.1 + b.2 = i := Finset.mem_antidiagonal.mp hb
    have hb1 : b.1 ≠ 0 := by
      intro h0
      exact hne (Prod.ext h0 (by simp only; omega))
    simp only [Polynomial.coeff_C, if_neg hb1, zero_mul]
  · intro hnot
    exact absurd (Finset.mem_antidiagonal.mpr (by omega : 0 + i = i)) hnot

/-- 単項式を掛けた係数の段（具体版 `subfieldConstMulPowMulCoeff` と同じ段）。 -/
theorem constMulPowMulCoeff_necSuf {K : Type*} [Semiring K] (c : K) (m : ℕ) (f : K[X]) (k : ℕ) :
    (C c * X ^ m * f).coeff k = if m ≤ k then c * f.coeff (k - m) else 0 := by
  rw [Polynomial.coeff_mul]
  split_ifs with hmk
  · rw [Finset.sum_eq_single ((m, k - m) : ℕ × ℕ)]
    · rw [constMulPowCoeff_necSuf, if_pos rfl]
    · intro b hb hne
      have hb' : b.1 + b.2 = k := Finset.mem_antidiagonal.mp hb
      have hb1 : b.1 ≠ m := by
        intro h0
        exact hne (Prod.ext h0 (by simp only; omega))
      rw [constMulPowCoeff_necSuf, if_neg hb1, zero_mul]
    · intro hnot
      exact absurd (Finset.mem_antidiagonal.mpr (by omega : m + (k - m) = k)) hnot
  · apply Finset.sum_eq_zero
    intro b hb
    have hb' : b.1 + b.2 = k := Finset.mem_antidiagonal.mp hb
    have hb1 : b.1 ≠ m := by omega
    rw [constMulPowCoeff_necSuf, if_neg hb1, zero_mul]

/-- 帰納法の主張 `P(d)`（具体版 `subfieldCoefficientPolynomialDivision_bound` と同じ段）。 -/
theorem polynomialDivision_bound_necSuf {K : Type*} [DivisionRing K] (S : Set K)
    (h0 : (0 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S)
    (h : K[X]) (n : ℕ) (hh : ∀ k : ℕ, h.coeff k ∈ S) (hn : h.coeff n ≠ 0)
    (htop : ∀ k : ℕ, n < k → h.coeff k = 0) (d : ℕ) :
    ∀ g : K[X], (∀ k : ℕ, g.coeff k ∈ S) → (∀ k : ℕ, d ≤ k → g.coeff k = 0) →
      ∃ u r : K[X], (∀ k : ℕ, u.coeff k ∈ S) ∧ (∀ k : ℕ, r.coeff k ∈ S) ∧
        g = u * h + r ∧ ∀ k : ℕ, n ≤ k → r.coeff k = 0 := by
  have noDivision : ∀ e : ℕ, e ≤ n → ∀ g : K[X], (∀ k : ℕ, g.coeff k ∈ S) →
      (∀ k : ℕ, e ≤ k → g.coeff k = 0) →
      ∃ u r : K[X], (∀ k : ℕ, u.coeff k ∈ S) ∧ (∀ k : ℕ, r.coeff k ∈ S) ∧
        g = u * h + r ∧ ∀ k : ℕ, n ≤ k → r.coeff k = 0 := by
    intro e he g hg hgz
    refine ⟨0, g, fun k => ?_, hg, ?_, fun k hk => hgz k (le_trans he hk)⟩
    · rw [Polynomial.coeff_zero]
      exact h0
    · rw [zero_mul, zero_add]
  induction d with
  | zero => exact noDivision 0 (Nat.zero_le n)
  | succ d ih =>
    intro g hg hgz
    by_cases hdn : d + 1 ≤ n
    · exact noDivision (d + 1) hdn g hg hgz
    · have hnd : n ≤ d := by omega
      have hcF : g.coeff d / h.coeff n ∈ S := hdiv _ _ (hg d) (hh n)
      have hsF : ∀ i : ℕ, (C (g.coeff d / h.coeff n) * X ^ (d - n) : K[X]).coeff i ∈ S := by
        intro i
        rw [constMulPowCoeff_necSuf]
        split_ifs
        · exact hcF
        · exact h0
      have hg'coeff : ∀ k : ℕ,
          (g - C (g.coeff d / h.coeff n) * X ^ (d - n) * h).coeff k
            = g.coeff k - (if d - n ≤ k then g.coeff d / h.coeff n * h.coeff (k - (d - n)) else 0) := by
        intro k
        rw [Polynomial.coeff_sub, constMulPowMulCoeff_necSuf]
      have hg'F : ∀ k : ℕ, (g - C (g.coeff d / h.coeff n) * X ^ (d - n) * h).coeff k ∈ S := by
        intro k
        rw [hg'coeff]
        split_ifs
        · exact hsub _ _ (hg k) (hmul _ _ hcF (hh _))
        · exact hsub _ _ (hg k) h0
      have hg'z : ∀ k : ℕ, d ≤ k → (g - C (g.coeff d / h.coeff n) * X ^ (d - n) * h).coeff k = 0 := by
        intro k hk
        rcases Nat.lt_or_ge d k with hlt | hle
        · rw [hg'coeff, if_pos (by omega), hgz k hlt, htop (k - (d - n)) (by omega), mul_zero,
            sub_zero]
        · have hkd : k = d := le_antisymm hle hk
          rw [hg'coeff, if_pos (by omega), show k - (d - n) = n by omega, hkd,
            div_mul_cancel₀ _ hn, sub_self]
      obtain ⟨u', r, hu'F, hrF, hg'eq, hrz⟩ := ih _ hg'F hg'z
      refine ⟨u' + C (g.coeff d / h.coeff n) * X ^ (d - n), r, ?_, hrF, ?_, hrz⟩
      · intro k
        rw [Polynomial.coeff_add]
        exact hadd _ _ (hu'F k) (hsF k)
      · calc g = (g - C (g.coeff d / h.coeff n) * X ^ (d - n) * h)
                + C (g.coeff d / h.coeff n) * X ^ (d - n) * h := (sub_add_cancel _ _).symm
          _ = u' * h + r + C (g.coeff d / h.coeff n) * X ^ (d - n) * h := by rw [← hg'eq]
          _ = (u' + C (g.coeff d / h.coeff n) * X ^ (d - n)) * h + r := by
              rw [add_mul, add_right_comm]

/-- 必要十分版の結論（具体版 `subfieldCoefficientPolynomialDivision` と同じ段）。 -/
theorem polynomialDivision_necSuf {K : Type*} [DivisionRing K] (S : Set K)
    (h0 : (0 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S)
    (h : K[X]) (n : ℕ) (hh : ∀ k : ℕ, h.coeff k ∈ S) (hn : h.coeff n ≠ 0)
    (htop : ∀ k : ℕ, n < k → h.coeff k = 0) (g : K[X]) (hg : ∀ k : ℕ, g.coeff k ∈ S) :
    ∃ u r : K[X], (∀ k : ℕ, u.coeff k ∈ S) ∧ (∀ k : ℕ, r.coeff k ∈ S) ∧
      g = u * h + r ∧ ∀ k : ℕ, n ≤ k → r.coeff k = 0 :=
  polynomialDivision_bound_necSuf S h0 hadd hsub hmul hdiv h n hh hn htop (g.natDegree + 1) g hg
    (fun _ hk => Polynomial.coeff_eq_zero_of_natDegree_lt (by omega))

end Ising2DLambda.NecSuf.FisherZero
