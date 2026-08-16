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

/-- 外箱の拡大に対する安定性を必要十分版から導く。 -/
theorem boundaryResponsePolynomial_outer_box_stability_fromNecSuf
    {Outer : Type*} [Fintype Outer]
    (broken : Configuration → Finset Edge)
    (broken' : Configuration × Outer → Finset Edge) (active : Finset Edge)
    (h : ∀ σ : Configuration, ∀ τ : Outer,
      boundarySpecialization active (∏ e ∈ broken' (σ, τ), X e) =
        boundarySpecialization active (∏ e ∈ broken σ, X e)) :
    boundaryResponsePolynomial broken' active =
      (Fintype.card Outer) • boundaryResponsePolynomial broken active :=
  NecSuf.boundaryResponsePolynomial_outer_box_stability broken broken' active h

/-- 外箱への非依存性を必要十分版（`R := ℤ`）から導く。 -/
theorem boundaryResponsePolynomial_outer_box_independence_fromNecSuf
    {Outer₁ Outer₂ : Type*} [Fintype Outer₁] [Fintype Outer₂]
    (broken : Configuration → Finset Edge)
    (broken₁ : Configuration × Outer₁ → Finset Edge)
    (broken₂ : Configuration × Outer₂ → Finset Edge) (active : Finset Edge)
    (h₁ : ∀ σ : Configuration, ∀ τ : Outer₁,
      boundarySpecialization active (∏ e ∈ broken₁ (σ, τ), X e) =
        boundarySpecialization active (∏ e ∈ broken σ, X e))
    (h₂ : ∀ σ : Configuration, ∀ τ : Outer₂,
      boundarySpecialization active (∏ e ∈ broken₂ (σ, τ), X e) =
        boundarySpecialization active (∏ e ∈ broken σ, X e)) :
    (Fintype.card (Configuration × Outer₂)) • boundaryResponsePolynomial broken₁ active =
      (Fintype.card (Configuration × Outer₁)) • boundaryResponsePolynomial broken₂ active :=
  NecSuf.boundaryResponsePolynomial_outer_box_independence broken broken₁ broken₂ active h₁ h₂

/-- 辺変数を 1 に置かない外箱依存性を必要十分版（`R := ℤ`）から導く。 -/
theorem fullBoundaryResponse_outer_edges_to_one_fromNecSuf
    {Edge'' Outer : Type*} [Fintype Edge''] [DecidableEq Edge''] [Fintype Outer]
    (broken : Configuration → Finset Edge)
    (broken'' : Configuration × Outer → Finset Edge'')
    (π : MvPolynomial Edge'' ℤ →+* MvPolynomial Edge ℤ)
    (h : ∀ σ : Configuration, ∀ τ : Outer,
      π (∏ e ∈ broken'' (σ, τ), X e) = ∏ e ∈ broken σ, X e) :
    π (multivariatePartitionPolynomial broken'') =
      (Fintype.card Outer) • multivariatePartitionPolynomial broken :=
  NecSuf.fullBoundaryResponse_outer_edges_to_one broken broken'' π h

/-- 辺変数を 1 に置かない共通の外箱を経由した比較を必要十分版（`R := ℤ`）から導く。 -/
theorem fullBoundaryResponse_common_outer_box_comparison_fromNecSuf
    {Edge₁ Edge₂ Outer₁ Outer₂ : Type*} [Fintype Edge₁] [DecidableEq Edge₁]
    [Fintype Edge₂] [DecidableEq Edge₂] [Fintype Outer₁] [Fintype Outer₂]
    (broken : Configuration → Finset Edge)
    (broken₁ : Configuration × Outer₁ → Finset Edge₁)
    (broken₂ : Configuration × Outer₂ → Finset Edge₂)
    (π₁ : MvPolynomial Edge₁ ℤ →+* MvPolynomial Edge ℤ)
    (π₂ : MvPolynomial Edge₂ ℤ →+* MvPolynomial Edge ℤ)
    (h₁ : ∀ σ : Configuration, ∀ τ : Outer₁,
      π₁ (∏ e ∈ broken₁ (σ, τ), X e) = ∏ e ∈ broken σ, X e)
    (h₂ : ∀ σ : Configuration, ∀ τ : Outer₂,
      π₂ (∏ e ∈ broken₂ (σ, τ), X e) = ∏ e ∈ broken σ, X e) :
    (Fintype.card (Configuration × Outer₂)) • π₁ (multivariatePartitionPolynomial broken₁) =
      (Fintype.card (Configuration × Outer₁)) • π₂ (multivariatePartitionPolynomial broken₂) :=
  NecSuf.fullBoundaryResponse_common_outer_box_comparison broken broken₁ broken₂ π₁ π₂ h₁ h₂

/-- 各辺変数についての次数は高々 1 を必要十分版（`R := ℤ`）から導く。 -/
theorem fullBoundaryResponse_degreeOf_le_one_fromNecSuf
    (broken : Configuration → Finset Edge) (e₀ : Edge) :
    degreeOf e₀ (multivariatePartitionPolynomial broken) ≤ 1 :=
  NecSuf.fullBoundaryResponse_degreeOf_le_one (R := ℤ) broken e₀

/-- 各辺の変数への真の依存（次数ちょうど 1）を必要十分版（`R := ℤ`。`CharZero ℤ`）から導く。 -/
theorem fullBoundaryResponse_degreeOf_eq_one_fromNecSuf
    (broken : Configuration → Finset Edge) (e₀ : Edge) (τ : Configuration)
    (hτ : e₀ ∈ broken τ) :
    degreeOf e₀ (multivariatePartitionPolynomial broken) = 1 :=
  NecSuf.fullBoundaryResponse_degreeOf_eq_one (R := ℤ) broken e₀ τ hτ

/-- 全次数は辺の総数以下を必要十分版（`R := ℤ`）から導く。 -/
theorem fullBoundaryResponse_totalDegree_le_card_edge_fromNecSuf
    (broken : Configuration → Finset Edge) :
    (multivariatePartitionPolynomial broken).totalDegree ≤ Fintype.card Edge :=
  NecSuf.fullBoundaryResponse_totalDegree_le_card_edge (R := ℤ) broken


/-- 全次数は辺の総数にちょうど等しいを必要十分版（`R := ℤ`）から導く。 -/
theorem fullBoundaryResponse_totalDegree_eq_card_edge_fromNecSuf
    (broken : Configuration → Finset Edge) (τ : Configuration)
    (hτ : broken τ = Finset.univ) :
    (multivariatePartitionPolynomial broken).totalDegree = Fintype.card Edge :=
  NecSuf.fullBoundaryResponse_totalDegree_eq_card_edge (R := ℤ) broken τ hτ

omit [Fintype Edge] [DecidableEq Edge] in
/-- 全変数を 1 に置いた値は配位の総数を必要十分版（`R := ℤ`）から導く。 -/
theorem fullBoundaryResponse_eval_one_eq_card_configuration_fromNecSuf
    (broken : Configuration → Finset Edge) :
    (eval fun _ : Edge ↦ (1 : ℤ)) (multivariatePartitionPolynomial broken) =
      Fintype.card Configuration :=
  NecSuf.fullBoundaryResponse_eval_one_eq_card_configuration (R := ℤ) broken

omit [Fintype Edge] [DecidableEq Edge] in
/-- 増えた辺の変数を 1 に置いてから全変数を 1 に置いた値が配位の総数、を必要十分版（`R := ℤ`）から導く。
具体版は環準同型 `π` を取るが、ℤ 上では環準同型は自動的に ℤ-代数準同型なので `π.toIntAlgHom` で渡す。 -/
theorem fullBoundaryResponse_outer_edges_to_one_then_eval_one_fromNecSuf
    {Edge'' Outer : Type*} [Fintype Outer]
    (broken'' : Configuration × Outer → Finset Edge'')
    (π : MvPolynomial Edge'' ℤ →+* MvPolynomial Edge ℤ)
    (hπ : ∀ e : Edge'', (eval fun _ : Edge ↦ (1 : ℤ)) (π (X e)) = 1) :
    (eval fun _ : Edge ↦ (1 : ℤ)) (π (multivariatePartitionPolynomial broken'')) =
      Fintype.card (Configuration × Outer) :=
  NecSuf.fullBoundaryResponse_outer_edges_to_one_then_eval_one (R := ℤ) broken''
    π.toIntAlgHom hπ

end Ising3DCut
