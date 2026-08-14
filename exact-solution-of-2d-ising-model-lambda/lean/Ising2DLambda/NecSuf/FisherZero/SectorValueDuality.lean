/-
「セクター多項式の値の双対関係」の必要十分版。
必要なのは可換半環、有限和、各指数の上界、および双対な重みの積の等式だけである。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

theorem sector_value_duality_necSuf
    {R α : Type*} [CommSemiring R] [DecidableEq α]
    (S : Finset α) (total : ℕ) (size : α → ℕ) (common dual : R)
    (hSize : ∀ A ∈ S, size A ≤ total) :
    (∑ A ∈ S, common ^ (total - size A) * (common * dual) ^ size A) =
      common ^ total * ∑ A ∈ S, dual ^ size A := by
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro A hA
  calc
    common ^ (total - size A) * (common * dual) ^ size A =
        common ^ (total - size A) * (common ^ size A * dual ^ size A) := by
      rw [mul_pow]
    _ = common ^ total * dual ^ size A := by
      rw [← mul_assoc, ← pow_add, Nat.sub_add_cancel (hSize A hA)]

end Ising2DLambda.NecSuf.FisherZero
