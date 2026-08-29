/-
章「相互到達成分の商が定める有限半順序」の Lean 必要十分版。

必要な構造の検査結果:
  - 成分集合、代表の回復、代表非依存性、商上の反射性・推移性・反対称性には、
    台上の二項関係と、その反射性・推移性だけが要る。
  - 台の有限性も等号判定も要らない。有限性が要るのは、具体版で成分集合を
    `Finset` として列挙し、個数と有限走査を述べる段だけである。
  - 状態集合、局所規則、時間、順序、R / C は使わない。
-/
import CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder
import CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityQuotientOrder

open CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder

/-- 相互到達成分の全体を、成分割り当ての像として取る。 -/
def componentSet {V : Type} (R : V → V → Prop) : Set (Set V) :=
  {Q | ∃ u : V, mutualComponent R u = Q}

/-- 商の上の到達関係。一組の代表が到達すればよい。 -/
def ComponentReaches {V : Type} (R : V → V → Prop) (Q S : Set V) : Prop :=
  ∃ v ∈ Q, ∃ w ∈ S, Reaches R v w

theorem mem_componentSet_iff {V : Type} (R : V → V → Prop) (Q : Set V) :
    Q ∈ componentSet R ↔ ∃ u : V, mutualComponent R u = Q := Iff.rfl

/-- 反射性から各相互到達成分が空でないことが従う。 -/
theorem componentSet_nonempty {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v) {Q : Set V} (hQ : Q ∈ componentSet R) : Q.Nonempty := by
  obtain ⟨u, rfl⟩ := hQ
  exact ⟨u, self_mem_mutualComponent hRefl u⟩

/-- 成分は、その任意の元の相互到達成分に一致する。 -/
theorem componentSet_eq_mutualComponent_of_mem {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v)
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {Q : Set V} (hQ : Q ∈ componentSet R) {v : V} (hv : v ∈ Q) :
    Q = mutualComponent R v := by
  obtain ⟨u, rfl⟩ := hQ
  have hInter : (mutualComponent R u ∩ mutualComponent R v).Nonempty :=
    ⟨v, hv, self_mem_mutualComponent hRefl v⟩
  exact mutualComponent_eq_of_inter_nonempty hTrans hInter

/-- 商上の到達は、任意の代表の間の到達と同値である。 -/
theorem componentReaches_iff_forall {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v)
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {Q S : Set V} (hQ : Q ∈ componentSet R) (hS : S ∈ componentSet R) :
    ComponentReaches R Q S ↔ ∀ v ∈ Q, ∀ w ∈ S, Reaches R v w := by
  constructor
  · rintro ⟨v₀, hv₀, w₀, hw₀, hv₀w₀⟩ v hv w hw
    have hQv := componentSet_eq_mutualComponent_of_mem hRefl hTrans hQ hv
    have hSw := componentSet_eq_mutualComponent_of_mem hRefl hTrans hS hw
    have hvv₀ : Reaches R v v₀ := ((mem_mutualComponent_iff R v v₀).mp (hQv ▸ hv₀)).1
    have hw₀w : Reaches R w₀ w := ((mem_mutualComponent_iff R w w₀).mp (hSw ▸ hw₀)).2
    exact reaches_trans hTrans (reaches_trans hTrans hvv₀ hv₀w₀) hw₀w
  · intro hAll
    obtain ⟨v, hv⟩ := componentSet_nonempty hRefl hQ
    obtain ⟨w, hw⟩ := componentSet_nonempty hRefl hS
    exact ⟨v, hv, w, hw, hAll v hv w hw⟩

theorem componentReaches_refl {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v) {Q : Set V} (hQ : Q ∈ componentSet R) :
    ComponentReaches R Q Q := by
  obtain ⟨v, hv⟩ := componentSet_nonempty hRefl hQ
  exact ⟨v, hv, v, hv, reaches_refl hRefl v⟩

theorem componentReaches_trans {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v)
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {Q S T : Set V} (hQ : Q ∈ componentSet R) (hS : S ∈ componentSet R)
    (hT : T ∈ componentSet R) (hQS : ComponentReaches R Q S)
    (hST : ComponentReaches R S T) : ComponentReaches R Q T := by
  obtain ⟨v, hv⟩ := componentSet_nonempty hRefl hQ
  obtain ⟨u, hu⟩ := componentSet_nonempty hRefl hS
  obtain ⟨w, hw⟩ := componentSet_nonempty hRefl hT
  exact ⟨v, hv, w, hw, reaches_trans hTrans
    ((componentReaches_iff_forall hRefl hTrans hQ hS).mp hQS v hv u hu)
    ((componentReaches_iff_forall hRefl hTrans hS hT).mp hST u hu w hw)⟩

theorem componentReaches_subset {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v)
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {Q S : Set V} (hQ : Q ∈ componentSet R) (hS : S ∈ componentSet R)
    (hQS : ComponentReaches R Q S) (hSQ : ComponentReaches R S Q) : S ⊆ Q := by
  obtain ⟨v, hv⟩ := componentSet_nonempty hRefl hQ
  intro w hw
  have hvw := (componentReaches_iff_forall hRefl hTrans hQ hS).mp hQS v hv w hw
  have hwv := (componentReaches_iff_forall hRefl hTrans hS hQ).mp hSQ w hw v hv
  have hMem : w ∈ mutualComponent R v := ⟨hvw, hwv⟩
  rw [componentSet_eq_mutualComponent_of_mem hRefl hTrans hQ hv]
  exact hMem

