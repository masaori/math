/-
節「両側イデアルと商代数」の具体版が、必要十分版の K := ℂ、n := -1_ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引く。

  具体版                                     必要十分版の特殊化
  IsTwoSidedIdeal                            isTwoSidedIdeal_iff_necSuf
  generatedIdeal・kernel                     …_eq_necSuf（rfl を含む集合の等号）
  Congruent・residueClass・QuotientSet・
  projection・演算・inducedMap               …_eq_necSuf / …_iff_necSuf（rfl）
  quotientRing・quotientVectorSpace・
  quotientAlgebra                            …_eq_necSuf（rfl）
  各主張                                     …_of_necSuf

ℂ と n := -1_ℂ は、必要十分版の仮定 `CongruenceLaws ℂ (-1)`（0+0=0、1+(-1)=0、(-1)+1=1+(-1)、(-1)·(-1)=1）と、
(-1)·λ = λ·(-1)（乗法の交換法則）、a·0 = 0 を満たす。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.IdealAndQuotientAlgebra.UniversalProperty
import CliffordMatrixIsomorphism.MathematicalToolkit.IdealAndQuotientAlgebra.DirectSumBasis
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.ComplexAlgebraFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.FiniteSetSumFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.IdealAndQuotientAlgebra.UniversalProperty
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.IdealAndQuotientAlgebra.DirectSumBasis

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u v

variable {A : Type u} {B : Type v}

/-! ### ℂ と -1_ℂ が満たす係数の性質 -/

theorem complexCongruenceLaws : NecSuf.AlgebraOver.CongruenceLaws ℂ (-1) where
  zero_add_zero := _root_.add_zero (0 : ℂ)
  one_add_n := add_neg_cancel (1 : ℂ)
  n_add_one := _root_.add_comm (-1 : ℂ) 1
  n_mul_n := by norm_num

theorem complexNegOneComm : ∀ l : ℂ, (-1 : ℂ) * l = l * (-1) := fun l => _root_.mul_comm (-1 : ℂ) l

/-! ### 定義の対応 -/

theorem isTwoSidedIdeal_iff_necSuf (SA : ComplexAlgebra A) (I : Set A) :
    IsTwoSidedIdeal SA I ↔ NecSuf.AlgebraOver.IsTwoSidedIdeal SA.toNecSuf I :=
  ⟨fun h => ⟨h.zero_mem, h.add_mem, h.mul_mem_left, h.mul_mem_right⟩,
    fun h => ⟨h.zero_mem, h.add_mem, h.mul_mem_left, h.mul_mem_right⟩⟩

theorem generatedIdeal_eq_necSuf (SA : ComplexAlgebra A) (X : Set A) :
    generatedIdeal SA X = NecSuf.AlgebraOver.generatedIdeal SA.toNecSuf X :=
  Set.ext fun _ =>
    ⟨fun h I hI hXI => h I ((isTwoSidedIdeal_iff_necSuf SA I).2 hI) hXI,
      fun h I hI hXI => h I ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) hXI⟩

theorem kernel_eq_necSuf (SB : ComplexAlgebra B) (φ : A → B) :
    kernel SB φ = NecSuf.AlgebraOver.kernel SB.toNecSuf φ := rfl

theorem congruent_iff_necSuf (SA : ComplexAlgebra A) (I : Set A) (a b : A) :
    Congruent SA I a b ↔ NecSuf.AlgebraOver.Congruent SA.toNecSuf (-1) I a b := Iff.rfl

theorem residueClass_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) (a : A) :
    residueClass SA I a = NecSuf.AlgebraOver.residueClass SA.toNecSuf (-1) I a := rfl

theorem quotientSet_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) :
    QuotientSet SA I = NecSuf.AlgebraOver.QuotientSet SA.toNecSuf (-1) I := rfl

theorem projection_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) (a : A) :
    projection SA I a = (NecSuf.AlgebraOver.projection SA.toNecSuf (-1) I a : QuotientSet SA I) := rfl

