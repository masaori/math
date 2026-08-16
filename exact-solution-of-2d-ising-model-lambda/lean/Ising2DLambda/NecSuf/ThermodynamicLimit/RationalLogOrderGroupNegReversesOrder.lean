/-
「有理係数の対数順序群の逆元は順序を反転する」の必要十分版。

具体版が使うのは、関係 `le` が (1) 右から同じ元を足しても保たれること、
(2) 加法の結合則・交換則、(3) 逆元 `x + (−x) = 0`、(4) 単位元 `0 + x = x`、だけである。
`AddCommMonoid` と `Neg` と逆元律 1 本で足りる（`(−x) + x = 0` の側も、減法・整数倍・有理数倍・
順序の推移律・線形性・`Λ_ℚ` も使わない）。交換則は右辺で `−λ` と `−μ` の順を入れ替えるところで要る
（右加法単調性しか無いので、`μ` を消すには `−μ` を `μ` の隣へ寄せる必要がある）。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommMonoid X] [Neg X]

/-- `x ≤ y` から `−y ≤ −x`。両辺に `(−x) + (−y)` を足して整える。 -/
theorem neg_le_neg_of_le_necSuf (le : X → X → Prop)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (hneg_add : ∀ x : X, x + -x = 0)
    {x y : X} (h : le x y) : le (-y) (-x) := by
  have h' := hadd (-x + -y) h
  have hl : x + (-x + -y) = -y := by
    rw [← add_assoc, hneg_add, zero_add]
  have hr : y + (-x + -y) = -x := by
    rw [add_comm (-x) (-y), ← add_assoc, hneg_add, zero_add]
  rwa [hl, hr] at h'

end Ising2DLambda.NecSuf.ThermodynamicLimit
