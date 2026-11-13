/-
節「両側イデアルと商代数」のうち、合同・剰余類・商集合・射影と、合同が演算と両立することの必要十分版。
具体版 `MathematicalToolkit/IdealAndQuotientAlgebra/Congruence.lean` と同じ def・calc の行で、係数 ℂ を型の変数 K に替えて書く。

本文の合同は「1_ℂ の加法の逆元」-1_ℂ を使って a +_A ((-1_ℂ) ∗_A b) ∈ I と定める。必要十分版では、この元を
K の元 n として合同の定義の引数に置く。n が 1 の加法の逆元であること（1 + n = 0）は、定義には含めず、
使う主張の仮定に置く。

各主張が実際に使う K の性質（n は合同の定義に置いた元）:

  congruent_refl     1 + n = 0、0 + 0 = 0
  congruent_symm     n · n = 1
  congruent_trans    n + 1 = 1 + n、1 + n = 0、0 + 0 = 0
  residueClass_eq_iff 上の三つを合わせたもの（`CongruenceLaws` にまとめる）
  congruent_add      使わない（使うのは A の加法の結合法則・交換法則と、ベクトルの加法についての分配法則だけ）
  congruent_mul      n + 1 = 1 + n、1 + n = 0、0 + 0 = 0
  congruent_smul     n · λ = λ · n（すべての λ。乗法の交換法則のうち n との交換だけ）

具体版の (-1)·(-1) = 1（`norm_num`）・(-1)+1 = 1+(-1)（加法の交換法則）・(-1)·λ = λ·(-1)（乗法の交換法則）の行が、
それぞれ n · n = 1・n + 1 = 1 + n・n · λ = λ · n の仮定に当たる。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.IdealAndQuotientAlgebra.TwoSidedIdeal

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A : Type u}

/-- 剰余類の同値（`residueClass_eq_iff`）と、それを引く商の構成が使う、合同の元 n と K についての三つの性質と 0 + 0 = 0。 -/
structure CongruenceLaws (K : Type uK) [Add K] [Mul K] [One K] [Zero K] (n : K) : Prop where
  /-- 零のスカラー倍が零ベクトルであること（反射性・推移性）に要る -/
  zero_add_zero : (0 : K) + 0 = 0
  /-- n は 1 の加法の逆元（反射性・推移性） -/
  one_add_n : 1 + n = 0
  /-- (-1)+1 = 1+(-1) の行（推移性） -/
  n_add_one : n + 1 = 1 + n
  /-- (-1)·(-1) = 1 の行（対称性） -/
  n_mul_n : n * n = 1

/-- 本文 `def_congruence_modulo_two_sided_ideal` の必要十分版：a ≡_I b :⟺ a +_A (n ∗_A b) ∈ I。 -/
def Congruent (SA : AlgebraOver K A) (n : K) (I : Set A) (a b : A) : Prop :=
  SA.add a (SA.smul n b) ∈ I

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_reflexive` の必要十分版。 -/
theorem congruent_refl [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (h1n : 1 + n = 0) (h00 : (0 : K) + 0 = 0) (a : A) : Congruent SA n I a a := by
  have h : SA.add a (SA.smul n a) = SA.zero := calc
    SA.add a (SA.smul n a) = SA.add (SA.smul 1 a) (SA.smul n a) := by rw [SA.one_smul a]
    _ = SA.smul (1 + n) a := (SA.add_smul 1 n a).symm
    _ = SA.smul 0 a := by rw [h1n]
    _ = SA.zero := zero_smul_eq_zero SA h00 a
  show SA.add a (SA.smul n a) ∈ I
  rw [h]
  exact hI.zero_mem

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_symmetric` の必要十分版。 -/
theorem congruent_symm {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (hnn : n * n = 1) (a b : A) (hab : Congruent SA n I a b) : Congruent SA n I b a := by
  let x : A := SA.add a (SA.smul n b)
  have hx : x ∈ I := hab
  have h : SA.add b (SA.smul n a) = SA.smul n x := calc
    SA.add b (SA.smul n a) = SA.add (SA.smul n a) b := SA.add_comm b (SA.smul n a)
    _ = SA.add (SA.smul n a) (SA.smul 1 b) := by rw [SA.one_smul b]
    _ = SA.add (SA.smul n a) (SA.smul (n * n) b) := by rw [hnn]
    _ = SA.add (SA.smul n a) (SA.smul n (SA.smul n b)) := by rw [SA.smul_assoc n n b]
    _ = SA.smul n (SA.add a (SA.smul n b)) := (SA.smul_add n a (SA.smul n b)).symm
    _ = SA.smul n x := rfl
  show SA.add b (SA.smul n a) ∈ I
  rw [h]
  exact hI.smul_mem n x hx

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_transitive` の必要十分版。 -/
theorem congruent_trans [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (hn1 : n + 1 = 1 + n) (h1n : 1 + n = 0) (h00 : (0 : K) + 0 = 0) (a b c : A)
    (hab : Congruent SA n I a b) (hbc : Congruent SA n I b c) : Congruent SA n I a c := by
  let x : A := SA.add a (SA.smul n b)
  let y : A := SA.add b (SA.smul n c)
  have hx : x ∈ I := hab
  have hy : y ∈ I := hbc
  have hprep : SA.add (SA.smul n b) b = SA.zero := calc
    SA.add (SA.smul n b) b = SA.add (SA.smul n b) (SA.smul 1 b) := by rw [SA.one_smul b]
    _ = SA.smul (n + 1) b := (SA.add_smul n 1 b).symm
    _ = SA.smul (1 + n) b := by rw [hn1]
    _ = SA.smul 0 b := by rw [h1n]
    _ = SA.zero := zero_smul_eq_zero SA h00 b
  have h : SA.add a (SA.smul n c) = SA.add x y := calc
    SA.add a (SA.smul n c) = SA.add (SA.add a SA.zero) (SA.smul n c) := by rw [SA.add_zero a]
    _ = SA.add (SA.add a (SA.add (SA.smul n b) b)) (SA.smul n c) := by rw [hprep]
    _ = SA.add (SA.add (SA.add a (SA.smul n b)) b) (SA.smul n c) := by
          rw [SA.add_assoc a (SA.smul n b) b]
    _ = SA.add (SA.add a (SA.smul n b)) (SA.add b (SA.smul n c)) :=
          SA.add_assoc (SA.add a (SA.smul n b)) b (SA.smul n c)
    _ = SA.add x y := rfl
  show SA.add a (SA.smul n c) ∈ I
  rw [h]
  exact hI.add_mem x y hx hy

/-- 本文 `def_residue_class_modulo_two_sided_ideal` の必要十分版。 -/
def residueClass (SA : AlgebraOver K A) (n : K) (I : Set A) (a : A) : Set A :=
  {b : A | Congruent SA n I a b}

/-- 本文 `claim_residue_classes_are_equal_iff_congruent` の必要十分版。 -/
theorem residueClass_eq_iff [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (hL : CongruenceLaws K n) (a b : A) :
    residueClass SA n I a = residueClass SA n I b ↔ Congruent SA n I a b := by
  constructor
  · intro h
    have hb : b ∈ residueClass SA n I b := congruent_refl hI hL.one_add_n hL.zero_add_zero b
    have hb' : b ∈ residueClass SA n I a := by rw [h]; exact hb
    exact hb'
  · intro hab
    have hba : Congruent SA n I b a := congruent_symm hI hL.n_mul_n a b hab
    apply Set.Subset.antisymm
    · intro c hc
      exact congruent_trans hI hL.n_add_one hL.one_add_n hL.zero_add_zero b a c hba hc
    · intro c hc
      exact congruent_trans hI hL.n_add_one hL.one_add_n hL.zero_add_zero a b c hab hc

/-- 本文 `def_quotient_set_modulo_two_sided_ideal` の必要十分版。 -/
def QuotientSet (SA : AlgebraOver K A) (n : K) (I : Set A) : Type u :=
  {X : Set A // ∃ a : A, X = residueClass SA n I a}

/-- 本文 `def_projection_onto_quotient_set` の必要十分版。 -/
def projection (SA : AlgebraOver K A) (n : K) (I : Set A) (a : A) : QuotientSet SA n I :=
  ⟨residueClass SA n I a, a, rfl⟩

/-- 本文 `claim_projection_onto_quotient_set_is_surjective` の必要十分版。K の性質を使わない。 -/
theorem projection_surjective (SA : AlgebraOver K A) (n : K) (I : Set A) (X : QuotientSet SA n I) :
    ∃ a : A, projection SA n I a = X := by
  obtain ⟨a, ha⟩ := X.2
  refine ⟨a, Subtype.ext ?_⟩
  calc (projection SA n I a).1 = residueClass SA n I a := rfl
    _ = X.1 := ha.symm

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_compatible_with_addition` の必要十分版。K の性質を使わない。 -/
theorem congruent_add {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (a a' b b' : A) (ha : Congruent SA n I a a') (hb : Congruent SA n I b b') :
    Congruent SA n I (SA.add a b) (SA.add a' b') := by
  let x : A := SA.add a (SA.smul n a')
  let y : A := SA.add b (SA.smul n b')
  have hx : x ∈ I := ha
  have hy : y ∈ I := hb
  let u : A := SA.smul n a'
  let v : A := SA.smul n b'
  have h : SA.add (SA.add a b) (SA.smul n (SA.add a' b')) = SA.add x y := calc
    SA.add (SA.add a b) (SA.smul n (SA.add a' b'))
        = SA.add (SA.add a b) (SA.add (SA.smul n a') (SA.smul n b')) := by
          rw [SA.smul_add n a' b']
    _ = SA.add (SA.add a b) (SA.add u v) := rfl
    _ = SA.add a (SA.add b (SA.add u v)) := SA.add_assoc a b (SA.add u v)
    _ = SA.add a (SA.add (SA.add b u) v) := by rw [SA.add_assoc b u v]
    _ = SA.add a (SA.add (SA.add u b) v) := by rw [SA.add_comm b u]
    _ = SA.add a (SA.add u (SA.add b v)) := by rw [SA.add_assoc u b v]
    _ = SA.add (SA.add a u) (SA.add b v) := (SA.add_assoc a u (SA.add b v)).symm
    _ = SA.add (SA.add a (SA.smul n a')) (SA.add b (SA.smul n b')) := rfl
    _ = SA.add x y := rfl
  show SA.add (SA.add a b) (SA.smul n (SA.add a' b')) ∈ I
  rw [h]
  exact hI.add_mem x y hx hy

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_compatible_with_multiplication` の必要十分版。 -/
theorem congruent_mul [Zero K] {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (hn1 : n + 1 = 1 + n) (h1n : 1 + n = 0) (h00 : (0 : K) + 0 = 0)
    (a a' b b' : A) (ha : Congruent SA n I a a') (hb : Congruent SA n I b b') :
    Congruent SA n I (SA.mul a b) (SA.mul a' b') := by
  let x : A := SA.add a (SA.smul n a')
  let y : A := SA.add b (SA.smul n b')
  have hx : x ∈ I := ha
  have hy : y ∈ I := hb
  let p : A := SA.mul a' b
  have hprep : SA.add (SA.smul n p) p = SA.zero := calc
    SA.add (SA.smul n p) p = SA.add (SA.smul n p) (SA.smul 1 p) := by rw [SA.one_smul p]
    _ = SA.smul (n + 1) p := (SA.add_smul n 1 p).symm
    _ = SA.smul (1 + n) p := by rw [hn1]
    _ = SA.smul 0 p := by rw [h1n]
    _ = SA.zero := zero_smul_eq_zero SA h00 p
  have h : SA.add (SA.mul a b) (SA.smul n (SA.mul a' b'))
      = SA.add (SA.mul x b) (SA.mul a' y) := calc
    SA.add (SA.mul a b) (SA.smul n (SA.mul a' b'))
        = SA.add (SA.add (SA.mul a b) SA.zero) (SA.smul n (SA.mul a' b')) := by
          rw [SA.add_zero (SA.mul a b)]
    _ = SA.add (SA.add (SA.mul a b) (SA.add (SA.smul n p) p)) (SA.smul n (SA.mul a' b')) := by
          rw [hprep]
    _ = SA.add (SA.add (SA.add (SA.mul a b) (SA.smul n p)) p) (SA.smul n (SA.mul a' b')) := by
          rw [SA.add_assoc (SA.mul a b) (SA.smul n p) p]
    _ = SA.add (SA.add (SA.mul a b) (SA.smul n p)) (SA.add p (SA.smul n (SA.mul a' b'))) :=
          SA.add_assoc (SA.add (SA.mul a b) (SA.smul n p)) p (SA.smul n (SA.mul a' b'))
    _ = SA.add (SA.add (SA.mul a b) (SA.smul n (SA.mul a' b)))
          (SA.add (SA.mul a' b) (SA.smul n (SA.mul a' b'))) := rfl
    _ = SA.add (SA.add (SA.mul a b) (SA.mul (SA.smul n a') b))
          (SA.add (SA.mul a' b) (SA.smul n (SA.mul a' b'))) := by
          rw [SA.smul_mul_left n a' b]
    _ = SA.add (SA.add (SA.mul a b) (SA.mul (SA.smul n a') b))
          (SA.add (SA.mul a' b) (SA.mul a' (SA.smul n b'))) := by
          rw [SA.smul_mul_right n a' b']
    _ = SA.add (SA.mul (SA.add a (SA.smul n a')) b)
          (SA.add (SA.mul a' b) (SA.mul a' (SA.smul n b'))) := by
          rw [SA.right_distrib a (SA.smul n a') b]
    _ = SA.add (SA.mul (SA.add a (SA.smul n a')) b)
          (SA.mul a' (SA.add b (SA.smul n b'))) := by
          rw [SA.left_distrib a' b (SA.smul n b')]
    _ = SA.add (SA.mul x b) (SA.mul a' y) := rfl
  show SA.add (SA.mul a b) (SA.smul n (SA.mul a' b')) ∈ I
  rw [h]
  exact hI.add_mem (SA.mul x b) (SA.mul a' y) (hI.mul_mem_right x b hx) (hI.mul_mem_left a' y hy)

/-- 本文 `claim_congruence_modulo_two_sided_ideal_is_compatible_with_scalar_multiplication` の必要十分版。
具体版の (-1)·λ = λ·(-1) の行が、n と λ の交換 `hcomm` に当たる。 -/
theorem congruent_smul {SA : AlgebraOver K A} {n : K} {I : Set A} (hI : IsTwoSidedIdeal SA I)
    (hcomm : ∀ l : K, n * l = l * n) (l : K) (a a' : A) (ha : Congruent SA n I a a') :
    Congruent SA n I (SA.smul l a) (SA.smul l a') := by
  let x : A := SA.add a (SA.smul n a')
  have hx : x ∈ I := ha
  have h : SA.add (SA.smul l a) (SA.smul n (SA.smul l a')) = SA.smul l x := calc
    SA.add (SA.smul l a) (SA.smul n (SA.smul l a'))
        = SA.add (SA.smul l a) (SA.smul (n * l) a') := by rw [SA.smul_assoc n l a']
    _ = SA.add (SA.smul l a) (SA.smul (l * n) a') := by rw [hcomm l]
    _ = SA.add (SA.smul l a) (SA.smul l (SA.smul n a')) := by rw [SA.smul_assoc l n a']
    _ = SA.smul l (SA.add a (SA.smul n a')) := (SA.smul_add l a (SA.smul n a')).symm
    _ = SA.smul l x := rfl
  show SA.add (SA.smul l a) (SA.smul n (SA.smul l a')) ∈ I
  rw [h]
  exact hI.smul_mem l x hx

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver
