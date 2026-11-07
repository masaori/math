/-
# 正の実数上の実対数は狭義単調増加（具体版を必要十分版から導く）

具体版 `ClaimRealLogStrictlyIncreasing.lean` の主張を、必要十分版
`Ising2D/NecSuf/InverseOfAdditiveToMultiplicativeMap.lean` の `NecSuf.inv_strictMono` の
`G := ℝ`、`R := ℝ`、`f := Real.exp`、`L := Real.log`、`P y := 0 < y` の特殊化として得る。人手のラベルは `real_log_strictly_increasing`。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimRealLogStrictlyIncreasing
import Ising2D.NecSuf.InverseOfAdditiveToMultiplicativeMap

namespace Ising2D

/-- `real_log_strictly_increasing` を `NecSuf.inv_strictMono` の特殊化として得る。 -/
theorem real_log_strictly_increasing_of_necSuf {u v : ℝ} (hu : 0 < u) (hv : 0 < v) (huv : u < v) :
    Real.log u < Real.log v :=
  NecSuf.inv_strictMono Real.exp Real.log (fun y => 0 < y) (fun _ _ h => Real.exp_lt_exp.2 h)
    (fun _ hy => Real.exp_log hy) hu hv huv

end Ising2D
