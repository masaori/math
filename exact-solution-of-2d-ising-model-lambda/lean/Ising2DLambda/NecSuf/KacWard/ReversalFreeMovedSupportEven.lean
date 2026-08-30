/-
必要十分版: 各無向辺に動く向き付き辺が一つだけ載り、置換が終点を始点へ送るなら、
無向辺の台は各頂点で偶数本の端点を持つ。

人手証明からトーラス、Kac--Ward 位相、辺の具体的な符号化を除き、有限集合、
二つの端点、向き付き代表との全単射、閉じた置換だけを残す。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.EquivFin

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 一意な向き付き代表と閉じた置換を持つ無向辺族の端点数は偶数である。 -/
theorem supportIncidence_even_necSuf
    {E O V : Type*} [Fintype E] [Fintype O] [DecidableEq V]
    (endpoint₀ endpoint₁ : E → V) (source target : O → V)
    (lift : E ≃ O) (cycle : Equiv.Perm O)
    (hendpoint : ∀ e : E,
      (endpoint₀ e, endpoint₁ e) = (source (lift e), target (lift e)) ∨
      (endpoint₀ e, endpoint₁ e) = (target (lift e), source (lift e)))
    (hcycle : ∀ o : O, source (cycle o) = target o) (v : V) :
    Even (∑ e : E, ((if endpoint₀ e = v then 1 else 0) +
      (if endpoint₁ e = v then 1 else 0))) := by
  let incoming : ℕ := ∑ o : O, if target o = v then 1 else 0
  refine ⟨incoming, ?_⟩
  calc
    ∑ e : E, ((if endpoint₀ e = v then 1 else 0) +
        (if endpoint₁ e = v then 1 else 0)) =
        ∑ o : O, ((if source o = v then 1 else 0) +
          (if target o = v then 1 else 0)) := by
      apply Fintype.sum_equiv lift
      intro e
      rcases hendpoint e with h | h <;> simp only [Prod.mk.injEq] at h
      · rw [h.1, h.2]
      · rw [h.1, h.2, Nat.add_comm]
    _ = (∑ o : O, if source o = v then 1 else 0) + incoming := by
      simp only [incoming, Finset.sum_add_distrib]
    _ = (∑ o : O, if source (cycle o) = v then 1 else 0) + incoming := by
      congr 1
      exact (Fintype.sum_equiv cycle
        (fun o : O => if source (cycle o) = v then 1 else 0)
        (fun o : O => if source o = v then 1 else 0) (fun _ => rfl)).symm
    _ = incoming + incoming := by
      congr 1
      apply Finset.sum_congr rfl
      intro o _
      rw [hcycle o]

end Ising2DLambda.NecSuf.KacWard
