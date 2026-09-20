/-
章「Onsager 閉形式への接続」の「一側閉包は閉じた単位格子路である」
（`claim_one_sided_periodic_lift_closure_closed_unit_steps`）の具体版。

人手証明と同じく、周期持ち上げ・帯外へ上がる横断階段・逆向きの平行階段列・
始点へ降りる横断階段の四部分を連結する。境界の一致で閉性を示し、各部分の一歩から
全ての連続差が単位格子ベクトルであることを示す。住処は ℕ と ℤ だけである。
-/
import Ising2DLambda.NecSuf.KacWard.OneSidedPeriodicLiftClosure

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_one_sided_periodic_lift_closure`。第四部分を逆向きにたどる四部分の一側閉包。 -/
def oneSidedPeriodicLiftClosure
    (periodicLift upperStaircase parallelReturn lowerStaircase : ℕ → ℤ × ℤ)
    (periodLength transverseLength parallelLength j : ℕ) : ℤ × ℤ :=
  oneSidedFourSegmentPath periodicLift upperStaircase parallelReturn lowerStaircase
    periodLength transverseLength parallelLength j

/-- `claim_one_sided_periodic_lift_closure_closed_unit_steps` の具体版。 -/
theorem oneSidedPeriodicLiftClosure_closed_unit_steps
    (periodicLift upperStaircase parallelReturn lowerStaircase : ℕ → ℤ × ℤ)
    (periodLength transverseLength parallelLength : ℕ)
    (hperiodLength : 0 < periodLength)
    (htransverseLength : 0 < transverseLength)
    (hparallelLength : 0 < parallelLength)
    (h12 : periodicLift periodLength = upperStaircase 0)
    (h23 : upperStaircase transverseLength = parallelReturn 0)
    (h34 : parallelReturn parallelLength = lowerStaircase transverseLength)
    (h41 : lowerStaircase 0 = periodicLift 0)
    (hperiodicLift : ∀ i < periodLength,
      |(periodicLift (i + 1)).1 - (periodicLift i).1| +
        |(periodicLift (i + 1)).2 - (periodicLift i).2| = 1)
    (hupperStaircase : ∀ i < transverseLength,
      |(upperStaircase (i + 1)).1 - (upperStaircase i).1| +
        |(upperStaircase (i + 1)).2 - (upperStaircase i).2| = 1)
    (hparallelReturn : ∀ i < parallelLength,
      |(parallelReturn (i + 1)).1 - (parallelReturn i).1| +
        |(parallelReturn (i + 1)).2 - (parallelReturn i).2| = 1)
    (hlowerStaircase : ∀ i < transverseLength,
      |(lowerStaircase (i + 1)).1 - (lowerStaircase i).1| +
        |(lowerStaircase (i + 1)).2 - (lowerStaircase i).2| = 1) :
    oneSidedPeriodicLiftClosure periodicLift upperStaircase parallelReturn lowerStaircase
        periodLength transverseLength parallelLength 0 = periodicLift 0 ∧
      oneSidedPeriodicLiftClosure periodicLift upperStaircase parallelReturn lowerStaircase
        periodLength transverseLength parallelLength
          (periodLength + 2 * transverseLength + parallelLength) = periodicLift 0 ∧
      ∀ j < periodLength + 2 * transverseLength + parallelLength,
        |(oneSidedPeriodicLiftClosure periodicLift upperStaircase parallelReturn lowerStaircase
            periodLength transverseLength parallelLength (j + 1)).1 -
            (oneSidedPeriodicLiftClosure periodicLift upperStaircase parallelReturn lowerStaircase
              periodLength transverseLength parallelLength j).1| +
          |(oneSidedPeriodicLiftClosure periodicLift upperStaircase parallelReturn lowerStaircase
            periodLength transverseLength parallelLength (j + 1)).2 -
            (oneSidedPeriodicLiftClosure periodicLift upperStaircase parallelReturn lowerStaircase
              periodLength transverseLength parallelLength j).2| = 1 := by
  exact one_sided_four_segments_closed_steps_necSuf
    (fun p q : ℤ × ℤ => |q.1 - p.1| + |q.2 - p.2| = 1)
    periodicLift upperStaircase parallelReturn lowerStaircase
    periodLength transverseLength parallelLength
    hperiodLength htransverseLength hparallelLength h12 h23 h34 h41
    hperiodicLift hupperStaircase hparallelReturn
    (fun i hi => by simpa [abs_sub_comm] using hlowerStaircase i hi)

end Ising2DLambda.KacWard
