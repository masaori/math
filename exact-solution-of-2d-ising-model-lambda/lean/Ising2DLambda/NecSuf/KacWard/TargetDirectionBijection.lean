/- 本文 `claim_target_direction_bijection` の必要十分版。
反転の対合性、端点の交換、方向を二だけ進めること、始点・方向の全単射だけを使う。 -/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

theorem targetDirection_bijective_necSuf {E V : Type*}
    (source target : E → V) (direction : E → ZMod 4) (reverse : E → E)
    (hrev : ∀ e, reverse (reverse e) = e)
    (htarget : ∀ e, target (reverse e) = source e)
    (hdir : ∀ e, direction (reverse e) = direction e + 2)
    (hsource : Function.Bijective (fun e => (source e, direction e))) :
    Function.Bijective (fun e => (target e, direction e)) := by
  constructor
  · intro e f h
    have ht : target e = target f := congrArg Prod.fst h
    have hd : direction e = direction f := congrArg Prod.snd h
    have hs : source (reverse e) = source (reverse f) := by
      rw [← htarget (reverse e), ← htarget (reverse f)]
      simpa only [hrev] using ht
    have hr : direction (reverse e) = direction (reverse f) := by
      rw [hdir, hdir, hd]
    have heq := hsource.1 (Prod.ext hs hr)
    have := congrArg reverse heq
    simpa only [hrev] using this
  · rintro ⟨v, d⟩
    obtain ⟨f, hf⟩ := hsource.2 (v, d + 2)
    refine ⟨reverse f, ?_⟩
    have hs : source f = v := congrArg Prod.fst hf
    have hd : direction f = d + 2 := congrArg Prod.snd hf
    apply Prod.ext
    · change target (reverse f) = v
      rw [htarget, hs]
    · change direction (reverse f) = d
      rw [hdir, hd]
      fin_cases d <;> decide

end Ising2DLambda.NecSuf.KacWard
