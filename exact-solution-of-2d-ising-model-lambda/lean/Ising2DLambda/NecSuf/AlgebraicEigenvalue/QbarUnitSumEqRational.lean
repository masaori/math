/-
「単位元の有限和は、自然数の与える有理数に等しい」の必要十分版。
具体版と同じ帰納法で示す。

必要なのは、有限和の空和と再帰（sum 0 = zero、sum (n+1) = add (sum n) one）、および
自然数を値の側へ送る写像の 2 つの再帰式（cast 0 = zero、cast (n+1) = add (cast n) one）
だけである。すなわちこの等式は「両辺が同じ再帰を満たすこと」そのものであり、
加法の結合則・可換性、積、単位元・零元であること、体、部分体、代数閉性は一切使わない。
住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 単位元の有限和を自然数の像と同定するための必要十分な手順。 -/
theorem unit_sum_eq_rational_necSuf {M : Type*}
    (zero one : M) (add : M → M → M) (sum : ℕ → M) (cast : ℕ → M)
    (hsum_zero : sum 0 = zero)
    (hsum_succ : ∀ n : ℕ, sum (n + 1) = add (sum n) one)
    (hcast_zero : cast 0 = zero)
    (hcast_succ : ∀ n : ℕ, cast (n + 1) = add (cast n) one) :
    ∀ n : ℕ, sum n = cast n := by
  intro n
  induction n with
  | zero =>
      calc
        sum 0 = zero := hsum_zero
        _ = cast 0 := hcast_zero.symm
  | succ n ih =>
      calc
        sum (n + 1) = add (sum n) one := hsum_succ n
        _ = add (cast n) one := by rw [ih]
        _ = cast (n + 1) := (hcast_succ n).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
