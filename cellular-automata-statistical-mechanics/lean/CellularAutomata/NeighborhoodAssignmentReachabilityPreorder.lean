/-
章「到達前順序と相互到達成分」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-reachability-preorder.ts。

対応表（人手証明 → この file）
  def_neighborhood_reachability_preorder
    `Reaches`, `reaches_iff_mem_closure`
  claim_neighborhood_reachability_preorder_reflexive
    `reaches_refl`
  claim_neighborhood_reachability_preorder_transitive
    `reaches_trans`
  def_reachability_preorder_antisymmetry_counterexample
    `twoCellAssignment`, `twoCellAssignment_apply`
  claim_neighborhood_reachability_preorder_not_antisymmetric
    `twoCell_reaches_flip`, `reaches_not_antisymmetric`
  def_neighborhood_mutual_reachability
    `MutuallyReaches`
  claim_neighborhood_mutual_reachability_reflexive
    `mutuallyReaches_refl`
  claim_neighborhood_mutual_reachability_symmetric
    `mutuallyReaches_symm`
  claim_neighborhood_mutual_reachability_transitive
    `mutuallyReaches_trans`
  def_neighborhood_mutual_reachability_component
    `mutualComponent`
  claim_neighborhood_mutual_reachability_component_membership
    `mem_mutualComponent_iff`
  claim_neighborhood_mutual_reachability_component_self_transpose
    `mutualComponent_selfTranspose`
  claim_neighborhood_mutual_reachability_components_partition
    `self_mem_mutualComponent`, `mutualComponent_eq_of_inter_nonempty`
  claim_neighborhood_reachability_preorder_finite_decidable
    `instDecidableReaches`, `instDecidableMutuallyReaches`,
    `preorderScan`, `card_preorderScan`

比較回数のコストモデル自体は形式化していない。形式化しているのは、到達関係と
相互到達関係の成否および相互到達成分への所属が決定可能であること
（`instDecidableReaches`, `instDecidableMutuallyReaches`,
`instDecidableMemMutualComponent`）と、人手証明が数える走査の組の総数が
`(|V|²+1)·|V|³ + 3|V|²` であること（`card_preorderScan`）である。

住処: 有限型、有限部分集合、有限写像、自然数だけ。ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentReachabilityClosure
import CellularAutomata.NeighborhoodAssignmentTransposeInvolution

namespace CellularAutomata.NeighborhoodAssignmentReachabilityPreorder

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentIntersectionNondistributivity
open CellularAutomata.NeighborhoodAssignmentTransposeInvolution
open CellularAutomata.NeighborhoodAssignmentReachabilityClosure

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_neighborhood_reachability_preorder` の到達関係
    `v ⪯_N w :⟺ w ∈ N*(v)`。 -/
def Reaches (N : NeighborhoodAssignment V) (v w : V) : Prop :=
  w ∈ reachabilityClosure N v

/-- 到達関係は閉包への所属を一段展開したものである。 -/
theorem reaches_iff_mem_closure (N : NeighborhoodAssignment V) (v w : V) :
    Reaches N v w ↔ w ∈ reachabilityClosure N v := Iff.rfl

/-- `claim_neighborhood_reachability_preorder_reflexive`。
    人手証明どおり閉包の反射性だけを使う。 -/
theorem reaches_refl (N : NeighborhoodAssignment V) (v : V) : Reaches N v v :=
  reachabilityClosure_self_mem N v

/-- `claim_neighborhood_reachability_preorder_transitive`。
    人手証明どおり閉包の推移性だけを使う。 -/
theorem reaches_trans (N : NeighborhoodAssignment V) {v u w : V}
    (hvu : Reaches N v u) (huw : Reaches N u w) : Reaches N v w :=
  reachabilityClosure_isTransitive N v u w hvu huw

/-- `def_reachability_preorder_antisymmetry_counterexample` の二元舞台
    `V₂ = {v₀, v₁}` と `N₂(v₀) = {v₁}`, `N₂(v₁) = {v₀}`。
    二元舞台は `Bool` で表し、`v₀ = false`, `v₁ = true` とする。 -/
def twoCellAssignment : NeighborhoodAssignment Bool := fun v => {!v}

@[simp] theorem twoCellAssignment_apply (v : Bool) :
    twoCellAssignment v = {!v} := rfl

/-- 二元舞台では、各元が相手の元へ到達する。
    人手証明の三行（明示表 → もとの割り当ての包含 → 到達関係の定義）に対応する。 -/
theorem twoCell_reaches_flip (v : Bool) : Reaches twoCellAssignment v (!v) := by
  have hMem : (!v) ∈ twoCellAssignment v := by simp
  exact reachabilityClosure_contains_original twoCellAssignment v hMem

/-- `claim_neighborhood_reachability_preorder_not_antisymmetric`。
    相異なる二元が互いに到達し合うので、到達関係は一般に反対称ではない。 -/
theorem reaches_not_antisymmetric :
    ¬ ∀ (N : NeighborhoodAssignment Bool) (v w : Bool),
        Reaches N v w → Reaches N w v → v = w := by
  intro hAll
  have h₀₁ : Reaches twoCellAssignment false true := by
    simpa using twoCell_reaches_flip false
  have h₁₀ : Reaches twoCellAssignment true false := by
    simpa using twoCell_reaches_flip true
  have : (false : Bool) = true := hAll twoCellAssignment false true h₀₁ h₁₀
  exact Bool.noConfusion this

/-- `def_neighborhood_mutual_reachability` の相互到達関係
    `v ≈_N w :⟺ (v ⪯_N w かつ w ⪯_N v)`。 -/
def MutuallyReaches (N : NeighborhoodAssignment V) (v w : V) : Prop :=
  Reaches N v w ∧ Reaches N w v

/-- `claim_neighborhood_mutual_reachability_reflexive`。 -/
theorem mutuallyReaches_refl (N : NeighborhoodAssignment V) (v : V) :
    MutuallyReaches N v v := ⟨reaches_refl N v, reaches_refl N v⟩

/-- `claim_neighborhood_mutual_reachability_symmetric`。
    二つの条件を入れ替えるだけである。 -/
theorem mutuallyReaches_symm (N : NeighborhoodAssignment V) {v w : V}
    (h : MutuallyReaches N v w) : MutuallyReaches N w v := ⟨h.2, h.1⟩

/-- `claim_neighborhood_mutual_reachability_transitive`。
    到達関係の推移性を二回、人手証明と同じ向きで使う。 -/
theorem mutuallyReaches_trans (N : NeighborhoodAssignment V) {v u w : V}
    (hvu : MutuallyReaches N v u) (huw : MutuallyReaches N u w) :
    MutuallyReaches N v w :=
  ⟨reaches_trans N hvu.1 huw.1, reaches_trans N huw.2 hvu.2⟩

/-- `def_neighborhood_mutual_reachability_component` の相互到達成分割り当て
    `C_N = N* ⊓ (N*)ᵀ`。 -/
def mutualComponent (N : NeighborhoodAssignment V) : NeighborhoodAssignment V :=
  pointwiseIntersection (reachabilityClosure N) (transpose (reachabilityClosure N))

/-- `claim_neighborhood_mutual_reachability_component_membership`。
    点ごとの積の定義と転置の所属条件を、人手証明と同じ順で使う。 -/
theorem mem_mutualComponent_iff (N : NeighborhoodAssignment V) (v w : V) :
    w ∈ mutualComponent N v ↔ MutuallyReaches N v w := by
  constructor
  · intro hw
    have hInter : w ∈ reachabilityClosure N v ∩ transpose (reachabilityClosure N) v := hw
    have hLeft : w ∈ reachabilityClosure N v := Finset.mem_of_mem_inter_left hInter
    have hRight : w ∈ transpose (reachabilityClosure N) v :=
      Finset.mem_of_mem_inter_right hInter
    have hBack : v ∈ reachabilityClosure N w :=
      (mem_transpose (reachabilityClosure N) w v).mp hRight
    exact ⟨hLeft, hBack⟩
  · rintro ⟨hFwd, hBack⟩
    have hRight : w ∈ transpose (reachabilityClosure N) v :=
      (mem_transpose (reachabilityClosure N) w v).mpr hBack
    exact Finset.mem_inter.mpr ⟨hFwd, hRight⟩

/-- `claim_neighborhood_mutual_reachability_component_self_transpose`。
    転置が点ごとの積を保つこと、対合であること、点ごとの積の可換律を
    人手証明と同じ順で使う。 -/
theorem mutualComponent_selfTranspose (N : NeighborhoodAssignment V) :
    transpose (mutualComponent N) = mutualComponent N := by
  calc transpose (mutualComponent N)
      = transpose (pointwiseIntersection (reachabilityClosure N)
          (transpose (reachabilityClosure N))) := rfl
    _ = pointwiseIntersection (transpose (reachabilityClosure N))
          (transpose (transpose (reachabilityClosure N))) :=
        transpose_pointwiseIntersection _ _
    _ = pointwiseIntersection (transpose (reachabilityClosure N))
          (reachabilityClosure N) := by rw [transpose_transpose]
    _ = pointwiseIntersection (reachabilityClosure N)
          (transpose (reachabilityClosure N)) := pointwiseIntersection_comm _ _
    _ = mutualComponent N := rfl

/-- `claim_neighborhood_mutual_reachability_components_partition` の後半（被覆）。 -/
theorem self_mem_mutualComponent (N : NeighborhoodAssignment V) (v : V) :
    v ∈ mutualComponent N v :=
  (mem_mutualComponent_iff N v v).mpr (mutuallyReaches_refl N v)

/-- `claim_neighborhood_mutual_reachability_components_partition` の前半の片側包含。 -/
theorem mutualComponent_subset_of_mem (N : NeighborhoodAssignment V) {v u r : V}
    (hv : r ∈ mutualComponent N v) (hu : r ∈ mutualComponent N u) :
    mutualComponent N v ⊆ mutualComponent N u := by
  have hvr : MutuallyReaches N v r := (mem_mutualComponent_iff N v r).mp hv
  have hur : MutuallyReaches N u r := (mem_mutualComponent_iff N u r).mp hu
  intro w hw
  have hvw : MutuallyReaches N v w := (mem_mutualComponent_iff N v w).mp hw
  have hrw : MutuallyReaches N r w :=
    mutuallyReaches_trans N (mutuallyReaches_symm N hvr) hvw
  have huw : MutuallyReaches N u w := mutuallyReaches_trans N hur hrw
  exact (mem_mutualComponent_iff N u w).mpr huw

/-- `claim_neighborhood_mutual_reachability_components_partition` の前半。
    共通の元を取り、両向きの包含を同じ論証で得る。 -/
theorem mutualComponent_eq_of_inter_nonempty (N : NeighborhoodAssignment V) {v u : V}
    (h : (mutualComponent N v ∩ mutualComponent N u).Nonempty) :
    mutualComponent N v = mutualComponent N u := by
  obtain ⟨r, hr⟩ := h
  have hv : r ∈ mutualComponent N v := Finset.mem_of_mem_inter_left hr
  have hu : r ∈ mutualComponent N u := Finset.mem_of_mem_inter_right hr
  exact Finset.Subset.antisymm
    (mutualComponent_subset_of_mem N hv hu)
    (mutualComponent_subset_of_mem N hu hv)

/-- 到達関係の成否は有限手続きで決まる。 -/
instance instDecidableReaches (N : NeighborhoodAssignment V) (v w : V) :
    Decidable (Reaches N v w) := by
  unfold Reaches
  infer_instance

/-- 相互到達関係の成否は有限手続きで決まる。 -/
instance instDecidableMutuallyReaches (N : NeighborhoodAssignment V) (v w : V) :
    Decidable (MutuallyReaches N v w) := by
  unfold MutuallyReaches
  infer_instance

/-- 相互到達成分への所属は有限手続きで決まる。 -/
instance instDecidableMemMutualComponent (N : NeighborhoodAssignment V) (v w : V) :
    Decidable (w ∈ mutualComponent N v) := by
  unfold mutualComponent
  infer_instance

/-- 人手証明が数える走査の組。閉包表の走査に、到達関係の組 `(v,w)` と、
    成分表を書き下すための二回の所属判定（`Bool` で区別する）を継ぎ足す。 -/
def preorderScan : Finset ((ℕ × V × V × V) ⊕ ((V × V) ⊕ (Bool × V × V))) :=
  (closureScan (V := V)).disjSum (Finset.univ.disjSum Finset.univ)

omit [DecidableEq V] in
/-- 走査する組の総数は `(|V|²+1)·|V|³ + 3|V|²` である。 -/
theorem card_preorderScan :
    (preorderScan (V := V)).card
      = (Fintype.card V ^ 2 + 1) * Fintype.card V ^ 3 + 3 * Fintype.card V ^ 2 := by
  rw [preorderScan, Finset.card_disjSum, Finset.card_disjSum, card_closureScan]
  simp [Finset.card_univ, pow_two]
  ring

end CellularAutomata.NeighborhoodAssignmentReachabilityPreorder
