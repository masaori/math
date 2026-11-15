/-
`Isomorphism/OddDimensional/ParityElement.lean` の具体版が、必要十分版のこのファイルの主張の K := ℂ、n := -1_ℂ への
特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。
具体版の主張は、どれも具体版と同じ名前に `_of_necSuf` を付けて示す（必要十分版の主張も具体版と同じ名前）。

具体版のクリフォード代数 Cl と、必要十分版の前提 `D.toNecSuf` のクリフォード代数 Cl' は別の集合なので、
`LocalIdentitiesFromNecSuf.lean` と同じく、Φ ∘ γ = γ' ∘（点を写す写像）を満たす準同型 Φ : Cl → Cl' で主張を運ぶ
（`eq_of_toN_eq`）。Φ は χ_i・ε を必要十分版の同じ名前の元へ移す（`toN_parityFactor`・`toN_parityElement`）ので、
具体版の主張の両辺の Φ による像は、必要十分版の主張の両辺である。y = a_k か y = a†_k の仮定は、場合を分けてから運ぶ。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws` と a + (-a) = 0 の `add_neg_cancel` だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ParityElement
import CliffordMatrixIsomorphism.Isomorphism.LocalIdentities.LocalIdentitiesFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.ParityElement

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### Φ による定義の像 -/

section

variable {D} {Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws}
  (hΦ : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.algebraN Φ)
  (hΦγ : ∀ p, Φ (D.space.γ p) = D.mapToN p)

include hΦ hΦγ in
/-- Φ(χ_i) = χ'_i。 -/
theorem toN_parityFactor (i : ℕ) : Φ (D.parityFactor i) = D.toNecSuf.parityFactor complexCliffordLaws i := by
  rw [parityFactor, hΦ.map_add, hΦ.map_mul, hΦ.map_smul, hΦ.map_mul, toN_annihilation hΦγ, toN_creation hΦγ]
  rfl

include hΦ hΦγ in
/-- Φ(ε) = ε'。 -/
theorem toN_parityElement : Φ D.parityElement = D.toNecSuf.parityElement complexCliffordLaws :=
  toN_orderedProduct hΦ D.M _ _ (toN_parityFactor hΦ hΦγ)

end

/-! ### 主張 -/

/-- 本文 `claim_parity_factor_times_annihilation_generator` を必要十分版から得る。 -/
theorem parityFactor_mul_annihilation_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.parityFactor i) (D.annihilation i) = D.annihilation i := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_parityFactor hΦ hΦγ, toN_annihilation hΦγ]
  exact D.toNecSuf.parityFactor_mul_annihilation complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_annihilation_generator_anticommutes_with_parity_factor` を必要十分版から得る。 -/
theorem annihilation_mul_parityFactor_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.annihilation i) (D.parityFactor i)
      = D.space.cliffordAlgebra.smul (-1) (D.space.cliffordAlgebra.mul (D.parityFactor i) (D.annihilation i)) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_smul, hΦ.map_mul, toN_parityFactor hΦ hΦγ, toN_annihilation hΦγ]
  exact D.toNecSuf.annihilation_mul_parityFactor complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_parity_factor_times_creation_generator` を必要十分版から得る。 -/
theorem parityFactor_mul_creation_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.parityFactor i) (D.creation i)
      = D.space.cliffordAlgebra.smul (-1) (D.creation i) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_smul, toN_parityFactor hΦ hΦγ, toN_creation hΦγ]
  exact D.toNecSuf.parityFactor_mul_creation complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_creation_generator_anticommutes_with_parity_factor` を必要十分版から得る。 -/
theorem creation_mul_parityFactor_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.parityFactor i)
      = D.space.cliffordAlgebra.smul (-1) (D.space.cliffordAlgebra.mul (D.parityFactor i) (D.creation i)) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_smul, hΦ.map_mul, toN_parityFactor hΦ hΦγ, toN_creation hΦγ]
  exact D.toNecSuf.creation_mul_parityFactor complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_square_of_parity_factor_is_one` を必要十分版から得る。 -/
theorem parityFactor_mul_self_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.parityFactor i) (D.parityFactor i) = D.space.cliffordAlgebra.one := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_one, toN_parityFactor hΦ hΦγ]
  exact D.toNecSuf.parityFactor_mul_self complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_generators_commute_with_parity_factor_of_other_number` を必要十分版から得る。 -/
theorem mul_parityFactor_comm_of_ne_of_necSuf {i k : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hk : 1 ≤ k ∧ k ≤ D.M)
    (hik : i ≠ k) {y : D.space.Cl} (hy : y = D.annihilation k ∨ y = D.creation k) :
    D.space.cliffordAlgebra.mul y (D.parityFactor i) = D.space.cliffordAlgebra.mul (D.parityFactor i) y := by
  rcases hy with rfl | rfl
  · apply D.eq_of_toN_eq
    intro Φ hΦ hΦγ
    rw [hΦ.map_mul, hΦ.map_mul, toN_parityFactor hΦ hΦγ, toN_annihilation hΦγ]
    exact D.toNecSuf.mul_parityFactor_comm_of_ne complexCliffordLaws add_neg_cancel hi hk hik (Or.inl rfl)
  · apply D.eq_of_toN_eq
    intro Φ hΦ hΦγ
    rw [hΦ.map_mul, hΦ.map_mul, toN_parityFactor hΦ hΦγ, toN_creation hΦγ]
    exact D.toNecSuf.mul_parityFactor_comm_of_ne complexCliffordLaws add_neg_cancel hi hk hik (Or.inr rfl)

/-- 本文 `claim_parity_factors_with_different_numbers_commute` を必要十分版から得る。 -/
theorem parityFactor_comm_of_ne_of_necSuf {i k : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hk : 1 ≤ k ∧ k ≤ D.M) (hik : i ≠ k) :
    D.space.cliffordAlgebra.mul (D.parityFactor k) (D.parityFactor i)
      = D.space.cliffordAlgebra.mul (D.parityFactor i) (D.parityFactor k) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_parityFactor hΦ hΦγ, toN_parityFactor hΦ hΦγ]
  exact D.toNecSuf.parityFactor_comm_of_ne complexCliffordLaws add_neg_cancel hi hk hik

/-- 本文 `claim_square_of_parity_element_is_one` を必要十分版から得る。 -/
theorem parityElement_mul_self_of_necSuf :
    D.space.cliffordAlgebra.mul D.parityElement D.parityElement = D.space.cliffordAlgebra.one := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_one, toN_parityElement hΦ hΦγ]
  exact D.toNecSuf.parityElement_mul_self complexCliffordLaws add_neg_cancel

/-- 本文 `claim_generators_anticommute_with_parity_element` を必要十分版から得る。 -/
theorem mul_parityElement_of_generator_of_necSuf {k : ℕ} (hk : 1 ≤ k ∧ k ≤ D.M) {y : D.space.Cl}
    (hy : y = D.annihilation k ∨ y = D.creation k) :
    D.space.cliffordAlgebra.mul y D.parityElement
      = D.space.cliffordAlgebra.smul (-1) (D.space.cliffordAlgebra.mul D.parityElement y) := by
  rcases hy with rfl | rfl
  · apply D.eq_of_toN_eq
    intro Φ hΦ hΦγ
    rw [hΦ.map_mul, hΦ.map_smul, hΦ.map_mul, toN_parityElement hΦ hΦγ, toN_annihilation hΦγ]
    exact D.toNecSuf.mul_parityElement_of_generator complexCliffordLaws add_neg_cancel hk (Or.inl rfl)
  · apply D.eq_of_toN_eq
    intro Φ hΦ hΦγ
    rw [hΦ.map_mul, hΦ.map_smul, hΦ.map_mul, toN_parityElement hΦ hΦγ, toN_creation hΦγ]
    exact D.toNecSuf.mul_parityElement_of_generator complexCliffordLaws add_neg_cancel hk (Or.inr rfl)

/-- 本文 `claim_image_of_split_space_anticommutes_with_parity_element` を必要十分版から得る。 -/
theorem γ_anticommute_parityElement_of_necSuf (v : W × DualSpace D.spaceW) :
    D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.space.γ v) D.parityElement)
        (D.space.cliffordAlgebra.mul D.parityElement (D.space.γ v))
      = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_add, hΦ.map_mul, hΦ.map_mul, hΦγ, toN_parityElement hΦ hΦγ, toN_zero hΦ]
  exact D.toNecSuf.γ_anticommute_parityElement complexCliffordLaws add_neg_cancel (splitPointToNecSuf D.spaceW v)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
