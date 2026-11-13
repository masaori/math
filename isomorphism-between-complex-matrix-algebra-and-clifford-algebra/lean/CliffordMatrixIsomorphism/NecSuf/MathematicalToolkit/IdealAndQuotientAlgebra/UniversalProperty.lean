/-
節「両側イデアルと商代数」のうち、商代数の普遍性の必要十分版。具体版
`MathematicalToolkit/IdealAndQuotientAlgebra/UniversalProperty.lean` と同じ def・calc の行で、係数 ℂ を型の変数 K に替え、
合同の -1_ℂ を K の元 n に替えて書く。docstring の式は本文の記号（-1_ℂ）のまま引く。

各主張が実際に使う K の性質:

  map_eq_of_congruent                    n + 1 = 1 + n、1 + n = 0、0 + 0 = 0（準備の ((-1_ℂ) ∗_B y) +_B y = 0_B の五行）
  inducedMap の定義                       使わない
  inducedMap_eq・inducedMap_projection    `CongruenceLaws K n`（剰余類の同値と、上の主張を経由する）
  inducedMap_isAlgebraHomomorphism・eq_inducedMap_of_comp_eq
                                         `CongruenceLaws K n` と n · λ = λ · n（始域の商代数が K-代数であることに要る）
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.IdealAndQuotientAlgebra.QuotientAlgebra

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u v uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A : Type u} {B : Type v}

