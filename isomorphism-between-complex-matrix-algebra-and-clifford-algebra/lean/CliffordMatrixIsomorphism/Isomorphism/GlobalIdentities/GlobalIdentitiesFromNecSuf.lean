/-
章「同型の証明」の節「クリフォード代数の中の大域的な等式」の具体版が、必要十分版のこの節の主張の
K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。
具体版の主張は、どれも具体版と同じ名前に `_of_necSuf` を付けて示す（必要十分版の主張も具体版と同じ名前）。

クリフォード代数の中の主張は、`LocalIdentitiesFromNecSuf.lean` と同じく、Φ ∘ γ = γ' ∘（点を写す写像）を満たす
準同型 Φ : Cl → Cl' で運ぶ（`equal_of_toN_eq`）。Φ はこの節の定義の四つ（a†_{U,≤m}・P_{≤m}・Q^{T,U}_m・u^S_i）を
必要十分版の同じ名前の元へ移す（`toN_…`）。1 の分解の和は、Φ が線型写像なので有限集合の上の和を値の和へ移す
（`IsComplexLinearMap.map_sumOverFiniteSet`）。
部分集合の和の主張（一般の ℂ-代数 B）は、B を必要十分版の K := ℂ の代数として読み（`ComplexAlgebra.toNecSuf`）、
線型結合と番号順の積の一致（`linearCombination_eq_necSuf`・`orderedProduct_eq_necSuf`）で運ぶ。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws`、a + (-a) = 0 の `add_neg_cancel`、
0 + 0 = 0 の `add_zero 0` だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.GlobalIdentities.GlobalIdentities
import CliffordMatrixIsomorphism.Isomorphism.LocalIdentities.LocalIdentitiesFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.FiniteSetSumFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GlobalIdentities.GlobalIdentities

-- 添字の再帰的な定義（2^M・個数 N_i(T)・整数の番号順の和など）は具体版と必要十分版に同じ式で別に置いてあり、
-- 変数での値は再帰の展開でしか一致しないので、このファイルでは smartUnfolding を切って定義どおりに展開させる。
set_option smartUnfolding false

namespace CliffordMatrixIsomorphism.ComplexAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra

universe v

variable {B : Type v}

/-- 本文 `claim_sum_over_subsets_of_selected_products_is_product_of_sums` を必要十分版から得る。 -/
theorem linearCombination_selectedProducts_eq_of_necSuf (SB : ComplexAlgebra B) (M : ℕ) (g h : ℕ → B) :
    ∀ m : ℕ, m ≤ M →
      linearCombination SB.toComplexVectorSpace (twoPower m) (fun _ => 1)
          (numberedFamily (binaryNumbering m) (fun S => orderedProduct SB m (selectedFactorBySubset g h S.1)) SB.zero)
        = orderedProduct SB m (fun i => SB.add (h i) (g i)) := by
  intro m hm
  simp only [linearCombination_eq_necSuf, orderedProduct_eq_necSuf, toComplexVectorSpace_toNecSuf]
  exact NecSuf.AlgebraOver.linearCombination_selectedProducts_eq SB.toNecSuf (_root_.add_zero 0) M g h m hm

end CliffordMatrixIsomorphism.ComplexAlgebra

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
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
/-- Φ(a†_{U,≤m}) = a'†_{U,≤m}。 -/
theorem toN_initialCreationProduct (U : PowerSet D.M) (m : ℕ) :
    Φ (D.initialCreationProduct U m) = D.toNecSuf.initialCreationProduct complexCliffordLaws U m :=
  toN_orderedProduct hΦ m _ _ (toN_selectedCreationFactor hΦ hΦγ U)

include hΦ hΦγ in
/-- Φ(P_{≤m}) = P'_{≤m}。 -/
theorem toN_initialVacuumPart (m : ℕ) :
    Φ (D.initialVacuumPart m) = D.toNecSuf.initialVacuumPart complexCliffordLaws m :=
  toN_orderedProduct hΦ m _ _ (toN_vacuumFactor hΦ hΦγ)

include hΦ hΦγ in
/-- Φ(Q^{T,U}_m) = Q'^{T,U}_m。 -/
theorem toN_vacuumSandwich (T U : PowerSet D.M) (m : ℕ) :
    Φ (D.vacuumSandwich T U m) = D.toNecSuf.vacuumSandwich complexCliffordLaws T U m := by
  rw [vacuumSandwich, hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, toN_initialVacuumPart hΦ hΦγ,
    toN_initialReverseAnnihilationProduct hΦ hΦγ, toN_initialCreationProduct hΦ hΦγ]
  rfl

include hΦ hΦγ in
/-- Φ(u^S_i) = u'^S_i。 -/
theorem toN_selectedNumberFactor (S : PowerSet D.M) (i : ℕ) :
    Φ (D.selectedNumberFactor S i) = D.toNecSuf.selectedNumberFactor complexCliffordLaws S i := by
  by_cases h : i ∈ S.1
  · rw [show D.selectedNumberFactor S i = D.space.cliffordAlgebra.mul (D.creation i) (D.annihilation i) from if_pos h,
      show D.toNecSuf.selectedNumberFactor complexCliffordLaws S i
        = ((D.spaceN).cliffordAlgebra complexCliffordLaws).mul (D.toNecSuf.creation complexCliffordLaws i)
            (D.toNecSuf.annihilation complexCliffordLaws i) from if_pos h,
      hΦ.map_mul, toN_creation hΦγ, toN_annihilation hΦγ]
    rfl
  · rw [show D.selectedNumberFactor S i = D.space.cliffordAlgebra.mul (D.annihilation i) (D.creation i) from if_neg h,
      show D.toNecSuf.selectedNumberFactor complexCliffordLaws S i
        = ((D.spaceN).cliffordAlgebra complexCliffordLaws).mul (D.toNecSuf.annihilation complexCliffordLaws i)
            (D.toNecSuf.creation complexCliffordLaws i) from if_neg h,
      hΦ.map_mul, toN_creation hΦγ, toN_annihilation hΦγ]
    rfl

end

/-! ### 主張 -/

/-- 本文 `claim_annihilation_generator_commutes_with_other_number_reversed_pair` を必要十分版から得る。 -/
theorem annihilation_commute_reversedPair_of_necSuf {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M)
    (hij : i ≠ j) :
    D.space.cliffordAlgebra.mul (D.annihilation i) (D.space.cliffordAlgebra.mul (D.creation j) (D.annihilation j))
      = D.space.cliffordAlgebra.mul (D.space.cliffordAlgebra.mul (D.creation j) (D.annihilation j)) (D.annihilation i) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, toN_annihilation hΦγ, toN_creation hΦγ, toN_annihilation hΦγ]
  exact D.toNecSuf.annihilation_commute_reversedPair complexCliffordLaws add_neg_cancel hi hj hij

/-- 本文 `claim_vacuum_factors_with_different_numbers_commute` を必要十分版から得る。 -/
theorem vacuumFactor_commute_of_necSuf {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor i) (D.vacuumFactor j)
      = D.space.cliffordAlgebra.mul (D.vacuumFactor j) (D.vacuumFactor i) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_vacuumFactor hΦ hΦγ, toN_vacuumFactor hΦ hΦγ]
  exact D.toNecSuf.vacuumFactor_commute complexCliffordLaws add_neg_cancel hi hj hij

/-- 本文 `claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator` を必要十分版から得る。 -/
theorem vacuumFactor_mul_annihilation_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor i) (D.annihilation i) = D.annihilation i := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_vacuumFactor hΦ hΦγ, toN_annihilation hΦγ]
  exact D.toNecSuf.vacuumFactor_mul_annihilation complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_creation_generator_times_vacuum_factor_is_creation_generator` を必要十分版から得る。 -/
