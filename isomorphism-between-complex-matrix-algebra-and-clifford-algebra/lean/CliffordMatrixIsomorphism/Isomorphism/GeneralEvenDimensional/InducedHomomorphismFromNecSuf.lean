/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」のうち、基底の座標を係数にした族の線型結合の写像と、
等長写像が誘導するクリフォード代数の準同型の具体版が、必要十分版の K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。
具体版のファイルは必要十分版を引かない。このファイルだけが両方を引く。

  具体版                                     必要十分版の特殊化
  rearrange_sum_of_two_sums                  rearrange_sum_of_two_sums_of_necSuf
  mapByCoordinates                           mapByCoordinates_eq_necSuf（座標の写像は 1,…,n の番号で `coordinate_eq_necSuf` により一致する）
  mapByCoordinates_isLinearMap               mapByCoordinates_isLinearMap_of_necSuf
  mapByCoordinates_basis                     mapByCoordinates_basis_of_necSuf
  linearMap_eq_self_of_fixes_basis           linearMap_eq_self_of_fixes_basis_of_necSuf
  isIsometry_of_linear_rightInverse          isIsometry_of_linear_rightInverse_of_necSuf
  existsUnique_inducedHom                    existsUnique_inducedHom_of_necSuf
  inducedHom_isHom・inducedHom_γ             inducedHom_isHom_of_necSuf・inducedHom_γ_of_necSuf
  inducedHom_comp_inducedHom                 inducedHom_comp_inducedHom_of_necSuf

ℂ から渡す性質は、係数の一意性の仮定の組 `complexUniquenessLaws`、0 + 0 = 0 の `add_zero 0`、
章「クリフォード代数」の仮定の組 `complexCliffordLaws`、a + (-a) = 0 の `add_neg_cancel` である。

クリフォード代数の主張は、`CliffordAlgebraFromNecSuf.lean` と同じ運び方をする。具体版の Cl(V,q) = T(V)/I_q と、
具体版の前提を写した必要十分版の前提 `Q.toNecSuf` の Cl は、T(V)・I_q が命題として等しいだけなので別の式である。
そこで必要十分版の主張を、二つの空間それぞれの T(V) の構造 S・埋め込み ι・両側イデアル I を変数にした形 `key` に書き直し
（変数を必要十分版のものに置けば必要十分版の主張そのもの）、変数に具体版の T(V)・ι・I_q を入れる。
具体版の Cl(V,q) の演算は、この形の商代数の演算と定義により一致する。

逆向きの等長写像の主張では、具体版の Cl(σ)・Cl(τ) と必要十分版の Cl(σ)・Cl(τ) は別々に `Classical.choose` で選ぶので、
`key` は Cl(σ)・Cl(τ) も変数にし、準同型であることと Cl(σ) ∘ γ = γ' ∘ σ を満たす任意の写像についての形に書く。
変数を必要十分版の空間に置いた後は、必要十分版の一意性（`inducedHom_unique`）で変数の写像が必要十分版の Cl(σ)・Cl(τ) に等しいので、
必要十分版の主張がそのまま当たる。
-/
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.InducedHomomorphism
import CliffordMatrixIsomorphism.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebraFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.QuadraticForm.QuadraticFormFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.ComplexAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.InducedHomomorphism

-- 添字の再帰的な定義（2^M・個数 N_i(T)・整数の番号順の和など）は具体版と必要十分版に同じ式で別に置いてあり、
-- 変数での値は再帰の展開でしか一致しないので、このファイルでは smartUnfolding を切って定義どおりに展開させる。
set_option smartUnfolding false

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v w

variable {V : Type u} {U : Type v}

/-- 本文 `claim_rearranging_sum_of_two_sums_in_vector_space` を、必要十分版から得たもの。 -/
theorem rearrange_sum_of_two_sums_of_necSuf (S : ComplexVectorSpace V) (x₁ x₂ y₁ y₂ : V) :
    S.add (S.add x₁ x₂) (S.add y₁ y₂) = S.add (S.add x₁ y₁) (S.add x₂ y₂) :=
  NecSuf.VectorSpace.rearrange_sum_of_two_sums S.toNecSuf x₁ x₂ y₁ y₂

