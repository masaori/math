/-
章「零点の詰め寄り」の「零点と臨界点の距離の二乗」（`def_distance_squared_to_critical_point`）の
具体版。定義ブロックなので必要十分版は無い。

  人手証明                                                          このファイル
  x_c ∈ R（`claim_critical_point_mem_real_closed`）を第 2 引数に取る  `criticalPointRealClosed`
  dsq_c(ξ) := (a-x_c)(a-x_c) + b·b                                   `distanceSquaredToCriticalPoint`

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.DistanceSquaredToRational
import Ising2DLambda.FisherZero.CriticalPointMemRealClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `x_c = -1 + s` を `R` の元として取り出したもの（`claim_critical_point_mem_real_closed`）。 -/
noncomputable def criticalPointRealClosed (data : RealClosedSubfieldData) (s : Qbar)
    (hs : s * s = 2) : data.carrier :=
  Classical.choose (criticalPoint_mem_realClosed data s hs)

/-- 取り出した元の値はちょうど `-1 + s` である。 -/
theorem criticalPointRealClosed_val (data : RealClosedSubfieldData) (s : Qbar)
    (hs : s * s = 2) :
    ((criticalPointRealClosed data s hs : data.carrier) : Qbar) = -1 + s :=
  Classical.choose_spec (criticalPoint_mem_realClosed data s hs)

/-- `dsq_c(ξ) := (a-x_c)(a-x_c) + b·b`。 -/
noncomputable def distanceSquaredToCriticalPoint (data : RealClosedSubfieldData) (s : Qbar)
    (hs : s * s = 2) (xi : Qbar) : data.carrier :=
  let ab := realClosedComponents data xi
  let xc := criticalPointRealClosed data s hs
  (ab.1 - xc) * (ab.1 - xc) + ab.2 * ab.2

end Ising2DLambda.FisherZero
