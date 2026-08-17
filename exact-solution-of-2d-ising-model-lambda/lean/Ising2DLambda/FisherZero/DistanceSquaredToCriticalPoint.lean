/-
章「零点の詰め寄り」の「零点と臨界点の距離の二乗」（`def_distance_squared_to_critical_point`）の
具体版。定義ブロックなので必要十分版は無い。

  人手証明                                                          このファイル
  dsq_R(ξ,r) := (a-r)(a-r) + b·b（第 2 引数を R の元へ広げる）        `distanceSquaredToRealClosed`
  有理点の場合は dsq と一致する                                       `..._eq_distanceSquaredToRational`
  x_c ∈ R（`claim_critical_point_mem_real_closed`）を第 2 引数に取る  `criticalPointRealClosed`
  dsq_c(ξ) := dsq_R(ξ, x_c)                                          `distanceSquaredToCriticalPoint`

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.DistanceSquaredToRational
import Ising2DLambda.FisherZero.CriticalPointMemRealClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `dsq_R(ξ, r)`。第 2 引数を `R` の元へ広げた距離の二乗。 -/
noncomputable def distanceSquaredToRealClosed
    (data : RealClosedSubfieldData) (xi : Qbar) (r : data.carrier) : data.carrier :=
  let ab := realClosedComponents data xi
  (ab.1 - r) * (ab.1 - r) + ab.2 * ab.2

/-- 有理点を `R` の元と見れば、`def_distance_squared_to_rational` の写像と一致する。 -/
theorem distanceSquaredToRealClosed_eq_distanceSquaredToRational
    (data : RealClosedSubfieldData) (xi : Qbar) (q : ℚ) :
    distanceSquaredToRealClosed data xi
        ⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩
      = distanceSquaredToRational data xi q := rfl

/-- `x_c = -1 + s` を `R` の元として取り出したもの（`claim_critical_point_mem_real_closed`）。 -/
noncomputable def criticalPointRealClosed (data : RealClosedSubfieldData) (s : Qbar)
    (hs : s * s = 2) : data.carrier :=
  Classical.choose (criticalPoint_mem_realClosed data s hs)

/-- 取り出した元の値はちょうど `-1 + s` である。 -/
theorem criticalPointRealClosed_val (data : RealClosedSubfieldData) (s : Qbar)
    (hs : s * s = 2) :
    ((criticalPointRealClosed data s hs : data.carrier) : Qbar) = -1 + s :=
  Classical.choose_spec (criticalPoint_mem_realClosed data s hs)

/-- `dsq_c(ξ) := dsq_R(ξ, x_c)`。 -/
noncomputable def distanceSquaredToCriticalPoint (data : RealClosedSubfieldData) (s : Qbar)
    (hs : s * s = 2) (xi : Qbar) : data.carrier :=
  distanceSquaredToRealClosed data xi (criticalPointRealClosed data s hs)

end Ising2DLambda.FisherZero
