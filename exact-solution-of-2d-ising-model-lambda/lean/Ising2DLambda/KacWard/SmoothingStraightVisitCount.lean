/-
「横断の平滑化は横断の頂点で各軸の直進通過数を一つ減らす」
（`claim_smoothing_straight_visit_count_update`）の具体版。
通過の添字を `Fin m`、平滑化後の局所データを、選んだ二添字だけで直進を失い
他の添字では変わらない写像 `visit'` として持つ（人手証明の第一段
「選んだ二添字は平滑化後に直進でない」は方向番号の議論なので、
ここでは仮定として受け取る）。
-/
import Ising2DLambda.KacWard.CrossingNumberDouble
import Ising2DLambda.NecSuf.KacWard.SmoothingStraightVisitCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 選んだ横断 `a, b` の平滑化は、横断の頂点では各軸の直進通過数を一つ減らし、
他の頂点では変えない（具体版）。 -/
theorem smoothing_straight_visit_count_update {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight)
    (w : V) (ax : Bool) :
    (Finset.univ.filter fun k : Fin m => vertex k = w ∧
        (visit k).turn = .straight ∧ (visit k).vertical = ax).card
      = (Finset.univ.filter fun k : Fin m => vertex k = w ∧
          (visit' k).turn = .straight ∧ (visit' k).vertical = ax).card
        + (if vertex a = w then 1 else 0) := by
  obtain ⟨hvtx, hsa, hsb, haxne⟩ := hcross
  by_cases hw : vertex a = w
  · -- 人手証明の「w = v の場合」: 軸 ax に属する側の添字がちょうど一つ除かれる
    rw [if_pos hw]
    by_cases hax : (visit a).vertical = ax
    · -- 除かれる一元は a
      refine flip_single_membership_card_necSuf Finset.univ _ _ a (Finset.mem_univ a)
        ⟨hw, hsa, hax⟩ (fun hQ => ha hQ.2.1) ?_
      intro y _ hya
      by_cases hyb : y = b
      · subst hyb
        constructor
        · rintro ⟨_, _, hbx⟩
          exact absurd (hbx.trans hax.symm) (Ne.symm haxne)
        · rintro ⟨_, hbt, _⟩
          exact absurd hbt hb
      · rw [hother y hya hyb]
    · -- 除かれる一元は b（Bool は二値なので b の軸が ax に一致する）
      have hbx : (visit b).vertical = ax := by
        cases h1 : (visit a).vertical <;> cases h2 : (visit b).vertical <;>
          cases ax <;> simp_all
      have hbw : vertex b = w := hvtx.symm.trans hw
      refine flip_single_membership_card_necSuf Finset.univ _ _ b (Finset.mem_univ b)
        ⟨hbw, hsb, hbx⟩ (fun hQ => hb hQ.2.1) ?_
      intro y _ hyb
      by_cases hya : y = a
      · subst hya
        constructor
        · rintro ⟨_, _, hax'⟩
          exact absurd hax' hax
        · rintro ⟨_, hat, _⟩
          exact absurd hat ha
      · rw [hother y hya hyb]
  · -- 人手証明の「w ≠ v の場合」: どの添字の帰属も変わらない
    rw [if_neg hw, Nat.add_zero]
    have hbw : vertex b ≠ w := by
      rw [← hvtx]
      exact hw
    have hiff : ∀ y ∈ (Finset.univ : Finset (Fin m)),
        ((vertex y = w ∧ (visit y).turn = .straight ∧ (visit y).vertical = ax) ↔
          (vertex y = w ∧ (visit' y).turn = .straight ∧ (visit' y).vertical = ax)) := by
      intro y _
      by_cases hya : y = a
      · subst hya
        constructor
        · rintro ⟨hyw, _, _⟩
          exact absurd hyw hw
        · rintro ⟨hyw, _, _⟩
          exact absurd hyw hw
      · by_cases hyb : y = b
        · subst hyb
          constructor
          · rintro ⟨hyw, _, _⟩
            exact absurd hyw hbw
          · rintro ⟨hyw, _, _⟩
            exact absurd hyw hbw
        · rw [hother y hya hyb]
    rw [Finset.filter_congr hiff]

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_straight_visit_count_update_from_necSuf {m : ℕ} {V : Type}
    [DecidableEq V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight)
    (w : V) (ax : Bool) :
    (Finset.univ.filter fun k : Fin m => vertex k = w ∧
        (visit k).turn = .straight ∧ (visit k).vertical = ax).card
      = (Finset.univ.filter fun k : Fin m => vertex k = w ∧
          (visit' k).turn = .straight ∧ (visit' k).vertical = ax).card
        + (if vertex a = w then 1 else 0) :=
  smoothing_straight_visit_count_update vertex visit visit' a b hcross hother ha hb w ax

end Ising2DLambda.KacWard