theorem componentReaches_antisymm {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v)
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {Q S : Set V} (hQ : Q ∈ componentSet R) (hS : S ∈ componentSet R)
    (hQS : ComponentReaches R Q S) (hSQ : ComponentReaches R S Q) : Q = S :=
  Set.Subset.antisymm
    (componentReaches_subset hRefl hTrans hS hQ hSQ hQS)
    (componentReaches_subset hRefl hTrans hQ hS hQS hSQ)

/-- 商上の関係が半順序の三性質を満たす。 -/
theorem componentReaches_isPartialOrder {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v)
    (hTrans : ∀ v u w : V, R v u → R u w → R v w) :
    (∀ Q ∈ componentSet R, ComponentReaches R Q Q) ∧
    (∀ Q ∈ componentSet R, ∀ S ∈ componentSet R, ∀ T ∈ componentSet R,
      ComponentReaches R Q S → ComponentReaches R S T → ComponentReaches R Q T) ∧
    (∀ Q ∈ componentSet R, ∀ S ∈ componentSet R,
      ComponentReaches R Q S → ComponentReaches R S Q → Q = S) :=
  ⟨fun _ hQ => componentReaches_refl hRefl hQ,
   fun _ hQ _ hS _ hT hQS hST => componentReaches_trans hRefl hTrans hQ hS hT hQS hST,
   fun _ hQ _ hS hQS hSQ => componentReaches_antisymm hRefl hTrans hQ hS hQS hSQ⟩

namespace Derivation

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder
open CellularAutomata.NeighborhoodAssignmentReachabilityPreorder
open CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder.Derivation
open CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure

variable {V : Type} [Fintype V] [DecidableEq V]

theorem coe_mem_componentSet (N : NeighborhoodAssignment V) {Q : Finset V}
    (hQ : Q ∈ CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.componentSet N) :
    (Q : Set V) ∈ componentSet (closureRelation N) := by
  obtain ⟨u, hu⟩ :=
    (CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.mem_componentSet_iff N Q).mp hQ
  refine ⟨u, ?_⟩
  rw [← coe_mutualComponent N u, hu]

theorem componentReaches_iff (N : NeighborhoodAssignment V) (Q S : Finset V) :
    ComponentReaches (closureRelation N) (Q : Set V) (S : Set V) ↔
      CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches N Q S := by
  simp only [ComponentReaches,
    CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches]
  constructor
  · rintro ⟨v, hv, w, hw, hvw⟩
    exact ⟨v, hv, w, hw, (reaches_iff N v w).mp hvw⟩
  · rintro ⟨v, hv, w, hw, hvw⟩
    exact ⟨v, hv, w, hw, (reaches_iff N v w).mpr hvw⟩

theorem componentReaches_refl_of_necSuf (N : NeighborhoodAssignment V) {Q : Finset V}
    (hQ : Q ∈ CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.componentSet N) :
    CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches N Q Q := by
  apply (componentReaches_iff N Q Q).mp
  exact componentReaches_refl
    (setReachabilityClosure_self_mem (fun x => ((N x : Finset V) : Set V)))
    (coe_mem_componentSet N hQ)

theorem componentReaches_trans_of_necSuf (N : NeighborhoodAssignment V) {Q S T : Finset V}
    (hQ : Q ∈ CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.componentSet N)
    (hS : S ∈ CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.componentSet N)
    (hT : T ∈ CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.componentSet N)
    (hQS : CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches N Q S)
    (hST : CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches N S T) :
    CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches N Q T := by
  apply (componentReaches_iff N Q T).mp
  exact componentReaches_trans
    (setReachabilityClosure_self_mem (fun x => ((N x : Finset V) : Set V)))
    (setReachabilityClosure_transitive (fun x => ((N x : Finset V) : Set V)))
    (coe_mem_componentSet N hQ) (coe_mem_componentSet N hS) (coe_mem_componentSet N hT)
    ((componentReaches_iff N Q S).mpr hQS) ((componentReaches_iff N S T).mpr hST)

theorem componentReaches_antisymm_of_necSuf (N : NeighborhoodAssignment V) {Q S : Finset V}
    (hQ : Q ∈ CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.componentSet N)
    (hS : S ∈ CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.componentSet N)
    (hQS : CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches N Q S)
    (hSQ : CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder.ComponentReaches N S Q) : Q = S := by
  apply Finset.coe_injective
  exact componentReaches_antisymm
    (setReachabilityClosure_self_mem (fun x => ((N x : Finset V) : Set V)))
    (setReachabilityClosure_transitive (fun x => ((N x : Finset V) : Set V)))
    (coe_mem_componentSet N hQ) (coe_mem_componentSet N hS)
    ((componentReaches_iff N Q S).mpr hQS) ((componentReaches_iff N S Q).mpr hSQ)

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityQuotientOrder
