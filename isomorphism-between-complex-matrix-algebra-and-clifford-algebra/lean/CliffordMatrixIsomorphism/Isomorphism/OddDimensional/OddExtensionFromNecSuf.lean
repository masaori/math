/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、一つの次元を足した空間 (V', q')・j・u・g の具体版が、
必要十分版の K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。

  具体版                                              必要十分版の特殊化
  linearCombination_unitFamily・unitFamily_isBasis    …_of_necSuf
  oddVectorSpace・oddForm                             oddVectorSpace_eq_of_necSuf・oddForm_eq_necSuf（rfl）
  polarization_oddForm ほか q' の五つの主張           …_of_necSuf
  oddInclusionHom_isHom・oddInclusionHom_γ            …_of_necSuf（後者は必要十分版の主張を T'・S' で引き戻す）
  addedGenerator_mul_self・addedGenerator_anticommute …_of_necSuf（必要十分版の主張を T'・S' で引き戻す）

運び方:
- q' についての主張は、必要十分版が任意の K-線型空間 S と写像 q について書いてあるので、S := V の組を `toNecSuf` で読んだもの、
  q := q_W、L := `complexValuedMapsLaws` を入れる。V' の点の型は具体版と同じで、具体版の V' の演算・q'・B_{q'} は
  必要十分版のものと定義により一致する（`rfl`）。
- j が準同型であることは、等長写像が誘導する準同型の導出版（`InducedHomomorphismFromNecSuf.lean`）を θ := in'_1 に当てる。
  j(γ(v)) = γ'(in'_1(v)) は、必要十分版の主張を下の T'・S' で引き戻す。
- g の主張は、具体版の Cl(V',q') と必要十分版のものが別の集合なので、二つの間の互いに逆な準同型
  T' : Cl(V',q') → Cl_N(V',q')・S'（`oddTransport`。V' の点を (v, t) ↦ (v を写した点, t) で写す）を置き、
  具体版の主張の両辺の T' による像が必要十分版の主張の両辺になることを示して（T'(g) = g_N、T'(j(a)) = j_N(T(a))）、
  必要十分版の主張を当て、S' ∘ T' = 恒等写像で戻す。
ℂ から渡す性質は、`complexValuedMapsLaws`（ℂ を自分自身の上の線型空間にする八つの性質）、a + (-a) = 0 の `add_neg_cancel`、
0 + a = a・a · 0 = 0・0 · a = 0・1 · a = a・a · 1 = a・0 + 0 = 0・乗法の交換法則である。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.OddExtension
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.InducedHomomorphismFromNecSuf
import CliffordMatrixIsomorphism.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebraFromNecSuf
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.GeneratorsFromNecSuf
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

/-! ### 具体版の Cl(V',q') と必要十分版の Cl(V',q') の間の準同型 -/

/-- V' の点を必要十分版の V' の点へ写す：(v, t) ↦ (v を写した点, t)。 -/
def oddPointToNecSuf (p : (W × DualSpace D.spaceW) × ℂ) : (W × NecSuf.VectorSpace.DualSpace D.spaceW.toNecSuf) × ℂ :=
  (splitPointToNecSuf D.spaceW p.1, p.2)

/-- V' := V ⊕ ℂ の点を、必要十分版の V' の点へ写す写し方。 -/
def oddTransport : QuadraticSpaceWithBasis.PointTransport D.oddSpace (D.toNecSuf.oddSpace complexCliffordLaws) where
  toPoint := D.oddPointToNecSuf
  ofPoint := fun p => (D.splitPointOfNecSuf p.1, p.2)
  toPoint_isLinearMap := ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  ofPoint_isLinearMap := ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  form_toPoint := fun _ => rfl
  form_ofPoint := fun _ => rfl
  ofPoint_toPoint := fun _ => rfl
  toPoint_ofPoint := fun _ => rfl

