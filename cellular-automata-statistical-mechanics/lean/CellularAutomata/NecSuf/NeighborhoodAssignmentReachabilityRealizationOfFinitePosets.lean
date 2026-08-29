/-
章「有限半順序の相互到達成分商としての実現」の Lean 必要十分版。

必要な構造の検査結果:
  - 一元成分、成分集合への実現写像の全単射性、商上の関係と元の関係の一致には、
    台上の二項関係と、その反射性・反対称性・推移性だけが要る。
  - 台の有限性も等号判定も要らない。有限性と等号判定が要るのは、具体版で関係を
    `Finset` 値の近傍割り当てとして列挙し、個数と有限走査を述べる段だけである。
  - 状態集合、局所規則、時間、既製の順序型クラス、ℝ / ℂ は使わない。
-/
import CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets
import CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityQuotientOrder

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets

open CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder
open CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityQuotientOrder

/-- 台の全体上の部分順序を、実際に使う三条件だけで書く。 -/
def IsPartialOrderOnUniv {V : Type} (R : V → V → Prop) : Prop :=
  (∀ v : V, R v v) ∧
    (∀ v w : V, R v w → R w v → v = w) ∧
    (∀ v u w : V, R v u → R u w → R v w)

/-- 部分順序関係を集合値の近傍割り当てとして読む。 -/
def assignmentOfRelation {V : Type} (R : V → V → Prop) : V → Set V :=
  fun v => {w | R v w}

theorem mem_assignmentOfRelation {V : Type} (R : V → V → Prop) (v w : V) :
    w ∈ assignmentOfRelation R v ↔ R v w := Iff.rfl

theorem assignmentOfRelation_self_mem {V : Type} {R : V → V → Prop}
    (hR : IsPartialOrderOnUniv R) (v : V) : v ∈ assignmentOfRelation R v :=
  hR.1 v

theorem assignmentOfRelation_isTransitive {V : Type} {R : V → V → Prop}
    (hR : IsPartialOrderOnUniv R) :
    ∀ v u w : V, u ∈ assignmentOfRelation R v →
      w ∈ assignmentOfRelation R u → w ∈ assignmentOfRelation R v :=
  hR.2.2

/-- 反対称性により、部分順序関係の相互到達成分は一元集合になる。 -/
theorem mutualComponent_assignmentOfRelation {V : Type} {R : V → V → Prop}
    (hR : IsPartialOrderOnUniv R) (v : V) :
    mutualComponent R v = ({v} : Set V) := by
  ext w
  constructor
  · intro hw
    exact hR.2.1 v w hw.1 hw.2 ▸ Set.mem_singleton v
  · intro hw
    have hEq : w = v := Set.mem_singleton_iff.mp hw
    subst w
    exact ⟨hR.1 v, hR.1 v⟩

/-- 商は一元集合の像に一致する。 -/
theorem componentSet_assignmentOfRelation {V : Type} {R : V → V → Prop}
    (hR : IsPartialOrderOnUniv R) :
    componentSet R = Set.range (fun v : V => ({v} : Set V)) := by
  ext Q
  constructor
  · rintro ⟨v, rfl⟩
    exact ⟨v, (mutualComponent_assignmentOfRelation hR v).symm⟩
  · rintro ⟨v, rfl⟩
    exact ⟨v, mutualComponent_assignmentOfRelation hR v⟩

/-- 元の台から相互到達成分の商への実現写像。 -/
def realizationMap {V : Type} (v : V) : Set V := {v}

theorem realizationMap_mem_componentSet {V : Type} {R : V → V → Prop}
    (hR : IsPartialOrderOnUniv R) (v : V) :
    realizationMap v ∈ componentSet R := by
  rw [componentSet_assignmentOfRelation hR]
  exact ⟨v, rfl⟩

theorem realizationMap_injective {V : Type} :
    Function.Injective (realizationMap (V := V)) := by
  intro v w hvw
  have hv : v ∈ realizationMap v := Set.mem_singleton v
  rw [hvw] at hv
  exact Set.mem_singleton_iff.mp hv

