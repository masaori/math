import Ising2DLambda.FisherZero.IncreasingSubfieldUnion
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.IncreasingPositiveConeUnion

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版の和集合の正錐を代数的数の部分体列へ特殊化する。 -/
theorem increasingPositiveConeUnion_isPositiveCone_from_necSuf
    (F : ℕ → Subfield Qbar) (C : ℕ → Set Qbar)
    (hstep : ∀ n, ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1))) :
    IsSubfieldPositiveCone
      (increasingSubfieldUnion F (monotone_nat_of_le_succ (fun n => (hstep n).subfield_le)))
      {z | ∃ n, z ∈ C n} := by
  have hn := Ising2DLambda.NecSuf.FisherZero.increasingPositiveConeUnion_isPositiveCone
    (F := fun n => (F n : Set Qbar)) C
    (fun n => (extendsPositiveCone_iff_from_necSuf (F n) (F (n + 1))
      (C n) (C (n + 1))).1 (hstep n))
  exact (isSubfieldPositiveCone_iff_from_necSuf _ _).2 hn

end Ising2DLambda.FisherZero
