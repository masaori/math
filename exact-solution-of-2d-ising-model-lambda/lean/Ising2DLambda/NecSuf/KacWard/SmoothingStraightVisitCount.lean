/-
「横断の平滑化は横断の頂点で各軸の直進通過数を一つ減らす」
（`claim_smoothing_straight_visit_count_update`）の必要十分版。

人手証明が使うのは、数え上げの述語がただ一つの元で真から偽へ変わり、
他の元では変わらないとき、個数がちょうど一つ減ることだけである。
格子・軸・閉歩道の構造は使わない。住処は有限集合の数え上げ（ℕ）であり、
ℝ / ℂ は現れない。
-/
import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.KacWard

/-- 述語がただ一つの元 `x` で真から偽へ変わり、他の元では変わらないとき、
数え上げは一つ減る。`DecidableEq ι` は `erase` による一元除去に、
`x ∈ s`・`P x`・`¬ Q x` は除かれる一元の実在に必要である。 -/
theorem flip_single_membership_card_necSuf {ι : Type} [DecidableEq ι]
    (s : Finset ι) (P Q : ι → Prop) [DecidablePred P] [DecidablePred Q]
    (x : ι) (hx : x ∈ s) (hP : P x) (hQ : ¬ Q x)
    (hagree : ∀ y ∈ s, y ≠ x → (P y ↔ Q y)) :
    (s.filter fun y => P y).card = (s.filter fun y => Q y).card + 1 := by
  -- 人手証明の第二段: 平滑化後の集合は元の集合から一元を除いたものである
  have hxmem : x ∈ s.filter fun y => P y := Finset.mem_filter.mpr ⟨hx, hP⟩
  have hset : (s.filter fun y => Q y) = (s.filter fun y => P y).erase x := by
    ext y
    simp only [Finset.mem_erase, Finset.mem_filter]
    constructor
    · rintro ⟨hys, hQy⟩
      have hyx : y ≠ x := by
        rintro rfl
        exact hQ hQy
      exact ⟨hyx, hys, (hagree y hys hyx).mpr hQy⟩
    · rintro ⟨hyx, hys, hPy⟩
      exact ⟨hys, (hagree y hys hyx).mp hPy⟩
  -- 人手証明の第三段: 属する一元を除いた有限集合の個数は一つ少ない
  have hpos : 0 < (s.filter fun y => P y).card := Finset.card_pos.mpr ⟨x, hxmem⟩
  rw [hset, Finset.card_erase_of_mem hxmem]
  omega

/-- 二つの因子がそれぞれ一つ減り、更新後の量が更新後の二因子の積なら、
更新後の量は更新前の各因子から一つ引いた積である。必要なのは三つの等式だけである。 -/
theorem two_factor_after_single_decrement_necSuf
    (n₀ n₁ n₀' n₁' c' : ℕ)
    (h₀ : n₀ = n₀' + 1) (h₁ : n₁ = n₁' + 1) (hc : c' = n₀' * n₁') :
    c' = (n₀ - 1) * (n₁ - 1) := by
  rw [hc, h₀, h₁, Nat.add_sub_cancel, Nat.add_sub_cancel]

end Ising2DLambda.NecSuf.KacWard
