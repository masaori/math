import Ising2DLambda.FisherZero.SumOfSquaresRootNonnegativeSign
import Ising2DLambda.NecSuf.FisherZero.SumOfSquaresRootNonnegativeSign

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の部分体と正錐へ特殊化する。 -/
theorem maximalOrderedSubfield_sumOfSquares_rootNonnegative_from_necSuf
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (a b : Qbar) (ha : a ∈ R) (hb : b ∈ R) :
    ∃ c : Qbar, c ∈ R ∧ c * c = a * a + b * b ∧ (c = 0 ∨ c ∈ C) := by
  exact Ising2DLambda.NecSuf.FisherZero.sumOfSquares_rootNonnegative
    (R : Set Qbar) C (fun z hz => R.neg_mem hz)
    (fun z hz => (hC.trichotomy z hz).1)
    a b (maximalOrderedSubfield_sumOfSquares_isSquare R C hC hmax a b ha hb)

end Ising2DLambda.FisherZero
