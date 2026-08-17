/-
「正錐の元の冪は正錐の元である」の必要十分版。
必要なのは、始点、二項演算、その単位元に相当する元の所属、積に相当する
二項演算による閉性だけである。結合則・可換則・体・順序は使わない。
-/
import Mathlib.Algebra.Group.Defs
import Mathlib.Data.Set.Defs

namespace Ising2DLambda.NecSuf.FisherZero

/-- 始点 `one` から、右に `x` を掛ける形で作る反復。 -/
def iteratedPower {X : Type*} (one : X) (mul : X → X → X) (x : X) : ℕ → X
  | 0 => one
  | m + 1 => mul (iteratedPower one mul x m) x

/-- 始点を含み二項演算で閉じた集合は、上の反復をすべて含む。 -/
theorem iteratedPower_mem_necSuf {X : Type*} (S : Set X)
    (one : X) (mul : X → X → X) (hOne : one ∈ S)
    (hMul : ∀ a b : X, a ∈ S → b ∈ S → mul a b ∈ S)
    {x : X} (hx : x ∈ S) (m : ℕ) :
    iteratedPower one mul x m ∈ S := by
  induction m with
  | zero => exact hOne
  | succ m ih => exact hMul _ _ ih hx

end Ising2DLambda.NecSuf.FisherZero
