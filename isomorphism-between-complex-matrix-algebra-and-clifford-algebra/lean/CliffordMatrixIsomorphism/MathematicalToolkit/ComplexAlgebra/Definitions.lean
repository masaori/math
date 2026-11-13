/-
節「ℂ-代数」の定義の具体版。mathlib の `Algebra`・`AlgHom`・`Subalgebra` を使わず、
本文の組 (A, +_A, ·_A, ∗_A, 0_A, 1_A) のとおりに structure と def で書く。

  本文のラベル                                       このファイル
  def_complex_algebra                                ComplexAlgebra・ComplexAlgebra.toComplexVectorSpace
  def_complex_algebra_homomorphism                   IsComplexAlgebraHomomorphism と、書き出した四つの条件
                                                     （map_add・map_mul・map_one・map_smul）
  def_underlying_ring_and_vector_space_of_algebra    underlyingRing（U_ring(A)）・underlyingVectorSpace（U_vec(A)）・
                                                     IsComplexAlgebraHomomorphism.isRingHomomorphism_underlying・
                                                     IsComplexAlgebraHomomorphism.isLinearMap_underlying
  def_ordered_product_in_algebra                     partialOrderedProduct（Π_m）・orderedProduct（Π_n）
  def_subalgebra                                     IsSubalgebra
  def_subset_generates_algebra                       GeneratesAlgebra

本文の一つ目の条件「(A, +_A, ·_A, 0_A, 1_A) は単位元をもつ環」は、`ComplexAlgebra` が `UnitalRing` の欄を
そのまま持つこと（`extends UnitalRing A`）で書く。二つ目の条件「(A, +_A, ∗_A, 0_A) は ℂ-線型空間」の八つの公理のうち、
加法の四つ（結合法則・交換法則・単位元・逆元）は環の加法の四つと同じ式なので重ねて置かず、スカラー倍の四つだけを欄に足す。
二つ目の条件の組は `toComplexVectorSpace` で作る。

番号付けた族 x:{1,…,n}→A は `ℕ → A` で表し、1,…,n の外の値は使わない（`ComplexVectorSpace/Definitions.lean` の約束）。

