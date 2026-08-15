/-
「開境界正方形のブロック敷き詰め評価」の必要十分版。

二方向の反復接合の合成で実際に使うものだけを残す。第一方向で `z^k` を `x` の上下から
挟み、その不等式を k 乗し、第二方向で `x^k` を `y` の上下から挟む。格子・配位・実数は
使わない。冪が順序を保つことも、具体版と同じく指数についての帰納法で示す。

`CommSemiring` が要るのは帰納段の積の順序を揃えるためである。`PartialOrder` と
`IsOrderedRing` は非負元の乗法が順序を保つことにだけ使い、全順序は使わない。
-/
import Mathlib.Algebra.Order.Ring.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

private lemma pow_le_pow_of_nonneg_of_le_by_induction
    {K : Type*} [Semiring K] [PartialOrder K] [IsOrderedRing K]
    {x y : K} (hx0 : 0 ≤ x) (hxy : x ≤ y) :
    ∀ n : ℕ, x ^ n ≤ y ^ n := by
  intro n
  induction n with
  | zero =>
      rw [pow_zero, pow_zero]
  | succ n ih =>
      rw [pow_succ, pow_succ]
      exact mul_le_mul ih hxy hx0 (pow_nonneg (le_trans hx0 hxy) n)

/-- 二方向の冪評価を順に合成する。証明手順は具体版と同じである。 -/
theorem two_direction_pow_bounds_necSuf
    {K : Type*} [CommSemiring K] [PartialOrder K] [IsOrderedRing K]
    (z x y lowerFirst upperFirst lowerSecond upperSecond : K) (k : ℕ)
    (hz0 : 0 ≤ z) (hx0 : 0 ≤ x)
    (hlf0 : 0 ≤ lowerFirst) (hls0 : 0 ≤ lowerSecond) (hus0 : 0 ≤ upperSecond)
    (hfirst : lowerFirst * z ^ k ≤ x ∧ x ≤ upperFirst * z ^ k)
    (hsecond : lowerSecond * x ^ k ≤ y ∧ y ≤ upperSecond * x ^ k) :
    lowerSecond * (lowerFirst * z ^ k) ^ k ≤ y ∧
      y ≤ upperSecond * (upperFirst * z ^ k) ^ k := by
  have hlowerPow : (lowerFirst * z ^ k) ^ k ≤ x ^ k :=
    pow_le_pow_of_nonneg_of_le_by_induction (mul_nonneg hlf0 (pow_nonneg hz0 k)) hfirst.1 k
  have hupperPow : x ^ k ≤ (upperFirst * z ^ k) ^ k :=
    pow_le_pow_of_nonneg_of_le_by_induction hx0 hfirst.2 k
  constructor
  · calc lowerSecond * (lowerFirst * z ^ k) ^ k
        ≤ lowerSecond * x ^ k := mul_le_mul_of_nonneg_left hlowerPow hls0
      _ ≤ y := hsecond.1
  · calc y
        ≤ upperSecond * x ^ k := hsecond.2
      _ ≤ upperSecond * (upperFirst * z ^ k) ^ k :=
          mul_le_mul_of_nonneg_left hupperPow hus0

end Ising2DLambda.NecSuf.ThermodynamicLimit
