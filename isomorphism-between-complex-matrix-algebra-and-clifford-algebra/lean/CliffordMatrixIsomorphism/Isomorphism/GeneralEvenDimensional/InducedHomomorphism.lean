/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」のうち、基底の座標を係数にした族の線型結合の写像と、
等長写像が誘導するクリフォード代数の準同型の具体版。人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                   このファイル
  claim_rearranging_sum_of_two_sums_in_vector_space                              rearrange_sum_of_two_sums
  def_map_by_coordinates_and_family                                              mapByCoordinates（L_{b,u}）
  claim_map_by_coordinates_and_family_is_linear_map                              mapByCoordinates_isLinearMap
  claim_map_by_coordinates_and_family_sends_basis_member_to_family_member        mapByCoordinates_basis
  claim_linear_map_fixing_basis_members_is_identity                              linearMap_eq_self_of_fixes_basis
  claim_linear_right_inverse_of_isometry_is_isometry                             isIsometry_of_linear_rightInverse
  claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry
                                                                                 QuadraticSpaceWithBasis.existsUnique_inducedHom
  def_homomorphism_of_clifford_algebras_induced_by_isometry                      QuadraticSpaceWithBasis.inducedHom（Cl(θ)）・
                                                                                 inducedHom_isHom・inducedHom_γ
  claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity          QuadraticSpaceWithBasis.inducedHom_comp_inducedHom

番号付けた族 b・u は `ℕ → V`・`ℕ → U` で表し、1,…,n の外の値は使わない。座標の写像 β^b_k は `coordinate`、
その族 β^b は `coordinateFamily` である（節「ℂ-線型空間」）。本文の前提 n ∈ ℤ_{≥1} は、どの証明も使わない
（n = 0 でも同じ証明が通る）ので、仮定に置かない。
二つの二次空間 (V, q)・(V', q') は、章「クリフォード代数」の前提の組 `QuadraticSpaceWithBasis` で受ける
（Cl(V,q) は基底 b で、Cl(V',q') は基底 b' で構成したもの）。等長写像 θ の仮定は `IsIsometry Q.space Q'.space Q.form Q'.form θ`。
Cl(θ) は存在と一意性の主張のただ一つの準同型を `Classical.choose` で取り出したものである。

