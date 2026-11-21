/-
章「Onsager 閉形式への接続」の「一側閉包は終点を除いて頂点を繰り返さない」
（`claim_one_sided_periodic_lift_closure_simple`）の具体版。

人手証明と同じく、周期持ち上げ・上り階段・反転平行階段・下り階段の
四部分内の単射性と、異なる部分の六つの非交差を合成する。住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.OneSidedPeriodicLiftClosure
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

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
  intro i hi j hj hij
  by_cases hia : i < periodLength
  · by_cases hja : j < periodLength
    · have heq : periodicLift i = periodicLift j := by
        simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hja] using hij
      exact hperiodicLift i hia j hja heq
    · by_cases hjab : j < periodLength + transverseLength
      · have heq : periodicLift i = upperStaircase (j - periodLength) := by
          simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hja, hjab] using hij
        exact False.elim (h12 i hia (j - periodLength) (by omega) heq)
      · by_cases hjabc : j < periodLength + transverseLength + parallelLength
        · have heq : periodicLift i = parallelReturn (j - periodLength - transverseLength) := by
            simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hja, hjab, hjabc] using hij
          exact False.elim (h13 i hia (j - periodLength - transverseLength) (by omega) heq)
        · have heq : periodicLift i = lowerStaircase (periodLength + 2 * transverseLength + parallelLength - j) := by
            simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hja, hjab, hjabc] using hij
          exact False.elim (h14 i hia _ (by omega) (by omega) heq)
  · by_cases hiab : i < periodLength + transverseLength
    · by_cases hja : j < periodLength
      · have heq : periodicLift j = upperStaircase (i - periodLength) := by
          simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hja] using hij.symm
        exact False.elim (h12 j hja _ (by omega) heq)
      · by_cases hjab : j < periodLength + transverseLength
        · have heq : upperStaircase (i - periodLength) = upperStaircase (j - periodLength) := by
            simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hja, hjab] using hij
          have hsub := hupperStaircase (i - periodLength) (by omega) (j - periodLength) (by omega) heq
          omega
        · by_cases hjabc : j < periodLength + transverseLength + parallelLength
          · have heq : upperStaircase (i - periodLength) = parallelReturn (j - periodLength - transverseLength) := by
              simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hja, hjab, hjabc] using hij
            exact False.elim (h23 _ (by omega) _ (by omega) heq)
          · have heq : upperStaircase (i - periodLength) = lowerStaircase (periodLength + 2 * transverseLength + parallelLength - j) := by
              simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hja, hjab, hjabc] using hij
            exact False.elim (h24 _ (by omega) _ (by omega) (by omega) heq)
    · by_cases hiabc : i < periodLength + transverseLength + parallelLength
      · by_cases hja : j < periodLength
        · have heq : periodicLift j = parallelReturn (i - periodLength - transverseLength) := by
            simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hiabc, hja] using hij.symm
          exact False.elim (h13 j hja _ (by omega) heq)
        · by_cases hjab : j < periodLength + transverseLength
          · have heq : upperStaircase (j - periodLength) = parallelReturn (i - periodLength - transverseLength) := by
              simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab] using hij.symm
            exact False.elim (h23 _ (by omega) _ (by omega) heq)
          · by_cases hjabc : j < periodLength + transverseLength + parallelLength
            · have heq : parallelReturn (i - periodLength - transverseLength) = parallelReturn (j - periodLength - transverseLength) := by
                simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab, hjabc] using hij
              have hsub := hparallelReturn _ (by omega) _ (by omega) heq
              omega
            · have heq : parallelReturn (i - periodLength - transverseLength) = lowerStaircase (periodLength + 2 * transverseLength + parallelLength - j) := by
                simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab, hjabc] using hij
              exact False.elim (h34 _ (by omega) _ (by omega) (by omega) heq)
      · by_cases hja : j < periodLength
        · have heq : periodicLift j = lowerStaircase (periodLength + 2 * transverseLength + parallelLength - i) := by
            simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hiabc, hja] using hij.symm
          exact False.elim (h14 j hja _ (by omega) (by omega) heq)
        · by_cases hjab : j < periodLength + transverseLength
          · have heq : upperStaircase (j - periodLength) = lowerStaircase (periodLength + 2 * transverseLength + parallelLength - i) := by
              simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab] using hij.symm
            exact False.elim (h24 _ (by omega) _ (by omega) (by omega) heq)
          · by_cases hjabc : j < periodLength + transverseLength + parallelLength
            · have heq : parallelReturn (j - periodLength - transverseLength) = lowerStaircase (periodLength + 2 * transverseLength + parallelLength - i) := by
                simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab, hjabc] using hij.symm
              exact False.elim (h34 _ (by omega) _ (by omega) (by omega) heq)
            · have heq : lowerStaircase (periodLength + 2 * transverseLength + parallelLength - i) = lowerStaircase (periodLength + 2 * transverseLength + parallelLength - j) := by
                simpa [oneSidedPeriodicLiftClosure, oneSidedFourSegmentPath, hia, hiab, hiabc, hja, hjab, hjabc] using hij
              have hsub := hlowerStaircase _ (by omega) (by omega) _ (by omega) (by omega) heq
              omega

end Ising2DLambda.KacWard
