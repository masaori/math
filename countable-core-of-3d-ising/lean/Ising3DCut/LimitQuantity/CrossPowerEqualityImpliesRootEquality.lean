/-
「有限箱値の交差べき等式は正の乗根の一致を決める」の Lean 具体版。

本文と同じく、正の実数 `A`, `B` と正の自然数 `N`, `M` について、
`A ^ M = B ^ N` から `posRoot A N = posRoot B M` を示す。
証明は二つの乗根の `N * M` 乗を本文と同じ順に計算し、最後に正の実数上の
正の自然数乗の単射性を使う。極限は使わない。
-/
import Ising3DCut.LimitQuantity.PositiveRealRootUnique

namespace Ising3DCut.LimitQuantity

/-- 交差べき等式 `A ^ M = B ^ N` は正の乗根の一致を決める。 -/
theorem cross_power_equality_implies_posRoot_equality
    (A B : ℝ) (hA : 0 < A) (hB : 0 < B)
    (N M : ℕ) (hN : N ≠ 0) (hM : M ≠ 0)
    (hcross : A ^ M = B ^ N) :
    posRoot A N = posRoot B M := by
  let x := posRoot A N
  let y := posRoot B M
  have hx : 0 < x := posRoot_pos A hA N
  have hy : 0 < y := posRoot_pos B hB M
  have hxN : x ^ N = A := posRoot_pow A hA N hN
  have hyM : y ^ M = B := posRoot_pow B hB M hM
  have hpowers : x ^ (N * M) = y ^ (N * M) := by
    calc
      x ^ (N * M) = (x ^ N) ^ M := by rw [pow_mul]
      _ = A ^ M := by rw [hxN]
      _ = B ^ N := hcross
      _ = (y ^ M) ^ N := by rw [hyM]
      _ = y ^ (M * N) := by rw [pow_mul]
      _ = y ^ (N * M) := by rw [Nat.mul_comm]
  have hNM : N * M ≠ 0 := Nat.mul_ne_zero hN hM
  exact (pow_left_inj₀ hx.le hy.le hNM).1 hpowers

end Ising3DCut.LimitQuantity
