/-
「有理数の平方は二倍の平方にならない」の十七等号に対応する必要十分版。
加法・順序・体構造は用いない。乗法の結合則は括弧の移動に、二つの可換性は
binv と a、および b と binv の交換だけに使う。b の右逆元と二つの単位元則は
鎖の末尾の四等号で使う。two は平方にならない指定元であり、数の 2 とは限らない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 本文と同じ十七等号を、途中の結論を仮定せずに導く。 -/
theorem rational_square_ne_double_square_necSuf
    {A : Type} [Mul A] [One A]
    (two a b binv r : A)
    (hNoSquareTwo : ∀ q : A, q * q ≠ two)
    (hr : r = a * binv)
    (hAssoc : ∀ x y z : A, (x * y) * z = x * (y * z))
    (hCommuteA : binv * a = a * binv)
    (hCommuteB : b * binv = binv * b)
    (hInv : b * binv = 1)
    (hOneOne : (1 : A) * 1 = 1)
    (hTwoOne : two * 1 = two) :
    a * a ≠ two * (b * b) := by
  intro hSquare
  apply hNoSquareTwo r
  calc
    r * r = (a * binv) * (a * binv) := congrArg (fun q : A => q * q) hr
    _ = a * (binv * (a * binv)) := hAssoc _ _ _
    _ = a * ((binv * a) * binv) := congrArg (a * ·) (hAssoc _ _ _).symm
    _ = a * ((a * binv) * binv) :=
      congrArg (fun q : A => a * (q * binv)) hCommuteA
    _ = a * (a * (binv * binv)) := congrArg (a * ·) (hAssoc _ _ _)
    _ = (a * a) * (binv * binv) := (hAssoc _ _ _).symm
    _ = (two * (b * b)) * (binv * binv) := congrArg (· * (binv * binv)) hSquare
    _ = two * ((b * b) * (binv * binv)) := hAssoc _ _ _
    _ = two * (b * (b * (binv * binv))) := congrArg (two * ·) (hAssoc _ _ _)
    _ = two * (b * ((b * binv) * binv)) :=
      congrArg (fun q : A => two * (b * q)) (hAssoc _ _ _).symm
    _ = two * (b * ((binv * b) * binv)) :=
      congrArg (fun q : A => two * (b * (q * binv))) hCommuteB
    _ = two * (b * (binv * (b * binv))) :=
      congrArg (fun q : A => two * (b * q)) (hAssoc _ _ _)
    _ = two * ((b * binv) * (b * binv)) := congrArg (two * ·) (hAssoc _ _ _).symm
    _ = two * (1 * (b * binv)) :=
      congrArg (fun q : A => two * (q * (b * binv))) hInv
    _ = two * (1 * 1) := congrArg (fun q : A => two * (1 * q)) hInv
    _ = two * 1 := congrArg (two * ·) hOneOne
    _ = two := hTwoOne

end Ising2DLambda.NecSuf.FisherZero
