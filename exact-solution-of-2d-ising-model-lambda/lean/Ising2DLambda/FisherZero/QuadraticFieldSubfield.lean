import Ising2DLambda.FisherZero.QuadraticInverse
import Ising2DLambda.FisherZero.QuadraticZeroNegation
import Ising2DLambda.FisherZero.QuadraticAddition
import Ising2DLambda.FisherZero.QuadraticMultiplication

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 二次体の台集合を、本文の各閉包の主張から部分体にする。 -/
def quadraticFieldSubfield (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) : Subfield Qbar where
  carrier := quadraticFieldSet s
  zero_mem' := quadraticZero_mem s
  one_mem' := by
    refine ⟨1, 0, ?_⟩
    simp
  add_mem' := by
    intro x y hx hy
    exact quadraticAdd_mem s ⟨x, hx⟩ ⟨y, hy⟩
  neg_mem' := by
    intro x hx
    exact quadraticNeg_mem s ⟨x, hx⟩
  mul_mem' := by
    intro x y hx hy
    exact quadraticMul_mem s hs ⟨x, hx⟩ ⟨y, hy⟩
  inv_mem' := by
    intro x hx
    by_cases hzero : x = 0
    · subst x
      simpa using quadraticZero_mem s
    · exact quadraticInverse_mem s hs x hx hzero

end Ising2DLambda.FisherZero
