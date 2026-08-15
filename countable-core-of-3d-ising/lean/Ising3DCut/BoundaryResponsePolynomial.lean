import Mathlib

/-!
人手証明「境界応答多項式」の Lean 具体版。

有限な配位型と辺型、各配位の破れ辺集合を固定し、辺ごとの多変数分配多項式を
有限和として作る。内箱に接する辺の有限集合を `active` とし、それ以外の変数を
`1` に送る有限代入を環準同型として構成する。
-/

namespace Ising3DCut

open MvPolynomial

section

variable {Configuration Edge : Type*}
variable [Fintype Configuration] [Fintype Edge] [DecidableEq Edge]

/-- 各配位の破れ辺に対応する不定元の積を、全配位について足した多変数分配多項式。 -/
noncomputable def multivariatePartitionPolynomial
    (broken : Configuration → Finset Edge) : MvPolynomial Edge ℤ :=
  ∑ σ : Configuration, ∏ e ∈ broken σ, X e

/-- `active` に属する辺変数を保ち、それ以外の辺変数を `1` に置く有限代入。 -/
noncomputable def boundarySpecialization (active : Finset Edge) :
    MvPolynomial Edge ℤ →+* MvPolynomial {e : Edge // e ∈ active} ℤ :=
  eval₂Hom C fun e ↦ if h : e ∈ active then X ⟨e, h⟩ else 1

/-- 保持する辺の不定元は、同じ辺を添字とする不定元へ移る。 -/
lemma boundarySpecialization_X_of_mem (active : Finset Edge) (e : Edge)
    (he : e ∈ active) :
    boundarySpecialization active (X e) = X (⟨e, he⟩ : {a : Edge // a ∈ active}) := by
  simp [boundarySpecialization, he]

/-- 保持しない辺の不定元は `1` へ移る。 -/
lemma boundarySpecialization_X_of_not_mem (active : Finset Edge) (e : Edge)
    (he : e ∉ active) :
    boundarySpecialization active (X e) = 1 := by
  simp [boundarySpecialization, he]

/-- 有限代入は加法を保存する。 -/
lemma boundarySpecialization_add (active : Finset Edge) (P Q : MvPolynomial Edge ℤ) :
    boundarySpecialization active (P + Q) =
      boundarySpecialization active P + boundarySpecialization active Q := by
  exact map_add (boundarySpecialization active) P Q

/-- 有限代入は乗法を保存する。 -/
lemma boundarySpecialization_mul (active : Finset Edge) (P Q : MvPolynomial Edge ℤ) :
    boundarySpecialization active (P * Q) =
      boundarySpecialization active P * boundarySpecialization active Q := by
  exact map_mul (boundarySpecialization active) P Q

/-- 有限代入は単位元を保存する。 -/
lemma boundarySpecialization_one (active : Finset Edge) :
    boundarySpecialization active (1 : MvPolynomial Edge ℤ) = 1 := by
  exact map_one (boundarySpecialization active)

/-- 境界応答多項式は、多変数分配多項式の有限代入像である。 -/
noncomputable def boundaryResponsePolynomial
    (broken : Configuration → Finset Edge) (active : Finset Edge) :
    MvPolynomial {e : Edge // e ∈ active} ℤ :=
  boundarySpecialization active (multivariatePartitionPolynomial broken)

lemma boundaryResponsePolynomial_eq_specialization
    (broken : Configuration → Finset Edge) (active : Finset Edge) :
    boundaryResponsePolynomial broken active =
      boundarySpecialization active (multivariatePartitionPolynomial broken) := by
  rfl

end

end Ising3DCut
