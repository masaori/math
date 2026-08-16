/-
「倍数辺との平方の差の評価」の必要十分版。
具体版の鎖が使っているのは、b := k a について b ≤ L ≤ b + a と、a, b, L が非負であることだけである。
k と a の積の形（倍数であること）は使わない。よって順序可換半環 K の元 a, b, L について
0 ≤ a、0 ≤ b、0 ≤ L、b ≤ L ≤ b + a から L² ≤ b² + 2 a L を、具体版と同じ七段で示す。

削れなかった仮定:
- 0 ≤ L、0 ≤ b、0 ≤ a。第 2・4・6 段で不等式に元を掛けるので、掛ける元の非負性が要る
  （ℕ では自動だが半環では仮定）。
- ℕ の引き算の形 L² − b² ≤ 2 a L は半環では書けないので、ここでは L² ≤ b² + 2 a L の形だけを持ち、
  引き算の形は導出側（ℕ）で付ける。
-/
import Mathlib.Algebra.Order.Ring.Defs
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 順序可換半環で、`0 ≤ a, b, L` と `b ≤ L ≤ b + a` から `L² ≤ b² + 2 a L`。 -/
theorem sq_le_sq_add_two_mul_of_between_necSuf {K : Type*} [CommSemiring K] [PartialOrder K]
    [IsOrderedRing K] {a b L : K} (ha : 0 ≤ a) (hb : 0 ≤ b) (hL : 0 ≤ L)
    (h1 : b ≤ L) (h2 : L ≤ b + a) : L ^ 2 ≤ b ^ 2 + 2 * a * L := by
  calc
    L ^ 2 = L * L := sq L                                                     -- 第 1 段
    _ ≤ (b + a) * L := mul_le_mul_of_nonneg_right h2 hL                       -- 第 2 段
    _ = b * L + a * L := add_mul _ _ _                                        -- 第 3 段
    _ ≤ b * (b + a) + a * L := add_le_add (mul_le_mul_of_nonneg_left h2 hb) (le_refl _)  -- 第 4 段
    _ = b ^ 2 + a * b + a * L := by ring                                      -- 第 5 段
    _ ≤ b ^ 2 + a * L + a * L :=
          add_le_add (add_le_add (le_refl _) (mul_le_mul_of_nonneg_left h1 ha)) (le_refl _)  -- 第 6 段
    _ = b ^ 2 + 2 * a * L := by ring                                          -- 第 7 段

end Ising2DLambda.NecSuf.ThermodynamicLimit
