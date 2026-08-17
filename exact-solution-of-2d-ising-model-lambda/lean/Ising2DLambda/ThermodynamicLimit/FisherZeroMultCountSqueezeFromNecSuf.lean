/-
「個数は重複度付きの個数を超えない」の具体版が、必要十分版の特殊化として得られることの導出
（`α := Qbar`、`s := F_L ∩ D(c,r)`、`f := ξ ↦ mult_ξ(Ẑ_L^F)`）。
具体側の仕事は「各項が 1 以上」を供給することだけである。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.FisherZeroMultCountSqueeze
import Ising2DLambda.NecSuf.ThermodynamicLimit.FisherZeroMultCountSqueeze

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.PartitionPolynomial

variable (L : ℕ) [NeZero L]

theorem fisherZeroCount_le_fisherZeroMultCount_from_necSuf
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    fisherZeroCountInRationalDisc L data c r ≤ fisherZeroMultCountInRationalDisc L data c r := by
  rw [← fisherZeroMultCount_index_card L data c r, fisherZeroMultCountInRationalDisc]
  exact Ising2DLambda.NecSuf.ThermodynamicLimit.card_le_sum_of_one_le_necSuf
    (fisherZeroMultCountIndex L data c r)
    (fun ξ => qbarRootMultiplicity ξ (integerPolynomialQbarLift (partitionPolynomial L))
      (integerPolynomialQbarLift_partitionPolynomial_ne_zero L))
    (one_le_fisherZeroMultiplicity L data c r)

end Ising2DLambda.ThermodynamicLimit
