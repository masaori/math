/-
「正錐の元の自然数倍は零元または正錐の元である」の必要十分版。
必要なのは、自然数の場合分け、添字 0 の元との積が指定した元になること、
正の添字の元の所属、二項演算による閉性だけである。環・体・順序は使わない
（具体版の Qbar・二次体・有理数の順序は、この場合分けの論法には本質的でない）。
-/
import Mathlib.Algebra.Group.Defs
import Mathlib.Data.Set.Defs

namespace Ising2DLambda.NecSuf.FisherZero

/-- 自然数で添字づけた族 `f` との積は、添字が零なら指定した元 `z`、
    添字が正なら集合 `P` に留まる。 -/
theorem natIndexed_mul_zero_or_mem_necSuf {X : Type*} (P : Set X)
    (mul : X → X → X) (f : ℕ → X) (z : X)
    (hzero : ∀ x : X, mul (f 0) x = z)
    (hpos : ∀ c : ℕ, 1 ≤ c → f c ∈ P)
    (hMul : ∀ a b : X, a ∈ P → b ∈ P → mul a b ∈ P)
    (c : ℕ) {x : X} (hx : x ∈ P) :
    (c = 0 → mul (f c) x = z) ∧ (1 ≤ c → mul (f c) x ∈ P) := by
  constructor
  · intro hc
    subst hc
    exact hzero x
  · intro hc
    exact hMul (f c) x (hpos c hc) hx

end Ising2DLambda.NecSuf.FisherZero
