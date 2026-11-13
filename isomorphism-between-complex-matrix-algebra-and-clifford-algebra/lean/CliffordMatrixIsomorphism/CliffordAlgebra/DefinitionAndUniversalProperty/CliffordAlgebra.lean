/-
章「クリフォード代数」のうち、クリフォード代数の定義と普遍性の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                          このファイル
  def_clifford_ideal                                                    QuadraticSpaceWithBasis（前提の組）・idealGenerators・ideal（I_q）・
                                                                        ideal_isTwoSidedIdeal
  def_clifford_algebra                                                  Cl・cliffordAlgebra（Cl(V,q)）・proj（π_{I_q}）
  def_clifford_generator_map                                            γ
  claim_clifford_generator_map_is_linear_map                            γ_isLinearMap
  claim_square_of_clifford_generator                                    γ_mul_self
  claim_anticommutator_of_clifford_generator_images_is_polarization     γ_anticommutator
  claim_image_of_clifford_generator_map_generates_clifford_algebra      γ_generates
  claim_universal_property_of_clifford_algebra                          universalProperty

本文の前提「V は ℂ-線型空間、b : {1,…,n} → V は基底、q は V 上の二次形式」を structure `QuadraticSpaceWithBasis` の欄に置く。
T(V) は基底 b の座標による族の上のテンソル代数 `coordinateTensorAlgebra`、ι は `embedVector` である。
本文の -_ℂ a は ℂ の `-a`、商代数の演算は `quotientAlgebra` の欄で、X +_{Cl} Y は代表で開くと `projection_add` などになる。

