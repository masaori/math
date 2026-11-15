/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、一つの次元を足した空間 (V', q')・j・u・g の具体版が、
必要十分版の K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。

  具体版                                              必要十分版の特殊化
  linearCombination_unitFamily・unitFamily_isBasis    …_of_necSuf
  oddVectorSpace・oddForm                             oddVectorSpace_eq_of_necSuf・oddForm_eq_necSuf（rfl）
  polarization_oddForm ほか q' の五つの主張           …_of_necSuf
  oddInclusionHom_isHom・oddInclusionHom_γ            …_of_necSuf
  addedGenerator_mul_self・addedGenerator_anticommute …_of_necSuf（具体版と同じ手順を、各段の導出版から組み立てる）

運び方:
- q' についての主張は、必要十分版が任意の K-線型空間 S と写像 q について書いてあるので、S := V の組を `toNecSuf` で読んだもの、
  q := q_W、L := `complexValuedMapsLaws` を入れる。V' の点の型は具体版と同じで、具体版の V' の演算・q'・B_{q'} は
  必要十分版のものと定義により一致する（`rfl`）。
- j・g の主張は、具体版の Cl(V,q)・Cl(V',q') と必要十分版のものが別の集合なので、必要十分版の主張を直に特殊化しない。
  系「一般の偶数次元」の導出版と同じく、具体版と同じ手順を各段の導出版（誘導される準同型・γ の平方・γ の反交換子・偏極の対称性・
  この節の q' の主張・零のスカラー倍）から組み立てる。
ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ を自分自身の上の線型空間にする八つの性質）、a + (-a) = 0 の `add_neg_cancel`、
0 + a = a・a · 0 = 0・0 · a = 0・1 · a = a・a · 1 = a・0 + 0 = 0・乗法の交換法則である。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.OddExtension
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.InducedHomomorphismFromNecSuf
import CliffordMatrixIsomorphism.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebraFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.QuadraticForm.QuadraticFormFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorProduct.TensorProductFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ComplexVectorSpaceFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.OddExtension

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

