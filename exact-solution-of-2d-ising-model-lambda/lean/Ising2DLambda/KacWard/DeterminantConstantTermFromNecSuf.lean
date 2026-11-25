/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.DeterminantConstantTerm
import Ising2DLambda.NecSuf.KacWard.DeterminantConstantTerm

namespace Ising2DLambda.KacWard

open Matrix Polynomial Equiv Ising2DLambda.AlgebraicEigenvalue

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem kacWardDeterminant_coeff_zero_from_necSuf {ι : Type}
    [Fintype ι] [DecidableEq ι] (M : Matrix ι ι Qbar) :
    (kacWardDeterminant M).coeff 0 = 1 := by
  rw [kacWardDeterminant_eq_mathlib]
  exact Ising2DLambda.NecSuf.KacWard.det_one_sub_X_mul_coeff_zero M

end Ising2DLambda.KacWard
