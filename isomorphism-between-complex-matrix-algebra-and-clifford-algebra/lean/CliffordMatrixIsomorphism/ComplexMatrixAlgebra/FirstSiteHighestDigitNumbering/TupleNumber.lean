/-
章「複素行列環」の、第 1 成分を最上位の桁として読んだ組の番号 num_M と、その四つの主張。人手証明と 1 対 1 に対応させる。
ℂ を含まないので、具体版と必要十分版が同じこのファイルを引く（必要十分版・導出版を置かない）。

  本文のラベル                                                                      このファイル
  def_number_of_tuple_with_first_site_as_highest_digit                              idxValue（{1,2} の元を ℤ の元として読む）・
                                                                                    twoPowerInt（2^{M-t} ∈ ℤ）・tupleNumberTerm（和の項）・
                                                                                    tupleNumber（num_M）
  claim_number_of_membership_tuple_of_reversed_subset_without_top_element           tupleNumber_reversal_of_lift
  claim_number_of_membership_tuple_of_reversed_subset_with_top_element              tupleNumber_reversal_of_addTop
  claim_number_of_membership_tuple_after_numbering_with_first_site_as_highest_digit tupleNumber_membershipTuple_firstSiteHighestNumbering
  claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection               tupleNumber_eq_inv（num_M(I) = r_M^{-1}(pos_M(I))）・
                                                                                    tupleNumber_mem（num_M(I) ∈ {1,…,2^M}）・
                                                                                    tupleNumberIdx（{1,…,2^M} への写像 num_M）・
                                                                                    tupleNumber_injective・tupleNumberIdx_injective（単射）・
                                                                                    tupleNumber_surjective・tupleNumberIdx_surjective（全射）・
                                                                                    tupleNumberInv（逆写像）・tupleNumberInv_tupleNumberIdx・
                                                                                    tupleNumberIdx_tupleNumberInv

本文の和 Σ_{t=1}^{M} の番号 t は ℤ の元なので、和の項は ℤ → ℤ の族で書く。I(t) は I を {1,…,M} の外で値 1 に延ばした族
`extendFamily I idxOne` の番号 t.toNat での値で、t ∈ {1,…,M} では I(t) である（外の値は使わない）。
2^{M-t} は `def_binary_numbering_of_power_set` の整数 `twoPower` の (M - t).toNat での値で、t ≤ M では本文の 2^{M-t} である。
番号の整数の計算（ℤ・ℕ の加減と順序、toNat）は `omega` で行う。

Lean の帰納的定義は M + 1 の段を M の段から作るので、本文の二つの「逆順に付け替えた組の番号」の主張の M・M - 1 は、
Lean では M + 1・M と読む。本文の「S ∈ P_{M-1} は S ∈ P_M でもある」は、P_M の元を ℕ の部分集合 T で表す（`PowerSet.lean`）ので、
同じ部分集合を P_{M+1} の元として読む写像 `liftPowerSet` で書く。S ∪ {M} は `addTopElement`。
本文の証明の、和の項を {a,…,b} の番号ごとに取り替える行（claim_ordered_sums_of_integers_with_equal_terms_are_equal）は `orderedIntSum_congr`、すべての番号で式が等しい項の取り替えは
族の等式（`funext`）を和に渡す行で書く。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.SubsetReversal
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.TuplesOfOnesAndTwos
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.OrderedIntegerSum

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- {1,2} の元 a を ℤ の元として読む。 -/
def idxValue (a : Idx 2) : ℤ := (a.1 : ℤ)

theorem idxValue_one_sub_one : idxValue idxOne - 1 = 0 := rfl

theorem idxValue_two_sub_one : idxValue idxTwo - 1 = 1 := rfl

/-- 本文 `def_number_of_tuple_with_first_site_as_highest_digit` の 2^{d} ∈ ℤ_{≥1}（d ≥ 0）：
`def_binary_numbering_of_power_set` の整数 2^{d} を ℤ の元として読む。 -/
def twoPowerInt (d : ℤ) : ℤ := (twoPower d.toNat : ℤ)

/-- 本文 `def_number_of_tuple_with_first_site_as_highest_digit` の和の項：t ↦ (I(t) - 1) · 2^{M-t}。 -/
def tupleNumberTerm (M : ℕ) (I : OneTwoTuple M) (t : ℤ) : ℤ :=
  (idxValue (extendFamily I idxOne t.toNat) - 1) * twoPowerInt ((M : ℤ) - t)

/-- 本文 `def_number_of_tuple_with_first_site_as_highest_digit`：num_M(I) := 1 + Σ_{t=1}^{M} (I(t) - 1) · 2^{M-t}。 -/
def tupleNumber (M : ℕ) (I : OneTwoTuple M) : ℤ :=
  1 + orderedIntSum (tupleNumberTerm M I) 1 M

/-- 本文 `def_tuple_of_membership_indices` を和の項へ当てる行：ō_M(T)(t) = o_{M,T}(t)。 -/
theorem tupleNumberTerm_membershipTuple (M : ℕ) (T : PowerSet M) :
    tupleNumberTerm M (membershipTuple T)
      = fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1) * twoPowerInt ((M : ℤ) - t) :=
  funext fun t => by
    show (idxValue (extendFamily (membershipTuple T) idxOne t.toNat) - 1) * twoPowerInt ((M : ℤ) - t) = _
    rw [extendFamily_membershipTuple]

/-- P_M の元を P_{M+1} の元として読む写像（同じ部分集合。S ⊆ {1,…,M} ⊆ {1,…,M+1}）。 -/
def liftPowerSet {M : ℕ} (S : PowerSet M) : PowerSet (M + 1) :=
  ⟨S.1, subset_of_powerSet_succ S⟩

/-- S ∈ P_M に番号 M + 1 を足した S ∪ {M + 1} ∈ P_{M+1}。 -/
def addTopElement {M : ℕ} (S : PowerSet M) : PowerSet (M + 1) :=
  ⟨S.1 ∪ {M + 1}, union_singleton_subset_of_powerSet_succ S⟩

/-- 本文 `claim_number_of_membership_tuple_of_reversed_subset_without_top_element`（Lean では M を M + 1 と読む）：
num_{M+1}(ō_{M+1}(ϱ_{M+1}(S))) = num_M(ō_M(ϱ_M(S)))。 -/
theorem tupleNumber_reversal_of_lift (M : ℕ) (S : PowerSet M) :
    tupleNumber (M + 1) (membershipTuple (reversal (M + 1) (liftPowerSet S)))
      = tupleNumber M (membershipTuple (reversal M S)) := by
  -- T := ϱ_{M+1}(S)、T' := ϱ_M(S)
  let T := reversal (M + 1) (liftPowerSet S)
  let T' := reversal M S
  -- （一）o_{M+1,T}(1) = 1：1 ∈ T は M + 1 ∈ S と同値で、S ⊆ {1,…,M} なので M + 1 ∉ S
  have h1 : membershipIndex T (1 : ℤ).toNat = idxOne := by
    apply membershipIndex_of_not_mem
    intro h
    have h' : M + 1 + 1 - 1 ∈ S.1 := (mem_reversal_iff (liftPowerSet S) 1 le_rfl (by omega)).1 h
    have hS := (S.2 _ h').2
    omega
  -- （二）t ∈ {2,…,M+1} について o_{M+1,T}(t) = o_{M,T'}(t - 1)
  have h2 : ∀ t : ℤ, 1 + 1 ≤ t → t ≤ ((M + 1 : ℕ) : ℤ) →
      membershipIndex T t.toNat = membershipIndex T' (t - 1).toNat := by
    intro t ht2 htM
    have hiff : t.toNat ∈ T.1 ↔ (t - 1).toNat ∈ T'.1 := calc
      t.toNat ∈ T.1
          -- claim_membership_in_reversed_subset
          ↔ M + 1 + 1 - t.toNat ∈ (liftPowerSet S).1 := mem_reversal_iff _ _ (by omega) (by omega)
      -- (M + 1) + 1 - t = M + 1 - (t - 1)
      _ ↔ M + 1 - (t - 1).toNat ∈ (liftPowerSet S).1 := by
          rw [show M + 1 + 1 - t.toNat = M + 1 - (t - 1).toNat by omega]
      -- claim_membership_in_reversed_subset で M + 1 → M、t → t - 1
      _ ↔ (t - 1).toNat ∈ T'.1 := (mem_reversal_iff S _ (by omega) (by omega)).symm
    -- 二つの添字は同じ場合分けで 2 か 1 になる（def_membership_index_of_subset）
    by_cases ht : t.toNat ∈ T.1
    · rw [membershipIndex_of_mem T _ ht, membershipIndex_of_mem T' _ (hiff.1 ht)]
    · rw [membershipIndex_of_not_mem T _ ht, membershipIndex_of_not_mem T' _ (fun h => ht (hiff.2 h))]
  calc tupleNumber (M + 1) (membershipTuple T)
      -- def_number_of_tuple_with_first_site_as_highest_digit
      = 1 + orderedIntSum (tupleNumberTerm (M + 1) (membershipTuple T)) 1 ((M + 1 : ℕ) : ℤ) := rfl
    -- def_tuple_of_membership_indices
    _ = 1 + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
          * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) 1 ((M + 1 : ℕ) : ℤ) := by
        rw [tupleNumberTerm_membershipTuple]
    -- claim_ordered_sum_of_integers_splits_off_first_term で a := 1、b := M + 1
    _ = 1 + ((idxValue (membershipIndex T (1 : ℤ).toNat) - 1) * twoPowerInt (((M + 1 : ℕ) : ℤ) - 1)
          + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
            * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ)) :=
        congrArg (1 + ·) (orderedIntSum_split_first _ 1 _ (by omega))
    -- （一）
    _ = 1 + ((idxValue idxOne - 1) * twoPowerInt (((M + 1 : ℕ) : ℤ) - 1)
          + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
            * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ)) := by rw [h1]
    -- (1 - 1) · 2^{M} = 0
    _ = 1 + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
          * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ) := by
        rw [idxValue_one_sub_one, zero_mul, zero_add]
    -- （二）
    _ = 1 + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T' (t - 1).toNat) - 1)
          * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ) :=
        congrArg (1 + ·) (orderedIntSum_congr _ _ _ _ fun t ht2 htM =>
          congrArg (fun a => (idxValue a - 1) * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (h2 t ht2 htM))
    -- (M + 1) - t = M - (t - 1)
    _ = 1 + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T' (t - 1).toNat) - 1)
          * twoPowerInt ((M : ℤ) - (t - 1))) (1 + 1) ((M + 1 : ℕ) : ℤ) :=
        congrArg (fun f => 1 + orderedIntSum f (1 + 1) ((M + 1 : ℕ) : ℤ)) (funext fun t =>
          congrArg (fun d => (idxValue (membershipIndex T' (t - 1).toNat) - 1) * twoPowerInt d)
            (show ((M + 1 : ℕ) : ℤ) - t = (M : ℤ) - (t - 1) by omega))
    -- claim_ordered_sum_of_integers_is_unchanged_by_shifting_index で a := 1、b := M
    _ = 1 + orderedIntSum (fun s : ℤ => (idxValue (membershipIndex T' ((s + 1) - 1).toNat) - 1)
          * twoPowerInt ((M : ℤ) - ((s + 1) - 1))) 1 (M : ℤ) := by
        rw [Nat.cast_succ, orderedIntSum_shift]
    -- (s + 1) - 1 = s
    _ = 1 + orderedIntSum (fun s : ℤ => (idxValue (membershipIndex T' s.toNat) - 1)
          * twoPowerInt ((M : ℤ) - s)) 1 (M : ℤ) := by
        simp only [add_sub_cancel_right]
    -- def_tuple_of_membership_indices
    _ = 1 + orderedIntSum (tupleNumberTerm M (membershipTuple T')) 1 (M : ℤ) := by
        rw [tupleNumberTerm_membershipTuple]
    -- def_number_of_tuple_with_first_site_as_highest_digit
    _ = tupleNumber M (membershipTuple T') := rfl

/-- 本文 `claim_number_of_membership_tuple_of_reversed_subset_with_top_element`（Lean では M を M + 1 と読む）：
num_{M+1}(ō_{M+1}(ϱ_{M+1}(S ∪ {M+1}))) = 2^{M} + num_M(ō_M(ϱ_M(S)))。 -/
theorem tupleNumber_reversal_of_addTop (M : ℕ) (S : PowerSet M) :
    tupleNumber (M + 1) (membershipTuple (reversal (M + 1) (addTopElement S)))
      = (twoPower M : ℤ) + tupleNumber M (membershipTuple (reversal M S)) := by
  -- T := ϱ_{M+1}(S ∪ {M+1})、T' := ϱ_M(S)
  let T := reversal (M + 1) (addTopElement S)
  let T' := reversal M S
  -- （一）o_{M+1,T}(1) = 2：(M + 1) + 1 - 1 = M + 1 ∈ S ∪ {M + 1} なので 1 ∈ T
  have h1 : membershipIndex T (1 : ℤ).toNat = idxTwo := by
    apply membershipIndex_of_mem
    exact (mem_reversal_iff (addTopElement S) 1 le_rfl (by omega)).2
      (Or.inr (show M + 1 + 1 - 1 = M + 1 by omega))
  -- （二）t ∈ {2,…,M+1} について o_{M+1,T}(t) = o_{M,T'}(t - 1)
  have h2 : ∀ t : ℤ, 1 + 1 ≤ t → t ≤ ((M + 1 : ℕ) : ℤ) →
      membershipIndex T t.toNat = membershipIndex T' (t - 1).toNat := by
    intro t ht2 htM
    have hiff : t.toNat ∈ T.1 ↔ (t - 1).toNat ∈ T'.1 := calc
      t.toNat ∈ T.1
          -- claim_membership_in_reversed_subset
          ↔ M + 1 + 1 - t.toNat ∈ (addTopElement S).1 := mem_reversal_iff _ _ (by omega) (by omega)
      -- 和集合と {M + 1} の定義
      _ ↔ (M + 1 + 1 - t.toNat ∈ S.1 ∨ M + 1 + 1 - t.toNat = M + 1) := Iff.rfl
      -- (M + 1) + 1 - t ≤ M なので (M + 1) + 1 - t ≠ M + 1
      _ ↔ M + 1 + 1 - t.toNat ∈ S.1 := or_iff_left (by omega)
      -- (M + 1) + 1 - t = M + 1 - (t - 1)
      _ ↔ M + 1 - (t - 1).toNat ∈ S.1 := by
          rw [show M + 1 + 1 - t.toNat = M + 1 - (t - 1).toNat by omega]
      -- claim_membership_in_reversed_subset で M + 1 → M、t → t - 1
      _ ↔ (t - 1).toNat ∈ T'.1 := (mem_reversal_iff S _ (by omega) (by omega)).symm
    -- 二つの添字は等しい（def_membership_index_of_subset）
    by_cases ht : t.toNat ∈ T.1
    · rw [membershipIndex_of_mem T _ ht, membershipIndex_of_mem T' _ (hiff.1 ht)]
    · rw [membershipIndex_of_not_mem T _ ht, membershipIndex_of_not_mem T' _ (fun h => ht (hiff.2 h))]
  calc tupleNumber (M + 1) (membershipTuple T)
      -- def_number_of_tuple_with_first_site_as_highest_digit
      = 1 + orderedIntSum (tupleNumberTerm (M + 1) (membershipTuple T)) 1 ((M + 1 : ℕ) : ℤ) := rfl
    -- def_tuple_of_membership_indices
    _ = 1 + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
          * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) 1 ((M + 1 : ℕ) : ℤ) := by
        rw [tupleNumberTerm_membershipTuple]
    -- claim_ordered_sum_of_integers_splits_off_first_term で a := 1、b := M + 1
    _ = 1 + ((idxValue (membershipIndex T (1 : ℤ).toNat) - 1) * twoPowerInt (((M + 1 : ℕ) : ℤ) - 1)
          + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
            * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ)) :=
        congrArg (1 + ·) (orderedIntSum_split_first _ 1 _ (by omega))
    -- （一）
    _ = 1 + ((idxValue idxTwo - 1) * twoPowerInt (((M + 1 : ℕ) : ℤ) - 1)
          + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
            * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ)) := by rw [h1]
    -- (2 - 1) · 2^{M} = 2^{M}
    _ = 1 + (twoPowerInt (((M + 1 : ℕ) : ℤ) - 1)
          + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
            * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ)) := by
        rw [idxValue_two_sub_one, one_mul]
    -- (M + 1) - 1 = M（本文の 2^{M-1} の指数。Lean では M を M + 1 と読む）
    _ = 1 + ((twoPower M : ℤ)
          + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
            * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ)) := by
        rw [show ((M + 1 : ℕ) : ℤ) - 1 = (M : ℤ) by omega]
        rfl
    -- ℤ の加法の交換法則と結合法則
    _ = (twoPower M : ℤ) + (1 + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T t.toNat) - 1)
          * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ)) := by
        rw [← add_assoc, add_comm 1 (twoPower M : ℤ), add_assoc]
    -- （二）
    _ = (twoPower M : ℤ) + (1 + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T' (t - 1).toNat) - 1)
          * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (1 + 1) ((M + 1 : ℕ) : ℤ)) :=
        congrArg (fun x => (twoPower M : ℤ) + (1 + x)) (orderedIntSum_congr _ _ _ _ fun t ht2 htM =>
          congrArg (fun a => (idxValue a - 1) * twoPowerInt (((M + 1 : ℕ) : ℤ) - t)) (h2 t ht2 htM))
    -- (M + 1) - t = M - (t - 1)
    _ = (twoPower M : ℤ) + (1 + orderedIntSum (fun t : ℤ => (idxValue (membershipIndex T' (t - 1).toNat) - 1)
          * twoPowerInt ((M : ℤ) - (t - 1))) (1 + 1) ((M + 1 : ℕ) : ℤ)) :=
        congrArg (fun f => (twoPower M : ℤ) + (1 + orderedIntSum f (1 + 1) ((M + 1 : ℕ) : ℤ))) (funext fun t =>
          congrArg (fun d => (idxValue (membershipIndex T' (t - 1).toNat) - 1) * twoPowerInt d)
            (show ((M + 1 : ℕ) : ℤ) - t = (M : ℤ) - (t - 1) by omega))
    -- claim_ordered_sum_of_integers_is_unchanged_by_shifting_index で a := 1、b := M
    _ = (twoPower M : ℤ) + (1 + orderedIntSum (fun s : ℤ => (idxValue (membershipIndex T' ((s + 1) - 1).toNat) - 1)
          * twoPowerInt ((M : ℤ) - ((s + 1) - 1))) 1 (M : ℤ)) := by
        rw [Nat.cast_succ, orderedIntSum_shift]
    -- (s + 1) - 1 = s
    _ = (twoPower M : ℤ) + (1 + orderedIntSum (fun s : ℤ => (idxValue (membershipIndex T' s.toNat) - 1)
          * twoPowerInt ((M : ℤ) - s)) 1 (M : ℤ)) := by
        simp only [add_sub_cancel_right]
    -- def_tuple_of_membership_indices
    _ = (twoPower M : ℤ) + (1 + orderedIntSum (tupleNumberTerm M (membershipTuple T')) 1 (M : ℤ)) := by
        rw [tupleNumberTerm_membershipTuple]
    -- def_number_of_tuple_with_first_site_as_highest_digit
    _ = (twoPower M : ℤ) + tupleNumber M (membershipTuple T') := rfl

/-- 本文 `claim_number_of_membership_tuple_after_numbering_with_first_site_as_highest_digit`：
k ∈ {1,…,2^M} について num_M(ō_M(r_M(k))) = k。M についての帰納法で示す。 -/
theorem tupleNumber_membershipTuple_firstSiteHighestNumbering :
    ∀ (M : ℕ) (k : Idx (twoPower M)),
      tupleNumber M (membershipTuple (firstSiteHighestNumbering M k)) = (k.1 : ℤ)
  | 0, k => by
    -- M = 0 のとき k = 1 であり、{1,…,0} は空集合なので t = 1,…,0 の和は 0
    have hk := k.2
    have h20 : twoPower 0 = 1 := rfl
    calc tupleNumber 0 (membershipTuple (firstSiteHighestNumbering 0 k))
        -- def_number_of_tuple_with_first_site_as_highest_digit
        = 1 + orderedIntSum (tupleNumberTerm 0 (membershipTuple (firstSiteHighestNumbering 0 k))) 1 ((0 : ℕ) : ℤ) :=
          rfl
      -- def_ordered_sum_of_integers の b < a の場合
      _ = 1 + 0 := by rw [orderedIntSum_of_lt _ (by omega : ((0 : ℕ) : ℤ) < 1)]
      _ = 1 := add_zero 1
      _ = (k.1 : ℤ) := by omega
  | M + 1, k => by
    -- h := 2^{M}（Lean では M を M + 1 と読む）
    by_cases hk : k.1 ≤ twoPower M
    · -- k ≤ h の場合：e_{M+1}(k) = e_M(k)（def_binary_numbering_of_power_set）
      let k' : Idx (twoPower M) := ⟨k.1, k.2.1, hk⟩
      have he : binaryNumbering (M + 1) k = liftPowerSet (binaryNumbering M k') :=
        Subtype.ext (binaryNumbering_succ_of_le M k hk)
      calc tupleNumber (M + 1) (membershipTuple (firstSiteHighestNumbering (M + 1) k))
          -- def_numbering_of_power_set_with_first_site_as_highest_digit
          = tupleNumber (M + 1) (membershipTuple (reversal (M + 1) (binaryNumbering (M + 1) k))) := rfl
        -- def_binary_numbering_of_power_set で k ≤ h
        _ = tupleNumber (M + 1) (membershipTuple (reversal (M + 1) (liftPowerSet (binaryNumbering M k')))) := by
            rw [he]
        -- claim_number_of_membership_tuple_of_reversed_subset_without_top_element で S := e_M(k)
        _ = tupleNumber M (membershipTuple (reversal M (binaryNumbering M k'))) :=
            tupleNumber_reversal_of_lift M _
        -- def_numbering_of_power_set_with_first_site_as_highest_digit
        _ = tupleNumber M (membershipTuple (firstSiteHighestNumbering M k')) := rfl
        -- 帰納法の仮定
        _ = (k.1 : ℤ) := tupleNumber_membershipTuple_firstSiteHighestNumbering M k'
    · -- k > h の場合：k - h ∈ {1,…,h}、e_{M+1}(k) = e_M(k - h) ∪ {M + 1}（def_binary_numbering_of_power_set）
      let k' : Idx (twoPower M) := ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩
      have he : binaryNumbering (M + 1) k = addTopElement (binaryNumbering M k') :=
        Subtype.ext (binaryNumbering_succ_of_gt M k hk)
      calc tupleNumber (M + 1) (membershipTuple (firstSiteHighestNumbering (M + 1) k))
          -- def_numbering_of_power_set_with_first_site_as_highest_digit
          = tupleNumber (M + 1) (membershipTuple (reversal (M + 1) (binaryNumbering (M + 1) k))) := rfl
        -- def_binary_numbering_of_power_set で k > h
        _ = tupleNumber (M + 1) (membershipTuple (reversal (M + 1) (addTopElement (binaryNumbering M k')))) := by
            rw [he]
        -- claim_number_of_membership_tuple_of_reversed_subset_with_top_element で S := e_M(k - h)
        _ = (twoPower M : ℤ) + tupleNumber M (membershipTuple (reversal M (binaryNumbering M k'))) :=
            tupleNumber_reversal_of_addTop M _
        -- def_numbering_of_power_set_with_first_site_as_highest_digit
        _ = (twoPower M : ℤ) + tupleNumber M (membershipTuple (firstSiteHighestNumbering M k')) := rfl
        -- 帰納法の仮定
        _ = (twoPower M : ℤ) + ((k.1 - twoPower M : ℕ) : ℤ) := by
            rw [tupleNumber_membershipTuple_firstSiteHighestNumbering M k']
        _ = (k.1 : ℤ) := by omega

/-- 本文 `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection` の証明の前半：
num_M(I) = r_M^{-1}(pos_M(I))。r_M^{-1} は番号付け (2^M, r_M) の逆写像（`def_numbering_of_finite_set`）。 -/
theorem tupleNumber_eq_inv (M : ℕ) (I : OneTwoTuple M) :
    tupleNumber M I = (((firstSiteHighestNumbering_isNumbering M).inv (positionsOfTwo I)).1 : ℤ) := calc
  tupleNumber M I
      -- claim_tuple_of_membership_indices_of_positions_of_two_is_original
      = tupleNumber M (membershipTuple (positionsOfTwo I)) := by rw [membershipTuple_positionsOfTwo]
  -- def_numbering_of_finite_set の e(e^{-1}(x)) = x
  _ = tupleNumber M (membershipTuple (firstSiteHighestNumbering M
        ((firstSiteHighestNumbering_isNumbering M).inv (positionsOfTwo I)))) := by
      rw [(firstSiteHighestNumbering_isNumbering M).apply_inv]
  -- claim_number_of_membership_tuple_after_numbering_with_first_site_as_highest_digit で k := r_M^{-1}(pos_M(I))
  _ = (((firstSiteHighestNumbering_isNumbering M).inv (positionsOfTwo I)).1 : ℤ) :=
      tupleNumber_membershipTuple_firstSiteHighestNumbering M _

/-- 本文 `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection`：num_M(I) ∈ {1,…,2^M}。 -/
theorem tupleNumber_mem (M : ℕ) (I : OneTwoTuple M) :
    1 ≤ tupleNumber M I ∧ tupleNumber M I ≤ (twoPower M : ℤ) := by
  have h := ((firstSiteHighestNumbering_isNumbering M).inv (positionsOfTwo I)).2
  rw [tupleNumber_eq_inv]
  omega

/-- 本文 `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection` の写像 num_M : 𝓘_M → {1,…,2^M}。 -/
def tupleNumberIdx (M : ℕ) (I : OneTwoTuple M) : Idx (twoPower M) :=
  ⟨(tupleNumber M I).toNat, by have h := tupleNumber_mem M I; omega⟩

theorem tupleNumberIdx_val (M : ℕ) (I : OneTwoTuple M) : ((tupleNumberIdx M I).1 : ℤ) = tupleNumber M I := by
  have h := tupleNumber_mem M I
  show (((tupleNumber M I).toNat : ℕ) : ℤ) = tupleNumber M I
  omega

/-- 上で示した num_M(I) = r_M^{-1}(pos_M(I)) を {1,…,2^M} の元の等式として書いたもの。 -/
theorem inv_positionsOfTwo_eq_tupleNumberIdx (M : ℕ) (I : OneTwoTuple M) :
    (firstSiteHighestNumbering_isNumbering M).inv (positionsOfTwo I) = tupleNumberIdx M I :=
  Subtype.ext (by
    have h1 := tupleNumber_eq_inv M I
    have h2 := tupleNumberIdx_val M I
    omega)

/-- 本文 `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection`：単射であること。
num_M(I) = num_M(J) なら I = J。 -/
theorem tupleNumber_injective (M : ℕ) (I J : OneTwoTuple M) (h : tupleNumber M I = tupleNumber M J) :
    I = J := by
  have hIJ : tupleNumberIdx M I = tupleNumberIdx M J :=
    Subtype.ext (show (tupleNumber M I).toNat = (tupleNumber M J).toNat by rw [h])
  calc I
      -- claim_tuple_of_membership_indices_of_positions_of_two_is_original
      = membershipTuple (positionsOfTwo I) := (membershipTuple_positionsOfTwo I).symm
    -- def_numbering_of_finite_set の e(e^{-1}(x)) = x
    _ = membershipTuple (firstSiteHighestNumbering M
          ((firstSiteHighestNumbering_isNumbering M).inv (positionsOfTwo I))) := by
        rw [(firstSiteHighestNumbering_isNumbering M).apply_inv]
    -- 上で示した num_M(I) = r_M^{-1}(pos_M(I))
    _ = membershipTuple (firstSiteHighestNumbering M (tupleNumberIdx M I)) := by
        rw [inv_positionsOfTwo_eq_tupleNumberIdx]
    -- num_M(I) = num_M(J)
    _ = membershipTuple (firstSiteHighestNumbering M (tupleNumberIdx M J)) := by rw [hIJ]
    -- 上で示した num_M(J) = r_M^{-1}(pos_M(J))
    _ = membershipTuple (firstSiteHighestNumbering M
          ((firstSiteHighestNumbering_isNumbering M).inv (positionsOfTwo J))) := by
        rw [inv_positionsOfTwo_eq_tupleNumberIdx]
    -- def_numbering_of_finite_set の e(e^{-1}(x)) = x
    _ = membershipTuple (positionsOfTwo J) := by
        rw [(firstSiteHighestNumbering_isNumbering M).apply_inv]
    -- claim_tuple_of_membership_indices_of_positions_of_two_is_original
    _ = J := membershipTuple_positionsOfTwo J

/-- 本文 `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection`：写像 num_M : 𝓘_M → {1,…,2^M} は単射である。 -/
theorem tupleNumberIdx_injective (M : ℕ) (I J : OneTwoTuple M) (h : tupleNumberIdx M I = tupleNumberIdx M J) :
    I = J := by
  have h1 := tupleNumberIdx_val M I
  have h2 := tupleNumberIdx_val M J
  have h3 : (tupleNumberIdx M I).1 = (tupleNumberIdx M J).1 := congrArg Subtype.val h
  exact tupleNumber_injective M I J (by omega)

/-- 本文 `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection`：全射であること。
k ∈ {1,…,2^M} について I := ō_M(r_M(k)) は num_M(I) = k を満たす。 -/
theorem tupleNumber_surjective (M : ℕ) (k : Idx (twoPower M)) :
    ∃ I : OneTwoTuple M, tupleNumber M I = (k.1 : ℤ) :=
  ⟨membershipTuple (firstSiteHighestNumbering M k), tupleNumber_membershipTuple_firstSiteHighestNumbering M k⟩

/-- 本文 `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection`：写像 num_M : 𝓘_M → {1,…,2^M} は全射である。 -/
theorem tupleNumberIdx_surjective (M : ℕ) (k : Idx (twoPower M)) :
    ∃ I : OneTwoTuple M, tupleNumberIdx M I = k := by
  obtain ⟨I, hI⟩ := tupleNumber_surjective M k
  refine ⟨I, Subtype.ext ?_⟩
  show (tupleNumber M I).toNat = k.1
  omega

/-- 全単射 num_M : 𝓘_M → {1,…,2^M} の逆写像：k に num_M(I) = k を満たすただ一つの I を与える。 -/
noncomputable def tupleNumberInv (M : ℕ) (k : Idx (twoPower M)) : OneTwoTuple M :=
  Classical.choose (tupleNumberIdx_surjective M k)

theorem tupleNumberIdx_tupleNumberInv (M : ℕ) (k : Idx (twoPower M)) :
    tupleNumberIdx M (tupleNumberInv M k) = k :=
  Classical.choose_spec (tupleNumberIdx_surjective M k)

theorem tupleNumberInv_tupleNumberIdx (M : ℕ) (I : OneTwoTuple M) :
    tupleNumberInv M (tupleNumberIdx M I) = I :=
  tupleNumberIdx_injective M _ _ (tupleNumberIdx_tupleNumberInv M (tupleNumberIdx M I))

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
