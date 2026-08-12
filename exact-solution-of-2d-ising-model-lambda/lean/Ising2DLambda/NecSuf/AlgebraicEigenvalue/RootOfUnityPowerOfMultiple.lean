/-
主張「指数が根の次数の倍数ならば 1 の冪根の冪は 1 である」の必要十分版。

具体版と同じ 3 段の鎖だけを残す。値の型には単位元と自然数冪の記号だけを要求し、
必要な冪の法則・根の条件・単位元の冪を個別の仮定として受け取る。
加法・零元・積の演算そのもの・分配則・体・代数閉性は不要である。

住処: 一般の型。ここに ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- `w ^ (n * k) = (w ^ n) ^ k`、`w ^ n = 1`、`1 ^ k = 1` だけから
`w ^ (n * k) = 1` を得る。 -/
theorem power_multiple_eq_one_necSuf {M : Type*} [One M] [Pow M ℕ]
    {w : M} {n k : ℕ} (hpow_mul : w ^ (n * k) = (w ^ n) ^ k)
    (hroot : w ^ n = 1) (hone_pow : (1 : M) ^ k = 1) : w ^ (n * k) = 1 := by
  calc w ^ (n * k) = (w ^ n) ^ k := hpow_mul
    _ = 1 ^ k := by rw [hroot]
    _ = 1 := hone_pow

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
