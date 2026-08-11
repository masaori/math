/-
章「固有値の代数性」の「冪の差の因数分解の商の係数は、その番号以上で零である」の具体版。
人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_qbar_pow_diff_sum_coeff_bound` である。

`Polynomial.coeff_mul_C` や次数についての既製定理へは委ねない。定数多項式との積の係数も、
人手証明と同じく積の係数の有限和から `i = j` の項を取り出して示す。

住処: Qbar。ここに ℝ / ℂ は現れない（係数は ℚ の代数閉包の元、番号は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の一歩で、定数多項式との積の係数を有限和から取り出す段。 -/
theorem qbarPolyCoeffMulConst (p : QbarPoly) (a : Qbar) (j : ℕ) :
    (p * qbarConst a).coeff j = p.coeff j * a := by
  rw [qbarConst, Polynomial.coeff_mul]
  rw [Finset.sum_eq_single ((j, 0) : ℕ × ℕ)]
  · simp
  · intro b hb hne
    have hb' : b.1 + b.2 = j := Finset.mem_antidiagonal.mp hb
    have hb2 : b.2 ≠ 0 := by
      intro h0
      apply hne
      have hb1 : b.1 = j := by omega
      exact Prod.ext hb1 h0
    simp only [Polynomial.coeff_C, if_neg hb2, mul_zero]
  · intro h
    exact absurd (Finset.mem_antidiagonal.mpr (by omega : j + 0 = j)) h

/-- `n ≤ j` ならば `K_n(w)` の `j` 番目の係数は零である。 -/
theorem qbarPowDiffSumCoeffBound (w : Qbar) (n j : ℕ) (h : n ≤ j) :
    (qbarPolyPowDiffSum w n).coeff j = 0 := by
  induction n generalizing j with
  | zero =>
      rw [qbarPolyPowDiffSum, Polynomial.coeff_zero]
  | succ n ih =>
      have hjn : j ≠ n := by omega
      have hnj : n ≤ j := by omega
      calc
        (qbarPolyPowDiffSum w (n + 1)).coeff j
            = (qbarPolyPowDiffSum w n * qbarConst w + Polynomial.X ^ n).coeff j := by
                rw [qbarPolyPowDiffSum]
        _ = (qbarPolyPowDiffSum w n * qbarConst w).coeff j
              + ((Polynomial.X : QbarPoly) ^ n).coeff j := Polynomial.coeff_add _ _ _
        _ = (qbarPolyPowDiffSum w n * qbarConst w).coeff j + 0 := by
              rw [qbarPolyIndeterminatePowerCoefficient]
              simp [hjn]
        _ = (qbarPolyPowDiffSum w n * qbarConst w).coeff j := add_zero _
        _ = (qbarPolyPowDiffSum w n).coeff j * w := qbarPolyCoeffMulConst _ _ _
        _ = 0 * w := by rw [ih j hnj]
        _ = 0 := zero_mul _

end Ising2DLambda.AlgebraicEigenvalue
