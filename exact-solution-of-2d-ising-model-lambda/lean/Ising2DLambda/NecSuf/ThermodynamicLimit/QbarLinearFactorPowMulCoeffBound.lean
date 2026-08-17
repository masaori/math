/-
「一次因子の冪との積の係数は、上界と指数の和より上の番号で零である」の必要十分版。

具体版と同じ手順（j についての帰納法。出発点は 1·C = C、一歩は
(t-ŵ)^{j+1}·C = (t-ŵ)·((t-ŵ)^j·C) と一次因子との積の係数の上界）。
必要なのは可換環だけである（一次式 X - C w に加法の逆元が要り、
一歩で積の可換則を使う）。体・代数閉性は要らない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorCoeffBound

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Polynomial

theorem poly_linear_factor_pow_mul_coeff_bound_necSuf {R : Type*} [CommRing R]
    (w : R) (C : R[X]) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ j : ℕ, ∀ k, m + j < k → ((X - Polynomial.C w) ^ j * C).coeff k = 0 := by
  intro j
  induction j with
  | zero =>
    intro k hk
    rw [pow_zero, one_mul]
    exact hC k (by omega)
  | succ j ih =>
    intro k hk
    have hstep : (X - Polynomial.C w) ^ (j + 1) * C =
        (X - Polynomial.C w) * ((X - Polynomial.C w) ^ j * C) := by
      rw [pow_succ, mul_comm ((X - Polynomial.C w) ^ j) (X - Polynomial.C w), mul_assoc]
    rw [hstep]
    exact AlgebraicEigenvalue.poly_linear_factor_coeff_bound_necSuf w
      ((X - Polynomial.C w) ^ j * C) (m + j) ih k (by omega)

end Ising2DLambda.NecSuf.ThermodynamicLimit
