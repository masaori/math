/-
章「同型の証明」の節「クリフォード代数の中の局所的な等式」の具体版が、必要十分版のこの節の主張の
K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。

  具体版の主張                                                     必要十分版の主張（NecSuf.Clifford.SplitData.…）
  annihilation_commute_vacuumFactor                                annihilation_commute_vacuumFactor
  creation_commute_vacuumFactor                                    creation_commute_vacuumFactor
  annihilation_mul_vacuumElement                                   annihilation_mul_vacuumElement
  vacuumElement_mul_creation                                       vacuumElement_mul_creation
  creation_mul_initialCreationProduct                              creation_mul_initialCreationProduct
  creation_mul_orderedCreationProduct_of_not_mem                   creation_mul_orderedCreationProduct_of_not_mem
  creation_mul_orderedCreationProduct_of_mem                       creation_mul_orderedCreationProduct_of_mem
  initialReverseAnnihilationProduct_succ                           initialReverseAnnihilationProduct_succ
  initialReverseAnnihilationProduct_last                           initialReverseAnnihilationProduct_last
  initialReverseAnnihilationProduct_mul_annihilation               initialReverseAnnihilationProduct_mul_annihilation
  reverseOrderedAnnihilationProduct_singleOut                      reverseOrderedAnnihilationProduct_singleOut
  reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem    reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem
  reverseOrderedAnnihilationProduct_mul_annihilation_of_mem        reverseOrderedAnnihilationProduct_mul_annihilation_of_mem
具体版の主張は、どれも名前に `_of_necSuf` を付けて示す。

