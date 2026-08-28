/-
章「到達前順序と相互到達成分」の Lean 必要十分版。

必要な構造の検査結果:
  - 到達関係の反射性・推移性と、相互到達関係が同値関係をなすことに要るのは、
    台上の二項関係と、その反射性・推移性だけである。
  - 相互到達成分の所属特徴づけ・自己転置性・分割性には、さらに集合の外延性だけが要る。
    台の有限性も等号判定も要らない。
  - 反対称性の破れには、相異なる二元と両方向の到達だけが要る。
  - 有限性と等号判定が要るのは、具体版で閉包・成分を `Finset` として構成し、
    全組を走査して決定する段だけである。
  - 状態集合、局所規則、時間、順序、R / C は使わない。
-/
import CellularAutomata.NeighborhoodAssignmentReachabilityPreorder
import CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure
import CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder

open CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution

/-- 任意の二項関係を到達関係として読む。 -/
def Reaches {V : Type} (R : V → V → Prop) (v w : V) : Prop := R v w

/-- 相互到達関係。 -/
def MutuallyReaches {V : Type} (R : V → V → Prop) (v w : V) : Prop :=
  Reaches R v w ∧ Reaches R w v

/-- 相互到達成分。 -/
def mutualComponent {V : Type} (R : V → V → Prop) (v : V) : Set V :=
  {w | MutuallyReaches R v w}

/-- 反射的な関係の到達関係は反射的である。 -/
theorem reaches_refl {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v) (v : V) : Reaches R v v := hRefl v

/-- 推移的な関係の到達関係は推移的である。 -/
theorem reaches_trans {V : Type} {R : V → V → Prop}
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {v u w : V} (hvu : Reaches R v u) (huw : Reaches R u w) : Reaches R v w :=
  hTrans v u w hvu huw

/-- 相異なる二元が相互到達すれば反対称性は破れる。 -/
theorem not_antisymmetric_of_mutual {V : Type} {R : V → V → Prop}
    {v w : V} (hne : v ≠ w) (hvw : Reaches R v w) (hwv : Reaches R w v) :
    ¬ ∀ a b : V, Reaches R a b → Reaches R b a → a = b := by
  intro h
  exact hne (h v w hvw hwv)

/-- 反射性から相互到達関係の反射性が従う。 -/
theorem mutuallyReaches_refl {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v) (v : V) : MutuallyReaches R v v :=
  ⟨reaches_refl hRefl v, reaches_refl hRefl v⟩

/-- 相互到達関係は定義だけから対称的である。 -/
theorem mutuallyReaches_symm {V : Type} {R : V → V → Prop} {v w : V}
    (h : MutuallyReaches R v w) : MutuallyReaches R w v := ⟨h.2, h.1⟩

/-- 到達関係の推移性から相互到達関係の推移性が従う。 -/
theorem mutuallyReaches_trans {V : Type} {R : V → V → Prop}
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {v u w : V} (hvu : MutuallyReaches R v u) (huw : MutuallyReaches R u w) :
    MutuallyReaches R v w :=
  ⟨reaches_trans hTrans hvu.1 huw.1, reaches_trans hTrans huw.2 hvu.2⟩

/-- 成分への所属は相互到達の定義そのものである。 -/
theorem mem_mutualComponent_iff {V : Type} (R : V → V → Prop) (v w : V) :
    w ∈ mutualComponent R v ↔ MutuallyReaches R v w := Iff.rfl

/-- 相互到達成分割り当ては自己転置である。 -/
theorem mutualComponent_selfTranspose {V : Type} (R : V → V → Prop) :
    setTranspose (mutualComponent R) = mutualComponent R := by
  funext v
  ext w
  exact ⟨fun h => mutuallyReaches_symm h, fun h => mutuallyReaches_symm h⟩

/-- 反射性から各元が自分の相互到達成分に属する。 -/
theorem self_mem_mutualComponent {V : Type} {R : V → V → Prop}
    (hRefl : ∀ v : V, R v v) (v : V) : v ∈ mutualComponent R v :=
  mutuallyReaches_refl hRefl v

