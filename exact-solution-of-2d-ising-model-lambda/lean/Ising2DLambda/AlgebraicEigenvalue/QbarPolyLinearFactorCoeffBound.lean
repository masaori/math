/-
「一次因子との積の係数は、上の番号で零である」の具体版。
人手証明と同じく、積の係数を番号 k = k' + 1 で開き、C の係数の仮定
（k' > m と k' + 1 > m）で両方の項を消す。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCancellation

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- `Qbar[t]` では、係数が番号 `m` で尽きる多項式に一次因子を掛けても、
係数は番号 `m + 1` で尽きる。 -/
theorem qbarPolyLinearFactorCoeffBound (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ k, m + 1 < k → ((Polynomial.X - qbarConst w) * C).coeff k = 0 := by
  intro k hk
  -- k > m + 1 ≥ 1 なので k は後続者である
  obtain ⟨k', rfl⟩ : ∃ k', k = k' + 1 := ⟨k - 1, by omega⟩
  -- 人手証明の「一次因子との積の係数」（d4b1 の準備と同じ公式）
  have hmul : ((Polynomial.X - qbarConst w) * C).coeff (k' + 1) =
      C.coeff k' + (-w) * C.coeff (k' + 1) := by
    simp [qbarConst, sub_mul, Polynomial.coeff_X_mul] <;> ring
  calc
    ((Polynomial.X - qbarConst w) * C).coeff (k' + 1)
        = C.coeff k' + (-w) * C.coeff (k' + 1) := hmul
    _ = 0 + (-w) * C.coeff (k' + 1) := by rw [hC k' (by omega)]
    _ = 0 + (-w) * 0 := by rw [hC (k' + 1) (by omega)]
    _ = 0 := by ring

end Ising2DLambda.AlgebraicEigenvalue