theorem creation_mul_vacuumFactor_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.vacuumFactor i) = D.creation i := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_vacuumFactor hΦ hΦγ, toN_creation hΦγ]
  exact D.toNecSuf.creation_mul_vacuumFactor complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_vacuum_factor_is_idempotent` を必要十分版から得る。 -/
theorem vacuumFactor_mul_self_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor i) (D.vacuumFactor i) = D.vacuumFactor i := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_vacuumFactor hΦ hΦγ]
  exact D.toNecSuf.vacuumFactor_mul_self complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_initial_ordered_creation_product_splits_off_last_number` を必要十分版から得る。 -/
theorem initialCreationProduct_succ_of_necSuf (U : PowerSet D.M) (m : ℕ) :
    D.initialCreationProduct U (m + 1)
      = D.space.cliffordAlgebra.mul (D.initialCreationProduct U m) (D.selectedCreationFactor U (m + 1)) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_initialCreationProduct hΦ hΦγ, toN_initialCreationProduct hΦ hΦγ,
    toN_selectedCreationFactor hΦ hΦγ]
  exact D.toNecSuf.initialCreationProduct_succ complexCliffordLaws U m

/-- 本文 `claim_initial_ordered_creation_product_up_to_last_number_is_whole_product` を必要十分版から得る。 -/
theorem initialCreationProduct_last_of_necSuf (U : PowerSet D.M) :
    D.initialCreationProduct U D.M = D.orderedCreationProduct U := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_initialCreationProduct hΦ hΦγ, toN_orderedCreationProduct hΦ hΦγ]
  exact D.toNecSuf.initialCreationProduct_last complexCliffordLaws U

