/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、分裂した二次空間に一つの次元を足した空間 (V', q')、
第一成分への埋め込みが誘導する準同型 j、足した次元の単位の元 u とその像 g の具体版。
人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                       このファイル
  def_odd_dimensional_extension_of_split_quadratic_space                             SplitData.oddVectorSpace（V'）・SplitData.oddForm（q'）・
                                                                                     SplitData.oddInclusion（in'_1）・SplitData.oddSecondInclusion（in'_2）
  def_family_of_unit_of_complex_numbers                                              unitFamily（o）
  claim_family_of_unit_is_basis_of_complex_numbers                                   linearCombination_unitFamily（準備の式）・unitFamily_isBasis
  claim_polarization_of_odd_extension_quadratic_form                                 SplitData.polarization_oddForm
  claim_odd_extension_quadratic_form_is_quadratic_form                               SplitData.oddForm_isQuadraticForm
  claim_embedding_into_first_component_of_odd_extension_is_isometry                  SplitData.oddForm_oddInclusion（式変形）・
                                                                                     SplitData.oddInclusion_isIsometry
  claim_odd_extension_quadratic_form_at_added_unit_vector_is_one                     SplitData.oddForm_oddSecondInclusion_one
  claim_polarization_of_odd_extension_between_first_component_and_added_unit_vector_is_zero
                                                                                     SplitData.polarization_oddInclusion_oddSecondInclusion_one
  def_setting_of_odd_dimensional_corollary                                           宣言を置かない（既存の記号に名前を付けるだけ。下の「表し方」）
  def_clifford_algebra_of_split_space_in_odd_corollary                               宣言を置かない（A。既存の記号に名前を付けるだけ。下の「表し方」）
  def_basis_of_split_space_in_odd_corollary                                          宣言を置かない（d。既存の記号に名前を付けるだけ。下の「表し方」）
  def_matrix_algebra_in_odd_corollary                                                宣言を置かない（B。既存の記号に名前を付けるだけ。下の「表し方」）
  def_basis_of_odd_extension                                                         SplitData.oddBasis（d'）
  def_clifford_algebra_of_odd_extension                                              SplitData.oddSpace（V'・q'・基底 d' の組。A' = D.oddSpace.Cl）
  def_clifford_generator_map_of_odd_extension                                        D.oddSpace.γ（γ'。SplitData.oddSpace の docstring）
  def_induced_homomorphism_into_odd_extension_clifford_algebra                       SplitData.oddInclusionHom（j）・oddInclusionHom_isHom
  claim_induced_homomorphism_into_odd_extension_after_generator_map                  SplitData.oddInclusionHom_γ
  def_added_unit_vector_of_odd_extension                                             SplitData.addedUnitVector（u）
  def_added_generator_of_odd_extension_clifford_algebra                              SplitData.addedGenerator（g）
  claim_square_of_added_generator_is_one                                             SplitData.addedGenerator_mul_self
  claim_added_generator_anticommutes_with_image_of_split_space                       SplitData.addedGenerator_anticommute

表し方:
- 分裂した二次空間 (V, q) と基底は `SplitData` の `D.space`（V := W ⊕ W^*、q := q_W、基底 c）で、本文の d は c と同じ族
  `D.space.basis` である。B_q は `polarization D.space.space D.space.form`。
- V' = V ⊕ ℂ^vec の元は V の元と ℂ の元の組 (v, t) で、型は `(W × DualSpace D.spaceW) × ℂ`。ℂ^vec は `complexNumbersVectorSpace`。
- 番号付けた族 o:{1}→ℂ・d':{1,…,2M+1}→V' は `ℕ → ℂ`・`ℕ → V'` で表し、1,…,n の外の値は使わない。
- 本文の def_clifford_algebra_of_split_space_in_odd_corollary の A、def_basis_of_split_space_in_odd_corollary の d、
  def_matrix_algebra_in_odd_corollary の B、本文の章「同型の証明」の Φ・Ψ、def_additive_inverse_in_complex_numbers の -_ℂ、
  def_minus_one_in_complex_numbers の -1_ℂ は既存の宣言（`D.space.Cl`、`D.space.basis`、`Isomorphism` の行列環、
  `SplitData.homomorphismToMatrix` 等、ℂ の `-`・`-1`）をそのまま使い、ここでは宣言を置かない。
- j は等長写像が誘導する準同型 `QuadraticSpaceWithBasis.inducedHom`（`InducedHomomorphism.lean`）を θ := in'_1 に当てたものである。
- 本文の前提 M ∈ ℤ_{≥1} は、どの証明も使わない（M = 0 でも同じ証明が通る）ので、仮定に置かない。

必要十分版は `NecSuf/Isomorphism/OddDimensional/OddExtension.lean`、導出版は `OddExtensionFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.InducedHomomorphism
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.OrthogonalBasis
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.Generators
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ComplexNumbersAsVectorSpace

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

/-- 本文 `def_family_of_unit_of_complex_numbers`：o(1) := 1_ℂ（{1} の外の値は使わない）。 -/
def unitFamily : ℕ → ℂ := fun _ => 1

/-- 本文 `claim_family_of_unit_is_basis_of_complex_numbers` の証明の準備の式：Σ_{k=1}^{1} λ_k ·_{ℂ^vec} o_k = λ_1。 -/
theorem linearCombination_unitFamily (c : ℕ → ℂ) :
    linearCombination complexNumbersVectorSpace 1 c unitFamily = c 1 := calc
  linearCombination complexNumbersVectorSpace 1 c unitFamily
      = complexNumbersVectorSpace.add complexNumbersVectorSpace.zero
          (complexNumbersVectorSpace.smul (c 1) (unitFamily 1)) := rfl
  _ = 0 + c 1 * unitFamily 1 := rfl
  _ = 0 + c 1 * 1 := rfl
  _ = c 1 := by ring

/-- 本文 `claim_family_of_unit_is_basis_of_complex_numbers`：o は ℂ^vec の基底である。 -/
theorem unitFamily_isBasis : IsBasisFamily complexNumbersVectorSpace 1 unitFamily where
  linearlyIndependent := by
    intro c hc k hk1 hk
    have hk' : k = 1 := by omega
    subst hk'
    calc c 1 = linearCombination complexNumbersVectorSpace 1 c unitFamily := (linearCombination_unitFamily c).symm
      _ = complexNumbersVectorSpace.zero := hc
      _ = 0 := rfl
  spans := fun t => ⟨fun _ => t, linearCombination_unitFamily (fun _ => t)⟩

end CliffordMatrixIsomorphism.ComplexVectorSpace

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### 一つの次元を足した空間 V' と q' -/

/-- 本文 `def_odd_dimensional_extension_of_split_quadratic_space` の V' := V ⊕ ℂ^vec。 -/
abbrev oddVectorSpace : ComplexVectorSpace ((W × DualSpace D.spaceW) × ℂ) :=
  directSumVectorSpace D.space.space complexNumbersVectorSpace

/-- 本文 `def_odd_dimensional_extension_of_split_quadratic_space` の q'((v, t)) := q(v) +_ℂ (t ·_ℂ t)。 -/
def oddForm (p : (W × DualSpace D.spaceW) × ℂ) : ℂ := D.space.form p.1 + p.2 * p.2

/-- 本文 `def_odd_dimensional_extension_of_split_quadratic_space` の in'_1 : V → V'。 -/
def oddInclusion : W × DualSpace D.spaceW → (W × DualSpace D.spaceW) × ℂ := embedFirst complexNumbersVectorSpace

/-- 本文 `def_odd_dimensional_extension_of_split_quadratic_space` の in'_2 : ℂ^vec → V'。 -/
def oddSecondInclusion : ℂ → (W × DualSpace D.spaceW) × ℂ := embedSecond D.space.space

/-- 本文 `claim_polarization_of_odd_extension_quadratic_form`：
B_{q'}((v, t), (v', t')) = B_q(v, v') +_ℂ (t ·_ℂ t' +_ℂ t' ·_ℂ t)。 -/
theorem polarization_oddForm (v v' : W × DualSpace D.spaceW) (t t' : ℂ) :
    polarization D.oddVectorSpace D.oddForm (v, t) (v', t')
      = polarization D.space.space D.space.form v v' + (t * t' + t' * t) := calc
  polarization D.oddVectorSpace D.oddForm (v, t) (v', t')
      = (D.oddForm (D.oddVectorSpace.add (v, t) (v', t')) + -D.oddForm (v, t)) + -D.oddForm (v', t') := rfl
  _ = (D.oddForm (D.space.space.add v v', complexNumbersVectorSpace.add t t') + -D.oddForm (v, t))
        + -D.oddForm (v', t') := rfl
  _ = (D.oddForm (D.space.space.add v v', t + t') + -D.oddForm (v, t)) + -D.oddForm (v', t') := rfl
  _ = ((D.space.form (D.space.space.add v v') + (t + t') * (t + t')) + -(D.space.form v + t * t))
        + -(D.space.form v' + t' * t') := rfl
  _ = ((D.space.form (D.space.space.add v v') + -D.space.form v) + -D.space.form v') + (t * t' + t' * t) := by ring
  _ = polarization D.space.space D.space.form v v' + (t * t' + t' * t) := rfl

/-- 本文 `claim_odd_extension_quadratic_form_is_quadratic_form`：q' は V' 上の二次形式である。
q = q_W が二次形式であることは `D.space.isQuadraticForm`（`claim_split_quadratic_form_is_quadratic_form`）。 -/
theorem oddForm_isQuadraticForm : IsQuadraticForm D.oddVectorSpace D.oddForm where
  map_smul l p := calc
    D.oddForm (D.oddVectorSpace.smul l p) = D.oddForm (D.space.space.smul l p.1, complexNumbersVectorSpace.smul l p.2) := rfl
    _ = D.oddForm (D.space.space.smul l p.1, l * p.2) := rfl
    _ = D.space.form (D.space.space.smul l p.1) + (l * p.2) * (l * p.2) := rfl
    _ = l * (l * D.space.form p.1) + (l * p.2) * (l * p.2) := by rw [D.space.isQuadraticForm.map_smul l p.1]
    _ = l * (l * (D.space.form p.1 + p.2 * p.2)) := by ring
    _ = l * (l * D.oddForm p) := rfl
  polarization_isLinearForm y := {
    map_add := fun p₁ p₂ => calc
      polarization D.oddVectorSpace D.oddForm (D.oddVectorSpace.add p₁ p₂) y
          = polarization D.oddVectorSpace D.oddForm (D.space.space.add p₁.1 p₂.1, p₁.2 + p₂.2) (y.1, y.2) := rfl
      _ = polarization D.space.space D.space.form (D.space.space.add p₁.1 p₂.1) y.1
            + ((p₁.2 + p₂.2) * y.2 + y.2 * (p₁.2 + p₂.2)) := D.polarization_oddForm _ _ _ _
      _ = (polarization D.space.space D.space.form p₁.1 y.1 + polarization D.space.space D.space.form p₂.1 y.1)
            + ((p₁.2 + p₂.2) * y.2 + y.2 * (p₁.2 + p₂.2)) := by
          rw [(D.space.isQuadraticForm.polarization_isLinearForm y.1).map_add p₁.1 p₂.1]
      _ = (polarization D.space.space D.space.form p₁.1 y.1 + (p₁.2 * y.2 + y.2 * p₁.2))
            + (polarization D.space.space D.space.form p₂.1 y.1 + (p₂.2 * y.2 + y.2 * p₂.2)) := by ring
      _ = polarization D.oddVectorSpace D.oddForm (p₁.1, p₁.2) (y.1, y.2)
            + polarization D.oddVectorSpace D.oddForm (p₂.1, p₂.2) (y.1, y.2) := by
          rw [D.polarization_oddForm p₁.1 y.1 p₁.2 y.2, D.polarization_oddForm p₂.1 y.1 p₂.2 y.2]
    map_smul := fun l p => calc
      polarization D.oddVectorSpace D.oddForm (D.oddVectorSpace.smul l p) y
          = polarization D.oddVectorSpace D.oddForm (D.space.space.smul l p.1, l * p.2) (y.1, y.2) := rfl
      _ = polarization D.space.space D.space.form (D.space.space.smul l p.1) y.1
            + ((l * p.2) * y.2 + y.2 * (l * p.2)) := D.polarization_oddForm _ _ _ _
      _ = l * polarization D.space.space D.space.form p.1 y.1 + ((l * p.2) * y.2 + y.2 * (l * p.2)) := by
          rw [(D.space.isQuadraticForm.polarization_isLinearForm y.1).map_smul l p.1]
      _ = l * (polarization D.space.space D.space.form p.1 y.1 + (p.2 * y.2 + y.2 * p.2)) := by ring
      _ = l * polarization D.oddVectorSpace D.oddForm (p.1, p.2) (y.1, y.2) := by
          rw [D.polarization_oddForm p.1 y.1 p.2 y.2] }

/-- 本文 `claim_embedding_into_first_component_of_odd_extension_is_isometry` の証明の式変形：q'(in'_1(v)) = q(v)。 -/
theorem oddForm_oddInclusion (v : W × DualSpace D.spaceW) : D.oddForm (D.oddInclusion v) = D.space.form v := calc
  D.oddForm (D.oddInclusion v) = D.oddForm (v, complexNumbersVectorSpace.zero) := rfl
  _ = D.oddForm (v, 0) := rfl
  _ = D.space.form v + 0 * 0 := rfl
  _ = D.space.form v := by ring

/-- 本文 `claim_embedding_into_first_component_of_odd_extension_is_isometry`：in'_1 は (V,q) から (V',q') への等長写像である。 -/
theorem oddInclusion_isIsometry :
    IsIsometry D.space.space D.oddVectorSpace D.space.form D.oddForm D.oddInclusion where
  isQuadraticForm := D.space.isQuadraticForm
  isQuadraticForm' := D.oddForm_isQuadraticForm
  isLinearMap := embedFirst_isLinearMap D.space.space complexNumbersVectorSpace
  map_form := D.oddForm_oddInclusion

/-- 本文 `claim_odd_extension_quadratic_form_at_added_unit_vector_is_one`：q'(in'_2(1_ℂ)) = 1_ℂ。 -/
theorem oddForm_oddSecondInclusion_one : D.oddForm (D.oddSecondInclusion 1) = 1 := calc
  D.oddForm (D.oddSecondInclusion 1) = D.oddForm (D.space.space.zero, 1) := rfl
  _ = D.space.form D.space.space.zero + 1 * 1 := rfl
  _ = D.space.form (D.space.space.smul 0 D.space.space.zero) + 1 * 1 := by
      rw [smul_zero_eq_zero D.space.space 0]
  _ = 0 * (0 * D.space.form D.space.space.zero) + 1 * 1 := by
      rw [D.space.isQuadraticForm.map_smul 0 D.space.space.zero]
  _ = 1 := by ring

/-- 本文 `claim_polarization_of_odd_extension_between_first_component_and_added_unit_vector_is_zero`：
B_{q'}(in'_1(v), in'_2(1_ℂ)) = 0_ℂ。 -/
theorem polarization_oddInclusion_oddSecondInclusion_one (v : W × DualSpace D.spaceW) :
    polarization D.oddVectorSpace D.oddForm (D.oddInclusion v) (D.oddSecondInclusion 1) = 0 := calc
  polarization D.oddVectorSpace D.oddForm (D.oddInclusion v) (D.oddSecondInclusion 1)
      = polarization D.oddVectorSpace D.oddForm (v, complexNumbersVectorSpace.zero) (D.space.space.zero, 1) := rfl
  _ = polarization D.oddVectorSpace D.oddForm (v, 0) (D.space.space.zero, 1) := rfl
  _ = polarization D.space.space D.space.form v D.space.space.zero + (0 * 1 + 1 * 0) :=
      D.polarization_oddForm v D.space.space.zero 0 1
  _ = polarization D.space.space D.space.form v D.space.space.zero := by ring
  _ = 0 := (polarization_isLinearForm_right D.space.space D.space.form D.space.isQuadraticForm v).map_zero

/-! ### 奇数次元の系で固定する記号 -/

/-- 本文 `def_basis_of_odd_extension`：d' は `claim_basis_of_direct_sum_of_two_vector_spaces` で
V_1 := V、V_2 := ℂ^vec、n := 2M、n' := 1、b := d、b' := o とした族。 -/
def oddBasis : ℕ → (W × DualSpace D.spaceW) × ℂ :=
  concatenatedFamily D.space.space complexNumbersVectorSpace (D.M + D.M) D.space.basis unitFamily

/-- 本文 `def_clifford_algebra_of_odd_extension`：(V', q') と基底 d' の組。A' := Cl(V', q') は `D.oddSpace.Cl`。
本文 `def_clifford_generator_map_of_odd_extension` の γ' : V' → A' は `D.oddSpace.γ`。q' が二次形式であることは `claim_odd_extension_quadratic_form_is_quadratic_form`。 -/
def oddSpace : QuadraticSpaceWithBasis ((W × DualSpace D.spaceW) × ℂ) where
  space := D.oddVectorSpace
  dim := (D.M + D.M) + 1
  basis := D.oddBasis
  isBasis := concatenatedFamily_isBasisFamily D.space.space complexNumbersVectorSpace (D.M + D.M) 1 D.space.basis
    unitFamily D.space.isBasis unitFamily_isBasis
  form := D.oddForm
  isQuadraticForm := D.oddForm_isQuadraticForm

/-! ### 誘導された準同型 j、u、g -/

/-- 本文 `def_induced_homomorphism_into_odd_extension_clifford_algebra`：j := Cl(in'_1) : A → A'。 -/
def oddInclusionHom : D.space.Cl → D.oddSpace.Cl :=
  QuadraticSpaceWithBasis.inducedHom D.space D.oddSpace D.oddInclusion D.oddInclusion_isIsometry

/-- 本文 `def_induced_homomorphism_into_odd_extension_clifford_algebra`：j は ℂ-代数の準同型である
（`def_homomorphism_of_clifford_algebras_induced_by_isometry`）。 -/
theorem oddInclusionHom_isHom :
    IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.oddSpace.cliffordAlgebra D.oddInclusionHom :=
  QuadraticSpaceWithBasis.inducedHom_isHom D.space D.oddSpace D.oddInclusion D.oddInclusion_isIsometry

/-- 本文 `claim_induced_homomorphism_into_odd_extension_after_generator_map`：j(γ(v)) = γ'(in'_1(v))。 -/
theorem oddInclusionHom_γ (v : W × DualSpace D.spaceW) :
    D.oddInclusionHom (D.space.γ v) = D.oddSpace.γ (D.oddInclusion v) := calc
  D.oddInclusionHom (D.space.γ v)
      = QuadraticSpaceWithBasis.inducedHom D.space D.oddSpace D.oddInclusion D.oddInclusion_isIsometry (D.space.γ v) := rfl
  _ = D.oddSpace.γ (D.oddInclusion v) :=
      QuadraticSpaceWithBasis.inducedHom_γ D.space D.oddSpace D.oddInclusion D.oddInclusion_isIsometry v

/-- 本文 `def_added_unit_vector_of_odd_extension`：u := in'_2(1_ℂ)。 -/
def addedUnitVector : (W × DualSpace D.spaceW) × ℂ := D.oddSecondInclusion 1

/-- 本文 `def_added_generator_of_odd_extension_clifford_algebra`：g := γ'(u)。 -/
def addedGenerator : D.oddSpace.Cl := D.oddSpace.γ D.addedUnitVector

/-- 本文 `claim_square_of_added_generator_is_one`：g ·_{A'} g = 1_{A'}。 -/
theorem addedGenerator_mul_self :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator D.addedGenerator = D.oddSpace.cliffordAlgebra.one := calc
  D.oddSpace.cliffordAlgebra.mul D.addedGenerator D.addedGenerator
      = D.oddSpace.cliffordAlgebra.mul (D.oddSpace.γ D.addedUnitVector) (D.oddSpace.γ D.addedUnitVector) := rfl
  _ = D.oddSpace.cliffordAlgebra.smul (D.oddSpace.form D.addedUnitVector) D.oddSpace.cliffordAlgebra.one :=
      D.oddSpace.γ_mul_self D.addedUnitVector
  _ = D.oddSpace.cliffordAlgebra.smul (D.oddForm (D.oddSecondInclusion 1)) D.oddSpace.cliffordAlgebra.one := rfl
  _ = D.oddSpace.cliffordAlgebra.smul 1 D.oddSpace.cliffordAlgebra.one := by rw [D.oddForm_oddSecondInclusion_one]
  _ = D.oddSpace.cliffordAlgebra.one := D.oddSpace.cliffordAlgebra.one_smul _

/-- 本文 `claim_added_generator_anticommutes_with_image_of_split_space`：
g ·_{A'} j(γ(v)) +_{A'} j(γ(v)) ·_{A'} g = 0_{A'}。 -/
theorem addedGenerator_anticommute (v : W × DualSpace D.spaceW) :
    D.oddSpace.cliffordAlgebra.add
        (D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom (D.space.γ v)))
        (D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.space.γ v)) D.addedGenerator)
      = D.oddSpace.cliffordAlgebra.zero := by
  let A' := D.oddSpace.cliffordAlgebra
  calc A'.add (A'.mul D.addedGenerator (D.oddInclusionHom (D.space.γ v)))
        (A'.mul (D.oddInclusionHom (D.space.γ v)) D.addedGenerator)
      = A'.add (A'.mul D.addedGenerator (D.oddSpace.γ (D.oddInclusion v)))
          (A'.mul (D.oddSpace.γ (D.oddInclusion v)) D.addedGenerator) := by rw [D.oddInclusionHom_γ v]
    _ = A'.add (A'.mul (D.oddSpace.γ D.addedUnitVector) (D.oddSpace.γ (D.oddInclusion v)))
          (A'.mul (D.oddSpace.γ (D.oddInclusion v)) (D.oddSpace.γ D.addedUnitVector)) := rfl
    _ = A'.smul (polarization D.oddSpace.space D.oddSpace.form D.addedUnitVector (D.oddInclusion v)) A'.one :=
        D.oddSpace.γ_anticommutator D.addedUnitVector (D.oddInclusion v)
    _ = A'.smul (polarization D.oddSpace.space D.oddSpace.form (D.oddInclusion v) D.addedUnitVector) A'.one := by
        rw [polarization_symm D.oddSpace.space D.oddSpace.form D.addedUnitVector (D.oddInclusion v)]
    _ = A'.smul (polarization D.oddVectorSpace D.oddForm (D.oddInclusion v) (D.oddSecondInclusion 1)) A'.one := rfl
    _ = A'.smul 0 A'.one := by rw [D.polarization_oddInclusion_oddSecondInclusion_one v]
    _ = A'.zero := ComplexAlgebra.zero_smul_eq_zero A' A'.one

end

end CliffordMatrixIsomorphism.Clifford.SplitData