/-- 具体版の L_{b,u} は、必要十分版の L_{b,u} と同じ（座標の写像は 1,…,n の番号で一致する）。 -/
theorem mapByCoordinates_eq_necSuf (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (u : ℕ → U) (x : V) :
    mapByCoordinates SV SU n b hb u x
      = NecSuf.VectorSpace.mapByCoordinates SV.toNecSuf SU.toNecSuf n b ((isBasisFamily_iff_necSuf SV n b).1 hb) u x := by
  unfold mapByCoordinates NecSuf.VectorSpace.mapByCoordinates
  rw [linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_eq_of_terms_eq _ n _ _ _ _ fun k hk1 hkn => by
    rw [coordinate_eq_necSuf SV n b hb k hk1 hkn x]

/-- 本文 `claim_map_by_coordinates_and_family_is_linear_map` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapByCoordinates_isLinearMap_of_necSuf (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily SV n b) (u : ℕ → U) :
    IsComplexLinearMap SV SU (mapByCoordinates SV SU n b hb u) := by
  rw [isComplexLinearMap_iff_necSuf]
  have heq : mapByCoordinates SV SU n b hb u
      = NecSuf.VectorSpace.mapByCoordinates SV.toNecSuf SU.toNecSuf n b ((isBasisFamily_iff_necSuf SV n b).1 hb) u :=
    funext (mapByCoordinates_eq_necSuf SV SU n b hb u)
  rw [heq]
  exact NecSuf.VectorSpace.mapByCoordinates_isLinearMap complexUniquenessLaws SV.toNecSuf SU.toNecSuf n b _ u

/-- 本文 `claim_map_by_coordinates_and_family_sends_basis_member_to_family_member` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapByCoordinates_basis_of_necSuf (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily SV n b) (u : ℕ → U) (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) :
    mapByCoordinates SV SU n b hb u (b j) = u j := by
  rw [mapByCoordinates_eq_necSuf]
  exact NecSuf.VectorSpace.mapByCoordinates_basis complexUniquenessLaws SV.toNecSuf SU.toNecSuf n b _ u j hj1 hjn

/-- 本文 `claim_linear_map_fixing_basis_members_is_identity` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem linearMap_eq_self_of_fixes_basis_of_necSuf (SV : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (F : V → V) (hF : IsComplexLinearMap SV SV F)
    (hfix : ∀ k : ℕ, 1 ≤ k → k ≤ n → F (b k) = b k) (x : V) : F x = x :=
  NecSuf.VectorSpace.linearMap_eq_self_of_fixes_basis SV.toNecSuf (_root_.add_zero 0) n b
    ((isBasisFamily_iff_necSuf SV n b).1 hb).spans F ((isComplexLinearMap_iff_necSuf SV SV F).1 hF) hfix x

/-- 本文 `claim_linear_right_inverse_of_isometry_is_isometry` を、必要十分版から得たもの。 -/
theorem isIsometry_of_linear_rightInverse_of_necSuf {V' : Type w} (S : ComplexVectorSpace V)
    (S' : ComplexVectorSpace V') (q : V → ℂ) (q' : V' → ℂ) (θ : V → V') (θ' : V' → V) (hθ : IsIsometry S S' q q' θ)
    (hθ' : IsComplexLinearMap S' S θ') (hright : ∀ y : V', θ (θ' y) = y) :
    IsIsometry S' S q' q θ' :=
  (isIsometry_iff_necSuf S' S q' q θ').2
    (NecSuf.VectorSpace.isIsometry_of_linear_rightInverse S.toNecSuf S'.toNecSuf q q' θ θ'
      ((isIsometry_iff_necSuf S S' q q' θ).1 hθ).isQuadraticForm ((isIsometry_iff_necSuf S S' q q' θ).1 hθ).isQuadraticForm'
      ((isIsometry_iff_necSuf S S' q q' θ).1 hθ).map_form ((isComplexLinearMap_iff_necSuf S' S θ').1 hθ') hright)

end CliffordMatrixIsomorphism.ComplexVectorSpace

namespace CliffordMatrixIsomorphism.Clifford.QuadraticSpaceWithBasis

open ComplexVectorSpace ComplexAlgebra

universe u u'

noncomputable section

variable {V : Type u} {V' : Type u'}

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry` を、
必要十分版に ℂ の性質を渡して得たもの。 -/
theorem existsUnique_inducedHom_of_necSuf (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V')
    (θ : V → V') (hθ : IsIsometry Q.space Q'.space Q.form Q'.form θ) :
    ∃ Θ : Q.Cl → Q'.Cl,
      (IsComplexAlgebraHomomorphism Q.cliffordAlgebra Q'.cliffordAlgebra Θ ∧ ∀ v : V, Θ (Q.γ v) = Q'.γ (θ v)) ∧
      ∀ Θ' : Q.Cl → Q'.Cl,
        (IsComplexAlgebraHomomorphism Q.cliffordAlgebra Q'.cliffordAlgebra Θ' ∧ ∀ v : V, Θ' (Q.γ v) = Q'.γ (θ v)) →
          Θ' = Θ := by
  have hlin := (isComplexLinearMap_iff_necSuf Q.space Q'.space θ).1 hθ.isLinearMap
  have key : ∀ (S : NecSuf.AlgebraOver ℂ Q.TV) (ι : V → Q.TV) (I : Set Q.TV)
      (S' : NecSuf.AlgebraOver ℂ Q'.TV) (ι' : V' → Q'.TV) (I' : Set Q'.TV),
      S = Q.toNecSuf.TA complexCliffordLaws → ι = Q.toNecSuf.ι complexCliffordLaws →
      I = Q.toNecSuf.ideal complexCliffordLaws →
      S' = Q'.toNecSuf.TA complexCliffordLaws → ι' = Q'.toNecSuf.ι complexCliffordLaws →
      I' = Q'.toNecSuf.ideal complexCliffordLaws →
      ∀ (hI : NecSuf.AlgebraOver.IsTwoSidedIdeal S I) (hI' : NecSuf.AlgebraOver.IsTwoSidedIdeal S' I'),
      ∃ Θ : NecSuf.AlgebraOver.QuotientSet S (-1) I → NecSuf.AlgebraOver.QuotientSet S' (-1) I',
        (NecSuf.AlgebraOver.IsAlgebraHomomorphism
            (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm)
            (NecSuf.AlgebraOver.quotientAlgebra hI' complexCongruenceLaws complexNegOneComm) Θ ∧
          ∀ v : V, Θ (NecSuf.AlgebraOver.projection S (-1) I (ι v))
            = NecSuf.AlgebraOver.projection S' (-1) I' (ι' (θ v))) ∧
        ∀ Θ' : NecSuf.AlgebraOver.QuotientSet S (-1) I → NecSuf.AlgebraOver.QuotientSet S' (-1) I',
          (NecSuf.AlgebraOver.IsAlgebraHomomorphism
              (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm)
              (NecSuf.AlgebraOver.quotientAlgebra hI' complexCongruenceLaws complexNegOneComm) Θ' ∧
            ∀ v : V, Θ' (NecSuf.AlgebraOver.projection S (-1) I (ι v))
              = NecSuf.AlgebraOver.projection S' (-1) I' (ι' (θ v))) → Θ' = Θ := by
    rintro _ _ _ _ _ _ rfl rfl rfl rfl rfl rfl _ _
    exact NecSuf.Clifford.QuadraticSpaceWithBasis.existsUnique_inducedHom complexCliffordLaws add_neg_cancel
      Q.toNecSuf Q'.toNecSuf θ hlin hθ.map_form
  obtain ⟨Θ, ⟨hΘ, hΘγ⟩, huniq⟩ :=
    key _ _ _ _ _ _ Q.TA_toNecSuf Q.ι_eq_necSuf Q.ideal_eq_necSuf Q'.TA_toNecSuf Q'.ι_eq_necSuf Q'.ideal_eq_necSuf
      Q.ideal_isTwoSidedIdeal_toNecSuf Q'.ideal_isTwoSidedIdeal_toNecSuf
  exact ⟨Θ, ⟨(isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2 hΘ, hΘγ⟩,
    fun Θ' hΘ' => huniq Θ' ⟨(isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 hΘ'.1, hΘ'.2⟩⟩

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry` の「Cl(θ) は ℂ-代数の準同型」を必要十分版から得る。 -/
theorem inducedHom_isHom_of_necSuf (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V') (θ : V → V')
    (hθ : IsIsometry Q.space Q'.space Q.form Q'.form θ) :
    IsComplexAlgebraHomomorphism Q.cliffordAlgebra Q'.cliffordAlgebra (inducedHom Q Q' θ hθ) :=
  (Classical.choose_spec (existsUnique_inducedHom_of_necSuf Q Q' θ hθ)).1.1

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry` の Cl(θ) ∘ γ = γ' ∘ θ を必要十分版から得る。 -/
theorem inducedHom_γ_of_necSuf (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V') (θ : V → V')
    (hθ : IsIsometry Q.space Q'.space Q.form Q'.form θ) (v : V) :
    inducedHom Q Q' θ hθ (Q.γ v) = Q'.γ (θ v) :=
  (Classical.choose_spec (existsUnique_inducedHom_of_necSuf Q Q' θ hθ)).1.2 v

/-- 本文 `claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem inducedHom_comp_inducedHom_of_necSuf (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V')
    (σ : V → V') (hσ : IsIsometry Q.space Q'.space Q.form Q'.form σ)
    (τ : V' → V) (hτ : IsIsometry Q'.space Q.space Q'.form Q.form τ) (hτσ : ∀ x : V, τ (σ x) = x)
    (a : Q.Cl) : inducedHom Q' Q τ hτ (inducedHom Q Q' σ hσ a) = a := by
  have hσlin := (isComplexLinearMap_iff_necSuf Q.space Q'.space σ).1 hσ.isLinearMap
  have hτlin := (isComplexLinearMap_iff_necSuf Q'.space Q.space τ).1 hτ.isLinearMap
  have key : ∀ (S : NecSuf.AlgebraOver ℂ Q.TV) (ι : V → Q.TV) (I : Set Q.TV)
      (S' : NecSuf.AlgebraOver ℂ Q'.TV) (ι' : V' → Q'.TV) (I' : Set Q'.TV),
      S = Q.toNecSuf.TA complexCliffordLaws → ι = Q.toNecSuf.ι complexCliffordLaws →
      I = Q.toNecSuf.ideal complexCliffordLaws →
      S' = Q'.toNecSuf.TA complexCliffordLaws → ι' = Q'.toNecSuf.ι complexCliffordLaws →
      I' = Q'.toNecSuf.ideal complexCliffordLaws →
      ∀ (hI : NecSuf.AlgebraOver.IsTwoSidedIdeal S I) (hI' : NecSuf.AlgebraOver.IsTwoSidedIdeal S' I')
        (Θσ : NecSuf.AlgebraOver.QuotientSet S (-1) I → NecSuf.AlgebraOver.QuotientSet S' (-1) I')
        (Θτ : NecSuf.AlgebraOver.QuotientSet S' (-1) I' → NecSuf.AlgebraOver.QuotientSet S (-1) I),
        NecSuf.AlgebraOver.IsAlgebraHomomorphism
            (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm)
            (NecSuf.AlgebraOver.quotientAlgebra hI' complexCongruenceLaws complexNegOneComm) Θσ →
        (∀ v : V, Θσ (NecSuf.AlgebraOver.projection S (-1) I (ι v))
          = NecSuf.AlgebraOver.projection S' (-1) I' (ι' (σ v))) →
        NecSuf.AlgebraOver.IsAlgebraHomomorphism
            (NecSuf.AlgebraOver.quotientAlgebra hI' complexCongruenceLaws complexNegOneComm)
            (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm) Θτ →
        (∀ v' : V', Θτ (NecSuf.AlgebraOver.projection S' (-1) I' (ι' v'))
          = NecSuf.AlgebraOver.projection S (-1) I (ι (τ v'))) →
        ∀ x : NecSuf.AlgebraOver.QuotientSet S (-1) I, Θτ (Θσ x) = x := by
    rintro _ _ _ _ _ _ rfl rfl rfl rfl rfl rfl _ _ Θσ Θτ hΘσ hΘσγ hΘτ hΘτγ x
    have hσeq := NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom_unique complexCliffordLaws add_neg_cancel
      Q.toNecSuf Q'.toNecSuf σ hσlin hσ.map_form Θσ hΘσ hΘσγ
    have hτeq := NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom_unique complexCliffordLaws add_neg_cancel
      Q'.toNecSuf Q.toNecSuf τ hτlin hτ.map_form Θτ hΘτ hΘτγ
    rw [hσeq, hτeq]
    exact NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom_comp_inducedHom complexCliffordLaws add_neg_cancel
      Q.toNecSuf Q'.toNecSuf σ hσlin hσ.map_form τ hτlin hτ.map_form hτσ x
  exact key _ _ _ _ _ _ Q.TA_toNecSuf Q.ι_eq_necSuf Q.ideal_eq_necSuf Q'.TA_toNecSuf Q'.ι_eq_necSuf
    Q'.ideal_eq_necSuf Q.ideal_isTwoSidedIdeal_toNecSuf Q'.ideal_isTwoSidedIdeal_toNecSuf
    (inducedHom Q Q' σ hσ) (inducedHom Q' Q τ hτ)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 (inducedHom_isHom_of_necSuf Q Q' σ hσ))
    (inducedHom_γ_of_necSuf Q Q' σ hσ)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 (inducedHom_isHom_of_necSuf Q' Q τ hτ))
    (inducedHom_γ_of_necSuf Q' Q τ hτ) a

end

end CliffordMatrixIsomorphism.Clifford.QuadraticSpaceWithBasis
