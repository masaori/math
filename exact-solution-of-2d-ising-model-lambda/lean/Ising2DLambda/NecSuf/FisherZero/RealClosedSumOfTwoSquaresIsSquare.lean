/-
「実閉部分体では二つの平方の和がまた平方である」の必要十分版。

部分体も虚数単位も代数閉性も、この段では本質でない。効いているのは Gauss の恒等式
`(a² - b²)² + (2ab)² = (a² + b²)²` だけで、必要なのは可換環である。
（本文はこの恒等式へ、`u·u = x + yω` の一意表示から読んだ `x = a² - b²`、`y = 2ab` を代入する。
そこだけが代数閉性と第 4 条件を使う。）
-/
import Mathlib.Algebra.Ring.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

theorem gauss_sum_of_two_squares_identity_necSuf {R : Type*} [CommRing R] (a b : R) :
    (a * a - b * b) * (a * a - b * b) + (2 * a * b) * (2 * a * b)
      = (a * a + b * b) * (a * a + b * b) := by
  ring

end Ising2DLambda.NecSuf.FisherZero
