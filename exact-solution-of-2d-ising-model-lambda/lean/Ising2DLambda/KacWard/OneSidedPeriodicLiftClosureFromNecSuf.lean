/- 具体版が必要十分版の四部分の有限路への特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.OneSidedPeriodicLiftClosure

namespace Ising2DLambda.KacWard

/-- `claim_one_sided_periodic_lift_closure_closed_unit_steps` を必要十分版から導いたもの。 -/
theorem oneSidedPeriodicLiftClosure_closed_unit_steps_from_necSuf
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
              periodLength transverseLength parallelLength j).2| = 1 :=
  oneSidedPeriodicLiftClosure_closed_unit_steps
    periodicLift upperStaircase parallelReturn lowerStaircase
    periodLength transverseLength parallelLength
    hperiodLength htransverseLength hparallelLength h12 h23 h34 h41
    hperiodicLift hupperStaircase hparallelReturn hlowerStaircase

end Ising2DLambda.KacWard
