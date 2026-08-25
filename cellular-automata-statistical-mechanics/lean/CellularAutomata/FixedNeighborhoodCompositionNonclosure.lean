/-
章「固定近傍による可逆大域写像族の合成非閉性」の Lean 具体版。
人手証明の正本は structured-latex/content/stage-reversible-composition-nonclosure.ts。

3 セルの巡回依存舞台、座標送り写像、その両側逆写像、二回合成の近傍外依存、
固定近傍での表現不能を、人手証明と同じ対象・仮定・順序で形式化する。
有限型・有限部分集合・写像だけを使い、R / C は現れない。

必要十分版と、具体版がその特殊化であることの導出は次の層で扱う。
-/
import CellularAutomata.LocalRuleRepresentation
import CellularAutomata.LocalityRestrictsCycleType

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

end CellularAutomata.FixedNeighborhoodCompositionNonclosure
