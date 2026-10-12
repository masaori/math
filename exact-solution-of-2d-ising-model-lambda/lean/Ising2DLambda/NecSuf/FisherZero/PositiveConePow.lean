/-
「正錐の元の冪は正錐の元である」の必要十分版。
台集合と正錐への二つの所属を、再帰の等式で移す。
必要なのは始点の所属と二項演算による閉性であり、結合則・可換則・体・順序は使わない。
-/
import Mathlib.Algebra.Group.Defs
import Mathlib.Data.Set.Defs

namespace Ising2DLambda.NecSuf.FisherZero

/-- 始点 `one` から、右に `x` を掛ける形で作る反復。 -/
def iteratedPower {X : Type*} (one : X) (mul : X → X → X) (x : X) : ℕ → X
  | 0 => one
  | m + 1 => mul (iteratedPower one mul x m) x

/-- 値の台集合と元の述語への所属を、本文と同じ帰納法で同時に保つ。 -/
theorem iteratedPower_mem_necSuf {X Y : Type*} (Q : Set Y) (S : Set X)
    (value : X → Y) (one : X) (mul : X → X → X)
    (hOneQ : value one ∈ Q) (hOne : one ∈ S)
    (hMulQ : ∀ a b : X, value a ∈ Q → value b ∈ Q → value (mul a b) ∈ Q)
    (hMul : ∀ a b : X, a ∈ S → b ∈ S → mul a b ∈ S)
    {x : X} (hxQ : value x ∈ Q) (hx : x ∈ S) (m : ℕ) :
    value (iteratedPower one mul x m) ∈ Q ∧ iteratedPower one mul x m ∈ S := by
  induction m with
  | zero =>
      have hZero : iteratedPower one mul x 0 = one := rfl
      have hZeroQ : value (iteratedPower one mul x 0) ∈ Q :=
        (congrArg value hZero).symm ▸ hOneQ
      have hZeroS : iteratedPower one mul x 0 ∈ S := hZero.symm ▸ hOne
      exact ⟨hZeroQ, hZeroS⟩
  | succ m ih =>
      have hProductQ : value (mul (iteratedPower one mul x m) x) ∈ Q :=
        hMulQ _ _ ih.1 hxQ
      have hProductS : mul (iteratedPower one mul x m) x ∈ S := hMul _ _ ih.2 hx
      have hSucc : iteratedPower one mul x (m + 1) = mul (iteratedPower one mul x m) x := rfl
      have hSuccQ : value (iteratedPower one mul x (m + 1)) ∈ Q :=
        (congrArg value hSucc).symm ▸ hProductQ
      have hSuccS : iteratedPower one mul x (m + 1) ∈ S := hSucc.symm ▸ hProductS
      exact ⟨hSuccQ, hSuccS⟩

/-- 二項演算の像と零回・後者回の定義だけで、反復と通常の冪との橋を作る。 -/
theorem iteratedPower_value_necSuf {X Y : Type*}
    (one : X) (mul : X → X → X) (value : X → Y) (x : X)
    (oneY : Y) (mulY : Y → Y → Y) (power : ℕ → Y)
    (hOne : value one = oneY)
    (hMul : ∀ a b : X, value (mul a b) = mulY (value a) (value b))
    (hZero : power 0 = oneY)
    (hSucc : ∀ n : ℕ, power (n + 1) = mulY (power n) (value x))
    (m : ℕ) : value (iteratedPower one mul x m) = power m := by
  induction m with
  | zero =>
      calc
        value (iteratedPower one mul x 0) = value one := rfl
        _ = oneY := hOne
        _ = power 0 := hZero.symm
  | succ m ih =>
      calc
        value (iteratedPower one mul x (m + 1)) =
            mulY (value (iteratedPower one mul x m)) (value x) :=
          hMul (iteratedPower one mul x m) x
        _ = mulY (power m) (value x) := congrArg (fun z : Y => mulY z (value x)) ih
        _ = power (m + 1) := (hSucc m).symm

end Ising2DLambda.NecSuf.FisherZero
