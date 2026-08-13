/-
「有理数の平方は二倍の平方にならない」の六段の鎖だけを残した必要十分版。
逆元を持つ体は要求せず、着目する b の右逆元と、鎖で実際に使う二つの並べ替えだけを要求する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 六段の鎖と終点での平方の非二性だけを要求する。 -/
theorem rational_square_ne_double_square_necSuf
    {A : Type} [Mul A] [One A]
    (two a b binv r : A)
    (hNoSquareTwo : ∀ q : A, q * q ≠ two)
    (hr : r = a * binv)
    (hReorderA : (a * binv) * (a * binv) = (a * a) * (binv * binv))
    (hReorderB : (two * (b * b)) * (binv * binv) =
      two * ((b * binv) * (b * binv)))
    (hInv : b * binv = 1)
    (hOne : two * (1 * 1) = two) :
    a * a ≠ two * (b * b) := by
  intro hSquare
  apply hNoSquareTwo r
  calc
    r * r = (a * binv) * (a * binv) := by rw [hr]
    _ = (a * a) * (binv * binv) := hReorderA
    _ = (two * (b * b)) * (binv * binv) := by rw [hSquare]
    _ = two * ((b * binv) * (b * binv)) := hReorderB
    _ = two * (1 * 1) := by rw [hInv]
    _ = two := hOne

end Ising2DLambda.NecSuf.FisherZero
