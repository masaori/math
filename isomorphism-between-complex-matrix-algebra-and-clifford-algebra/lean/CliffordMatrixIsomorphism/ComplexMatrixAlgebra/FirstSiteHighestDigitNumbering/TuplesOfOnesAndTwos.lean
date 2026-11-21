/-
章「複素行列環」の、各成分が 1 か 2 である M 個組の全体 𝓘_M、部分集合に各番号が入るかどうかを並べた組 ō_M、
組の成分が 2 である番号の集合 pos_M。人手証明と 1 対 1 に対応させる。
必要十分版は `NecSuf/ComplexMatrixAlgebra/FirstSiteHighestDigitNumbering/TuplesOfOnesAndTwos.lean` に同じ形で置く。

  本文のラベル                                                          このファイル
  def_tuples_of_ones_and_twos                                           OneTwoTuple（𝓘_M）・OneTwoTuple.ext（写像の等しさ）
  def_tuple_of_membership_indices                                       membershipTuple（ō_M）
  def_positions_of_two_in_tuple                                         positionsOfTwo（pos_M）・mem_positionsOfTwo_iff
  claim_tuple_of_membership_indices_of_positions_of_two_is_original     membershipTuple_positionsOfTwo

𝓘_M の元 I : {1,…,M} → {1,2} は `Idx M → Idx 2` で表す（写像の等しさが I = J になるよう、{1,…,M} の外の値を持たせない）。
番号 t を ℕ の元として受け取る式（番号順の積・和の項）には、I を {1,…,M} の外で値 1 に延ばした族 `extendFamily I idxOne`
（`FiniteSetSum/Numbering.lean`）を渡す。外の値は使わない。
{1,2} の元が 1 か 2 のどちらかであること（本文の「I(t) ∈ {1,2} なので二つの場合に分ける」）は `idxTwoElement_cases`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.MembershipIndex

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- 本文 `def_tuples_of_ones_and_twos`：𝓘_M := {I : {1,…,M} → {1,2}}。 -/
abbrev OneTwoTuple (M : ℕ) : Type := Idx M → Idx 2

/-- 本文 `def_tuples_of_ones_and_twos`：I = J は、すべての t ∈ {1,…,M} で I(t) = J(t) であること（写像の等しさ）。 -/
theorem OneTwoTuple.ext {M : ℕ} {I J : OneTwoTuple M} (h : ∀ t : Idx M, I t = J t) : I = J :=
  funext h

/-- {1,2} の元は 1 か 2 である。 -/
theorem idxTwoElement_cases (a : Idx 2) : a = idxOne ∨ a = idxTwo := by
  have h := a.2
  by_cases ha : a.1 = 1
  · exact Or.inl (Subtype.ext ha)
  · exact Or.inr (Subtype.ext (by show a.1 = 2; omega))

/-- 本文 `def_tuple_of_membership_indices`：ō_M(T)(t) := o_{M,T}(t)。 -/
noncomputable def membershipTuple {M : ℕ} (T : PowerSet M) : OneTwoTuple M :=
  fun t => membershipIndex T t.1

/-- ō_M(T) を {1,…,M} の外で値 1 に延ばした族は、すべての番号 k で o_{M,T}(k) に等しい
（{1,…,M} の外の k は T に入らないので o_{M,T}(k) = 1）。 -/
theorem extendFamily_membershipTuple {M : ℕ} (T : PowerSet M) (k : ℕ) :
    extendFamily (membershipTuple T) idxOne k = membershipIndex T k := by
  by_cases hk : 1 ≤ k ∧ k ≤ M
  · rw [extendFamily_of_le (membershipTuple T) idxOne k hk.1 hk.2]
    rfl
  · have hkT : k ∉ T.1 := fun h => hk (T.2 k h)
    unfold extendFamily
    rw [dif_neg hk, membershipIndex_of_not_mem T k hkT]

/-- 本文 `def_positions_of_two_in_tuple`：pos_M(I) := {t ∈ {1,…,M} : I(t) = 2}。 -/
def positionsOfTwo {M : ℕ} (I : OneTwoTuple M) : PowerSet M :=
  ⟨{t : ℕ | ∃ h : 1 ≤ t ∧ t ≤ M, I ⟨t, h⟩ = idxTwo}, fun _ ht => ht.1⟩

/-- 本文 `def_positions_of_two_in_tuple`：t ∈ {1,…,M} について t ∈ pos_M(I) ⟺ I(t) = 2。 -/
theorem mem_positionsOfTwo_iff {M : ℕ} (I : OneTwoTuple M) (t : Idx M) :
    t.1 ∈ (positionsOfTwo I).1 ↔ I t = idxTwo :=
  ⟨fun h => h.2, fun h => ⟨t.2, h⟩⟩

/-- 本文 `claim_tuple_of_membership_indices_of_positions_of_two_is_original`：ō_M(pos_M(I)) = I。 -/
theorem membershipTuple_positionsOfTwo {M : ℕ} (I : OneTwoTuple M) :
    membershipTuple (positionsOfTwo I) = I := by
  -- 写像の等しさ（def_tuples_of_ones_and_twos）を確かめる
  apply OneTwoTuple.ext
  intro t
  -- I(t) ∈ {1,2} なので二つの場合に分ける
  rcases idxTwoElement_cases (I t) with h1 | h2
  · -- I(t) = 1 の場合：I(t) ≠ 2 なので t ∉ pos_M(I)（def_positions_of_two_in_tuple）
    have ht : t.1 ∉ (positionsOfTwo I).1 := fun h =>
      idxOne_ne_idxTwo (h1.symm.trans ((mem_positionsOfTwo_iff I t).1 h))
    calc membershipTuple (positionsOfTwo I) t
        -- def_tuple_of_membership_indices
        = membershipIndex (positionsOfTwo I) t.1 := rfl
      -- t ∉ pos_M(I)。def_membership_index_of_subset
      _ = idxOne := membershipIndex_of_not_mem _ _ ht
      -- I(t) = 1
      _ = I t := h1.symm
  · -- I(t) = 2 の場合：t ∈ pos_M(I)（def_positions_of_two_in_tuple）
    have ht : t.1 ∈ (positionsOfTwo I).1 := (mem_positionsOfTwo_iff I t).2 h2
    calc membershipTuple (positionsOfTwo I) t
        -- def_tuple_of_membership_indices
        = membershipIndex (positionsOfTwo I) t.1 := rfl
      -- t ∈ pos_M(I)。def_membership_index_of_subset
      _ = idxTwo := membershipIndex_of_mem _ _ ht
      -- I(t) = 2
      _ = I t := h2.symm

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
