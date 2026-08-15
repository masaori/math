/-
「有限系の密度の分母は整数倍で払える」の必要十分版。
格子・自由エントロピー・有限台写像を外し、体上の加群における同じ係数計算だけを残す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 非零な二係数で割った二要素へ積を作用させると、それぞれ反対側の係数倍になる。 -/
theorem two_scaled_denominators_cancel_necSuf
    {K A : Type*} [Field K] [AddCommGroup A] [Module K A]
    (a b : K) (ha : a ≠ 0) (hb : b ≠ 0) (x y : A) :
    ((a * b) • ((1 / a) • x) = b • x) ∧
    ((a * b) • ((1 / b) • y) = a • y) := by
  constructor
  · simp only [smul_smul]
    congr 1
    field_simp
  · simp only [smul_smul]
    congr 1
    field_simp

end Ising2DLambda.NecSuf.ThermodynamicLimit
