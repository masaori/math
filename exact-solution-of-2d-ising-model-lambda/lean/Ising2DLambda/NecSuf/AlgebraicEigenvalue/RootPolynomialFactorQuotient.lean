/-
「因数定理の商は冪の差の商に等しい」の必要十分版。

必要なのは、有限和の指定した 1 項が目的の値であり、同じ範囲のほかの項がすべて零元であることだけ。
多項式・係数・評価・積・体・代数閉性は使わない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 有限和の 1 項だけが残るとき、その和は残った項の値に等しい。 -/
theorem single_term_sum_necSuf {M : Type*} [AddCommMonoid M]
    (term : ℕ → M) (n : ℕ) (value : M)
    (hmain : term n = value)
    (hother : ∀ k ∈ Finset.range (n + 1), k ≠ n → term k = 0) :
    ∑ k ∈ Finset.range (n + 1), term k = value := by
  rw [Finset.sum_eq_single n hother (by simp), hmain]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
