/-
章「有限半順序の被覆関係と被覆近傍割り当てによる生成」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-covering-relation-of-finite-poset.ts。

対応表（人手証明 → この file）
  def_finite_poset_interval
    `interval`, `mem_interval`
  claim_finite_poset_interval_endpoints
    `interval_endpoints`
  def_finite_poset_covering_relation
    `Covering`
  def_covering_neighborhood_assignment
    `coveringAssignment`, `mem_coveringAssignment`
  claim_covering_neighborhood_assignment_included
    `coveringAssignment_included`
  claim_finite_poset_interval_strictly_smaller
    `interval_left_card_lt`, `interval_right_card_lt`
  claim_covering_neighborhood_assignment_generates
    `coveringAssignment_generates`
  claim_covering_neighborhood_assignment_closure_eq
    `coveringAssignment_closure_eq`
  claim_covering_neighborhood_assignment_reachability_eq
    `reaches_coveringAssignment_iff`
  claim_finite_poset_covering_relation_finite_decidable
    `instDecidableCovering`, `coveringPairScan`, `card_coveringPairScan`

比較回数のコストモデル自体は形式化していない。形式化しているのは被覆関係への所属が
決定可能であることと、人手証明が外側で走査する組が `|V|²` 個であることである。

有限型、有限部分集合、有限関係、自然数だけを使う。ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets

namespace CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentReachabilityClosure
open CellularAutomata.NeighborhoodAssignmentReachabilityPreorder
open CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets
open CellularAutomata.OrderedNeighborhoodAssignmentMonoid

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_finite_poset_interval` の区間。 -/
def interval (R : V → V → Prop) [DecidableRel R] (v w : V) : Finset V :=
  Finset.univ.filter fun u => R v u ∧ R u w

omit [DecidableEq V] in
@[simp] theorem mem_interval (R : V → V → Prop) [DecidableRel R] (v w u : V) :
    u ∈ interval R v w ↔ R v u ∧ R u w := by
  simp [interval]

omit [DecidableEq V] in
/-- `claim_finite_poset_interval_endpoints`。 -/
theorem interval_endpoints (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) {v w : V} (hvw : R v w) :
    v ∈ interval R v w ∧ w ∈ interval R v w := by
  constructor
  · exact (mem_interval R v w v).mpr ⟨hR.1 v, hvw⟩
  · exact (mem_interval R v w w).mpr ⟨hvw, hR.1 w⟩

/-- `def_finite_poset_covering_relation` の被覆関係。 -/
def Covering (R : V → V → Prop) [DecidableRel R] (v w : V) : Prop :=
  R v w ∧ v ≠ w ∧ interval R v w = {v, w}

instance instDecidableCovering (R : V → V → Prop) [DecidableRel R] (v w : V) :
    Decidable (Covering R v w) := by
  unfold Covering
  infer_instance

/-- `def_covering_neighborhood_assignment` の被覆近傍割り当て。 -/
def coveringAssignment (R : V → V → Prop) [DecidableRel R] : NeighborhoodAssignment V :=
  fun v => Finset.univ.filter fun w => Covering R v w

@[simp] theorem mem_coveringAssignment (R : V → V → Prop) [DecidableRel R] (v w : V) :
    w ∈ coveringAssignment R v ↔ Covering R v w := by
  simp [coveringAssignment]

/-- `claim_covering_neighborhood_assignment_included`。 -/
theorem coveringAssignment_included (R : V → V → Prop) [DecidableRel R] :
    PointwiseInclusion (coveringAssignment R) (assignmentOfRelation R) := by
  intro v w hw
  have hCover : Covering R v w := (mem_coveringAssignment R v w).mp hw
  exact (mem_assignmentOfRelation R v w).mpr hCover.1

omit [DecidableEq V] in
/-- `claim_finite_poset_interval_strictly_smaller` の左側。 -/
theorem interval_left_card_lt (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) {v w u : V} (hu : u ∈ interval R v w)
    (_huv : u ≠ v) (huw : u ≠ w) :
    (interval R v u).card < (interval R v w).card := by
  have hvu : R v u := (mem_interval R v w u).mp hu |>.1
  have huwR : R u w := (mem_interval R v w u).mp hu |>.2
  have hSub : interval R v u ⊆ interval R v w := by
    intro x hx
    have hx' := (mem_interval R v u x).mp hx
    exact (mem_interval R v w x).mpr ⟨hx'.1, hR.2.2 x u w hx'.2 huwR⟩
  have hwBig : w ∈ interval R v w := (interval_endpoints R hR (hR.2.2 v u w hvu huwR)).2
  have hwSmall : w ∉ interval R v u := by
    intro hw
    have hwu : R w u := (mem_interval R v u w).mp hw |>.2
    exact huw (hR.2.1 u w huwR hwu)
  have hNe : interval R v u ≠ interval R v w := by
    intro hEq
    apply hwSmall
    rw [hEq]
    exact hwBig
  exact Finset.card_lt_card (Finset.ssubset_iff_subset_ne.mpr ⟨hSub, hNe⟩)

omit [DecidableEq V] in
/-- `claim_finite_poset_interval_strictly_smaller` の右側。 -/
theorem interval_right_card_lt (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) {v w u : V} (hu : u ∈ interval R v w)
    (huv : u ≠ v) (_huw : u ≠ w) :
    (interval R u w).card < (interval R v w).card := by
  have hvu : R v u := (mem_interval R v w u).mp hu |>.1
  have huwR : R u w := (mem_interval R v w u).mp hu |>.2
  have hSub : interval R u w ⊆ interval R v w := by
    intro x hx
    have hx' := (mem_interval R u w x).mp hx
    exact (mem_interval R v w x).mpr ⟨hR.2.2 v u x hvu hx'.1, hx'.2⟩
  have hvBig : v ∈ interval R v w := (interval_endpoints R hR (hR.2.2 v u w hvu huwR)).1
  have hvSmall : v ∉ interval R u w := by
    intro hv
    have huvR : R u v := (mem_interval R u w v).mp hv |>.1
    exact huv (hR.2.1 u v huvR hvu)
  have hNe : interval R u w ≠ interval R v w := by
    intro hEq
    apply hvSmall
    rw [hEq]
    exact hvBig
  exact Finset.card_lt_card (Finset.ssubset_iff_subset_ne.mpr ⟨hSub, hNe⟩)

/-- `claim_covering_neighborhood_assignment_generates`。
    区間の元数についての強い帰納法を、人手証明と同じ三場合に分けて行う。 -/
theorem coveringAssignment_generates (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) {v w : V} (hvw : R v w) :
    w ∈ reachabilityClosure (coveringAssignment R) v := by
  have aux : ∀ n : ℕ, ∀ v w : V, (interval R v w).card = n → R v w →
      w ∈ reachabilityClosure (coveringAssignment R) v := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      intro v w hCardEq hvw
      by_cases hEq : v = w
      · simpa [hEq] using reachabilityClosure_self_mem (coveringAssignment R) v
      by_cases hInt : interval R v w = {v, w}
      · have hCover : Covering R v w := ⟨hvw, hEq, hInt⟩
        exact reachabilityClosure_contains_original (coveringAssignment R) v
          ((mem_coveringAssignment R v w).mpr hCover)
      · have hPairSub : ({v, w} : Finset V) ⊆ interval R v w := by
          intro x hx
          simp only [Finset.mem_insert, Finset.mem_singleton] at hx
          rcases hx with rfl | rfl
          · exact (interval_endpoints R hR hvw).1
          · exact (interval_endpoints R hR hvw).2
        have hProper : ({v, w} : Finset V) ⊂ interval R v w :=
          Finset.ssubset_iff_subset_ne.mpr ⟨hPairSub, Ne.symm hInt⟩
        have hCard : ({v, w} : Finset V).card < (interval R v w).card :=
          Finset.card_lt_card hProper
        obtain ⟨u, hu, huPair⟩ := Finset.exists_mem_notMem_of_card_lt_card hCard
        have huv : u ≠ v := by
          intro huv
          subst huv
          exact huPair (by simp)
        have huw : u ≠ w := by
          intro huw
          subst huw
          exact huPair (by simp)
        have huRel := (mem_interval R v w u).mp hu
        have hLeftLt : (interval R v u).card < n := by
          rw [← hCardEq]
          exact interval_left_card_lt R hR hu huv huw
        have hRightLt : (interval R u w).card < n := by
          rw [← hCardEq]
          exact interval_right_card_lt R hR hu huv huw
        have hLeft : u ∈ reachabilityClosure (coveringAssignment R) v :=
          ih (interval R v u).card hLeftLt v u rfl huRel.1
        have hRight : w ∈ reachabilityClosure (coveringAssignment R) u :=
          ih (interval R u w).card hRightLt u w rfl huRel.2
        exact reachabilityClosure_isTransitive (coveringAssignment R) v u w hLeft hRight
  exact aux (interval R v w).card v w rfl hvw

/-- `claim_covering_neighborhood_assignment_closure_eq`。 -/
theorem coveringAssignment_closure_eq (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) :
    reachabilityClosure (coveringAssignment R) = assignmentOfRelation R := by
  have hForward : PointwiseInclusion (reachabilityClosure (coveringAssignment R))
      (assignmentOfRelation R) :=
    reachabilityClosure_minimal (coveringAssignment R) (assignmentOfRelation R)
      (assignmentOfRelation_self_mem R hR) (assignmentOfRelation_isTransitive R hR)
      (coveringAssignment_included R)
  have hBackward : PointwiseInclusion (assignmentOfRelation R)
      (reachabilityClosure (coveringAssignment R)) := by
    intro v w hw
    exact coveringAssignment_generates R hR ((mem_assignmentOfRelation R v w).mp hw)
  exact pointwiseInclusion_antisymm hForward hBackward

/-- `claim_covering_neighborhood_assignment_reachability_eq`。 -/
theorem reaches_coveringAssignment_iff (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) (v w : V) :
    Reaches (coveringAssignment R) v w ↔ R v w := by
  calc Reaches (coveringAssignment R) v w
      ↔ w ∈ reachabilityClosure (coveringAssignment R) v :=
        reaches_iff_mem_closure (coveringAssignment R) v w
    _ ↔ w ∈ assignmentOfRelation R v := by rw [coveringAssignment_closure_eq R hR]
    _ ↔ R v w := mem_assignmentOfRelation R v w

/-- 被覆関係を構成するために走査する全ての組。 -/
def coveringPairScan : Finset (V × V) := Finset.univ

omit [DecidableEq V] in
/-- `claim_finite_poset_covering_relation_finite_decidable` の外側の走査は `|V|²` 組である。 -/
theorem card_coveringPairScan :
    (coveringPairScan (V := V)).card = Fintype.card V ^ 2 := by
  simp [coveringPairScan, pow_two]

end CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset
