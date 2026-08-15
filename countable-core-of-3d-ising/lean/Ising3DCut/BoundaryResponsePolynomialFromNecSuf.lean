/-
必要十分版（係数環を可換半環 `R` にした境界応答多項式）を `R := ℤ` に特殊化すると、
具体版の定義・補題がそのまま得られることの確認。
-/
import Ising3DCut.BoundaryResponsePolynomial
import Ising3DCut.NecSuf.BoundaryResponsePolynomial

namespace Ising3DCut

open MvPolynomial

variable {Configuration Edge : Type*}
variable [Fintype Configuration] [Fintype Edge] [DecidableEq Edge]

theorem multivariatePartitionPolynomial_eq_necSuf (broken : Configuration → Finset Edge) :
    multivariatePartitionPolynomial broken =
      NecSuf.multivariatePartitionPolynomial (R := ℤ) broken := rfl

theorem boundarySpecialization_eq_necSuf (active : Finset Edge) :
    boundarySpecialization active = NecSuf.boundarySpecialization (R := ℤ) active := rfl

theorem boundaryResponsePolynomial_eq_necSuf
    (broken : Configuration → Finset Edge) (active : Finset Edge) :
    boundaryResponsePolynomial broken active =
      NecSuf.boundaryResponsePolynomial (R := ℤ) broken active := rfl

/-- 具体版の各補題を必要十分版から導く。 -/
theorem boundarySpecialization_X_of_mem_fromNecSuf (active : Finset Edge) (e : Edge)
    (he : e ∈ active) :
    boundarySpecialization active (X e) = X (⟨e, he⟩ : {a : Edge // a ∈ active}) :=
  NecSuf.boundarySpecialization_X_of_mem active e he

theorem boundarySpecialization_X_of_not_mem_fromNecSuf (active : Finset Edge) (e : Edge)
    (he : e ∉ active) :
    boundarySpecialization active (X e) = 1 :=
  NecSuf.boundarySpecialization_X_of_not_mem active e he

theorem boundarySpecialization_add_fromNecSuf (active : Finset Edge)
    (P Q : MvPolynomial Edge ℤ) :
    boundarySpecialization active (P + Q) =
      boundarySpecialization active P + boundarySpecialization active Q :=
  NecSuf.boundarySpecialization_add active P Q

theorem boundarySpecialization_mul_fromNecSuf (active : Finset Edge)
    (P Q : MvPolynomial Edge ℤ) :
    boundarySpecialization active (P * Q) =
      boundarySpecialization active P * boundarySpecialization active Q :=
  NecSuf.boundarySpecialization_mul active P Q

theorem boundarySpecialization_one_fromNecSuf (active : Finset Edge) :
    boundarySpecialization active (1 : MvPolynomial Edge ℤ) = 1 :=
  NecSuf.boundarySpecialization_one active

end Ising3DCut
