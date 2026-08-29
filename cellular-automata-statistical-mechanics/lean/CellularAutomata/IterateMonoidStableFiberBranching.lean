/-
章「安定ファイバー間の分岐個数」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-stable-fiber-predecessor-count.ts。

一段前像集合、その非交差、安定ファイバーの完全逆像の分解、個数保存、
有限走査を人手証明と同じ順序で形式化する。
有限集合・自然数・写像の等号だけを使い、R / C は使わない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import CellularAutomata.IterateMonoidStableFiberDynamics
import CellularAutomata.NecSuf.IterateMonoidStableFiberBranching

namespace CellularAutomata.IterateMonoidStableFiberBranching

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoidStableImage
open CellularAutomata.IterateMonoidStablePartition
open CellularAutomata.IterateMonoidStableFiberDynamics

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- `Pre_F(z) := {y | F(y) = z}`。 -/
def predecessorSet (z : V → State) : Set (V → State) :=
  {y | globalMap N f y = z}

/-- `Pre_F(z)` を全配位から有限走査した表。 -/
noncomputable def predecessorTable (z : V → State) : Finset (V → State) :=
  Finset.univ.filter (fun y => globalMap N f y = z)

theorem mem_predecessorTable_iff (z y : V → State) :
    y ∈ predecessorTable N f z ↔ y ∈ predecessorSet N f z := by
  simp [predecessorTable, predecessorSet]

/-- `b_F(z) := |Pre_F(z)|`。 -/
noncomputable def predecessorCount (z : V → State) : ℕ :=
  (predecessorTable N f z).card

/-- 異なる配位の一段前像集合は交わらない。 -/
theorem distinct_predecessorSets_disjoint
    {z w : V → State} (hzw : z ≠ w) :
    predecessorSet N f z ∩ predecessorSet N f w = ∅ := by
  ext y
  constructor
  · rintro ⟨hyz, hyw⟩
    exact (hzw (hyz.symm.trans hyw)).elim
  · simp

/-- 安定ファイバーの完全逆像は、一段前像集合の有限合併に分解される。 -/
theorem stableFiber_preimage_eq_iUnion (q : stableImage N f) :
    globalMap N f ⁻¹' stableFiber N f (stableIndexMap N f q) =
      ⋃ z ∈ stableFiber N f (stableIndexMap N f q), predecessorSet N f z := by
  ext y
  constructor
  · intro hy
    exact Set.mem_iUnion_of_mem (globalMap N f y)
      (Set.mem_iUnion_of_mem hy (by rfl))
  · intro hy
    simp only [Set.mem_iUnion] at hy
    obtain ⟨z, hz⟩ := hy
    obtain ⟨hzTarget, hyz⟩ := hz
    change globalMap N f y = z at hyz
    simpa [hyz] using hzTarget

/-- 目標ファイバーの `z` に対し、全配位で取った前像表は元ファイバー内の fiber と一致する。 -/
theorem predecessorTable_eq_source_fiber
    (q : stableImage N f) (z : V → State)
    (hz : z ∈ stableFiberTable N f (stableIndexMap N f q)) :
    predecessorTable N f z =
      (stableFiberTable N f q).filter (fun y => globalMap N f y = z) := by
  ext y
  simp only [predecessorTable, Finset.mem_filter, Finset.mem_univ, true_and]
  constructor
  · intro hyz
    refine ⟨(mem_stableFiberTable_iff N f q y).2 ?_, hyz⟩
    apply (globalMap_mem_stableFiber_index_iff N f q y).1
    rw [hyz]
    exact (mem_stableFiberTable_iff N f (stableIndexMap N f q) z).1 hz
  · exact fun hy => hy.2

/-- 人手証明の有限合併をそのまま表す走査表。 -/
noncomputable def predecessorUnionTable (q : stableImage N f) : Finset (V → State) :=
  (stableFiberTable N f (stableIndexMap N f q)).biUnion (predecessorTable N f)

/-- 有限合併の表は完全逆像の有限走査表に一致する。 -/
theorem predecessorUnionTable_eq_preimageTable (q : stableImage N f) :
    predecessorUnionTable N f q = stableFiberPreimageTable N f q := by
  classical
  ext y
  simp only [predecessorUnionTable, Finset.mem_biUnion, mem_predecessorTable_iff,
    predecessorSet, stableFiberPreimageTable, Finset.mem_filter, Finset.mem_univ, true_and]
  constructor
  · rintro ⟨z, hz, hyz⟩
    rw [hyz]
    exact hz
  · intro hy
    exact ⟨globalMap N f y, hy, rfl⟩

