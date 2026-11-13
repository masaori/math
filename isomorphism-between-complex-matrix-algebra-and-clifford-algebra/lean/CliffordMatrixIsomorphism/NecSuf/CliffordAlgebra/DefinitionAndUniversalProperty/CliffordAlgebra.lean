/-
章「クリフォード代数」のうち、クリフォード代数の定義と普遍性の必要十分版。具体版
`CliffordAlgebra/DefinitionAndUniversalProperty/CliffordAlgebra.lean` と同じ def・calc の行を、係数 ℂ を型の変数 K に替えて書く。
本文の -_ℂ a は K の `-a`、合同と T(V) の加法の逆元に使う -1_ℂ は K の元 n である。

K に置く仮定は `CliffordLaws K n` の四つの欄と、a + (-a) = 0（`hneg`）である。各仮定を使う所:

  valuedMaps・uniqueness   T(V) を座標による構成の族の上で作ること（テンソル代数の節の必要十分版がそのまま要求する）。
                           uniqueness の欄のうち加法の結合法則・交換法則・0 + a = a は偏極の等式（γ_anticommutator）で、
                           加法の交換法則は γ(v)² の計算の λ + (-λ) = (-λ) + λ の行でも使い、
                           a + 0 = a・a · 0 = 0 は T(V) の零の境とスカラー倍（`ScalarMultipleOfZeroLaws`）と、射影が I_q の元を零へ移すことに使う
  mul_comm                 T(V) のテンソルの積を定めること、商代数のスカラー倍が代表によらないこと（n · λ = λ · n）
  congruence               商代数（合同の反射性・対称性・推移性）と、T(V) の加法の逆元 n ∗ x を作る 1 + n = 0。
                           その欄の 0 + 0 = 0 は、零のスカラー倍が零であること（`zero_smul_eq_zero`）と、準同型の核が両側イデアルであることにも使う
  hneg                     a + (-a) = 0：γ(v)² の計算（γ_mul_self）、偏極の等式（γ_anticommutator）、普遍性の存在の計算（universalProperty）だけ。
                           T(V)・Cl・π・γ の構成、γ が線型であること、γ(V) が生成することは使わない

前提の組 `QuadraticSpaceWithBasis` は、具体版の欄のうち「q は二次形式である」を持たない。
この章のどの主張も q が二次形式であることを使わず、q は V から K への任意の写像でよい
（偏極の等式は任意の写像で成り立ち、普遍性の証明が q について使うのは f(v)·f(v) = q(v) ∗ 1 という仮定と I_q の生成元の形だけである）。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.QuadraticForm.QuadraticForm
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.UniversalPropertyOfTensorAlgebra
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.IdealAndQuotientAlgebra.UniversalProperty

namespace CliffordMatrixIsomorphism.NecSuf.Clifford

open VectorSpace AlgebraOver

universe u w uK

noncomputable section

/-- この章の必要十分版が K に置く仮定。 -/
structure CliffordLaws (K : Type uK) [Add K] [Mul K] [One K] [Zero K] (n : K) : Prop where
  valuedMaps : ValuedMapsLaws K
  uniqueness : UniquenessLaws K
  mul_comm : ∀ a b : K, a * b = b * a
  congruence : AlgebraOver.CongruenceLaws K n

/-- 本文 `def_clifford_ideal` の前提の必要十分版：K-線型空間 V、その基底 b、写像 q : V → K（二次形式であることは要らない）。 -/
structure QuadraticSpaceWithBasis (K : Type uK) [Add K] [Mul K] [One K] [Zero K] (V : Type u) where
  space : VectorSpace K V
  dim : ℕ
  basis : ℕ → V
  isBasis : IsBasisFamily space dim basis
  form : V → K

namespace CliffordLaws

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {n : K}