具体版のクリフォード代数 Cl と、必要十分版の前提 `D.toNecSuf` のクリフォード代数 Cl' は別の集合なので、
`GeneratorsFromNecSuf.lean` と同じく、Φ ∘ γ = γ' ∘（点を写す写像）を満たす準同型 Φ : Cl → Cl' で主張を運ぶ
（`eq_of_toN_eq`。Φ で写した両辺が等しければ、Ψ ∘ Φ = 恒等写像なので両辺は等しい）。
Φ は生成元を必要十分版の生成元へ、定義の七つと a_{T,≤m} を必要十分版の同じ名前の元へ移す（`toN_…`。
番号順の積は、準同型が番号順の積を保つこと `IsComplexAlgebraHomomorphism.map_orderedProduct_of_necSuf` で移す）。
したがって具体版の主張の両辺の Φ による像は、必要十分版の主張の両辺である。符号 ς は `sign_eq_necSuf` で移す。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws` と a + (-a) = 0 の `add_neg_cancel` だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.LocalIdentities.LocalIdentities
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CountAndSignFromNecSuf
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.GeneratorsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.LocalIdentities.LocalIdentities

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet)
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

include hΦγ in
/-- Φ(a†_i) = a'†_i。 -/
theorem toN_creation (i : ℕ) : Φ (D.creation i) = D.toNecSuf.creation complexCliffordLaws i := by
  rw [show D.creation i = D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i)) from rfl, hΦγ]
  rfl

include hΦγ in
/-- Φ(a_i) = a'_i。 -/
theorem toN_annihilation (i : ℕ) : Φ (D.annihilation i) = D.toNecSuf.annihilation complexCliffordLaws i := by
  rw [show D.annihilation i = D.space.γ (embedSecond D.spaceW (D.f i)) from rfl, hΦγ]
  rfl

include hΦ in
/-- Φ(0_{Cl}) = 0_{Cl'}。 -/
theorem toN_zero :
    Φ D.space.cliffordAlgebra.zero = ((D.spaceN).cliffordAlgebra complexCliffordLaws).zero :=
  hΦ.isLinearMap.map_zero

include hΦ in
/-- Φ は番号順の積を、像の族の番号順の積へ移す。 -/
theorem toN_orderedProduct (m : ℕ) (x : ℕ → D.space.Cl) (x' : ℕ → D.spaceN.Cl complexCliffordLaws)
    (h : ∀ k, Φ (x k) = x' k) :
    Φ (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m x)
      = NecSuf.AlgebraOver.orderedProduct ((D.spaceN).cliffordAlgebra complexCliffordLaws) m x' := by
  rw [hΦ.map_orderedProduct_of_necSuf m x, ComplexAlgebra.orderedProduct_eq_necSuf]
  exact congrArg (NecSuf.AlgebraOver.orderedProduct ((D.spaceN).cliffordAlgebra complexCliffordLaws) m) (funext h)

include hΦ hΦγ in
/-- Φ(y^S_t) = y'^S_t。 -/
theorem toN_selectedCreationFactor (S : PowerSet D.M) (t : ℕ) :
    Φ (D.selectedCreationFactor S t) = D.toNecSuf.selectedCreationFactor complexCliffordLaws S t := by
  by_cases h : t ∈ S.1
  · rw [D.selectedCreationFactor_of_mem h, D.toNecSuf.selectedCreationFactor_of_mem complexCliffordLaws h]
    exact toN_creation hΦγ t
  · rw [D.selectedCreationFactor_of_not_mem h, D.toNecSuf.selectedCreationFactor_of_not_mem complexCliffordLaws h]
    exact hΦ.map_one

include hΦ hΦγ in
/-- Φ(z^T_t) = z'^T_t。 -/
theorem toN_selectedAnnihilationFactor (T : PowerSet D.M) (t : ℕ) :
    Φ (D.selectedAnnihilationFactor T t) = D.toNecSuf.selectedAnnihilationFactor complexCliffordLaws T t := by
  by_cases h : t ∈ T.1
  · rw [D.selectedAnnihilationFactor_of_mem h, D.toNecSuf.selectedAnnihilationFactor_of_mem complexCliffordLaws h]
    exact toN_annihilation hΦγ t
  · rw [D.selectedAnnihilationFactor_of_not_mem h,
      D.toNecSuf.selectedAnnihilationFactor_of_not_mem complexCliffordLaws h]
    exact hΦ.map_one

include hΦ hΦγ in
/-- Φ(a†_S) = a'†_S。 -/
theorem toN_orderedCreationProduct (S : PowerSet D.M) :
    Φ (D.orderedCreationProduct S) = D.toNecSuf.orderedCreationProduct complexCliffordLaws S :=
  toN_orderedProduct hΦ D.M _ _ (toN_selectedCreationFactor hΦ hΦγ S)

include hΦ hΦγ in
/-- Φ(a_T) = a'_T。 -/
theorem toN_reverseOrderedAnnihilationProduct (T : PowerSet D.M) :
    Φ (D.reverseOrderedAnnihilationProduct T) = D.toNecSuf.reverseOrderedAnnihilationProduct complexCliffordLaws T :=
  toN_orderedProduct hΦ D.M _ _ fun k => toN_selectedAnnihilationFactor hΦ hΦγ T (D.M + 1 - k)

include hΦ hΦγ in
/-- Φ(x_i) = x'_i。 -/
theorem toN_vacuumFactor (i : ℕ) : Φ (D.vacuumFactor i) = D.toNecSuf.vacuumFactor complexCliffordLaws i := by
  rw [vacuumFactor, hΦ.map_mul, toN_annihilation hΦγ, toN_creation hΦγ]
  rfl

include hΦ hΦγ in
/-- Φ(P) = P'。 -/
theorem toN_vacuumElement : Φ D.vacuumElement = D.toNecSuf.vacuumElement complexCliffordLaws :=
  toN_orderedProduct hΦ D.M _ _ (toN_vacuumFactor hΦ hΦγ)

include hΦ hΦγ in
/-- Φ(a_{T,≤m}) = a'_{T,≤m}。 -/
theorem toN_initialReverseAnnihilationProduct (T : PowerSet D.M) (m : ℕ) :
    Φ (D.initialReverseAnnihilationProduct T m)
      = D.toNecSuf.initialReverseAnnihilationProduct complexCliffordLaws T m :=
  toN_orderedProduct hΦ m _ _ fun k => toN_selectedAnnihilationFactor hΦ hΦγ T (m + 1 - k)

end

/-! ### 主張 -/

/-- 本文 `claim_annihilation_generator_commutes_with_other_number_pair` を必要十分版から得る。 -/
theorem annihilation_commute_vacuumFactor_of_necSuf {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M)
    (hij : i ≠ j) :
    D.space.cliffordAlgebra.mul (D.annihilation i) (D.vacuumFactor j)
      = D.space.cliffordAlgebra.mul (D.vacuumFactor j) (D.annihilation i) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_annihilation hΦγ, toN_vacuumFactor hΦ hΦγ]
  exact D.toNecSuf.annihilation_commute_vacuumFactor complexCliffordLaws add_neg_cancel hi hj hij

/-- 本文 `claim_creation_generator_commutes_with_other_number_pair` を必要十分版から得る。 -/
theorem creation_commute_vacuumFactor_of_necSuf {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M)
    (hij : i ≠ j) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.vacuumFactor j)
      = D.space.cliffordAlgebra.mul (D.vacuumFactor j) (D.creation i) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_creation hΦγ, toN_vacuumFactor hΦ hΦγ]
  exact D.toNecSuf.creation_commute_vacuumFactor complexCliffordLaws add_neg_cancel hi hj hij

/-- 本文 `claim_annihilation_generator_times_vacuum_element_is_zero` を必要十分版から得る。 -/
theorem annihilation_mul_vacuumElement_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.annihilation i) D.vacuumElement = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_annihilation hΦγ, toN_vacuumElement hΦ hΦγ, toN_zero hΦ]
  exact D.toNecSuf.annihilation_mul_vacuumElement complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_vacuum_element_times_creation_generator_is_zero` を必要十分版から得る。 -/
theorem vacuumElement_mul_creation_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul D.vacuumElement (D.creation i) = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_creation hΦγ, toN_vacuumElement hΦ hΦγ, toN_zero hΦ]
  exact D.toNecSuf.vacuumElement_mul_creation complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_creation_generator_passes_initial_creation_factors_with_sign` を必要十分版から得る。 -/
theorem creation_mul_initialCreationProduct_of_necSuf {i : ℕ} (T : PowerSet D.M) :
    ∀ m : ℕ, m ≤ i - 1 →
      D.space.cliffordAlgebra.mul (D.creation i)
          (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (D.selectedCreationFactor T))
        = D.space.cliffordAlgebra.smul (sign (countBelow T (m + 1)))
            (D.space.cliffordAlgebra.mul (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (D.selectedCreationFactor T))
              (D.creation i)) := by
  intro m hm
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_smul, hΦ.map_mul, toN_creation hΦγ,
    toN_orderedProduct hΦ m _ _ (toN_selectedCreationFactor hΦ hΦγ T), sign_eq_necSuf]
  exact D.toNecSuf.creation_mul_initialCreationProduct complexCliffordLaws add_neg_cancel T m hm

/-- 本文 `claim_creation_generator_times_ordered_creation_product_without_index` を必要十分版から得る。 -/
theorem creation_mul_orderedCreationProduct_of_not_mem_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (T : PowerSet D.M) (hiT : i ∉ T.1) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.orderedCreationProduct T)
      = D.space.cliffordAlgebra.smul (sign (countBelow T i)) (D.orderedCreationProduct (unionSingleton T i hi)) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_smul, toN_creation hΦγ, toN_orderedCreationProduct hΦ hΦγ,
    toN_orderedCreationProduct hΦ hΦγ, sign_eq_necSuf]
  exact D.toNecSuf.creation_mul_orderedCreationProduct_of_not_mem complexCliffordLaws add_neg_cancel hi T hiT

/-- 本文 `claim_creation_generator_times_ordered_creation_product_with_index_is_zero` を必要十分版から得る。 -/
theorem creation_mul_orderedCreationProduct_of_mem_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (T : PowerSet D.M) (hiT : i ∈ T.1) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.orderedCreationProduct T) = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_creation hΦγ, toN_orderedCreationProduct hΦ hΦγ, toN_zero hΦ]
  exact D.toNecSuf.creation_mul_orderedCreationProduct_of_mem complexCliffordLaws add_neg_cancel hi T hiT

/-- 本文 `claim_initial_reverse_ordered_annihilation_product_splits_off_last_number` を必要十分版から得る。 -/
theorem initialReverseAnnihilationProduct_succ_of_necSuf (T : PowerSet D.M) (m : ℕ) :
    D.initialReverseAnnihilationProduct T (m + 1)
      = D.space.cliffordAlgebra.mul (D.selectedAnnihilationFactor T (m + 1)) (D.initialReverseAnnihilationProduct T m) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_initialReverseAnnihilationProduct hΦ hΦγ, toN_initialReverseAnnihilationProduct hΦ hΦγ,
    toN_selectedAnnihilationFactor hΦ hΦγ]
  exact D.toNecSuf.initialReverseAnnihilationProduct_succ complexCliffordLaws T m

/-- 本文 `claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product` を必要十分版から得る。 -/
theorem initialReverseAnnihilationProduct_last_of_necSuf (T : PowerSet D.M) :
    D.initialReverseAnnihilationProduct T D.M = D.reverseOrderedAnnihilationProduct T := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_initialReverseAnnihilationProduct hΦ hΦγ, toN_reverseOrderedAnnihilationProduct hΦ hΦγ]
  exact D.toNecSuf.initialReverseAnnihilationProduct_last complexCliffordLaws T

/-- 本文 `claim_initial_annihilation_factors_pass_annihilation_generator_with_sign` を必要十分版から得る。 -/
theorem initialReverseAnnihilationProduct_mul_annihilation_of_necSuf {i : ℕ} (T : PowerSet D.M) :
    ∀ m : ℕ, m ≤ i - 1 →
      D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.annihilation i)
        = D.space.cliffordAlgebra.smul (sign (countBelow T (m + 1)))
            (D.space.cliffordAlgebra.mul (D.annihilation i) (D.initialReverseAnnihilationProduct T m)) := by
  intro m hm
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_smul, hΦ.map_mul, toN_annihilation hΦγ, toN_initialReverseAnnihilationProduct hΦ hΦγ,
    sign_eq_necSuf]
  exact D.toNecSuf.initialReverseAnnihilationProduct_mul_annihilation complexCliffordLaws add_neg_cancel T m hm

/-- 本文の二つの主張の証明が共通に置く a_T の分解 a_T = L ·_A (z^T_i ·_A α) を必要十分版から得る。 -/
theorem reverseOrderedAnnihilationProduct_singleOut_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) :
    D.reverseOrderedAnnihilationProduct T
      = D.space.cliffordAlgebra.mul
          (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra (D.M - i) (D.reversedSelectedAnnihilationFactor T))
          (D.space.cliffordAlgebra.mul (D.selectedAnnihilationFactor T i)
            (D.initialReverseAnnihilationProduct T (i - 1))) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_mul, toN_reverseOrderedAnnihilationProduct hΦ hΦγ,
    toN_orderedProduct hΦ (D.M - i) (D.reversedSelectedAnnihilationFactor T)
      (D.toNecSuf.reversedSelectedAnnihilationFactor complexCliffordLaws T)
      fun k => toN_selectedAnnihilationFactor hΦ hΦγ T (D.M + 1 - k),
    toN_selectedAnnihilationFactor hΦ hΦγ, toN_initialReverseAnnihilationProduct hΦ hΦγ]
  exact D.toNecSuf.reverseOrderedAnnihilationProduct_singleOut complexCliffordLaws hi T

/-- 本文 `claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index` を必要十分版から得る。 -/
theorem reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (T : PowerSet D.M) (hiT : i ∉ T.1) :
    D.space.cliffordAlgebra.mul (D.reverseOrderedAnnihilationProduct T) (D.annihilation i)
      = D.space.cliffordAlgebra.smul (sign (countBelow T i))
          (D.reverseOrderedAnnihilationProduct (unionSingleton T i hi)) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_smul, toN_annihilation hΦγ, toN_reverseOrderedAnnihilationProduct hΦ hΦγ,
    toN_reverseOrderedAnnihilationProduct hΦ hΦγ, sign_eq_necSuf]
  exact D.toNecSuf.reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem complexCliffordLaws add_neg_cancel
    hi T hiT

/-- 本文 `claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero` を必要十分版から得る。 -/
theorem reverseOrderedAnnihilationProduct_mul_annihilation_of_mem_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (T : PowerSet D.M) (hiT : i ∈ T.1) :
    D.space.cliffordAlgebra.mul (D.reverseOrderedAnnihilationProduct T) (D.annihilation i)
      = D.space.cliffordAlgebra.zero := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_annihilation hΦγ, toN_reverseOrderedAnnihilationProduct hΦ hΦγ, toN_zero hΦ]
  exact D.toNecSuf.reverseOrderedAnnihilationProduct_mul_annihilation_of_mem complexCliffordLaws add_neg_cancel
    hi T hiT

end

end CliffordMatrixIsomorphism.Clifford.SplitData