theorem realizationMap_surjective_onto_componentSet {V : Type} {R : V → V → Prop}
    (hR : IsPartialOrderOnUniv R) {Q : Set V} (hQ : Q ∈ componentSet R) :
    ∃ v : V, realizationMap v = Q := by
  rw [componentSet_assignmentOfRelation hR] at hQ
  exact hQ

/-- 実現写像は元の部分順序を商上の到達関係へ両方向に移す。 -/
theorem componentReaches_realizationMap_iff {V : Type} {R : V → V → Prop}
    (v w : V) :
    ComponentReaches R (realizationMap v) (realizationMap w) ↔ R v w := by
  constructor
  · rintro ⟨a, ha, b, hb, hab⟩
    have hav : a = v := Set.mem_singleton_iff.mp ha
    have hbw : b = w := Set.mem_singleton_iff.mp hb
    exact hav ▸ hbw ▸ hab
  · intro hvw
    exact ⟨v, Set.mem_singleton v, w, Set.mem_singleton w, hvw⟩

namespace Derivation

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentCompositionIdempotents
open CellularAutomata.NeighborhoodAssignmentReachabilityPreorder
open CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets

variable {V : Type} [Fintype V] [DecidableEq V]

omit [Fintype V] [DecidableEq V] in
theorem partialOrder_iff (R : V → V → Prop) :
    IsPartialOrderOnUniv R ↔
      CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R :=
  Iff.rfl

theorem coe_assignmentOfRelation (R : V → V → Prop) [DecidableRel R] :
    (fun v => ((CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation R v :
      Finset V) : Set V)) = assignmentOfRelation R := by
  funext v
  ext w
  simp [CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation,
    assignmentOfRelation]

/-- 具体版の自己近傍性は必要十分版の特殊化である。 -/
theorem assignmentOfRelation_self_mem_of_necSuf (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R)
    (v : V) :
    v ∈ CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation R v := by
  have h := assignmentOfRelation_self_mem ((partialOrder_iff R).mpr hR) v
  rw [← coe_assignmentOfRelation R] at h
  exact h

/-- 具体版の推移性は必要十分版の特殊化である。 -/
theorem assignmentOfRelation_isTransitive_of_necSuf (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R) :
    IsTransitive
      (CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation R) := by
  intro v u w hu hw
  have hTrans := assignmentOfRelation_isTransitive ((partialOrder_iff R).mpr hR)
  apply (CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.mem_assignmentOfRelation
    R v w).mpr
  exact hTrans v u w
    ((CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.mem_assignmentOfRelation
      R v u).mp hu)
    ((CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.mem_assignmentOfRelation
      R u w).mp hw)

/-- 具体版の一元成分定理は必要十分版の特殊化である。 -/
theorem mutualComponent_assignmentOfRelation_of_necSuf
    (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R)
    (v : V) :
    CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent
      (CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation R) v =
        {v} := by
  ext w
  have hSet := congrArg (fun S : Set V => w ∈ S)
    (mutualComponent_assignmentOfRelation ((partialOrder_iff R).mpr hR) v)
  rw [CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mem_mutualComponent_iff]
  rw [CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches,
    CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.reaches_assignmentOfRelation_iff
      R hR v w,
    CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.reaches_assignmentOfRelation_iff
      R hR w v]
  simpa [CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder.mutualComponent,
    CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches,
    CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder.Reaches] using hSet

omit [Fintype V] [DecidableEq V] in
/-- 具体版の実現写像の単射性は必要十分版の特殊化である。 -/
theorem realizationMap_injective_of_necSuf :
    Function.Injective
      (CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.realizationMap
        (V := V)) := by
  intro v w hvw
  apply realizationMap_injective
  have hSet := congrArg (fun S : Finset V => (S : Set V)) hvw
  change ({v} : Set V) = {w}
  simpa [CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.realizationMap]
    using hSet

/-- 具体版の順序保存同値は必要十分版の特殊化である。 -/
theorem componentReaches_realizationMap_iff_of_necSuf
    (R : V → V → Prop) [DecidableRel R]
    (hR : CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.IsPartialOrderOnUniv R)
    (v w : V) :
    CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches
      (CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.assignmentOfRelation R)
      (CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.realizationMap v)
      (CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.realizationMap w) ↔ R v w := by
  rw [CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets.componentReaches_realizationMap_iff
    R hR v w]

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets
