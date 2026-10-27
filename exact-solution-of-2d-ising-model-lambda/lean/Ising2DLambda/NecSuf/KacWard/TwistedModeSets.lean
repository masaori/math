import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.NecSuf.KacWard

theorem twistedPow_mem_doubleRoots_necSuf {M : Type*} [Monoid M]
    (z : M) (L : ℕ) (h : (z ^ L) ^ 2 = 1) : z ^ (2 * L) = 1 := by
  calc
    z ^ (2 * L) = (z ^ L) ^ 2 := by rw [mul_comm 2 L, pow_mul]
    _ = 1 := h

end Ising2DLambda.NecSuf.KacWard
