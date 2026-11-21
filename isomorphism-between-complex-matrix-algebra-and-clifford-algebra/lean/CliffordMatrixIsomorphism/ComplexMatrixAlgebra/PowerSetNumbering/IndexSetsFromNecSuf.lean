/-
章「複素行列環」の、部分集合全体・2 進の番号付け・組の番号付け・{1,2}・番号を逆順に付け替える写像・
番号 1 を最上位の桁にする番号付け・1 と 2 の組・整数の番号順の和・組の番号の主張が、必要十分版の特殊化として
得られることを示す導出版。どの定義も ℂ を含まず、具体版と必要十分版に同じ式で別に置いてあるので、
主張の式は定義により一致する。二つの版の再帰的な定義（2^M・整数の番号順の和など）は、変数での値が
再帰の展開でしか一致しないので、各宣言で smartUnfolding を切って定義どおりに展開させる。
番号付けと有限集合の条件だけを `IsNumbering.ofNecSuf`・`IsFiniteSet.ofNecSuf` で写す。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.TupleNumber
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.PairNumbering
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.TupleNumber
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.PowerSetNumbering.PairNumbering
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.NumberingFromNecSuf

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

set_option smartUnfolding false in
/-- 本文 `claim_binary_numbering_is_numbering_of_power_set` を、必要十分版から得たもの。 -/
theorem binaryNumbering_isNumbering_of_necSuf (M : ℕ) :
    IsNumbering (twoPower M) (binaryNumbering M) :=
  IsNumbering.ofNecSuf (NecSuf.ComplexMatrixAlgebra.binaryNumbering_isNumbering M)

set_option smartUnfolding false in
/-- 本文 `claim_number_of_pairs_of_subsets_is_at_least_one` を、必要十分版から得たもの。 -/
theorem one_le_pairCount_of_necSuf (M : ℕ) : 1 ≤ pairCount M :=
  NecSuf.ComplexMatrixAlgebra.one_le_pairCount M

set_option smartUnfolding false in
/-- 本文 `claim_numbering_of_pairs_of_subsets_is_numbering` を、必要十分版から得たもの。 -/
theorem pairNumbering_isNumbering_of_necSuf (M : ℕ) : IsNumbering (pairCount M) (pairNumbering M) :=
  IsNumbering.ofNecSuf (NecSuf.ComplexMatrixAlgebra.pairNumbering_isNumbering M)

set_option smartUnfolding false in
/-- 本文 `claim_two_element_set_is_finite_set` を、必要十分版から得たもの。 -/
theorem isFiniteSet_two_of_necSuf : IsFiniteSet (Idx 2) :=
  IsFiniteSet.ofNecSuf NecSuf.ComplexMatrixAlgebra.isFiniteSet_two

set_option smartUnfolding false in
/-- 本文 `claim_membership_in_reversed_subset` を、必要十分版から得たもの。 -/
theorem mem_reversal_iff_of_necSuf {M : ℕ} (T : PowerSet M) (t : ℕ) (ht1 : 1 ≤ t) (htM : t ≤ M) :
    t ∈ (reversal M T).1 ↔ M + 1 - t ∈ T.1 :=
  NecSuf.ComplexMatrixAlgebra.mem_reversal_iff T t ht1 htM

set_option smartUnfolding false in
/-- 本文 `claim_reversal_of_subsets_is_involution` を、必要十分版から得たもの。 -/
theorem reversal_reversal_of_necSuf (M : ℕ) (T : PowerSet M) : reversal M (reversal M T) = T :=
  NecSuf.ComplexMatrixAlgebra.reversal_reversal M T

set_option smartUnfolding false in
/-- 本文 `claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set` を、必要十分版から得たもの。 -/
theorem firstSiteHighestNumbering_isNumbering_of_necSuf (M : ℕ) :
    IsNumbering (twoPower M) (firstSiteHighestNumbering M) :=
  IsNumbering.ofNecSuf (NecSuf.ComplexMatrixAlgebra.firstSiteHighestNumbering_isNumbering M)

