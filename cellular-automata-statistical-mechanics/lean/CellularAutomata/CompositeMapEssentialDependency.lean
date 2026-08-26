/-
章「合成写像の本質的依存台」の Lean 具体版。
人手証明の正本は structured-latex/content/composite-map-essential-dependency.ts。

対応表（人手証明 → この file）
  def_finite_configuration_map_cell_map
    `cellMap`
  def_global_map_essential_dependency_assignment
    `dependencyAssignment`
  claim_composite_map_support_bounded_by_composed_support
    `supportLocalRuleFamily`, `globalMap_supportLocalRuleFamily`,
    `composite_support_subset`, `dependencyMembershipDecidable`
  def_composite_support_strict_inclusion_witness
    `StrictCell`, `strictG`, `strictF`
  claim_composite_map_support_bound_can_be_strict
    `strict_witness_values`, `composite_support_bound_can_be_strict`

人手証明と同じく、本質的依存台が最小の表現集合であること、合成近傍上で合成を
表現できること、表現可能性から依存台包含が従うことをこの順で使う。
有限型・有限部分集合・二元状態上の写像だけを扱い、ℝ / ℂ は現れない。
必要十分版は CellularAutomata.NecSuf.CompositeMapEssentialDependency にあり、
本 file 末尾で具体版の主要主張がその特殊化として得られることを示す。
-/
import CellularAutomata.ComposedNeighborhoodClosure
import CellularAutomata.LocalRuleRepresentation
import CellularAutomata.NecSuf.CompositeMapEssentialDependency

