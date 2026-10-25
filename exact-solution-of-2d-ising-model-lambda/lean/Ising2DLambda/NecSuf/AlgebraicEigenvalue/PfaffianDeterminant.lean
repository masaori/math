import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Classical

/-- 互いに素な二部分への有限和の分割と片方の相殺に必要な加法則。 -/
theorem sum_split_cancel
    {R : Type*} [AddCommMonoid R]
    (total even odd : R)
    (hpartition : total = even + odd)
    (hcancel : odd = 0) :
    total = even := by
  calc
    total = even + odd := hpartition
    _ = even + 0 := congrArg (even + ·) hcancel
    _ = even := add_zero _

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
