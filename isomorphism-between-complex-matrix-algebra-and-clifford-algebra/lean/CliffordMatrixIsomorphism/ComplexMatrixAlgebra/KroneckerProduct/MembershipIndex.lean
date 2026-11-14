/-
章「複素行列環」の、部分集合に番号が入るかどうかを 1・2 で表す添字の定義。ℂ を含まないので、具体版と必要十分版が
同じこのファイルを引く（必要十分版・導出版を置かない）。

  本文のラベル                       このファイル
  def_membership_index_of_subset     idxOne・idxTwo（{1,2} の二元）・membershipIndex（o_T(k)）・
                                     membershipIndex_of_mem・membershipIndex_of_not_mem（二つの場合）・
                                     idxOne_ne_idxTwo（1 ≠ 2）
  claim_entry_of_product_of_matrices_indexed_by_two_element_set の前提
                                     isNumbering_two（(2, id_2) は {1,2} の番号付け）・isFiniteSet_two（{1,2} は有限集合）

{1,2} は既存の `Idx 2`（{1,…,n} の部分型）で表し、その二元 1・2 を `idxOne`・`idxTwo` と書く。
番号 k は ℕ の元で、本文は k ∈ {1,…,M} についてだけ o_T(k) を使う（{1,…,M} の外の値は使わない）。
k ∈ T か k ∉ T のどちらか一方だけが成り立つことは、所属の判定に `Classical.propDecidable` を使って書く。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.PowerSet
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Numbering

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- {1,2} の元 1。 -/
def idxOne : Idx 2 := ⟨1, le_refl 1, by omega⟩

/-- {1,2} の元 2。 -/
def idxTwo : Idx 2 := ⟨2, by omega, le_refl 2⟩

/-- {1,2} の二元 1 と 2 は異なる。 -/
theorem idxOne_ne_idxTwo : idxOne ≠ idxTwo := by
  intro h
  have h' : (1 : ℕ) = 2 := congrArg Subtype.val h
  omega

/-- 本文 `claim_entry_of_product_of_matrices_indexed_by_two_element_set` の前提：id_2 を恒等写像とすると、
(2, id_2) は {1,2} の番号付けである。 -/
theorem isNumbering_two : IsNumbering 2 (fun k : Idx 2 => k) :=
  ⟨fun _ _ h => h, fun i => ⟨i, rfl⟩⟩

/-- 本文 `claim_entry_of_product_of_matrices_indexed_by_two_element_set` の前提：{1,2} は有限集合である。 -/
theorem isFiniteSet_two : IsFiniteSet (Idx 2) := ⟨2, fun k => k, isNumbering_two⟩

open Classical in
/-- 本文 `def_membership_index_of_subset`：o_T(k) := 2（k ∈ T）、o_T(k) := 1（k ∉ T）。 -/
noncomputable def membershipIndex {M : ℕ} (T : PowerSet M) (k : ℕ) : Idx 2 :=
  if k ∈ T.1 then idxTwo else idxOne

/-- 本文 `def_membership_index_of_subset` の k ∈ T の場合：o_T(k) = 2。 -/
theorem membershipIndex_of_mem {M : ℕ} (T : PowerSet M) (k : ℕ) (hk : k ∈ T.1) :
    membershipIndex T k = idxTwo := by
  unfold membershipIndex
  rw [if_pos hk]

/-- 本文 `def_membership_index_of_subset` の k ∉ T の場合：o_T(k) = 1。 -/
theorem membershipIndex_of_not_mem {M : ℕ} (T : PowerSet M) (k : ℕ) (hk : k ∉ T.1) :
    membershipIndex T k = idxOne := by
  unfold membershipIndex
  rw [if_neg hk]

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
