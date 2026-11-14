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
  let AllowedStep : (ℤ × ℤ) → (ℤ × ℤ) → Prop :=
    fun p q => |q.1 - p.1| + |q.2 - p.2| = 1
  have hfirst : ∀ i < periodLength, AllowedStep (periodicLift i) (periodicLift (i + 1)) :=
    hperiodicLift
  have hsecond : ∀ i < transverseLength,
      AllowedStep (upperStaircase i) (upperStaircase (i + 1)) := hupperStaircase
  have hthird : ∀ i < parallelLength,
      AllowedStep (parallelReturn i) (parallelReturn (i + 1)) := hparallelReturn
  have hfourth : ∀ i < transverseLength,
      AllowedStep (lowerStaircase (i + 1)) (lowerStaircase i) := by
    intro i hi
    simpa only [AllowedStep, abs_sub_comm] using hlowerStaircase i hi
  change oneSidedFourSegmentPath periodicLift upperStaircase parallelReturn lowerStaircase
      periodLength transverseLength parallelLength 0 = periodicLift 0 ∧
    oneSidedFourSegmentPath periodicLift upperStaircase parallelReturn lowerStaircase
      periodLength transverseLength parallelLength
        (periodLength + 2 * transverseLength + parallelLength) = periodicLift 0 ∧
    ∀ j < periodLength + 2 * transverseLength + parallelLength,
      AllowedStep
        (oneSidedFourSegmentPath periodicLift upperStaircase parallelReturn lowerStaircase
          periodLength transverseLength parallelLength j)
        (oneSidedFourSegmentPath periodicLift upperStaircase parallelReturn lowerStaircase
          periodLength transverseLength parallelLength (j + 1))
  constructor
  · simp [oneSidedFourSegmentPath, hperiodLength]
  constructor
  · have htotalA : ¬periodLength + 2 * transverseLength + parallelLength < periodLength := by omega
    have htotalAB : ¬periodLength + 2 * transverseLength + parallelLength < periodLength + transverseLength := by omega
    have htotalABC : ¬periodLength + 2 * transverseLength + parallelLength < periodLength + transverseLength + parallelLength := by omega
    simp [oneSidedFourSegmentPath, htotalA, htotalAB, htotalABC, h41]
  · intro j hj
    by_cases hja : j < periodLength
    · by_cases hnext : j + 1 < periodLength
      · simpa [oneSidedFourSegmentPath, hja, hnext] using hfirst j hja
      · have hjeq : j + 1 = periodLength := by omega
        have hjnext : ¬j + 1 < periodLength := hnext
        have hjnextab : j + 1 < periodLength + transverseLength := by omega
        simpa [oneSidedFourSegmentPath, hja, hjnext, hjnextab, hjeq, h12, htransverseLength] using
          hfirst j hja
    · have hperiodLengthj : periodLength ≤ j := Nat.le_of_not_gt hja
      by_cases hjab : j < periodLength + transverseLength
      · by_cases hnext : j + 1 < periodLength + transverseLength
        · have hnexta : ¬j + 1 < periodLength := by omega
          have hsub : j + 1 - periodLength = (j - periodLength) + 1 := by omega
          simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnext, hsub]
            using hsecond (j - periodLength) (by omega)
        · have hjeq : j + 1 = periodLength + transverseLength := by omega
          have hnexta : ¬j + 1 < periodLength := by omega
          have hnextab : ¬j + 1 < periodLength + transverseLength := hnext
          have hnextabc : j + 1 < periodLength + transverseLength + parallelLength := by omega
          have hindex : (j - periodLength) + 1 = transverseLength := by omega
          simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnextab, hnextabc,
            hjeq, hindex, h23, hparallelLength]
            using hsecond (j - periodLength) (by omega)
      · have hperiodLengthtransverseLengthj : periodLength + transverseLength ≤ j := Nat.le_of_not_gt hjab
        by_cases hjabc : j < periodLength + transverseLength + parallelLength
        · by_cases hnext : j + 1 < periodLength + transverseLength + parallelLength
          · have hnexta : ¬j + 1 < periodLength := by omega
            have hnextab : ¬j + 1 < periodLength + transverseLength := by omega
            have hsub : j + 1 - periodLength - transverseLength = (j - periodLength - transverseLength) + 1 := by omega
            simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnextab, hjabc, hnext,
              hsub]
              using hthird (j - periodLength - transverseLength) (by omega)
          · have hjeq : j + 1 = periodLength + transverseLength + parallelLength := by omega
            have hnexta : ¬j + 1 < periodLength := by omega
            have hnextab : ¬j + 1 < periodLength + transverseLength := by omega
            have hnextabc : ¬j + 1 < periodLength + transverseLength + parallelLength := hnext
            have hsumA : ¬periodLength + transverseLength + parallelLength < periodLength := by omega
            have hsumAB : ¬periodLength + transverseLength + parallelLength < periodLength + transverseLength := by omega
            have hsumABC : ¬periodLength + transverseLength + parallelLength < periodLength + transverseLength + parallelLength := by omega
            have hthirdIndex : (j - periodLength - transverseLength) + 1 = parallelLength := by omega
            have hfourthIndex : periodLength + 2 * transverseLength + parallelLength - (periodLength + transverseLength + parallelLength) = transverseLength := by omega
            simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnextab, hjabc,
              hnextabc, hjeq, hsumA, hsumAB, hsumABC, hthirdIndex,
              hfourthIndex, h34]
              using hthird (j - periodLength - transverseLength) (by omega)
        · have hperiodLengthtransverseLengthparallelLengthj : periodLength + transverseLength + parallelLength ≤ j := Nat.le_of_not_gt hjabc
          have hnexta : ¬j + 1 < periodLength := by omega
          have hnextab : ¬j + 1 < periodLength + transverseLength := by omega
          have hnextabc : ¬j + 1 < periodLength + transverseLength + parallelLength := by omega
          have hindex : periodLength + 2 * transverseLength + parallelLength - j = (periodLength + 2 * transverseLength + parallelLength - (j + 1)) + 1 := by
            omega
          simpa [oneSidedFourSegmentPath, hja, hnexta, hjab, hnextab, hjabc,
            hnextabc, hindex]
            using hfourth (periodLength + 2 * transverseLength + parallelLength - (j + 1)) (by omega)
end Ising2DLambda.KacWard
