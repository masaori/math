/-
章「固定近傍による可逆大域写像族の合成非閉性」の Lean 具体版。
人手証明の正本は structured-latex/content/stage-reversible-composition-nonclosure.ts。

3 セルの巡回依存舞台、座標送り写像、その両側逆写像、二回合成の近傍外依存、
固定近傍での表現不能を、人手証明と同じ対象・仮定・順序で形式化する。
有限型・有限部分集合・写像だけを使い、R / C は現れない。

必要十分版は NecSuf/FixedNeighborhoodCompositionNonclosure.lean、そこからの導出は
この file 末尾の `Derivation` 名前空間にある。
-/
import CellularAutomata.LocalRuleRepresentation
import CellularAutomata.LocalityRestrictsCycleType
import CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure

namespace CellularAutomata.FixedNeighborhoodCompositionNonclosure

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.LocalRuleRepresentation
open CellularAutomata.LocalityRestrictsCycleType

/-- `def_three_cell_cyclic_dependency_stage` の相異なる 3 セル。 -/
inductive Cell : Type where
  | a | b | c
deriving DecidableEq

instance : Fintype Cell :=
  ⟨{Cell.a, Cell.b, Cell.c}, fun v => by cases v <;> simp⟩

/-- 巡回写像 s(a)=b, s(b)=c, s(c)=a。 -/
def shift : Cell → Cell
  | .a => .b
  | .b => .c
  | .c => .a

/-- 固定近傍 N(v)={s(v)}。 -/
def nbhd (v : Cell) : Finset Cell := {shift v}

/-- 座標送り写像 F(x)(v)=x(s(v))。 -/
def shiftMap (x : Cell → State) : Cell → State := fun v => x (shift v)

/-- F を固定近傍上で表す一元局所規則族。 -/
def shiftRules : LocalRuleFamily nbhd :=
  fun v z => z ⟨shift v, by simp [nbhd]⟩

/-- 定義した局所規則族の大域写像は F に一致する。 -/
theorem globalMap_shiftRules : globalMap nbhd shiftRules = shiftMap := by
  funext x v
  simp [globalMap, shiftRules, restrict, shiftMap]

/-- s を三回適用すると元へ戻る。 -/
theorem shift_three (v : Cell) : shift (shift (shift v)) = v := by
  cases v <;> rfl

/-- 人手証明の G(x)(v)=x(s(s(v)))。 -/
def inverseShiftMap (x : Cell → State) : Cell → State :=
  fun v => x (shift (shift v))

/-- F o G = id。 -/
theorem shiftMap_comp_inverseShiftMap : shiftMap ∘ inverseShiftMap = id := by
  funext x v
  simp [shiftMap, inverseShiftMap, shift_three]

/-- G o F = id。 -/
theorem inverseShiftMap_comp_shiftMap : inverseShiftMap ∘ shiftMap = id := by
  funext x v
  simp [shiftMap, inverseShiftMap, shift_three]

/-- `claim_three_cell_cyclic_shift_reversible`: F は単射である。 -/
theorem shiftMap_injective : Function.Injective shiftMap := by
  intro x y hxy
  funext v
  have h := congrFun hxy (shift (shift v))
  simpa [shiftMap, shift_three] using h

/-- F は固定近傍で表せる大域写像である。 -/
theorem shiftMap_mem_stageGlobalMaps : shiftMap ∈ stageGlobalMaps nbhd := by
  classical
  rw [stageGlobalMaps]
  exact Finset.mem_image.mpr ⟨shiftRules, Finset.mem_univ _, globalMap_shiftRules⟩

/-- 二回合成の a 座標写像 g_a。 -/
def twiceAtA (x : Cell → State) : State := (shiftMap (shiftMap x)) .a

/-- 人手証明の g_a(x)=x(c)。 -/
theorem twiceAtA_eq (x : Cell → State) : twiceAtA x = x .c := by
  rfl

/-- 定値零配位。 -/
def zeroConfig : Cell → State := fun _ => .zero

/-- x_0 と phi_c(x_0) は g_a の値を変える。 -/
theorem twiceAtA_zero_ne_flip :
    twiceAtA zeroConfig ≠ twiceAtA (flip .c zeroConfig) := by
  decide

/-- c は g_a の本質的依存台に属する。 -/
theorem cellC_mem_twiceAtA_supp : Cell.c ∈ supp twiceAtA := by
  rw [mem_supp_iff, essentialDep_iff_flip]
  exact ⟨zeroConfig, twiceAtA_zero_ne_flip⟩

/-- c は a の固定近傍 {b} の外にある。 -/
theorem cellC_not_mem_nbhdA : Cell.c ∉ nbhd Cell.a := by
  decide

/-- 二回合成の a 座標写像は N(a) 上では表せない。 -/
theorem twiceAtA_not_representable : ¬ Representable (nbhd Cell.a) twiceAtA := by
  intro hrep
  have hsub := representable_implies_supp_subset (nbhd Cell.a) twiceAtA hrep
  exact cellC_not_mem_nbhdA (hsub cellC_mem_twiceAtA_supp)

/-- `claim_fixed_neighborhood_reversible_maps_not_composition_closed` の核心:
    F o F を同じ固定近傍上の局所規則族では表せない。 -/
theorem shiftMap_comp_not_representable :
    ¬ ∃ f : LocalRuleFamily nbhd, globalMap nbhd f = shiftMap ∘ shiftMap := by
  rintro ⟨f, hf⟩
  apply twiceAtA_not_representable
  refine ⟨f Cell.a, ?_⟩
  intro x
  have h := congrFun (congrFun hf x) Cell.a
  exact h.symm

