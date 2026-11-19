import Ising2DLambda.FisherZero.MaximalOrderedSubfieldPositiveIsSquare
import Ising2DLambda.FisherZero.OnePlusWeightedSquareSumEvenDegree

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem maximalOrderedSubfield_sumOfSquares_isSquare
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (a b : Qbar) (ha : a ∈ R) (hb : b ∈ R) :
    ∃ c : Qbar, c ∈ R ∧ c * c = a * a + b * b := by
  -- 本文の零・非零の場合分け。非零の平方は正錐に入り、正錐は和で閉じる。
  have hsum : a * a + b * b = 0 ∨ a * a + b * b ∈ C := by
    by_cases ha0 : a = 0
    · by_cases hb0 : b = 0
      · left
        simp [ha0, hb0]
      · right
        simpa [ha0] using mul_self_mem_of_isSubfieldPositiveCone R C hC b hb hb0
    · by_cases hb0 : b = 0
      · right
        simpa [hb0] using mul_self_mem_of_isSubfieldPositiveCone R C hC a ha ha0
      · right
        exact hC.add_mem _ _
          (mul_self_mem_of_isSubfieldPositiveCone R C hC a ha ha0)
          (mul_self_mem_of_isSubfieldPositiveCone R C hC b hb hb0)
  rcases hsum with hzero | hpos
  · exact ⟨0, R.zero_mem, by simp [hzero]⟩
  -- 本文の最後の段。正錐の元に対する既証明の平方根を取る。
  · obtain ⟨c, hc, _, hcsq⟩ :=
      maximalOrderedSubfield_positive_isSquare R C hC hmax (a * a + b * b) hpos
    exact ⟨c, hc, hcsq⟩

end Ising2DLambda.FisherZero
