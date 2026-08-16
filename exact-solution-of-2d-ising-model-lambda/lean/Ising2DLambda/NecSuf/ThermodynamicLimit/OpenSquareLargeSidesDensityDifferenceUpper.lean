/-
「基準辺の平方以上の二つの辺の密度の差の一様な上からの評価（q は 1 以下）」の必要十分版。

具体版が使うのは、関係 `le` の (1) 推移律、(2) 右から同じ元を足しても保たれること、
(3) 加法の結合則・交換則、(4) 逆元 `x + (−x) = 0`・`(−x) + x = 0`、(5) 単位元 `x + 0 = x`・`0 + x = x`、
だけである。上端 `ψL ≤ U + Ψ` と下端 `(D + Ψ) + (−tC) ≤ ψM` から `ψL + (−ψM) ≤ (U + (−D)) + tC` を得る。
有理数倍・係数・順序の線形性・`Λ_ℚ` は使わない。`AddCommGroup` の代わりに `AddCommMonoid` と `Neg` と
二つの逆元律だけで足りる（減法・整数倍は使わない）。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommMonoid X] [Neg X]

/-- 上端と下端から差の上からの評価を得る。 -/
theorem difference_upper_bound_from_upper_and_lower_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (hneg_add : ∀ x : X, x + -x = 0) (hadd_neg : ∀ x : X, -x + x = 0)
    (ψL ψM U Ψ D tC : X)
    (hup : le ψL (U + Ψ)) (hlow : le (D + Ψ + -tC) ψM) :
    le (ψL + -ψM) (U + -D + tC) := by
  -- 準備: 下端の両辺に (−D) + tC を足し、左辺を Ψ に戻す
  have hprep' := hadd (-D + tC) hlow
  have hre : D + Ψ + -tC + (-D + tC) = Ψ + ((D + -D) + (-tC + tC)) := by
    simp only [add_assoc, add_comm, add_left_comm]
  have hprep : le Ψ (ψM + (-D + tC)) := by
    rw [hre, hneg_add, hadd_neg, add_zero, add_zero] at hprep'
    exact hprep'
  -- 本体
  have h1 : le (ψL + -ψM) (U + Ψ + -ψM) := hadd (-ψM) hup
  have h2 : U + Ψ + -ψM = Ψ + (-ψM + U) := by
    simp only [add_assoc, add_comm, add_left_comm]
  have h3 : le (Ψ + (-ψM + U)) (ψM + (-D + tC) + (-ψM + U)) := hadd (-ψM + U) hprep
  have h4 : ψM + (-D + tC) + (-ψM + U) = (ψM + -ψM) + (U + (-D + tC)) := by
    simp only [add_assoc, add_comm, add_left_comm]
  have h5 : (ψM + -ψM) + (U + (-D + tC)) = U + -D + tC := by
    rw [hneg_add, zero_add]; exact (add_assoc _ _ _).symm
  rw [h2] at h1
  rw [h4, h5] at h3
  exact htrans h1 h3

end Ising2DLambda.NecSuf.ThermodynamicLimit