/-- T(V) に渡す 0 + 0 = 0 と a · 0 = 0（テンソル代数の普遍性の必要十分版が使う組と同じ形）。 -/
theorem scalarMultipleOfZero (C : CliffordLaws K n) : ScalarMultipleOfZeroLaws K :=
  ⟨C.uniqueness.add_zero 0, C.uniqueness.mul_zero⟩

/-- n · λ = λ · n。 -/
theorem n_comm (C : CliffordLaws K n) : ∀ l : K, n * l = l * n := fun l => C.mul_comm n l

/-- 双対空間を線型空間にする性質は、どれもこの章の仮定の欄から出る。 -/
theorem dualSpaceVectorSpaceLaws (C : CliffordLaws K n) : DualSpaceVectorSpaceLaws K where
  add_assoc := C.uniqueness.add_assoc
  add_comm := C.uniqueness.add_comm
  left_distrib := C.valuedMaps.left_distrib
  mul_assoc := C.valuedMaps.mul_assoc
  mul_comm := C.mul_comm
  zero_add_zero := C.congruence.zero_add_zero
  mul_zero := C.uniqueness.mul_zero
  add_zero := C.uniqueness.add_zero
  exists_neg_one := C.uniqueness.exists_neg_one
  one_mul := C.uniqueness.one_mul
  right_distrib := C.uniqueness.right_distrib
  zero_mul := C.uniqueness.zero_mul

/-- a · 1 = a は、乗法の交換法則と 1 · a = a から出る。 -/
theorem mul_one (C : CliffordLaws K n) : ∀ a : K, a * 1 = a := fun a =>
  (C.mul_comm a 1).trans (C.uniqueness.one_mul a)

end CliffordLaws

namespace QuadraticSpaceWithBasis

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {V : Type u} (Q : QuadraticSpaceWithBasis K V)

/-- 本文 `def_clifford_ideal` の T(V) の台にある族の必要十分版。 -/
abbrev tensorPowers : TensorPowers.{u, uK} Q.space :=
  coordinateTensorPowers C.valuedMaps C.uniqueness C.mul_comm Q.space Q.dim Q.basis Q.isBasis

/-- 本文 `def_clifford_ideal` の T(V) の集合。 -/
abbrev TV : Type uK := DirectSumOfFamily (Q.tensorPowers C).space

/-- 本文 `def_clifford_ideal` の T(V) の必要十分版。 -/
abbrev TA : AlgebraOver K (Q.TV C) :=
  (Q.tensorPowers C).tensorAlgebra C.mul_comm C.scalarMultipleOfZero n C.congruence.one_add_n

/-- 本文 `def_clifford_ideal` の ι の必要十分版。 -/
def ι (v : V) : Q.TV C := (Q.tensorPowers C).embedVector v

/-- 本文 `def_clifford_ideal` で両側イデアルを生成する部分集合の必要十分版。 -/
def idealGenerators : Set (Q.TV C) :=
  {x | ∃ v : V, x = (Q.TA C).add ((Q.TA C).mul (Q.ι C v) (Q.ι C v)) ((Q.TA C).smul (-Q.form v) (Q.TA C).one)}

/-- 本文 `def_clifford_ideal` の I_q の必要十分版。 -/
def ideal : Set (Q.TV C) := generatedIdeal (Q.TA C) (Q.idealGenerators C)

theorem ideal_isTwoSidedIdeal : IsTwoSidedIdeal (Q.TA C) (Q.ideal C) :=
  generatedIdeal_isTwoSidedIdeal (Q.TA C) (Q.idealGenerators C)

/-- 本文 `def_clifford_algebra` の集合 T(V)/I_q の必要十分版。 -/
abbrev Cl : Type uK := QuotientSet (Q.TA C) n (Q.ideal C)

/-- 本文 `def_clifford_algebra` の必要十分版。 -/
def cliffordAlgebra : AlgebraOver K (Q.Cl C) :=
  quotientAlgebra (Q.ideal_isTwoSidedIdeal C) C.congruence C.n_comm

