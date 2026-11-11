/-
「接触点分割の回転位相は交差形式で更新される」（`claim_crossing_free_contact_split_phase`）の必要十分版。

具体版と同じ手順で証明する。
- `axis_ne_iff_adjacent`: 軸が異なることは、方向番号の差が `1` か `3` であることと同値である。
- `contact_local_pattern_necSuf`: 接触頂点の四半辺が相異なり、元の二通過がともに直進して軸が異なる
  ことはないとき、方向番号の差は本文の表の三つの型（回転差零で分割後に横断する型、`+4`、`−4`）の
  どれかになる。`ZMod 4` の有限な場合分け。
- `contact_local_table_necSuf`: 三つの型で回転差を評価する。
- `contact_phase_sign_necSuf`: 回転差と分割後の混合横断の値から、位相の等式を得る。
- `crossing_free_contact_split_phase_necSuf`: 合成。

格子・トーラス・辺の標識・閉歩道・混合横断数の数え上げ・交差形式は取り去った（それらは具体版で
混合横断数の偶奇が表の最後の値に等しいこと `hc`・`hI` を与える段にだけ現れる）。残した仮定と、その理由:
- 方向を `ZMod 4` に置き、入る方向 `a` の通過は半辺 `a + 2` を、出る方向 `a'` の通過は半辺 `a'` を使う。
  四半辺の相異（六つの不等式）が表の行を四つに絞るので外せない。
- 一歩の回転数は方向番号の差だけで決まる関数 `turn : ZMod 4 → ℤ` とし、`turn 0 = 0`（直進は回らない）と
  `turn 3 = −turn 1`（右折は左折の逆）だけを仮定する。`turn 1 = 1` は使わない（回転差は `±4 · turn 1`、
  位相は `z ^ (4 · turn 1)` を通してしか現れない）。後退 `turn 2` は四半辺の相異で現れない。
  `turn 0 = 0` を外すと、横断する型の回転差 `2 · turn 0 − turn 1 − turn 3` が零にならない。
  `turn 3 = −turn 1` を外すと、同じ型の回転差 `−(turn 1 + turn 3)` が零にならない。
- 軸は任意の型への写像 `ax` で、隣の方向とは異なり（`hax1`）、向かいの方向とは等しい（`hax2`）。
  元の横断・分割後の横断の条件はこの二つを通してだけ方向番号の差へ翻訳される。
- 位相の住処は零を除いて群をなすもの（`GroupWithZero`）で、`z ≠ 0`。積の可換性は使わない
  （同じ `z` の整数冪どうしが可換であることだけを使う）。`s := z ^ (4 · turn 1)` について `s * s = 1` を仮定する。
  これは回転差 `+4 · turn 1` の型で `s · z ^ (t + 4 · turn 1) = z ^ t` を得るのに要る（具体版では
  `s = ζ_8^4 = −1`）。回転差 `−4 · turn 1` の型では `s ≠ 0` だけで足りる。
- 自然数 `c` は分割後の混合横断数で、表の最後の値に等しいこと（`hc`）と、その偶奇 `I`（`hI`）だけを使う。
-/
import Mathlib.Algebra.GroupWithZero.Basic
import Mathlib.Algebra.Group.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.GroupWithZero.Units.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.KacWard

/-- 隣の方向と軸が異なり、向かいの方向と軸が等しいなら、軸が異なることは方向番号の差が `1` か `3`
であることと同値である。 -/
theorem axis_ne_iff_adjacent {B : Type*} (ax : ZMod 4 → B)
    (hax1 : ∀ d, ax (d + 1) ≠ ax d) (hax2 : ∀ d, ax (d + 2) = ax d) (a b : ZMod 4) :
    ax b ≠ ax a ↔ (b = a + 1 ∨ b = a + 3) := by
  have hcases : ∀ a b : ZMod 4, b = a ∨ b = a + 1 ∨ b = a + 2 ∨ b = a + 3 := by decide
  have h0 : ∀ a : ZMod 4, ¬ (a = a + 1 ∨ a = a + 3) := by decide
  have h2 : ∀ a : ZMod 4, ¬ (a + 2 = a + 1 ∨ a + 2 = a + 3) := by decide
  rcases hcases a b with rfl | rfl | rfl | rfl
  · exact ⟨fun h => (h rfl).elim, fun h => (h0 b h).elim⟩
  · exact ⟨fun _ => Or.inl rfl, fun _ => hax1 a⟩
  · exact ⟨fun h => (h (hax2 a)).elim, fun h => (h2 a h).elim⟩
  · refine ⟨fun _ => Or.inr rfl, fun _ => ?_⟩
    have h3 : a + 3 = (a + 1) + 2 := by ring
    rw [h3, hax2]
    exact hax1 a

/-- 接触頂点の型: 四半辺が相異なり、元の二通過がともに直進して隣り合うことはないとき、方向番号の差は
三つの型のどれかである。 -/
theorem contact_local_pattern_necSuf : ∀ a b a' b' : ZMod 4,
    a + 2 ≠ a' → b + 2 ≠ b' → a + 2 ≠ b + 2 → a + 2 ≠ b' → a' ≠ b + 2 → a' ≠ b' →
    ¬ (a' = a ∧ b' = b ∧ (b = a + 1 ∨ b = a + 3)) →
    (b' - a = 0 ∧ a' - b = 0 ∧ ((a' - a = 1 ∧ b' - b = 3) ∨ (a' - a = 3 ∧ b' - b = 1)) ∧
        (a' = b ∧ b' = a ∧ (b = a + 1 ∨ b = a + 3))) ∨
      (b' - a = 3 ∧ a' - b = 3 ∧ a' - a = 1 ∧ b' - b = 1 ∧
        ¬ (a' = b ∧ b' = a ∧ (b = a + 1 ∨ b = a + 3))) ∨
      (b' - a = 1 ∧ a' - b = 1 ∧ a' - a = 3 ∧ b' - b = 3 ∧
        ¬ (a' = b ∧ b' = a ∧ (b = a + 1 ∨ b = a + 3))) := by
  decide

/-- 本文の表: 回転差 `D` は、分割後の二通過が横断するなら零、横断しないなら `±4 · turn 1`。 -/
theorem contact_local_table_necSuf (turn : ZMod 4 → ℤ) (h0 : turn 0 = 0) (h3 : turn 3 = -turn 1)
    {B : Type*} (ax : ZMod 4 → B) (hax1 : ∀ d, ax (d + 1) ≠ ax d) (hax2 : ∀ d, ax (d + 2) = ax d)
    (a b a' b' : ZMod 4)
    (d1 : a + 2 ≠ a') (d2 : b + 2 ≠ b') (d3 : a + 2 ≠ b + 2) (d4 : a + 2 ≠ b') (d5 : a' ≠ b + 2)
    (d6 : a' ≠ b') (hnc : ¬ (a' = a ∧ b' = b ∧ ax a ≠ ax b)) :
    ((turn (b' - a) + turn (a' - b)) - (turn (a' - a) + turn (b' - b)) = 0 ∧
        (a' = b ∧ b' = a ∧ ax b ≠ ax a)) ∨
      ((turn (b' - a) + turn (a' - b)) - (turn (a' - a) + turn (b' - b)) = 4 * turn 1 ∧
        ¬ (a' = b ∧ b' = a ∧ ax b ≠ ax a)) ∨
      ((turn (b' - a) + turn (a' - b)) - (turn (a' - a) + turn (b' - b)) = -(4 * turn 1) ∧
        ¬ (a' = b ∧ b' = a ∧ ax b ≠ ax a)) := by
  have hiff := axis_ne_iff_adjacent ax hax1 hax2 a b
  rw [ne_comm, hiff] at hnc
  rw [hiff]
  rcases contact_local_pattern_necSuf a b a' b' d1 d2 d3 d4 d5 d6 hnc with
    ⟨e1, e2, e34 | e34, hP⟩ | ⟨e1, e2, e3, e4, hP⟩ | ⟨e1, e2, e3, e4, hP⟩
  · left
    rw [e1, e2, e34.1, e34.2, h0, h3]
    exact ⟨by ring, hP⟩
  · left
    rw [e1, e2, e34.1, e34.2, h0, h3]
    exact ⟨by ring, hP⟩
  · right; right
    rw [e1, e2, e3, e4, h3]
    exact ⟨by ring, hP⟩
  · right; left
    rw [e1, e2, e3, e4, h3]
    exact ⟨by ring, hP⟩

