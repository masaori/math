/-
節「両側イデアルと商代数」のうち、両側イデアルと、部分集合が生成する両側イデアルの必要十分版。
具体版 `MathematicalToolkit/IdealAndQuotientAlgebra/TwoSidedIdeal.lean` と同じ structure・def・calc の行で、
係数 ℂ を型の変数 K に替えて書く。

各主張が実際に使う K の性質:

  generatedIdeal_isTwoSidedIdeal・subset_generatedIdeal・generatedIdeal_subset
                                     使わない（両側イデアルの定義に K は現れない）
  kernel_isTwoSidedIdeal             0 + 0 = 0 だけ（零のスカラー倍が零ベクトルであることを、
                                     B の c · 0 = 0・0 · c = 0 と φ(0_A) = 0_B の三か所で使う）
  IsTwoSidedIdeal.smul_mem           使わない（使うのは A の 1_A · x = x と、スカラー倍と乗法の両立だけ）
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Definitions
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u v uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A : Type u} {B : Type v}

/-- 本文 `claim_zero_scalar_multiple_is_zero_vector` を U_vec(A) に当てたものの必要十分版。 -/
theorem zero_smul_eq_zero [Zero K] (SA : AlgebraOver K A) (h00 : (0 : K) + 0 = 0) (x : A) :
    SA.smul 0 x = SA.zero :=
  VectorSpace.zero_smul_eq_zero SA.toVectorSpace h00 x

/-- 本文 `claim_scalar_multiple_of_zero_vector_is_zero_vector` を U_vec(A) に当てたものの必要十分版。 -/
theorem smul_zero_eq_zero [Zero K] (SA : AlgebraOver K A) (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) (l : K) : SA.smul l SA.zero = SA.zero :=
  VectorSpace.smul_zero_eq_zero SA.toVectorSpace h00 hmul0 l

/-- 本文 `def_two_sided_ideal` の必要十分版。 -/
structure IsTwoSidedIdeal (SA : AlgebraOver K A) (I : Set A) : Prop where
  zero_mem : SA.zero ∈ I
  add_mem : ∀ x y : A, x ∈ I → y ∈ I → SA.add x y ∈ I
  mul_mem_left : ∀ a x : A, x ∈ I → SA.mul a x ∈ I
  mul_mem_right : ∀ x a : A, x ∈ I → SA.mul x a ∈ I

/-- 本文 `def_two_sided_ideal_generated_by_subset` の必要十分版。 -/
def generatedIdeal (SA : AlgebraOver K A) (X : Set A) : Set A :=
  {a : A | ∀ I : Set A, IsTwoSidedIdeal SA I → X ⊆ I → a ∈ I}

/-- 本文 `claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal` の必要十分版。 -/
theorem generatedIdeal_isTwoSidedIdeal (SA : AlgebraOver K A) (X : Set A) :
    IsTwoSidedIdeal SA (generatedIdeal SA X) where
  zero_mem := fun _ hI _ => hI.zero_mem
  add_mem x y hx hy := fun I hI hXI => hI.add_mem x y (hx I hI hXI) (hy I hI hXI)
  mul_mem_left a x hx := fun I hI hXI => hI.mul_mem_left a x (hx I hI hXI)
  mul_mem_right x a hx := fun I hI hXI => hI.mul_mem_right x a (hx I hI hXI)

/-- 本文 `claim_two_sided_ideal_generated_by_subset_contains_subset` の必要十分版。 -/
theorem subset_generatedIdeal (SA : AlgebraOver K A) (X : Set A) : X ⊆ generatedIdeal SA X :=
  fun _ hx _ _ hXI => hXI hx

/-- 本文 `claim_two_sided_ideal_generated_by_subset_is_contained_in_every_ideal_containing_subset` の必要十分版。 -/
theorem generatedIdeal_subset (SA : AlgebraOver K A) (X J : Set A) (hJ : IsTwoSidedIdeal SA J)
    (hXJ : X ⊆ J) : generatedIdeal SA X ⊆ J :=
  fun _ ha => ha J hJ hXJ

/-- 本文 `claim_kernel_of_algebra_homomorphism_is_two_sided_ideal` の K_φ。 -/
def kernel (SB : AlgebraOver K B) (φ : A → B) : Set A := {x : A | φ x = SB.zero}

/-- 本文 `claim_kernel_of_algebra_homomorphism_is_two_sided_ideal` の必要十分版。 -/
theorem kernel_isTwoSidedIdeal [Zero K] {SA : AlgebraOver K A} {SB : AlgebraOver K B} {φ : A → B}
    (hφ : IsAlgebraHomomorphism SA SB φ) (h00 : (0 : K) + 0 = 0) :
    IsTwoSidedIdeal SA (kernel SB φ) := by
  have hmul_zero : ∀ c : B, SB.mul c SB.zero = SB.zero := fun c => calc
    SB.mul c SB.zero = SB.mul c (SB.smul 0 SB.zero) := by rw [zero_smul_eq_zero SB h00 SB.zero]
    _ = SB.smul 0 (SB.mul c SB.zero) := (SB.smul_mul_right 0 c SB.zero).symm
    _ = SB.zero := zero_smul_eq_zero SB h00 (SB.mul c SB.zero)
  have hzero_mul : ∀ c : B, SB.mul SB.zero c = SB.zero := fun c => calc
    SB.mul SB.zero c = SB.mul (SB.smul 0 SB.zero) c := by rw [zero_smul_eq_zero SB h00 SB.zero]
    _ = SB.smul 0 (SB.mul SB.zero c) := (SB.smul_mul_left 0 SB.zero c).symm
    _ = SB.zero := zero_smul_eq_zero SB h00 (SB.mul SB.zero c)
  exact {
    zero_mem := by
      show φ SA.zero = SB.zero
      exact hφ.isLinearMap_underlying.map_zero h00
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

/-- 本文 `claim_two_sided_ideal_is_closed_under_scalar_multiplication` の必要十分版。K の性質を使わない。 -/
theorem IsTwoSidedIdeal.smul_mem {SA : AlgebraOver K A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (l : K) (x : A) (hx : x ∈ I) : SA.smul l x ∈ I := by
  let a : A := SA.smul l SA.one
  have h : SA.smul l x = SA.mul a x := calc
    SA.smul l x = SA.smul l (SA.mul SA.one x) := by rw [SA.one_mul x]
    _ = SA.mul (SA.smul l SA.one) x := SA.smul_mul_left l SA.one x
    _ = SA.mul a x := rfl
  rw [h]
  exact hI.mul_mem_left a x hx

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver
