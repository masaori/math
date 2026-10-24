/- 代数的数係数多項式の零積性。本文と同じ最小非零係数の論法。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors
import Lean.Elab.Tactic.Omega
import Mathlib.Algebra.BigOperators.NatAntidiagonal

namespace Ising2DLambda.AlgebraicEigenvalue

/-- `claim_qbar_polynomial_zero_product` の具体版。 -/
theorem qbarPolynomial_zero_product (f g : QbarPoly) (hfg : f * g = 0) :
    f = 0 ∨ g = 0 := by
  classical
  by_cases hf : f = 0
  · exact Or.inl hf
  by_cases hg : g = 0
  · exact Or.inr hg
  exfalso
  -- 多項式の係数による等号から、非零係数の添字が存在する。
  have hfex : ∃ k : ℕ, f.coeff k ≠ 0 := by
    by_contra h
    apply hf
    ext k
    simpa using (not_exists.mp h k)
  have hgex : ∃ k : ℕ, g.coeff k ≠ 0 := by
    by_contra h
    apply hg
    ext k
    simpa using (not_exists.mp h k)
  -- 最小の非零係数より前は、すべて零である。
  let m := Nat.find hfex
  let n := Nat.find hgex
  have hm : f.coeff m ≠ 0 := Nat.find_spec hfex
  have hn : g.coeff n ≠ 0 := Nat.find_spec hgex
  have hbeforeF : ∀ i, i < m → f.coeff i = 0 := by
    intro i hi
    by_contra hne
    exact Nat.find_min hfex hi hne
  have hbeforeG : ∀ j, j < n → g.coeff j = 0 := by
    intro j hj
    by_contra hne
    exact Nat.find_min hgex hj hne
  -- i+j=m+n の非主項では i<m または j<n となり、係数積が零になる。
  have hoff : ∀ p ∈ Finset.antidiagonal (m + n), p ≠ (m, n) →
      f.coeff p.1 * g.coeff p.2 = 0 := by
    rintro ⟨i, j⟩ hij hne
    have hsum : i + j = m + n := by simpa using hij
    by_cases hi : i < m
    · calc
        f.coeff i * g.coeff j = 0 * g.coeff j := by rw [hbeforeF i hi]
        _ = 0 := zero_mul _
    · have hmi : m ≤ i := Nat.le_of_not_gt hi
      have hneI : i ≠ m := by
        intro heq
        have heqJ : j = n := by omega
        exact hne (Prod.ext heq heqJ)
      have hstrict : m < i := by omega
      have hsumStrict : m + j < i + j := Nat.add_lt_add_right hstrict j
      have hsumBound : m + j < m + n := by rw [hsum] at hsumStrict; exact hsumStrict
      have hj : j < n := Nat.lt_of_add_lt_add_left hsumBound
      calc
        f.coeff i * g.coeff j = f.coeff i * 0 := by rw [hbeforeG j hj]
        _ = 0 := mul_zero _
  -- Cauchy 積の有限和を一項へ縮める。coeff_mul は積の定義との橋だけに使う。
  have hcoefficient : (f * g).coeff (m + n) = f.coeff m * g.coeff n := by
    calc
      (f * g).coeff (m + n) =
          ∑ i ∈ Finset.range (m + n + 1), f.coeff i * g.coeff (m + n - i) := by
        rw [Polynomial.coeff_mul, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
      _ = ∑ p ∈ Finset.antidiagonal (m + n), f.coeff p.1 * g.coeff p.2 :=
        (Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk
          (fun p => f.coeff p.1 * g.coeff p.2) (m + n)).symm
      _ = f.coeff m * g.coeff n :=
        Finset.sum_eq_single_of_mem (m, n) (by simp) hoff
  -- 仮定 f*g=0 の係数は零だが、上の二つの係数の積は非零である。
  have hzero : (f * g).coeff (m + n) = 0 := by
    calc
      (f * g).coeff (m + n) = (0 : Polynomial _).coeff (m + n) := by rw [hfg]
      _ = 0 := Polynomial.coeff_zero (m + n)
  exact hn (qbarNoZeroDivisors hm (hcoefficient.symm.trans hzero))

end Ising2DLambda.AlgebraicEigenvalue
