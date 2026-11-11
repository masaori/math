import Ising2DLambda.KacWard.SmoothedSuccessorMap
import Ising2DLambda.NecSuf.KacWard.SmoothingIndexBlocks

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- 本文の閉じた非後退辺列 `(e_1, …, e_{m+1})` の添字 `I_{m+1} = {1, …, m+1}` と、
Lean の辺列 `γ : Fin (m + 1) → OrientedEdge L` の添字の対応。Lean の `r` は本文の `r + 1`。 -/
def closedWalkTextIndex {m : ℕ} (r : Fin (m + 1)) : {n : ℕ // 1 ≤ n ∧ n ≤ m + 1} :=
  ⟨r.val + 1, Nat.succ_pos _, r.isLt⟩

/-- 添字の対応 `closedWalkTextIndex` は全単射である。 -/
def closedWalkTextIndexEquiv (m : ℕ) : Fin (m + 1) ≃ {n : ℕ // 1 ≤ n ∧ n ≤ m + 1} where
  toFun := closedWalkTextIndex
  invFun n := ⟨n.val - 1, by have := n.property; omega⟩
  left_inv r := by ext; simp [closedWalkTextIndex]
  right_inv n := by
    ext
    have := n.property
    simp [closedWalkTextIndex]
    omega

/-- 添字の対応は順序を保ち、また反映する。 -/
theorem closedWalkTextIndex_lt_iff {m : ℕ} (r s : Fin (m + 1)) :
    (closedWalkTextIndex r).val < (closedWalkTextIndex s).val ↔ r < s := by
  change r.val + 1 < s.val + 1 ↔ r < s
  omega

theorem closedWalkTextIndex_le_iff {m : ℕ} (r s : Fin (m + 1)) :
    (closedWalkTextIndex r).val ≤ (closedWalkTextIndex s).val ↔ r ≤ s := by
  change r.val + 1 ≤ s.val + 1 ↔ r ≤ s
  omega

/-- `def_smoothing_index_blocks` の `A = {r ∈ I_{m+1} : k < r ≤ l}` を、添字の対応で引き戻したもの。 -/
def smoothingIndexBlockA {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : Set (Fin (m + 1)) :=
  {r | (closedWalkTextIndex k).val < (closedWalkTextIndex r).val ∧
    (closedWalkTextIndex r).val ≤ (closedWalkTextIndex l).val}

/-- `def_smoothing_index_blocks` の `B = I_{m+1} \ A` を、添字の対応で引き戻したもの。 -/
def smoothingIndexBlockB {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : Set (Fin (m + 1)) :=
  {r | r ∉ smoothingIndexBlockA γ hγ k l}

theorem smoothingIndexBlockB_membership {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockB γ hγ k l ↔ r ≤ k ∨ l < r := by
  change ¬ ((closedWalkTextIndex k).val < (closedWalkTextIndex r).val ∧
    (closedWalkTextIndex r).val ≤ (closedWalkTextIndex l).val) ↔ _
  rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]
  omega

/-- 二つの添字区間は辺列の全添字を分割する（各添字はちょうど一方に属する）。 -/
theorem smoothingIndexBlocks_partition {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l r : Fin (m + 1)) :
    (r ∈ smoothingIndexBlockA γ hγ k l ∧ r ∉ smoothingIndexBlockB γ hγ k l) ∨
      (r ∉ smoothingIndexBlockA γ hγ k l ∧ r ∈ smoothingIndexBlockB γ hγ k l) := by
  by_cases h : r ∈ smoothingIndexBlockA γ hγ k l
  · exact Or.inl ⟨h, fun hB => hB h⟩
  · exact Or.inr ⟨h, h⟩

theorem smoothingIndexBlocks_nonempty {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    {k l : Fin (m + 1)} (hkl : k < l) :
    l ∈ smoothingIndexBlockA γ hγ k l ∧ k ∈ smoothingIndexBlockB γ hγ k l := by
  constructor
  · exact ⟨(closedWalkTextIndex_lt_iff k l).2 hkl, le_refl _⟩
  · exact fun h => (lt_irrefl _) h.1

theorem smoothingIndexBlockA_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexBlockA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexBlockA k l := by
  ext r
  change ((closedWalkTextIndex k).val < (closedWalkTextIndex r).val ∧
    (closedWalkTextIndex r).val ≤ (closedWalkTextIndex l).val) ↔ (k < r ∧ r ≤ l)
  rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]

theorem smoothingIndexBlockB_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexBlockB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexBlockB k l := by
  ext r
  change r ∉ smoothingIndexBlockA γ hγ k l ↔
    r ∉ Ising2DLambda.NecSuf.KacWard.smoothingIndexBlockA k l
  rw [smoothingIndexBlockA_from_necSuf]

end Ising2DLambda.KacWard
