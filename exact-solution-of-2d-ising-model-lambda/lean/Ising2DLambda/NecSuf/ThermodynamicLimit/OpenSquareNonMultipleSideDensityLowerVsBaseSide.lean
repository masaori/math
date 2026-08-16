/-
「倍数でない辺の密度の基準辺の密度による下からの評価（q は 1 以下）」の必要十分版。

具体版の本体が使うのは、関係 `le` の (1) 推移律、(2) 右から同じ元を足しても保たれること、
(3) 加法の結合則と交換則と単位元（`AddCommMonoid`）、(4) 逆元 `x + -x = 0`、だけである。
密度 `ψ` が二つの項 `x + y` に割れていること（具体版では分配則）、誤差の項の比較 `y ≤ z`、
下からの評価 `base ≤ ψ`、下端 `w + x ≤ big` から `w + (base + -z) ≤ big` を得る。
係数・有理数倍・`Λ_ℚ`・符号は本体には入らない（それらは具体版の準備であり、`ψ = x + y` と `y ≤ z` の形で受け取る）。
`AddCommGroup` まで要求しない: 減法や整数倍は使わず、逆元は `x + -x = 0` の一本しか使わないので、
`Neg` と仮定 `hneg` で受ける。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommMonoid X] [Neg X]

/-- 密度を二つの項に割り、片方を押さえ、逆元を足して移項し、下からの評価と下端へつなぐ。 -/
theorem lower_bound_split_and_shift_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (hneg : ∀ x : X, x + -x = 0)
    (ψ x y z base w big : X)
    (hsplit : ψ = x + y) (hy : le y z) (hbase : le base ψ) (hlow : le (w + x) big) :
    le (w + (base + -z)) big := by
  -- (1) ψ = x + y ≤ x + z（加法単調性。交換則で寄せる）
  have h1 : le ψ (x + z) := by
    rw [hsplit]
    have h := hadd x hy
    rw [add_comm y x, add_comm z x] at h
    exact h
  -- (2) 両辺に −z を足す。結合則・逆元・単位元
  have h2 : le (ψ + -z) x := by
    have h := hadd (-z) h1
    rw [add_assoc, hneg, add_zero] at h
    exact h
  -- (3) base ≤ ψ に −z と w を足し、(2) に w を足し、推移律で下端へ
  have h3 := hadd w (hadd (-z) hbase)
  rw [add_comm _ w, add_comm (ψ + -z) w] at h3
  have h4 := hadd w h2
  rw [add_comm (ψ + -z) w, add_comm x w] at h4
  exact htrans h3 (htrans h4 hlow)

end Ising2DLambda.NecSuf.ThermodynamicLimit