/-- 本文 `claim_homomorphism_vanishing_on_ideal_takes_equal_values_on_congruent_elements`：
I の上で 0_B をとる準同型 φ について、a ≡_I a' ならば φ(a) = φ(a')。
x := a +_A ((-1_ℂ) ∗_A a')、y := φ(a') と置き、準備の ((-1_ℂ) ∗_B y) +_B y = 0_B を五行、φ(a) = φ(a') を十一行で示す。 -/
theorem map_eq_of_congruent [Zero K] {SA : AlgebraOver K A} {SB : AlgebraOver K B} {n : K} {I : Set A} {φ : A → B}
    (hφ : IsAlgebraHomomorphism SA SB φ) (hφI : ∀ x ∈ I, φ x = SB.zero) (hn1 : n + 1 = 1 + n) (h1n : 1 + n = 0)
    (h00 : (0 : K) + 0 = 0) (a a' : A) (haa' : Congruent SA n I a a') : φ a = φ a' := by
  let x : A := SA.add a (SA.smul n a')
  have hx : x ∈ I := haa'
  have hφx : φ x = SB.zero := hφI x hx
  let y : B := φ a'
  have hprep : SB.add (SB.smul n y) y = SB.zero := calc
    SB.add (SB.smul n y) y = SB.add (SB.smul n y) (SB.smul 1 y) := by rw [SB.one_smul y]
    _ = SB.smul (n + 1) y := (SB.add_smul n 1 y).symm
    _ = SB.smul (1 + n) y := by rw [hn1]
    _ = SB.smul 0 y := by rw [h1n]
    _ = SB.zero := zero_smul_eq_zero SB h00 y
  calc φ a = SB.add (φ a) SB.zero := (SB.add_zero (φ a)).symm
    _ = SB.add (φ a) (SB.add (SB.smul n y) y) := by rw [hprep]
    _ = SB.add (SB.add (φ a) (SB.smul n y)) y := (SB.add_assoc (φ a) (SB.smul n y) y).symm
    _ = SB.add (SB.add (φ a) (SB.smul n (φ a'))) y := rfl
    _ = SB.add (SB.add (φ a) (φ (SA.smul n a'))) y := by rw [hφ.map_smul n a']
    _ = SB.add (φ (SA.add a (SA.smul n a'))) y := by rw [hφ.map_add a (SA.smul n a')]
    _ = SB.add (φ x) y := rfl
    _ = SB.add SB.zero y := by rw [hφx]
    _ = SB.add y SB.zero := SB.add_comm SB.zero y
    _ = y := SB.add_zero y
    _ = φ a' := rfl

/-- 本文 `def_map_induced_on_quotient_algebra`：φ̄(X) := φ(a)（π_I(a) = X となる a を一つ選ぶ）。 -/
noncomputable def inducedMap (SA : AlgebraOver K A) (n : K) (I : Set A) (φ : A → B) (X : QuotientSet SA n I) : B :=
  φ (rep X)

/-- 本文 `def_map_induced_on_quotient_algebra` の後半：右辺は代表のとり方によらない。
[a]_I = π_I(a) = X = π_I(a') = [a']_I から a ≡_I a'（同値の ⇒）、合同な元に同じ値をとることで φ(a) = φ(a')。 -/
theorem inducedMap_eq [Zero K] {SA : AlgebraOver K A} {SB : AlgebraOver K B} {n : K} {I : Set A} {φ : A → B}
    (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hφ : IsAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (X : QuotientSet SA n I) (a : A) (ha : projection SA n I a = X) :
    inducedMap SA n I φ X = φ a := by
  have hres : residueClass SA n I (rep X) = residueClass SA n I a := calc
    residueClass SA n I (rep X) = (projection SA n I (rep X)).1 := rfl
    _ = X.1 := by rw [projection_rep X]
    _ = (projection SA n I a).1 := by rw [ha]
    _ = residueClass SA n I a := rfl
  exact map_eq_of_congruent hφ hφI hL.n_add_one hL.one_add_n hL.zero_add_zero (rep X) a ((residueClass_eq_iff hI hL (rep X) a).1 hres)

/-- 本文 `claim_induced_map_composed_with_projection_is_original_homomorphism`：φ̄(π_I(a)) = φ(a)。
X := π_I(a) の代表に a 自身をとる。 -/
theorem inducedMap_projection [Zero K] {SA : AlgebraOver K A} {SB : AlgebraOver K B} {n : K} {I : Set A} {φ : A → B}
    (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n) (hφ : IsAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (a : A) : inducedMap SA n I φ (projection SA n I a) = φ a :=
  inducedMap_eq hI hL hφ hφI (projection SA n I a) a rfl

/-- 本文 `claim_induced_map_is_algebra_homomorphism`：φ̄ は商代数 A/I から B への ℂ-代数の準同型。
X, Y の代表 a, b を全射性でとり、四つの等式をそれぞれ六行・三行の鎖で示す。 -/
theorem inducedMap_isAlgebraHomomorphism [Zero K] {SA : AlgebraOver K A} {SB : AlgebraOver K B}
    {n : K} {I : Set A} {φ : A → B} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n)
    (hcomm : ∀ l : K, n * l = l * n) (hφ : IsAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) :
    IsAlgebraHomomorphism (quotientAlgebra hI hL hcomm) SB (inducedMap SA n I φ) := by
  have hcomp := inducedMap_projection hI hL hφ hφI
  have hadd : ∀ X Y : QuotientSet SA n I,
      inducedMap SA n I φ (quotientAdd SA n I X Y) = SB.add (inducedMap SA n I φ X) (inducedMap SA n I φ Y) := by
    intro X Y
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    calc inducedMap SA n I φ (quotientAdd SA n I (projection SA n I a) (projection SA n I b))
        = inducedMap SA n I φ (projection SA n I (SA.add a b)) := by rw [projection_add hI hL a b]
      _ = φ (SA.add a b) := hcomp (SA.add a b)
      _ = SB.add (φ a) (φ b) := hφ.map_add a b
      _ = SB.add (inducedMap SA n I φ (projection SA n I a)) (inducedMap SA n I φ (projection SA n I b)) := by
          rw [hcomp a, hcomp b]
  have hmul : ∀ X Y : QuotientSet SA n I,
      inducedMap SA n I φ (quotientMul SA n I X Y) = SB.mul (inducedMap SA n I φ X) (inducedMap SA n I φ Y) := by
    intro X Y
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    obtain ⟨b, rfl⟩ := projection_surjective SA n I Y
    calc inducedMap SA n I φ (quotientMul SA n I (projection SA n I a) (projection SA n I b))
        = inducedMap SA n I φ (projection SA n I (SA.mul a b)) := by rw [projection_mul hI hL a b]
      _ = φ (SA.mul a b) := hcomp (SA.mul a b)
      _ = SB.mul (φ a) (φ b) := hφ.map_mul a b
      _ = SB.mul (inducedMap SA n I φ (projection SA n I a)) (inducedMap SA n I φ (projection SA n I b)) := by
          rw [hcomp a, hcomp b]
  have hone : inducedMap SA n I φ (quotientOne SA n I) = SB.one := calc
    inducedMap SA n I φ (quotientOne SA n I) = inducedMap SA n I φ (projection SA n I SA.one) := rfl
    _ = φ SA.one := hcomp SA.one
    _ = SB.one := hφ.map_one
  have hsmul : ∀ (l : K) (X : QuotientSet SA n I),
      inducedMap SA n I φ (quotientSmul SA n I l X) = SB.smul l (inducedMap SA n I φ X) := by
    intro l X
    obtain ⟨a, rfl⟩ := projection_surjective SA n I X
    calc inducedMap SA n I φ (quotientSmul SA n I l (projection SA n I a))
        = inducedMap SA n I φ (projection SA n I (SA.smul l a)) := by rw [projection_smul hI hL hcomm l a]
      _ = φ (SA.smul l a) := hcomp (SA.smul l a)
      _ = SB.smul l (φ a) := hφ.map_smul l a
      _ = SB.smul l (inducedMap SA n I φ (projection SA n I a)) := by rw [hcomp a]
  exact ⟨⟨hadd, hmul, hone⟩, ⟨hadd, hsmul⟩⟩

/-- 本文 `claim_homomorphism_from_quotient_algebra_composing_with_projection_is_unique`：
商代数からの準同型 ψ が ψ(π_I(a)) = φ(a) を満たすなら ψ = φ̄。X の代表 a を全射性でとる。 -/
theorem eq_inducedMap_of_comp_eq [Zero K] {SA : AlgebraOver K A} {SB : AlgebraOver K B} {n : K} {I : Set A}
    {φ : A → B} (hI : IsTwoSidedIdeal SA I) (hL : CongruenceLaws K n)
    (hcomm : ∀ l : K, n * l = l * n) (hφ : IsAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (ψ : QuotientSet SA n I → B)
    (_hψ : IsAlgebraHomomorphism (quotientAlgebra hI hL hcomm) SB ψ)
    (hψφ : ∀ a : A, ψ (projection SA n I a) = φ a) (X : QuotientSet SA n I) :
    ψ X = inducedMap SA n I φ X := by
  obtain ⟨a, rfl⟩ := projection_surjective SA n I X
  calc ψ (projection SA n I a) = φ a := hψφ a
    _ = inducedMap SA n I φ (projection SA n I a) := (inducedMap_projection hI hL hφ hφI a).symm

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver
