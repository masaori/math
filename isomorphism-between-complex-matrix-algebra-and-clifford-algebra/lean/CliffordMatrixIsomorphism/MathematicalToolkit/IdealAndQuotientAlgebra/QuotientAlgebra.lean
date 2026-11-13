/-
節「両側イデアルと商代数」のうち、商集合の上の演算と、それが ℂ-代数をなすこと（商代数）、射影が準同型であることの具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                                              このファイル
  claim_quotient_addition_does_not_depend_on_representatives                projection_add_eq_of_projection_eq
  claim_quotient_multiplication_does_not_depend_on_representatives          projection_mul_eq_of_projection_eq
  claim_quotient_scalar_multiplication_does_not_depend_on_representatives   projection_smul_eq_of_projection_eq
  def_quotient_algebra_operations                                           quotientAdd・quotientMul・quotientSmul・
                                                                            quotientZero・quotientOne と、
                                                                            代表のとり方によらないこと quotientAdd_eq・
                                                                            quotientMul_eq・quotientSmul_eq
  claim_projection_onto_quotient_set_preserves_addition                     projection_add
  claim_projection_onto_quotient_set_preserves_multiplication               projection_mul
  claim_projection_onto_quotient_set_preserves_scalar_multiplication        projection_smul
  claim_quotient_set_operations_form_unital_ring                            quotientRing
  claim_quotient_set_operations_form_complex_vector_space                   quotientVectorSpace
  claim_quotient_algebra_is_complex_algebra                                 quotientAlgebra
  claim_projection_onto_quotient_algebra_is_algebra_homomorphism            projection_isComplexAlgebraHomomorphism
  claim_projection_onto_quotient_set_sends_ideal_elements_to_zero           projection_eq_zero_of_mem

本文の演算の定義は「射影の全射性で π_I(a) = X、π_I(b) = Y となる a, b をとり、X +_{A/I} Y := π_I(a +_A b)」である。
Lean では代表 `rep X` を全射性の証明から `Classical.choose` で一つ選んで定め、本文の定義の後半
「右辺は代表のとり方によらない」を、任意の代表 a, b で開いてよいこと（`quotientAdd_eq` 等）として示す。
演算を定めること自体は I が両側イデアルであることを使わない。代表によらないことは使う。

