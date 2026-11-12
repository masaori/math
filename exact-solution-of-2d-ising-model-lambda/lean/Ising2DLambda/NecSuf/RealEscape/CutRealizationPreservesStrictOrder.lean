/-
`claim_cut_realization_preserves_strict_order`（下切断による実現写像は狭義順序を保ち単射である）の必要十分版。

具体版と同じ手順（ρ(1) = 1、0 < d なら 0 ∈ C_d で 0 ≤ ρ(d)、d ≠ 0 と逆元で ρ(d)ρ(d⁻¹) = 1、
ゆえに 0 < ρ(d)、ρ(b) = ρ(a + (b − a)) = ρ(a) + ρ(b − a)、三分法による単射性）を、
体 α・有理数の写像 rational・関係 lt だけで書く。仮定は次のとおりである。
  - trans, irrefl, ratLt, subPos, posMul, posAddNonneg, ratPos, ratZero, ratAdd, ratMul, total, pinch:
    乗法の保存（前の主張の必要十分版）と同じ。ρ(dd⁻¹) = ρ(d)ρ(d⁻¹) と加法の保存に要る。
    irrefl は d ≠ 0（lt 0 0 にならない）にも、subPos は 0 < b − a を作る段と単射性にも、
    total は単射性の場合分けにも使う。
  - ratOne: rational は 1 を保つ。ρ(1) = ι(1) = 1 を出す段に要る。
α が体であること（逆元の存在 d d⁻¹ = 1）は ρ(d) ≠ 0 を出す段に要る。可換環のままでは、
0 < d の元について ρ(d) の正値を出す手段が無い（下切断の下側に正の有理数を取れることが仮定に無い）。
-/
import Ising2DLambda.NecSuf.RealEscape.CutRealizationPreservesMultiplication

namespace Ising2DLambda.NecSuf.RealEscape

section

variable {α : Type*} [Field α] {rational : ℚ → α} {lt : α → α → Prop}

/-- 必要十分版: `lt a b` なら `cutRealization a < cutRealization b`。 -/
theorem cutRealization_preserves_strict_order_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    (subPos : ∀ u v : α, lt u v ↔ lt 0 (v - u))
    (posMul : ∀ u v : α, lt 0 u → lt 0 v → lt 0 (u * v))
    (posAddNonneg : ∀ u v : α, lt 0 u → (lt 0 v ∨ v = 0) → lt 0 (u + v))
    (ratPos : ∀ q : ℚ, 0 < q → lt 0 (rational q))
    (ratZero : rational 0 = 0)
    (ratOne : rational 1 = 1)
    (ratAdd : ∀ r s : ℚ, rational (r + s) = rational r + rational s)
    (ratMul : ∀ r s : ℚ, rational (r * s) = rational r * rational s)
    (total : ∀ x : α, lt x 0 ∨ x = 0 ∨ lt 0 x)
    (pinch : ∀ x : α, ∀ ε : ℚ, 0 < ε →
      ∃ r s : ℚ, lt (rational r) x ∧ lt x (rational s) ∧ s - r < ε)
    {a b : α} (hab : lt a b) :
    cutRealization rational lt a < cutRealization rational lt b := by
  set ρ := cutRealization rational lt with hρdef
  -- ρ(1) = ι(1) = 1。
  have hone : ρ 1 = 1 := by
    rw [← ratOne, hρdef, cutRealization_agrees_on_rationals_necSuf trans irrefl ratLt]
    exact Rat.cast_one
  -- d := b − a、0 < d。
  have hd : lt 0 (b - a) := (subPos a b).mp hab
  -- 0 ∈ C_d、上限は上界なので 0 ≤ ρ(d)。
  have hnonneg : 0 ≤ ρ (b - a) := by
    obtain ⟨_, s, _, hs, _⟩ := pinch (b - a) 1 one_pos
    have hlub := (lower_cut_has_supremum_necSuf trans irrefl ratLt (b - a)
      ⟨0, s, by rw [ratZero]; exact hd, hs⟩).2.2
    have h := hlub.1 ⟨0, by rw [ratZero]; exact hd, rfl⟩
    rwa [Rat.cast_zero] at h
  -- d ≠ 0（lt 0 0 にならない）、逆元で ρ(d)ρ(d⁻¹) = ρ(1) = 1。
  have hd0 : b - a ≠ 0 := fun h => irrefl 0 (by rw [h] at hd; exact hd)
  have hprod : ρ (b - a) * ρ (b - a)⁻¹ = 1 := by
    rw [← cutRealization_preserves_multiplication_necSuf trans irrefl ratLt subPos posMul
      posAddNonneg ratPos ratZero ratAdd ratMul total pinch, mul_inv_cancel₀ hd0]
    exact hone
  have hne : ρ (b - a) ≠ 0 := by
    intro h0
    rw [h0, zero_mul] at hprod
    exact zero_ne_one hprod
  have hpos : 0 < ρ (b - a) := lt_of_le_of_ne hnonneg hne.symm
  -- ρ(b) = ρ(a + (b − a)) = ρ(a) + ρ(b − a)。
  have hadd : ρ (a + (b - a)) = ρ a + ρ (b - a) :=
    cutRealization_preserves_addition_necSuf trans irrefl ratLt
      (fun u v w h => by rw [subPos] at h ⊢; rwa [show v + w - (u + w) = v - u by ring])
      (fun u v w h => by rw [subPos] at h ⊢; rwa [show w + v - (w + u) = v - u by ring])
      ratAdd a (b - a) (pinch a) (pinch (b - a))
  rw [add_sub_cancel] at hadd
  rw [hadd]
  linarith

/-- 必要十分版: `cutRealization` は単射。 -/
theorem cutRealization_injective_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    (subPos : ∀ u v : α, lt u v ↔ lt 0 (v - u))
    (posMul : ∀ u v : α, lt 0 u → lt 0 v → lt 0 (u * v))
    (posAddNonneg : ∀ u v : α, lt 0 u → (lt 0 v ∨ v = 0) → lt 0 (u + v))
    (ratPos : ∀ q : ℚ, 0 < q → lt 0 (rational q))
    (ratZero : rational 0 = 0)
    (ratOne : rational 1 = 1)
    (ratAdd : ∀ r s : ℚ, rational (r + s) = rational r + rational s)
    (ratMul : ∀ r s : ℚ, rational (r * s) = rational r * rational s)
    (total : ∀ x : α, lt x 0 ∨ x = 0 ∨ lt 0 x)
    (pinch : ∀ x : α, ∀ ε : ℚ, 0 < ε →
      ∃ r s : ℚ, lt (rational r) x ∧ lt x (rational s) ∧ s - r < ε) :
    Function.Injective (cutRealization rational lt) := by
  have hlt := fun {a b : α} (h : lt a b) =>
    cutRealization_preserves_strict_order_necSuf trans irrefl ratLt subPos posMul posAddNonneg
      ratPos ratZero ratOne ratAdd ratMul total pinch h
  intro a b hab
  -- 三分法: lt a b、a = b、lt b a のいずれか（b − a に total を当てる）。
  rcases total (b - a) with h | h | h
  · have hba : lt b a := by
      rw [subPos] at h ⊢
      rwa [show a - b = 0 - (b - a) by ring]
    exact absurd hab (hlt hba).ne'
  · exact (sub_eq_zero.mp h).symm
  · exact absurd hab (hlt ((subPos a b).mpr h)).ne

end

end Ising2DLambda.NecSuf.RealEscape