/-- 本文 `claim_initial_part_of_vacuum_element_splits_off_last_factor` を必要十分版から得る。 -/
theorem initialVacuumPart_succ_of_necSuf (m : ℕ) :
    D.initialVacuumPart (m + 1) = D.space.cliffordAlgebra.mul (D.initialVacuumPart m) (D.vacuumFactor (m + 1)) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_initialVacuumPart hΦ hΦγ, toN_initialVacuumPart hΦ hΦγ, toN_vacuumFactor hΦ hΦγ]
  exact D.toNecSuf.initialVacuumPart_succ complexCliffordLaws m

/-- 本文 `claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element` を必要十分版から得る。 -/
theorem initialVacuumPart_last_of_necSuf : D.initialVacuumPart D.M = D.vacuumElement := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_initialVacuumPart hΦ hΦγ, toN_vacuumElement hΦ hΦγ]
  exact D.toNecSuf.initialVacuumPart_last complexCliffordLaws

/-- 本文 `claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich` を必要十分版から得る。 -/
theorem vacuumSandwich_last_of_necSuf (T U : PowerSet D.M) :
    D.vacuumSandwich T U D.M
      = D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul D.vacuumElement
            (D.space.cliffordAlgebra.mul (D.reverseOrderedAnnihilationProduct T) (D.orderedCreationProduct U)))
          D.vacuumElement := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_vacuumSandwich hΦ hΦγ, hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, toN_vacuumElement hΦ hΦγ,
    toN_reverseOrderedAnnihilationProduct hΦ hΦγ, toN_orderedCreationProduct hΦ hΦγ]
  exact D.toNecSuf.vacuumSandwich_last complexCliffordLaws T U

/-- 本文 `claim_vacuum_factor_commutes_with_lower_initial_parts` を必要十分版から得る。 -/
theorem vacuumFactor_commute_initialParts_of_necSuf (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor (m + 1))
        (D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m))
      = D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m))
          (D.vacuumFactor (m + 1)) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, toN_vacuumFactor hΦ hΦγ,
    toN_initialReverseAnnihilationProduct hΦ hΦγ, toN_initialCreationProduct hΦ hΦγ]
  exact D.toNecSuf.vacuumFactor_commute_initialParts complexCliffordLaws add_neg_cancel T U hm

/-- 三つの場合の主張が共通に置く準備（イ）の x ·_A P' = P' ·_A x を必要十分版から得る。 -/
theorem vacuumFactor_commute_initialVacuumPart_of_necSuf {m : ℕ} (hm : m + 1 ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor (m + 1)) (D.initialVacuumPart m)
      = D.space.cliffordAlgebra.mul (D.initialVacuumPart m) (D.vacuumFactor (m + 1)) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_vacuumFactor hΦ hΦγ, toN_initialVacuumPart hΦ hΦγ]
  exact D.toNecSuf.vacuumFactor_commute_initialVacuumPart complexCliffordLaws add_neg_cancel hm

/-- 三つの場合の主張が共通に置く準備（ハ）を必要十分版から得る。 -/
theorem initialParts_mul_succ_of_necSuf (T U : PowerSet D.M) (m : ℕ) :
    D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T (m + 1)) (D.initialCreationProduct U (m + 1))
      = D.space.cliffordAlgebra.mul (D.selectedAnnihilationFactor T (m + 1))
          (D.space.cliffordAlgebra.mul
            (D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m))
            (D.selectedCreationFactor U (m + 1))) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, toN_initialReverseAnnihilationProduct hΦ hΦγ,
    toN_initialCreationProduct hΦ hΦγ, toN_selectedAnnihilationFactor hΦ hΦγ,
    toN_initialReverseAnnihilationProduct hΦ hΦγ, toN_initialCreationProduct hΦ hΦγ,
    toN_selectedCreationFactor hΦ hΦγ]
  exact D.toNecSuf.initialParts_mul_succ complexCliffordLaws T U m

/-- 本文 `claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset` を必要十分版から得る。 -/
theorem vacuumSandwich_succ_of_exactlyOne_of_necSuf (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (h : (m + 1 ∈ T.1 ∧ m + 1 ∉ U.1) ∨ (m + 1 ∉ T.1 ∧ m + 1 ∈ U.1)) :
    D.vacuumSandwich T U (m + 1) = D.space.cliffordAlgebra.zero := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_vacuumSandwich hΦ hΦγ, toN_zero hΦ]
  exact D.toNecSuf.vacuumSandwich_succ_of_exactlyOne complexCliffordLaws add_neg_cancel T U hm h