/-- 一段前像数の総和は元の安定ファイバーの個数に等しい。 -/
theorem predecessorCount_conservation (q : stableImage N f) :
    (stableFiberTable N f q).card =
      ∑ z ∈ stableFiberTable N f (stableIndexMap N f q), predecessorCount N f z := by
  classical
  have hdisjoint :
      ((stableFiberTable N f (stableIndexMap N f q) : Finset (V → State)) :
          Set (V → State)).PairwiseDisjoint (predecessorTable N f) := by
    intro z _hz w _hw hzw
    change Disjoint (predecessorTable N f z) (predecessorTable N f w)
    rw [Finset.disjoint_left]
    intro y hyz hyw
    apply hzw
    exact ((mem_predecessorTable_iff N f z y).1 hyz).symm.trans
      ((mem_predecessorTable_iff N f w y).1 hyw)
  calc
    (stableFiberTable N f q).card =
        (stableFiberPreimageTable N f q).card := by
      apply congrArg Finset.card
      ext y
      exact (mem_stableFiberTable_iff N f q y).trans
        (mem_stableFiberPreimageTable_iff N f q y).symm
    _ = (predecessorUnionTable N f q).card := by
      rw [predecessorUnionTable_eq_preimageTable]
    _ = ∑ z ∈ stableFiberTable N f (stableIndexMap N f q),
          (predecessorTable N f z).card := by
      exact Finset.card_biUnion hdisjoint
    _ = ∑ z ∈ stableFiberTable N f (stableIndexMap N f q),
          predecessorCount N f z := by
      apply Finset.sum_congr rfl
      intro z _hz
      rfl

/-- 全ての一段前像集合と個数を有限集合として列挙する。 -/
noncomputable def predecessorDataTable :
    Finset ((V → State) × Finset (V → State) × ℕ) :=
  Finset.univ.image (fun z => (z, predecessorTable N f z, predecessorCount N f z))

theorem mem_predecessorDataTable_iff
    (z : V → State) (P : Finset (V → State)) (d : ℕ) :
    (z, P, d) ∈ predecessorDataTable N f ↔
      P = predecessorTable N f z ∧ d = predecessorCount N f z := by
  classical
  simp [predecessorDataTable, eq_comm]

/-! ## 必要十分版からの導出

具体版は必要十分版を X := Y := V → State、F := globalMap N f へ特殊化したものである。
非交差と完全逆像の分解は写像だけの一般層の特殊化、個数保存は
A := B(q), T := B(σ q) と前章の完全逆像（具体版の同値）を代入した特殊化である。 -/

section Derivation

/-- 前像集合は必要十分版の前像集合に一致する。 -/
theorem predecessorSet_eq_necessary_sufficient (z : V → State) :
    predecessorSet N f z =
      CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorSet
        (globalMap N f) z := rfl

/-- 前像表と一段前像数は必要十分版のものに一致する。 -/
theorem predecessorTable_eq_necessary_sufficient (z : V → State) :
    predecessorTable N f z =
      CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorTable
        (globalMap N f) z := rfl

theorem predecessorCount_eq_necessary_sufficient (z : V → State) :
    predecessorCount N f z =
      CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorCount
        (globalMap N f) z := rfl

/-- 非交差は写像だけの一般層の特殊化である。 -/
theorem distinct_predecessorSets_disjoint_from_necessary_sufficient
    {z w : V → State} (hzw : z ≠ w) :
    predecessorSet N f z ∩ predecessorSet N f w = ∅ :=
  CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.distinct_predecessorSets_disjoint
    (globalMap N f) hzw

/-- 完全逆像の分解は写像だけの一般層の特殊化である。 -/
theorem stableFiber_preimage_eq_iUnion_from_necessary_sufficient (q : stableImage N f) :
    globalMap N f ⁻¹' stableFiber N f (stableIndexMap N f q) =
      ⋃ z ∈ stableFiber N f (stableIndexMap N f q), predecessorSet N f z :=
  CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.preimage_eq_iUnion
    (globalMap N f) _

/-- 元ファイバーと次のファイバーの関係。具体版の完全逆像の同値から得る。 -/
theorem stableFiberTable_iff_next (q : stableImage N f) (y : V → State) :
    y ∈ stableFiberTable N f q ↔
      globalMap N f y ∈ stableFiberTable N f (stableIndexMap N f q) := by
  rw [mem_stableFiberTable_iff, mem_stableFiberTable_iff]
  exact (globalMap_mem_stableFiber_index_iff N f q y).symm

/-- 個数保存は必要十分版の個数保存の特殊化である。 -/
theorem predecessorCount_conservation_from_necessary_sufficient (q : stableImage N f) :
    (stableFiberTable N f q).card =
      ∑ z ∈ stableFiberTable N f (stableIndexMap N f q), predecessorCount N f z :=
  CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorCount_conservation
    (globalMap N f) _ _ (stableFiberTable_iff_next N f q)

end Derivation

end CellularAutomata.IterateMonoidStableFiberBranching
