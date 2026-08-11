/-
主張「冪の差の因数分解の商の係数は、その番号以上で零である」の必要十分版。
具体版と同じ帰納法を一般の半環係数の多項式で行う。要求するのは和・積の係数と
零元・単位元だけであり、加法の逆元、積の可換性、体、代数閉性は使わない。

住処: ここに ℝ / ℂ は現れない（係数は一般の半環の元、番号は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

/-- 人手証明の一歩で、定数多項式との積の係数を有限和から取り出す段。 -/
theorem coeff_mul_C_necSuf {R : Type*} [Semiring R] (p : R[X]) (a : R) (j : ℕ) :
    (p * C a).coeff j = p.coeff j * a := by
  rw [Polynomial.coeff_mul]
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

/-- 必要十分版の `K_n`。具体版と同じ再帰の約束だけで定める。 -/
noncomputable def powDiffSum_necSuf {R : Type*} [Semiring R] (w : R) : ℕ → R[X]
  | 0 => 0
  | n + 1 => powDiffSum_necSuf w n * C w + X ^ n

/-- 半環係数でも、`n ≤ j` ならば `K_n(w)` の `j` 番目の係数は零である。 -/
theorem pow_diff_sum_coeff_bound_necSuf {R : Type*} [Semiring R]
    (w : R) (n j : ℕ) (h : n ≤ j) :
    (powDiffSum_necSuf w n).coeff j = 0 := by
  induction n generalizing j with
  | zero =>
      rw [powDiffSum_necSuf, Polynomial.coeff_zero]
  | succ n ih =>
      have hjn : j ≠ n := by omega
      have hnj : n ≤ j := by omega
      calc
        (powDiffSum_necSuf w (n + 1)).coeff j
            = (powDiffSum_necSuf w n * C w + X ^ n).coeff j := by
                rw [powDiffSum_necSuf]
        _ = (powDiffSum_necSuf w n * C w).coeff j + ((X : R[X]) ^ n).coeff j :=
              Polynomial.coeff_add _ _ _
        _ = (powDiffSum_necSuf w n * C w).coeff j + 0 := by
              rw [indeterminate_power_coefficient_necSuf]
              simp [hjn]
        _ = (powDiffSum_necSuf w n * C w).coeff j := add_zero _
        _ = (powDiffSum_necSuf w n).coeff j * w := coeff_mul_C_necSuf _ _ _
        _ = 0 * w := by rw [ih j hnj]
        _ = 0 := zero_mul _

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
