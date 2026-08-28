/-
「正の乗根の一致は交差べき等式を決める」の Lean 具体版。

本文 `claim_root_equality_implies_cross_power_equality` と同じく、正の実数 `A`, `B` と
正の自然数 `N`, `M` について、乗根の一致 `posRoot A N = posRoot B M` から
`A ^ M = B ^ N` を示す。人手証明と同じ順に、`x := posRoot A N` と置いて
`x ^ N = A`、仮定から `x ^ M = B` を取り、`A ^ M` を五つの等号で `B ^ N` まで運ぶ。
逆向きは `CrossPowerEqualityImpliesRootEquality.lean` にあり、合わせて同値になる。
極限は使わない。
-/
import Ising3DCut.LimitQuantity.PositiveRealRootUnique

namespace Ising3DCut.LimitQuantity

/-- 正の乗根の一致 `posRoot A N = posRoot B M` は交差べき等式 `A ^ M = B ^ N` を決める。 -/
theorem posRoot_equality_implies_cross_power_equality
    (A B : ℝ) (hA : 0 < A) (hB : 0 < B)
    (N M : ℕ) (hN : N ≠ 0) (hM : M ≠ 0)
    (hroot : posRoot A N = posRoot B M) :
    A ^ M = B ^ N := by
  let x := posRoot A N
  have hxN : x ^ N = A := posRoot_pow A hA N hN
  have hxM : x ^ M = B := by
    show posRoot A N ^ M = B
    rw [hroot]
    exact posRoot_pow B hB M hM
  calc
    A ^ M = (x ^ N) ^ M := by rw [hxN]
    _ = x ^ (N * M) := by rw [pow_mul]
    _ = x ^ (M * N) := by rw [Nat.mul_comm]
    _ = (x ^ M) ^ N := by rw [pow_mul]
    _ = B ^ N := by rw [hxM]

end Ising3DCut.LimitQuantity