set_option smartUnfolding false in
/-- 本文 `claim_tuple_of_membership_indices_of_positions_of_two_is_original` を、必要十分版から得たもの。 -/
theorem membershipTuple_positionsOfTwo_of_necSuf {M : ℕ} (I : OneTwoTuple M) :
    membershipTuple (positionsOfTwo I) = I :=
  NecSuf.ComplexMatrixAlgebra.membershipTuple_positionsOfTwo I

set_option smartUnfolding false in
/-- 本文 `claim_ordered_sum_of_integers_splits_off_first_term` を、必要十分版から得たもの。 -/
theorem orderedIntSum_split_first_of_necSuf (n : ℤ → ℤ) (a b : ℤ) (hab : a ≤ b) :
    orderedIntSum n a b = n a + orderedIntSum n (a + 1) b :=
  NecSuf.ComplexMatrixAlgebra.orderedIntSum_split_first n a b hab

set_option smartUnfolding false in
/-- 本文 `claim_ordered_sum_of_integers_is_unchanged_by_shifting_index` を、必要十分版から得たもの。 -/
theorem orderedIntSum_shift_of_necSuf (n : ℤ → ℤ) (a b : ℤ) :
    orderedIntSum n (a + 1) (b + 1) = orderedIntSum (fun s => n (s + 1)) a b :=
  NecSuf.ComplexMatrixAlgebra.orderedIntSum_shift n a b

set_option smartUnfolding false in
/-- 本文 `claim_ordered_sums_of_integers_with_equal_terms_are_equal` を、必要十分版から得たもの。 -/
theorem orderedIntSum_congr_of_necSuf (n n' : ℤ → ℤ) (a b : ℤ)
    (h : ∀ t : ℤ, a ≤ t → t ≤ b → n t = n' t) :
    orderedIntSum n a b = orderedIntSum n' a b :=
  NecSuf.ComplexMatrixAlgebra.orderedIntSum_congr n n' a b h

set_option smartUnfolding false in
/-- 本文 `claim_number_of_membership_tuple_of_reversed_subset_without_top_element` を、必要十分版から得たもの。 -/
theorem tupleNumber_reversal_of_lift_of_necSuf (M : ℕ) (S : PowerSet M) :
    tupleNumber (M + 1) (membershipTuple (reversal (M + 1) (liftPowerSet S)))
      = tupleNumber M (membershipTuple (reversal M S)) :=
  NecSuf.ComplexMatrixAlgebra.tupleNumber_reversal_of_lift M S

set_option smartUnfolding false in
/-- 本文 `claim_number_of_membership_tuple_of_reversed_subset_with_top_element` を、必要十分版から得たもの。 -/
theorem tupleNumber_reversal_of_addTop_of_necSuf (M : ℕ) (S : PowerSet M) :
    tupleNumber (M + 1) (membershipTuple (reversal (M + 1) (addTopElement S)))
      = (twoPower M : ℤ) + tupleNumber M (membershipTuple (reversal M S)) :=
  NecSuf.ComplexMatrixAlgebra.tupleNumber_reversal_of_addTop M S

set_option smartUnfolding false in
/-- 本文 `claim_number_of_membership_tuple_after_numbering_with_first_site_as_highest_digit` を、必要十分版から得たもの。 -/
theorem tupleNumber_membershipTuple_firstSiteHighestNumbering_of_necSuf (M : ℕ) (k : Idx (twoPower M)) :
    tupleNumber M (membershipTuple (firstSiteHighestNumbering M k)) = (k.1 : ℤ) :=
  NecSuf.ComplexMatrixAlgebra.tupleNumber_membershipTuple_firstSiteHighestNumbering M k

set_option smartUnfolding false in
/-- 本文 `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection` を、必要十分版から得たもの。 -/
theorem tupleNumber_injective_of_necSuf (M : ℕ) (I J : OneTwoTuple M)
    (h : tupleNumber M I = tupleNumber M J) : I = J :=
  NecSuf.ComplexMatrixAlgebra.tupleNumber_injective M I J h

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
