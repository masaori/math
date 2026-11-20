import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldIsMaximal
import Ising2DLambda.FisherZero.OddDegreePolynomialHasOddDegreeRoot
import Ising2DLambda.FisherZero.OddDegreePositiveConeExtension
import Ising2DLambda.FisherZero.SubfieldPolynomialValuesSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 奇数次の根を正錐付きの拡大体へ入れ、極大性で元の部分体へ戻す。 -/
theorem maximalOrderedSubfield_oddDegreeRoot
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (n : ℕ) (f : QbarPoly) (hf : f ∈ subfieldCoefficientPolynomials R)
    (hodd : Odd n) (hfn : f.coeff n ≠ 0)
    (hfz : ∀ k : ℕ, n < k → f.coeff k = 0) :
    ∃ β : Qbar, β ∈ R ∧ qbarPolyEval β f = 0 := by
  obtain ⟨β, hroot, hdegree, _⟩ :=
    oddDegreePolynomial_hasOddDegreeRoot R n f hf hodd hfn hfz
  obtain ⟨D, hD⟩ := oddDegree_positiveCone_extension R C hC β hdegree
  have hER := hmax (subfieldPolynomialValuesSubfield R β) D hD
  have hβE : β ∈ subfieldPolynomialValuesSubfield R β :=
    element_mem_subfieldPolynomialValues R β
  exact ⟨β, hER ▸ hβE, hroot⟩

end Ising2DLambda.FisherZero
