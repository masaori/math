/-
「自己双対方程式の因数分解と根の全体」と「二根は相異なる」の具体版。
人手証明と同じ因数分解、零因子の場合分け、背理法を順に実装する。
-/
import Ising2DLambda.FisherZero.SqrtTwoExists
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_self_dual_quadratic_roots` の具体版。 -/
theorem selfDualQuadratic_roots {s xi : Qbar} (hs : s * s = 2) :
    xi ^ 2 + 2 * xi - 1 = 0 ↔ xi = -1 + s ∨ xi = -1 - s := by
  have hFactor : ((xi + 1) - s) * ((xi + 1) + s) = xi ^ 2 + 2 * xi - 1 := by
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
  constructor
  · intro hQuadratic
    have hProduct : ((xi + 1) - s) * ((xi + 1) + s) = 0 := hFactor.trans hQuadratic
    by_cases hFirst : (xi + 1) - s = 0
    · left
      linear_combination hFirst
    · have hSecond : (xi + 1) + s = 0 :=
        AlgebraicEigenvalue.qbarNoZeroDivisors hFirst hProduct
      right
      linear_combination hSecond
  · intro hRoot
    rw [← hFactor]
    rcases hRoot with hPlus | hMinus
    · have hFirst : (xi + 1) - s = 0 := by linear_combination hPlus
      rw [hFirst, zero_mul]
    · have hSecond : (xi + 1) + s = 0 := by linear_combination hMinus
      rw [hSecond, mul_zero]

/-- `claim_self_dual_quadratic_roots_distinct` の具体版。 -/
theorem selfDualQuadratic_roots_distinct {s : Qbar} (hs : s * s = 2) :
    -1 + s ≠ -1 - s := by
  intro hEqual
  have hsNeg : s = -s := by linear_combination hEqual
  have hTwoMul : (2 : Qbar) * s = 0 := by
    calc
      (2 : Qbar) * s = (1 + 1) * s := by norm_num
      _ = 1 * s + 1 * s := by rw [add_mul]
      _ = s + s := by rw [one_mul]
      _ = (-s) + s := congrArg (fun z => z + s) hsNeg
      _ = 0 := by rw [neg_add_cancel]
  have hTwo : (2 : Qbar) ≠ 0 := by norm_num
  have hsZero : s = 0 := AlgebraicEigenvalue.qbarNoZeroDivisors hTwo hTwoMul
  have : (2 : Qbar) = 0 := by
    calc
      (2 : Qbar) = s * s := hs.symm
      _ = 0 * 0 := by rw [hsZero]
      _ = 0 := zero_mul 0
  exact hTwo this

end Ising2DLambda.FisherZero