/-- 共通元を持つ二成分の片側包含。人手証明と同じ二回の推移を使う。 -/
theorem mutualComponent_subset_of_mem {V : Type} {R : V → V → Prop}
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {v u r : V} (hv : r ∈ mutualComponent R v) (hu : r ∈ mutualComponent R u) :
    mutualComponent R v ⊆ mutualComponent R u := by
  intro w hw
  have hrw : MutuallyReaches R r w :=
    mutuallyReaches_trans hTrans (mutuallyReaches_symm hv) hw
  exact mutuallyReaches_trans hTrans hu hrw

/-- 共通元を持つ二成分は等しい。 -/
theorem mutualComponent_eq_of_inter_nonempty {V : Type} {R : V → V → Prop}
    (hTrans : ∀ v u w : V, R v u → R u w → R v w)
    {v u : V} (h : (mutualComponent R v ∩ mutualComponent R u).Nonempty) :
    mutualComponent R v = mutualComponent R u := by
  obtain ⟨r, hv, hu⟩ := h
  exact Set.Subset.antisymm
    (mutualComponent_subset_of_mem hTrans hv hu)
    (mutualComponent_subset_of_mem hTrans hu hv)

namespace Derivation

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentReachabilityPreorder
open CellularAutomata.NeighborhoodAssignmentReachabilityClosure
open CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure

variable {V : Type} [Fintype V] [DecidableEq V]

def closureRelation (N : NeighborhoodAssignment V) : V → V → Prop :=
  fun v w => w ∈ setReachabilityClosure (fun x => ((N x : Finset V) : Set V)) v

theorem reaches_iff (N : NeighborhoodAssignment V) (v w : V) :
    Reaches (closureRelation N) v w ↔
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N v w := by
  rw [CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.reaches_iff_mem_closure]
  change w ∈ setReachabilityClosure (fun x => ((N x : Finset V) : Set V)) v ↔ _
  rw [← CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure.Derivation.coe_reachabilityClosure N]
  rfl

theorem reaches_refl_of_necSuf (N : NeighborhoodAssignment V) (v : V) :
    CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N v v :=
  (reaches_iff N v v).mp
    (reaches_refl (setReachabilityClosure_self_mem (fun x => ((N x : Finset V) : Set V))) v)

theorem reaches_trans_of_necSuf (N : NeighborhoodAssignment V) {v u w : V}
    (hvu : CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N v u)
    (huw : CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N u w) :
    CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N v w := by
  apply (reaches_iff N v w).mp
  exact reaches_trans (setReachabilityClosure_transitive
    (fun x => ((N x : Finset V) : Set V)))
    ((reaches_iff N v u).mpr hvu) ((reaches_iff N u w).mpr huw)

theorem reaches_not_antisymmetric_of_necSuf :
    ¬ ∀ (N : NeighborhoodAssignment Bool) (v w : Bool),
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N v w →
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N w v → v = w := by
  let N := CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.twoCellAssignment
  have h₀₁ : CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N false true := by
    simpa [N] using
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.twoCell_reaches_flip false
  have h₁₀ : CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.Reaches N true false := by
    simpa [N] using
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.twoCell_reaches_flip true
  have hNot : ¬ ∀ v w : Bool, Reaches (closureRelation N) v w →
      Reaches (closureRelation N) w v → v = w :=
    not_antisymmetric_of_mutual Bool.false_ne_true
      ((reaches_iff N false true).mpr h₀₁) ((reaches_iff N true false).mpr h₁₀)
  intro h
  apply hNot
  intro v w hvw hwv
  exact h N v w ((reaches_iff N v w).mp hvw) ((reaches_iff N w v).mp hwv)

theorem mutuallyReaches_iff (N : NeighborhoodAssignment V) (v w : V) :
    MutuallyReaches (closureRelation N) v w ↔
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches N v w := by
  simp only [MutuallyReaches]
  rw [reaches_iff, reaches_iff]
  rfl

theorem coe_mutualComponent (N : NeighborhoodAssignment V) (v : V) :
    ((CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v : Finset V) : Set V) =
      mutualComponent (closureRelation N) v := by
  ext w
  change w ∈ CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v ↔ _
  rw [CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mem_mutualComponent_iff,
    mem_mutualComponent_iff, mutuallyReaches_iff]

