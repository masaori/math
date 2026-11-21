/-
# 部分空間・基底・次元・直和の具体版を必要十分版から導く

具体版 `SubspacesBasesAndDimension.lean`・`ClaimNonzeroElementsOfImagesOfCheckQFormBasis.lean` の各宣言を、必要十分版
`Ising2D/NecSuf/SubspacesBasesAndDimension.lean`・`Ising2D/NecSuf/NonzeroElementsOfImagesOfProjectionsFormBasis.lean` の
`K := ℂ`、`V := Matrix ι κ ℂ`（数ベクトルは `Matrix ι (Fin 1) ℂ`）の特殊化として得る（README 4 節の要件 4）。

- 定義は、具体版と必要十分版が同じ式なので `Iff.rfl`（部分空間は構造体の欄の入れ替え）で一致する。
- 人手の `x ↦ Qx` は、必要十分版の線型写像 `f` に `matMulLeftLinear Q` を渡す。
- `nonzero_elements_of_images_of_check_Q_form_basis` は、必要十分版の自己準同型の族 `Pr` に `x ↦ Q̌_ε x` を渡し、
  全体を張る族に行列単位の族（`matrix_units_form_basis`）を渡す。
-/
import Ising2D.MathematicalTools.SubspacesBasesAndDimension.ClaimNonzeroElementsOfImagesOfCheckQFormBasis
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWordsFromNecSuf
import Ising2D.NecSuf.SubspacesBasesAndDimension
import Ising2D.NecSuf.NonzeroElementsOfImagesOfProjectionsFormBasis

namespace Ising2D

section Definitions

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

theorem isSubspaceMat_iff_necSuf (U : Set (Matrix ι κ ℂ)) : IsSubspaceMat U ↔ NecSuf.IsSubspaceSet ℂ U :=
  ⟨fun h => ⟨h.1, h.2, h.3⟩, fun h => ⟨h.1, h.2, h.3⟩⟩

theorem matLinComb_eq_necSuf {p : ℕ} (c : Fin p → ℂ) (u : Fin p → Matrix ι κ ℂ) :
    matLinComb c u = NecSuf.famLinComb c u := rfl

theorem matIsLinComb_iff_necSuf (A : Matrix ι κ ℂ) {p : ℕ} (u : Fin p → Matrix ι κ ℂ) :
    MatIsLinComb A u ↔ NecSuf.FamIsLinComb ℂ A u := Iff.rfl

theorem matSpans_iff_necSuf (U : Set (Matrix ι κ ℂ)) {p : ℕ} (u : Fin p → Matrix ι κ ℂ) :
    MatSpans U u ↔ NecSuf.FamSpans ℂ U u := Iff.rfl

theorem matLinIndep_iff_necSuf {p : ℕ} (u : Fin p → Matrix ι κ ℂ) :
    MatLinIndep u ↔ NecSuf.FamLinIndep ℂ u := Iff.rfl

theorem matIsBasis_iff_necSuf (U : Set (Matrix ι κ ℂ)) {p : ℕ} (u : Fin p → Matrix ι κ ℂ) :
    MatIsBasis U u ↔ NecSuf.FamIsBasis ℂ U u := Iff.rfl

theorem matIsBasisIndexed_iff_necSuf (U : Set (Matrix ι κ ℂ)) {α : Type*} [Fintype α] (u : α → Matrix ι κ ℂ) :
    MatIsBasisIndexed U u ↔ NecSuf.FamIsBasisIndexed ℂ U u := Iff.rfl

theorem isDirectSumOfTwoMat_iff_necSuf (Vs U W : Set (Matrix ι κ ℂ)) :
    IsDirectSumOfTwoMat Vs U W ↔ NecSuf.IsDirectSumOfTwo Vs U W := Iff.rfl

/-- `def_dimension`: 具体版の次元は必要十分版の `famDim` に等しい。 -/
theorem matDim_eq_necSuf (U : Set (Matrix ι κ ℂ)) (hU : IsSubspaceMat U)
    (h : ∃ p : ℕ, ∃ u : Fin p → Matrix ι κ ℂ, NecSuf.FamIsBasis ℂ U u) : matDim U hU = NecSuf.famDim ℂ U h := by
  obtain ⟨u, hu⟩ := matDim_spec U hU
  exact (NecSuf.famDim_eq_of_isBasis h hu).symm