/-- T'(j(a)) = j_N(T(a))。二つの準同型 Cl(V,q) → Cl_N(V',q') は γ(V) の上で一致する。 -/
theorem oddToCl_oddInclusionHom (a : D.space.Cl) :
    D.oddTransport.toCl (D.oddInclusionHom a)
      = D.toNecSuf.oddInclusionHom complexCliffordLaws add_neg_cancel (D.splitTransport.toCl a) :=
  eq_of_agree_on_generators_of_necSuf
    (IsComplexAlgebraHomomorphism.comp_of_necSuf D.oddInclusionHom_isHom_of_necSuf D.oddTransport.toCl_isHom)
    (IsComplexAlgebraHomomorphism.comp_of_necSuf D.splitTransport.toCl_isHom
      ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2
        (D.toNecSuf.oddInclusionHom_isHom complexCliffordLaws add_neg_cancel)))
    (Set.range D.space.γ) D.space.γ_generates_of_necSuf
    (fun _ ⟨v, hv⟩ => by
      rw [← hv]
      show D.oddTransport.toCl (D.oddInclusionHom (D.space.γ v))
        = D.toNecSuf.oddInclusionHom complexCliffordLaws add_neg_cancel (D.splitTransport.toCl (D.space.γ v))
      -- j は θ := in'_1 が誘導する準同型 Cl(θ) なので、j(γ(v)) = γ'(in'_1(v)) は誘導される準同型の主張による
      rw [show D.oddInclusionHom (D.space.γ v) = D.oddSpace.γ (D.oddInclusion v) from
          QuadraticSpaceWithBasis.inducedHom_γ_of_necSuf D.space D.oddSpace D.oddInclusion D.oddInclusion_isIsometry v,
        D.oddTransport.toCl_γ, D.splitTransport.toCl_γ]
      exact (D.toNecSuf.oddInclusionHom_γ complexCliffordLaws add_neg_cancel (splitPointToNecSuf D.spaceW v)).symm) a

/-- 本文 `claim_induced_homomorphism_into_odd_extension_after_generator_map` を、必要十分版の主張を T' で引き戻して得たもの
（T'(j(γ(v))) = j_N(γ_N(v を写した点)) に必要十分版の主張を当て、T'(γ'(in'_1(v))) と比べる）。 -/
theorem oddInclusionHom_γ_of_necSuf (v : W × DualSpace D.spaceW) :
    D.oddInclusionHom (D.space.γ v) = D.oddSpace.γ (D.oddInclusion v) := by
  apply D.oddTransport.eq_of_toCl_eq
  rw [D.oddToCl_oddInclusionHom, D.splitTransport.toCl_γ, D.oddTransport.toCl_γ]
  exact D.toNecSuf.oddInclusionHom_γ complexCliffordLaws add_neg_cancel (splitPointToNecSuf D.spaceW v)

/-- T'(g) = g_N。 -/
theorem oddToCl_addedGenerator :
    D.oddTransport.toCl D.addedGenerator = D.toNecSuf.addedGenerator complexCliffordLaws :=
  D.oddTransport.toCl_γ D.addedUnitVector

/-- 本文 `claim_square_of_added_generator_is_one` を、必要十分版の主張を T' で引き戻して得たもの。 -/
theorem addedGenerator_mul_self_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator D.addedGenerator = D.oddSpace.cliffordAlgebra.one := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_mul, hT.map_one, D.oddToCl_addedGenerator]
  exact D.toNecSuf.addedGenerator_mul_self complexCliffordLaws add_neg_cancel

/-- 本文 `claim_added_generator_anticommutes_with_image_of_split_space` を、必要十分版の主張を T' で引き戻して得たもの。 -/
theorem addedGenerator_anticommute_of_necSuf (v : W × DualSpace D.spaceW) :
    D.oddSpace.cliffordAlgebra.add
        (D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom (D.space.γ v)))
        (D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.space.γ v)) D.addedGenerator)
      = D.oddSpace.cliffordAlgebra.zero := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_add, hT.map_mul, hT.map_mul,
    show D.oddTransport.toCl D.oddSpace.cliffordAlgebra.zero
      = (QuadraticSpaceWithBasis.algebraOfNecSuf (D.toNecSuf.oddSpace complexCliffordLaws)).zero
      from hT.isLinearMap.map_zero, D.oddToCl_addedGenerator,
    D.oddToCl_oddInclusionHom, D.splitTransport.toCl_γ]
  exact D.toNecSuf.addedGenerator_anticommute complexCliffordLaws add_neg_cancel (splitPointToNecSuf D.spaceW v)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
