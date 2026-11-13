/-
節「両側イデアルと商代数」のうち、両側イデアルを法とする合同・剰余類・商集合・商集合への射影と、
合同が演算と両立することの具体版。人手証明と 1 対 1 に対応させる。mathlib の `Quotient`・`Setoid` を使わない。

  本文のラベル                                                              このファイル
  def_congruence_modulo_two_sided_ideal                                     Congruent（a ≡_I b）
  claim_congruence_modulo_two_sided_ideal_is_reflexive                      congruent_refl
  claim_congruence_modulo_two_sided_ideal_is_symmetric                      congruent_symm
  claim_congruence_modulo_two_sided_ideal_is_transitive                     congruent_trans
  def_residue_class_modulo_two_sided_ideal                                  residueClass（[a]_I）
  claim_residue_classes_are_equal_iff_congruent                             residueClass_eq_iff
  def_quotient_set_modulo_two_sided_ideal                                   QuotientSet（A/I）
  def_projection_onto_quotient_set                                          projection（π_I）
  claim_projection_onto_quotient_set_is_surjective                          projection_surjective
  claim_congruence_modulo_two_sided_ideal_is_compatible_with_addition       congruent_add
  claim_congruence_modulo_two_sided_ideal_is_compatible_with_multiplication congruent_mul
  claim_congruence_modulo_two_sided_ideal_is_compatible_with_scalar_multiplication
                                                                            congruent_smul

-1_ℂ は ℂ の `-1` で、1_ℂ +_ℂ (-1_ℂ) = 0_ℂ は `add_neg_cancel 1` である。
剰余類 [a]_I は A の部分集合 `Set A` で、商集合 A/I は「ある a について X = [a]_I となる A の部分集合 X」の全体
（`Set A` の部分型）である。A/I の元の等号は、部分型の値（A の部分集合）の等号である（`Subtype.ext`）。
本文の「[a]_I = π_I(a)」の行は、π_I(a) の値（部分集合）が [a]_I であること（`rfl`）である。

