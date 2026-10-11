/- 本文の具体版を、必要十分版の演算法則の特殊化として得る。 -/
import Ising2DLambda.FisherZero.SelfDualQuadraticRoots
import Ising2DLambda.NecSuf.FisherZero.SelfDualQuadraticRoots

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem selfDualQuadratic_roots_from_necSuf {s xi : Qbar} (hs : s * s = 2) :
    xi ^ 2 + 2 * xi - 1 = 0 ↔ xi = -1 + s ∨ xi = -1 - s := by
  have hSquare : s * s = (1 : Qbar) + 1 := by
    calc
      s * s = 2 := hs
      _ = 1 + 1 := (one_add_one_eq_two : (1 : Qbar) + 1 = 2).symm
  have hSpecialization :=
    Ising2DLambda.NecSuf.FisherZero.self_dual_quadratic_roots_necSuf
      (xi := xi) hSquare (mul_comm (xi + 1) s)
      (fun ha hab => AlgebraicEigenvalue.qbarNoZeroDivisors ha hab)
  -- 必要十分版の二乗と二は、本文と同じ略記に戻すだけである。
  simpa only [pow_two, one_add_one_eq_two] using hSpecialization

end Ising2DLambda.FisherZero
