/-
章「Onsager 閉形式への接続」の「一側閉包は終点を除いて頂点を繰り返さない」
（`claim_one_sided_periodic_lift_closure_simple`）の具体版。

人手証明と同じく、周期持ち上げ・上り階段・反転平行階段・下り階段の
四部分内の単射性と、異なる部分の六つの非交差を合成する。住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.OneSidedPeriodicLiftClosure
import Ising2DLambda.NecSuf.KacWard.OneSidedPeriodicLiftClosureSimple

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `claim_one_sided_periodic_lift_closure_simple` の具体版。 -/
theorem oneSidedPeriodicLiftClosure_injective
    (periodicLift upperStaircase parallelReturn lowerStaircase : ℕ → ℤ × ℤ)
    (periodLength transverseLength parallelLength : ℕ)
    (hperiodicLift : ∀ i < periodLength, ∀ j < periodLength,
      periodicLift i = periodicLift j → i = j)
    (hupperStaircase : ∀ i < transverseLength, ∀ j < transverseLength,
      upperStaircase i = upperStaircase j → i = j)
    (hparallelReturn : ∀ i < parallelLength, ∀ j < parallelLength,
      parallelReturn i = parallelReturn j → i = j)
    (hlowerStaircase : ∀ i, 0 < i → i ≤ transverseLength →
      ∀ j, 0 < j → j ≤ transverseLength → lowerStaircase i = lowerStaircase j → i = j)
    (h12 : ∀ i < periodLength, ∀ j < transverseLength,
      periodicLift i ≠ upperStaircase j)
    (h13 : ∀ i < periodLength, ∀ j < parallelLength,
      periodicLift i ≠ parallelReturn j)
    (h14 : ∀ i < periodLength, ∀ j, 0 < j → j ≤ transverseLength →
      periodicLift i ≠ lowerStaircase j)
    (h23 : ∀ i < transverseLength, ∀ j < parallelLength,
      upperStaircase i ≠ parallelReturn j)
    (h24 : ∀ i < transverseLength, ∀ j, 0 < j → j ≤ transverseLength →
      upperStaircase i ≠ lowerStaircase j)
    (h34 : ∀ i < parallelLength, ∀ j, 0 < j → j ≤ transverseLength →
      parallelReturn i ≠ lowerStaircase j) :
    ∀ i < periodLength + 2 * transverseLength + parallelLength,
      ∀ j < periodLength + 2 * transverseLength + parallelLength,
        oneSidedPeriodicLiftClosure periodicLift upperStaircase parallelReturn lowerStaircase
            periodLength transverseLength parallelLength i =
          oneSidedPeriodicLiftClosure periodicLift upperStaircase parallelReturn lowerStaircase
            periodLength transverseLength parallelLength j → i = j := by
  exact one_sided_four_segment_path_injective_necSuf
    periodicLift upperStaircase parallelReturn lowerStaircase
    periodLength transverseLength parallelLength
    hperiodicLift hupperStaircase hparallelReturn hlowerStaircase
    h12 h13 h14 h23 h24 h34

end Ising2DLambda.KacWard
