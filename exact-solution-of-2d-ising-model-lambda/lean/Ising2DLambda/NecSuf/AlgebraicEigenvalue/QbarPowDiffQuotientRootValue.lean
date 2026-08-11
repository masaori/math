/-
「冪の差の因数分解の商の、もとの根における値」の必要十分版。
具体版と同じ帰納法・同じ式変形を、二つの半環、再帰列、定数を送る写像、
不定元、評価写像について書く。必要なのは再帰式と評価写像の保存則だけであり、
多項式・体・代数閉性は使わない。住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 再帰列を評価すると、同じ冪を反復加算した有限和になる。 -/
theorem pow_diff_quotient_root_value_necSuf
    {P R : Type*} [Semiring P] [Semiring R]
    (K : ℕ → P) (c : R → P) (x : P) (φ : P → R) (w : R)
    (hK0 : K 0 = 0)
    (hKs : ∀ n : ℕ, K (n + 1) = K n * c w + x ^ n)
    (hadd : ∀ a b : P, φ (a + b) = φ a + φ b)
    (hmul : ∀ a b : P, φ (a * b) = φ a * φ b)
    (hc : φ (c w) = w)
    (hxpow : ∀ n : ℕ, φ (x ^ n) = w ^ n)
    (n : ℕ) :
    φ (K (n + 1)) = ∑ _i ∈ Finset.range (n + 1), w ^ n := by
  induction n with
  | zero =>
      calc
        φ (K (0 + 1)) = φ (K 0 * c w + x ^ 0) := by rw [hKs]
        _ = φ (0 * c w + x ^ 0) := by rw [hK0]
        _ = φ (0 + x ^ 0) := by rw [zero_mul]
        _ = φ (x ^ 0) := by rw [zero_add]
        _ = w ^ 0 := hxpow 0
        _ = ∑ _i ∈ Finset.range (0 + 1), w ^ 0 := by simp
  | succ n ih =>
      calc
        φ (K ((n + 1) + 1)) = φ (K (n + 1) * c w + x ^ (n + 1)) := by rw [hKs]
        _ = φ (K (n + 1) * c w) + φ (x ^ (n + 1)) := hadd _ _
        _ = φ (K (n + 1)) * φ (c w) + φ (x ^ (n + 1)) := by rw [hmul]
        _ = φ (K (n + 1)) * w + φ (x ^ (n + 1)) := by rw [hc]
        _ = φ (K (n + 1)) * w + w ^ (n + 1) := by rw [hxpow]
        _ = (∑ _i ∈ Finset.range (n + 1), w ^ n) * w + w ^ (n + 1) := by rw [ih]
        _ = (∑ _i ∈ Finset.range (n + 1), w ^ n * w) + w ^ (n + 1) := by
              rw [Finset.sum_mul]
        _ = (∑ _i ∈ Finset.range (n + 1), w ^ (n + 1)) + w ^ (n + 1) := by
              simp only [pow_succ]
        _ = ∑ _i ∈ Finset.range ((n + 1) + 1), w ^ (n + 1) := by
              conv_rhs => rw [Finset.sum_range_succ]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
