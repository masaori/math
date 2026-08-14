/-
「実対数の 1 における値」の必要十分版。

実数・順序・対数を除き、証明の六段が実際に使う乗法単位元、加法群、
および 1・1 の積を加法へ移す一つの等式だけを残す。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 乗法単位元を加法へ移す写像は、その単位元を零元へ移す。 -/
theorem map_one_eq_zero_necSuf
    {K A : Type*} [MulOneClass K] [AddGroup A]
    (ell : K → A) (hmapOne : ell (1 * 1) = ell 1 + ell 1) :
    ell 1 = 0 := by
  calc
    ell 1 = ell 1 + 0 := (add_zero _).symm
    _ = ell 1 + (ell 1 + (-ell 1)) := by rw [add_neg_cancel]
    _ = (ell 1 + ell 1) + (-ell 1) := by rw [add_assoc]
    _ = ell (1 * 1) + (-ell 1) := by rw [hmapOne]
    _ = ell 1 + (-ell 1) := by rw [one_mul]
    _ = 0 := add_neg_cancel _

end Ising2DLambda.NecSuf.ThermodynamicLimit
