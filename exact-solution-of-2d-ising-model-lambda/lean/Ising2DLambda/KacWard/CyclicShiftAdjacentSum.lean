/-
「巡回移動は隣接二項の整数和を保つ」の具体版。
添字は m を法とする剰余、値は整数に固定する。
人手証明と同じく逆写像、次の添字との可換性、有限和の添字変更を順に示す。
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Defs

namespace Ising2DLambda.KacWard

/-- 巡回移動とその逆写像を明示する。 -/
def cyclicIndexShift {m : ℕ} (k : ZMod m) : Equiv.Perm (ZMod m) where
  toFun j := j + k
  invFun j := j - k
  left_inv j := add_sub_cancel_right j k
  right_inv j := sub_add_cancel j k

theorem cyclicIndexShift_successor {m : ℕ} (k j : ZMod m) :
    cyclicIndexShift k (j + 1) = cyclicIndexShift k j + 1 := by
  change (j + 1) + k = (j + k) + 1
  calc
    (j + 1) + k = j + (1 + k) := add_assoc j 1 k
    _ = j + (k + 1) := congrArg (j + ·) (add_comm 1 k)
    _ = (j + k) + 1 := (add_assoc j k 1).symm

theorem cyclicShift_adjacent_integer_sum {m : ℕ} [NeZero m]
    (k : ZMod m) (a : ZMod m → ZMod m → ℤ) :
    (∑ j, a (j + k) ((j + 1) + k)) = ∑ j, a j (j + 1) := by
  have hnext (j : ZMod m) : (j + 1) + k = (j + k) + 1 :=
    cyclicIndexShift_successor k j
  calc
    (∑ j, a (j + k) ((j + 1) + k))
        = ∑ j, a (j + k) ((j + k) + 1) := by
          apply Finset.sum_congr rfl
          intro j _
          rw [hnext j]
    _ = ∑ j, a j (j + 1) :=
      Equiv.sum_comp (cyclicIndexShift k) (fun j => a j (j + 1))

end Ising2DLambda.KacWard
