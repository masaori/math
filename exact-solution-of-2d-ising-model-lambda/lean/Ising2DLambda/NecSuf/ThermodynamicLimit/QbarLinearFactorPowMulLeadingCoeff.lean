/-
「一次因子の冪との積の先頭の係数は、もとの先頭の係数である」の必要十分版。

具体版と同じ手順（j についての帰納法。出発点は 1·C = C と m+0 = m、一歩は
前主張の上界 m+j、(t-ŵ)^{j+1}·C = (t-ŵ)·((t-ŵ)^j·C)、m+(j+1) = (m+j)+1、
一次因子との積の先頭の係数、帰納法の仮定）。
必要なのは可換環だけである（一次式 X - C w に加法の逆元が要り、
一歩で積の可換則を使う）。体・代数閉性は要らない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorLeadingCoeff
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarLinearFactorPowMulCoeffBound

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Polynomial

theorem poly_linear_factor_pow_mul_leading_coeff_necSuf {R : Type*} [CommRing R]
    (w : R) (C : R[X]) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ j : ℕ, ((X - Polynomial.C w) ^ j * C).coeff (m + j) = C.coeff m := by
  intro j
  induction j with
  | zero =>
    calc ((X - Polynomial.C w) ^ 0 * C).coeff (m + 0)
        = (1 * C).coeff (m + 0) := by rw [pow_zero]
      _ = C.coeff (m + 0) := by rw [one_mul]
      _ = C.coeff m := by rw [Nat.add_zero]
  | succ j ih =>
    have hbound : ∀ k, m + j < k → ((X - Polynomial.C w) ^ j * C).coeff k = 0 :=
      poly_linear_factor_pow_mul_coeff_bound_necSuf w C m hC j
    have hstep : (X - Polynomial.C w) ^ (j + 1) * C =
        (X - Polynomial.C w) * ((X - Polynomial.C w) ^ j * C) := by
      rw [pow_succ, mul_comm ((X - Polynomial.C w) ^ j) (X - Polynomial.C w), mul_assoc]
    calc ((X - Polynomial.C w) ^ (j + 1) * C).coeff (m + (j + 1))
        = ((X - Polynomial.C w) ^ (j + 1) * C).coeff ((m + j) + 1) := by rw [Nat.add_assoc]
      _ = ((X - Polynomial.C w) * ((X - Polynomial.C w) ^ j * C)).coeff ((m + j) + 1) := by
          rw [hstep]
      _ = ((X - Polynomial.C w) ^ j * C).coeff (m + j) :=
          AlgebraicEigenvalue.poly_linear_factor_leading_coeff_necSuf w
            ((X - Polynomial.C w) ^ j * C) (m + j) hbound
      _ = C.coeff m := ih

end Ising2DLambda.NecSuf.ThermodynamicLimit
