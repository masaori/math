/-
`claim_cut_realization_preserves_multiplication`（下切断による実現写像は乗法を保つ）の必要十分版。

具体版と同じ手順（正の元の挟み込みの下側を max(r,0)、上側を min(s,B) へ取り替える、
ab − r_a r_b = a(b − r_b) + r_b(a − r_a) と s_a s_b − ab = s_a(s_b − b) + b(s_a − a) で ab を挟む、
二つの実数が同じ区間に入り幅が η(B_a + B_b) より小さい、実数内の有理数の稠密性、
ρ(−x) = −ρ(x) による符号の反転、三分法による場合分け）を、可換環 α・有理数の写像 rational・
関係 lt だけで書く。仮定は次のとおりである。
  - trans, irrefl, ratLt: 前の主張（下切断の上限）と同じ。切断の挟み込みに要る。
  - subPos: lt u v ↔ lt 0 (v − u)。積の挟み込みを差の正値性へ移す段と、加法移送
    （加法の保存を符号の反転に使う段）に要る（具体版では狭義順序の定義）。
  - posMul: 正の元の積は正。posAddNonneg: 正の元と、正か零の元の和は正。
    積の挟み込みの二つの分解の各項に要る。
  - ratPos: 正の有理数の像は正。上側 s_a s_b − ab の第一項 s_a(s_b − b) と、
    下側の第二項 r_b(a − r_a) の r_b ≥ 0 に要る。
  - ratZero, ratAdd, ratMul: rational は環準同型の零・和・積を保つ。
    下側を max(r,0) に取り替える段、加法の保存、積の下側・上側を一つの有理数の像として読む段に要る。
  - total: 各元は負・零・正のいずれか（三分法の網羅性）。場合分けに要る。
  - pinch: 各元の任意の正の有理幅での挟み込み（`claim_real_algebraic_rational_pinching` の結論）。
    a, b, −a, −b と、加法の保存に渡す元のすべてに当てるので、全称で仮定する。
α の可換性は二つの分解（r_b a = a r_b の並べ替え）に要る。逆元・除法・平方の存在は使わない。
-/
import Ising2DLambda.NecSuf.RealEscape.CutRealizationPreservesAddition

namespace Ising2DLambda.NecSuf.RealEscape

section

variable {α : Type*} [CommRing α] {rational : ℚ → α} {lt : α → α → Prop}

