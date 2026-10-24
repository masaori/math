import Ising2DLambda.AlgebraicEigenvalue.EvenOrbitColoring
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.EvenOrbitColoring

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 必要十分版の基点・周期・座標を本文の定義から供給する。 -/
theorem finitePermutationEvenColor_alternates_from_necSuf (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) (i : J) :
    σ i ∈ finitePermutationEvenColor σ ↔ i ∉ finitePermutationEvenColor σ := by
  rw [finitePermutationEvenColor_mem, finitePermutationEvenColor_mem]
  apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.cyclicCoordinates_alternate_necSuf
    σ (finitePermutationOrbitMinimum σ)
    (fun j => finitePermutationMinimalPeriod σ (finitePermutationOrbitMinimum σ j))
    (finitePermutationOrbitCoordinate σ)
  · exact finitePermutationOrbitMinimum_apply σ
  · intro j
    exact congrArg (finitePermutationMinimalPeriod σ) (finitePermutationOrbitMinimum_apply σ j)
  · intro j
    exact (finitePermutationMinimalPeriod_spec σ _).2.1
  · intro j
    exact (finitePermutationOrbitCoordinate_spec σ j).1
  · intro j
    exact (finitePermutationOrbitCoordinate_spec σ j).2
  · intro j
    exact finitePermutationIterate_injOn_period σ _
  · intro j
    apply Nat.even_iff.mp
    rw [finitePermutationMinimalPeriod_eq_orbitLength]
    exact heven _

/-- 基点の冪等性を軌道の最小元の一致で充足し、座標零を導く。 -/
theorem finitePermutationOrbitCoordinate_minimum_from_necSuf (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbitCoordinate σ (finitePermutationOrbitMinimum σ i) = 0 := by
  apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.cyclicCoordinates_basepoint_zero_necSuf
    σ (finitePermutationOrbitMinimum σ)
    (fun j => finitePermutationMinimalPeriod σ (finitePermutationOrbitMinimum σ j))
    (finitePermutationOrbitCoordinate σ)
  · intro j
    exact finitePermutationOrbitMinimum_eq_of_mem σ j _ (finitePermutationOrbitMinimum_mem σ j)
  · intro j
    exact (finitePermutationOrbitCoordinate_spec σ j).1
  · intro j
    exact (finitePermutationOrbitCoordinate_spec σ j).2
  · intro j
    exact finitePermutationIterate_injOn_period σ _

theorem finitePermutationEvenColor_minimum_mem_from_necSuf (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbitMinimum σ i ∈ finitePermutationEvenColor σ := by
  rw [finitePermutationEvenColor_mem, finitePermutationOrbitCoordinate_minimum_from_necSuf]

end Ising2DLambda.AlgebraicEigenvalue
