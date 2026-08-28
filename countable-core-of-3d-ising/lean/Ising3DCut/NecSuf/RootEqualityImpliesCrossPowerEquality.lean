/-
「正の乗根の一致は交差べき等式を決める」の Lean 必要十分版。

具体版が実際に使うのは、一つの元 `x`、二つの自然数べき
`x ^ N = A` と `x ^ M = B`、およびモノイドのべき乗則だけである。
正値性・実数・乗根の一意性・指数の非零性は、この二つの等式を具体側で
供給するためにしか使わない。可換性も要らない。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising3DCut.NecSuf

/-- 一つの元の二つの自然数べきは交差べき等式を満たす。 -/
theorem common_root_implies_cross_power_equality
    {G : Type*} [Monoid G] (x A B : G) (N M : ℕ)
    (hxN : x ^ N = A) (hxM : x ^ M = B) :
    A ^ M = B ^ N := by
  calc
    A ^ M = (x ^ N) ^ M := by rw [hxN]
    _ = x ^ (N * M) := by rw [pow_mul]
    _ = x ^ (M * N) := by rw [Nat.mul_comm]
    _ = (x ^ M) ^ N := by rw [pow_mul]
    _ = B ^ N := by rw [hxM]

end Ising3DCut.NecSuf
