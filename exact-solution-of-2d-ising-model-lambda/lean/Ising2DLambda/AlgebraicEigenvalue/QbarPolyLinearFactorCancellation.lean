/-
「一次因子は消去できる」の具体版。
人手証明と同じく、係数を上の番号から下へ辿る帰納法で示す。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- `Qbar[t]` では、一次因子との積が等しい二つの多項式は等しい。 -/
theorem qbarPolyLinearFactorCancellation (w : Qbar) (A B : QbarPoly) (n : ℕ)
    (hA : ∀ k, n < k → A.coeff k = 0)
    (hB : ∀ k, n < k → B.coeff k = 0)
    (hmul : (Polynomial.X - qbarConst w) * A = (Polynomial.X - qbarConst w) * B) : A = B := by
  apply Polynomial.ext
  intro k
  have hP : ∀ j k : ℕ, n + 1 ≤ k + j → A.coeff k = B.coeff k := by
    intro j
    induction j with
    | zero =>
        intro k hk
        have hnk : n < k := by omega
        calc
          A.coeff k = 0 := hA k hnk
          _ = B.coeff k := (hB k hnk).symm
    | succ j ih =>
        intro k hk
        by_cases hprev : n + 1 ≤ k + j
        · exact ih k hprev
        · have hk1 : n + 1 ≤ (k + 1) + j := by omega
          have hcoeff := congrArg (fun p : QbarPoly => p.coeff (k + 1)) hmul
          have hmulA : ((Polynomial.X - qbarConst w) * A).coeff (k + 1) =
              A.coeff k + (-w) * A.coeff (k + 1) := by
            simp [qbarConst, sub_mul, Polynomial.coeff_X_mul] <;> ring
          have hmulB : ((Polynomial.X - qbarConst w) * B).coeff (k + 1) =
              B.coeff k + (-w) * B.coeff (k + 1) := by
            simp [qbarConst, sub_mul, Polynomial.coeff_X_mul] <;> ring
          calc
            A.coeff k
                = (A.coeff k + (-w) * A.coeff (k + 1)) - (-w) * A.coeff (k + 1) := by ring
            _ = ((Polynomial.X - qbarConst w) * A).coeff (k + 1) - (-w) * A.coeff (k + 1) := by rw [hmulA]
            _ = ((Polynomial.X - qbarConst w) * B).coeff (k + 1) - (-w) * A.coeff (k + 1) := by rw [hcoeff]
            _ = ((Polynomial.X - qbarConst w) * B).coeff (k + 1) - (-w) * B.coeff (k + 1) := by rw [ih (k + 1) hk1]
            _ = (B.coeff k + (-w) * B.coeff (k + 1)) - (-w) * B.coeff (k + 1) := by rw [hmulB]
            _ = B.coeff k := by ring
  exact hP (n + 1) k (by omega)

end Ising2DLambda.AlgebraicEigenvalue
