import Ising2DLambda.FisherZero.QuadraticTrichotomyAtMostOne
import Ising2DLambda.NecSuf.FisherZero.QuadraticTrichotomyAtMostOne

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_trichotomy_at_most_one` の具体版を必要十分版から導く。 -/
theorem quadraticTrichotomyAtMostOne_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    ¬ (xi ∈ quadraticPositiveCone s ∧ (xi : Qbar) = 0) ∧
      ¬ ((xi : Qbar) = 0 ∧ quadraticNegElement s xi ∈ quadraticPositiveCone s) ∧
      ¬ (xi ∈ quadraticPositiveCone s ∧
        quadraticNegElement s xi ∈ quadraticPositiveCone s) := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  have hcases :=
    Ising2DLambda.NecSuf.FisherZero.quadratic_trichotomy_at_most_one_necSuf a b
  constructor
  · rintro ⟨hpos, hzero⟩
    apply hcases.1
    constructor
    · change quadraticCoefficientPositive (quadraticRepresentation s xi) at hpos
      simpa [quadraticCoefficientPositive,
        Ising2DLambda.NecSuf.FisherZero.quadraticCoefficientPositiveNecSuf,
        a, b] using hpos
    · have hrep := (quadraticRepresentation_eq_zero_iff s hs xi).1 hzero
      simpa [a, b] using hrep
  constructor
  · rintro ⟨hzero, hneg⟩
    apply hcases.2.1
    constructor
    · have hrep := (quadraticRepresentation_eq_zero_iff s hs xi).1 hzero
      simpa [a, b] using hrep
    · change quadraticCoefficientPositive
        (quadraticRepresentation s (quadraticNegElement s xi)) at hneg
      rw [quadraticRepresentation_neg s hs xi] at hneg
      simpa [quadraticCoefficientPositive,
        Ising2DLambda.NecSuf.FisherZero.quadraticCoefficientPositiveNecSuf,
        a, b] using hneg
  · rintro ⟨hpos, hneg⟩
    apply hcases.2.2
    constructor
    · change quadraticCoefficientPositive (quadraticRepresentation s xi) at hpos
      simpa [quadraticCoefficientPositive,
        Ising2DLambda.NecSuf.FisherZero.quadraticCoefficientPositiveNecSuf,
        a, b] using hpos
    · change quadraticCoefficientPositive
        (quadraticRepresentation s (quadraticNegElement s xi)) at hneg
      rw [quadraticRepresentation_neg s hs xi] at hneg
      simpa [quadraticCoefficientPositive,
        Ising2DLambda.NecSuf.FisherZero.quadraticCoefficientPositiveNecSuf,
        a, b] using hneg

end Ising2DLambda.FisherZero
