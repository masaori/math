/-
「基準辺の平方以上の辺の密度の基準辺の密度による一様な下からの評価（q は 1 以下）」の必要十分版。

具体版の本体が使うのは、関係 `le` の (1) 推移律、(2) 右から同じ元を足しても保たれること、
(3) 加法の交換則、だけである。下端 `((x + y) + Ψ) + w ≤ ψ` と、第一の項の比較 `x' ≤ x`、
末尾の項の比較 `w' ≤ w`、和への分割 `D = x' + y` から `(D + Ψ) + w' ≤ ψ` を得る。
結合則・単位元・係数・有理数倍・逆元・`Λ_ℚ`・符号は本体には入らない
（それらは具体版の準備であり、`x' ≤ x`、`w' ≤ w`、`D = x' + y` の形で受け取る）。
`AddCommMagma` で足りる（結合則を使わないので `AddCommSemigroup` も要らない）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommMagma X]

/-- 下端の第一の項と末尾の項をそれぞれ小さくし、第一の項を分割の和で書く。 -/
theorem lower_bound_shrink_first_and_last_terms_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (ψ x x' y Ψ w w' D : X)
    (hlow : le (x + y + Ψ + w) ψ) (hx : le x' x) (hw : le w' w) (hD : D = x' + y) :
    le (D + Ψ + w') ψ := by
  -- 分割: D = x' + y
  rw [hD]
  -- (1) x' ≤ x に y を足し、Ψ を足し、w' を足す
  have h1 : le (x' + y + Ψ + w') (x + y + Ψ + w') := hadd w' (hadd Ψ (hadd y hx))
  -- (2) w' ≤ w に (x + y + Ψ) を足す（交換則で先頭へ寄せる）
  have h2' := hadd (x + y + Ψ) hw
  rw [add_comm w' (x + y + Ψ), add_comm w (x + y + Ψ)] at h2'
  exact htrans h1 (htrans h2' hlow)

end Ising2DLambda.NecSuf.ThermodynamicLimit