/-- 本文 `def_clifford_algebra` の π_{I_q} の必要十分版。 -/
def proj (x : Q.TV C) : Q.Cl C := projection (Q.TA C) n (Q.ideal C) x

theorem proj_isHom : IsAlgebraHomomorphism (Q.TA C) (Q.cliffordAlgebra C) (Q.proj C) :=
  projection_isAlgebraHomomorphism (Q.ideal_isTwoSidedIdeal C) C.congruence C.n_comm

/-- 本文 `def_clifford_generator_map` の必要十分版。 -/
def γ (v : V) : Q.Cl C := Q.proj C (Q.ι C v)

/-- 本文 `claim_clifford_generator_map_is_linear_map` の必要十分版。 -/
theorem γ_isLinearMap : IsLinearMap Q.space (underlyingVectorSpace (Q.cliffordAlgebra C)) (Q.γ C) :=
  IsLinearMap.comp (g := Q.proj C)
    ((Q.tensorPowers C).embedVector_isLinearMap C.mul_comm C.scalarMultipleOfZero n C.congruence.one_add_n)
    (Q.proj_isHom C).isLinearMap_underlying

theorem γ_add (x y : V) : Q.γ C (Q.space.add x y) = (Q.cliffordAlgebra C).add (Q.γ C x) (Q.γ C y) :=
  (Q.γ_isLinearMap C).map_add x y

/-- 本文 `claim_square_of_clifford_generator` の必要十分版。 -/
theorem γ_mul_self (hneg : ∀ a : K, a + -a = 0) (v : V) :
    (Q.cliffordAlgebra C).mul (Q.γ C v) (Q.γ C v) = (Q.cliffordAlgebra C).smul (Q.form v) (Q.cliffordAlgebra C).one := by
  have hI := Q.ideal_isTwoSidedIdeal C
  let A := Q.cliffordAlgebra C
  let T := Q.TA C
  let x : Q.TV C := T.mul (Q.ι C v) (Q.ι C v)
  let l : K := Q.form v
  have hmem : T.add x (T.smul (-l) T.one) ∈ Q.ideal C :=
    subset_generatedIdeal (Q.TA C) (Q.idealGenerators C) ⟨v, rfl⟩
  calc A.mul (Q.γ C v) (Q.γ C v)
      = A.mul (Q.proj C (Q.ι C v)) (Q.proj C (Q.ι C v)) := rfl
    _ = Q.proj C x := (projection_mul hI C.congruence (Q.ι C v) (Q.ι C v)).symm
    _ = Q.proj C (T.add x T.zero) := by rw [T.add_zero x]
    _ = Q.proj C (T.add x (T.smul 0 T.one)) := by
        rw [AlgebraOver.zero_smul_eq_zero T C.congruence.zero_add_zero T.one]
    _ = Q.proj C (T.add x (T.smul (l + -l) T.one)) := by rw [hneg l]
    _ = Q.proj C (T.add x (T.smul (-l + l) T.one)) := by rw [C.uniqueness.add_comm l (-l)]
    _ = Q.proj C (T.add x (T.add (T.smul (-l) T.one) (T.smul l T.one))) := by rw [T.add_smul (-l) l T.one]
    _ = Q.proj C (T.add (T.add x (T.smul (-l) T.one)) (T.smul l T.one)) := by
        rw [T.add_assoc x (T.smul (-l) T.one) (T.smul l T.one)]
    _ = A.add (Q.proj C (T.add x (T.smul (-l) T.one))) (Q.proj C (T.smul l T.one)) :=
        projection_add hI C.congruence _ _
    _ = A.add A.zero (Q.proj C (T.smul l T.one)) :=
        congrArg (fun X => A.add X (Q.proj C (T.smul l T.one)))
          (projection_eq_zero_of_mem hI C.congruence C.uniqueness.mul_zero _ hmem)
    _ = A.add (Q.proj C (T.smul l T.one)) A.zero := A.add_comm A.zero _
    _ = Q.proj C (T.smul l T.one) := A.add_zero _
    _ = A.smul l (Q.proj C T.one) := projection_smul hI C.congruence C.n_comm l T.one
    _ = A.smul l A.one := congrArg (fun X => A.smul l X) (Q.proj_isHom C).map_one
    _ = A.smul (Q.form v) A.one := rfl