/-- 本文 `claim_family_of_unit_is_basis_of_complex_numbers` の準備の式を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem linearCombination_unitFamily_of_necSuf (c : ℕ → ℂ) :
    linearCombination complexNumbersVectorSpace 1 c unitFamily = c 1 := by
  rw [linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_unitFamily complexValuedMapsLaws mul_one zero_add c

/-- 本文 `claim_family_of_unit_is_basis_of_complex_numbers` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem unitFamily_isBasis_of_necSuf : IsBasisFamily complexNumbersVectorSpace 1 unitFamily :=
  (isBasisFamily_iff_necSuf complexNumbersVectorSpace 1 unitFamily).2
    (NecSuf.VectorSpace.unitFamily_isBasis complexValuedMapsLaws mul_one zero_add)

end CliffordMatrixIsomorphism.ComplexVectorSpace

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 具体版の V' を必要十分版の線型空間として読んだものは、必要十分版の V' に S := V、L := ℂ の性質を入れたものである。 -/
theorem oddVectorSpace_eq_of_necSuf :
    D.oddVectorSpace.toNecSuf = NecSuf.VectorSpace.oddVectorSpace complexValuedMapsLaws D.space.space.toNecSuf := rfl

/-- 具体版の q' は、必要十分版の q' に q := q_W を入れたものである。 -/
theorem oddForm_eq_necSuf : D.oddForm = NecSuf.VectorSpace.oddForm D.space.form := rfl

/-- 本文 `claim_polarization_of_odd_extension_quadratic_form` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_oddForm_of_necSuf (v v' : W × DualSpace D.spaceW) (t t' : ℂ) :
    polarization D.oddVectorSpace D.oddForm (v, t) (v', t')
      = polarization D.space.space D.space.form v v' + (t * t' + t' * t) :=
  NecSuf.VectorSpace.polarization_oddForm complexValuedMapsLaws add_neg_cancel zero_add D.space.space.toNecSuf
    D.space.form v v' t t'

/-- 本文 `claim_odd_extension_quadratic_form_is_quadratic_form` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem oddForm_isQuadraticForm_of_necSuf : IsQuadraticForm D.oddVectorSpace D.oddForm :=
  (isQuadraticForm_iff_necSuf D.oddVectorSpace D.oddForm).2
    (NecSuf.VectorSpace.oddForm_isQuadraticForm complexValuedMapsLaws add_neg_cancel zero_add mul_comm
      D.space.space.toNecSuf D.space.form ((isQuadraticForm_iff_necSuf D.space.space D.space.form).1 D.space.isQuadraticForm))

/-- 本文 `claim_embedding_into_first_component_of_odd_extension_is_isometry` の式変形を、必要十分版から得たもの。 -/
theorem oddForm_oddInclusion_of_necSuf (v : W × DualSpace D.spaceW) :
    D.oddForm (D.oddInclusion v) = D.space.form v :=
  NecSuf.VectorSpace.oddForm_oddInclusion complexValuedMapsLaws mul_zero D.space.form v

/-- 本文 `claim_embedding_into_first_component_of_odd_extension_is_isometry` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem oddInclusion_isIsometry_of_necSuf :
    IsIsometry D.space.space D.oddVectorSpace D.space.form D.oddForm D.oddInclusion :=
  (isIsometry_iff_necSuf D.space.space D.oddVectorSpace D.space.form D.oddForm D.oddInclusion).2
    (NecSuf.VectorSpace.oddInclusion_isIsometry complexValuedMapsLaws add_neg_cancel zero_add mul_comm mul_zero
      (add_zero 0) D.space.space.toNecSuf D.space.form
      ((isQuadraticForm_iff_necSuf D.space.space D.space.form).1 D.space.isQuadraticForm))

/-- 本文 `claim_odd_extension_quadratic_form_at_added_unit_vector_is_one` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem oddForm_oddSecondInclusion_one_of_necSuf : D.oddForm (D.oddSecondInclusion 1) = 1 :=
  NecSuf.VectorSpace.oddForm_oddSecondInclusion_one (add_zero 0) mul_zero zero_mul one_mul zero_add
    D.space.space.toNecSuf D.space.form D.space.isQuadraticForm.map_smul

/-- 本文 `claim_polarization_of_odd_extension_between_first_component_and_added_unit_vector_is_zero` を、
必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_oddInclusion_oddSecondInclusion_one_of_necSuf (v : W × DualSpace D.spaceW) :
    polarization D.oddVectorSpace D.oddForm (D.oddInclusion v) (D.oddSecondInclusion 1) = 0 :=
  NecSuf.VectorSpace.polarization_oddInclusion_oddSecondInclusion_one complexValuedMapsLaws add_neg_cancel zero_add
    zero_mul (add_zero 0) D.space.space.toNecSuf D.space.form
    ((isQuadraticForm_iff_necSuf D.space.space D.space.form).1 D.space.isQuadraticForm) v

/-- 本文 `def_induced_homomorphism_into_odd_extension_clifford_algebra` の「j は ℂ-代数の準同型」を必要十分版から得る
（等長写像が誘導する準同型の導出版 `inducedHom_isHom_of_necSuf` を θ := in'_1 に当てる）。 -/
theorem oddInclusionHom_isHom_of_necSuf :
    IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.oddSpace.cliffordAlgebra D.oddInclusionHom :=
  QuadraticSpaceWithBasis.inducedHom_isHom_of_necSuf D.space D.oddSpace D.oddInclusion D.oddInclusion_isIsometry

/-- 本文 `claim_induced_homomorphism_into_odd_extension_after_generator_map` を、必要十分版から得たもの。 -/
theorem oddInclusionHom_γ_of_necSuf (v : W × DualSpace D.spaceW) :
    D.oddInclusionHom (D.space.γ v) = D.oddSpace.γ (D.oddInclusion v) :=
  QuadraticSpaceWithBasis.inducedHom_γ_of_necSuf D.space D.oddSpace D.oddInclusion D.oddInclusion_isIsometry v

/-- 本文 `claim_square_of_added_generator_is_one` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem addedGenerator_mul_self_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator D.addedGenerator = D.oddSpace.cliffordAlgebra.one := calc
  D.oddSpace.cliffordAlgebra.mul D.addedGenerator D.addedGenerator
      = D.oddSpace.cliffordAlgebra.mul (D.oddSpace.γ D.addedUnitVector) (D.oddSpace.γ D.addedUnitVector) := rfl
  _ = D.oddSpace.cliffordAlgebra.smul (D.oddSpace.form D.addedUnitVector) D.oddSpace.cliffordAlgebra.one :=
      D.oddSpace.γ_mul_self_of_necSuf D.addedUnitVector
  _ = D.oddSpace.cliffordAlgebra.smul (D.oddForm (D.oddSecondInclusion 1)) D.oddSpace.cliffordAlgebra.one := rfl
  _ = D.oddSpace.cliffordAlgebra.smul 1 D.oddSpace.cliffordAlgebra.one := by
      rw [D.oddForm_oddSecondInclusion_one_of_necSuf]
  _ = D.oddSpace.cliffordAlgebra.one := D.oddSpace.cliffordAlgebra.one_smul _

/-- 本文 `claim_added_generator_anticommutes_with_image_of_split_space` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem addedGenerator_anticommute_of_necSuf (v : W × DualSpace D.spaceW) :
    D.oddSpace.cliffordAlgebra.add
        (D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom (D.space.γ v)))
        (D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.space.γ v)) D.addedGenerator)
      = D.oddSpace.cliffordAlgebra.zero := by
  let A' := D.oddSpace.cliffordAlgebra
  calc A'.add (A'.mul D.addedGenerator (D.oddInclusionHom (D.space.γ v)))
        (A'.mul (D.oddInclusionHom (D.space.γ v)) D.addedGenerator)
      = A'.add (A'.mul D.addedGenerator (D.oddSpace.γ (D.oddInclusion v)))
          (A'.mul (D.oddSpace.γ (D.oddInclusion v)) D.addedGenerator) := by rw [D.oddInclusionHom_γ_of_necSuf v]
    _ = A'.add (A'.mul (D.oddSpace.γ D.addedUnitVector) (D.oddSpace.γ (D.oddInclusion v)))
          (A'.mul (D.oddSpace.γ (D.oddInclusion v)) (D.oddSpace.γ D.addedUnitVector)) := rfl
    _ = A'.smul (polarization D.oddSpace.space D.oddSpace.form D.addedUnitVector (D.oddInclusion v)) A'.one :=
        D.oddSpace.γ_anticommutator_of_necSuf D.addedUnitVector (D.oddInclusion v)
    _ = A'.smul (polarization D.oddSpace.space D.oddSpace.form (D.oddInclusion v) D.addedUnitVector) A'.one := by
        rw [polarization_symm_of_necSuf D.oddSpace.space D.oddSpace.form D.addedUnitVector (D.oddInclusion v)]
    _ = A'.smul (polarization D.oddVectorSpace D.oddForm (D.oddInclusion v) (D.oddSecondInclusion 1)) A'.one := rfl
    _ = A'.smul 0 A'.one := by rw [D.polarization_oddInclusion_oddSecondInclusion_one_of_necSuf v]
    _ = A'.zero := zero_smul_eq_zero_of_necSuf A'.toComplexVectorSpace A'.one

end

end CliffordMatrixIsomorphism.Clifford.SplitData
