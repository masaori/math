/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」のうち、基底の座標を係数にした族の線型結合の写像と、
等長写像が誘導するクリフォード代数の準同型の必要十分版。具体版
`Isomorphism/GeneralEvenDimensional/InducedHomomorphism.lean` と同じ def・calc の行を、係数 ℂ を型の変数 K に替えて書く。

主張ごとに使う K の性質:

  rearrange_sum_of_two_sums             なし（V の加法の結合法則・交換法則だけ）
  mapByCoordinates                      なし（座標の写像は、張ることから係数を選ぶだけ）
  mapByCoordinates_isLinearMap          係数の一意性の仮定の組 `UniquenessLaws`（座標の写像が線型形式であること）。
                                        スカラー倍の行の 0 + 0 = 0・a · 0 = 0 もこの組の欄から出る
  mapByCoordinates_basis                `UniquenessLaws`（座標の写像の族が双対基底であること）。
                                        Σ δ_{k,j} ·_U u_k = u_j の行は 0 + 0 = 0 だけを使う
  linearMap_eq_self_of_fixes_basis      0 + 0 = 0 だけ（線型写像が線型結合を移す主張から来る）。座標の写像の一つ目の性質
                                        Σ β^b_k(x) ·_V b_k = x は選び方そのものなので、係数の一意性は使わない
  isIsometry_of_linear_rightInverse     なし
  existsUnique_inducedHom・inducedHom   章「クリフォード代数」の仮定 `CliffordLaws K n` と a + (-a) = 0（`hneg`）。
                                        どちらも γ'(θ(v))² の計算とクリフォード代数の普遍性から来る
  inducedHom_comp_inducedHom            同じ（普遍性と γ(v)² = q(v) ∗ 1）

等長写像の仮定は、具体版の `IsIsometry`（q・q' が二次形式であること、θ が線型、q'(θ(x)) = q(x)）のうち、
θ が線型であること（`hlin`）と q'(θ(x)) = q(x)（`hform`）の二つに分けて置く。普遍性の証明が q・q' について使うのは
γ(v)² = q(v) ∗ 1 と I_q の生成元の形だけで、q・q' が二次形式であることはどの主張も使わない（章「クリフォード代数」の
必要十分版の前提の組 `QuadraticSpaceWithBasis` も「q は二次形式」の欄を持たない）。結論が等長写像である
`isIsometry_of_linear_rightInverse` だけは、結論の q・q' が二次形式である欄を仮定の θ から受け取るので `IsIsometry` で書く。

分かったこと:
  - 線型写像が基底を動かさなければ恒等写像であることは、係数の性質のうち 0 + 0 = 0 しか使わない。
    係数の一意性（一次独立）も使わず、b が張ることだけで足りる。
  - L_{b,u} が線型であること・b_j を u_j へ移すことは、座標の写像についての係数の一意性の仮定の組だけで足り、
    乗法の結合法則・交換法則・左分配法則を使わない。
  - 等長写像が誘導する準同型の存在と一意性、逆向きの等長写像が誘導する準同型の合成が恒等写像であることは、
    章「クリフォード代数」の仮定 `CliffordLaws K n` と a + (-a) = 0 のほかに K の性質を足さない。q・q' が二次形式であることも使わない。
  - 本文の前提 n ∈ ℤ_{≥1} は、どの主張も使わない（n = 0 でも同じ証明が通る）。
-/
import CliffordMatrixIsomorphism.NecSuf.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebra
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.AssociativityOfTensorProduct
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Homomorphisms

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe uK u v w

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {V : Type u} {U : Type v}

omit [Zero K] in
/-- 本文 `claim_rearranging_sum_of_two_sums_in_vector_space` の必要十分版。 -/
theorem rearrange_sum_of_two_sums (S : VectorSpace K V) (x₁ x₂ y₁ y₂ : V) :
    S.add (S.add x₁ x₂) (S.add y₁ y₂) = S.add (S.add x₁ y₁) (S.add x₂ y₂) := calc
  S.add (S.add x₁ x₂) (S.add y₁ y₂)
      = S.add x₁ (S.add x₂ (S.add y₁ y₂)) := by rw [S.add_assoc x₁ x₂ (S.add y₁ y₂)]
  _ = S.add x₁ (S.add (S.add x₂ y₁) y₂) := by rw [S.add_assoc x₂ y₁ y₂]
  _ = S.add x₁ (S.add (S.add y₁ x₂) y₂) := by rw [S.add_comm x₂ y₁]
  _ = S.add x₁ (S.add y₁ (S.add x₂ y₂)) := by rw [S.add_assoc y₁ x₂ y₂]
  _ = S.add (S.add x₁ y₁) (S.add x₂ y₂) := by rw [S.add_assoc x₁ y₁ (S.add x₂ y₂)]

/-- 本文 `def_map_by_coordinates_and_family` の必要十分版：L_{b,u}(x) := Σ_{k=1}^{n} β^b_k(x) ·_U u_k。 -/
noncomputable def mapByCoordinates (SV : VectorSpace K V) (SU : VectorSpace K U) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (u : ℕ → U) (x : V) : U :=
  linearCombination SU n (fun k => coordinate SV n b hb k x) u

/-- 本文 `claim_map_by_coordinates_and_family_is_linear_map` の必要十分版。 -/
theorem mapByCoordinates_isLinearMap (UL : UniquenessLaws K) (SV : VectorSpace K V) (SU : VectorSpace K U) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily SV n b) (u : ℕ → U) :
    IsLinearMap SV SU (mapByCoordinates SV SU n b hb u) where
  map_add x y := calc
    mapByCoordinates SV SU n b hb u (SV.add x y)
        = linearCombination SU n (fun k => coordinate SV n b hb k (SV.add x y)) u := rfl
    _ = linearCombination SU n (fun k => coordinate SV n b hb k x + coordinate SV n b hb k y) u :=
        linearCombination_eq_of_terms_eq SU n u u _ _ fun k hk1 hkn => by
          rw [(coordinate_isLinearForm SV UL n b hb k hk1 hkn).map_add x y]
    _ = SU.add (linearCombination SU n (fun k => coordinate SV n b hb k x) u)
          (linearCombination SU n (fun k => coordinate SV n b hb k y) u) :=
        (linearCombination_add_of_same_family SU n u _ _).symm
    _ = SU.add (mapByCoordinates SV SU n b hb u x) (mapByCoordinates SV SU n b hb u y) := rfl
  map_smul l x := calc
    mapByCoordinates SV SU n b hb u (SV.smul l x)
        = linearCombination SU n (fun k => coordinate SV n b hb k (SV.smul l x)) u := rfl
    _ = linearCombination SU n (fun k => l * coordinate SV n b hb k x) u :=
        linearCombination_eq_of_terms_eq SU n u u _ _ fun k hk1 hkn => by
          rw [(coordinate_isLinearForm SV UL n b hb k hk1 hkn).map_smul l x]
    _ = SU.smul l (linearCombination SU n (fun k => coordinate SV n b hb k x) u) :=
        (smul_linearCombination SU (UL.add_zero 0) UL.mul_zero n u _ l).symm
    _ = SU.smul l (mapByCoordinates SV SU n b hb u x) := rfl

/-- 本文 `claim_map_by_coordinates_and_family_sends_basis_member_to_family_member` の必要十分版。 -/
theorem mapByCoordinates_basis (UL : UniquenessLaws K) (SV : VectorSpace K V) (SU : VectorSpace K U) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily SV n b) (u : ℕ → U) (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) :
    mapByCoordinates SV SU n b hb u (b j) = u j := by
  have hδ : ∀ k : ℕ, 1 ≤ k → k ≤ n → coordinate SV n b hb k (b j) = (kroneckerDelta k j : K) := by
    intro k hk1 hkn
    have h := coordinateFamily_isDualBasis UL SV n b hb k j hk1 hkn hj1 hjn
    rw [coordinateFamily, dif_pos ⟨hk1, hkn⟩] at h
    exact h
  calc mapByCoordinates SV SU n b hb u (b j)
      = linearCombination SU n (fun k => coordinate SV n b hb k (b j)) u := rfl
    _ = linearCombination SU n (fun k => (kroneckerDelta k j : K)) u :=
        linearCombination_eq_of_terms_eq SU n u u _ _ fun k hk1 hkn => by rw [hδ k hk1 hkn]
    _ = u j := linearCombination_kroneckerDelta SU (UL.add_zero 0) n u j hj1 hjn

/-- 本文 `claim_linear_map_fixing_basis_members_is_identity` の必要十分版。K に要るのは 0 + 0 = 0 だけ。 -/
theorem linearMap_eq_self_of_fixes_basis (SV : VectorSpace K V) (h00 : (0 : K) + 0 = 0) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (F : V → V) (hF : IsLinearMap SV SV F)
    (hfix : ∀ k : ℕ, 1 ≤ k → k ≤ n → F (b k) = b k) (x : V) : F x = x := calc
  F x = F (linearCombination SV n (fun k => coordinate SV n b hb k x) b) := by
        rw [linearCombination_coordinate SV n b hb x]
  _ = linearCombination SV n (fun k => coordinate SV n b hb k x) (fun k => F (b k)) :=
        hF.map_linearCombination h00 n _ b
  _ = linearCombination SV n (fun k => coordinate SV n b hb k x) b :=
        linearCombination_eq_of_terms_eq SV n _ b _ _ fun k hk1 hkn => by rw [hfix k hk1 hkn]
  _ = x := linearCombination_coordinate SV n b hb x

