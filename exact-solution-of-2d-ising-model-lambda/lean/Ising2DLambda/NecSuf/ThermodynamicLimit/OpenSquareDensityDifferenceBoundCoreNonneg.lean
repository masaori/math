/-
「核は非負である」の必要十分版。

具体版が使うのは、関係 `le` の (1) 推移律、(2) 右から同じ元を足しても保たれること、
(3) 非負の有理数倍で保たれること `0 ≤ c → le x y → le (c•x) (c•y)`、(4) 逆元が向きを反転すること、
そして (5) 有理数倍 `c • 0 = 0`、(6) 逆元 `−0 = 0`、(7) 加法の単位元 `x + 0 = x`・`0 + x = x`、
(8) 加法の交換則、だけである。符号 `0 ≤ g2`、`0 ≤ l1q`、`lq ≤ 0` は仮定として受ける
（具体版では埋め込んだ対数の順序から得る）。加法群の公理のうち結合則・逆元律は使わない。
`AddCommMonoid`（単位元・交換則）と `Neg`・`SMul ℚ X` があればよく、`c • 0 = 0` と `−0 = 0` は
型クラスからは出ないので仮定として受ける。順序の線形性・`Λ_ℚ` は使わない。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Field.Rat
import Mathlib.Tactic.NormNum

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommMonoid X] [Neg X] [SMul ℚ X]

/-- 三つの符号から核 `((2•g2 + 4•l1q) + −(4•lq)) + 2•(g2 + 2•l1q)` が非負であること。 -/
theorem zero_le_core_of_signs_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (hsmul : ∀ {c : ℚ} {x y : X}, 0 ≤ c → le x y → le (c • x) (c • y))
    (hneg : ∀ {x y : X}, le x y → le (-y) (-x))
    (hsmul_zero : ∀ c : ℚ, c • (0 : X) = 0) (hneg_zero : -(0 : X) = 0)
    (g2 l1q lq : X) (hg2 : le 0 g2) (hl1q : le 0 l1q) (hlq : le lq 0) :
    le 0 ((((2 : ℚ) • g2 + (4 : ℚ) • l1q) + -((4 : ℚ) • lq)) + (2 : ℚ) • (g2 + (2 : ℚ) • l1q)) := by
  -- 準備の第二: 0 = 2·0 ≤ 2·g2、0 = 4·0 ≤ 4·l1q = 0 + 4·l1q ≤ 2·g2 + 4·l1q
  have ha : le 0 ((2 : ℚ) • g2) := by
    have h := hsmul (by norm_num : (0 : ℚ) ≤ 2) hg2
    rwa [hsmul_zero] at h
  have hb : le 0 ((4 : ℚ) • l1q) := by
    have h := hsmul (by norm_num : (0 : ℚ) ≤ 4) hl1q
    rwa [hsmul_zero] at h
  have hX : le 0 ((2 : ℚ) • g2 + (4 : ℚ) • l1q) := by
    have hc := hadd ((4 : ℚ) • l1q) ha
    rw [zero_add] at hc
    exact htrans hb hc
  -- 準備の第三: 4·lq ≤ 4·0 = 0、0 = −0 ≤ −(4·lq)
  have hY : le ((4 : ℚ) • lq) 0 := by
    have h := hsmul (by norm_num : (0 : ℚ) ≤ 4) hlq
    rwa [hsmul_zero] at h
  have hnY : le 0 (-((4 : ℚ) • lq)) := by
    have h := hneg hY
    rwa [hneg_zero] at h
  -- 準備の第四: 0 = 2·0 ≤ 2·l1q = 0 + 2·l1q ≤ g2 + 2·l1q = C、0 = 2·0 ≤ 2·C
  have hC : le 0 (g2 + (2 : ℚ) • l1q) := by
    have hs : le 0 ((2 : ℚ) • l1q) := by
      have h := hsmul (by norm_num : (0 : ℚ) ≤ 2) hl1q
      rwa [hsmul_zero] at h
    have hc := hadd ((2 : ℚ) • l1q) hg2
    rw [zero_add] at hc
    exact htrans hs hc
  have hC2 : le 0 ((2 : ℚ) • (g2 + (2 : ℚ) • l1q)) := by
    have h := hsmul (by norm_num : (0 : ℚ) ≤ 2) hC
    rwa [hsmul_zero] at h
  -- 本体
  set Xv := (2 : ℚ) • g2 + (4 : ℚ) • l1q with hXv
  set Yv := (4 : ℚ) • lq with hYv
  set Cv := g2 + (2 : ℚ) • l1q with hCv
  have h1 : le 0 (0 + Xv) := by
    have h := hadd 0 hX
    rwa [add_zero (0 : X), add_comm Xv 0] at h
  have h2 : le (0 + Xv) (Xv + -Yv) := by
    have h := hadd Xv hnY
    rwa [add_comm (-Yv) Xv] at h
  have h3 : le (Xv + -Yv) ((Xv + -Yv) + (2 : ℚ) • Cv) := by
    have h := hadd (Xv + -Yv) hC2
    rwa [zero_add, add_comm ((2 : ℚ) • Cv) (Xv + -Yv)] at h
  exact htrans h1 (htrans h2 h3)

end Ising2DLambda.NecSuf.ThermodynamicLimit
