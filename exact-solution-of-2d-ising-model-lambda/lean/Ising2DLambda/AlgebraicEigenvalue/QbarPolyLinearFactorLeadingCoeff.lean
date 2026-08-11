/-
「一次因子との積の先頭の係数は、もとの先頭の係数である」の具体版。
人手証明と同じく一次因子との積の係数を開き、上の番号の係数を零にする。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem qbarPolyLinearFactorLeadingCoeff (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ((Polynomial.X - qbarConst w) * C).coeff (m + 1) = C.coeff m := by
  have hmul : ((Polynomial.X - qbarConst w) * C).coeff (m + 1) =
      C.coeff m + (-w) * C.coeff (m + 1) := by
    simp [qbarConst, sub_mul, Polynomial.coeff_X_mul] <;> ring
  calc
    ((Polynomial.X - qbarConst w) * C).coeff (m + 1)
        = C.coeff m + (-w) * C.coeff (m + 1) := hmul
    _ = C.coeff m + (-w) * 0 := by rw [hC (m + 1) (by omega)]
    _ = C.coeff m + 0 := by ring
    _ = C.coeff m := by ring

end Ising2DLambda.AlgebraicEigenvalue
