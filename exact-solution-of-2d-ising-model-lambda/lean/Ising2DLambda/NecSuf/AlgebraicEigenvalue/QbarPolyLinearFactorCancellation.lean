/-
「一次因子は消去できる」の必要十分版。

本文と同じく、係数を上の番号から下へ辿る帰納法を行う。必要なのは可換環の
加法の逆元と、一次因子との積の係数公式だけであり、体・代数閉性は要らない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

/-- 可換環上でも、一次因子との積は係数を上から復元できるので消去できる。 -/
theorem poly_linear_factor_cancellation_necSuf {R : Type*} [CommRing R]
    (w : R) (A B : R[X]) (n : ℕ)
    (hA : ∀ k, n < k → A.coeff k = 0)
    (hB : ∀ k, n < k → B.coeff k = 0)
    (hmul : (X - C w) * A = (X - C w) * B) : A = B := by
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
          have hcoeff := congrArg (fun p : R[X] => p.coeff (k + 1)) hmul
          have hmulA : ((X - C w) * A).coeff (k + 1) = A.coeff k + (-w) * A.coeff (k + 1) := by
            simp [sub_mul, Polynomial.coeff_X_mul] <;> ring
          have hmulB : ((X - C w) * B).coeff (k + 1) = B.coeff k + (-w) * B.coeff (k + 1) := by
            simp [sub_mul, Polynomial.coeff_X_mul] <;> ring
          calc
            A.coeff k
                = (A.coeff k + (-w) * A.coeff (k + 1)) - (-w) * A.coeff (k + 1) := by ring
            _ = ((X - C w) * A).coeff (k + 1) - (-w) * A.coeff (k + 1) := by rw [hmulA]
            _ = ((X - C w) * B).coeff (k + 1) - (-w) * A.coeff (k + 1) := by rw [hcoeff]
            _ = ((X - C w) * B).coeff (k + 1) - (-w) * B.coeff (k + 1) := by rw [ih (k + 1) hk1]
            _ = (B.coeff k + (-w) * B.coeff (k + 1)) - (-w) * B.coeff (k + 1) := by rw [hmulB]
            _ = B.coeff k := by ring
  exact hP (n + 1) k (by omega)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
