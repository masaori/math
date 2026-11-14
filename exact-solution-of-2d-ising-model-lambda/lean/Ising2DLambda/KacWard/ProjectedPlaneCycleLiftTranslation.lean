/-
章「Onsager 閉形式への接続」の「射影の平面持ち上げは元の平面閉路の平行移動で
巻き付きは零である」（`claim_projected_plane_cycle_lift_translation`）の具体版。

人手証明と同じく、各歩の変位一致を帰納法で足し上げ、閉路の終点一致と
巻き付き終点公式から二つの整数巻き付き数を零へ戻す。
住処は ℤ × ℤ だけであり、ℝ / ℂ は現れない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

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
  have htranslation : ∀ k, lift k = lift 0 + original k - original 0 := by
    intro k
    induction k with
    | zero => simp
    | succ k ih =>
        rw [hstep k, ih]
        abel
  have hliftClosed : lift n = lift 0 := by
    rw [htranslation n, hclosed]
    abel
  have hpairZero : integerWindingPair L wv wh = 0 := by
    rw [← hendpoint, hliftClosed]
    simp
  have hL : (L : ℤ) ≠ 0 := by
    exact_mod_cast (NeZero.ne L)
  have hv : wv = 0 := by
    have h : (L : ℤ) * wv = 0 := congrArg Prod.fst hpairZero
    exact (mul_eq_zero.mp h).resolve_left hL
  have hh : wh = 0 := by
    have h : (L : ℤ) * wh = 0 := congrArg Prod.snd hpairZero
    exact (mul_eq_zero.mp h).resolve_left hL
  exact ⟨htranslation, hliftClosed, hv, hh⟩

end Ising2DLambda.KacWard