必要十分版は `NecSuf/MathematicalToolkit/IdealAndQuotientAlgebra/Congruence.lean`、
導出版は `IdealAndQuotientAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.IdealAndQuotientAlgebra.TwoSidedIdeal

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u

variable {A : Type u}

/-- 本文 `def_congruence_modulo_two_sided_ideal`：a ≡_I b :⟺ a +_A ((-1_ℂ) ∗_A b) ∈ I。 -/
def Congruent (SA : ComplexAlgebra A) (I : Set A) (a b : A) : Prop :=
  SA.add a (SA.smul (-1) b) ∈ I

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_reflexive`：a ≡_I a。 -/
theorem congruent_refl {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) (a : A) :
    Congruent SA I a a := by
  have h : SA.add a (SA.smul (-1) a) = SA.zero := calc
    SA.add a (SA.smul (-1) a) = SA.add (SA.smul 1 a) (SA.smul (-1) a) := by rw [SA.one_smul a]
    _ = SA.smul (1 + (-1)) a := (SA.add_smul 1 (-1) a).symm
    _ = SA.smul 0 a := by rw [add_neg_cancel (1 : ℂ)]
    _ = SA.zero := zero_smul_eq_zero SA a
  show SA.add a (SA.smul (-1) a) ∈ I
  rw [h]
  exact hI.zero_mem

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_symmetric`：a ≡_I b ならば b ≡_I a。
x := a +_A ((-1_ℂ) ∗_A b) と置き、b +_A ((-1_ℂ) ∗_A a) = (-1_ℂ) ∗_A x を六行で示す。 -/
theorem congruent_symm {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) (a b : A)
    (hab : Congruent SA I a b) : Congruent SA I b a := by
  let x : A := SA.add a (SA.smul (-1) b)
  have hx : x ∈ I := hab
  have hm : (-1 : ℂ) * (-1) = 1 := by norm_num
  have h : SA.add b (SA.smul (-1) a) = SA.smul (-1) x := calc
    SA.add b (SA.smul (-1) a) = SA.add (SA.smul (-1) a) b := SA.add_comm b (SA.smul (-1) a)
    _ = SA.add (SA.smul (-1) a) (SA.smul 1 b) := by rw [SA.one_smul b]
    _ = SA.add (SA.smul (-1) a) (SA.smul ((-1) * (-1)) b) := by rw [hm]
    _ = SA.add (SA.smul (-1) a) (SA.smul (-1) (SA.smul (-1) b)) := by
          rw [SA.smul_assoc (-1) (-1) b]
    _ = SA.smul (-1) (SA.add a (SA.smul (-1) b)) := (SA.smul_add (-1) a (SA.smul (-1) b)).symm
    _ = SA.smul (-1) x := rfl
  show SA.add b (SA.smul (-1) a) ∈ I
  rw [h]
  exact hI.smul_mem (-1) x hx

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_transitive`：a ≡_I b かつ b ≡_I c ならば a ≡_I c。
準備の ((-1_ℂ) ∗_A b) +_A b = 0_A を五行で示し、a +_A ((-1_ℂ) ∗_A c) = x +_A y を五行で示す。 -/
theorem congruent_trans {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) (a b c : A)
    (hab : Congruent SA I a b) (hbc : Congruent SA I b c) : Congruent SA I a c := by
  let x : A := SA.add a (SA.smul (-1) b)
  let y : A := SA.add b (SA.smul (-1) c)
  have hx : x ∈ I := hab
  have hy : y ∈ I := hbc
  have hprep : SA.add (SA.smul (-1) b) b = SA.zero := calc
    SA.add (SA.smul (-1) b) b = SA.add (SA.smul (-1) b) (SA.smul 1 b) := by rw [SA.one_smul b]
    _ = SA.smul ((-1) + 1) b := (SA.add_smul (-1) 1 b).symm
    _ = SA.smul (1 + (-1)) b := by rw [_root_.add_comm (-1 : ℂ) 1]
    _ = SA.smul 0 b := by rw [add_neg_cancel (1 : ℂ)]
    _ = SA.zero := zero_smul_eq_zero SA b
  have h : SA.add a (SA.smul (-1) c) = SA.add x y := calc
    SA.add a (SA.smul (-1) c) = SA.add (SA.add a SA.zero) (SA.smul (-1) c) := by rw [SA.add_zero a]
    _ = SA.add (SA.add a (SA.add (SA.smul (-1) b) b)) (SA.smul (-1) c) := by rw [hprep]
    _ = SA.add (SA.add (SA.add a (SA.smul (-1) b)) b) (SA.smul (-1) c) := by
          rw [SA.add_assoc a (SA.smul (-1) b) b]
    _ = SA.add (SA.add a (SA.smul (-1) b)) (SA.add b (SA.smul (-1) c)) :=
          SA.add_assoc (SA.add a (SA.smul (-1) b)) b (SA.smul (-1) c)
    _ = SA.add x y := rfl
  show SA.add a (SA.smul (-1) c) ∈ I
  rw [h]
  exact hI.add_mem x y hx hy

/-- 本文 `def_residue_class_modulo_two_sided_ideal`：[a]_I := {b ∈ A : a ≡_I b}（A の部分集合）。 -/
def residueClass (SA : ComplexAlgebra A) (I : Set A) (a : A) : Set A :=
  {b : A | Congruent SA I a b}

/-- 本文 `claim_residue_classes_are_equal_iff_congruent`：[a]_I = [b]_I ⟺ a ≡_I b（左辺は A の部分集合の等号）。 -/
theorem residueClass_eq_iff {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a b : A) : residueClass SA I a = residueClass SA I b ↔ Congruent SA I a b := by
  constructor
  · -- （⇒）b ∈ [b]_I（反射性）と仮定から b ∈ [a]_I、すなわち a ≡_I b
    intro h
    have hb : b ∈ residueClass SA I b := congruent_refl hI b
    have hb' : b ∈ residueClass SA I a := by rw [h]; exact hb
    exact hb'
  · -- （⇐）二つの包含
    intro hab
    have hba : Congruent SA I b a := congruent_symm hI a b hab
    apply Set.Subset.antisymm
    · intro c hc
      exact congruent_trans hI b a c hba hc
    · intro c hc
      exact congruent_trans hI a b c hab hc