omit [Zero K] in
/-- 本文 `claim_linear_right_inverse_of_isometry_is_isometry` の必要十分版。K の性質を使わない。 -/
theorem isIsometry_of_linear_rightInverse [Neg K] {V' : Type w} (S : VectorSpace K V) (S' : VectorSpace K V')
    (q : V → K) (q' : V' → K) (θ : V → V') (θ' : V' → V) (hθ : IsIsometry S S' q q' θ)
    (hθ' : IsLinearMap S' S θ') (hright : ∀ y : V', θ (θ' y) = y) :
    IsIsometry S' S q' q θ' where
  isQuadraticForm := hθ.isQuadraticForm'
  isQuadraticForm' := hθ.isQuadraticForm
  isLinearMap := hθ'
  map_form y := calc
    q (θ' y) = q' (θ (θ' y)) := (hθ.map_form (θ' y)).symm
    _ = q' y := by rw [hright y]

end CliffordMatrixIsomorphism.NecSuf.VectorSpace

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.QuadraticSpaceWithBasis

open VectorSpace AlgebraOver

universe uK u u'

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {V : Type u} {V' : Type u'}

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry` の必要十分版。
等長写像の仮定は、θ が線型であること `hlin` と q'(θ(x)) = q(x)（`hform`）だけを置く。 -/
theorem existsUnique_inducedHom (hneg : ∀ a : K, a + -a = 0)
    (Q : QuadraticSpaceWithBasis K V) (Q' : QuadraticSpaceWithBasis K V') (θ : V → V')
    (hlin : IsLinearMap Q.space Q'.space θ) (hform : ∀ x : V, Q'.form (θ x) = Q.form x) :
    ∃ Θ : Q.Cl C → Q'.Cl C,
      (IsAlgebraHomomorphism (Q.cliffordAlgebra C) (Q'.cliffordAlgebra C) Θ ∧
        ∀ v : V, Θ (Q.γ C v) = Q'.γ C (θ v)) ∧
      ∀ Θ' : Q.Cl C → Q'.Cl C,
        (IsAlgebraHomomorphism (Q.cliffordAlgebra C) (Q'.cliffordAlgebra C) Θ' ∧
          ∀ v : V, Θ' (Q.γ C v) = Q'.γ C (θ v)) → Θ' = Θ := by
  let A := Q'.cliffordAlgebra C
  let g : V → Q'.Cl C := fun v => Q'.γ C (θ v)
  have hg : IsLinearMap Q.space (underlyingVectorSpace A) g :=
    IsLinearMap.comp (g := Q'.γ C) hlin (Q'.γ_isLinearMap C)
  have hsq : ∀ v : V, A.mul (g v) (g v) = A.smul (Q.form v) A.one := fun v => calc
    A.mul (g v) (g v) = A.mul (Q'.γ C (θ v)) (Q'.γ C (θ v)) := rfl
    _ = A.smul (Q'.form (θ v)) A.one := Q'.γ_mul_self C hneg (θ v)
    _ = A.smul (Q.form v) A.one := by rw [hform v]
  exact Q.universalProperty C hneg A g hg hsq

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry` の必要十分版。 -/
def inducedHom (hneg : ∀ a : K, a + -a = 0)
    (Q : QuadraticSpaceWithBasis K V) (Q' : QuadraticSpaceWithBasis K V') (θ : V → V')
    (hlin : IsLinearMap Q.space Q'.space θ) (hform : ∀ x : V, Q'.form (θ x) = Q.form x) : Q.Cl C → Q'.Cl C :=
  Classical.choose (existsUnique_inducedHom C hneg Q Q' θ hlin hform)

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry` の必要十分版：Cl(θ) は K-代数の準同型。 -/
theorem inducedHom_isHom (hneg : ∀ a : K, a + -a = 0)
    (Q : QuadraticSpaceWithBasis K V) (Q' : QuadraticSpaceWithBasis K V') (θ : V → V')
    (hlin : IsLinearMap Q.space Q'.space θ) (hform : ∀ x : V, Q'.form (θ x) = Q.form x) :
    IsAlgebraHomomorphism (Q.cliffordAlgebra C) (Q'.cliffordAlgebra C) (inducedHom C hneg Q Q' θ hlin hform) :=
  (Classical.choose_spec (existsUnique_inducedHom C hneg Q Q' θ hlin hform)).1.1

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry` の必要十分版：Cl(θ) ∘ γ = γ' ∘ θ。 -/
theorem inducedHom_γ (hneg : ∀ a : K, a + -a = 0)
    (Q : QuadraticSpaceWithBasis K V) (Q' : QuadraticSpaceWithBasis K V') (θ : V → V')
    (hlin : IsLinearMap Q.space Q'.space θ) (hform : ∀ x : V, Q'.form (θ x) = Q.form x) (v : V) :
    inducedHom C hneg Q Q' θ hlin hform (Q.γ C v) = Q'.γ C (θ v) :=
  (Classical.choose_spec (existsUnique_inducedHom C hneg Q Q' θ hlin hform)).1.2 v

/-- 本文 `def_homomorphism_of_clifford_algebras_induced_by_isometry` の必要十分版：Θ ∘ γ = γ' ∘ θ を満たす準同型は Cl(θ) に等しい。 -/
theorem inducedHom_unique (hneg : ∀ a : K, a + -a = 0)
    (Q : QuadraticSpaceWithBasis K V) (Q' : QuadraticSpaceWithBasis K V') (θ : V → V')
    (hlin : IsLinearMap Q.space Q'.space θ) (hform : ∀ x : V, Q'.form (θ x) = Q.form x) (Θ' : Q.Cl C → Q'.Cl C)
    (hΘ' : IsAlgebraHomomorphism (Q.cliffordAlgebra C) (Q'.cliffordAlgebra C) Θ')
    (hΘ'γ : ∀ v : V, Θ' (Q.γ C v) = Q'.γ C (θ v)) : Θ' = inducedHom C hneg Q Q' θ hlin hform :=
  (Classical.choose_spec (existsUnique_inducedHom C hneg Q Q' θ hlin hform)).2 Θ' ⟨hΘ', hΘ'γ⟩

/-- 本文 `claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity` の必要十分版。 -/
theorem inducedHom_comp_inducedHom (hneg : ∀ a : K, a + -a = 0)
    (Q : QuadraticSpaceWithBasis K V) (Q' : QuadraticSpaceWithBasis K V')
    (σ : V → V') (hσlin : IsLinearMap Q.space Q'.space σ) (hσform : ∀ x : V, Q'.form (σ x) = Q.form x)
    (τ : V' → V) (hτlin : IsLinearMap Q'.space Q.space τ) (hτform : ∀ y : V', Q.form (τ y) = Q'.form y)
    (hτσ : ∀ x : V, τ (σ x) = x) (a : Q.Cl C) :
    inducedHom C hneg Q' Q τ hτlin hτform (inducedHom C hneg Q Q' σ hσlin hσform a) = a := by
  let A := Q.cliffordAlgebra C
  let Ξ : Q.Cl C → Q.Cl C := fun x => inducedHom C hneg Q' Q τ hτlin hτform (inducedHom C hneg Q Q' σ hσlin hσform x)
  have hΞ : IsAlgebraHomomorphism A A Ξ :=
    IsAlgebraHomomorphism.comp (inducedHom_isHom C hneg Q Q' σ hσlin hσform)
      (inducedHom_isHom C hneg Q' Q τ hτlin hτform)
  have hid : IsAlgebraHomomorphism A A (fun x => x) := isAlgebraHomomorphism_id A
  have hΞγ : ∀ v : V, Ξ (Q.γ C v) = Q.γ C v := fun v => calc
    Ξ (Q.γ C v) = inducedHom C hneg Q' Q τ hτlin hτform (inducedHom C hneg Q Q' σ hσlin hσform (Q.γ C v)) := rfl
    _ = inducedHom C hneg Q' Q τ hτlin hτform (Q'.γ C (σ v)) := by
        rw [inducedHom_γ C hneg Q Q' σ hσlin hσform v]
    _ = Q.γ C (τ (σ v)) := inducedHom_γ C hneg Q' Q τ hτlin hτform (σ v)
    _ = Q.γ C v := by rw [hτσ v]
    _ = (fun x => x) (Q.γ C v) := rfl
  obtain ⟨Υ, _, huniq⟩ := Q.universalProperty C hneg A (Q.γ C) (Q.γ_isLinearMap C) (Q.γ_mul_self C hneg)
  have hΞΥ : Ξ = Υ := huniq Ξ ⟨hΞ, hΞγ⟩
  have hidΥ : (fun x => x) = Υ := huniq (fun x => x) ⟨hid, fun _ => rfl⟩
  calc inducedHom C hneg Q' Q τ hτlin hτform (inducedHom C hneg Q Q' σ hσlin hσform a) = Ξ a := rfl
    _ = Υ a := by rw [hΞΥ]
    _ = (fun x => x) a := by rw [hidΥ]
    _ = a := rfl

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.QuadraticSpaceWithBasis
