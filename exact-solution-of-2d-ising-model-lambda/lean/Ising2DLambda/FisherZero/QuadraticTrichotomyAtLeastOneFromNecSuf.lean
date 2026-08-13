import Ising2DLambda.FisherZero.QuadraticTrichotomyAtLeastOne
import Ising2DLambda.NecSuf.FisherZero.QuadraticTrichotomyAtLeastOne

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_trichotomy_at_least_one` の具体版を必要十分版から導く。 -/
theorem quadraticTrichotomyAtLeastOne_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    xi ∈ quadraticPositiveCone s ∨
      (xi : Qbar) = 0 ∨
      quadraticNegElement s xi ∈ quadraticPositiveCone s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  have hcases :=
    Ising2DLambda.NecSuf.FisherZero.quadratic_trichotomy_at_least_one_necSuf
      a b (rationalSquareNeDoubleSquare a b)
  rcases hcases with hpos | hzero | hneg
  · left
    change quadraticCoefficientPositive (quadraticRepresentation s xi)
    simpa [quadraticCoefficientPositive,
      Ising2DLambda.NecSuf.FisherZero.quadraticCoefficientPositiveNecSuf,
      a, b] using hpos
  · right
    left
    apply (quadraticRepresentation_eq_zero_iff s hs xi).2
    simpa [a, b] using hzero
  · right
    right
    change quadraticCoefficientPositive
      (quadraticRepresentation s (quadraticNegElement s xi))
    rw [quadraticRepresentation_neg s hs xi]
    simpa [quadraticCoefficientPositive,
      Ising2DLambda.NecSuf.FisherZero.quadraticCoefficientPositiveNecSuf,
      a, b] using hneg

end Ising2DLambda.FisherZero