theorem quotientAdd_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) (X Y : QuotientSet SA I) :
    quotientAdd SA I X Y = (NecSuf.AlgebraOver.quotientAdd SA.toNecSuf (-1) I X Y : QuotientSet SA I) :=
  rfl

theorem quotientMul_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) (X Y : QuotientSet SA I) :
    quotientMul SA I X Y = (NecSuf.AlgebraOver.quotientMul SA.toNecSuf (-1) I X Y : QuotientSet SA I) :=
  rfl

theorem quotientSmul_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) (l : ℂ) (X : QuotientSet SA I) :
    quotientSmul SA I l X
      = (NecSuf.AlgebraOver.quotientSmul SA.toNecSuf (-1) I l X : QuotientSet SA I) :=
  rfl

theorem quotientZero_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) :
    quotientZero SA I = (NecSuf.AlgebraOver.quotientZero SA.toNecSuf (-1) I : QuotientSet SA I) := rfl

theorem quotientOne_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) :
    quotientOne SA I = (NecSuf.AlgebraOver.quotientOne SA.toNecSuf (-1) I : QuotientSet SA I) := rfl

theorem quotientRing_eq_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) :
    quotientRing hI
      = NecSuf.AlgebraOver.quotientRing ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexCongruenceLaws :=
  rfl

theorem quotientVectorSpace_eq_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) :
    (quotientVectorSpace hI).toNecSuf
      = NecSuf.AlgebraOver.quotientVectorSpace ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
          complexCongruenceLaws complexNegOneComm :=
  rfl

theorem quotientAlgebra_eq_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) :
    (quotientAlgebra hI).toNecSuf
      = NecSuf.AlgebraOver.quotientAlgebra ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
          complexCongruenceLaws complexNegOneComm :=
  rfl

theorem inducedMap_eq_necSuf (SA : ComplexAlgebra A) (I : Set A) (φ : A → B) (X : QuotientSet SA I) :
    inducedMap SA I φ X = NecSuf.AlgebraOver.inducedMap SA.toNecSuf (-1) I φ X := rfl

/-! ### 両側イデアルの主張 -/

theorem generatedIdeal_isTwoSidedIdeal_of_necSuf (SA : ComplexAlgebra A) (X : Set A) :
    IsTwoSidedIdeal SA (generatedIdeal SA X) := by
  rw [isTwoSidedIdeal_iff_necSuf, generatedIdeal_eq_necSuf]
  exact NecSuf.AlgebraOver.generatedIdeal_isTwoSidedIdeal SA.toNecSuf X

theorem subset_generatedIdeal_of_necSuf (SA : ComplexAlgebra A) (X : Set A) :
    X ⊆ generatedIdeal SA X := by
  rw [generatedIdeal_eq_necSuf]
  exact NecSuf.AlgebraOver.subset_generatedIdeal SA.toNecSuf X

theorem generatedIdeal_subset_of_necSuf (SA : ComplexAlgebra A) (X J : Set A)
    (hJ : IsTwoSidedIdeal SA J) (hXJ : X ⊆ J) : generatedIdeal SA X ⊆ J := by
  rw [generatedIdeal_eq_necSuf]
  exact NecSuf.AlgebraOver.generatedIdeal_subset SA.toNecSuf X J
    ((isTwoSidedIdeal_iff_necSuf SA J).1 hJ) hXJ

theorem kernel_isTwoSidedIdeal_of_necSuf {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {φ : A → B}
    (hφ : IsComplexAlgebraHomomorphism SA SB φ) : IsTwoSidedIdeal SA (kernel SB φ) :=
  (isTwoSidedIdeal_iff_necSuf SA _).2
    (NecSuf.AlgebraOver.kernel_isTwoSidedIdeal ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ)
      complexCongruenceLaws.zero_add_zero)

theorem IsTwoSidedIdeal.smul_mem_of_necSuf {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (l : ℂ) (x : A) (hx : x ∈ I) : SA.smul l x ∈ I :=
  NecSuf.AlgebraOver.IsTwoSidedIdeal.smul_mem ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) l x hx

/-! ### 合同・剰余類・射影の主張 -/

theorem congruent_refl_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a : A) : Congruent SA I a a :=
  NecSuf.AlgebraOver.congruent_refl ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws.one_add_n complexCongruenceLaws.zero_add_zero a

theorem congruent_symm_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a b : A) (hab : Congruent SA I a b) : Congruent SA I b a :=
  NecSuf.AlgebraOver.congruent_symm ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws.n_mul_n a b hab

theorem congruent_trans_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a b c : A) (hab : Congruent SA I a b) (hbc : Congruent SA I b c) : Congruent SA I a c :=
  NecSuf.AlgebraOver.congruent_trans ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws.n_add_one complexCongruenceLaws.one_add_n complexCongruenceLaws.zero_add_zero
    a b c hab hbc

theorem residueClass_eq_iff_of_necSuf {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (a b : A) :
    residueClass SA I a = residueClass SA I b ↔ Congruent SA I a b :=
  NecSuf.AlgebraOver.residueClass_eq_iff ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws a b

theorem projection_surjective_of_necSuf (SA : ComplexAlgebra A) (I : Set A) (X : QuotientSet SA I) :
    ∃ a : A, projection SA I a = X :=
  NecSuf.AlgebraOver.projection_surjective SA.toNecSuf (-1) I X

theorem congruent_add_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a a' b b' : A) (ha : Congruent SA I a a') (hb : Congruent SA I b b') :
    Congruent SA I (SA.add a b) (SA.add a' b') :=
  NecSuf.AlgebraOver.congruent_add ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) a a' b b' ha hb

theorem congruent_mul_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a a' b b' : A) (ha : Congruent SA I a a') (hb : Congruent SA I b b') :
    Congruent SA I (SA.mul a b) (SA.mul a' b') :=
  NecSuf.AlgebraOver.congruent_mul ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws.n_add_one complexCongruenceLaws.one_add_n complexCongruenceLaws.zero_add_zero
    a a' b b' ha hb

