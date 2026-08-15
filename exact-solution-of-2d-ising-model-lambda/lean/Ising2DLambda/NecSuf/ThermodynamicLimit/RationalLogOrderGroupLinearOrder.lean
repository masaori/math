/-
「有理係数の対数順序群の順序は線形順序である」の必要十分版。

具体版が使うのは次だけである。添字 `i`（共通分母）と元 `x` に証人 `w` を対応させる関係 `Rep`、
良い添字 `Good`（`N ≥ 1`）、証人の住処 `Y`（`Λ`）の関係 `le` について、
(1) 任意の三元に共通の良い添字と証人が在ること（`N_λ N_μ N_ν`）、
(2) 二つの良い添字の間で `le` の真偽が一致すること（順序判定の共通分母からの独立性）、
(3) `le` が同じ名前の性質を持つこと（`Λ` の順序の線形順序性）、
(4) 反対称律だけ、同じ良い添字で証人が一致すれば元が一致すること（`N⁻¹` 倍で戻す）。
順序・対数順序群・共通分母の中身は本質でない。四つの性質はそれぞれ使う仮定だけを取る。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {I X Y : Type*}

/-- 定義の形: ある良い添字で、両者の証人が `le` を満たす。 -/
def indexedLE (Rep : I → X → Y → Prop) (Good : I → Prop) (le : Y → Y → Prop) (x y : X) : Prop :=
  ∃ (i : I) (wx wy : Y), Good i ∧ Rep i x wx ∧ Rep i y wy ∧ le wx wy

/-- 反射律。使うのは、元自身に良い添字と証人が在ることと、`le` の反射律だけ。 -/
theorem indexedLE_refl_necSuf (Rep : I → X → Y → Prop) (Good : I → Prop) (le : Y → Y → Prop)
    (hex : ∀ x : X, ∃ (i : I) (w : Y), Good i ∧ Rep i x w)
    (hrefl : ∀ a : Y, le a a) (x : X) : indexedLE Rep Good le x x := by
  obtain ⟨i, w, hi, hw⟩ := hex x
  exact ⟨i, w, w, hi, hw, hw, hrefl w⟩

/-- 推移律。三元の共通の良い添字へ移し（独立性で証人の比較を移し替え）、`le` の推移律へ落とす。 -/
theorem indexedLE_trans_necSuf (Rep : I → X → Y → Prop) (Good : I → Prop) (le : Y → Y → Prop)
    (hex3 : ∀ x y z : X, ∃ (i : I) (wx wy wz : Y),
      Good i ∧ Rep i x wx ∧ Rep i y wy ∧ Rep i z wz)
    (hind : ∀ (i j : I) (x y : X) (wx wy wx' wy' : Y), Good i → Good j →
      Rep i x wx → Rep i y wy → Rep j x wx' → Rep j y wy' → (le wx wy ↔ le wx' wy'))
    (htrans : ∀ a b c : Y, le a b → le b c → le a c)
    {x y z : X} (h1 : indexedLE Rep Good le x y) (h2 : indexedLE Rep Good le y z) :
    indexedLE Rep Good le x z := by
  obtain ⟨i, wx, wy, wz, hi, hx, hy, hz⟩ := hex3 x y z
  obtain ⟨j, ux, uy, hj, hux, huy, hle1⟩ := h1
  obtain ⟨k, vy, vz, hk, hvy, hvz, hle2⟩ := h2
  have e1 : le wx wy := (hind j i x y ux uy wx wy hj hi hux huy hx hy).mp hle1   -- 独立性
  have e2 : le wy wz := (hind k i y z vy vz wy wz hk hi hvy hvz hy hz).mp hle2   -- 独立性
  exact ⟨i, wx, wz, hi, hx, hz, htrans wx wy wz e1 e2⟩

/-- 反対称律。共通の良い添字で `le` の反対称律から証人の一致を得て、証人の一致から元の一致へ戻す。 -/
theorem indexedLE_antisymm_necSuf (Rep : I → X → Y → Prop) (Good : I → Prop) (le : Y → Y → Prop)
    (hex2 : ∀ x y : X, ∃ (i : I) (wx wy : Y), Good i ∧ Rep i x wx ∧ Rep i y wy)
    (hind : ∀ (i j : I) (x y : X) (wx wy wx' wy' : Y), Good i → Good j →
      Rep i x wx → Rep i y wy → Rep j x wx' → Rep j y wy' → (le wx wy ↔ le wx' wy'))
    (hanti : ∀ a b : Y, le a b → le b a → a = b)
    (hinj : ∀ (i : I) (x y : X) (w : Y), Good i → Rep i x w → Rep i y w → x = y)
    {x y : X} (h1 : indexedLE Rep Good le x y) (h2 : indexedLE Rep Good le y x) : x = y := by
  obtain ⟨i, wx, wy, hi, hx, hy⟩ := hex2 x y
  obtain ⟨j, ux, uy, hj, hux, huy, hle1⟩ := h1
  obtain ⟨k, vy, vx, hk, hvy, hvx, hle2⟩ := h2
  have e1 : le wx wy := (hind j i x y ux uy wx wy hj hi hux huy hx hy).mp hle1   -- 独立性
  have e2 : le wy wx := (hind k i y x vy vx wy wx hk hi hvy hvx hy hx).mp hle2   -- 独立性
  have hw : wx = wy := hanti wx wy e1 e2                                          -- 証人の一致
  rw [hw] at hx
  exact hinj i x y wy hi hx hy                                                    -- 元の一致

/-- 全順序性。使うのは、二元に共通の良い添字と証人が在ることと、`le` の全順序性だけ。 -/
theorem indexedLE_total_necSuf (Rep : I → X → Y → Prop) (Good : I → Prop) (le : Y → Y → Prop)
    (hex2 : ∀ x y : X, ∃ (i : I) (wx wy : Y), Good i ∧ Rep i x wx ∧ Rep i y wy)
    (htotal : ∀ a b : Y, le a b ∨ le b a) (x y : X) :
    indexedLE Rep Good le x y ∨ indexedLE Rep Good le y x := by
  obtain ⟨i, wx, wy, hi, hx, hy⟩ := hex2 x y
  rcases htotal wx wy with h | h
  · exact Or.inl ⟨i, wx, wy, hi, hx, hy, h⟩
  · exact Or.inr ⟨i, wy, wx, hi, hy, hx, h⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