必要十分版は `NecSuf/CliffordAlgebra/DefinitionAndUniversalProperty/CliffordAlgebra.lean`、
導出版は `CliffordAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.QuadraticForm.QuadraticForm
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.UniversalPropertyOfTensorAlgebra
import CliffordMatrixIsomorphism.MathematicalToolkit.IdealAndQuotientAlgebra.UniversalProperty

namespace CliffordMatrixIsomorphism.Clifford

open ComplexVectorSpace ComplexAlgebra

universe u w

noncomputable section

/-- 本文 `def_clifford_ideal` の前提：ℂ-線型空間 V、その基底 b : {1,…,n} → V、V 上の二次形式 q。 -/
structure QuadraticSpaceWithBasis (V : Type u) where
  space : ComplexVectorSpace V
  dim : ℕ
  basis : ℕ → V
  isBasis : IsBasisFamily space dim basis
  form : V → ℂ
  isQuadraticForm : IsQuadraticForm space form

namespace QuadraticSpaceWithBasis

variable {V : Type u} (Q : QuadraticSpaceWithBasis V)

/-- 本文 `def_clifford_ideal` の T(V) の台にある族：基底 b の座標による j 重テンソル積の族。 -/
noncomputable abbrev tensorPowers : TensorPowers.{u, 0} Q.space :=
  coordinateTensorPowers Q.space Q.dim Q.basis Q.isBasis

/-- 本文 `def_clifford_ideal` の T(V) の集合。 -/
abbrev TV : Type := DirectSumOfFamily Q.tensorPowers.space

/-- 本文 `def_clifford_ideal` の T(V)：基底 b で構成した V のテンソル代数。 -/
noncomputable abbrev TA : ComplexAlgebra Q.TV := coordinateTensorAlgebra Q.space Q.dim Q.basis Q.isBasis

/-- 本文 `def_clifford_ideal` の ι : V → T(V)。 -/
def ι (v : V) : Q.TV := Q.tensorPowers.embedVector v

/-- 本文 `def_clifford_ideal` で両側イデアルを生成する部分集合 {ι(v) ·_{T(V)} ι(v) +_{T(V)} ((-_ℂ q(v)) ∗_{T(V)} 1_{T(V)}) : v ∈ V}。 -/
def idealGenerators : Set Q.TV :=
  {x | ∃ v : V, x = Q.TA.add (Q.TA.mul (Q.ι v) (Q.ι v)) (Q.TA.smul (-Q.form v) Q.TA.one)}

/-- 本文 `def_clifford_ideal`：I_q := ⟨{ι(v) ι(v) + ((-q(v)) ∗ 1) : v ∈ V}⟩_{T(V)}。 -/
def ideal : Set Q.TV := generatedIdeal Q.TA Q.idealGenerators

/-- 本文 `def_clifford_ideal`：I_q は T(V) の両側イデアルである（`claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal`）。 -/
theorem ideal_isTwoSidedIdeal : IsTwoSidedIdeal Q.TA Q.ideal :=
  generatedIdeal_isTwoSidedIdeal Q.TA Q.idealGenerators

/-- 本文 `def_clifford_algebra` の Cl(V,q) の集合 T(V)/I_q。 -/
abbrev Cl : Type := QuotientSet Q.TA Q.ideal

/-- 本文 `def_clifford_algebra`：Cl(V,q) := T(V)/I_q（商代数。`claim_quotient_algebra_is_complex_algebra`）。 -/
noncomputable def cliffordAlgebra : ComplexAlgebra Q.Cl := quotientAlgebra Q.ideal_isTwoSidedIdeal

/-- 本文 `def_clifford_algebra` の π_{I_q} : T(V) → Cl(V,q)。 -/
def proj (x : Q.TV) : Q.Cl := projection Q.TA Q.ideal x

/-- 本文 `def_clifford_algebra`：π_{I_q} は ℂ-代数の準同型である（`claim_projection_onto_quotient_algebra_is_algebra_homomorphism`）。 -/
theorem proj_isHom : IsComplexAlgebraHomomorphism Q.TA Q.cliffordAlgebra Q.proj :=
  projection_isComplexAlgebraHomomorphism Q.ideal_isTwoSidedIdeal

/-- 本文 `def_clifford_generator_map`：γ(v) := π_{I_q}(ι(v))。 -/
def γ (v : V) : Q.Cl := Q.proj (Q.ι v)

/-- 本文 `claim_clifford_generator_map_is_linear_map`：γ は V から U_vec(Cl(V,q)) への線型写像である。
ι は線型写像（`claim_embedding_of_vector_space_into_tensor_algebra_is_linear_map`）、π_{I_q} は準同型なので
U_vec の間の線型写像で、γ = π_{I_q} ∘ ι は二つの線型写像の合成である（`claim_composition_of_linear_maps_is_linear_map`）。 -/
theorem γ_isLinearMap : IsComplexLinearMap Q.space (underlyingVectorSpace Q.cliffordAlgebra) Q.γ :=
  IsComplexLinearMap.comp (g := Q.proj) Q.tensorPowers.embedVector_isLinearMap Q.proj_isHom.isLinearMap_underlying

/-- γ が加法を保つこと（`claim_clifford_generator_map_is_linear_map` を Cl(V,q) の演算で書いたもの）。 -/
theorem γ_add (x y : V) : Q.γ (Q.space.add x y) = Q.cliffordAlgebra.add (Q.γ x) (Q.γ y) :=
  Q.γ_isLinearMap.map_add x y

/-- 本文 `claim_square_of_clifford_generator`：γ(v) ·_{Cl} γ(v) = q(v) ∗_{Cl} 1_{Cl}。
本文どおり x := ι(v) ·_{T(V)} ι(v)、λ := q(v) と置く。 -/
theorem γ_mul_self (v : V) :
    Q.cliffordAlgebra.mul (Q.γ v) (Q.γ v) = Q.cliffordAlgebra.smul (Q.form v) Q.cliffordAlgebra.one := by
  have hI := Q.ideal_isTwoSidedIdeal
  let C := Q.cliffordAlgebra
  let T := Q.TA
  let x : Q.TV := T.mul (Q.ι v) (Q.ι v)
  let l : ℂ := Q.form v
  have hmem : T.add x (T.smul (-l) T.one) ∈ Q.ideal :=
    subset_generatedIdeal Q.TA Q.idealGenerators ⟨v, rfl⟩
  calc C.mul (Q.γ v) (Q.γ v)
      = C.mul (Q.proj (Q.ι v)) (Q.proj (Q.ι v)) := rfl
    _ = Q.proj x := (projection_mul hI (Q.ι v) (Q.ι v)).symm
    _ = Q.proj (T.add x T.zero) := by rw [T.add_zero x]
    _ = Q.proj (T.add x (T.smul 0 T.one)) := by rw [ComplexAlgebra.zero_smul_eq_zero T T.one]
    _ = Q.proj (T.add x (T.smul (l + -l) T.one)) := by rw [add_neg_cancel l]
    _ = Q.proj (T.add x (T.smul (-l + l) T.one)) := by rw [_root_.add_comm l (-l)]
    _ = Q.proj (T.add x (T.add (T.smul (-l) T.one) (T.smul l T.one))) := by rw [T.add_smul (-l) l T.one]
    _ = Q.proj (T.add (T.add x (T.smul (-l) T.one)) (T.smul l T.one)) := by
        rw [T.add_assoc x (T.smul (-l) T.one) (T.smul l T.one)]
    _ = C.add (Q.proj (T.add x (T.smul (-l) T.one))) (Q.proj (T.smul l T.one)) :=
        projection_add hI _ _
    _ = C.add C.zero (Q.proj (T.smul l T.one)) :=
        congrArg (fun X => C.add X (Q.proj (T.smul l T.one))) (projection_eq_zero_of_mem hI _ hmem)
    _ = C.add (Q.proj (T.smul l T.one)) C.zero := C.add_comm C.zero _
    _ = Q.proj (T.smul l T.one) := C.add_zero _
    _ = C.smul l (Q.proj T.one) := projection_smul hI l T.one
    _ = C.smul l C.one := congrArg (fun X => C.smul l X) Q.proj_isHom.map_one
    _ = C.smul (Q.form v) C.one := rfl

/-- 本文 `claim_anticommutator_of_clifford_generator_images_is_polarization`：
γ(x) γ(y) + γ(y) γ(x) = B_q(x, y) ∗ 1。本文どおり s・u・β を置き、u +_A u' = 0_A となる u' を一つ選ぶ。 -/
theorem γ_anticommutator (x y : V) :
    Q.cliffordAlgebra.add (Q.cliffordAlgebra.mul (Q.γ x) (Q.γ y)) (Q.cliffordAlgebra.mul (Q.γ y) (Q.γ x))
      = Q.cliffordAlgebra.smul (polarization Q.space Q.form x y) Q.cliffordAlgebra.one := by
  let A := Q.cliffordAlgebra
  let q := Q.form
  let s : Q.Cl := A.add (A.mul (Q.γ x) (Q.γ y)) (A.mul (Q.γ y) (Q.γ x))
  let u : Q.Cl := A.add (A.smul (q x) A.one) (A.smul (q y) A.one)
  let β : ℂ := polarization Q.space Q.form x y
  obtain ⟨u', hu'⟩ := A.exists_add_inverse u
  -- 平方の展開の等式
  have hexp : A.mul (Q.γ (Q.space.add x y)) (Q.γ (Q.space.add x y)) = A.add u s := calc
    A.mul (Q.γ (Q.space.add x y)) (Q.γ (Q.space.add x y))
        = A.mul (A.add (Q.γ x) (Q.γ y)) (A.add (Q.γ x) (Q.γ y)) := by rw [Q.γ_add x y]
    _ = A.add (A.mul (Q.γ x) (A.add (Q.γ x) (Q.γ y))) (A.mul (Q.γ y) (A.add (Q.γ x) (Q.γ y))) :=
        A.right_distrib _ _ _
    _ = A.add (A.add (A.mul (Q.γ x) (Q.γ x)) (A.mul (Q.γ x) (Q.γ y)))
          (A.add (A.mul (Q.γ y) (Q.γ x)) (A.mul (Q.γ y) (Q.γ y))) := by
        rw [A.left_distrib (Q.γ x) (Q.γ x) (Q.γ y), A.left_distrib (Q.γ y) (Q.γ x) (Q.γ y)]
    _ = A.add (A.add (A.smul (q x) A.one) (A.mul (Q.γ x) (Q.γ y)))
          (A.add (A.mul (Q.γ y) (Q.γ x)) (A.smul (q y) A.one)) := by
        rw [Q.γ_mul_self x, Q.γ_mul_self y]
    _ = A.add (A.smul (q x) A.one) (A.add (A.mul (Q.γ x) (Q.γ y))
          (A.add (A.mul (Q.γ y) (Q.γ x)) (A.smul (q y) A.one))) := A.add_assoc _ _ _
    _ = A.add (A.smul (q x) A.one) (A.add (A.add (A.mul (Q.γ x) (Q.γ y)) (A.mul (Q.γ y) (Q.γ x)))
          (A.smul (q y) A.one)) := by rw [A.add_assoc (A.mul (Q.γ x) (Q.γ y))]
    _ = A.add (A.smul (q x) A.one) (A.add s (A.smul (q y) A.one)) := rfl
    _ = A.add (A.smul (q x) A.one) (A.add (A.smul (q y) A.one) s) := by rw [A.add_comm s]
    _ = A.add (A.add (A.smul (q x) A.one) (A.smul (q y) A.one)) s := (A.add_assoc _ _ _).symm
    _ = A.add u s := rfl
  calc A.add (A.mul (Q.γ x) (Q.γ y)) (A.mul (Q.γ y) (Q.γ x))
      = s := rfl
    _ = A.add s A.zero := (A.add_zero s).symm
    _ = A.add s (A.add u u') := by rw [hu']
    _ = A.add (A.add s u) u' := (A.add_assoc s u u').symm
    _ = A.add (A.add u s) u' := by rw [A.add_comm s u]
    _ = A.add (A.mul (Q.γ (Q.space.add x y)) (Q.γ (Q.space.add x y))) u' := by rw [hexp]
    _ = A.add (A.smul (q (Q.space.add x y)) A.one) u' := by rw [Q.γ_mul_self (Q.space.add x y)]
    _ = A.add (A.smul ((q x + q y) + polarization Q.space Q.form x y) A.one) u' := by
        rw [polarization_identity Q.space Q.form x y]
    _ = A.add (A.smul ((q x + q y) + β) A.one) u' := rfl
    _ = A.add (A.add (A.smul (q x + q y) A.one) (A.smul β A.one)) u' := by rw [A.add_smul (q x + q y) β A.one]
    _ = A.add (A.add (A.add (A.smul (q x) A.one) (A.smul (q y) A.one)) (A.smul β A.one)) u' := by
        rw [A.add_smul (q x) (q y) A.one]
    _ = A.add (A.add u (A.smul β A.one)) u' := rfl
    _ = A.add (A.add (A.smul β A.one) u) u' := by rw [A.add_comm u (A.smul β A.one)]
    _ = A.add (A.smul β A.one) (A.add u u') := A.add_assoc _ _ _
    _ = A.add (A.smul β A.one) A.zero := by rw [hu']
    _ = A.smul β A.one := A.add_zero _
    _ = A.smul (polarization Q.space Q.form x y) A.one := rfl

/-- 本文 `claim_image_of_clifford_generator_map_generates_clifford_algebra`：γ(V) は Cl(V,q) を生成する。
γ(V) ⊆ B を満たす部分代数 B について、B' := {x ∈ T(V) : π_{I_q}(x) ∈ B} が T(V) の部分代数で ι(V) を含むことを示し、
ι(V) が T(V) を生成すること（`claim_image_of_embedding_generates_tensor_algebra`）と射影の全射性で B = Cl(V,q) を得る。 -/
theorem γ_generates : GeneratesAlgebra Q.cliffordAlgebra (Set.range Q.γ) := by
  intro B hB hsub
  let B' : Set Q.TV := {x | Q.proj x ∈ B}
  have hB' : IsSubalgebra Q.TA B' := {
    one_mem := by
      show Q.proj Q.TA.one ∈ B
      rw [Q.proj_isHom.map_one]
      exact hB.one_mem
    add_mem := fun x y hx hy => by
      show Q.proj (Q.TA.add x y) ∈ B
      rw [Q.proj_isHom.map_add x y]
      exact hB.add_mem _ _ hx hy
    mul_mem := fun x y hx hy => by
      show Q.proj (Q.TA.mul x y) ∈ B
      rw [Q.proj_isHom.map_mul x y]
      exact hB.mul_mem _ _ hx hy
    smul_mem := fun l x hx => by
      show Q.proj (Q.TA.smul l x) ∈ B
      rw [Q.proj_isHom.map_smul l x]
      exact hB.smul_mem _ _ hx }
  have hιB' : Set.range Q.tensorPowers.embedVector ⊆ B' := by
    rintro _ ⟨v, rfl⟩
    show Q.γ v ∈ B
    exact hsub ⟨v, rfl⟩
  have hB'univ : B' = Set.univ :=
    coordinateTensorPowers_generates Q.space Q.dim Q.basis Q.isBasis B' hB' hιB'
  apply Set.eq_univ_of_forall
  intro X
  obtain ⟨a, rfl⟩ := projection_surjective Q.TA Q.ideal X
  have ha : a ∈ B' := by rw [hB'univ]; exact Set.mem_univ a
  exact ha

/-- 本文 `claim_universal_property_of_clifford_algebra`：f(v) ·_A f(v) = q(v) ∗_A 1_A を満たす線型写像 f : V → U_vec(A) について、
Φ ∘ γ = f を満たす Cl(V,q) から A への ℂ-代数の準同型 Φ がただ一つ存在する。
（存在）テンソル代数の普遍性の F は I_q を生成する部分集合を 0_A へ移すので I_q ⊆ K_F、F が誘導する写像が求めるもの。
（一意性）γ(V) は Cl(V,q) を生成するので、生成元で一致する準同型は等しい。 -/
theorem universalProperty {A : Type w} (SA : ComplexAlgebra A) (f : V → A)
    (hf : IsComplexLinearMap Q.space SA.toComplexVectorSpace f)
    (hsq : ∀ v : V, SA.mul (f v) (f v) = SA.smul (Q.form v) SA.one) :
    ∃ Φ : Q.Cl → A, (IsComplexAlgebraHomomorphism Q.cliffordAlgebra SA Φ ∧ ∀ v : V, Φ (Q.γ v) = f v) ∧
      ∀ Φ' : Q.Cl → A, (IsComplexAlgebraHomomorphism Q.cliffordAlgebra SA Φ' ∧ ∀ v : V, Φ' (Q.γ v) = f v) →
        Φ' = Φ := by
  have hI := Q.ideal_isTwoSidedIdeal
  -- （存在）
  obtain ⟨F, ⟨hF, hFι⟩, _⟩ :=
    universalProperty_of_tensorAlgebra Q.space Q.dim Q.basis Q.isBasis SA f hf
  have hgen : ∀ v : V,
      F (Q.TA.add (Q.TA.mul (Q.ι v) (Q.ι v)) (Q.TA.smul (-Q.form v) Q.TA.one)) = SA.zero := by
    intro v
    let l : ℂ := Q.form v
    calc F (Q.TA.add (Q.TA.mul (Q.ι v) (Q.ι v)) (Q.TA.smul (-l) Q.TA.one))
        = SA.add (F (Q.TA.mul (Q.ι v) (Q.ι v))) (F (Q.TA.smul (-l) Q.TA.one)) := hF.map_add _ _
      _ = SA.add (SA.mul (F (Q.ι v)) (F (Q.ι v))) (F (Q.TA.smul (-l) Q.TA.one)) := by
          rw [hF.map_mul (Q.ι v) (Q.ι v)]
      _ = SA.add (SA.mul (f v) (f v)) (F (Q.TA.smul (-l) Q.TA.one)) := by
          rw [show F (Q.ι v) = f v from hFι v]
      _ = SA.add (SA.mul (f v) (f v)) (SA.smul (-l) (F Q.TA.one)) := by rw [hF.map_smul (-l) Q.TA.one]
      _ = SA.add (SA.mul (f v) (f v)) (SA.smul (-l) SA.one) := by rw [hF.map_one]
      _ = SA.add (SA.smul (Q.form v) SA.one) (SA.smul (-l) SA.one) := by rw [hsq v]
      _ = SA.add (SA.smul l SA.one) (SA.smul (-l) SA.one) := rfl
      _ = SA.smul (l + -l) SA.one := (SA.add_smul l (-l) SA.one).symm
      _ = SA.smul 0 SA.one := by rw [add_neg_cancel l]
      _ = SA.zero := ComplexAlgebra.zero_smul_eq_zero SA SA.one
  have hsubK : Q.idealGenerators ⊆ kernel SA F := by
    rintro _ ⟨v, rfl⟩
    exact hgen v
  have hIK : Q.ideal ⊆ kernel SA F :=
    generatedIdeal_subset Q.TA Q.idealGenerators (kernel SA F) (kernel_isTwoSidedIdeal hF) hsubK
  have hFI : ∀ x ∈ Q.ideal, F x = SA.zero := fun x hx => hIK hx
  let Fbar : Q.Cl → A := inducedMap Q.TA Q.ideal F
  have hFbar : IsComplexAlgebraHomomorphism Q.cliffordAlgebra SA Fbar :=
    inducedMap_isComplexAlgebraHomomorphism hI hF hFI
  have hFbarγ : ∀ v : V, Fbar (Q.γ v) = f v := fun v => calc
    Fbar (Q.γ v) = Fbar (Q.proj (Q.ι v)) := rfl
    _ = F (Q.ι v) := inducedMap_projection hI hF hFI (Q.ι v)
    _ = f v := hFι v
  refine ⟨Fbar, ⟨hFbar, hFbarγ⟩, ?_⟩
  -- （一意性）
  rintro Φ' ⟨hΦ', hΦ'γ⟩
  funext X
  exact eq_of_agree_on_generators hΦ' hFbar (Set.range Q.γ) Q.γ_generates
    (fun _ ⟨v, hv⟩ => by rw [← hv, hΦ'γ v, hFbarγ v]) X

end QuadraticSpaceWithBasis

end

end CliffordMatrixIsomorphism.Clifford