theorem congruent_smul_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (l : ℂ) (a a' : A) (ha : Congruent SA I a a') :
    Congruent SA I (SA.smul l a) (SA.smul l a') :=
  NecSuf.AlgebraOver.congruent_smul ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexNegOneComm l a a' ha

/-! ### 商代数の主張 -/

theorem projection_add_eq_of_projection_eq_of_necSuf {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (a a' b b' : A) (ha : projection SA I a = projection SA I a')
    (hb : projection SA I b = projection SA I b') :
    projection SA I (SA.add a b) = projection SA I (SA.add a' b') :=
  NecSuf.AlgebraOver.projection_add_eq_of_projection_eq ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws a a' b b' ha hb

theorem projection_mul_eq_of_projection_eq_of_necSuf {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (a a' b b' : A) (ha : projection SA I a = projection SA I a')
    (hb : projection SA I b = projection SA I b') :
    projection SA I (SA.mul a b) = projection SA I (SA.mul a' b') :=
  NecSuf.AlgebraOver.projection_mul_eq_of_projection_eq ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws a a' b b' ha hb

theorem projection_smul_eq_of_projection_eq_of_necSuf {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (l : ℂ) (a a' : A) (ha : projection SA I a = projection SA I a') :
    projection SA I (SA.smul l a) = projection SA I (SA.smul l a') :=
  NecSuf.AlgebraOver.projection_smul_eq_of_projection_eq ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws complexNegOneComm l a a' ha

theorem quotientAdd_eq_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (X Y : QuotientSet SA I) (a b : A) (ha : projection SA I a = X) (hb : projection SA I b = Y) :
    quotientAdd SA I X Y = projection SA I (SA.add a b) :=
  NecSuf.AlgebraOver.quotientAdd_eq ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexCongruenceLaws
    X Y a b ha hb

theorem quotientMul_eq_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (X Y : QuotientSet SA I) (a b : A) (ha : projection SA I a = X) (hb : projection SA I b = Y) :
    quotientMul SA I X Y = projection SA I (SA.mul a b) :=
  NecSuf.AlgebraOver.quotientMul_eq ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexCongruenceLaws
    X Y a b ha hb

theorem quotientSmul_eq_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (l : ℂ) (X : QuotientSet SA I) (a : A) (ha : projection SA I a = X) :
    quotientSmul SA I l X = projection SA I (SA.smul l a) :=
  NecSuf.AlgebraOver.quotientSmul_eq ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexCongruenceLaws
    complexNegOneComm l X a ha

theorem projection_add_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a b : A) :
    projection SA I (SA.add a b) = quotientAdd SA I (projection SA I a) (projection SA I b) :=
  NecSuf.AlgebraOver.projection_add ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexCongruenceLaws a b

theorem projection_mul_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a b : A) :
    projection SA I (SA.mul a b) = quotientMul SA I (projection SA I a) (projection SA I b) :=
  NecSuf.AlgebraOver.projection_mul ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexCongruenceLaws a b

theorem projection_smul_of_necSuf {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (l : ℂ) (a : A) : projection SA I (SA.smul l a) = quotientSmul SA I l (projection SA I a) :=
  NecSuf.AlgebraOver.projection_smul ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexCongruenceLaws
    complexNegOneComm l a

theorem projection_isComplexAlgebraHomomorphism_of_necSuf {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) :
    IsComplexAlgebraHomomorphism SA (quotientAlgebra hI) (projection SA I) := by
  rw [isComplexAlgebraHomomorphism_iff_necSuf, quotientAlgebra_eq_necSuf]
  exact NecSuf.AlgebraOver.projection_isAlgebraHomomorphism ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws complexNegOneComm

theorem projection_eq_zero_of_mem_of_necSuf {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (x : A) (hx : x ∈ I) : projection SA I x = quotientZero SA I :=
  NecSuf.AlgebraOver.projection_eq_zero_of_mem ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws (fun a => MulZeroClass.mul_zero a) x hx

/-! ### 商代数の普遍性の主張 -/

theorem map_eq_of_congruent_of_necSuf {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {I : Set A}
    {φ : A → B} (hφ : IsComplexAlgebraHomomorphism SA SB φ) (hφI : ∀ x ∈ I, φ x = SB.zero)
    (a a' : A) (haa' : Congruent SA I a a') : φ a = φ a' :=
  NecSuf.AlgebraOver.map_eq_of_congruent ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ) hφI
    complexCongruenceLaws.n_add_one complexCongruenceLaws.one_add_n complexCongruenceLaws.zero_add_zero
    a a' haa'

theorem inducedMap_eq_of_necSuf {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {I : Set A} {φ : A → B}
    (hI : IsTwoSidedIdeal SA I) (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (X : QuotientSet SA I) (a : A) (ha : projection SA I a = X) :
    inducedMap SA I φ X = φ a :=
  NecSuf.AlgebraOver.inducedMap_eq ((isTwoSidedIdeal_iff_necSuf SA I).1 hI) complexCongruenceLaws
    ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ) hφI X a ha

theorem inducedMap_projection_of_necSuf {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {I : Set A}
    {φ : A → B} (hI : IsTwoSidedIdeal SA I) (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (a : A) : inducedMap SA I φ (projection SA I a) = φ a :=
  NecSuf.AlgebraOver.inducedMap_projection ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ) hφI a

theorem inducedMap_isComplexAlgebraHomomorphism_of_necSuf {SA : ComplexAlgebra A}
    {SB : ComplexAlgebra B} {I : Set A} {φ : A → B} (hI : IsTwoSidedIdeal SA I)
    (hφ : IsComplexAlgebraHomomorphism SA SB φ) (hφI : ∀ x ∈ I, φ x = SB.zero) :
    IsComplexAlgebraHomomorphism (quotientAlgebra hI) SB (inducedMap SA I φ) := by
  rw [isComplexAlgebraHomomorphism_iff_necSuf, quotientAlgebra_eq_necSuf]
  exact NecSuf.AlgebraOver.inducedMap_isAlgebraHomomorphism ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws complexNegOneComm ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ) hφI

theorem eq_inducedMap_of_comp_eq_of_necSuf {SA : ComplexAlgebra A} {SB : ComplexAlgebra B}
    {I : Set A} {φ : A → B} (hI : IsTwoSidedIdeal SA I) (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (ψ : QuotientSet SA I → B)
    (hψ : IsComplexAlgebraHomomorphism (quotientAlgebra hI) SB ψ)
    (hψφ : ∀ a : A, ψ (projection SA I a) = φ a) (X : QuotientSet SA I) :
    ψ X = inducedMap SA I φ X := by
  have hψ' := (isComplexAlgebraHomomorphism_iff_necSuf _ SB ψ).1 hψ
  rw [quotientAlgebra_eq_necSuf] at hψ'
  exact NecSuf.AlgebraOver.eq_inducedMap_of_comp_eq ((isTwoSidedIdeal_iff_necSuf SA I).1 hI)
    complexCongruenceLaws complexNegOneComm ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ) hφI
    ψ hψ' hψφ X

end CliffordMatrixIsomorphism.ComplexAlgebra

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

variable {V₁ : Type u} {V₂ : Type v}

/-! ### 二つの基底を並べた族が直和の基底であること -/

theorem concatenatedFamily_eq_necSuf (S₁ : ComplexVectorSpace V₁) (S₂ : ComplexVectorSpace V₂) (n : ℕ)
    (b : ℕ → V₁) (b' : ℕ → V₂) :
    concatenatedFamily S₁ S₂ n b b'
      = NecSuf.VectorSpace.concatenatedFamily S₁.toNecSuf S₂.toNecSuf n b b' := rfl

theorem linearCombination_concatenatedFamily_of_necSuf (S₁ : ComplexVectorSpace V₁)
    (S₂ : ComplexVectorSpace V₂) (n n' : ℕ) (b : ℕ → V₁) (b' : ℕ → V₂) (κ : ℕ → ℂ) :
    linearCombination (directSumVectorSpace S₁ S₂) (n + n') κ (concatenatedFamily S₁ S₂ n b b')
      = (linearCombination S₁ n κ b, linearCombination S₂ n' (fun j => κ (n + j)) b') := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_concatenatedFamily S₁.toNecSuf S₂.toNecSuf n n' b b'
    (_root_.add_zero (0 : ℂ)) (fun a => MulZeroClass.mul_zero a) κ

theorem concatenatedFamily_isBasisFamily_of_necSuf (S₁ : ComplexVectorSpace V₁)
    (S₂ : ComplexVectorSpace V₂) (n n' : ℕ) (b : ℕ → V₁) (b' : ℕ → V₂) (hb : IsBasisFamily S₁ n b)
    (hb' : IsBasisFamily S₂ n' b') :
    IsBasisFamily (directSumVectorSpace S₁ S₂) (n + n') (concatenatedFamily S₁ S₂ n b b') := by
  rw [isBasisFamily_iff_necSuf]
  exact NecSuf.VectorSpace.concatenatedFamily_isBasisFamily S₁.toNecSuf S₂.toNecSuf n n' b b'
    (_root_.add_zero (0 : ℂ)) (fun a => MulZeroClass.mul_zero a) ((isBasisFamily_iff_necSuf S₁ n b).1 hb)
    ((isBasisFamily_iff_necSuf S₂ n' b').1 hb')

end CliffordMatrixIsomorphism.ComplexVectorSpace
