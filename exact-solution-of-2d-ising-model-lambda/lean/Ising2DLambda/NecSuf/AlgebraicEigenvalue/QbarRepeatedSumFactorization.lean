/-
「同じ元の有限和は、単位元の有限和との積である」の必要十分版。
具体版と同じ帰納法で示す。

必要なのは、有限和の空和と再帰、zero の左吸収、one の左単位元性、右分配則だけである。
加法・積の結合則、加法・積の可換性、加法の逆元、体、代数閉性は使わない。
住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 同じ元の有限和を 1 の有限和との積へ分解するための必要十分な手順。 -/
theorem repeated_sum_factorization_necSuf {M : Type*}
    (zero one : M) (add mul : M → M → M) (sum : M → ℕ → M)
    (hsum_zero : ∀ x : M, sum x 0 = zero)
    (hsum_succ : ∀ (x : M) (n : ℕ), sum x (n + 1) = add (sum x n) x)
    (hzero_mul : ∀ x : M, mul zero x = zero)
    (hone_mul : ∀ x : M, mul one x = x)
    (hadd_mul : ∀ x y z : M, add (mul x z) (mul y z) = mul (add x y) z)
    (a : M) : ∀ n : ℕ, sum a n = mul (sum one n) a := by
  intro n
  induction n with
  | zero =>
      calc
        sum a 0 = zero := hsum_zero a
        _ = mul zero a := (hzero_mul a).symm
        _ = mul (sum one 0) a := by rw [hsum_zero one]
  | succ n ih =>
      calc
        sum a (n + 1) = add (sum a n) a := hsum_succ a n
        _ = add (mul (sum one n) a) a := by rw [ih]
        _ = add (mul (sum one n) a) (mul one a) := by rw [hone_mul a]
        _ = mul (add (sum one n) one) a := hadd_mul (sum one n) one a
        _ = mul (sum one (n + 1)) a := by rw [hsum_succ one n]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
