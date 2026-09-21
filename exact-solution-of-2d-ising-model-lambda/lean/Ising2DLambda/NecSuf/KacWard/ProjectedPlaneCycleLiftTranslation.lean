/-
「射影の平面持ち上げは元の平面閉路の平行移動で巻き付きは零である」の必要十分版。

本質は、二つの点列の一歩差が一致すること、元の点列が閉じること、巻き付きの
二成分を点列の終点差へ送る写像が零だけを零へ送ることだけである。
点の型には加法可換群以外の構造を要求しない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 一歩差が一致する二つの点列は一定の平行移動だけ異なる。元の点列が閉じ、
終点差が巻き付き対の像なら、その巻き付き対は零である。 -/
theorem projected_cycle_lift_translation_necSuf
    {G S : Type*} [AddCommGroup G] [Zero S]
    (lift original : ℕ → G) (n : ℕ)
    (windingPair : S → S → G) (wv wh : S)
    (hstep : ∀ k, lift (k + 1) = lift k + (original (k + 1) - original k))
    (hclosed : original n = original 0)
    (hendpoint : lift n - lift 0 = windingPair wv wh)
    (hzero : ∀ v h, windingPair v h = 0 → v = 0 ∧ h = 0) :
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
  have hpairZero : windingPair wv wh = 0 := by
    rw [← hendpoint, hliftClosed]
    simp
  exact ⟨htranslation, hliftClosed, hzero wv wh hpairZero⟩

end Ising2DLambda.NecSuf.KacWard
