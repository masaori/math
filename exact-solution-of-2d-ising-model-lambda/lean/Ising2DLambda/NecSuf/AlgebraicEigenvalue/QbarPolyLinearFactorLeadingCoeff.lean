/-
「一次因子との積の先頭の係数は、もとの先頭の係数である」の必要十分版。

具体版と同じ手順に必要なのは可換環、一次因子との積の係数公式、係数の上界だけである。
体・代数閉性は要らない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

theorem poly_linear_factor_leading_coeff_necSuf {R : Type*} [CommRing R]
    (w : R) (C : R[X]) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ((X - Polynomial.C w) * C).coeff (m + 1) = C.coeff m := by
  have hmul : ((X - Polynomial.C w) * C).coeff (m + 1) =
      C.coeff m + (-w) * C.coeff (m + 1) := by
    simp [sub_mul, Polynomial.coeff_X_mul] <;> ring
  calc
    ((X - Polynomial.C w) * C).coeff (m + 1)
        = C.coeff m + (-w) * C.coeff (m + 1) := hmul
    _ = C.coeff m + (-w) * 0 := by rw [hC (m + 1) (by omega)]
    _ = C.coeff m + 0 := by ring
    _ = C.coeff m := by ring

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