必要十分版は `NecSuf/MathematicalToolkit/IdealAndQuotientAlgebra/QuotientAlgebra.lean`、
導出版は `IdealAndQuotientAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.IdealAndQuotientAlgebra.Congruence

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u

variable {A : Type u}

/-- 本文の「[a]_I = π_I(a) = π_I(a') = [a']_I」の三行（π_I の値が剰余類であることを両端で使う）。 -/
theorem residueClass_eq_of_projection_eq {SA : ComplexAlgebra A} {I : Set A} {a a' : A}
    (h : projection SA I a = projection SA I a') : residueClass SA I a = residueClass SA I a' := calc
  residueClass SA I a = (projection SA I a).1 := rfl
  _ = (projection SA I a').1 := by rw [h]
  _ = residueClass SA I a' := rfl

/-- 本文の「π_I(a) = [a]_I = [a']_I = π_I(a')」の三行。 -/
theorem projection_eq_of_residueClass_eq {SA : ComplexAlgebra A} {I : Set A} {a a' : A}
    (h : residueClass SA I a = residueClass SA I a') : projection SA I a = projection SA I a' :=
  Subtype.ext (calc
    (projection SA I a).1 = residueClass SA I a := rfl
    _ = residueClass SA I a' := h
    _ = (projection SA I a').1 := rfl)

/-- 本文 `claim_quotient_addition_does_not_depend_on_representatives`：
π_I(a) = π_I(a') かつ π_I(b) = π_I(b') ならば π_I(a +_A b) = π_I(a' +_A b')。 -/
theorem projection_add_eq_of_projection_eq {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (a a' b b' : A) (ha : projection SA I a = projection SA I a')
    (hb : projection SA I b = projection SA I b') :
    projection SA I (SA.add a b) = projection SA I (SA.add a' b') := by
  have hca : Congruent SA I a a' := (residueClass_eq_iff hI a a').1 (residueClass_eq_of_projection_eq ha)
  have hcb : Congruent SA I b b' := (residueClass_eq_iff hI b b').1 (residueClass_eq_of_projection_eq hb)
  have hab : residueClass SA I (SA.add a b) = residueClass SA I (SA.add a' b') :=
    (residueClass_eq_iff hI (SA.add a b) (SA.add a' b')).2 (congruent_add hI a a' b b' hca hcb)
  exact projection_eq_of_residueClass_eq hab

/-- 本文 `claim_quotient_multiplication_does_not_depend_on_representatives`：
π_I(a) = π_I(a') かつ π_I(b) = π_I(b') ならば π_I(a ·_A b) = π_I(a' ·_A b')。 -/
theorem projection_mul_eq_of_projection_eq {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (a a' b b' : A) (ha : projection SA I a = projection SA I a')
    (hb : projection SA I b = projection SA I b') :
    projection SA I (SA.mul a b) = projection SA I (SA.mul a' b') := by
  have hca : Congruent SA I a a' := (residueClass_eq_iff hI a a').1 (residueClass_eq_of_projection_eq ha)
  have hcb : Congruent SA I b b' := (residueClass_eq_iff hI b b').1 (residueClass_eq_of_projection_eq hb)
  have hab : residueClass SA I (SA.mul a b) = residueClass SA I (SA.mul a' b') :=
    (residueClass_eq_iff hI (SA.mul a b) (SA.mul a' b')).2 (congruent_mul hI a a' b b' hca hcb)
  exact projection_eq_of_residueClass_eq hab

/-- 本文 `claim_quotient_scalar_multiplication_does_not_depend_on_representatives`：
π_I(a) = π_I(a') ならば π_I(λ ∗_A a) = π_I(λ ∗_A a')。 -/
theorem projection_smul_eq_of_projection_eq {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (l : ℂ) (a a' : A) (ha : projection SA I a = projection SA I a') :
    projection SA I (SA.smul l a) = projection SA I (SA.smul l a') := by
  have hca : Congruent SA I a a' := (residueClass_eq_iff hI a a').1 (residueClass_eq_of_projection_eq ha)
  have hla : residueClass SA I (SA.smul l a) = residueClass SA I (SA.smul l a') :=
    (residueClass_eq_iff hI (SA.smul l a) (SA.smul l a')).2 (congruent_smul hI l a a' hca)
  exact projection_eq_of_residueClass_eq hla

/-- 本文 `def_quotient_algebra_operations` で代表をとる操作：π_I(a) = X となる a を全射性から一つ選ぶ。 -/
noncomputable def rep {SA : ComplexAlgebra A} {I : Set A} (X : QuotientSet SA I) : A :=
  Classical.choose (projection_surjective SA I X)

theorem projection_rep {SA : ComplexAlgebra A} {I : Set A} (X : QuotientSet SA I) :
    projection SA I (rep X) = X :=
  Classical.choose_spec (projection_surjective SA I X)

/-- 本文 `def_quotient_algebra_operations`：X +_{A/I} Y := π_I(a +_A b)。 -/
noncomputable def quotientAdd (SA : ComplexAlgebra A) (I : Set A) (X Y : QuotientSet SA I) :
    QuotientSet SA I :=
  projection SA I (SA.add (rep X) (rep Y))

/-- 本文 `def_quotient_algebra_operations`：X ·_{A/I} Y := π_I(a ·_A b)。 -/
noncomputable def quotientMul (SA : ComplexAlgebra A) (I : Set A) (X Y : QuotientSet SA I) :
    QuotientSet SA I :=
  projection SA I (SA.mul (rep X) (rep Y))

/-- 本文 `def_quotient_algebra_operations`：λ ∗_{A/I} X := π_I(λ ∗_A a)。 -/
noncomputable def quotientSmul (SA : ComplexAlgebra A) (I : Set A) (l : ℂ) (X : QuotientSet SA I) :
    QuotientSet SA I :=
  projection SA I (SA.smul l (rep X))

/-- 本文 `def_quotient_algebra_operations`：0_{A/I} := π_I(0_A)。 -/
def quotientZero (SA : ComplexAlgebra A) (I : Set A) : QuotientSet SA I := projection SA I SA.zero

/-- 本文 `def_quotient_algebra_operations`：1_{A/I} := π_I(1_A)。 -/
def quotientOne (SA : ComplexAlgebra A) (I : Set A) : QuotientSet SA I := projection SA I SA.one

/-- 本文 `def_quotient_algebra_operations` の後半：加法の右辺は代表のとり方によらない
（`claim_quotient_addition_does_not_depend_on_representatives` を、選んだ代表と a, b に当てる）。 -/
theorem quotientAdd_eq {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (X Y : QuotientSet SA I) (a b : A) (ha : projection SA I a = X) (hb : projection SA I b = Y) :
    quotientAdd SA I X Y = projection SA I (SA.add a b) :=
  projection_add_eq_of_projection_eq hI (rep X) a (rep Y) b
    ((projection_rep X).trans ha.symm) ((projection_rep Y).trans hb.symm)

/-- 本文 `def_quotient_algebra_operations` の後半：乗法の右辺は代表のとり方によらない。 -/
theorem quotientMul_eq {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (X Y : QuotientSet SA I) (a b : A) (ha : projection SA I a = X) (hb : projection SA I b = Y) :
    quotientMul SA I X Y = projection SA I (SA.mul a b) :=
  projection_mul_eq_of_projection_eq hI (rep X) a (rep Y) b
    ((projection_rep X).trans ha.symm) ((projection_rep Y).trans hb.symm)

/-- 本文 `def_quotient_algebra_operations` の後半：スカラー倍の右辺は代表のとり方によらない。 -/
theorem quotientSmul_eq {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) (l : ℂ)
    (X : QuotientSet SA I) (a : A) (ha : projection SA I a = X) :
    quotientSmul SA I l X = projection SA I (SA.smul l a) :=
  projection_smul_eq_of_projection_eq hI l (rep X) a ((projection_rep X).trans ha.symm)

/-- 本文 `claim_projection_onto_quotient_set_preserves_addition`：π_I(a +_A b) = π_I(a) +_{A/I} π_I(b)。
X := π_I(a)、Y := π_I(b) の代表に a, b 自身をとる。 -/
theorem projection_add {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) (a b : A) :
    projection SA I (SA.add a b) = quotientAdd SA I (projection SA I a) (projection SA I b) :=
  (quotientAdd_eq hI (projection SA I a) (projection SA I b) a b rfl rfl).symm

/-- 本文 `claim_projection_onto_quotient_set_preserves_multiplication`：π_I(a ·_A b) = π_I(a) ·_{A/I} π_I(b)。 -/
theorem projection_mul {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) (a b : A) :
    projection SA I (SA.mul a b) = quotientMul SA I (projection SA I a) (projection SA I b) :=
  (quotientMul_eq hI (projection SA I a) (projection SA I b) a b rfl rfl).symm

/-- 本文 `claim_projection_onto_quotient_set_preserves_scalar_multiplication`：π_I(λ ∗_A a) = λ ∗_{A/I} π_I(a)。 -/
theorem projection_smul {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) (l : ℂ)
    (a : A) : projection SA I (SA.smul l a) = quotientSmul SA I l (projection SA I a) :=
  (quotientSmul_eq hI l (projection SA I a) a rfl).symm

/-- 本文 `claim_quotient_set_operations_form_unital_ring`：(A/I, +_{A/I}, ·_{A/I}, 0_{A/I}, 1_{A/I}) は単位元をもつ環。
各条件は、X, Y, Z の代表 a, b, c を全射性でとり、射影が演算を保つことで A の同じ条件へ移す。 -/
noncomputable def quotientRing {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) :
    UnitalRing (QuotientSet SA I) where
  add := quotientAdd SA I
  mul := quotientMul SA I
  zero := quotientZero SA I
  one := quotientOne SA I
  add_assoc X Y Z := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    obtain ⟨c, rfl⟩ := projection_surjective SA I Z
    calc quotientAdd SA I (quotientAdd SA I (projection SA I a) (projection SA I b)) (projection SA I c)
        = quotientAdd SA I (projection SA I (SA.add a b)) (projection SA I c) := by
          rw [projection_add hI a b]
      _ = projection SA I (SA.add (SA.add a b) c) := by rw [projection_add hI (SA.add a b) c]
      _ = projection SA I (SA.add a (SA.add b c)) := by rw [SA.add_assoc a b c]
      _ = quotientAdd SA I (projection SA I a) (projection SA I (SA.add b c)) :=
          projection_add hI a (SA.add b c)
      _ = quotientAdd SA I (projection SA I a) (quotientAdd SA I (projection SA I b) (projection SA I c)) := by
          rw [projection_add hI b c]
  add_comm X Y := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    calc quotientAdd SA I (projection SA I a) (projection SA I b)
        = projection SA I (SA.add a b) := (projection_add hI a b).symm
      _ = projection SA I (SA.add b a) := by rw [SA.add_comm a b]
      _ = quotientAdd SA I (projection SA I b) (projection SA I a) := projection_add hI b a
  add_zero X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    calc quotientAdd SA I (projection SA I a) (quotientZero SA I)
        = quotientAdd SA I (projection SA I a) (projection SA I SA.zero) := rfl
      _ = projection SA I (SA.add a SA.zero) := (projection_add hI a SA.zero).symm
      _ = projection SA I a := by rw [SA.add_zero a]
  exists_add_inverse X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨a', ha'⟩ := SA.exists_add_inverse a
    refine ⟨projection SA I a', ?_⟩
    calc quotientAdd SA I (projection SA I a) (projection SA I a')
        = projection SA I (SA.add a a') := (projection_add hI a a').symm
      _ = projection SA I SA.zero := by rw [ha']
      _ = quotientZero SA I := rfl
  mul_assoc X Y Z := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    obtain ⟨c, rfl⟩ := projection_surjective SA I Z
    calc quotientMul SA I (quotientMul SA I (projection SA I a) (projection SA I b)) (projection SA I c)
        = quotientMul SA I (projection SA I (SA.mul a b)) (projection SA I c) := by
          rw [projection_mul hI a b]
      _ = projection SA I (SA.mul (SA.mul a b) c) := by rw [projection_mul hI (SA.mul a b) c]
      _ = projection SA I (SA.mul a (SA.mul b c)) := by rw [SA.mul_assoc a b c]
      _ = quotientMul SA I (projection SA I a) (projection SA I (SA.mul b c)) :=
          projection_mul hI a (SA.mul b c)
      _ = quotientMul SA I (projection SA I a) (quotientMul SA I (projection SA I b) (projection SA I c)) := by
          rw [projection_mul hI b c]
  mul_one X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    calc quotientMul SA I (projection SA I a) (quotientOne SA I)
        = quotientMul SA I (projection SA I a) (projection SA I SA.one) := rfl
      _ = projection SA I (SA.mul a SA.one) := (projection_mul hI a SA.one).symm
      _ = projection SA I a := by rw [SA.mul_one a]
  one_mul X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    calc quotientMul SA I (quotientOne SA I) (projection SA I a)
        = quotientMul SA I (projection SA I SA.one) (projection SA I a) := rfl
      _ = projection SA I (SA.mul SA.one a) := (projection_mul hI SA.one a).symm
      _ = projection SA I a := by rw [SA.one_mul a]
  left_distrib X Y Z := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    obtain ⟨c, rfl⟩ := projection_surjective SA I Z
    calc quotientMul SA I (projection SA I a) (quotientAdd SA I (projection SA I b) (projection SA I c))
        = quotientMul SA I (projection SA I a) (projection SA I (SA.add b c)) := by
          rw [projection_add hI b c]
      _ = projection SA I (SA.mul a (SA.add b c)) := (projection_mul hI a (SA.add b c)).symm
      _ = projection SA I (SA.add (SA.mul a b) (SA.mul a c)) := by rw [SA.left_distrib a b c]
      _ = quotientAdd SA I (projection SA I (SA.mul a b)) (projection SA I (SA.mul a c)) :=
          projection_add hI (SA.mul a b) (SA.mul a c)
      _ = quotientAdd SA I (quotientMul SA I (projection SA I a) (projection SA I b))
            (quotientMul SA I (projection SA I a) (projection SA I c)) := by
          rw [projection_mul hI a b, projection_mul hI a c]
  right_distrib X Y Z := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    obtain ⟨c, rfl⟩ := projection_surjective SA I Z
    calc quotientMul SA I (quotientAdd SA I (projection SA I a) (projection SA I b)) (projection SA I c)
        = quotientMul SA I (projection SA I (SA.add a b)) (projection SA I c) := by
          rw [projection_add hI a b]
      _ = projection SA I (SA.mul (SA.add a b) c) := (projection_mul hI (SA.add a b) c).symm
      _ = projection SA I (SA.add (SA.mul a c) (SA.mul b c)) := by rw [SA.right_distrib a b c]
      _ = quotientAdd SA I (projection SA I (SA.mul a c)) (projection SA I (SA.mul b c)) :=
          projection_add hI (SA.mul a c) (SA.mul b c)
      _ = quotientAdd SA I (quotientMul SA I (projection SA I a) (projection SA I c))
            (quotientMul SA I (projection SA I b) (projection SA I c)) := by
          rw [projection_mul hI a c, projection_mul hI b c]

/-- 本文 `claim_quotient_set_operations_form_complex_vector_space`：(A/I, +_{A/I}, ∗_{A/I}, 0_{A/I}) は ℂ-線型空間。
加法の四条件は環の同じ四条件（`quotientRing`）、スカラー倍の四条件は代表に移して U_vec(A) の同じ条件を当てる。 -/
noncomputable def quotientVectorSpace {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) : ComplexVectorSpace (QuotientSet SA I) where
  add := quotientAdd SA I
  smul := quotientSmul SA I
  zero := quotientZero SA I
  add_assoc := (quotientRing hI).add_assoc
  add_comm := (quotientRing hI).add_comm
  add_zero := (quotientRing hI).add_zero
  exists_add_inverse := (quotientRing hI).exists_add_inverse
  smul_assoc l m X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    calc quotientSmul SA I (l * m) (projection SA I a)
        = projection SA I (SA.smul (l * m) a) := (projection_smul hI (l * m) a).symm
      _ = projection SA I (SA.smul l (SA.smul m a)) := by rw [SA.smul_assoc l m a]
      _ = quotientSmul SA I l (projection SA I (SA.smul m a)) := projection_smul hI l (SA.smul m a)
      _ = quotientSmul SA I l (quotientSmul SA I m (projection SA I a)) := by
          rw [projection_smul hI m a]
  one_smul X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    calc quotientSmul SA I 1 (projection SA I a)
        = projection SA I (SA.smul 1 a) := (projection_smul hI 1 a).symm
      _ = projection SA I a := by rw [SA.one_smul a]
  smul_add l X Y := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    calc quotientSmul SA I l (quotientAdd SA I (projection SA I a) (projection SA I b))
        = quotientSmul SA I l (projection SA I (SA.add a b)) := by rw [projection_add hI a b]
      _ = projection SA I (SA.smul l (SA.add a b)) := (projection_smul hI l (SA.add a b)).symm
      _ = projection SA I (SA.add (SA.smul l a) (SA.smul l b)) := by rw [SA.smul_add l a b]
      _ = quotientAdd SA I (projection SA I (SA.smul l a)) (projection SA I (SA.smul l b)) :=
          projection_add hI (SA.smul l a) (SA.smul l b)
      _ = quotientAdd SA I (quotientSmul SA I l (projection SA I a))
            (quotientSmul SA I l (projection SA I b)) := by
          rw [projection_smul hI l a, projection_smul hI l b]
  add_smul l m X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    calc quotientSmul SA I (l + m) (projection SA I a)
        = projection SA I (SA.smul (l + m) a) := (projection_smul hI (l + m) a).symm
      _ = projection SA I (SA.add (SA.smul l a) (SA.smul m a)) := by rw [SA.add_smul l m a]
      _ = quotientAdd SA I (projection SA I (SA.smul l a)) (projection SA I (SA.smul m a)) :=
          projection_add hI (SA.smul l a) (SA.smul m a)
      _ = quotientAdd SA I (quotientSmul SA I l (projection SA I a))
            (quotientSmul SA I m (projection SA I a)) := by
          rw [projection_smul hI l a, projection_smul hI m a]

/-- 本文 `claim_quotient_algebra_is_complex_algebra`：(A/I, +_{A/I}, ·_{A/I}, ∗_{A/I}, 0_{A/I}, 1_{A/I}) は ℂ-代数（商代数）。
一つ目の条件は `quotientRing`、二つ目は `quotientVectorSpace`、両立の二つは代表に移して A の両立を当てる。 -/
noncomputable def quotientAlgebra {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) : ComplexAlgebra (QuotientSet SA I) where
  toUnitalRing := quotientRing hI
  smul := quotientSmul SA I
  smul_assoc := (quotientVectorSpace hI).smul_assoc
  one_smul := (quotientVectorSpace hI).one_smul
  smul_add := (quotientVectorSpace hI).smul_add
  add_smul := (quotientVectorSpace hI).add_smul
  smul_mul_left l X Y := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    calc quotientSmul SA I l (quotientMul SA I (projection SA I a) (projection SA I b))
        = quotientSmul SA I l (projection SA I (SA.mul a b)) := by rw [projection_mul hI a b]
      _ = projection SA I (SA.smul l (SA.mul a b)) := (projection_smul hI l (SA.mul a b)).symm
      _ = projection SA I (SA.mul (SA.smul l a) b) := by rw [SA.smul_mul_left l a b]
      _ = quotientMul SA I (projection SA I (SA.smul l a)) (projection SA I b) :=
          projection_mul hI (SA.smul l a) b
      _ = quotientMul SA I (quotientSmul SA I l (projection SA I a)) (projection SA I b) := by
          rw [projection_smul hI l a]
  smul_mul_right l X Y := by
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    calc quotientSmul SA I l (quotientMul SA I (projection SA I a) (projection SA I b))
        = quotientSmul SA I l (projection SA I (SA.mul a b)) := by rw [projection_mul hI a b]
      _ = projection SA I (SA.smul l (SA.mul a b)) := (projection_smul hI l (SA.mul a b)).symm
      _ = projection SA I (SA.mul a (SA.smul l b)) := by rw [SA.smul_mul_right l a b]
      _ = quotientMul SA I (projection SA I a) (projection SA I (SA.smul l b)) :=
          projection_mul hI a (SA.smul l b)
      _ = quotientMul SA I (projection SA I a) (quotientSmul SA I l (projection SA I b)) := by
          rw [projection_smul hI l b]

/-- 本文 `claim_projection_onto_quotient_algebra_is_algebra_homomorphism`：π_I は A から商代数 A/I への ℂ-代数の準同型。 -/
theorem projection_isComplexAlgebraHomomorphism {SA : ComplexAlgebra A} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) :
    IsComplexAlgebraHomomorphism SA (quotientAlgebra hI) (projection SA I) where
  isRingHomomorphism := {
    map_add := projection_add hI
    map_mul := projection_mul hI
    map_one := rfl }
  isLinearMap := {
    map_add := projection_add hI
    map_smul := projection_smul hI }

/-- 本文 `claim_projection_onto_quotient_set_sends_ideal_elements_to_zero`：x ∈ I ならば π_I(x) = 0_{A/I}。
x ≡_I 0_A を x +_A ((-1_ℂ) ∗_A 0_A) = x の二行で示し、π_I(x) = [x]_I = [0_A]_I = π_I(0_A) = 0_{A/I}。 -/
theorem projection_eq_zero_of_mem {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (x : A) (hx : x ∈ I) : projection SA I x = quotientZero SA I := by
  have h : SA.add x (SA.smul (-1) SA.zero) = x := calc
    SA.add x (SA.smul (-1) SA.zero) = SA.add x SA.zero := by rw [smul_zero_eq_zero SA (-1)]
    _ = x := SA.add_zero x
  have hc : Congruent SA I x SA.zero := by
    show SA.add x (SA.smul (-1) SA.zero) ∈ I
    rw [h]
    exact hx
  calc projection SA I x = projection SA I SA.zero :=
        projection_eq_of_residueClass_eq ((residueClass_eq_iff hI x SA.zero).2 hc)
    _ = quotientZero SA I := rfl

end CliffordMatrixIsomorphism.ComplexAlgebra
