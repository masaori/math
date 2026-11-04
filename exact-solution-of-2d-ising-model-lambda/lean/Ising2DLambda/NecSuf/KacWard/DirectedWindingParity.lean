import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Modulo two, assigning a sign to each crossing does not change its count. -/
theorem directedWindingParity_necSuf {I : Type*} [Fintype I]
    (crossing : I → ℕ) (reversed : I → Bool) :
    ((∑ i, (crossing i : ℤ) * (1 - 2 * ((reversed i).toNat : ℤ)) : ℤ) : ZMod 2) =
      ((∑ i, crossing i : ℕ) : ZMod 2) := by
  push_cast
  apply Finset.sum_congr rfl
  intro i _
  cases reversed i <;> norm_num

end Ising2DLambda.NecSuf.KacWard
