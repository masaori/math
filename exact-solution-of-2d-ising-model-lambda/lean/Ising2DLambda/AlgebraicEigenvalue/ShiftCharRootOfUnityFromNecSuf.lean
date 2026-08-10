/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  R := ℤ[x][t]（`SecondPoly`）        M := Qbar        β := OrbitIndex L
  φ := evalSecond ξ z                 A := RootOfUnity  n := fun O => O.1.card
  s := Finset.univ                    N := L
  f := fun O => t ^ |O| + ι(-κ(1))

すなわちこの段が要求するのは、**φ が有限積を有限積へ写すこと・値の側が可換群に零元を
添えた構造であること・各因子から所属が出ること・各指数が L を割り切ること・所属先が整除で
単調であること**だけであり、多項式であることも特性多項式であることも軌道であることも
使っていない。積の側は可換モノイドで足りる（和も分配則も使わない）。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharRootOfUnity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharRootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- 具体版は必要十分版の特殊化である。 -/
theorem rootOfUnity_of_charPoly_shiftMatrix_eval_eq_zero_from_necSuf
    (L : ℕ) [NeZero L] {ξ z : Qbar}
    (h : evalSecond ξ z (charPoly L (shiftMatrix L)) = 0) :
    z ∈ RootOfUnity L := by
  classical
  have hprod : evalSecond ξ z
      (∏ O : OrbitIndex L, ((X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1)))) = 0 := by
    rw [← charPoly_shiftMatrix_eq_prod_orbit_factor]
    exact h
  exact
    NecSuf.AlgebraicEigenvalue.mem_of_prod_eval_eq_zero_necSuf
      (β := OrbitIndex L) (evalSecond ξ z)
      (fun s f => evalSecond_prod ξ z s f)
      (A := fun n => RootOfUnity n)
      (fun hd => rootOfUnity_of_dvd hd)
      (n := fun O => O.1.card) (N := L)
      (fun _ _ hzero => rootOfUnity_of_orbitFactor_eval_eq_zero hzero)
      (fun O _ => orbitCard_dvd_L O)
      hprod

end Ising2DLambda.AlgebraicEigenvalue
