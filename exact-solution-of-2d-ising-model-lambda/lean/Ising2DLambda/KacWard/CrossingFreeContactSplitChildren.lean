/-
「横断のない閉歩道を接触点で分けても各子に横断は生じない」
（`claim_crossing_free_contact_split_children`）を、実際の閉じた非後退辺列
`γ : Fin (m + 1) → OrientedEdge L`（台の辺が相異なり、横断数が零）と接触対 `k < l` について述べる具体版。
本文の添字 `r ∈ I_{m+1}` は Lean の `r - 1`。

`claim_edge_simple_contact_split` の二本 `γ_A = (e_{k+1}, …, e_l)`、`γ_B = (e_{l+1}, …, e_m, e_1, …, e_k)` は、
平滑化の二本と同じ添字区間なので `smoothedSplitWalkA`・`smoothedSplitWalkB` で表す。
各位置の後続は、交換した二接続（`k` の出辺 `e_{σ(l)}`、`l` の出辺 `e_{σ(k)}`）を持つ `smoothedExitEdge` である
（`smoothedSplitWalkA_successor`・`smoothedSplitWalkB_successor`）。

人手証明との対応:
- `claim_edge_simple_contact_split` の「交換した接続は非後退」（始点は接触頂点の一致、反転なら台の辺が等しく
  `σ(l) = k` から `e_k = ι(e_k)` で矛盾）: `contactSwappedExit_mem_nonbacktrackingSuccessors`。
  これによる二本の閉性: `contactSplitWalkA_closed`・`contactSplitWalkB_closed`。
- 「一つの通過の入る半辺 `ι(e_r)` と出る半辺 `e_{σ(r)}` は異なる（非後退）」: `pass_halfEdges_ne`。
- 「異なる通過は半辺を共有しない（台の辺の相異性）」: `pass_shared_halfEdge_eq`。
- 「`v` を始点とする半辺は方向番号の四つ（`claim_vertex_port_bijection`）なので、`k` と `l` の四半辺で尽き、
  `v` の通過は `k` と `l` だけ」: `contact_vertex_passes`。
- 「子の添字集合は `v` の通過のうち一つだけを含むので、子は `v` で横断しない。他の頂点の通過は出辺が
  元と同じなので、子の横断は元の横断になり `c(γ) = 0` に反する」: `contact_split_child_crossing_free`
  （元の横断への読み替えは `contact_split_child_original_crossing`）。
- 合成: `crossing_free_contact_split_children`。
-/
import Ising2DLambda.KacWard.SmoothingSplitCrossingPartition
import Ising2DLambda.KacWard.EdgeDistinctCrossingStraightVisits

namespace Ising2DLambda.KacWard

open Finset
open Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

omit [NeZero L] in
/-- 接触対 `k, l` で `k` の出辺を `e_{σ(l)}` に付け替えた接続は非後退である。 -/
theorem contactSwappedExit_mem_nonbacktrackingSuccessors (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    γ (closedWalkSuccessor l) ∈ nonbacktrackingSuccessors (γ k) := by
  refine Finset.mem_filter.mpr ⟨Finset.mem_univ _,
    hcontact.trans (closedWalk_target_eq_source γ hγ l), fun hrev => ?_⟩
  exact incoming_outgoing_absurd γ hinj k (closedWalkSuccessor l) (γ (closedWalkSuccessor l))
    (by rw [hrev, reversal_involutive]) rfl

/-- `γ_A` は閉じた非後退辺列である（終辺 `e_l` から始辺 `e_{k+1}` へは交換した接続）。 -/
theorem contactSplitWalkA_closed (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    closedNonbacktrackingWalk (smoothedSplitWalkA γ hγ k l) := by
  apply closedWalkSegment_closed γ hγ
  have hk' : k.val < l.val := hkl
  have hk : (⟨k.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = k :=
    Fin.ext (Nat.mod_eq_of_lt k.isLt)
  have hsucc := closedWalkSuccessor_mod (m := m) k.val
  rw [hk] at hsucc
  have hlast : (⟨(k.val + 1 + (l.val - k.val - 1)) % (m + 1),
      Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = l := by
    apply Fin.ext
    simp only
    rw [show k.val + 1 + (l.val - k.val - 1) = l.val by omega]
    exact Nat.mod_eq_of_lt l.isLt
  rw [hlast, ← hsucc]
  exact contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj hcontact.symm

/-- `γ_B` は閉じた非後退辺列である（終辺 `e_k` から始辺 `e_{σ(l)}` へは交換した接続）。 -/
theorem contactSplitWalkB_closed (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    closedNonbacktrackingWalk (smoothedSplitWalkB γ hγ k l) := by
  apply closedWalkSegment_closed γ hγ
  have hk' : k.val < l.val := hkl
  have hl' := l.isLt
  have hl : (⟨l.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = l :=
    Fin.ext (Nat.mod_eq_of_lt l.isLt)
  have hsucc := closedWalkSuccessor_mod (m := m) l.val
  rw [hl] at hsucc
  have hlast : (⟨(l.val + 1 + (m - l.val + k.val)) % (m + 1),
      Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = k := by
    apply Fin.ext
    simp only
    rw [show l.val + 1 + (m - l.val + k.val) = (m + 1) + k.val by omega, Nat.add_mod_left]
    exact Nat.mod_eq_of_lt k.isLt
  rw [hlast, ← hsucc]
  exact contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj hcontact

/-- 一つの通過の入る半辺と出る半辺は異なる（非後退）。 -/
theorem pass_halfEdges_ne (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (r : Fin (m + 1)) :
    directionNumber (γ r) + 2 ≠ directionNumber (γ (closedWalkSuccessor r)) := by
  intro h
  have hin : γ r = reversal (halfEdgeOutgoing (orientedTarget (γ r)) (directionNumber (γ r) + 2)) :=
    (halfEdgeIncoming_iff (γ r) _ _).mp ⟨rfl, rfl⟩
  have hout : γ (closedWalkSuccessor r) =
      halfEdgeOutgoing (orientedTarget (γ r)) (directionNumber (γ r) + 2) :=
    (halfEdgeOutgoing_iff _ _ _).mp ⟨(closedWalk_target_eq_source γ hγ r).symm, h.symm⟩
  have hNB := (Finset.mem_filter.mp (closedWalkPass_valid γ hγ r)).2.2
  apply hNB
  change γ (closedWalkSuccessor r) = reversal (γ r)
  calc γ (closedWalkSuccessor r)
      = halfEdgeOutgoing (orientedTarget (γ r)) (directionNumber (γ r) + 2) := hout
    _ = reversal (reversal
          (halfEdgeOutgoing (orientedTarget (γ r)) (directionNumber (γ r) + 2))) :=
        (reversal_involutive _).symm
    _ = reversal (γ r) := congrArg reversal hin.symm

/-- 接触頂点 `v` の通過は `k` と `l` だけである。 -/
theorem contact_vertex_passes (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k ≠ l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l))
    (r : Fin (m + 1)) (hr : orientedTarget (γ r) = orientedTarget (γ k)) : r = k ∨ r = l := by
  have hcover : ∀ a b c e z : ZMod 4, a ≠ b → c ≠ e → a ≠ c → a ≠ e → b ≠ c → b ≠ e →
      z = a ∨ z = b ∨ z = c ∨ z = e := by
    decide
  have hsep : ∀ d, walkPassUsesHalfEdge γ k d → walkPassUsesHalfEdge γ l d → False :=
    fun d h1 h2 => hkl (pass_shared_halfEdge_eq γ hγ hinj k l d hcontact h1 h2)
  rcases hcover (directionNumber (γ k) + 2) (directionNumber (γ (closedWalkSuccessor k)))
      (directionNumber (γ l) + 2) (directionNumber (γ (closedWalkSuccessor l)))
      (directionNumber (γ r) + 2)
      (pass_halfEdges_ne γ hγ k) (pass_halfEdges_ne γ hγ l)
      (fun h => hsep _ (Or.inl rfl) (Or.inl h.symm))
      (fun h => hsep _ (Or.inl rfl) (Or.inr h.symm))
      (fun h => hsep _ (Or.inr rfl) (Or.inl h.symm))
      (fun h => hsep _ (Or.inr rfl) (Or.inr h.symm)) with h | h | h | h
  · exact Or.inl (pass_shared_halfEdge_eq γ hγ hinj r k _ hr (Or.inl rfl) (Or.inl h.symm))
  · exact Or.inl (pass_shared_halfEdge_eq γ hγ hinj r k _ hr (Or.inl rfl) (Or.inr h.symm))
  · exact Or.inr (pass_shared_halfEdge_eq γ hγ hinj r l _ (hr.trans hcontact) (Or.inl rfl)
      (Or.inl h.symm))
  · exact Or.inr (pass_shared_halfEdge_eq γ hγ hinj r l _ (hr.trans hcontact) (Or.inl rfl)
      (Or.inr h.symm))

omit [NeZero L] in
/-- 子の位置 `i, j` の横断で、像 `p i, p j` がどちらも `k, l` でなければ、出辺は元と同じなので元の横断である。 -/
theorem contact_split_child_original_crossing (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1))
    {n : ℕ} (δ : Fin (n + 1) → OrientedEdge L) (hδ : closedNonbacktrackingWalk δ)
    (p : Fin (n + 1) → Fin (m + 1)) (hp : Function.Injective p) (hpos : ∀ j, δ j = γ (p j))
    (hsucc : ∀ j, δ (closedWalkSuccessor j) = smoothedExitEdge γ k l (p j))
    {i j : Fin (n + 1)} (hc : indexPairCrossing δ hδ i j)
    (hik : p i ≠ k) (hil : p i ≠ l) (hjk : p j ≠ k) (hjl : p j ≠ l) :
    indexPairCrossing γ hγ (p i) (p j) := by
  have hexit : ∀ a, p a ≠ k → p a ≠ l →
      smoothedExitEdge γ k l (p a) = γ (closedWalkSuccessor (p a)) := by
    intro a h1 h2
    unfold smoothedExitEdge
    rw [if_neg h1, if_neg h2]
  have hcr := hc.2
  rw [hsucc i, hsucc j, hpos i, hpos j, hexit i hik hil, hexit j hjk hjl] at hcr
  exact ⟨fun h => hc.1 (hp h), hcr⟩

/-- 接触点分割の子の横断数は零である（子の添字の像は `k` と `l` を同時には含まない）。 -/
theorem contact_split_child_crossing_free (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k ≠ l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l))
    (hzero : closedWalkCrossingNumber γ hγ = 0)
    {n : ℕ} (δ : Fin (n + 1) → OrientedEdge L) (hδ : closedNonbacktrackingWalk δ)
    (p : Fin (n + 1) → Fin (m + 1)) (hp : Function.Injective p) (hpos : ∀ j, δ j = γ (p j))
    (hsucc : ∀ j, δ (closedWalkSuccessor j) = smoothedExitEdge γ k l (p j))
    (hnot : ∀ i j, p i = k → p j = l → False) :
    closedWalkCrossingNumber δ hδ = 0 := by
  classical
  unfold closedWalkCrossingNumber at hzero ⊢
  rw [card_eq_zero] at hzero ⊢
  apply eq_empty_of_forall_notMem
  rintro ⟨i, j⟩ hmem
  obtain ⟨-, -, hc⟩ := mem_filter.mp hmem
  have hvij : orientedTarget (γ (p i)) = orientedTarget (γ (p j)) := by
    rw [← hpos i, ← hpos j]
    exact hc.2.2.2.1
  have hpij : p i ≠ p j := fun h => hc.1 (hp h)
  -- 接触頂点 `v` の横断: 相手の通過も `v` にあり、二つの添字は `k`・`l` を一つずつ占める。
  have hat : ∀ a b, (p a = k ∨ p a = l) →
      orientedTarget (γ (p a)) = orientedTarget (γ (p b)) → p a ≠ p b → False := by
    intro a b ha hab hne
    have hb : orientedTarget (γ (p b)) = orientedTarget (γ k) := by
      rcases ha with h | h
      · rw [← hab, h]
      · rw [← hab, h, hcontact]
    rcases ha with ha | ha <;>
      rcases contact_vertex_passes γ hγ hinj hkl hcontact (p b) hb with hb' | hb'
    · exact hne (ha.trans hb'.symm)
    · exact hnot a b ha hb'
    · exact hnot b a hb' ha
    · exact hne (ha.trans hb'.symm)
  by_cases hi : p i = k ∨ p i = l
  · exact hat i j hi hvij hpij
  by_cases hj : p j = k ∨ p j = l
  · exact hat j i hj hvij.symm hpij.symm
  push Not at hi hj
  -- 他の頂点: 元の横断であり、`c(γ) = 0` に反する。
  have hcγ := contact_split_child_original_crossing γ hγ k l δ hδ p hp hpos hsucc hc
    hi.1 hi.2 hj.1 hj.2
  rcases lt_or_gt_of_ne hpij with hlt | hlt
  · exact eq_empty_iff_forall_notMem.mp hzero (p i, p j)
      (mem_filter.mpr ⟨mem_product.mpr ⟨mem_univ _, mem_univ _⟩, hlt, hcγ⟩)
  · exact eq_empty_iff_forall_notMem.mp hzero (p j, p i)
      (mem_filter.mpr ⟨mem_product.mpr ⟨mem_univ _, mem_univ _⟩, hlt, Ne.symm hcγ.1,
        hcγ.2.2.1, hcγ.2.1, hcγ.2.2.2.1.symm, hcγ.2.2.2.2.2.1, hcγ.2.2.2.2.1,
        Ne.symm hcγ.2.2.2.2.2.2⟩)

/-- `claim_crossing_free_contact_split_children`: `c(γ_A) = c(γ_B) = 0`。 -/
theorem crossing_free_contact_split_children (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    (hzero : closedWalkCrossingNumber γ hγ = 0)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
        (contactSplitWalkA_closed γ hγ hinj hkl hcontact) = 0 ∧
      closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
        (contactSplitWalkB_closed γ hγ hinj hkl hcontact) = 0 := by
  have hne : k ≠ l := ne_of_lt hkl
  refine ⟨contact_split_child_crossing_free γ hγ hinj hne hcontact hzero _ _
      (smoothedSplitIndexA k l) (smoothedSplitIndexA_injective hkl)
      (smoothedSplitWalkA_apply γ hγ k l) (smoothedSplitWalkA_successor γ hγ hkl) ?_,
    contact_split_child_crossing_free γ hγ hinj hne hcontact hzero _ _
      (smoothedSplitIndexB k l) (smoothedSplitIndexB_injective hkl)
      (smoothedSplitWalkB_apply γ hγ k l) (smoothedSplitWalkB_successor γ hγ hkl) ?_⟩
  · -- `k` は `γ_A` の添字区間 `(k, l]` に無い。
    intro i _ hi _
    have hmem := (smoothedSplitIndexA_range γ hγ hkl k).2 ⟨i, hi⟩
    exact lt_irrefl _ hmem.1
  · -- `l` は `γ_B` の添字区間（`(k, l]` の補集合）に無い。
    intro _ j _ hj
    have hmem := (smoothedSplitIndexB_range γ hγ hkl l).2 ⟨j, hj⟩
    apply hmem
    change (closedWalkTextIndex k).val < (closedWalkTextIndex l).val ∧
      (closedWalkTextIndex l).val ≤ (closedWalkTextIndex l).val
    rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]
    exact ⟨hkl, le_refl _⟩

end Ising2DLambda.KacWard
