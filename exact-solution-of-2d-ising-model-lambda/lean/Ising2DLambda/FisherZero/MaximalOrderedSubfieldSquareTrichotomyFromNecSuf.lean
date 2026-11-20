import Ising2DLambda.FisherZero.MaximalOrderedSubfieldSquareTrichotomy
import Ising2DLambda.NecSuf.FisherZero.MaximalOrderedSubfieldSquareTrichotomy

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の正錐付き部分体へ特殊化する。 -/
theorem maximalOrderedSubfield_squareTrichotomy_from_necSuf
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (z : Qbar) (hz : z ∈ R) :
    ExactlyOneOfThree (z = 0)
      (∃ w : Qbar, w ∈ R ∧ w ≠ 0 ∧ z = w * w)
      (∃ w : Qbar, w ∈ R ∧ w ≠ 0 ∧ -z = w * w) := by
  have hsquareCone : ∀ w : Qbar, w ∈ R → w ≠ 0 → w * w ∈ C := by
    intro w hwR hw
    rcases (hC.trichotomy w hwR).1 with hzero | hpositive | hnegative
    · exact False.elim (hw hzero)
    · exact hC.mul_mem w w hpositive hpositive
    · simpa only [neg_mul_neg] using hC.mul_mem (-w) (-w) hnegative hnegative
  exact Ising2DLambda.NecSuf.FisherZero.maximalOrderedSubfield_squareTrichotomy
    (R : Set Qbar) C hC.trichotomy hsquareCone
    (fun a ha => maximalOrderedSubfield_positive_isSquare R C hC hmax a ha)
    z hz

end Ising2DLambda.FisherZero