/-- 本文 `claim_vacuum_sandwich_when_last_number_is_in_neither_subset` を必要十分版から得る。 -/
theorem vacuumSandwich_succ_of_neither_of_necSuf (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (hT : m + 1 ∉ T.1) (hU : m + 1 ∉ U.1) :
    D.vacuumSandwich T U (m + 1) = D.space.cliffordAlgebra.mul (D.vacuumSandwich T U m) (D.vacuumFactor (m + 1)) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_vacuumSandwich hΦ hΦγ, toN_vacuumSandwich hΦ hΦγ, toN_vacuumFactor hΦ hΦγ]
  exact D.toNecSuf.vacuumSandwich_succ_of_neither complexCliffordLaws add_neg_cancel T U hm hT hU

/-- 本文 `claim_vacuum_sandwich_when_last_number_is_in_both_subsets` を必要十分版から得る。 -/
theorem vacuumSandwich_succ_of_both_of_necSuf (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (hT : m + 1 ∈ T.1) (hU : m + 1 ∈ U.1) :
    D.vacuumSandwich T U (m + 1)
      = D.space.cliffordAlgebra.mul (D.annihilation (m + 1))
          (D.space.cliffordAlgebra.mul (D.vacuumSandwich T U m) (D.creation (m + 1))) := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_vacuumSandwich hΦ hΦγ, toN_vacuumSandwich hΦ hΦγ, toN_annihilation hΦγ,
    toN_creation hΦγ]
  exact D.toNecSuf.vacuumSandwich_succ_of_both complexCliffordLaws add_neg_cancel T U hm hT hU

/-- 本文 `claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part` を必要十分版から得る。 -/
theorem vacuumSandwich_of_agree_of_necSuf (T U : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M → (∀ t : ℕ, 1 ≤ t → t ≤ m → (t ∈ T.1 ↔ t ∈ U.1)) →
      D.vacuumSandwich T U m = D.initialVacuumPart m := by
  intro m hm hagree
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_vacuumSandwich hΦ hΦγ, toN_initialVacuumPart hΦ hΦγ]
  exact D.toNecSuf.vacuumSandwich_of_agree complexCliffordLaws add_neg_cancel T U m hm hagree

/-- 本文 `claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero` を必要十分版から得る。 -/
theorem vacuumSandwich_of_disagree_of_necSuf (T U : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M → (∃ t : ℕ, 1 ≤ t ∧ t ≤ m ∧ ((t ∈ T.1 ∧ t ∉ U.1) ∨ (t ∉ T.1 ∧ t ∈ U.1))) →
      D.vacuumSandwich T U m = D.space.cliffordAlgebra.zero := by
  intro m hm hdis
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_vacuumSandwich hΦ hΦγ, toN_zero hΦ]
  exact D.toNecSuf.vacuumSandwich_of_disagree complexCliffordLaws add_neg_cancel T U m hm hdis

open Classical in
/-- 本文 `claim_vacuum_element_sandwich_of_annihilation_and_creation_products` を必要十分版から得る。 -/
theorem vacuumElement_sandwich_of_necSuf (T U : PowerSet D.M) :
    D.space.cliffordAlgebra.mul
        (D.space.cliffordAlgebra.mul D.vacuumElement
          (D.space.cliffordAlgebra.mul (D.reverseOrderedAnnihilationProduct T) (D.orderedCreationProduct U)))
        D.vacuumElement
      = D.space.cliffordAlgebra.smul (kroneckerDelta T U) D.vacuumElement := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, hΦ.map_mul, hΦ.map_smul, toN_vacuumElement hΦ hΦγ,
    toN_reverseOrderedAnnihilationProduct hΦ hΦγ, toN_orderedCreationProduct hΦ hΦγ, kroneckerDelta_eq_necSuf]
  exact D.toNecSuf.vacuumElement_sandwich complexCliffordLaws add_neg_cancel T U

/-- 本文 `claim_creation_vacuum_annihilation_factor_of_one_number` を必要十分版から得る。 -/
theorem creation_vacuum_annihilation_factor_of_necSuf (S : PowerSet D.M) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul
        (D.space.cliffordAlgebra.mul (D.selectedCreationFactor S i) (D.vacuumFactor i))
        (D.selectedAnnihilationFactor S i)
      = D.selectedNumberFactor S i := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_selectedCreationFactor hΦ hΦγ, toN_vacuumFactor hΦ hΦγ,
    toN_selectedAnnihilationFactor hΦ hΦγ, toN_selectedNumberFactor hΦ hΦγ]
  exact D.toNecSuf.creation_vacuum_annihilation_factor complexCliffordLaws add_neg_cancel S hi

