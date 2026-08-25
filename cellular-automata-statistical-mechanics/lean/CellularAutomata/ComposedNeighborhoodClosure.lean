/-
章「合成近傍による大域写像の合成表現」の Lean 具体版。
人手証明の正本は structured-latex/content/composed-neighborhood-closure.ts。

対応表（人手証明 → この file）
  def_composed_neighborhood
    `composedNeighborhood`, `inner_mem_composedNeighborhood`
  def_composed_local_rule_family
    `composedLocalRuleFamily`
  claim_global_map_composition_representable_on_composed_neighborhood
    `twoStageRestriction`, `globalMap_composition_eq`,
    `globalMap_composition_mem_stageGlobalMaps`

必要十分版は NecSuf/ComposedNeighborhoodClosure.lean、そこからの導出は
このファイル末尾の `Derivation` 名前空間に置く。

住処: 有限型・有限部分集合・二元状態上の写像のみ。ℝ / ℂ は現れない。
抽象度は人手証明に固定し、合成近傍、二段制限、合成局所規則族、
大域写像の一致と所属を同じ順序で形式化する。
-/
import CellularAutomata.LocalityRestrictsCycleType
import CellularAutomata.NecSuf.ComposedNeighborhoodClosure

namespace CellularAutomata.ComposedNeighborhoodClosure

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.LocalityRestrictsCycleType

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_composed_neighborhood` の (N ⋆ M)(v) = ⋃_{u ∈ N(v)} M(u)。 -/
def composedNeighborhood (N M : V → Finset V) (v : V) : Finset V :=
  (N v).biUnion M

omit [Fintype V] in
/-- u ∈ N(v) なら M(u) ⊆ (N ⋆ M)(v)。合併の定義から従う。 -/
theorem inner_mem_composedNeighborhood (N M : V → Finset V) (v u w : V)
    (hu : u ∈ N v) (hw : w ∈ M u) : w ∈ composedNeighborhood N M v := by
  exact Finset.mem_biUnion.mpr ⟨u, hu, hw⟩

/-- `def_composed_local_rule_family` の h_v。
    z を各 M(u) へ制限して g_u を適用し、その N(v) 上の値を f_v へ渡す。 -/
def composedLocalRuleFamily (N M : V → Finset V)
    (f : LocalRuleFamily N) (g : LocalRuleFamily M) :
    LocalRuleFamily (composedNeighborhood N M) :=
  fun v z => f v (fun u => g u.val (fun w =>
    z ⟨w.val, inner_mem_composedNeighborhood N M v u.val w.val u.property w.property⟩))

omit [Fintype V] in
/-- 人手証明の二段制限:
    ρ^{(N⋆M)(v)}_{M(u)}(ρ^V_{(N⋆M)(v)}x) = ρ^V_{M(u)}x。 -/
theorem twoStageRestriction (N M : V → Finset V) (x : V → State)
    (v : V) (u : ↥(N v)) :
    (fun w : ↥(M u.val) =>
      (restrict (composedNeighborhood N M v) x)
        ⟨w.val, inner_mem_composedNeighborhood N M v u.val w.val u.property w.property⟩) =
      restrict (M u.val) x := by
  funext w
  rfl

omit [Fintype V] in
/-- `claim_global_map_composition_representable_on_composed_neighborhood` の等号部分。
    人手証明どおり二段制限を座標ごとに展開し、写像の外延性で結ぶ。 -/
theorem globalMap_composition_eq (N M : V → Finset V)
    (f : LocalRuleFamily N) (g : LocalRuleFamily M) :
    globalMap N f ∘ globalMap M g =
      globalMap (composedNeighborhood N M) (composedLocalRuleFamily N M f g) := by
  funext x v
  show f v (restrict (N v) (globalMap M g x)) =
    f v (fun u => g u.val (fun w =>
      (restrict (composedNeighborhood N M v) x)
        ⟨w.val, inner_mem_composedNeighborhood N M v u.val w.val u.property w.property⟩))
  refine congrArg (f v) ?_
  funext u
  show g u.val (restrict (M u.val) x) = _
  rw [twoStageRestriction N M x v u]

/-- `claim_global_map_composition_representable_on_composed_neighborhood` の所属部分。
    合成局所規則族を明示的な証人として M(V,N⋆M) への所属を示す。 -/
theorem globalMap_composition_mem_stageGlobalMaps (N M : V → Finset V)
    (f : LocalRuleFamily N) (g : LocalRuleFamily M) :
    globalMap N f ∘ globalMap M g ∈ stageGlobalMaps (composedNeighborhood N M) := by
  classical
  rw [globalMap_composition_eq]
  unfold stageGlobalMaps
  exact Finset.mem_image.mpr ⟨composedLocalRuleFamily N M f g, Finset.mem_univ _, rfl⟩

/-! ### 必要十分版からの導出

添字型は同じ `V`（有限性は必要十分版では使わない）、状態型を `State` に特殊化する。
具体版の合成近傍・合成局所規則族・二段制限・大域写像の一致は、いずれも必要十分版を
A := State と取った特殊化である。有限性を使うのは、大域写像全体 `stageGlobalMaps` を
有限集合として集める最後の所属の段だけである。 -/

namespace Derivation

/-- 具体版の合成近傍は、必要十分版の合成近傍そのものである。 -/
theorem composedNeighborhood_eq (N M : V → Finset V) :
    composedNeighborhood N M =
      _root_.CellularAutomata.NecSuf.ComposedNeighborhoodClosure.composedNeighborhood N M :=
  rfl

/-- 具体版の部分近傍の包含は、必要十分版の特殊化である。 -/
theorem inner_mem_composedNeighborhood_of_necSuf (N M : V → Finset V) (v u w : V)
    (hu : u ∈ N v) (hw : w ∈ M u) : w ∈ composedNeighborhood N M v :=
  _root_.CellularAutomata.NecSuf.ComposedNeighborhoodClosure.inner_mem_composedNeighborhood
    N M v u w hu hw

/-- 具体版の合成局所規則族は、必要十分版の合成局所規則族を A := State と取ったものである。 -/
theorem composedLocalRuleFamily_eq (N M : V → Finset V)
    (f : LocalRuleFamily N) (g : LocalRuleFamily M) :
    composedLocalRuleFamily N M f g =
      _root_.CellularAutomata.NecSuf.ComposedNeighborhoodClosure.composedLocalRuleFamily
        (A := State) N M f g :=
  rfl

/-- 具体版の二段制限は、必要十分版の二段制限の特殊化である。 -/
theorem twoStageRestriction_of_necSuf (N M : V → Finset V) (x : V → State)
    (v : V) (u : ↥(N v)) :
    (fun w : ↥(M u.val) =>
      (restrict (composedNeighborhood N M v) x)
        ⟨w.val, inner_mem_composedNeighborhood N M v u.val w.val u.property w.property⟩) =
      restrict (M u.val) x :=
  _root_.CellularAutomata.NecSuf.ComposedNeighborhoodClosure.twoStageRestriction
    (A := State) N M x v u

/-- 具体版の大域写像の合成の一致は、必要十分版の等号の特殊化である。 -/
theorem globalMap_composition_eq_of_necSuf (N M : V → Finset V)
    (f : LocalRuleFamily N) (g : LocalRuleFamily M) :
    globalMap N f ∘ globalMap M g =
      globalMap (composedNeighborhood N M) (composedLocalRuleFamily N M f g) :=
  _root_.CellularAutomata.NecSuf.ComposedNeighborhoodClosure.globalMap_composition_eq
    (A := State) N M f g

/-- 具体版の所属は、必要十分版の「合成近傍上の局所規則族が存在する」に
    V と State の有限性を足して、大域写像全体を有限集合として集めたものである。 -/
theorem globalMap_composition_mem_stageGlobalMaps_of_necSuf (N M : V → Finset V)
    (f : LocalRuleFamily N) (g : LocalRuleFamily M) :
    globalMap N f ∘ globalMap M g ∈ stageGlobalMaps (composedNeighborhood N M) := by
  classical
  obtain ⟨h, hh⟩ :=
    _root_.CellularAutomata.NecSuf.ComposedNeighborhoodClosure.globalMap_composition_representable
      (A := State) N M f g
  have hh' : globalMap N f ∘ globalMap M g =
      globalMap (composedNeighborhood N M) h := hh
  rw [hh']
  unfold stageGlobalMaps
  exact Finset.mem_image.mpr ⟨h, Finset.mem_univ _, rfl⟩

end Derivation

end CellularAutomata.ComposedNeighborhoodClosure