end Definitions

theorem isDirectSumOverBinaryWordsMat_iff_necSuf {m n : ℕ} (r : ℕ) (Vs : Set (Matrix (Fin m) (Fin n) ℂ))
    (U : (Fin (r + 1) → Fin 2) → Set (Matrix (Fin m) (Fin n) ℂ)) :
    IsDirectSumOverBinaryWordsMat r Vs U ↔ NecSuf.IsDirectSumOverBinaryWords r Vs U := by
  simp only [IsDirectSumOverBinaryWordsMat, NecSuf.IsDirectSumOverBinaryWords, binaryWordMatrixSum_eq_binWordSum]

theorem finite_sum_of_complex_numbers_times_complex_number_of_necSuf (m : ℕ) (y : Fin (m + 1) → ℂ) (w : ℂ) :
    ∑ j, y j * w = (∑ j, y j) * w :=
  NecSuf.finite_sum_of_complex_numbers_times_complex_number m y w

theorem homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution_of_necSuf
    (q p : ℕ) (h : q < p) (a : Fin p → Fin q → ℂ) :
    ∃ c : Fin p → ℂ, (∃ i, c i ≠ 0) ∧ ∀ j, ∑ i, c i * a i j = 0 :=
  NecSuf.homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution q p h a

/-- 人手の `x ↦ Qx`（`Mat(m,n,ℂ)` の行列を数ベクトルに左から掛ける写像）。 -/
def matMulLeftLinear {ι κ : Type*} [Fintype ι] [Fintype κ] (Q : Matrix ι κ ℂ) :
    Matrix κ (Fin 1) ℂ →ₗ[ℂ] Matrix ι (Fin 1) ℂ where
  toFun x := Q * x
  map_add' := Matrix.mul_add Q
  map_smul' c x := Matrix.mul_smul Q c x

section Claims

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

theorem linear_combination_splits_off_last_term_of_necSuf {p : ℕ} (c : Fin (p + 1) → ℂ)
    (u : Fin (p + 1) → Matrix ι κ ℂ) :
    matLinComb c u = matLinComb (fun t => c t.castSucc) (fun t => u t.castSucc) + c (Fin.last p) • u (Fin.last p) :=
  NecSuf.linear_combination_splits_off_last_term c u

theorem matrix_sum_is_associative_of_necSuf (A B C : Matrix ι κ ℂ) : (A + B) + C = A + (B + C) :=
  NecSuf.matrix_sum_is_associative A B C

theorem linear_combination_splits_into_two_blocks_of_necSuf {r : ℕ} (s : ℕ) (c : Fin (r + s) → ℂ)
    (v : Fin (r + s) → Matrix ι κ ℂ) :
    matLinComb c v
      = matLinComb (fun t => c (Fin.castAdd s t)) (fun t => v (Fin.castAdd s t))
        + matLinComb (fun t => c (Fin.natAdd r t)) (fun t => v (Fin.natAdd r t)) :=
  NecSuf.linear_combination_splits_into_two_blocks s c v

theorem linear_combination_of_subspace_elements_stays_in_subspace_of_necSuf {U : Set (Matrix ι κ ℂ)}
    (hU : IsSubspaceMat U) {p : ℕ} (c : Fin p → ℂ) (u : Fin p → Matrix ι κ ℂ) (hu : ∀ t, u t ∈ U) :
    matLinComb c u ∈ U :=
  NecSuf.linear_combination_of_subspace_elements_stays_in_subspace ((isSubspaceMat_iff_necSuf U).1 hU) c u hu

theorem linearly_independent_family_has_no_zero_element_of_necSuf {p : ℕ} {u : Fin p → Matrix ι κ ℂ}
    (hu : MatLinIndep u) (s : Fin p) : u s ≠ 0 :=
  NecSuf.linearly_independent_family_has_no_zero_element hu s

theorem linearly_independent_family_is_no_longer_than_spanning_family_of_necSuf {p q : ℕ} (_hq : 1 ≤ q)
    (u : Fin p → Matrix ι κ ℂ) (w : Fin q → Matrix ι κ ℂ) (hu : ∀ i, MatIsLinComb (u i) w)
    (hind : MatLinIndep u) : p ≤ q :=
  NecSuf.linearly_independent_family_is_no_longer_than_spanning_family u w hu hind

theorem extending_independent_family_by_element_outside_span_of_necSuf {p : ℕ} {u : Fin p → Matrix ι κ ℂ}
    {x : Matrix ι κ ℂ} (hu : MatLinIndep u) (hx : ¬ MatIsLinComb x u) :
    MatLinIndep (Fin.snoc (α := fun _ => Matrix ι κ ℂ) u x) :=
  NecSuf.extending_independent_family_by_element_outside_span hu hx

theorem matrix_units_form_basis_of_necSuf [DecidableEq ι] [DecidableEq κ] {N : ℕ} (π : Fin N ≃ ι × κ) :
    MatIsBasis (Set.univ : Set (Matrix ι κ ℂ)) (fun t => matUnit (π t).1 (π t).2) :=
  NecSuf.matrix_units_form_basis (K := ℂ) π

theorem subspace_has_basis_of_necSuf (U : Set (Matrix ι κ ℂ)) (_hU : IsSubspaceMat U) :
    ∃ p, p ≤ Fintype.card ι * Fintype.card κ ∧ ∃ u : Fin p → Matrix ι κ ℂ, MatIsBasis U u := by
  classical
  obtain ⟨p, hp, u, hu⟩ := NecSuf.subspace_has_basis (K := ℂ) _ (fun A => matUnit_spans A) U
  exact ⟨p, by rw [← Fintype.card_prod]; exact hp, u, hu⟩

theorem bases_of_subspace_have_same_number_of_elements_of_necSuf {U : Set (Matrix ι κ ℂ)} (_hU : IsSubspaceMat U)
    {p q : ℕ} {u : Fin p → Matrix ι κ ℂ} {w : Fin q → Matrix ι κ ℂ}
    (hu : MatIsBasis U u) (hw : MatIsBasis U w) : p = q :=
  NecSuf.bases_of_subspace_have_same_number_of_elements hu hw

theorem dimension_of_matrix_space_of_necSuf :
    matDim (Set.univ : Set (Matrix ι κ ℂ)) isSubspaceMat_univ = Fintype.card ι * Fintype.card κ := by
  classical
  obtain ⟨u, hu⟩ := matDim_spec (Set.univ : Set (Matrix ι κ ℂ)) isSubspaceMat_univ
  rw [NecSuf.bases_of_subspace_have_same_number_of_elements hu
    (NecSuf.matrix_units_form_basis (K := ℂ) (Fintype.equivFin (ι × κ)).symm), Fintype.card_prod]

theorem image_of_matrix_is_subspace_of_necSuf (Q : Matrix ι κ ℂ) :
    IsSubspaceMat {y : Matrix ι (Fin 1) ℂ | ∃ x : Matrix κ (Fin 1) ℂ, y = Q * x} :=
  (isSubspaceMat_iff_necSuf _).2 (NecSuf.image_of_matrix_is_subspace (matMulLeftLinear Q))

theorem kernel_of_matrix_is_subspace_of_necSuf (Q : Matrix ι κ ℂ) :
    IsSubspaceMat {x : Matrix κ (Fin 1) ℂ | Q * x = 0} :=
  (isSubspaceMat_iff_necSuf _).2 (NecSuf.kernel_of_matrix_is_subspace (matMulLeftLinear Q))

theorem eigenvalue_equation_solution_set_is_subspace_of_necSuf (A : Matrix κ κ ℂ) (lam : ℂ) :
    IsSubspaceMat {x : Matrix κ (Fin 1) ℂ | A * x = lam • x} :=
  (isSubspaceMat_iff_necSuf _).2 (NecSuf.eigenvalue_equation_solution_set_is_subspace (matMulLeftLinear A) lam)

theorem concatenated_bases_of_direct_sum_form_basis_of_necSuf {Vs U W : Set (Matrix ι κ ℂ)}
    (hU : IsSubspaceMat U) (hW : IsSubspaceMat W) (hds : IsDirectSumOfTwoMat Vs U W)
    {r s : ℕ} {u : Fin r → Matrix ι κ ℂ} {w : Fin s → Matrix ι κ ℂ} (hu : MatIsBasis U u) (hw : MatIsBasis W w) :
    MatIsBasis Vs (Fin.append u w) :=
  NecSuf.concatenated_bases_of_direct_sum_form_basis ((isSubspaceMat_iff_necSuf U).1 hU)
    ((isSubspaceMat_iff_necSuf W).1 hW) hds hu hw

