/-
「基準辺の平方以上の二つの辺の密度の差の一様な下からの評価（q は 1 以下）」の必要十分版。

具体版が使うのは、(1) 入れ替えた上端 `ψM + (−ψL) ≤ R`、(2) 逆元による順序の反転
`x ≤ y → −y ≤ −x`、(3) 等式 `−(ψM + (−ψL)) = ψL + (−ψM)`、だけである。
(3) を具体版は素数ごとの ℚ の四則で示すが、必要十分版ではこの等式そのものを仮定として受ける
（本文の準備の結論に当たる。`Λ_ℚ` の中身も、加法群の公理も、順序の推移律も要らない）。
したがって型 `X` には `Add` と `Neg` だけがあればよい。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [Add X] [Neg X]

/-- 入れ替えた上端と逆元の順序反転から差の下からの評価を得る。 -/
theorem difference_lower_bound_from_swapped_upper_necSuf (le : X → X → Prop)
    (hneg : ∀ {x y : X}, le x y → le (-y) (-x))
    (ψL ψM R : X)
    (hswap : le (ψM + -ψL) R)
    (hprep : -(ψM + -ψL) = ψL + -ψM) :
    le (-R) (ψL + -ψM) := by
  have h1 := hneg hswap
  rwa [hprep] at h1

end Ising2DLambda.NecSuf.ThermodynamicLimit