namespace CellularAutomata.CompositeMapEssentialDependency

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.LocalRuleRepresentation
open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.LocalityRestrictsCycleType

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_finite_configuration_map_cell_map`: F の v での値写像。 -/
def cellMap (F : (V → State) → (V → State)) (v : V) : (V → State) → State :=
  fun x => F x v

/-- `def_global_map_essential_dependency_assignment`: D_F(v) = supp(F_v)。 -/
def dependencyAssignment (F : (V → State) → (V → State)) (v : V) : Finset V :=
  supp (cellMap F v)

/-- 各値写像をその本質的依存台上で表す、人手証明の局所規則族。 -/
def supportLocalRuleFamily (F : (V → State) → (V → State)) :
    LocalRuleFamily (dependencyAssignment F) :=
  fun v => cellMap F v ∘ baseExtend (dependencyAssignment F v)

/-- 人手証明の第一段: F は D_F 上の局所規則族が定める大域写像である。 -/
theorem globalMap_supportLocalRuleFamily (F : (V → State) → (V → State)) :
    globalMap (dependencyAssignment F) (supportLocalRuleFamily F) = F := by
  funext x v
  change cellMap F v (baseExtend (dependencyAssignment F v)
    (restrict (dependencyAssignment F v) x)) = F x v
  exact (supp_subset_implies_representable (dependencyAssignment F v) (cellMap F v)
    Finset.Subset.rfl x).symm

/-- `claim_composite_map_support_bounded_by_composed_support`。
    人手証明の三段を順に用いて、各セルで合成の依存台包含を得る。 -/
theorem composite_support_subset (F G : (V → State) → (V → State)) (v : V) :
    dependencyAssignment (F ∘ G) v ⊆
      composedNeighborhood (dependencyAssignment F) (dependencyAssignment G) v := by
  apply representable_implies_supp_subset
  refine ⟨composedLocalRuleFamily (dependencyAssignment F) (dependencyAssignment G)
    (supportLocalRuleFamily F) (supportLocalRuleFamily G) v, ?_⟩
  intro x
  have hcomp := globalMap_composition_eq
    (dependencyAssignment F) (dependencyAssignment G)
    (supportLocalRuleFamily F) (supportLocalRuleFamily G)
  have hleft :
      globalMap (dependencyAssignment F) (supportLocalRuleFamily F) ∘
          globalMap (dependencyAssignment G) (supportLocalRuleFamily G) = F ∘ G := by
    rw [globalMap_supportLocalRuleFamily, globalMap_supportLocalRuleFamily]
  have hmaps : F ∘ G =
      globalMap
        (composedNeighborhood (dependencyAssignment F) (dependencyAssignment G))
        (composedLocalRuleFamily (dependencyAssignment F) (dependencyAssignment G)
          (supportLocalRuleFamily F) (supportLocalRuleFamily G)) := by
    rw [← hleft]
    exact hcomp
  exact congrFun (congrFun hmaps x) v

/-- 有限真理値表から各依存台の所属が決定できること。 -/
instance dependencyMembershipDecidable (F : (V → State) → (V → State)) (v w : V) :
    Decidable (w ∈ dependencyAssignment F v) := inferInstance

/-- 反例の相異なる二セル。 -/
inductive StrictCell : Type where
  | a : StrictCell
  | b : StrictCell
deriving DecidableEq

instance : Fintype StrictCell :=
  ⟨{StrictCell.a, StrictCell.b}, fun v => by cases v <;> simp⟩

/-- `def_composite_support_strict_inclusion_witness` の G。入力 a を二つの中間セルへ複製する。 -/
def strictG (x : StrictCell → State) : StrictCell → State :=
  fun _ => x StrictCell.a

/-- `def_composite_support_strict_inclusion_witness` の F。
    a では二つの中間値の相違を読み、b では常に zero を返す。 -/
def strictF (y : StrictCell → State) : StrictCell → State
  | StrictCell.a => if y StrictCell.a = y StrictCell.b then State.zero else State.one
  | StrictCell.b => State.zero

/-- 人手証明で個別に計算した三つの依存台の値。有限真理値表を全て展開して確認する。 -/
theorem strict_witness_values :
    dependencyAssignment (strictF ∘ strictG) StrictCell.a = ∅ ∧
    dependencyAssignment strictF StrictCell.a = {StrictCell.a, StrictCell.b} ∧
    dependencyAssignment strictG StrictCell.a = {StrictCell.a} ∧
    dependencyAssignment strictG StrictCell.b = {StrictCell.a} := by
  native_decide

/-- `claim_composite_map_support_bound_can_be_strict`。
    D_{F∘G}(a) = ∅ ⊊ {a} = (D_F ⋆ D_G)(a)。 -/
theorem composite_support_bound_can_be_strict :
    dependencyAssignment (strictF ∘ strictG) StrictCell.a ⊂
      composedNeighborhood (dependencyAssignment strictF) (dependencyAssignment strictG)
        StrictCell.a := by
  native_decide

/-! ### 必要十分版からの導出 -/

/-- 状態型 `State` と入れ替え写像 `nu` へ特殊化した、本質的依存の決定手続き。
    必要十分版はこの手続きを仮定として外へ出している。 -/
def stateEssentialDepDecidable (g : (V → State) → State) (w : V) :
    Decidable (NecSuf.EssentialDependency.EssentialDep g w) :=
  NecSuf.EssentialDependency.essentialDepDecidable nu ne_iff_eq_nu g w

omit [Fintype V] [DecidableEq V] in
/-- 具体版の値写像は、必要十分版の値写像を状態型 `State` へ特殊化したものである。 -/
theorem cellMap_eq_necessary_sufficient (F : (V → State) → (V → State)) (v : V) :
    cellMap F v = NecSuf.CompositeMapEssentialDependency.cellMap F v := rfl

/-- 具体版の依存台割り当ては、必要十分版の依存台割り当てを、状態型 `State` と
    その有限真理値表による決定手続きへ特殊化したものである。 -/
theorem dependencyAssignment_eq_necessary_sufficient (F : (V → State) → (V → State)) (v : V) :
    dependencyAssignment F v =
      NecSuf.CompositeMapEssentialDependency.supportAssignment
        stateEssentialDepDecidable F v := by
  ext w
  rw [NecSuf.CompositeMapEssentialDependency.mem_supportAssignment_iff]
  exact mem_supp_iff (cellMap F v) w

/-- `claim_composite_map_support_bounded_by_composed_support` が、必要十分版の包含定理を
    状態型 `State`、入れ替え写像 `nu`、基準値 `State.zero` へ特殊化して得られること。 -/
theorem composite_support_subset_from_necessary_sufficient
    (F G : (V → State) → (V → State)) (v : V) :
    dependencyAssignment (F ∘ G) v ⊆
      composedNeighborhood (dependencyAssignment F) (dependencyAssignment G) v := by
  have h := NecSuf.CompositeMapEssentialDependency.supportAssignment_composite_subset
    (V := V) (A := State) stateEssentialDepDecidable State.zero nu ne_iff_eq_nu F G v
  have hD : ∀ H : (V → State) → (V → State),
      dependencyAssignment H =
        NecSuf.CompositeMapEssentialDependency.supportAssignment stateEssentialDepDecidable H :=
    fun H => funext (fun u => dependencyAssignment_eq_necessary_sufficient H u)
  rw [composedNeighborhood, hD F, hD G, hD (F ∘ G)]
  exact h

/-- 具体版の複製写像は、必要十分版の複製写像をセル `StrictCell.a` へ特殊化したものである。 -/
theorem strictG_eq_necessary_sufficient :
    strictG = NecSuf.CompositeMapEssentialDependency.dupMap (A := State) StrictCell.a := rfl

/-- 具体版の相違読み取り写像は、必要十分版の相違読み取り写像を
    セル `StrictCell.a`・`StrictCell.b` と値 `State.zero`・`State.one` へ特殊化したものである。 -/
theorem strictF_eq_necessary_sufficient :
    strictF = NecSuf.CompositeMapEssentialDependency.diffMap
      StrictCell.a StrictCell.b State.zero State.one := by
  funext y c
  cases c <;> simp [strictF, NecSuf.CompositeMapEssentialDependency.diffMap]

/-- `claim_composite_map_support_bound_can_be_strict` が、必要十分版の反例定理を
    二セルの舞台と状態型 `State` の相異なる二値へ特殊化して得られること。 -/
theorem composite_support_bound_can_be_strict_from_necessary_sufficient :
    dependencyAssignment (strictF ∘ strictG) StrictCell.a ⊂
      composedNeighborhood (dependencyAssignment strictF) (dependencyAssignment strictG)
        StrictCell.a := by
  have h := NecSuf.CompositeMapEssentialDependency.supportAssignment_composite_subset_can_be_strict
    (C := StrictCell) (A := State) stateEssentialDepDecidable
    StrictCell.a StrictCell.b (by decide) State.zero State.one (by decide)
  have hD : ∀ H : (StrictCell → State) → (StrictCell → State),
      dependencyAssignment H =
        NecSuf.CompositeMapEssentialDependency.supportAssignment stateEssentialDepDecidable H :=
    fun H => funext (fun u => dependencyAssignment_eq_necessary_sufficient H u)
  rw [composedNeighborhood, hD strictF, hD strictG, hD (strictF ∘ strictG),
    strictF_eq_necessary_sufficient, strictG_eq_necessary_sufficient]
  exact h

end CellularAutomata.CompositeMapEssentialDependency
