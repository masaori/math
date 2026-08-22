import Ising2DLambda.FisherZero.SelfDualQuadraticRoots
import Ising2DLambda.NecSuf.FisherZero.SelfDualQuadraticRoots

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem selfDualQuadratic_roots_from_necSuf {s xi : Qbar} (hs : s * s = 2) :
    xi ^ 2 + 2 * xi - 1 = 0 ↔ xi = -1 + s ∨ xi = -1 - s := by
  have hFactorEq : ((xi + 1) - s) * ((xi + 1) + s) = xi ^ 2 + 2 * xi - 1 := by
    calc
      ((xi + 1) - s) * ((xi + 1) + s)
          = ((xi + 1) - s) * (xi + 1) + ((xi + 1) - s) * s := by ring
      _ = ((xi + 1) * (xi + 1) - s * (xi + 1)) + ((xi + 1) * s - s * s) := by ring
      _ = ((xi + 1) * (xi + 1) - s * (xi + 1)) + (s * (xi + 1) - s * s) := by ring
      _ = (xi + 1) * (xi + 1) + ((-(s * (xi + 1)) + s * (xi + 1)) - s * s) := by ring
      _ = (xi + 1) * (xi + 1) + (0 - s * s) := by ring
      _ = (xi + 1) * (xi + 1) - s * s := by ring
      _ = (xi + 1) * (xi + 1) - 2 := by rw [hs]
      _ = (((xi + 1) * xi + (xi + 1) * 1) - 2) := by ring
      _ = (((xi * xi + 1 * xi) + (xi + 1)) - 2) := by ring
      _ = (((xi ^ 2 + xi) + (xi + 1)) - 2) := by ring
      _ = (((xi ^ 2 + (xi + xi)) + 1) - 2) := by ring
      _ = (((xi ^ 2 + 2 * xi) + 1) - 2) := by ring
      _ = (xi ^ 2 + 2 * xi) + (1 - 2) := by ring
      _ = xi ^ 2 + 2 * xi - 1 := by ring
  apply Ising2DLambda.NecSuf.FisherZero.self_dual_quadratic_roots_necSuf
      (factor := ((xi + 1) - s) * ((xi + 1) + s) = 0)
      (firstZero := (xi + 1) - s = 0)
      (secondZero := (xi + 1) + s = 0)
  · intro h; exact hFactorEq.trans h
  · intro h
    by_cases hFirst : (xi + 1) - s = 0
    · exact Or.inl hFirst
    · exact Or.inr (AlgebraicEigenvalue.qbarNoZeroDivisors hFirst h)
  · intro h; linear_combination h
  · intro h; linear_combination h
  · intro h; linear_combination h
  · intro h; linear_combination h
  · intro h; rw [h, zero_mul]
  · intro h; rw [h, mul_zero]
  · intro h; exact hFactorEq.symm.trans h


end Ising2DLambda.FisherZero