/-- したがって F o F は M(V,N) に属さない。 -/
theorem shiftMap_comp_not_mem_stageGlobalMaps :
    shiftMap ∘ shiftMap ∉ stageGlobalMaps nbhd := by
  classical
  intro hmem
  rw [stageGlobalMaps] at hmem
  obtain ⟨f, -, hf⟩ := Finset.mem_image.mp hmem
  exact shiftMap_comp_not_representable ⟨f, hf⟩

/-- 固定近傍で表せる可逆大域写像族は合成で閉じない。 -/
theorem reversible_stage_maps_not_composition_closed :
    ∃ F, F ∈ stageGlobalMaps nbhd ∧ Function.Injective F ∧
      F ∘ F ∉ stageGlobalMaps nbhd :=
  ⟨shiftMap, shiftMap_mem_stageGlobalMaps, shiftMap_injective,
    shiftMap_comp_not_mem_stageGlobalMaps⟩


/-! ### 必要十分版からの導出

添字型を `Cell`、状態型を `State`、ν を `nu`、基準値を `State.zero`、
s を `shift`、s の右逆写像 t を `fun v => shift (shift v)`、v₀ を `Cell.a` に特殊化する。
有限性を使うのは、大域写像全体 `stageGlobalMaps` を有限集合として集める最後の段だけである。 -/

namespace Derivation


/-- 具体版の近傍は、必要十分版の近傍を s := shift に特殊化したものである。 -/
theorem nbhd_eq :
    nbhd = _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.shiftNbhd shift :=
  rfl

/-- 具体版の座標送り写像は、必要十分版の座標送り写像の特殊化である。 -/
theorem shiftMap_eq : (shiftMap : (Cell → State) → Cell → State) = _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.shiftMap shift := rfl

/-- 具体版の「局所規則族の大域写像が F に一致する」は必要十分版の特殊化である。 -/
theorem globalMap_shiftRules_of_necSuf : globalMap nbhd shiftRules = shiftMap :=
  _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.globalMap_shiftRules (A := State) shift

/-- 具体版の単射性は、s の右逆写像 t := s ∘ s を取った必要十分版の特殊化である。 -/
theorem shiftMap_injective_of_necSuf : Function.Injective shiftMap :=
  _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.shiftMap_injective (A := State) shift (fun v => shift (shift v))
    (fun v => shift_three v)

/-- 具体版の両側逆写像は、必要十分版の二つの合成条件の特殊化である。 -/
theorem shiftMap_comp_inverseShiftMap_of_necSuf : shiftMap ∘ inverseShiftMap = id :=
  _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.shiftMap_comp_left (A := State) shift (fun v => shift (shift v))
    (fun v => shift_three v)

theorem inverseShiftMap_comp_shiftMap_of_necSuf : inverseShiftMap ∘ shiftMap = id :=
  _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.shiftMap_comp_right (A := State) shift (fun v => shift (shift v))
    (fun v => shift_three v)

/-- 具体版の「c は g_a の本質的依存台に属する」は、必要十分版の本質的依存を
    ν := nu、基準値 := zero に特殊化し、依存台の所属へ言い換えて得られる。 -/
theorem cellC_mem_twiceAtA_supp_of_necSuf : Cell.c ∈ supp twiceAtA := by
  have h := _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.twiceCellMap_essentialDep nu ne_iff_eq_nu State.zero shift Cell.a
  exact (mem_supp_iff twiceAtA Cell.c).mpr h

/-- 具体版の表現不能は、必要十分版を「読む添字が近傍の外にある」条件
    s (s a) = c ≠ b = s a のもとで特殊化して得られる。 -/
theorem twiceAtA_not_representable_of_necSuf : ¬ Representable (nbhd Cell.a) twiceAtA :=
  _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.twiceCellMap_not_representable nu ne_iff_eq_nu State.zero shift Cell.a
    (by decide)

/-- 具体版の「F ∘ F を同じ固定近傍の局所規則族では表せない」は必要十分版の特殊化である。 -/
theorem shiftMap_comp_not_representable_of_necSuf :
    ¬ ∃ f : LocalRuleFamily nbhd, globalMap nbhd f = shiftMap ∘ shiftMap :=
  _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.shiftMap_comp_not_globalMap nu ne_iff_eq_nu State.zero shift Cell.a (by decide)

/-- 具体版の最終主張は、必要十分版の合成非閉性に有限性を足して
    大域写像全体を有限集合として集めたものである。 -/
theorem reversible_stage_maps_not_composition_closed_of_necSuf :
    ∃ F, F ∈ stageGlobalMaps nbhd ∧ Function.Injective F ∧
      F ∘ F ∉ stageGlobalMaps nbhd := by
  classical
  obtain ⟨F, ⟨f, hf⟩, hinj, hnot⟩ :=
    _root_.CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure.reversible_fixed_neighborhood_not_composition_closed
      nu ne_iff_eq_nu State.zero shift (fun v => shift (shift v))
      (fun v => shift_three v) Cell.a (by decide)
  refine ⟨F, ?_, hinj, ?_⟩
  · rw [stageGlobalMaps]
    exact Finset.mem_image.mpr ⟨f, Finset.mem_univ _, hf⟩
  · intro hmem
    rw [stageGlobalMaps] at hmem
    obtain ⟨g, -, hg⟩ := Finset.mem_image.mp hmem
    exact hnot ⟨g, hg⟩

end Derivation

end CellularAutomata.FixedNeighborhoodCompositionNonclosure