/-- 本文 `claim_anticommutator_of_clifford_generator_images_is_polarization` の必要十分版。 -/
theorem γ_anticommutator (hneg : ∀ a : K, a + -a = 0) (x y : V) :
    (Q.cliffordAlgebra C).add ((Q.cliffordAlgebra C).mul (Q.γ C x) (Q.γ C y))
        ((Q.cliffordAlgebra C).mul (Q.γ C y) (Q.γ C x))
      = (Q.cliffordAlgebra C).smul (polarization Q.space Q.form x y) (Q.cliffordAlgebra C).one := by
  let A := Q.cliffordAlgebra C
  let q := Q.form
  let s : Q.Cl C := A.add (A.mul (Q.γ C x) (Q.γ C y)) (A.mul (Q.γ C y) (Q.γ C x))
  let u : Q.Cl C := A.add (A.smul (q x) A.one) (A.smul (q y) A.one)
  let β : K := polarization Q.space Q.form x y
  obtain ⟨u', hu'⟩ := A.exists_add_inverse u
  have hexp : A.mul (Q.γ C (Q.space.add x y)) (Q.γ C (Q.space.add x y)) = A.add u s := calc
    A.mul (Q.γ C (Q.space.add x y)) (Q.γ C (Q.space.add x y))
        = A.mul (A.add (Q.γ C x) (Q.γ C y)) (A.add (Q.γ C x) (Q.γ C y)) := by rw [Q.γ_add C x y]
    _ = A.add (A.mul (Q.γ C x) (A.add (Q.γ C x) (Q.γ C y))) (A.mul (Q.γ C y) (A.add (Q.γ C x) (Q.γ C y))) :=
        A.right_distrib _ _ _
    _ = A.add (A.add (A.mul (Q.γ C x) (Q.γ C x)) (A.mul (Q.γ C x) (Q.γ C y)))
          (A.add (A.mul (Q.γ C y) (Q.γ C x)) (A.mul (Q.γ C y) (Q.γ C y))) := by
        rw [A.left_distrib (Q.γ C x) (Q.γ C x) (Q.γ C y), A.left_distrib (Q.γ C y) (Q.γ C x) (Q.γ C y)]
    _ = A.add (A.add (A.smul (q x) A.one) (A.mul (Q.γ C x) (Q.γ C y)))
          (A.add (A.mul (Q.γ C y) (Q.γ C x)) (A.smul (q y) A.one)) := by
        rw [Q.γ_mul_self C hneg x, Q.γ_mul_self C hneg y]
    _ = A.add (A.smul (q x) A.one) (A.add (A.mul (Q.γ C x) (Q.γ C y))
          (A.add (A.mul (Q.γ C y) (Q.γ C x)) (A.smul (q y) A.one))) := A.add_assoc _ _ _
    _ = A.add (A.smul (q x) A.one) (A.add (A.add (A.mul (Q.γ C x) (Q.γ C y)) (A.mul (Q.γ C y) (Q.γ C x)))
          (A.smul (q y) A.one)) := by rw [A.add_assoc (A.mul (Q.γ C x) (Q.γ C y))]
    _ = A.add (A.smul (q x) A.one) (A.add s (A.smul (q y) A.one)) := rfl
    _ = A.add (A.smul (q x) A.one) (A.add (A.smul (q y) A.one) s) := by rw [A.add_comm s]
    _ = A.add (A.add (A.smul (q x) A.one) (A.smul (q y) A.one)) s := (A.add_assoc _ _ _).symm
    _ = A.add u s := rfl
  calc A.add (A.mul (Q.γ C x) (Q.γ C y)) (A.mul (Q.γ C y) (Q.γ C x))
      = s := rfl
    _ = A.add s A.zero := (A.add_zero s).symm
    _ = A.add s (A.add u u') := by rw [hu']
    _ = A.add (A.add s u) u' := (A.add_assoc s u u').symm
    _ = A.add (A.add u s) u' := by rw [A.add_comm s u]
    _ = A.add (A.mul (Q.γ C (Q.space.add x y)) (Q.γ C (Q.space.add x y))) u' := by rw [hexp]
    _ = A.add (A.smul (q (Q.space.add x y)) A.one) u' := by rw [Q.γ_mul_self C hneg (Q.space.add x y)]
    _ = A.add (A.smul ((q x + q y) + polarization Q.space Q.form x y) A.one) u' := by
        rw [polarization_identity C.uniqueness.add_assoc C.uniqueness.add_comm hneg C.uniqueness.zero_add
          Q.space Q.form x y]
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

/-- 本文 `claim_image_of_clifford_generator_map_generates_clifford_algebra` の必要十分版。 -/
theorem γ_generates : GeneratesAlgebra (Q.cliffordAlgebra C) (Set.range (Q.γ C)) := by
  intro B hB hsub
  let B' : Set (Q.TV C) := {x | Q.proj C x ∈ B}
  have hB' : IsSubalgebra (Q.TA C) B' := {
    one_mem := by
      show Q.proj C (Q.TA C).one ∈ B
      rw [(Q.proj_isHom C).map_one]
      exact hB.one_mem
    add_mem := fun x y hx hy => by
      show Q.proj C ((Q.TA C).add x y) ∈ B
      rw [(Q.proj_isHom C).map_add x y]
      exact hB.add_mem _ _ hx hy
    mul_mem := fun x y hx hy => by
      show Q.proj C ((Q.TA C).mul x y) ∈ B
      rw [(Q.proj_isHom C).map_mul x y]
      exact hB.mul_mem _ _ hx hy
    smul_mem := fun l x hx => by
      show Q.proj C ((Q.TA C).smul l x) ∈ B
      rw [(Q.proj_isHom C).map_smul l x]
      exact hB.smul_mem _ _ hx }
  have hιB' : Set.range (Q.tensorPowers C).embedVector ⊆ B' := by
    rintro _ ⟨v, rfl⟩
    show Q.γ C v ∈ B
    exact hsub ⟨v, rfl⟩
  have hB'univ : B' = Set.univ :=
    coordinateTensorPowers_generates C.valuedMaps C.uniqueness C.mul_comm C.scalarMultipleOfZero n
      C.congruence.one_add_n Q.space Q.dim Q.basis Q.isBasis B' hB' hιB'
  apply Set.eq_univ_of_forall
  intro X
  obtain ⟨a, rfl⟩ := projection_surjective (Q.TA C) n (Q.ideal C) X
  have ha : a ∈ B' := by rw [hB'univ]; exact Set.mem_univ a
  exact ha

/-- 本文 `claim_universal_property_of_clifford_algebra` の必要十分版。 -/
theorem universalProperty (hneg : ∀ a : K, a + -a = 0) {A : Type w} (SA : AlgebraOver K A) (f : V → A)
    (hf : IsLinearMap Q.space SA.toVectorSpace f)
    (hsq : ∀ v : V, SA.mul (f v) (f v) = SA.smul (Q.form v) SA.one) :
    ∃ Φ : Q.Cl C → A, (IsAlgebraHomomorphism (Q.cliffordAlgebra C) SA Φ ∧ ∀ v : V, Φ (Q.γ C v) = f v) ∧
      ∀ Φ' : Q.Cl C → A, (IsAlgebraHomomorphism (Q.cliffordAlgebra C) SA Φ' ∧ ∀ v : V, Φ' (Q.γ C v) = f v) →
        Φ' = Φ := by
  have hI := Q.ideal_isTwoSidedIdeal C
  obtain ⟨F, ⟨hF, hFι⟩, _⟩ :=
    universalProperty_of_tensorAlgebra C.valuedMaps C.uniqueness C.mul_comm n C.congruence.one_add_n
      Q.space Q.dim Q.basis Q.isBasis SA f hf
  have hgen : ∀ v : V,
      F ((Q.TA C).add ((Q.TA C).mul (Q.ι C v) (Q.ι C v)) ((Q.TA C).smul (-Q.form v) (Q.TA C).one)) = SA.zero := by
    intro v
    let l : K := Q.form v
    calc F ((Q.TA C).add ((Q.TA C).mul (Q.ι C v) (Q.ι C v)) ((Q.TA C).smul (-l) (Q.TA C).one))
        = SA.add (F ((Q.TA C).mul (Q.ι C v) (Q.ι C v))) (F ((Q.TA C).smul (-l) (Q.TA C).one)) := hF.map_add _ _
      _ = SA.add (SA.mul (F (Q.ι C v)) (F (Q.ι C v))) (F ((Q.TA C).smul (-l) (Q.TA C).one)) := by
          rw [hF.map_mul (Q.ι C v) (Q.ι C v)]
      _ = SA.add (SA.mul (f v) (f v)) (F ((Q.TA C).smul (-l) (Q.TA C).one)) := by
          rw [show F (Q.ι C v) = f v from hFι v]
      _ = SA.add (SA.mul (f v) (f v)) (SA.smul (-l) (F (Q.TA C).one)) := by rw [hF.map_smul (-l) (Q.TA C).one]
      _ = SA.add (SA.mul (f v) (f v)) (SA.smul (-l) SA.one) := by rw [hF.map_one]
      _ = SA.add (SA.smul (Q.form v) SA.one) (SA.smul (-l) SA.one) := by rw [hsq v]
      _ = SA.add (SA.smul l SA.one) (SA.smul (-l) SA.one) := rfl
      _ = SA.smul (l + -l) SA.one := (SA.add_smul l (-l) SA.one).symm
      _ = SA.smul 0 SA.one := by rw [hneg l]
      _ = SA.zero := AlgebraOver.zero_smul_eq_zero SA C.congruence.zero_add_zero SA.one
  have hsubK : Q.idealGenerators C ⊆ kernel SA F := by
    rintro _ ⟨v, rfl⟩
    exact hgen v
  have hIK : Q.ideal C ⊆ kernel SA F :=
    generatedIdeal_subset (Q.TA C) (Q.idealGenerators C) (kernel SA F)
      (kernel_isTwoSidedIdeal hF C.congruence.zero_add_zero) hsubK
  have hFI : ∀ x ∈ Q.ideal C, F x = SA.zero := fun x hx => hIK hx
  let Fbar : Q.Cl C → A := inducedMap (Q.TA C) n (Q.ideal C) F
  have hFbar : IsAlgebraHomomorphism (Q.cliffordAlgebra C) SA Fbar :=
    inducedMap_isAlgebraHomomorphism hI C.congruence C.n_comm hF hFI
  have hFbarγ : ∀ v : V, Fbar (Q.γ C v) = f v := fun v => calc
    Fbar (Q.γ C v) = Fbar (Q.proj C (Q.ι C v)) := rfl
    _ = F (Q.ι C v) := inducedMap_projection hI C.congruence hF hFI (Q.ι C v)
    _ = f v := hFι v
  refine ⟨Fbar, ⟨hFbar, hFbarγ⟩, ?_⟩
  rintro Φ' ⟨hΦ', hΦ'γ⟩
  funext X
  exact eq_of_agree_on_generators hΦ' hFbar (Set.range (Q.γ C)) (Q.γ_generates C)
    (fun _ ⟨v, hv⟩ => by rw [← hv, hΦ'γ v, hFbarγ v]) X

end QuadraticSpaceWithBasis

end

end CliffordMatrixIsomorphism.NecSuf.Clifford
