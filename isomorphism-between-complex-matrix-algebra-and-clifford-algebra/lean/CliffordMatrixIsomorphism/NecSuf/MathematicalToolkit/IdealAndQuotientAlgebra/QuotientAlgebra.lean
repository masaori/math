/-
節「両側イデアルと商代数」のうち、商集合の上の演算・商代数・射影が準同型であることの必要十分版。
具体版 `MathematicalToolkit/IdealAndQuotientAlgebra/QuotientAlgebra.lean` と同じ def・calc の行で、
係数 ℂ を型の変数 K に替え、合同の -1_ℂ を K の元 n に替えて書く。docstring の式は本文の記号（-1_ℂ）のまま引く。

各主張が実際に使う K の性質:

  演算の定義（quotientAdd 等）           使わない
  加法・乗法が代表によらないこと、射影が加法・乗法を保つこと、環であること
                                        `CongruenceLaws K n`（剰余類の同値を経由する）
  スカラー倍が代表によらないこと、射影がスカラー倍を保つこと、線型空間・代数であること、射影が準同型であること
                                        `CongruenceLaws K n` と n · λ = λ · n（すべての λ。合同がスカラー倍と両立することに要る）
  projection_eq_zero_of_mem             `CongruenceLaws K n` と a · 0 = 0（零ベクトルのスカラー倍が零ベクトルであることを
                                        λ := n に当てる。引く主張の必要十分版が a · 0 = 0 をすべての a で仮定している）

具体版の環・線型空間・代数の公理を当てる行（加法の結合法則など）は、A の公理を当てるだけで K の性質を使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.IdealAndQuotientAlgebra.Congruence

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A : Type u}

/-- 本文の「[a]_I = π_I(a) = π_I(a') = [a']_I」の三行（π_I の値が剰余類であることを両端で使う）。 -/
theorem residueClass_eq_of_projection_eq {SA : AlgebraOver K A} {n : K} {I : Set A} {a a' : A}
    (h : projection SA n I a = projection SA n I a') : residueClass SA n I a = residueClass SA n I a' := calc
  residueClass SA n I a = (projection SA n I a).1 := rfl
  _ = (projection SA n I a').1 := by rw [h]
  _ = residueClass SA n I a' := rfl

/-- 本文の「π_I(a) = [a]_I = [a']_I = π_I(a')」の三行。 -/
theorem projection_eq_of_residueClass_eq {SA : AlgebraOver K A} {n : K} {I : Set A} {a a' : A}
    (h : residueClass SA n I a = residueClass SA n I a') : projection SA n I a = projection SA n I a' :=
  Subtype.ext (calc
    (projection SA n I a).1 = residueClass SA n I a := rfl
    _ = residueClass SA n I a' := h
    _ = (projection SA n I a').1 := rfl)

/-- 本文 `claim_quotient_addition_does_not_depend_on_representatives`：
π_I(a) = π_I(a') かつ π_I(b) = π_I(b') ならば π_I(a +_A b) = π_I(a' +_A b')。 -/
theorem projection_add_eq_of_projection_eq [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (a a' b b' : A) (ha : projection SA n I a = projection SA n I a')
    (hb : projection SA n I b = projection SA n I b') :
    projection SA n I (SA.add a b) = projection SA n I (SA.add a' b') := by
  have hca : Congruent SA n I a a' := (residueClass_eq_iff hI hL a a').1 (residueClass_eq_of_projection_eq ha)
  have hcb : Congruent SA n I b b' := (residueClass_eq_iff hI hL b b').1 (residueClass_eq_of_projection_eq hb)
  have hab : residueClass SA n I (SA.add a b) = residueClass SA n I (SA.add a' b') :=
    (residueClass_eq_iff hI hL (SA.add a b) (SA.add a' b')).2 (congruent_add hI a a' b b' hca hcb)
  exact projection_eq_of_residueClass_eq hab

/-- 本文 `claim_quotient_multiplication_does_not_depend_on_representatives`：
π_I(a) = π_I(a') かつ π_I(b) = π_I(b') ならば π_I(a ·_A b) = π_I(a' ·_A b')。 -/
theorem projection_mul_eq_of_projection_eq [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (a a' b b' : A) (ha : projection SA n I a = projection SA n I a')
    (hb : projection SA n I b = projection SA n I b') :
    projection SA n I (SA.mul a b) = projection SA n I (SA.mul a' b') := by
  have hca : Congruent SA n I a a' := (residueClass_eq_iff hI hL a a').1 (residueClass_eq_of_projection_eq ha)
  have hcb : Congruent SA n I b b' := (residueClass_eq_iff hI hL b b').1 (residueClass_eq_of_projection_eq hb)
  have hab : residueClass SA n I (SA.mul a b) = residueClass SA n I (SA.mul a' b') :=
    (residueClass_eq_iff hI hL (SA.mul a b) (SA.mul a' b')).2 (congruent_mul hI hL.n_add_one hL.one_add_n hL.zero_add_zero a a' b b' hca hcb)
  exact projection_eq_of_residueClass_eq hab

/-- 本文 `claim_quotient_scalar_multiplication_does_not_depend_on_representatives`：
π_I(a) = π_I(a') ならば π_I(λ ∗_A a) = π_I(λ ∗_A a')。 -/
theorem projection_smul_eq_of_projection_eq [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hcomm : ∀ l : K, n * l = l * n) (l : K) (a a' : A) (ha : projection SA n I a = projection SA n I a') :
    projection SA n I (SA.smul l a) = projection SA n I (SA.smul l a') := by
  have hca : Congruent SA n I a a' := (residueClass_eq_iff hI hL a a').1 (residueClass_eq_of_projection_eq ha)
  have hla : residueClass SA n I (SA.smul l a) = residueClass SA n I (SA.smul l a') :=
    (residueClass_eq_iff hI hL (SA.smul l a) (SA.smul l a')).2 (congruent_smul hI hcomm l a a' hca)
  exact projection_eq_of_residueClass_eq hla

/-- 本文 `def_quotient_algebra_operations` で代表をとる操作：π_I(a) = X となる a を全射性から一つ選ぶ。 -/
noncomputable def rep {SA : AlgebraOver K A} {n : K} {I : Set A} (X : QuotientSet SA n I) : A :=
  Classical.choose (projection_surjective SA n I X)

theorem projection_rep {SA : AlgebraOver K A} {n : K} {I : Set A} (X : QuotientSet SA n I) :
    projection SA n I (rep X) = X :=
  Classical.choose_spec (projection_surjective SA n I X)

/-- 本文 `def_quotient_algebra_operations`：X +_{A/I} Y := π_I(a +_A b)。 -/
noncomputable def quotientAdd (SA : AlgebraOver K A) (n : K) (I : Set A) (X Y : QuotientSet SA n I) :
    QuotientSet SA n I :=
  projection SA n I (SA.add (rep X) (rep Y))

/-- 本文 `def_quotient_algebra_operations`：X ·_{A/I} Y := π_I(a ·_A b)。 -/
noncomputable def quotientMul (SA : AlgebraOver K A) (n : K) (I : Set A) (X Y : QuotientSet SA n I) :
    QuotientSet SA n I :=
  projection SA n I (SA.mul (rep X) (rep Y))

/-- 本文 `def_quotient_algebra_operations`：λ ∗_{A/I} X := π_I(λ ∗_A a)。 -/
noncomputable def quotientSmul (SA : AlgebraOver K A) (n : K) (I : Set A) (l : K) (X : QuotientSet SA n I) :
    QuotientSet SA n I :=
  projection SA n I (SA.smul l (rep X))

/-- 本文 `def_quotient_algebra_operations`：0_{A/I} := π_I(0_A)。 -/
def quotientZero (SA : AlgebraOver K A) (n : K) (I : Set A) : QuotientSet SA n I := projection SA n I SA.zero

/-- 本文 `def_quotient_algebra_operations`：1_{A/I} := π_I(1_A)。 -/
def quotientOne (SA : AlgebraOver K A) (n : K) (I : Set A) : QuotientSet SA n I := projection SA n I SA.one

/-- 本文 `def_quotient_algebra_operations` の後半：加法の右辺は代表のとり方によらない
（`claim_quotient_addition_does_not_depend_on_representatives` を、選んだ代表と a, b に当てる）。 -/
theorem quotientAdd_eq [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n)
    (X Y : QuotientSet SA n I) (a b : A) (ha : projection SA n I a = X) (hb : projection SA n I b = Y) :
    quotientAdd SA n I X Y = projection SA n I (SA.add a b) :=
  projection_add_eq_of_projection_eq hI hL (rep X) a (rep Y) b
    ((projection_rep X).trans ha.symm) ((projection_rep Y).trans hb.symm)

/-- 本文 `def_quotient_algebra_operations` の後半：乗法の右辺は代表のとり方によらない。 -/
theorem quotientMul_eq [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n)
    (X Y : QuotientSet SA n I) (a b : A) (ha : projection SA n I a = X) (hb : projection SA n I b = Y) :
    quotientMul SA n I X Y = projection SA n I (SA.mul a b) :=
  projection_mul_eq_of_projection_eq hI hL (rep X) a (rep Y) b
    ((projection_rep X).trans ha.symm) ((projection_rep Y).trans hb.symm)

/-- 本文 `def_quotient_algebra_operations` の後半：スカラー倍の右辺は代表のとり方によらない。 -/
theorem quotientSmul_eq [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hcomm : ∀ l : K, n * l = l * n) (l : K)
    (X : QuotientSet SA n I) (a : A) (ha : projection SA n I a = X) :
    quotientSmul SA n I l X = projection SA n I (SA.smul l a) :=
  projection_smul_eq_of_projection_eq hI hL hcomm l (rep X) a ((projection_rep X).trans ha.symm)

/-- 本文 `claim_projection_onto_quotient_set_preserves_addition`：π_I(a +_A b) = π_I(a) +_{A/I} π_I(b)。
X := π_I(a)、Y := π_I(b) の代表に a, b 自身をとる。 -/
theorem projection_add [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (a b : A) :
    projection SA n I (SA.add a b) = quotientAdd SA n I (projection SA n I a) (projection SA n I b) :=
  (quotientAdd_eq hI hL (projection SA n I a) (projection SA n I b) a b rfl rfl).symm

/-- 本文 `claim_projection_onto_quotient_set_preserves_multiplication`：π_I(a ·_A b) = π_I(a) ·_{A/I} π_I(b)。 -/
theorem projection_mul [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (a b : A) :
    projection SA n I (SA.mul a b) = quotientMul SA n I (projection SA n I a) (projection SA n I b) :=
  (quotientMul_eq hI hL (projection SA n I a) (projection SA n I b) a b rfl rfl).symm

/-- 本文 `claim_projection_onto_quotient_set_preserves_scalar_multiplication`：π_I(λ ∗_A a) = λ ∗_{A/I} π_I(a)。 -/
theorem projection_smul [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hcomm : ∀ l : K, n * l = l * n) (l : K)
    (a : A) : projection SA n I (SA.smul l a) = quotientSmul SA n I l (projection SA n I a) :=
  (quotientSmul_eq hI hL hcomm l (projection SA n I a) a rfl).symm

/-- 本文 `claim_quotient_set_operations_form_unital_ring`：(A/I, +_{A/I}, ·_{A/I}, 0_{A/I}, 1_{A/I}) は単位元をもつ環。
各条件は、X, Y, Z の代表 a, b, c を全射性でとり、射影が演算を保つことで A の同じ条件へ移す。 -/
noncomputable def quotientRing [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) :
    UnitalRing (QuotientSet SA n I) where
  add := quotientAdd SA n I
  mul := quotientMul SA n I
  zero := quotientZero SA n I
  one := quotientOne SA n I
  add_assoc X Y Z := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    obtain ⟨c, rfl⟩ := projection_surjective SA n I Z
    calc quotientAdd SA n I (quotientAdd SA n I (projection SA n I a) (projection SA n I b)) (projection SA n I c)
        = quotientAdd SA n I (projection SA n I (SA.add a b)) (projection SA n I c) := by
          rw [projection_add hI hL a b]
      _ = projection SA n I (SA.add (SA.add a b) c) := by rw [projection_add hI hL (SA.add a b) c]
      _ = projection SA n I (SA.add a (SA.add b c)) := by rw [SA.add_assoc a b c]
      _ = quotientAdd SA n I (projection SA n I a) (projection SA n I (SA.add b c)) :=
          projection_add hI hL a (SA.add b c)
      _ = quotientAdd SA n I (projection SA n I a) (quotientAdd SA n I (projection SA n I b) (projection SA n I c)) := by
          rw [projection_add hI hL b c]
  add_comm X Y := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    calc quotientAdd SA n I (projection SA n I a) (projection SA n I b)
        = projection SA n I (SA.add a b) := (projection_add hI hL a b).symm
      _ = projection SA n I (SA.add b a) := by rw [SA.add_comm a b]
      _ = quotientAdd SA n I (projection SA n I b) (projection SA n I a) := projection_add hI hL b a
  add_zero X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    calc quotientAdd SA n I (projection SA n I a) (quotientZero SA n I)
        = quotientAdd SA n I (projection SA n I a) (projection SA n I SA.zero) := rfl
      _ = projection SA n I (SA.add a SA.zero) := (projection_add hI hL a SA.zero).symm
      _ = projection SA n I a := by rw [SA.add_zero a]
  exists_add_inverse X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨a', ha'⟩ := SA.exists_add_inverse a
    refine ⟨projection SA n I a', ?_⟩
    calc quotientAdd SA n I (projection SA n I a) (projection SA n I a')
        = projection SA n I (SA.add a a') := (projection_add hI hL a a').symm
      _ = projection SA n I SA.zero := by rw [ha']
      _ = quotientZero SA n I := rfl
  mul_assoc X Y Z := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    obtain ⟨c, rfl⟩ := projection_surjective SA n I Z
    calc quotientMul SA n I (quotientMul SA n I (projection SA n I a) (projection SA n I b)) (projection SA n I c)
        = quotientMul SA n I (projection SA n I (SA.mul a b)) (projection SA n I c) := by
          rw [projection_mul hI hL a b]
      _ = projection SA n I (SA.mul (SA.mul a b) c) := by rw [projection_mul hI hL (SA.mul a b) c]
      _ = projection SA n I (SA.mul a (SA.mul b c)) := by rw [SA.mul_assoc a b c]
      _ = quotientMul SA n I (projection SA n I a) (projection SA n I (SA.mul b c)) :=
          projection_mul hI hL a (SA.mul b c)
      _ = quotientMul SA n I (projection SA n I a) (quotientMul SA n I (projection SA n I b) (projection SA n I c)) := by
          rw [projection_mul hI hL b c]
  mul_one X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    calc quotientMul SA n I (projection SA n I a) (quotientOne SA n I)
        = quotientMul SA n I (projection SA n I a) (projection SA n I SA.one) := rfl
      _ = projection SA n I (SA.mul a SA.one) := (projection_mul hI hL a SA.one).symm
      _ = projection SA n I a := by rw [SA.mul_one a]
  one_mul X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    calc quotientMul SA n I (quotientOne SA n I) (projection SA n I a)
        = quotientMul SA n I (projection SA n I SA.one) (projection SA n I a) := rfl
      _ = projection SA n I (SA.mul SA.one a) := (projection_mul hI hL SA.one a).symm
      _ = projection SA n I a := by rw [SA.one_mul a]
  left_distrib X Y Z := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    obtain ⟨c, rfl⟩ := projection_surjective SA n I Z
    calc quotientMul SA n I (projection SA n I a) (quotientAdd SA n I (projection SA n I b) (projection SA n I c))
        = quotientMul SA n I (projection SA n I a) (projection SA n I (SA.add b c)) := by
          rw [projection_add hI hL b c]
      _ = projection SA n I (SA.mul a (SA.add b c)) := (projection_mul hI hL a (SA.add b c)).symm
      _ = projection SA n I (SA.add (SA.mul a b) (SA.mul a c)) := by rw [SA.left_distrib a b c]
      _ = quotientAdd SA n I (projection SA n I (SA.mul a b)) (projection SA n I (SA.mul a c)) :=
          projection_add hI hL (SA.mul a b) (SA.mul a c)
      _ = quotientAdd SA n I (quotientMul SA n I (projection SA n I a) (projection SA n I b))
            (quotientMul SA n I (projection SA n I a) (projection SA n I c)) := by
          rw [projection_mul hI hL a b, projection_mul hI hL a c]
  right_distrib X Y Z := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    obtain ⟨c, rfl⟩ := projection_surjective SA n I Z
    calc quotientMul SA n I (quotientAdd SA n I (projection SA n I a) (projection SA n I b)) (projection SA n I c)
        = quotientMul SA n I (projection SA n I (SA.add a b)) (projection SA n I c) := by
          rw [projection_add hI hL a b]
      _ = projection SA n I (SA.mul (SA.add a b) c) := (projection_mul hI hL (SA.add a b) c).symm
      _ = projection SA n I (SA.add (SA.mul a c) (SA.mul b c)) := by rw [SA.right_distrib a b c]
      _ = quotientAdd SA n I (projection SA n I (SA.mul a c)) (projection SA n I (SA.mul b c)) :=
          projection_add hI hL (SA.mul a c) (SA.mul b c)
      _ = quotientAdd SA n I (quotientMul SA n I (projection SA n I a) (projection SA n I c))
            (quotientMul SA n I (projection SA n I b) (projection SA n I c)) := by
          rw [projection_mul hI hL a c, projection_mul hI hL b c]

/-- 本文 `claim_quotient_set_operations_form_complex_vector_space`：(A/I, +_{A/I}, ∗_{A/I}, 0_{A/I}) は ℂ-線型空間。
加法の四条件は環の同じ四条件（`quotientRing`）、スカラー倍の四条件は代表に移して U_vec(A) の同じ条件を当てる。 -/
noncomputable def quotientVectorSpace [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hcomm : ∀ l : K, n * l = l * n) : VectorSpace K (QuotientSet SA n I) where
  add := quotientAdd SA n I
  smul := quotientSmul SA n I
  zero := quotientZero SA n I
  add_assoc := (quotientRing hI hL).add_assoc
  add_comm := (quotientRing hI hL).add_comm
  add_zero := (quotientRing hI hL).add_zero
  exists_add_inverse := (quotientRing hI hL).exists_add_inverse
  smul_assoc l m X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    calc quotientSmul SA n I (l * m) (projection SA n I a)
        = projection SA n I (SA.smul (l * m) a) := (projection_smul hI hL hcomm (l * m) a).symm
      _ = projection SA n I (SA.smul l (SA.smul m a)) := by rw [SA.smul_assoc l m a]
      _ = quotientSmul SA n I l (projection SA n I (SA.smul m a)) := projection_smul hI hL hcomm l (SA.smul m a)
      _ = quotientSmul SA n I l (quotientSmul SA n I m (projection SA n I a)) := by
          rw [projection_smul hI hL hcomm m a]
  one_smul X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    calc quotientSmul SA n I 1 (projection SA n I a)
        = projection SA n I (SA.smul 1 a) := (projection_smul hI hL hcomm 1 a).symm
      _ = projection SA n I a := by rw [SA.one_smul a]
  smul_add l X Y := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    calc quotientSmul SA n I l (quotientAdd SA n I (projection SA n I a) (projection SA n I b))
        = quotientSmul SA n I l (projection SA n I (SA.add a b)) := by rw [projection_add hI hL a b]
      _ = projection SA n I (SA.smul l (SA.add a b)) := (projection_smul hI hL hcomm l (SA.add a b)).symm
      _ = projection SA n I (SA.add (SA.smul l a) (SA.smul l b)) := by rw [SA.smul_add l a b]
      _ = quotientAdd SA n I (projection SA n I (SA.smul l a)) (projection SA n I (SA.smul l b)) :=
          projection_add hI hL (SA.smul l a) (SA.smul l b)
      _ = quotientAdd SA n I (quotientSmul SA n I l (projection SA n I a))
            (quotientSmul SA n I l (projection SA n I b)) := by
          rw [projection_smul hI hL hcomm l a, projection_smul hI hL hcomm l b]
  add_smul l m X := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    calc quotientSmul SA n I (l + m) (projection SA n I a)
        = projection SA n I (SA.smul (l + m) a) := (projection_smul hI hL hcomm (l + m) a).symm
      _ = projection SA n I (SA.add (SA.smul l a) (SA.smul m a)) := by rw [SA.add_smul l m a]
      _ = quotientAdd SA n I (projection SA n I (SA.smul l a)) (projection SA n I (SA.smul m a)) :=
          projection_add hI hL (SA.smul l a) (SA.smul m a)
      _ = quotientAdd SA n I (quotientSmul SA n I l (projection SA n I a))
            (quotientSmul SA n I m (projection SA n I a)) := by
          rw [projection_smul hI hL hcomm l a, projection_smul hI hL hcomm m a]

/-- 本文 `claim_quotient_algebra_is_complex_algebra`：(A/I, +_{A/I}, ·_{A/I}, ∗_{A/I}, 0_{A/I}, 1_{A/I}) は ℂ-代数（商代数）。
一つ目の条件は `quotientRing`、二つ目は `quotientVectorSpace`、両立の二つは代表に移して A の両立を当てる。 -/
noncomputable def quotientAlgebra [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hcomm : ∀ l : K, n * l = l * n) : AlgebraOver K (QuotientSet SA n I) where
  toUnitalRing := quotientRing hI hL
  smul := quotientSmul SA n I
  smul_assoc := (quotientVectorSpace hI hL hcomm).smul_assoc
  one_smul := (quotientVectorSpace hI hL hcomm).one_smul
  smul_add := (quotientVectorSpace hI hL hcomm).smul_add
  add_smul := (quotientVectorSpace hI hL hcomm).add_smul
  smul_mul_left l X Y := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    calc quotientSmul SA n I l (quotientMul SA n I (projection SA n I a) (projection SA n I b))
        = quotientSmul SA n I l (projection SA n I (SA.mul a b)) := by rw [projection_mul hI hL a b]
      _ = projection SA n I (SA.smul l (SA.mul a b)) := (projection_smul hI hL hcomm l (SA.mul a b)).symm
      _ = projection SA n I (SA.mul (SA.smul l a) b) := by rw [SA.smul_mul_left l a b]
      _ = quotientMul SA n I (projection SA n I (SA.smul l a)) (projection SA n I b) :=
          projection_mul hI hL (SA.smul l a) b
      _ = quotientMul SA n I (quotientSmul SA n I l (projection SA n I a)) (projection SA n I b) := by
          rw [projection_smul hI hL hcomm l a]
  smul_mul_right l X Y := by
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    calc quotientSmul SA n I l (quotientMul SA n I (projection SA n I a) (projection SA n I b))
        = quotientSmul SA n I l (projection SA n I (SA.mul a b)) := by rw [projection_mul hI hL a b]
      _ = projection SA n I (SA.smul l (SA.mul a b)) := (projection_smul hI hL hcomm l (SA.mul a b)).symm
      _ = projection SA n I (SA.mul a (SA.smul l b)) := by rw [SA.smul_mul_right l a b]
      _ = quotientMul SA n I (projection SA n I a) (projection SA n I (SA.smul l b)) :=
          projection_mul hI hL a (SA.smul l b)
      _ = quotientMul SA n I (projection SA n I a) (quotientSmul SA n I l (projection SA n I b)) := by
          rw [projection_smul hI hL hcomm l b]

/-- 本文 `claim_projection_onto_quotient_algebra_is_algebra_homomorphism`：π_I は A から商代数 A/I への ℂ-代数の準同型。 -/
theorem projection_isAlgebraHomomorphism [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A}
    (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hcomm : ∀ l : K, n * l = l * n) :
    IsAlgebraHomomorphism SA (quotientAlgebra hI hL hcomm) (projection SA n I) where
  isRingHomomorphism := {
    map_add := projection_add hI hL
    map_mul := projection_mul hI hL
    map_one := rfl }
  isLinearMap := {
    map_add := projection_add hI hL
    map_smul := projection_smul hI hL hcomm }

/-- 本文 `claim_projection_onto_quotient_set_sends_ideal_elements_to_zero`：x ∈ I ならば π_I(x) = 0_{A/I}。
x ≡_I 0_A を x +_A ((-1_ℂ) ∗_A 0_A) = x の二行で示し、π_I(x) = [x]_I = [0_A]_I = π_I(0_A) = 0_{A/I}。 -/
theorem projection_eq_zero_of_mem [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hmul0 : ∀ a : K, a * 0 = 0)
    (x : A) (hx : x ∈ I) : projection SA n I x = quotientZero SA n I := by
  have h : SA.add x (SA.smul n SA.zero) = x := calc
    SA.add x (SA.smul n SA.zero) = SA.add x SA.zero := by rw [smul_zero_eq_zero SA hL.zero_add_zero hmul0 n]
    _ = x := SA.add_zero x
  have hc : Congruent SA n I x SA.zero := by
    show SA.add x (SA.smul n SA.zero) ∈ I
    rw [h]
    exact hx
  calc projection SA n I x = projection SA n I SA.zero :=
        projection_eq_of_residueClass_eq ((residueClass_eq_iff hI hL x SA.zero).2 hc)
    _ = quotientZero SA n I := rfl

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver
