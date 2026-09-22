/-
章「有限半順序の被覆関係と被覆近傍割り当てによる生成」の Lean 必要十分版。

必要な構造の検査結果:
  - 被覆辺が関係を生成する証明に要るのは、非被覆な比較可能対を二つの真に小さい対へ
    分ける自然数値尺度だけである。
  - 被覆辺の反射推移閉包が元の関係に一致する証明で追加されるのは、関係の反射性と
    推移性だけである。反対称性は要らない。
  - 台の有限性、等号判定、有限区間、有限表現は要らない。
  - 有限性と等号判定は、具体版で区間の元数を尺度として構成し、被覆関係を有限表にして
    全ての組を走査する段だけで要る。
  - 状態集合、局所規則、時間、物理的意味、ℝ / ℂ は使わない。
-/
import CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset
import CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure

namespace CellularAutomata.NecSuf.NeighborhoodCoveringRelationOfFinitePoset

open CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure

/-- 台の全体上の関係について、閉包等式で使う反射性と推移性だけを書く。 -/
def IsPreorderOnUniv {V : Type} (R : V → V → Prop) : Prop :=
  (∀ v : V, R v v) ∧
    (∀ v u w : V, R v u → R u w → R v w)

/-- 比較可能な相異なる二点の間に中間点が無いこととして被覆を定める。 -/
def Covering {V : Type} (R : V → V → Prop) (v w : V) : Prop :=
  R v w ∧ v ≠ w ∧ ∀ u : V, R v u → R u w → u = v ∨ u = w

/-- 被覆辺だけを持つ集合値割り当て。 -/
def coveringAssignment {V : Type} (R : V → V → Prop) : V → Set V :=
  fun v => {w | Covering R v w}

/-- 元の関係を集合値割り当てとして読む。 -/
def assignmentOfRelation {V : Type} (R : V → V → Prop) : V → Set V :=
  fun v => {w | R v w}

/-- 非被覆な比較可能対を、自然数値尺度が真に小さい二対へ分解できるという仮定。 -/
def HasDescendingInteriorMeasure {V : Type} (R : V → V → Prop)
    (measure : V → V → ℕ) : Prop :=
  ∀ v w : V, R v w → v ≠ w → ¬ Covering R v w →
    ∃ u : V, R v u ∧ R u w ∧ u ≠ v ∧ u ≠ w ∧
      measure v u < measure v w ∧ measure u w < measure v w

theorem coveringAssignment_included {V : Type} (R : V → V → Prop) :
    ∀ v w : V, w ∈ coveringAssignment R v → w ∈ assignmentOfRelation R v := by
  intro v w hw
  exact hw.1

/-- 整礎な自然数値尺度についての強い帰納法で、被覆辺が全比較対を生成する。 -/
theorem coveringAssignment_generates {V : Type} (R : V → V → Prop)
    (measure : V → V → ℕ) (hMeasure : HasDescendingInteriorMeasure R measure)
    {v w : V} (hvw : R v w) :
    w ∈ setReachabilityClosure (coveringAssignment R) v := by
  have aux : ∀ n : ℕ, ∀ v w : V, measure v w = n → R v w →
      w ∈ setReachabilityClosure (coveringAssignment R) v := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      intro v w hMeasureEq hvw
      by_cases hEq : v = w
      · simpa [hEq] using setReachabilityClosure_self_mem (coveringAssignment R) v
      by_cases hCover : Covering R v w
      · exact setReachabilityClosure_contains_original (coveringAssignment R) v w hCover
      · obtain ⟨u, hvu, huw, _huv, _huw, hLeftLt, hRightLt⟩ :=
          hMeasure v w hvw hEq hCover
        have hLeft : u ∈ setReachabilityClosure (coveringAssignment R) v :=
          ih (measure v u) (by simpa [hMeasureEq] using hLeftLt) v u rfl hvu
        have hRight : w ∈ setReachabilityClosure (coveringAssignment R) u :=
          ih (measure u w) (by simpa [hMeasureEq] using hRightLt) u w rfl huw
        exact setReachabilityClosure_transitive (coveringAssignment R) v u w hLeft hRight
  exact aux (measure v w) v w rfl hvw

/-- 被覆辺の反射推移閉包は元の反射・推移的な関係に一致する。 -/
theorem coveringAssignment_closure_eq {V : Type} (R : V → V → Prop)
    (measure : V → V → ℕ) (hR : IsPreorderOnUniv R)
    (hMeasure : HasDescendingInteriorMeasure R measure) :
    setReachabilityClosure (coveringAssignment R) = assignmentOfRelation R := by
  funext v
  ext w
  constructor
  · exact setReachabilityClosure_minimal (coveringAssignment R) (assignmentOfRelation R)
      hR.1 hR.2 (coveringAssignment_included R) v w
  · exact coveringAssignment_generates R measure hMeasure

namespace Derivation

open CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset
open CellularAutomata.NeighborhoodAssignmentReachabilityClosure
open CellularAutomata.NeighborhoodAssignmentReachabilityPreorder
open CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets
open CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure.Derivation

variable {V : Type} [Fintype V] [DecidableEq V]

theorem covering_iff (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R)
    (v w : V) :
    Covering R v w ↔ CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.Covering R v w := by
  constructor
  · rintro ⟨hvw, hne, hNoMiddle⟩
    refine ⟨hvw, hne, Finset.Subset.antisymm ?_ ?_⟩
    · intro u hu
      rcases hNoMiddle u ((mem_interval R v w u).mp hu).1 ((mem_interval R v w u).mp hu).2 with rfl | rfl <;> simp
    · intro u hu
      simp only [Finset.mem_insert, Finset.mem_singleton] at hu
      rcases hu with rfl | rfl
      · exact (interval_endpoints R hR hvw).1
      · exact (interval_endpoints R hR hvw).2
  · rintro ⟨hvw, hne, hInterval⟩
    refine ⟨hvw, hne, ?_⟩
    intro u hvu huw
    have hu : u ∈ interval R v w := (mem_interval R v w u).mpr ⟨hvu, huw⟩
    rw [hInterval] at hu
    simpa using hu

theorem coe_coveringAssignment (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R) :
    (fun v => ((CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.coveringAssignment R v :
      Finset V) : Set V)) = coveringAssignment R := by
  funext v
  ext w
  change (w ∈ CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.coveringAssignment R v) ↔
    Covering R v w
  rw [CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.mem_coveringAssignment]
  exact (covering_iff R hR v w).symm

theorem coe_assignmentOfRelation (R : V → V → Prop) [DecidableRel R] :
    (fun v => ((CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation R v :
      Finset V) : Set V)) = assignmentOfRelation R := by
  funext v
  ext w
  simp [CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation,
    assignmentOfRelation]

def intervalMeasure (R : V → V → Prop) [DecidableRel R] (v w : V) : ℕ :=
  (interval R v w).card

theorem intervalMeasure_descends (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R) :
    HasDescendingInteriorMeasure R (intervalMeasure R) := by
  intro v w hvw hne hNotCover
  have hNotConcrete : ¬ CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.Covering R v w := by
    intro h
    exact hNotCover ((covering_iff R hR v w).mpr h)
  have hIntervalNe : interval R v w ≠ {v, w} := fun h => hNotConcrete ⟨hvw, hne, h⟩
  have hPairSub : ({v, w} : Finset V) ⊆ interval R v w := by
    intro x hx
    simp only [Finset.mem_insert, Finset.mem_singleton] at hx
    rcases hx with rfl | rfl
    · exact (interval_endpoints R hR hvw).1
    · exact (interval_endpoints R hR hvw).2
  have hProper : ({v, w} : Finset V) ⊂ interval R v w :=
    Finset.ssubset_iff_subset_ne.mpr ⟨hPairSub, Ne.symm hIntervalNe⟩
  obtain ⟨u, hu, huPair⟩ := Finset.exists_mem_notMem_of_card_lt_card (Finset.card_lt_card hProper)
  have huv : u ≠ v := fun huv => huPair (huv.symm ▸ by simp)
  have huw : u ≠ w := fun huw => huPair (huw.symm ▸ by simp)
  have huRel := (mem_interval R v w u).mp hu
  exact ⟨u, huRel.1, huRel.2, huv, huw,
    interval_left_card_lt R hR hu huv huw, interval_right_card_lt R hR hu huv huw⟩

/-- 具体版の生成定理は必要十分版の特殊化である。 -/
theorem coveringAssignment_generates_of_necSuf (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R)
    {v w : V} (hvw : R v w) :
    w ∈ reachabilityClosure
      (CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.coveringAssignment R) v := by
  have hGeneral := coveringAssignment_generates R (intervalMeasure R)
    (intervalMeasure_descends R hR) hvw
  rw [← coe_coveringAssignment R hR] at hGeneral
  rw [← coe_reachabilityClosure
    (CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.coveringAssignment R)] at hGeneral
  exact hGeneral

/-- 具体版の閉包等式は必要十分版の特殊化である。 -/
theorem coveringAssignment_closure_eq_of_necSuf (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R) :
    reachabilityClosure
      (CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.coveringAssignment R) =
      CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation R := by
  funext v
  apply Finset.ext
  intro w
  have hGeneral := congrArg (fun N : V → Set V => w ∈ N v)
    (coveringAssignment_closure_eq R (intervalMeasure R) ⟨hR.1, hR.2.2⟩
      (intervalMeasure_descends R hR))
  rw [← coe_coveringAssignment R hR] at hGeneral
  rw [← coe_reachabilityClosure
    (CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.coveringAssignment R)] at hGeneral
  rw [← coe_assignmentOfRelation R] at hGeneral
  exact Iff.of_eq hGeneral

/-- 具体版の到達関係の特徴づけは必要十分版の閉包等式から従う。 -/
theorem reaches_coveringAssignment_iff_of_necSuf
    (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R)
    (v w : V) :
    Reaches (CellularAutomata.NeighborhoodCoveringRelationOfFinitePoset.coveringAssignment R) v w ↔ R v w := by
  rw [reaches_iff_mem_closure, coveringAssignment_closure_eq_of_necSuf R hR,
    mem_assignmentOfRelation]

end Derivation

end CellularAutomata.NecSuf.NeighborhoodCoveringRelationOfFinitePoset
