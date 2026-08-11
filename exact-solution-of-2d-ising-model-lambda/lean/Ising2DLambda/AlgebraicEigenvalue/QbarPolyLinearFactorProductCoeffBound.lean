/-
「一次因子の積の係数は、因子の個数より上の番号で零である」の具体版。
人手証明と同じく因子の個数 m について帰納する。出発点は空積、
一歩は積の最後の因子を交換則で先頭へ移し、一次因子との積の係数上界を当てる。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

/-- `m` 個の一次因子の積の係数は、番号 `m` で尽きる。 -/
theorem qbarPolyLinearFactorProductCoeffBound (w : ℕ → Qbar) :
    ∀ m k : ℕ, m < k →
      (∏ i ∈ Finset.range m, (Polynomial.X - qbarConst (w i))).coeff k = 0 := by
  intro m
  induction m with
  | zero =>
      intro k hk
      simp [Polynomial.coeff_one, Nat.ne_of_gt hk]
  | succ m ih =>
      intro k hk
      rw [Finset.prod_range_succ, mul_comm]
      exact qbarPolyLinearFactorCoeffBound (w m)
        (∏ i ∈ Finset.range m, (Polynomial.X - qbarConst (w i))) m ih k (by omega)

end Ising2DLambda.AlgebraicEigenvalue
