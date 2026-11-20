import Ising2DLambda.FisherZero.MaximalOrderedSubfieldOddDegreeRoot
import Ising2DLambda.FisherZero.OddDegreePositiveConeExtensionFromNecSuf
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.MaximalOrderedSubfieldOddDegreeRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の極大な順序付き部分体へ特殊化する。 -/
theorem maximalOrderedSubfield_oddDegreeRoot_from_necSuf
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (n : ℕ) (f : QbarPoly) (hf : f ∈ subfieldCoefficientPolynomials R)
    (hodd : Odd n) (hfn : f.coeff n ≠ 0)
    (hfz : ∀ k : ℕ, n < k → f.coeff k = 0) :
    ∃ β : Qbar, β ∈ R ∧ qbarPolyEval β f = 0 := by
  exact Ising2DLambda.NecSuf.FisherZero.maximalOrderedSubfield_oddDegreeRoot
    (fun E : Subfield Qbar => (E : Set Qbar)) R C f
    (fun p β => qbarPolyEval β p = 0) (degreeOverSubfield R)
    (by
      obtain ⟨β, hroot, hdegree, _⟩ :=
        oddDegreePolynomial_hasOddDegreeRoot R n f hf hodd hfn hfz
      exact ⟨β, hroot, hdegree⟩)
    (subfieldPolynomialValuesSubfield R)
    (fun β => element_mem_subfieldPolynomialValues R β)
    (fun β hdegree => by
      obtain ⟨D, hD⟩ := oddDegree_positiveCone_extension_from_necSuf R C hC β hdegree
      exact ⟨D, (extendsPositiveCone_iff_from_necSuf R
        (subfieldPolynomialValuesSubfield R β) C D).mp hD⟩)
    (fun E D hED => hmax E D ((extendsPositiveCone_iff_from_necSuf R E C D).mpr hED))

end Ising2DLambda.FisherZero
