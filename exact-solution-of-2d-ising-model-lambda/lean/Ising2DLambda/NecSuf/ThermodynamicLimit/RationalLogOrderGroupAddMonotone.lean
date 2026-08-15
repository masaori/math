/-
「有理係数の対数順序群の順序は加法について単調である」の必要十分版。

具体版が使うのは次だけである。添字 `i`（共通分母）と元 `x` に証人 `w` を対応させる関係 `Rep`、
良い添字 `Good`（`N ≥ 1`）、証人の住処 `Y`（`Λ`）の関係 `le`、`X` と `Y` の加法について、
(1) 任意の三元に共通の良い添字と証人が在ること（`N_λ N_μ N_ν`）、
(2) 二つの良い添字の間で `le` の真偽が一致すること（順序判定の共通分母からの独立性）、
(3) 同じ添字で `Rep` が加法を保つこと（`N·(λ+ν) = ι(λ_N+ν_N)`。有理数倍の分配則と `ι` の加法性）、
(4) `le` が加法について単調であること（`Λ` の順序の加法単調性）。
順序・対数順序群・共通分母の中身、加法の結合則・可換則は本質でない。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupLinearOrder

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {I X Y : Type*}

/-- 加法単調性。三元の共通の良い添字へ移し（独立性で証人の比較を移し替え）、
同じ添字で `Rep` が加法を保つことで和の証人を作り、`le` の加法単調性へ落とす。 -/
theorem indexedLE_add_right_necSuf [Add X] [Add Y]
    (Rep : I → X → Y → Prop) (Good : I → Prop) (le : Y → Y → Prop)
    (hex3 : ∀ x y z : X, ∃ (i : I) (wx wy wz : Y),
      Good i ∧ Rep i x wx ∧ Rep i y wy ∧ Rep i z wz)
    (hind : ∀ (i j : I) (x y : X) (wx wy wx' wy' : Y), Good i → Good j →
      Rep i x wx → Rep i y wy → Rep j x wx' → Rep j y wy' → (le wx wy ↔ le wx' wy'))
    (hadd : ∀ (i : I) (x z : X) (wx wz : Y), Rep i x wx → Rep i z wz → Rep i (x + z) (wx + wz))
    (hmono : ∀ a b c : Y, le a b → le (a + c) (b + c))
    {x y : X} (h : indexedLE Rep Good le x y) (z : X) :
    indexedLE Rep Good le (x + z) (y + z) := by
  obtain ⟨i, wx, wy, wz, hi, hx, hy, hz⟩ := hex3 x y z
  obtain ⟨j, ux, uy, hj, hux, huy, hle⟩ := h
  have e : le wx wy := (hind j i x y ux uy wx wy hj hi hux huy hx hy).mp hle   -- 独立性
  exact ⟨i, wx + wz, wy + wz, hi, hadd i x z wx wz hx hz, hadd i y z wy wz hy hz,
    hmono wx wy wz e⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
