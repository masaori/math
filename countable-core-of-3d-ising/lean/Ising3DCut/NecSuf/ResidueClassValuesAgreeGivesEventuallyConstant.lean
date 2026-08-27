/-
「剰余類ごとの値が一致する末尾周期性は末尾定数性である」の Lean 必要十分版。

具体版の証明が実際に使うのは、自然数で添字づけられた任意の列、正の周期、
各剰余類に沿う定数性、剰余類の代表値が共通値に等しいことだけである。
Ising 模型・有理数・実数・乗根・箱の点数は使わない。
-/
import Ising3DCut.NecSuf.EventuallyPeriodicResidueClassConstant

namespace Ising3DCut.NecSuf

/-- 各剰余類に沿う定数値が一致する任意の列は、閾値以後で定数である。 -/
theorem residueClassValuesAgree_givesEventuallyConstant
    {A : Type*} (a : ℕ → A) {L0 p : ℕ}
    (hp : 0 < p)
    (hresidue : ∀ r k : ℕ, a (L0 + r + k * p) = a (L0 + r))
    {c : A}
    (hagree : ∀ r : ℕ, r < p → a (L0 + r) = c) :
    ∀ L, L0 ≤ L → a L = c := by
  intro L hL
  have hr : (L - L0) % p < p := Nat.mod_lt _ hp
  have hdiv : (L - L0) / p * p + (L - L0) % p = L - L0 := Nat.div_add_mod' _ _
  have hindex : L = L0 + (L - L0) % p + (L - L0) / p * p := by omega
  calc
    a L = a (L0 + (L - L0) % p + (L - L0) / p * p) := by rw [← hindex]
    _ = a (L0 + (L - L0) % p) := hresidue _ _
    _ = c := hagree _ hr

end Ising3DCut.NecSuf