/-- 回転差 `D` と分割後の混合横断の値 `c` から、`z ^ t = s ^ (1 + c) · z ^ (t_A + t_B)`。 -/
theorem contact_phase_sign_necSuf {G : Type*} [GroupWithZero G] {z s : G} (hz : z ≠ 0) (u : ℤ)
    (hs : z ^ (4 * u) = s) (hss : s * s = 1) (t tA tB D : ℤ) (c : ℕ)
    (hsum : tA + tB - t = D)
    (hcase : (D = 0 ∧ c = 1) ∨ (D = 4 * u ∧ c = 0) ∨ (D = -(4 * u) ∧ c = 0)) :
    z ^ t = s ^ (1 + (c : ZMod 2)).val * z ^ (tA + tB) := by
  -- 同じ `z` の整数冪どうしは可換である。
  have hcomm : s * z ^ t = z ^ t * s := by
    rw [← hs, ← zpow_add₀ hz, ← zpow_add₀ hz, add_comm]
  rcases hcase with ⟨hD, hc⟩ | ⟨hD, hc⟩ | ⟨hD, hc⟩
  · subst hc
    have h11 : ((1 : ZMod 2) + ((1 : ℕ) : ZMod 2)).val = 0 := by decide
    rw [h11, pow_zero, one_mul, show tA + tB = t by omega]
  · subst hc
    have h10 : ((1 : ZMod 2) + ((0 : ℕ) : ZMod 2)).val = 1 := by decide
    rw [h10, pow_one, show tA + tB = t + 4 * u by omega, zpow_add₀ hz, hs, ← mul_assoc, hcomm,
      mul_assoc, hss, mul_one]
  · subst hc
    have h10 : ((1 : ZMod 2) + ((0 : ℕ) : ZMod 2)).val = 1 := by decide
    have hs0 : s ≠ 0 := by
      rw [← hs]
      exact zpow_ne_zero _ hz
    rw [h10, pow_one, show tA + tB = t + -(4 * u) by omega, zpow_add₀ hz, zpow_neg, hs,
      ← mul_assoc, hcomm, mul_assoc, mul_inv_cancel₀ hs0, mul_one]

/-- 合成: 接触頂点の方向番号の条件、一歩の回転数の和の等式 `hsum`、分割後の混合横断数 `c` とその偶奇 `I`
から、`z ^ t = s ^ (1 + I) · z ^ (t_A + t_B)`。 -/
theorem crossing_free_contact_split_phase_necSuf {G : Type*} [GroupWithZero G] {z s : G}
    (hz : z ≠ 0) (turn : ZMod 4 → ℤ) (h0 : turn 0 = 0) (h3 : turn 3 = -turn 1)
    (hs : z ^ (4 * turn 1) = s) (hss : s * s = 1)
    {B : Type*} (ax : ZMod 4 → B) (hax1 : ∀ d, ax (d + 1) ≠ ax d) (hax2 : ∀ d, ax (d + 2) = ax d)
    (a b a' b' : ZMod 4)
    (d1 : a + 2 ≠ a') (d2 : b + 2 ≠ b') (d3 : a + 2 ≠ b + 2) (d4 : a + 2 ≠ b') (d5 : a' ≠ b + 2)
    (d6 : a' ≠ b') (hnc : ¬ (a' = a ∧ b' = b ∧ ax a ≠ ax b))
    (t tA tB : ℤ)
    (hsum : tA + tB - t = (turn (b' - a) + turn (a' - b)) - (turn (a' - a) + turn (b' - b)))
    (c : ℕ) [Decidable (a' = b ∧ b' = a ∧ ax b ≠ ax a)]
    (hc : c = if a' = b ∧ b' = a ∧ ax b ≠ ax a then 1 else 0)
    (I : ZMod 2) (hI : (c : ZMod 2) = I) :
    z ^ t = s ^ (1 + I).val * z ^ (tA + tB) := by
  rw [← hI]
  apply contact_phase_sign_necSuf hz (turn 1) hs hss t tA tB _ c hsum
  rcases contact_local_table_necSuf turn h0 h3 ax hax1 hax2 a b a' b' d1 d2 d3 d4 d5 d6 hnc with
    ⟨hD, hP⟩ | ⟨hD, hP⟩ | ⟨hD, hP⟩
  · exact Or.inl ⟨hD, by rw [hc, if_pos hP]⟩
  · exact Or.inr (Or.inl ⟨hD, by rw [hc, if_neg hP]⟩)
  · exact Or.inr (Or.inr ⟨hD, by rw [hc, if_neg hP]⟩)

end Ising2DLambda.NecSuf.KacWard