theorem mem_mutualComponent_iff_of_necSuf (N : NeighborhoodAssignment V) (v w : V) :
    w ∈ CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v ↔
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches N v w := by
  rw [← mutuallyReaches_iff N v w, ← mem_mutualComponent_iff]
  have hEq := coe_mutualComponent N v
  change w ∈ ((CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v :
    Finset V) : Set V) ↔ _
  rw [hEq]

theorem mutualComponent_selfTranspose_of_necSuf (N : NeighborhoodAssignment V) :
    CellularAutomata.NeighborhoodAssignmentTransposeInvolution.transpose
      (CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N) =
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N := by
  funext v
  ext w
  rw [CellularAutomata.NeighborhoodAssignmentTransposeInvolution.mem_transpose]
  rw [mem_mutualComponent_iff_of_necSuf, mem_mutualComponent_iff_of_necSuf]
  constructor
  · intro h
    exact (mutuallyReaches_iff N v w).mp
      (mutuallyReaches_symm ((mutuallyReaches_iff N w v).mpr h))
  · intro h
    exact (mutuallyReaches_iff N w v).mp
      (mutuallyReaches_symm ((mutuallyReaches_iff N v w).mpr h))

theorem mutuallyReaches_refl_of_necSuf (N : NeighborhoodAssignment V) (v : V) :
    CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches N v v :=
  (mutuallyReaches_iff N v v).mp
    (mutuallyReaches_refl
      (setReachabilityClosure_self_mem (fun x => ((N x : Finset V) : Set V))) v)

theorem mutuallyReaches_symm_of_necSuf (N : NeighborhoodAssignment V) {v w : V}
    (h : CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches N v w) :
    CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches N w v :=
  (mutuallyReaches_iff N w v).mp (mutuallyReaches_symm ((mutuallyReaches_iff N v w).mpr h))

theorem mutuallyReaches_trans_of_necSuf (N : NeighborhoodAssignment V) {v u w : V}
    (hvu : CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches N v u)
    (huw : CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches N u w) :
    CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.MutuallyReaches N v w := by
  apply (mutuallyReaches_iff N v w).mp
  exact mutuallyReaches_trans (setReachabilityClosure_transitive
    (fun x => ((N x : Finset V) : Set V)))
    ((mutuallyReaches_iff N v u).mpr hvu) ((mutuallyReaches_iff N u w).mpr huw)

theorem self_mem_mutualComponent_of_necSuf (N : NeighborhoodAssignment V) (v : V) :
    v ∈ CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v := by
  have h := self_mem_mutualComponent
    (setReachabilityClosure_self_mem (fun x => ((N x : Finset V) : Set V))) v
  have hEq := coe_mutualComponent N v
  change v ∈ ((CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v :
    Finset V) : Set V)
  rw [hEq]
  exact h

theorem mutualComponent_eq_of_inter_nonempty_of_necSuf (N : NeighborhoodAssignment V)
    {v u : V}
    (h : (CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v ∩
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N u).Nonempty) :
    CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v =
      CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N u := by
  apply Finset.ext
  intro w
  have hSet : (mutualComponent (closureRelation N) v ∩
      mutualComponent (closureRelation N) u).Nonempty := by
    obtain ⟨r, hr⟩ := h
    exact ⟨r, (coe_mutualComponent N v) ▸ Finset.mem_of_mem_inter_left hr,
      (coe_mutualComponent N u) ▸ Finset.mem_of_mem_inter_right hr⟩
  have hEq := mutualComponent_eq_of_inter_nonempty
    (setReachabilityClosure_transitive (fun x => ((N x : Finset V) : Set V))) hSet
  change mutualComponent (closureRelation N) v = mutualComponent (closureRelation N) u at hEq
  change w ∈ _ ↔ w ∈ _
  have hv := congrArg (fun S : Set V => w ∈ S) (coe_mutualComponent N v)
  have hu := congrArg (fun S : Set V => w ∈ S) (coe_mutualComponent N u)
  change w ∈ ((CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N v :
    Finset V) : Set V) ↔
    w ∈ ((CellularAutomata.NeighborhoodAssignmentReachabilityPreorder.mutualComponent N u :
      Finset V) : Set V)
  rw [hv, hu, hEq]

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityPreorder
