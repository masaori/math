/-
章「クリフォード代数」の節「分裂した二次空間のクリフォード代数の生成元」の具体版が、
必要十分版のこの節の主張の K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。

  具体版の主張                                   必要十分版の主張
  annihilation_creation_anticommute              NecSuf.Clifford.SplitData.annihilation_creation_anticommute
  creation_anticommute                           NecSuf.Clifford.SplitData.creation_anticommute
  annihilation_anticommute                       NecSuf.Clifford.SplitData.annihilation_anticommute
  creation_mul_self                              NecSuf.Clifford.SplitData.creation_mul_self
  annihilation_mul_self                          NecSuf.Clifford.SplitData.annihilation_mul_self

具体版の W^* は具体版の双対空間、必要十分版の W^* は必要十分版の双対空間で、二つは値の写像が同じ元を持つ別の部分型である。
したがって具体版のクリフォード代数 Cl と、具体版の前提を写した必要十分版の前提 `D.toNecSuf` のクリフォード代数 Cl' は別の集合である。
そこで二つの間に準同型を作って主張を運ぶ。
  - Φ : Cl → Cl' は、具体版のクリフォード代数の普遍性（必要十分版から得たもの）を、v ↦ γ'(v を写した点) に当てて得る。
  - Ψ : Cl' → Cl は、必要十分版のクリフォード代数の普遍性を、v' ↦ γ(v' を写し戻した点) に当てて得る。
  - Ψ ∘ Φ は γ(V) の上で恒等写像に一致するので、生成元で一致する準同型は等しいことから、すべての元で Ψ(Φ(x)) = x である。
  - Φ(a_i) = a'_i、Φ(a†_i) = a'†_i なので、具体版の主張の両辺の Φ による像は必要十分版の主張の両辺である。
    必要十分版の主張で両辺の像が等しく、Ψ を当てて両辺が等しい。
W ⊕ W^* の点を写す写像（`splitPointToNecSuf` と `splitPointOfNecSuf`）は、値の写像を変えないので、演算と q_W を定義により保つ。
-/
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.Generators
import CliffordMatrixIsomorphism.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.CliffordAlgebra.SplitQuadraticSpace.Generators

namespace CliffordMatrixIsomorphism.Clifford

open ComplexVectorSpace ComplexAlgebra

universe u

noncomputable section

namespace SplitData

variable {W : Type u} (D : SplitData W)

/-- 具体版の前提の組を、W^* の元を `DualSpace.toNecSuf` で写して、必要十分版の前提の組として読む。 -/
def toNecSuf : NecSuf.Clifford.SplitData ℂ W where
  spaceW := D.spaceW.toNecSuf
  M := D.M
  w := D.w
  isBasis := (isBasisFamily_iff_necSuf D.spaceW D.M D.w).1 D.isBasis
  f := fun k => (D.f k).toNecSuf
  isDualBasis := fun i j hi1 hiM hj1 hjM => D.isDualBasis i j hi1 hiM hj1 hjM

/-- 必要十分版の前提の組から作った、必要十分版の V := W ⊕ W^* と q_W と基底の組。 -/
abbrev spaceN : NecSuf.Clifford.QuadraticSpaceWithBasis ℂ (W × NecSuf.VectorSpace.DualSpace D.spaceW.toNecSuf) :=
  D.toNecSuf.space complexCliffordLaws

/-- 必要十分版のクリフォード代数を、具体版の ℂ-代数として読む（欄を写すだけ）。 -/
abbrev algebraN : ComplexAlgebra (D.spaceN.Cl complexCliffordLaws) :=
  TensorPowers.complexAlgebraOfNecSuf (D.spaceN.cliffordAlgebra complexCliffordLaws)

/-- 必要十分版の W ⊕ W^* の点を、具体版の点へ写し戻す。 -/
def splitPointOfNecSuf (p : W × NecSuf.VectorSpace.DualSpace D.spaceW.toNecSuf) : W × DualSpace D.spaceW :=
  (p.1, DualSpace.ofNecSuf p.2)

/-- v ↦ γ'(v を写した点)。 -/
def mapToN (p : W × DualSpace D.spaceW) : D.spaceN.Cl complexCliffordLaws :=
  D.spaceN.γ complexCliffordLaws (splitPointToNecSuf D.spaceW p)

/-- v' ↦ γ(v' を写し戻した点)。 -/
def mapOfN (p : W × NecSuf.VectorSpace.DualSpace D.spaceW.toNecSuf) : D.space.Cl :=
  D.space.γ (D.splitPointOfNecSuf p)

theorem mapToN_isLinearMap :
    IsComplexLinearMap D.space.space D.algebraN.toComplexVectorSpace D.mapToN := by
  rw [isComplexLinearMap_iff_necSuf]
  have hγ := D.spaceN.γ_isLinearMap complexCliffordLaws
  have hpt : NecSuf.VectorSpace.IsLinearMap D.space.space.toNecSuf D.spaceN.space (splitPointToNecSuf D.spaceW) :=
    ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  have h := NecSuf.VectorSpace.IsLinearMap.comp hpt hγ
  exact h

theorem mapToN_mul_self (p : W × DualSpace D.spaceW) :
    D.algebraN.mul (D.mapToN p) (D.mapToN p) = D.algebraN.smul (D.space.form p) D.algebraN.one :=
  D.spaceN.γ_mul_self complexCliffordLaws add_neg_cancel (splitPointToNecSuf D.spaceW p)

theorem mapOfN_isLinearMap :
    NecSuf.VectorSpace.IsLinearMap D.spaceN.space D.space.cliffordAlgebra.toNecSuf.toVectorSpace D.mapOfN := by
  have hγ := (isComplexLinearMap_iff_necSuf _ _ _).1 D.space.γ_isLinearMap_of_necSuf
  have hpt : NecSuf.VectorSpace.IsLinearMap D.spaceN.space D.space.space.toNecSuf D.splitPointOfNecSuf :=
    ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  have h := NecSuf.VectorSpace.IsLinearMap.comp hpt hγ
  exact h

theorem mapOfN_mul_self (p : W × NecSuf.VectorSpace.DualSpace D.spaceW.toNecSuf) :
    D.space.cliffordAlgebra.toNecSuf.mul (D.mapOfN p) (D.mapOfN p)
      = D.space.cliffordAlgebra.toNecSuf.smul (D.spaceN.form p) D.space.cliffordAlgebra.toNecSuf.one :=
  D.space.γ_mul_self_of_necSuf (D.splitPointOfNecSuf p)

/-- 具体版の普遍性から得る、Cl から Cl' への準同型 Φ と、Φ ∘ γ = γ' ∘（点を写す写像）。 -/
theorem exists_toN :
    ∃ Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws,
      IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.algebraN Φ ∧ ∀ p, Φ (D.space.γ p) = D.mapToN p := by
  obtain ⟨Φ, ⟨hΦ, hΦγ⟩, _⟩ :=
    D.space.universalProperty_of_necSuf D.algebraN D.mapToN D.mapToN_isLinearMap D.mapToN_mul_self
  exact ⟨Φ, hΦ, hΦγ⟩

/-- 必要十分版の普遍性から得る、Cl' から Cl への準同型 Ψ と、Ψ ∘ γ' = γ ∘（点を写し戻す写像）。 -/
theorem exists_ofN :
    ∃ Ψ : D.spaceN.Cl complexCliffordLaws → D.space.Cl,
      IsComplexAlgebraHomomorphism D.algebraN D.space.cliffordAlgebra Ψ ∧
        ∀ p, Ψ (D.spaceN.γ complexCliffordLaws p) = D.mapOfN p := by
  obtain ⟨Ψ, ⟨hΨ, hΨγ⟩, _⟩ := D.spaceN.universalProperty complexCliffordLaws add_neg_cancel
    D.space.cliffordAlgebra.toNecSuf D.mapOfN D.mapOfN_isLinearMap D.mapOfN_mul_self
  exact ⟨Ψ, (isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2 hΨ, hΨγ⟩

/-- Φ で写した両辺が等しければ、具体版の両辺も等しい（Ψ ∘ Φ が恒等写像であるため）。 -/
theorem eq_of_toN_eq {x y : D.space.Cl}
    (h : ∀ Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws,
      IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.algebraN Φ → (∀ p, Φ (D.space.γ p) = D.mapToN p) →
        Φ x = Φ y) : x = y := by
  obtain ⟨Φ, hΦ, hΦγ⟩ := D.exists_toN
  obtain ⟨Ψ, hΨ, hΨγ⟩ := D.exists_ofN
  have hΨΦ : ∀ z, Ψ (Φ z) = z := fun z =>
    eq_of_agree_on_generators_of_necSuf (IsComplexAlgebraHomomorphism.comp_of_necSuf hΦ hΨ)
      (isComplexAlgebraHomomorphism_id_of_necSuf D.space.cliffordAlgebra) (Set.range D.space.γ)
      D.space.γ_generates_of_necSuf
      (fun _ ⟨p, hp⟩ => by rw [← hp]; show Ψ (Φ (D.space.γ p)) = D.space.γ p; rw [hΦγ p]; exact hΨγ _) z
  calc x = Ψ (Φ x) := (hΨΦ x).symm
    _ = Ψ (Φ y) := by rw [h Φ hΦ hΦγ]
    _ = y := hΨΦ y

/-- 本文 `claim_annihilation_and_creation_generators_anticommute` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem annihilation_creation_anticommute_of_necSuf (i j : ℕ) (hi1 : 1 ≤ i) (hiM : i ≤ D.M) (hj1 : 1 ≤ j)
    (hjM : j ≤ D.M) :
    D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.annihilation i) (D.creation j))
        (D.space.cliffordAlgebra.mul (D.creation j) (D.annihilation i))
      = D.space.cliffordAlgebra.smul (kroneckerDelta i j) D.space.cliffordAlgebra.one := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_add, hΦ.map_mul, hΦ.map_mul, hΦ.map_smul, hΦ.map_one]
  show D.algebraN.add (D.algebraN.mul (Φ (D.space.γ _)) (Φ (D.space.γ _)))
      (D.algebraN.mul (Φ (D.space.γ _)) (Φ (D.space.γ _))) = _
  rw [hΦγ, hΦγ]
  exact D.toNecSuf.annihilation_creation_anticommute complexCliffordLaws add_neg_cancel i j hi1 hiM hj1 hjM

/-- 本文 `claim_creation_generators_anticommute` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem creation_anticommute_of_necSuf (i j : ℕ) :
    D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.creation i) (D.creation j))
        (D.space.cliffordAlgebra.mul (D.creation j) (D.creation i))
      = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_add, hΦ.map_mul, hΦ.map_mul, show Φ D.space.cliffordAlgebra.zero = D.algebraN.zero from
    hΦ.isLinearMap.map_zero]
  show D.algebraN.add (D.algebraN.mul (Φ (D.space.γ _)) (Φ (D.space.γ _)))
      (D.algebraN.mul (Φ (D.space.γ _)) (Φ (D.space.γ _))) = _
  rw [hΦγ, hΦγ]
  exact D.toNecSuf.creation_anticommute complexCliffordLaws add_neg_cancel i j

/-- 本文 `claim_annihilation_generators_anticommute` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem annihilation_anticommute_of_necSuf (i j : ℕ) :
    D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.annihilation i) (D.annihilation j))
        (D.space.cliffordAlgebra.mul (D.annihilation j) (D.annihilation i))
      = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_add, hΦ.map_mul, hΦ.map_mul, show Φ D.space.cliffordAlgebra.zero = D.algebraN.zero from
    hΦ.isLinearMap.map_zero]
  show D.algebraN.add (D.algebraN.mul (Φ (D.space.γ _)) (Φ (D.space.γ _)))
      (D.algebraN.mul (Φ (D.space.γ _)) (Φ (D.space.γ _))) = _
  rw [hΦγ, hΦγ]
  exact D.toNecSuf.annihilation_anticommute complexCliffordLaws add_neg_cancel i j

/-- 本文 `claim_square_of_creation_generator_is_zero` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem creation_mul_self_of_necSuf (i : ℕ) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.creation i) = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, show Φ D.space.cliffordAlgebra.zero = D.algebraN.zero from hΦ.isLinearMap.map_zero]
  show D.algebraN.mul (Φ (D.space.γ _)) (Φ (D.space.γ _)) = _
  rw [hΦγ]
  exact D.toNecSuf.creation_mul_self complexCliffordLaws add_neg_cancel i

/-- 本文 `claim_square_of_annihilation_generator_is_zero` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem annihilation_mul_self_of_necSuf (i : ℕ) :
    D.space.cliffordAlgebra.mul (D.annihilation i) (D.annihilation i) = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, show Φ D.space.cliffordAlgebra.zero = D.algebraN.zero from hΦ.isLinearMap.map_zero]
  show D.algebraN.mul (Φ (D.space.γ _)) (Φ (D.space.γ _)) = _
  rw [hΦγ]
  exact D.toNecSuf.annihilation_mul_self complexCliffordLaws add_neg_cancel i

end SplitData

end

end CliffordMatrixIsomorphism.Clifford