/-- 本文 `def_quotient_set_modulo_two_sided_ideal`：A/I := {[a]_I : a ∈ A}。
元は A の部分集合 X で、ある a ∈ A について X = [a]_I となるもの。 -/
def QuotientSet (SA : ComplexAlgebra A) (I : Set A) : Type u :=
  {X : Set A // ∃ a : A, X = residueClass SA I a}

/-- 本文 `def_projection_onto_quotient_set`：π_I(a) := [a]_I。値が A/I に属することは代表に a 自身をとる。 -/
def projection (SA : ComplexAlgebra A) (I : Set A) (a : A) : QuotientSet SA I :=
  ⟨residueClass SA I a, a, rfl⟩

/-- 本文 `claim_projection_onto_quotient_set_is_surjective`：A/I の任意の元 X に π_I(a) = X となる a がある。 -/
theorem projection_surjective (SA : ComplexAlgebra A) (I : Set A) (X : QuotientSet SA I) :
    ∃ a : A, projection SA I a = X := by
  obtain ⟨a, ha⟩ := X.2
  refine ⟨a, Subtype.ext ?_⟩
  calc (projection SA I a).1 = residueClass SA I a := rfl
    _ = X.1 := ha.symm

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_compatible_with_addition`：
a ≡_I a' かつ b ≡_I b' ならば a +_A b ≡_I a' +_A b'。u := (-1_ℂ) ∗_A a'、v := (-1_ℂ) ∗_A b' と置き九行で示す。 -/
theorem congruent_add {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a a' b b' : A) (ha : Congruent SA I a a') (hb : Congruent SA I b b') :
    Congruent SA I (SA.add a b) (SA.add a' b') := by
  let x : A := SA.add a (SA.smul (-1) a')
  let y : A := SA.add b (SA.smul (-1) b')
  have hx : x ∈ I := ha
  have hy : y ∈ I := hb
  let u : A := SA.smul (-1) a'
  let v : A := SA.smul (-1) b'
  have h : SA.add (SA.add a b) (SA.smul (-1) (SA.add a' b')) = SA.add x y := calc
    SA.add (SA.add a b) (SA.smul (-1) (SA.add a' b'))
        = SA.add (SA.add a b) (SA.add (SA.smul (-1) a') (SA.smul (-1) b')) := by
          rw [SA.smul_add (-1) a' b']
    _ = SA.add (SA.add a b) (SA.add u v) := rfl
    _ = SA.add a (SA.add b (SA.add u v)) := SA.add_assoc a b (SA.add u v)
    _ = SA.add a (SA.add (SA.add b u) v) := by rw [SA.add_assoc b u v]
    _ = SA.add a (SA.add (SA.add u b) v) := by rw [SA.add_comm b u]
    _ = SA.add a (SA.add u (SA.add b v)) := by rw [SA.add_assoc u b v]
    _ = SA.add (SA.add a u) (SA.add b v) := (SA.add_assoc a u (SA.add b v)).symm
    _ = SA.add (SA.add a (SA.smul (-1) a')) (SA.add b (SA.smul (-1) b')) := rfl
    _ = SA.add x y := rfl
  show SA.add (SA.add a b) (SA.smul (-1) (SA.add a' b')) ∈ I
  rw [h]
  exact hI.add_mem x y hx hy

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_compatible_with_multiplication`：
a ≡_I a' かつ b ≡_I b' ならば a ·_A b ≡_I a' ·_A b'。p := a' ·_A b と置き、
準備の ((-1_ℂ) ∗_A p) +_A p = 0_A を五行、a ·_A b を引いた元 = (x ·_A b) +_A (a' ·_A y) を十行で示す。 -/
theorem congruent_mul {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a a' b b' : A) (ha : Congruent SA I a a') (hb : Congruent SA I b b') :
    Congruent SA I (SA.mul a b) (SA.mul a' b') := by
  let x : A := SA.add a (SA.smul (-1) a')
  let y : A := SA.add b (SA.smul (-1) b')
  have hx : x ∈ I := ha
  have hy : y ∈ I := hb
  let p : A := SA.mul a' b
  have hprep : SA.add (SA.smul (-1) p) p = SA.zero := calc
    SA.add (SA.smul (-1) p) p = SA.add (SA.smul (-1) p) (SA.smul 1 p) := by rw [SA.one_smul p]
    _ = SA.smul ((-1) + 1) p := (SA.add_smul (-1) 1 p).symm
    _ = SA.smul (1 + (-1)) p := by rw [_root_.add_comm (-1 : ℂ) 1]
    _ = SA.smul 0 p := by rw [add_neg_cancel (1 : ℂ)]
    _ = SA.zero := zero_smul_eq_zero SA p
  have h : SA.add (SA.mul a b) (SA.smul (-1) (SA.mul a' b'))
      = SA.add (SA.mul x b) (SA.mul a' y) := calc
    SA.add (SA.mul a b) (SA.smul (-1) (SA.mul a' b'))
        = SA.add (SA.add (SA.mul a b) SA.zero) (SA.smul (-1) (SA.mul a' b')) := by
          rw [SA.add_zero (SA.mul a b)]
    _ = SA.add (SA.add (SA.mul a b) (SA.add (SA.smul (-1) p) p)) (SA.smul (-1) (SA.mul a' b')) := by
          rw [hprep]
    _ = SA.add (SA.add (SA.add (SA.mul a b) (SA.smul (-1) p)) p) (SA.smul (-1) (SA.mul a' b')) := by
          rw [SA.add_assoc (SA.mul a b) (SA.smul (-1) p) p]
    _ = SA.add (SA.add (SA.mul a b) (SA.smul (-1) p)) (SA.add p (SA.smul (-1) (SA.mul a' b'))) :=
          SA.add_assoc (SA.add (SA.mul a b) (SA.smul (-1) p)) p (SA.smul (-1) (SA.mul a' b'))
    _ = SA.add (SA.add (SA.mul a b) (SA.smul (-1) (SA.mul a' b)))
          (SA.add (SA.mul a' b) (SA.smul (-1) (SA.mul a' b'))) := rfl
    _ = SA.add (SA.add (SA.mul a b) (SA.mul (SA.smul (-1) a') b))
          (SA.add (SA.mul a' b) (SA.smul (-1) (SA.mul a' b'))) := by
          rw [SA.smul_mul_left (-1) a' b]
    _ = SA.add (SA.add (SA.mul a b) (SA.mul (SA.smul (-1) a') b))
          (SA.add (SA.mul a' b) (SA.mul a' (SA.smul (-1) b'))) := by
          rw [SA.smul_mul_right (-1) a' b']
    _ = SA.add (SA.mul (SA.add a (SA.smul (-1) a')) b)
          (SA.add (SA.mul a' b) (SA.mul a' (SA.smul (-1) b'))) := by
          rw [SA.right_distrib a (SA.smul (-1) a') b]
    _ = SA.add (SA.mul (SA.add a (SA.smul (-1) a')) b)
          (SA.mul a' (SA.add b (SA.smul (-1) b'))) := by
          rw [SA.left_distrib a' b (SA.smul (-1) b')]
    _ = SA.add (SA.mul x b) (SA.mul a' y) := rfl
  show SA.add (SA.mul a b) (SA.smul (-1) (SA.mul a' b')) ∈ I
  rw [h]
  exact hI.add_mem (SA.mul x b) (SA.mul a' y) (hI.mul_mem_right x b hx) (hI.mul_mem_left a' y hy)

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_compatible_with_scalar_multiplication`：
a ≡_I a' ならば λ ∗_A a ≡_I λ ∗_A a'。λ ∗_A a から λ ∗_A a' を引いた元 = λ ∗_A x を五行で示す。 -/
theorem congruent_smul {SA : ComplexAlgebra A} {I : Set A} (hI : IsTwoSidedIdeal SA I) (l : ℂ)
    (a a' : A) (ha : Congruent SA I a a') :
    Congruent SA I (SA.smul l a) (SA.smul l a') := by
  let x : A := SA.add a (SA.smul (-1) a')
  have hx : x ∈ I := ha
  have h : SA.add (SA.smul l a) (SA.smul (-1) (SA.smul l a')) = SA.smul l x := calc
    SA.add (SA.smul l a) (SA.smul (-1) (SA.smul l a'))
        = SA.add (SA.smul l a) (SA.smul ((-1) * l) a') := by rw [SA.smul_assoc (-1) l a']
    _ = SA.add (SA.smul l a) (SA.smul (l * (-1)) a') := by rw [_root_.mul_comm (-1 : ℂ) l]
    _ = SA.add (SA.smul l a) (SA.smul l (SA.smul (-1) a')) := by rw [SA.smul_assoc l (-1) a']
    _ = SA.smul l (SA.add a (SA.smul (-1) a')) := (SA.smul_add l a (SA.smul (-1) a')).symm
    _ = SA.smul l x := rfl
  show SA.add (SA.smul l a) (SA.smul (-1) (SA.smul l a')) ∈ I
  rw [h]
  exact hI.smul_mem l x hx

end CliffordMatrixIsomorphism.ComplexAlgebra