/-- 本文 `claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors` を必要十分版から得る。 -/
theorem initialParts_product_eq_orderedProduct_of_necSuf (S : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M →
      D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul (D.initialCreationProduct S m) (D.initialVacuumPart m))
          (D.initialReverseAnnihilationProduct S m)
        = ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (D.selectedNumberFactor S) := by
  intro m hm
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_initialCreationProduct hΦ hΦγ, toN_initialVacuumPart hΦ hΦγ,
    toN_initialReverseAnnihilationProduct hΦ hΦγ,
    toN_orderedProduct hΦ m _ _ (toN_selectedNumberFactor hΦ hΦγ S)]
  exact D.toNecSuf.initialParts_product_eq_orderedProduct complexCliffordLaws add_neg_cancel S m hm

/-- 本文 `claim_decomposition_of_unity_in_split_clifford_algebra` を必要十分版から得る。
Φ は線型写像なので、有限集合の上の和を値の和へ移す。 -/
theorem decomposition_of_unity_of_necSuf :
    sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M) (fun _ => 1)
        (fun S => D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul (D.orderedCreationProduct S) D.vacuumElement)
          (D.reverseOrderedAnnihilationProduct S))
      = D.space.cliffordAlgebra.one := by
  apply D.equal_of_toN_eq
  intro Φ hΦ hΦγ
  let A' := (D.spaceN).cliffordAlgebra complexCliffordLaws
  have hterm : ∀ S : PowerSet D.M,
      Φ (D.space.cliffordAlgebra.mul (D.space.cliffordAlgebra.mul (D.orderedCreationProduct S) D.vacuumElement)
          (D.reverseOrderedAnnihilationProduct S))
        = A'.mul (A'.mul (D.toNecSuf.orderedCreationProduct complexCliffordLaws S)
            (D.toNecSuf.vacuumElement complexCliffordLaws))
            (D.toNecSuf.reverseOrderedAnnihilationProduct complexCliffordLaws S) := by
    intro S
    rw [hΦ.map_mul, hΦ.map_mul, toN_orderedCreationProduct hΦ hΦγ, toN_vacuumElement hΦ hΦγ,
      toN_reverseOrderedAnnihilationProduct hΦ hΦγ]
    rfl
  calc Φ (sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M) (fun _ => 1)
        (fun S => D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul (D.orderedCreationProduct S) D.vacuumElement)
          (D.reverseOrderedAnnihilationProduct S)))
      = sumOverFiniteSet D.algebraN.toComplexVectorSpace (isFiniteSet_powerSet D.M) (fun _ => 1)
          (fun S => Φ (D.space.cliffordAlgebra.mul
            (D.space.cliffordAlgebra.mul (D.orderedCreationProduct S) D.vacuumElement)
            (D.reverseOrderedAnnihilationProduct S))) :=
        hΦ.isLinearMap.map_sumOverFiniteSet (isFiniteSet_powerSet D.M) _ _
    _ = sumOverFiniteSet D.algebraN.toComplexVectorSpace (isFiniteSet_powerSet D.M) (fun _ => 1)
          (fun S => A'.mul (A'.mul (D.toNecSuf.orderedCreationProduct complexCliffordLaws S)
            (D.toNecSuf.vacuumElement complexCliffordLaws))
            (D.toNecSuf.reverseOrderedAnnihilationProduct complexCliffordLaws S)) := by
        rw [funext hterm]
    _ = NecSuf.VectorSpace.sumOverFiniteSet A'.toVectorSpace (isFiniteSet_powerSet D.M).toNecSuf (fun _ => 1)
          (fun S => A'.mul (A'.mul (D.toNecSuf.orderedCreationProduct complexCliffordLaws S)
            (D.toNecSuf.vacuumElement complexCliffordLaws))
            (D.toNecSuf.reverseOrderedAnnihilationProduct complexCliffordLaws S)) :=
        sumOverFiniteSet_eq_necSuf _ _ _ _
    _ = A'.one := D.toNecSuf.decomposition_of_unity complexCliffordLaws add_neg_cancel
    _ = Φ D.space.cliffordAlgebra.one := hΦ.map_one.symm

end

end CliffordMatrixIsomorphism.Clifford.SplitData