必要十分版は `NecSuf/MathematicalToolkit/ComplexAlgebra/Definitions.lean`、導出版は `ComplexAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.Ring.UnitalRing
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism

universe u v

/-- 本文 `def_complex_algebra`：ℂ-代数 (A, +_A, ·_A, ∗_A, 0_A, 1_A)。乗法の交換法則は仮定しない。 -/
structure ComplexAlgebra (A : Type u) extends UnitalRing A where
  smul : ℂ → A → A
  /-- スカラー倍の結合法則（二つ目の条件） -/
  smul_assoc : ∀ (l m : ℂ) (x : A), smul (l * m) x = smul l (smul m x)
  /-- スカラー倍の単位元（二つ目の条件） -/
  one_smul : ∀ x : A, smul 1 x = x
  /-- ベクトルの加法についての分配法則（二つ目の条件） -/
  smul_add : ∀ (l : ℂ) (x y : A), smul l (add x y) = add (smul l x) (smul l y)
  /-- スカラーの加法についての分配法則（二つ目の条件） -/
  add_smul : ∀ (l m : ℂ) (x : A), smul (l + m) x = add (smul l x) (smul m x)
  /-- スカラー倍と乗法の両立、左の因子 -/
  smul_mul_left : ∀ (l : ℂ) (x y : A), smul l (mul x y) = mul (smul l x) y
  /-- スカラー倍と乗法の両立、右の因子 -/
  smul_mul_right : ∀ (l : ℂ) (x y : A), smul l (mul x y) = mul x (smul l y)

namespace ComplexAlgebra

variable {A : Type u} {B : Type v}

/-- 本文 `def_complex_algebra` の二つ目の条件の組 (A, +_A, ∗_A, 0_A)。 -/
def toComplexVectorSpace (SA : ComplexAlgebra A) : ComplexVectorSpace A where
  add := SA.add
  smul := SA.smul
  zero := SA.zero
  add_assoc := SA.add_assoc
  add_comm := SA.add_comm
  add_zero := SA.add_zero
  exists_add_inverse := SA.exists_add_inverse
  smul_assoc := SA.smul_assoc
  one_smul := SA.one_smul
  smul_add := SA.smul_add
  add_smul := SA.add_smul

/-- 本文 `def_complex_algebra_homomorphism`：環の組の間の環の準同型で、かつ線型空間の組の間の線型写像であるもの。 -/
structure IsComplexAlgebraHomomorphism (SA : ComplexAlgebra A) (SB : ComplexAlgebra B) (φ : A → B) :
    Prop where
  isRingHomomorphism : IsRingHomomorphism SA.toUnitalRing SB.toUnitalRing φ
  isLinearMap : ComplexVectorSpace.IsComplexLinearMap SA.toComplexVectorSpace SB.toComplexVectorSpace φ

namespace IsComplexAlgebraHomomorphism

variable {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {φ : A → B}

/-- 本文 `def_complex_algebra_homomorphism` を書き出した条件：加法を保つ。 -/
theorem map_add (h : IsComplexAlgebraHomomorphism SA SB φ) (x y : A) :
    φ (SA.add x y) = SB.add (φ x) (φ y) :=
  h.isRingHomomorphism.map_add x y

/-- 本文 `def_complex_algebra_homomorphism` を書き出した条件：乗法を保つ。 -/
theorem map_mul (h : IsComplexAlgebraHomomorphism SA SB φ) (x y : A) :
    φ (SA.mul x y) = SB.mul (φ x) (φ y) :=
  h.isRingHomomorphism.map_mul x y

/-- 本文 `def_complex_algebra_homomorphism` を書き出した条件：乗法の単位元を保つ。 -/
theorem map_one (h : IsComplexAlgebraHomomorphism SA SB φ) : φ SA.one = SB.one :=
  h.isRingHomomorphism.map_one

/-- 本文 `def_complex_algebra_homomorphism` を書き出した条件：スカラー倍を保つ。 -/
theorem map_smul (h : IsComplexAlgebraHomomorphism SA SB φ) (l : ℂ) (x : A) :
    φ (SA.smul l x) = SB.smul l (φ x) :=
  h.isLinearMap.map_smul l x

end IsComplexAlgebraHomomorphism

/-- 本文 `def_underlying_ring_and_vector_space_of_algebra`：U_ring(A) := (A, +_A, ·_A, 0_A, 1_A)。 -/
def underlyingRing (SA : ComplexAlgebra A) : UnitalRing A := SA.toUnitalRing

/-- 本文 `def_underlying_ring_and_vector_space_of_algebra`：U_vec(A) := (A, +_A, ∗_A, 0_A)。 -/
def underlyingVectorSpace (SA : ComplexAlgebra A) : ComplexVectorSpace A := SA.toComplexVectorSpace

/-- 本文 `def_underlying_ring_and_vector_space_of_algebra`：ℂ-代数の準同型は U_ring(A) から U_ring(B) への環の準同型。 -/
theorem IsComplexAlgebraHomomorphism.isRingHomomorphism_underlying {SA : ComplexAlgebra A}
    {SB : ComplexAlgebra B} {φ : A → B} (h : IsComplexAlgebraHomomorphism SA SB φ) :
    IsRingHomomorphism (underlyingRing SA) (underlyingRing SB) φ :=
  h.isRingHomomorphism

/-- 本文 `def_underlying_ring_and_vector_space_of_algebra`：ℂ-代数の準同型は U_vec(A) から U_vec(B) への線型写像。 -/
theorem IsComplexAlgebraHomomorphism.isLinearMap_underlying {SA : ComplexAlgebra A}
    {SB : ComplexAlgebra B} {φ : A → B} (h : IsComplexAlgebraHomomorphism SA SB φ) :
    ComplexVectorSpace.IsComplexLinearMap (underlyingVectorSpace SA) (underlyingVectorSpace SB) φ :=
  h.isLinearMap

/-- 本文 `def_ordered_product_in_algebra` の Π_m：Π_0 = 1_A、Π_m = Π_{m-1} ·_A x_m。 -/
def partialOrderedProduct (SA : ComplexAlgebra A) (x : ℕ → A) : ℕ → A
  | 0 => SA.one
  | m + 1 => SA.mul (partialOrderedProduct SA x m) (x (m + 1))

/-- 本文 `def_ordered_product_in_algebra`：∏_{A,k=1}^{n} x_k := Π_n。 -/
def orderedProduct (SA : ComplexAlgebra A) (n : ℕ) (x : ℕ → A) : A :=
  partialOrderedProduct SA x n

/-- 本文 `def_subalgebra`：1_A を含み、加法・乗法・スカラー倍で閉じた部分集合。0_A を含むことは条件に含めない。 -/
structure IsSubalgebra (SA : ComplexAlgebra A) (S : Set A) : Prop where
  /-- 乗法の単位元を含む -/
  one_mem : SA.one ∈ S
  /-- 加法で閉じている -/
  add_mem : ∀ x y : A, x ∈ S → y ∈ S → SA.add x y ∈ S
  /-- 乗法で閉じている -/
  mul_mem : ∀ x y : A, x ∈ S → y ∈ S → SA.mul x y ∈ S
  /-- スカラー倍で閉じている -/
  smul_mem : ∀ (l : ℂ) (x : A), x ∈ S → SA.smul l x ∈ S

/-- 本文 `def_subset_generates_algebra`：X を含む部分代数は、どれも A 全体である。 -/
def GeneratesAlgebra (SA : ComplexAlgebra A) (X : Set A) : Prop :=
  ∀ S : Set A, IsSubalgebra SA S → X ⊆ S → S = Set.univ

end ComplexAlgebra

end CliffordMatrixIsomorphism
