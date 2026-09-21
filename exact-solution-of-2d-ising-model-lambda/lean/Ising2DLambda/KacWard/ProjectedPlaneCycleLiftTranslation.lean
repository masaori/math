/-
章「Onsager 閉形式への接続」の「射影の平面持ち上げは元の平面閉路の平行移動で
巻き付きは零である」（`claim_projected_plane_cycle_lift_translation`）の具体版。

人手証明と同じく、各歩の変位一致を帰納法で足し上げ、閉路の終点一致と
巻き付き終点公式から二つの整数巻き付き数を零へ戻す。
住処は ℤ × ℤ だけであり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.NecSuf.KacWard.ProjectedPlaneCycleLiftTranslation

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 一辺 `L` のトーラスの巻き付き対を平面持ち上げの終点差へ送る。 -/
def integerWindingPair (L : ℕ) (wv wh : ℤ) : ℤ × ℤ :=
  ((L : ℤ) * wv, (L : ℤ) * wh)

/-- `claim_projected_plane_cycle_lift_translation` の具体版。 -/
theorem projectedPlaneCycleLift_translation_and_winding_zero
    (L : ℕ) [NeZero L] (lift original : ℕ → ℤ × ℤ) (n : ℕ) (wv wh : ℤ)
    (hstep : ∀ k, lift (k + 1) = lift k + (original (k + 1) - original k))
    (hclosed : original n = original 0)
    (hendpoint : lift n - lift 0 = integerWindingPair L wv wh) :
    (∀ k, lift k = lift 0 + original k - original 0) ∧
      lift n = lift 0 ∧ wv = 0 ∧ wh = 0 := by
  apply projected_cycle_lift_translation_necSuf
    lift original n (integerWindingPair L) wv wh hstep hclosed hendpoint
  intro v h hvh
  have hL : (L : ℤ) ≠ 0 := by
    exact_mod_cast (NeZero.ne L)
  constructor
  · have hv : (L : ℤ) * v = 0 := congrArg Prod.fst hvh
    exact (mul_eq_zero.mp hv).resolve_left hL
  · have hh : (L : ℤ) * h = 0 := congrArg Prod.snd hvh
    exact (mul_eq_zero.mp hh).resolve_left hL

end Ising2DLambda.KacWard
