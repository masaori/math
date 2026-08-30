/-
「平滑化は切断線偶奇を保つ」の必要十分版。
有限族の二点を交換し、その前後で添字を全単射により取り替えると、有限和は変わらない。
格子・辺・切断線・偶奇は使わない。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingTurningInvariance

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- 全単射で添字を取り替えた有限族の二点交換は有限和を保つ。 -/
theorem two_point_swap_reindex_sum_necSuf {ι M : Type} [Fintype ι] [DecidableEq ι]
    [AddCommMonoid M] (f g : ι → M) (σ : ι ≃ ι) (a b : ι) (hab : a ≠ b)
    (ha : g a = f (σ b)) (hb : g b = f (σ a))
    (hother : ∀ r, r ≠ a → r ≠ b → g r = f (σ r)) :
    ∑ r : ι, g r = ∑ r : ι, f r := by
  have hpair : g a + g b = f (σ a) + f (σ b) := by
    rw [ha, hb]
    ac_rfl
  calc
    ∑ r : ι, g r = ∑ r : ι, f (σ r) :=
      two_point_preserved_sum_necSuf (fun r => f (σ r)) g a b hab hpair hother
    _ = ∑ r : ι, f r := σ.sum_comp f

end Ising2DLambda.NecSuf.KacWard
