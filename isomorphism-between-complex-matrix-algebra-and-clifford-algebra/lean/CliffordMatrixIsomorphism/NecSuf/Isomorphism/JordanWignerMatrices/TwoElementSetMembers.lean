/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の証明が使う、{1,2} の元が 1 か 2 のどちらかであることと、
部分集合に番号が入るかどうかが違えば o_{M,T}(k) も違うこと。必要十分版。具体版 `Isomorphism/JordanWignerMatrices/TwoElementSetMembers.lean` と同じ定義と証明を、必要十分版の名前空間に置く（ℂ を含まないので、形は具体版と同じ）。どちらも本文のブロックではなく、本文が地の文で使う事実である。

  本文の箇所                                                        このファイル
  {1,2} の行列の四つの成分（「四つの成分がすべて等しいので、
  二つの行列は等しい」の行。{1,2} の元は 1 と 2 だけである）        idx_two_cases
  k ∈ S と k ∈ T が同値でなければ o_{M,S}(k) ≠ o_{M,T}(k)
  （def_membership_index_of_subset）                                membershipIndex_ne_of_not_iff
  o_{M,S}(k) と o_{M,T}(k) は k ∈ S と k ∈ T が同値なら等しい      membershipIndex_eq_of_iff
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.KroneckerProduct.MembershipIndex

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

/-- {1,2} の元は 1 か 2 である。 -/
theorem idx_two_cases (a : Idx 2) : a = idxOne ∨ a = idxTwo := by
  have h := a.2
  by_cases ha : a.1 = 1
  · exact Or.inl (Subtype.ext ha)
  · exact Or.inr (Subtype.ext (by show a.1 = 2; omega))

/-- 本文 `def_membership_index_of_subset` の二つの場合から：k ∈ S と k ∈ T が同値なら o_{M,S}(k) = o_{M,T}(k)。 -/
theorem membershipIndex_eq_of_iff {M : ℕ} (S T : PowerSet M) (k : ℕ) (h : k ∈ S.1 ↔ k ∈ T.1) :
    membershipIndex S k = membershipIndex T k := by
  by_cases hk : k ∈ S.1
  · rw [membershipIndex_of_mem S k hk, membershipIndex_of_mem T k (h.1 hk)]
  · rw [membershipIndex_of_not_mem S k hk, membershipIndex_of_not_mem T k (fun h' => hk (h.2 h'))]

/-- 本文 `def_membership_index_of_subset` の二つの場合から：k ∈ S と k ∈ T が同値でなければ、一方は 2、他方は 1 なので
o_{M,S}(k) ≠ o_{M,T}(k)。 -/
theorem membershipIndex_ne_of_not_iff {M : ℕ} (S T : PowerSet M) (k : ℕ) (h : ¬(k ∈ S.1 ↔ k ∈ T.1)) :
    membershipIndex S k ≠ membershipIndex T k := by
  by_cases hkS : k ∈ S.1
  · have hkT : k ∉ T.1 := fun h' => h ⟨fun _ => h', fun _ => hkS⟩
    rw [membershipIndex_of_mem S k hkS, membershipIndex_of_not_mem T k hkT]
    exact fun h' => idxOne_ne_idxTwo h'.symm
  · have hkT : k ∈ T.1 := by
      by_contra hkT
      exact h ⟨fun h' => absurd h' hkS, fun h' => absurd h' hkT⟩
    rw [membershipIndex_of_not_mem S k hkS, membershipIndex_of_mem T k hkT]
    exact idxOne_ne_idxTwo

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
