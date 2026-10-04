/- 隣接対の重みの一致を内部和と閉じ目へ移す。添字の値域に構造は不要。 -/
import Ising2DLambda.NecSuf.KacWard.ReversedParallelStaircaseTurning

namespace Ising2DLambda.NecSuf.KacWard

/-- 内部の隣接対と閉じ目だけを使う。正の長さも辺・方向・格子も要求しない。 -/
theorem cyclicAdjacentSum_transport_necSuf {α β M : Type*} [AddCommMonoid M]
    (a : α → α → M) (b : β → β → M) (p : ℕ → α) (u : ℕ → β)
    (n : ℕ)
    (hinternal : ∀ j < n - 1, a (p j) (p (j + 1)) = b (u j) (u (j + 1)))
    (hclosing : a (p (n - 1)) (p 0) = b (u (n - 1)) (u 0)) :
    cyclicAdjacentSum a n p = cyclicAdjacentSum b n u := by
  unfold cyclicAdjacentSum
  apply congrArg₂ (· + ·)
  · apply Finset.sum_congr rfl
    intro j hj
    exact hinternal j (Finset.mem_range.mp hj)
  · exact hclosing

end Ising2DLambda.NecSuf.KacWard