必要十分版は `NecSuf/Isomorphism/GeneralEvenDimensional/InducedHomomorphism.lean`、
導出版は `InducedHomomorphismFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebra
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.AssociativityOfTensorProduct
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.Homomorphisms

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v w

variable {V : Type u} {U : Type v}

/-- 本文 `claim_rearranging_sum_of_two_sums_in_vector_space`：
(x_1 +_V x_2) +_V (y_1 +_V y_2) = (x_1 +_V y_1) +_V (x_2 +_V y_2)。 -/
theorem rearrange_sum_of_two_sums (S : ComplexVectorSpace V) (x₁ x₂ y₁ y₂ : V) :
    S.add (S.add x₁ x₂) (S.add y₁ y₂) = S.add (S.add x₁ y₁) (S.add x₂ y₂) := calc
  S.add (S.add x₁ x₂) (S.add y₁ y₂)
      = S.add x₁ (S.add x₂ (S.add y₁ y₂)) := by rw [S.add_assoc x₁ x₂ (S.add y₁ y₂)]
  _ = S.add x₁ (S.add (S.add x₂ y₁) y₂) := by rw [S.add_assoc x₂ y₁ y₂]
  _ = S.add x₁ (S.add (S.add y₁ x₂) y₂) := by rw [S.add_comm x₂ y₁]
  _ = S.add x₁ (S.add y₁ (S.add x₂ y₂)) := by rw [S.add_assoc y₁ x₂ y₂]
  _ = S.add (S.add x₁ y₁) (S.add x₂ y₂) := by rw [S.add_assoc x₁ y₁ (S.add x₂ y₂)]

/-- 本文 `def_map_by_coordinates_and_family`：L_{b,u}(x) := Σ_{k=1}^{n} β^b_k(x) ·_U u_k。 -/
noncomputable def mapByCoordinates (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (u : ℕ → U) (x : V) : U :=
  linearCombination SU n (fun k => coordinate SV n b hb k x) u

/-- 本文 `claim_map_by_coordinates_and_family_is_linear_map`：L_{b,u} は V から U への線型写像である。 -/
theorem mapByCoordinates_isLinearMap (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily SV n b) (u : ℕ → U) :
    IsComplexLinearMap SV SU (mapByCoordinates SV SU n b hb u) where
  map_add x y := calc
    mapByCoordinates SV SU n b hb u (SV.add x y)
        = linearCombination SU n (fun k => coordinate SV n b hb k (SV.add x y)) u := rfl
    _ = linearCombination SU n (fun k => coordinate SV n b hb k x + coordinate SV n b hb k y) u :=
        linearCombination_eq_of_terms_eq SU n u u _ _ fun k hk1 hkn => by
          rw [(coordinate_isLinearForm SV n b hb k hk1 hkn).map_add x y]
    _ = SU.add (linearCombination SU n (fun k => coordinate SV n b hb k x) u)
          (linearCombination SU n (fun k => coordinate SV n b hb k y) u) :=
        (linearCombination_add_of_same_family SU n u _ _).symm
    _ = SU.add (mapByCoordinates SV SU n b hb u x) (mapByCoordinates SV SU n b hb u y) := rfl
  map_smul l x := calc
    mapByCoordinates SV SU n b hb u (SV.smul l x)
        = linearCombination SU n (fun k => coordinate SV n b hb k (SV.smul l x)) u := rfl
    _ = linearCombination SU n (fun k => l * coordinate SV n b hb k x) u :=
        linearCombination_eq_of_terms_eq SU n u u _ _ fun k hk1 hkn => by
          rw [(coordinate_isLinearForm SV n b hb k hk1 hkn).map_smul l x]
    _ = SU.smul l (linearCombination SU n (fun k => coordinate SV n b hb k x) u) :=
        (smul_linearCombination SU n u _ l).symm
    _ = SU.smul l (mapByCoordinates SV SU n b hb u x) := rfl

/-- 本文 `claim_map_by_coordinates_and_family_sends_basis_member_to_family_member`：L_{b,u}(b_j) = u_j（1 ≤ j ≤ n）。
β^b は b の双対基底なので（`claim_coordinate_maps_form_dual_basis`）、各 k で β^b_k(b_j) = δ_{k,j}（`def_dual_basis`）。 -/
theorem mapByCoordinates_basis (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (u : ℕ → U) (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) :
    mapByCoordinates SV SU n b hb u (b j) = u j := by
  have hδ : ∀ k : ℕ, 1 ≤ k → k ≤ n → coordinate SV n b hb k (b j) = kroneckerDelta k j := by
    intro k hk1 hkn
    have h := coordinateFamily_isDualBasis SV n b hb k j hk1 hkn hj1 hjn
    rw [coordinateFamily, dif_pos ⟨hk1, hkn⟩] at h
    exact h
  calc mapByCoordinates SV SU n b hb u (b j)
      = linearCombination SU n (fun k => coordinate SV n b hb k (b j)) u := rfl
    _ = linearCombination SU n (fun k => kroneckerDelta k j) u :=
        linearCombination_eq_of_terms_eq SU n u u _ _ fun k hk1 hkn => by rw [hδ k hk1 hkn]
    _ = u j := linearCombination_kroneckerDelta SU n u j hj1 hjn

/-- 本文 `claim_linear_map_fixing_basis_members_is_identity`：線型写像 F : V → V がすべての k で F(b_k) = b_k なら、
すべての x で F(x) = x。 -/
theorem linearMap_eq_self_of_fixes_basis (SV : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (F : V → V) (hF : IsComplexLinearMap SV SV F)
    (hfix : ∀ k : ℕ, 1 ≤ k → k ≤ n → F (b k) = b k) (x : V) : F x = x := calc
  F x = F (linearCombination SV n (fun k => coordinate SV n b hb k x) b) := by
        rw [linearCombination_coordinate SV n b hb x]
  _ = linearCombination SV n (fun k => coordinate SV n b hb k x) (fun k => F (b k)) :=
        hF.map_linearCombination n _ b
  _ = linearCombination SV n (fun k => coordinate SV n b hb k x) b :=
        linearCombination_eq_of_terms_eq SV n _ b _ _ fun k hk1 hkn => by rw [hfix k hk1 hkn]
  _ = x := linearCombination_coordinate SV n b hb x

/-- 本文 `claim_linear_right_inverse_of_isometry_is_isometry`：θ : (V,q) → (V',q') が等長写像、θ' : V' → V が線型写像で
すべての y で θ(θ'(y)) = y なら、θ' は (V',q') から (V,q) への等長写像である。 -/
theorem isIsometry_of_linear_rightInverse {V' : Type w} (S : ComplexVectorSpace V) (S' : ComplexVectorSpace V')
    (q : V → ℂ) (q' : V' → ℂ) (θ : V → V') (θ' : V' → V) (hθ : IsIsometry S S' q q' θ)
    (hθ' : IsComplexLinearMap S' S θ') (hright : ∀ y : V', θ (θ' y) = y) :
    IsIsometry S' S q' q θ' where
  isQuadraticForm := hθ.isQuadraticForm'
  isQuadraticForm' := hθ.isQuadraticForm
  isLinearMap := hθ'
  map_form y := calc
    q (θ' y) = q' (θ (θ' y)) := (hθ.map_form (θ' y)).symm
    _ = q' y := by rw [hright y]

end CliffordMatrixIsomorphism.ComplexVectorSpace

namespace CliffordMatrixIsomorphism.Clifford.QuadraticSpaceWithBasis

open ComplexVectorSpace ComplexAlgebra

universe u u'

noncomputable section

variable {V : Type u} {V' : Type u'}

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry`：
θ : (V,q) → (V',q') が等長写像なら、Θ ∘ γ = γ' ∘ θ を満たす Cl(V,q) から Cl(V',q') への ℂ-代数の準同型 Θ がただ一つ存在する。
クリフォード代数の普遍性を A := Cl(V',q')、g := γ' ∘ θ に当てる。 -/
theorem existsUnique_inducedHom (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V') (θ : V → V')
    (hθ : IsIsometry Q.space Q'.space Q.form Q'.form θ) :
    ∃ Θ : Q.Cl → Q'.Cl,
      (IsComplexAlgebraHomomorphism Q.cliffordAlgebra Q'.cliffordAlgebra Θ ∧ ∀ v : V, Θ (Q.γ v) = Q'.γ (θ v)) ∧
      ∀ Θ' : Q.Cl → Q'.Cl,
        (IsComplexAlgebraHomomorphism Q.cliffordAlgebra Q'.cliffordAlgebra Θ' ∧ ∀ v : V, Θ' (Q.γ v) = Q'.γ (θ v)) →
          Θ' = Θ := by
  let A := Q'.cliffordAlgebra
  -- g := γ' ∘ θ
  let g : V → Q'.Cl := fun v => Q'.γ (θ v)
  -- θ は線型写像、γ' は V' から U_vec(A) への線型写像なので、g は線型写像（`claim_composition_of_linear_maps_is_linear_map`）
  have hg : IsComplexLinearMap Q.space (underlyingVectorSpace A) g :=
    IsComplexLinearMap.comp (g := Q'.γ) hθ.isLinearMap Q'.γ_isLinearMap
  have hsq : ∀ v : V, A.mul (g v) (g v) = A.smul (Q.form v) A.one := fun v => calc
    A.mul (g v) (g v) = A.mul (Q'.γ (θ v)) (Q'.γ (θ v)) := rfl
    _ = A.smul (Q'.form (θ v)) A.one := Q'.γ_mul_self (θ v)
    _ = A.smul (Q.form v) A.one := by rw [hθ.map_form v]
  exact Q.universalProperty A g hg hsq

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry`：Θ ∘ γ = γ' ∘ θ を満たすただ一つの ℂ-代数の準同型
Cl(θ) : Cl(V,q) → Cl(V',q')。 -/
def inducedHom (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V') (θ : V → V')
    (hθ : IsIsometry Q.space Q'.space Q.form Q'.form θ) : Q.Cl → Q'.Cl :=
  Classical.choose (existsUnique_inducedHom Q Q' θ hθ)

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry`：Cl(θ) は ℂ-代数の準同型である。 -/
theorem inducedHom_isHom (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V') (θ : V → V')
    (hθ : IsIsometry Q.space Q'.space Q.form Q'.form θ) :
    IsComplexAlgebraHomomorphism Q.cliffordAlgebra Q'.cliffordAlgebra (inducedHom Q Q' θ hθ) :=
  (Classical.choose_spec (existsUnique_inducedHom Q Q' θ hθ)).1.1

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry`：Cl(θ) ∘ γ = γ' ∘ θ。 -/
theorem inducedHom_γ (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V') (θ : V → V')
    (hθ : IsIsometry Q.space Q'.space Q.form Q'.form θ) (v : V) :
    inducedHom Q Q' θ hθ (Q.γ v) = Q'.γ (θ v) :=
  (Classical.choose_spec (existsUnique_inducedHom Q Q' θ hθ)).1.2 v

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry`：Cl(θ) は、Θ ∘ γ = γ' ∘ θ を満たす準同型のどれとも等しい
（存在と一意性の主張の一意性）。 -/
theorem inducedHom_unique (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V') (θ : V → V')
    (hθ : IsIsometry Q.space Q'.space Q.form Q'.form θ) (Θ' : Q.Cl → Q'.Cl)
    (hΘ' : IsComplexAlgebraHomomorphism Q.cliffordAlgebra Q'.cliffordAlgebra Θ')
    (hΘ'γ : ∀ v : V, Θ' (Q.γ v) = Q'.γ (θ v)) : Θ' = inducedHom Q Q' θ hθ :=
  (Classical.choose_spec (existsUnique_inducedHom Q Q' θ hθ)).2 Θ' ⟨hΘ', hΘ'γ⟩

/-- 本文 `claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity`：σ : (V,q) → (V',q')、τ : (V',q') → (V,q) が
等長写像で、すべての x で τ(σ(x)) = x なら、すべての a ∈ Cl(V,q) で Cl(τ)(Cl(σ)(a)) = a。
Ξ := Cl(τ) ∘ Cl(σ) と id_A が γ の上で一致することを示し、普遍性の一意性（A := Cl(V,q)、線型写像 γ）で Ξ = id_A を得る。 -/
theorem inducedHom_comp_inducedHom (Q : QuadraticSpaceWithBasis V) (Q' : QuadraticSpaceWithBasis V')
    (σ : V → V') (hσ : IsIsometry Q.space Q'.space Q.form Q'.form σ)
    (τ : V' → V) (hτ : IsIsometry Q'.space Q.space Q'.form Q.form τ) (hτσ : ∀ x : V, τ (σ x) = x)
    (a : Q.Cl) : inducedHom Q' Q τ hτ (inducedHom Q Q' σ hσ a) = a := by
  let A := Q.cliffordAlgebra
  let Ξ : Q.Cl → Q.Cl := fun x => inducedHom Q' Q τ hτ (inducedHom Q Q' σ hσ x)
  have hΞ : IsComplexAlgebraHomomorphism A A Ξ :=
    IsComplexAlgebraHomomorphism.comp (inducedHom_isHom Q Q' σ hσ) (inducedHom_isHom Q' Q τ hτ)
  have hid : IsComplexAlgebraHomomorphism A A (fun x => x) := isComplexAlgebraHomomorphism_id A
  have hΞγ : ∀ v : V, Ξ (Q.γ v) = Q.γ v := fun v => calc
    Ξ (Q.γ v) = inducedHom Q' Q τ hτ (inducedHom Q Q' σ hσ (Q.γ v)) := rfl
    _ = inducedHom Q' Q τ hτ (Q'.γ (σ v)) := by rw [inducedHom_γ Q Q' σ hσ v]
    _ = Q.γ (τ (σ v)) := inducedHom_γ Q' Q τ hτ (σ v)
    _ = Q.γ v := by rw [hτσ v]
    _ = (fun x => x) (Q.γ v) := rfl
  -- 普遍性：Υ ∘ γ = γ を満たす準同型 Υ : A → A はただ一つ
  obtain ⟨Υ, _, huniq⟩ := Q.universalProperty A Q.γ Q.γ_isLinearMap Q.γ_mul_self
  have hΞΥ : Ξ = Υ := huniq Ξ ⟨hΞ, hΞγ⟩
  have hidΥ : (fun x => x) = Υ := huniq (fun x => x) ⟨hid, fun _ => rfl⟩
  calc inducedHom Q' Q τ hτ (inducedHom Q Q' σ hσ a) = Ξ a := rfl
    _ = Υ a := by rw [hΞΥ]
    _ = (fun x => x) a := by rw [hidΥ]
    _ = a := rfl

end

end CliffordMatrixIsomorphism.Clifford.QuadraticSpaceWithBasis