/-- 必要十分版: `cutRealization (a * b) = cutRealization a * cutRealization b`。 -/
theorem cutRealization_preserves_multiplication_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    (subPos : ∀ u v : α, lt u v ↔ lt 0 (v - u))
    (posMul : ∀ u v : α, lt 0 u → lt 0 v → lt 0 (u * v))
    (posAddNonneg : ∀ u v : α, lt 0 u → (lt 0 v ∨ v = 0) → lt 0 (u + v))
    (ratPos : ∀ q : ℚ, 0 < q → lt 0 (rational q))
    (ratZero : rational 0 = 0)
    (ratAdd : ∀ r s : ℚ, rational (r + s) = rational r + rational s)
    (ratMul : ∀ r s : ℚ, rational (r * s) = rational r * rational s)
    (total : ∀ x : α, lt x 0 ∨ x = 0 ∨ lt 0 x)
    (pinch : ∀ x : α, ∀ ε : ℚ, 0 < ε →
      ∃ r s : ℚ, lt (rational r) x ∧ lt x (rational s) ∧ s - r < ε)
    (a b : α) :
    cutRealization rational lt (a * b) =
      cutRealization rational lt a * cutRealization rational lt b := by
  set ρ := cutRealization rational lt with hρdef
  -- 0 <_R x <_R s なら 0 < s。
  have ratPosOf : ∀ {x : α} {s : ℚ}, lt 0 x → lt x (rational s) → 0 < s := by
    intro x s hx hs
    apply rat_lt_of_lt_necSuf trans irrefl ratLt
    rw [ratZero]
    exact trans _ _ _ hx hs
  -- 正の元の挟み込み: 下側 max(r,0)、上側 min(s,B)。
  have posPinch : ∀ {x : α} {B : ℚ}, lt 0 x → lt x (rational B) → ∀ {η : ℚ}, 0 < η →
      ∃ r s : ℚ, 0 ≤ r ∧ s ≤ B ∧ lt (rational r) x ∧ lt x (rational s) ∧ s - r < η := by
    intro x B hx hB η hη
    obtain ⟨r, s, hr, hs, hw⟩ := pinch x η hη
    refine ⟨max r 0, min s B, le_max_right _ _, min_le_right _ _, ?_, ?_, ?_⟩
    · rcases le_total r 0 with h | h
      · rw [max_eq_right h, ratZero]; exact hx
      · rw [max_eq_left h]; exact hr
    · rcases le_total s B with h | h
      · rw [min_eq_left h]; exact hs
      · rw [min_eq_right h]; exact hB
    · have h1 := le_max_left r 0
      have h2 := min_le_left s B
      linarith
  -- 正の二元の場合。
  have hpos : ∀ {x y : α}, lt 0 x → lt 0 y → ρ (x * y) = ρ x * ρ y := by
    intro x y hx hy
    obtain ⟨_, Bx, _, hBx, _⟩ := pinch x 1 one_pos
    obtain ⟨_, By, _, hBy, _⟩ := pinch y 1 one_pos
    have hK : 0 < Bx + By := by
      have := ratPosOf hx hBx
      have := ratPosOf hy hBy
      linarith
    have hclose : ∀ η : ℚ, 0 < η → |ρ (x * y) - ρ x * ρ y| < ((η * (Bx + By) : ℚ) : ℝ) := by
      intro η hη
      obtain ⟨rx, sx, hrx0, hsxB, hrx, hsx, hwx⟩ := posPinch hx hBx hη
      obtain ⟨ry, sy, hry0, hsyB, hry, hsy, hwy⟩ := posPinch hy hBy hη
      have hsx0 : 0 < sx := ratPosOf hx hsx
      have hsy0 : 0 < sy := ratPosOf hy hsy
      have hlo : lt (rational (rx * ry)) (x * y) := by
        rw [subPos, ratMul]
        have e : x * y - rational rx * rational ry =
            x * (y - rational ry) + rational ry * (x - rational rx) := by ring
        rw [e]
        apply posAddNonneg _ _ (posMul _ _ hx ((subPos _ _).mp hry))
        rcases hry0.lt_or_eq with h | h
        · exact Or.inl (posMul _ _ (ratPos _ h) ((subPos _ _).mp hrx))
        · right; rw [← h, ratZero, zero_mul]
      have hhi : lt (x * y) (rational (sx * sy)) := by
        rw [subPos, ratMul]
        have e : rational sx * rational sy - x * y =
            rational sx * (rational sy - y) + y * (rational sx - x) := by ring
        rw [e]
        exact posAddNonneg _ _ (posMul _ _ (ratPos _ hsx0) ((subPos _ _).mp hsy))
          (Or.inl (posMul _ _ hy ((subPos _ _).mp hsx)))
      obtain ⟨h1, h2⟩ := cutRealization_pinch_necSuf trans irrefl ratLt hlo hhi
      obtain ⟨h3, h4⟩ := cutRealization_pinch_necSuf trans irrefl ratLt hrx hsx
      obtain ⟨h5, h6⟩ := cutRealization_pinch_necSuf trans irrefl ratLt hry hsy
      have hrx0' : (0 : ℝ) ≤ (rx : ℝ) := Rat.cast_nonneg.mpr hrx0
      have hry0' : (0 : ℝ) ≤ (ry : ℝ) := Rat.cast_nonneg.mpr hry0
      have hρy0 : (0 : ℝ) ≤ ρ y := le_trans hry0' h5
      have hsx0' : (0 : ℝ) ≤ (sx : ℝ) := le_trans (le_trans hrx0' h3) h4
      have hlow : (rx : ℝ) * (ry : ℝ) ≤ ρ x * ρ y := mul_le_mul h3 h5 hry0' (le_trans hrx0' h3)
      have hupp : ρ x * ρ y ≤ (sx : ℝ) * (sy : ℝ) := mul_le_mul h4 h6 hρy0 hsx0'
      have hrxs : rx ≤ sx :=
        (rat_lt_of_lt_necSuf trans irrefl ratLt (trans _ _ _ hrx hsx)).le
      have hwidth : sx * sy - rx * ry < η * (Bx + By) := by
        have e : sx * sy - rx * ry = (sx - rx) * sy + rx * (sy - ry) := by ring
        have t1 : (sx - rx) * sy < η * By := by
          calc (sx - rx) * sy < η * sy := mul_lt_mul_of_pos_right hwx hsy0
            _ ≤ η * By := mul_le_mul_of_nonneg_left hsyB hη.le
        have t2 : rx * (sy - ry) ≤ Bx * η := by
          calc rx * (sy - ry) ≤ rx * η := mul_le_mul_of_nonneg_left hwy.le hrx0
            _ ≤ Bx * η := mul_le_mul_of_nonneg_right (le_trans hrxs hsxB) hη.le
        rw [e]
        linarith
      have hwidth' : (sx : ℝ) * (sy : ℝ) - (rx : ℝ) * (ry : ℝ) < ((η * (Bx + By) : ℚ) : ℝ) := by
        rw [← Rat.cast_mul, ← Rat.cast_mul, ← Rat.cast_sub, Rat.cast_lt]
        exact hwidth
      push_cast at h1 h2
      rw [abs_sub_lt_iff]
      constructor <;> linarith
    by_contra hne
    have hd : 0 < |ρ (x * y) - ρ x * ρ y| := abs_pos.mpr (sub_ne_zero.mpr hne)
    obtain ⟨q, hq0, hqd⟩ := exists_rat_btwn hd
    have hq : (0 : ℚ) < q := Rat.cast_pos.mp hq0
    have h := hclose (q / (Bx + By)) (div_pos hq hK)
    have h2 : ((q / (Bx + By) * (Bx + By) : ℚ) : ℝ) = (q : ℝ) := by
      rw [div_mul_cancel₀ q hK.ne']
    rw [h2] at h
    linarith
  -- 加法の保存（前の主張の必要十分版）。加法移送は subPos と環の加法から出る。
  have hadd : ∀ x y : α, ρ (x + y) = ρ x + ρ y := by
    intro x y
    exact cutRealization_preserves_addition_necSuf trans irrefl ratLt
      (fun u v w h => by rw [subPos] at h ⊢; rwa [show v + w - (u + w) = v - u by ring])
      (fun u v w h => by rw [subPos] at h ⊢; rwa [show w + v - (w + u) = v - u by ring])
      ratAdd x y (pinch x) (pinch y)
  have hzero : ρ 0 = 0 := by
    rw [← ratZero, hρdef, cutRealization_agrees_on_rationals_necSuf trans irrefl ratLt]
    exact Rat.cast_zero
  -- ρ(−x) = −ρ(x)。
  have hneg : ∀ x : α, ρ (-x) = -ρ x := by
    intro x
    have h : ρ x + ρ (-x) = 0 := by rw [← hadd, add_neg_cancel, hzero]
    linarith
  have negL : ∀ {x y : α}, ρ (x * y) = ρ x * ρ y → ρ ((-x) * y) = ρ (-x) * ρ y := by
    intro x y h
    rw [neg_mul, hneg, h, hneg, neg_mul]
  have negR : ∀ {x y : α}, ρ (x * y) = ρ x * ρ y → ρ (x * (-y)) = ρ x * ρ (-y) := by
    intro x y h
    rw [mul_neg, hneg, h, hneg, mul_neg]
  -- 三分法: 零か、正か、符号を反転したものが正。
  have sign : ∀ x : α, x = 0 ∨ lt 0 x ∨ lt 0 (-x) := by
    intro x
    rcases total x with h | h | h
    · right; right
      rw [subPos] at h
      rwa [show (-x : α) = 0 - x by ring]
    · exact Or.inl h
    · exact Or.inr (Or.inl h)
  rcases sign a with ha | ha | ha
  · rw [ha, zero_mul, hzero, zero_mul]
  · rcases sign b with hb | hb | hb
    · rw [hb, mul_zero, hzero, mul_zero]
    · exact hpos ha hb
    · have h := negR (hpos ha hb)
      rwa [neg_neg] at h
  · rcases sign b with hb | hb | hb
    · rw [hb, mul_zero, hzero, mul_zero]
    · have h := negL (hpos ha hb)
      rwa [neg_neg] at h
    · have h := negR (negL (hpos ha hb))
      rwa [neg_neg, neg_neg] at h

end

end Ising2DLambda.NecSuf.RealEscape
