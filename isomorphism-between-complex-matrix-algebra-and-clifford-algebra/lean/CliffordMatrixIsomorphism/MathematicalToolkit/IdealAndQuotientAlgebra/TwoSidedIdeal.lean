/-
節「両側イデアルと商代数」のうち、両側イデアルと、部分集合が生成する両側イデアルの具体版。
人手証明と 1 対 1 に対応させる。mathlib の `Ideal`・`TwoSidedIdeal`・`RingCon` を使わない。

  本文のラベル                                                                          このファイル
  def_two_sided_ideal                                                                   IsTwoSidedIdeal
  def_two_sided_ideal_generated_by_subset                                               generatedIdeal（⟨X⟩_A）
  claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal                          generatedIdeal_isTwoSidedIdeal
  claim_two_sided_ideal_generated_by_subset_contains_subset                             subset_generatedIdeal
  claim_two_sided_ideal_generated_by_subset_is_contained_in_every_ideal_containing_subset
                                                                                        generatedIdeal_subset
  claim_kernel_of_algebra_homomorphism_is_two_sided_ideal                               kernel・kernel_isTwoSidedIdeal
  claim_two_sided_ideal_is_closed_under_scalar_multiplication                           IsTwoSidedIdeal.smul_mem

両側イデアルは A の部分集合 `Set A` についての条件である。I の上に演算を制限した組は作らない（本文と同じ）。
本文が ℂ-線型空間の主張を U_vec(A) に当てる行は、`toComplexVectorSpace` に当てた主張を引く行である。
零のスカラー倍が零ベクトルであること（`claim_zero_scalar_multiple_is_zero_vector`）を U_vec(A) に当てた形を
`zero_smul_eq_zero` として置く（式は A の演算で書き、証明は `ComplexVectorSpace.zero_smul_eq_zero` をそのまま引く）。

必要十分版は `NecSuf/MathematicalToolkit/IdealAndQuotientAlgebra/TwoSidedIdeal.lean`、
導出版は `IdealAndQuotientAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.Definitions
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u v

variable {A : Type u} {B : Type v}

/-- 本文 `claim_zero_scalar_multiple_is_zero_vector` を U_vec(A) に当てたもの：0_ℂ ∗_A x = 0_A。 -/
theorem zero_smul_eq_zero (SA : ComplexAlgebra A) (x : A) : SA.smul 0 x = SA.zero :=
  ComplexVectorSpace.zero_smul_eq_zero SA.toComplexVectorSpace x

/-- 本文 `claim_scalar_multiple_of_zero_vector_is_zero_vector` を U_vec(A) に当てたもの：λ ∗_A 0_A = 0_A。 -/
theorem smul_zero_eq_zero (SA : ComplexAlgebra A) (l : ℂ) : SA.smul l SA.zero = SA.zero :=
  ComplexVectorSpace.smul_zero_eq_zero SA.toComplexVectorSpace l

/-- 本文 `def_two_sided_ideal`：0_A を含み、加法で閉じ、A の元を左右から掛けても入る部分集合。
スカラー倍で閉じていること、加法の逆元を含むこと、1_A ∈ I は条件に含めない。 -/
structure IsTwoSidedIdeal (SA : ComplexAlgebra A) (I : Set A) : Prop where
  /-- 加法の単位元を含む -/
  zero_mem : SA.zero ∈ I
  /-- 加法で閉じている -/
  add_mem : ∀ x y : A, x ∈ I → y ∈ I → SA.add x y ∈ I
  /-- A の元を左から掛けても I に入る -/
  mul_mem_left : ∀ a x : A, x ∈ I → SA.mul a x ∈ I
  /-- A の元を右から掛けても I に入る -/
  mul_mem_right : ∀ x a : A, x ∈ I → SA.mul x a ∈ I

/-- 本文 `def_two_sided_ideal_generated_by_subset`：⟨X⟩_A := {a ∈ A : X ⊆ I を満たす A の両側イデアル I のどれについても a ∈ I}。 -/
def generatedIdeal (SA : ComplexAlgebra A) (X : Set A) : Set A :=
  {a : A | ∀ I : Set A, IsTwoSidedIdeal SA I → X ⊆ I → a ∈ I}

/-- 本文 `claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal`：⟨X⟩_A は A の両側イデアル。
四条件のそれぞれを、X を含む任意の両側イデアル I の同じ条件から得る。 -/
theorem generatedIdeal_isTwoSidedIdeal (SA : ComplexAlgebra A) (X : Set A) :
    IsTwoSidedIdeal SA (generatedIdeal SA X) where
  zero_mem := fun _ hI _ => hI.zero_mem
  add_mem x y hx hy := fun I hI hXI => hI.add_mem x y (hx I hI hXI) (hy I hI hXI)
  mul_mem_left a x hx := fun I hI hXI => hI.mul_mem_left a x (hx I hI hXI)
  mul_mem_right x a hx := fun I hI hXI => hI.mul_mem_right x a (hx I hI hXI)

/-- 本文 `claim_two_sided_ideal_generated_by_subset_contains_subset`：X ⊆ ⟨X⟩_A。 -/
theorem subset_generatedIdeal (SA : ComplexAlgebra A) (X : Set A) : X ⊆ generatedIdeal SA X :=
  fun _ hx _ _ hXI => hXI hx

/-- 本文 `claim_two_sided_ideal_generated_by_subset_is_contained_in_every_ideal_containing_subset`：
X ⊆ J を満たす両側イデアル J について ⟨X⟩_A ⊆ J。定義の条件を I := J に当てる。 -/
theorem generatedIdeal_subset (SA : ComplexAlgebra A) (X J : Set A) (hJ : IsTwoSidedIdeal SA J)
    (hXJ : X ⊆ J) : generatedIdeal SA X ⊆ J :=
  fun _ ha => ha J hJ hXJ

/-- 本文 `claim_kernel_of_algebra_homomorphism_is_two_sided_ideal` の K_φ := {x ∈ A : φ(x) = 0_B}。 -/
def kernel (SB : ComplexAlgebra B) (φ : A → B) : Set A := {x : A | φ x = SB.zero}

/-- 本文 `claim_kernel_of_algebra_homomorphism_is_two_sided_ideal`：K_φ は A の両側イデアル。
準備の c ·_B 0_B = 0_B と 0_B ·_B c = 0_B は、本文と同じ三行（零のスカラー倍・両立・零のスカラー倍）で示す。 -/
theorem kernel_isTwoSidedIdeal {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {φ : A → B}
    (hφ : IsComplexAlgebraHomomorphism SA SB φ) : IsTwoSidedIdeal SA (kernel SB φ) := by
  have hmul_zero : ∀ c : B, SB.mul c SB.zero = SB.zero := fun c => calc
    SB.mul c SB.zero = SB.mul c (SB.smul 0 SB.zero) := by rw [zero_smul_eq_zero SB SB.zero]
    _ = SB.smul 0 (SB.mul c SB.zero) := (SB.smul_mul_right 0 c SB.zero).symm
    _ = SB.zero := zero_smul_eq_zero SB (SB.mul c SB.zero)
  have hzero_mul : ∀ c : B, SB.mul SB.zero c = SB.zero := fun c => calc
    SB.mul SB.zero c = SB.mul (SB.smul 0 SB.zero) c := by rw [zero_smul_eq_zero SB SB.zero]
    _ = SB.smul 0 (SB.mul SB.zero c) := (SB.smul_mul_left 0 SB.zero c).symm
    _ = SB.zero := zero_smul_eq_zero SB (SB.mul SB.zero c)
  exact {
    zero_mem := by
      show φ SA.zero = SB.zero
      exact hφ.isLinearMap_underlying.map_zero
    add_mem := by
      intro x y hx hy
      show φ (SA.add x y) = SB.zero
      calc φ (SA.add x y) = SB.add (φ x) (φ y) := hφ.map_add x y
        _ = SB.add SB.zero SB.zero := by rw [show φ x = SB.zero from hx, show φ y = SB.zero from hy]
        _ = SB.zero := SB.add_zero SB.zero
    mul_mem_left := by
      intro a x hx
      show φ (SA.mul a x) = SB.zero
      calc φ (SA.mul a x) = SB.mul (φ a) (φ x) := hφ.map_mul a x
        _ = SB.mul (φ a) SB.zero := by rw [show φ x = SB.zero from hx]
        _ = SB.zero := hmul_zero (φ a)
    mul_mem_right := by
      intro x a hx
      show φ (SA.mul x a) = SB.zero
      calc φ (SA.mul x a) = SB.mul (φ x) (φ a) := hφ.map_mul x a
        _ = SB.mul SB.zero (φ a) := by rw [show φ x = SB.zero from hx]
        _ = SB.zero := hzero_mul (φ a) }

/-- 本文 `claim_two_sided_ideal_is_closed_under_scalar_multiplication`：λ ∗_A x ∈ I（x ∈ I）。
a := λ ∗_A 1_A と置き、λ ∗_A x = a ·_A x を三行で示して、左から掛けて閉じていることを当てる。 -/
theorem IsTwoSidedIdeal.smul_mem {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (l : ℂ) (x : A) (hx : x ∈ I) : SA.smul l x ∈ I := by
  let a : A := SA.smul l SA.one
  have h : SA.smul l x = SA.mul a x := calc
    SA.smul l x = SA.smul l (SA.mul SA.one x) := by rw [SA.one_mul x]
    _ = SA.mul (SA.smul l SA.one) x := SA.smul_mul_left l SA.one x
    _ = SA.mul a x := rfl
  rw [h]
  exact hI.mul_mem_left a x hx

end CliffordMatrixIsomorphism.ComplexAlgebra
