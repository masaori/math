import Ising2DLambda.FisherZero.MaximalOrderedSubfieldPositiveIsSquare
import Ising2DLambda.NecSuf.FisherZero.MaximalOrderedSubfieldPositiveIsSquare
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の極大な正錐付き部分体へ特殊化する。 -/
theorem maximalOrderedSubfield_positive_isSquare_from_necSuf
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (a : Qbar) (ha : a ∈ C) :
    ∃ b : Qbar, b ∈ R ∧ b ≠ 0 ∧ b * b = a := by
  have hext : ∀ x ∈ C, ∀ b : Qbar, b * b = x → b ∉ (R : Set Qbar) →
      ∃ (E : Subfield Qbar) (D : Set Qbar), b ∈ E ∧
        Ising2DLambda.NecSuf.FisherZero.ExtendsPositiveConeOn
          (R : Set Qbar) (E : Set Qbar) C D := by
    intro x hx b hb hbR
    obtain ⟨D, hD⟩ := squareRootAdjoined_positiveCone_extension R C hC x b hx hb hbR
    let E : Subfield Qbar := Subfield.closure ((R : Set Qbar) ∪ ({b} : Set Qbar))
    refine ⟨E, D, ?_, ?_⟩
    · exact Subfield.subset_closure (Set.mem_union_right _ (Set.mem_singleton b))
    · exact (extendsPositiveCone_iff_from_necSuf R E C D).mp hD
  have hmax' : ∀ (E : Subfield Qbar) (D : Set Qbar),
      Ising2DLambda.NecSuf.FisherZero.ExtendsPositiveConeOn
        (R : Set Qbar) (E : Set Qbar) C D → E = R := by
    intro E D hED
    exact hmax E D ((extendsPositiveCone_iff_from_necSuf R E C D).mpr hED)
  exact Ising2DLambda.NecSuf.FisherZero.maximalOrderedSubfield_positive_isSquare
    (fun E : Subfield Qbar => (E : Set Qbar)) R C
    (fun x hx => positiveConeElement_hasQbarSquareRoot R C hC x hx)
    hext hmax' a ha

end Ising2DLambda.FisherZero