theorem one_dimensional_subspace_is_multiples_of_nonzero_element_of_necSuf {U : Set (Matrix ι κ ℂ)}
    (hU : IsSubspaceMat U) (hdim : matDim U hU = 1) :
    ∃ q ∈ U, q ≠ 0 ∧ U = {A | ∃ c : ℂ, A = c • q} := by
  obtain ⟨u, hu⟩ := matDim_spec U hU
  have h : ∃ p : ℕ, ∃ u : Fin p → Matrix ι κ ℂ, NecSuf.FamIsBasis ℂ U u := ⟨_, u, hu⟩
  exact NecSuf.one_dimensional_subspace_is_multiples_of_nonzero_element ((isSubspaceMat_iff_necSuf U).1 hU) h
    ((matDim_eq_necSuf U hU h).symm.trans hdim)

end Claims

theorem matrix_of_basis_columns_has_inverse_of_necSuf {n : ℕ} (v : Fin n → Matrix (Fin n) (Fin 1) ℂ)
    (hv : MatIsBasis Set.univ v) :
    ∃ P' : Matrix (Fin n) (Fin n) ℂ,
      P' * Matrix.of (fun i j => v j i 0) = 1 ∧ Matrix.of (fun i j => v j i 0) * P' = 1 :=
  NecSuf.matrix_of_basis_columns_has_inverse v hv

/-- 列ベクトルの空間 `Matrix ι (Fin 1) ℂ` の行列単位を、元の個数が `N` の添字で並べる全単射（`π(t) := (t,1)`）。 -/
noncomputable def columnUnitEquiv {ι : Type*} [Fintype ι] [DecidableEq ι] {N : ℕ} (hN : Fintype.card ι = N) : Fin N ≃ ι × Fin 1 where
  toFun t := ((Fintype.equivFinOfCardEq hN).symm t, 0)
  invFun x := Fintype.equivFinOfCardEq hN x.1
  left_inv t := by simp
  right_inv x := Prod.ext (by simp) (Subsingleton.elim _ _)

theorem linearly_independent_family_of_n_vectors_is_basis_of_necSuf {ι : Type*} [Fintype ι] [DecidableEq ι] {N : ℕ}
    (hN : Fintype.card ι = N) (v : Fin N → Matrix ι (Fin 1) ℂ) (hv : MatLinIndep v) : MatIsBasis Set.univ v :=
  NecSuf.linearly_independent_family_of_n_vectors_is_basis _
    (fun A => (matrix_units_form_basis (columnUnitEquiv hN)).1.2 A trivial) v hv

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

theorem nonzero_elements_of_images_of_check_Q_form_basis_of_necSuf
    (q : Finset (CheckIdx M) → Matrix (Conf M) (Fin 1) ℂ) (hq : ∀ T, ∃ x, q T = F.Qproj T * x)
    (hq0 : ∀ T, q T ≠ 0) (π : Fin (Fintype.card (Finset (CheckIdx M))) ≃ Finset (CheckIdx M)) :
    MatIsBasis Set.univ (q ∘ π) ∧ MatIsBasisIndexed Set.univ q := by
  let Pr : Finset (CheckIdx M) → Module.End ℂ (Matrix (Conf M) (Fin 1) ℂ) := fun T => matMulLeftLinear (F.Qproj T)
  have hne : ∀ T T', T ≠ T' → Pr T' * Pr T = 0 := fun T T' h => LinearMap.ext fun x => by
    show F.Qproj T' * (F.Qproj T * x) = 0
    rw [← Matrix.mul_assoc, F.Qproj_mul_Qproj_of_ne h.symm, Matrix.zero_mul]
  have hsq : ∀ T, Pr T ^ 2 = Pr T := fun T => LinearMap.ext fun x => by
    rw [pow_two, Module.End.mul_apply]
    show F.Qproj T * (F.Qproj T * x) = F.Qproj T * x
    rw [← Matrix.mul_assoc, F.Qproj_mul_self T]
  exact NecSuf.nonzero_elements_of_images_of_projections_form_basis Pr hne hsq q hq hq0 _
    (fun A => (matrix_units_form_basis (columnUnitEquiv (card_conf_eq_card_finset_checkIdx (M := M)))).1.2 A trivial) π

end CheckFermiSetup

end Ising2D
