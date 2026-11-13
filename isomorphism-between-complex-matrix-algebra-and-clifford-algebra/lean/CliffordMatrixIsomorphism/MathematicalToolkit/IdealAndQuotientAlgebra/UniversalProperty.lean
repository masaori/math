/-
節「両側イデアルと商代数」のうち、商代数の普遍性（両側イデアルの元を零へ移す準同型が商代数の上に誘導する写像）の具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                       このファイル
  claim_homomorphism_vanishing_on_ideal_takes_equal_values_on_congruent_elements     map_eq_of_congruent
  def_map_induced_on_quotient_algebra                                                inducedMap（φ̄）と、
                                                                                     代表のとり方によらないこと inducedMap_eq
  claim_induced_map_composed_with_projection_is_original_homomorphism                inducedMap_projection
  claim_induced_map_is_algebra_homomorphism                                          inducedMap_isComplexAlgebraHomomorphism
  claim_homomorphism_from_quotient_algebra_composing_with_projection_is_unique eq_inducedMap_of_comp_eq

φ̄(X) := φ(a)（π_I(a) = X）の代表は、商代数の演算と同じく `rep X` を選んで定め、任意の代表で開いてよいことを
`inducedMap_eq` として示す（本文の定義の後半）。

必要十分版は `NecSuf/MathematicalToolkit/IdealAndQuotientAlgebra/UniversalProperty.lean`、
導出版は `IdealAndQuotientAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.IdealAndQuotientAlgebra.QuotientAlgebra

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u v

variable {A : Type u} {B : Type v}

/-- 本文 `claim_homomorphism_vanishing_on_ideal_takes_equal_values_on_congruent_elements`：
I の上で 0_B をとる準同型 φ について、a ≡_I a' ならば φ(a) = φ(a')。
x := a +_A ((-1_ℂ) ∗_A a')、y := φ(a') と置き、準備の ((-1_ℂ) ∗_B y) +_B y = 0_B を五行、φ(a) = φ(a') を十一行で示す。 -/
theorem map_eq_of_congruent {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {I : Set A} {φ : A → B}
    (hφ : IsComplexAlgebraHomomorphism SA SB φ) (hφI : ∀ x ∈ I, φ x = SB.zero) (a a' : A)
    (haa' : Congruent SA I a a') : φ a = φ a' := by
  let x : A := SA.add a (SA.smul (-1) a')
  have hx : x ∈ I := haa'
  have hφx : φ x = SB.zero := hφI x hx
  let y : B := φ a'
  have hprep : SB.add (SB.smul (-1) y) y = SB.zero := calc
    SB.add (SB.smul (-1) y) y = SB.add (SB.smul (-1) y) (SB.smul 1 y) := by rw [SB.one_smul y]
    _ = SB.smul ((-1) + 1) y := (SB.add_smul (-1) 1 y).symm
    _ = SB.smul (1 + (-1)) y := by rw [_root_.add_comm (-1 : ℂ) 1]
    _ = SB.smul 0 y := by rw [add_neg_cancel (1 : ℂ)]
    _ = SB.zero := zero_smul_eq_zero SB y
  calc φ a = SB.add (φ a) SB.zero := (SB.add_zero (φ a)).symm
    _ = SB.add (φ a) (SB.add (SB.smul (-1) y) y) := by rw [hprep]
    _ = SB.add (SB.add (φ a) (SB.smul (-1) y)) y := (SB.add_assoc (φ a) (SB.smul (-1) y) y).symm
    _ = SB.add (SB.add (φ a) (SB.smul (-1) (φ a'))) y := rfl
    _ = SB.add (SB.add (φ a) (φ (SA.smul (-1) a'))) y := by rw [hφ.map_smul (-1) a']
    _ = SB.add (φ (SA.add a (SA.smul (-1) a'))) y := by rw [hφ.map_add a (SA.smul (-1) a')]
    _ = SB.add (φ x) y := rfl
    _ = SB.add SB.zero y := by rw [hφx]
    _ = SB.add y SB.zero := SB.add_comm SB.zero y
    _ = y := SB.add_zero y
    _ = φ a' := rfl

/-- 本文 `def_map_induced_on_quotient_algebra`：φ̄(X) := φ(a)（π_I(a) = X となる a を一つ選ぶ）。 -/
noncomputable def inducedMap (SA : ComplexAlgebra A) (I : Set A) (φ : A → B) (X : QuotientSet SA I) : B :=
  φ (rep X)

/-- 本文 `def_map_induced_on_quotient_algebra` の後半：右辺は代表のとり方によらない。
[a]_I = π_I(a) = X = π_I(a') = [a']_I から a ≡_I a'（同値の ⇒）、合同な元に同じ値をとることで φ(a) = φ(a')。 -/
theorem inducedMap_eq {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {I : Set A} {φ : A → B}
    (hI : IsTwoSidedIdeal SA I) (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (X : QuotientSet SA I) (a : A) (ha : projection SA I a = X) :
    inducedMap SA I φ X = φ a := by
  have hres : residueClass SA I (rep X) = residueClass SA I a := calc
    residueClass SA I (rep X) = (projection SA I (rep X)).1 := rfl
    _ = X.1 := by rw [projection_rep X]
    _ = (projection SA I a).1 := by rw [ha]
    _ = residueClass SA I a := rfl
  exact map_eq_of_congruent hφ hφI (rep X) a ((residueClass_eq_iff hI (rep X) a).1 hres)

/-- 本文 `claim_induced_map_composed_with_projection_is_original_homomorphism`：φ̄(π_I(a)) = φ(a)。
X := π_I(a) の代表に a 自身をとる。 -/
theorem inducedMap_projection {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {I : Set A} {φ : A → B}
    (hI : IsTwoSidedIdeal SA I) (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (a : A) : inducedMap SA I φ (projection SA I a) = φ a :=
  inducedMap_eq hI hφ hφI (projection SA I a) a rfl

/-- 本文 `claim_induced_map_is_algebra_homomorphism`：φ̄ は商代数 A/I から B への ℂ-代数の準同型。
X, Y の代表 a, b を全射性でとり、四つの等式をそれぞれ六行・三行の鎖で示す。 -/
theorem inducedMap_isComplexAlgebraHomomorphism {SA : ComplexAlgebra A} {SB : ComplexAlgebra B}
    {I : Set A} {φ : A → B} (hI : IsTwoSidedIdeal SA I) (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) :
    IsComplexAlgebraHomomorphism (quotientAlgebra hI) SB (inducedMap SA I φ) := by
  have hcomp := inducedMap_projection hI hφ hφI
  have hadd : ∀ X Y : QuotientSet SA I,
      inducedMap SA I φ (quotientAdd SA I X Y) = SB.add (inducedMap SA I φ X) (inducedMap SA I φ Y) := by
    intro X Y
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    calc inducedMap SA I φ (quotientAdd SA I (projection SA I a) (projection SA I b))
        = inducedMap SA I φ (projection SA I (SA.add a b)) := by rw [projection_add hI a b]
      _ = φ (SA.add a b) := hcomp (SA.add a b)
      _ = SB.add (φ a) (φ b) := hφ.map_add a b
      _ = SB.add (inducedMap SA I φ (projection SA I a)) (inducedMap SA I φ (projection SA I b)) := by
          rw [hcomp a, hcomp b]
  have hmul : ∀ X Y : QuotientSet SA I,
      inducedMap SA I φ (quotientMul SA I X Y) = SB.mul (inducedMap SA I φ X) (inducedMap SA I φ Y) := by
    intro X Y
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    obtain ⟨b, rfl⟩ := projection_surjective SA I Y
    calc inducedMap SA I φ (quotientMul SA I (projection SA I a) (projection SA I b))
        = inducedMap SA I φ (projection SA I (SA.mul a b)) := by rw [projection_mul hI a b]
      _ = φ (SA.mul a b) := hcomp (SA.mul a b)
      _ = SB.mul (φ a) (φ b) := hφ.map_mul a b
      _ = SB.mul (inducedMap SA I φ (projection SA I a)) (inducedMap SA I φ (projection SA I b)) := by
          rw [hcomp a, hcomp b]
  have hone : inducedMap SA I φ (quotientOne SA I) = SB.one := calc
    inducedMap SA I φ (quotientOne SA I) = inducedMap SA I φ (projection SA I SA.one) := rfl
    _ = φ SA.one := hcomp SA.one
    _ = SB.one := hφ.map_one
  have hsmul : ∀ (l : ℂ) (X : QuotientSet SA I),
      inducedMap SA I φ (quotientSmul SA I l X) = SB.smul l (inducedMap SA I φ X) := by
    intro l X
    obtain ⟨a, rfl⟩ := projection_surjective SA I X
    calc inducedMap SA I φ (quotientSmul SA I l (projection SA I a))
        = inducedMap SA I φ (projection SA I (SA.smul l a)) := by rw [projection_smul hI l a]
      _ = φ (SA.smul l a) := hcomp (SA.smul l a)
      _ = SB.smul l (φ a) := hφ.map_smul l a
      _ = SB.smul l (inducedMap SA I φ (projection SA I a)) := by rw [hcomp a]
  exact ⟨⟨hadd, hmul, hone⟩, ⟨hadd, hsmul⟩⟩

/-- 本文 `claim_homomorphism_from_quotient_algebra_composing_with_projection_is_unique`：
商代数からの準同型 ψ が ψ(π_I(a)) = φ(a) を満たすなら ψ = φ̄。X の代表 a を全射性でとる。 -/
theorem eq_inducedMap_of_comp_eq {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {I : Set A}
    {φ : A → B} (hI : IsTwoSidedIdeal SA I) (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hφI : ∀ x ∈ I, φ x = SB.zero) (ψ : QuotientSet SA I → B)
    (_hψ : IsComplexAlgebraHomomorphism (quotientAlgebra hI) SB ψ)
    (hψφ : ∀ a : A, ψ (projection SA I a) = φ a) (X : QuotientSet SA I) :
    ψ X = inducedMap SA I φ X := by
  obtain ⟨a, rfl⟩ := projection_surjective SA I X
  calc ψ (projection SA I a) = φ a := hψφ a
    _ = inducedMap SA I φ (projection SA I a) := (inducedMap_projection hI hφ hφI a).symm

end CliffordMatrixIsomorphism.ComplexAlgebra
