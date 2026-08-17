/-
章「安定ファイバーの層別分岐個数」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-stable-fiber-layer-branching.ts。

有限部分集合の完全逆像の分解、正の層と零層の個数保存、および
有限走査を人手証明と同じ順序で形式化する。有限集合・自然数・
写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidStableFiberBranching
import CellularAutomata.IterateMonoidStableFiberLayerPreimage
import CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching

namespace CellularAutomata.IterateMonoidStableFiberLayerBranching

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.MinimalPreperiodPeriod
open CellularAutomata.IterateMonoidStableImage
open CellularAutomata.IterateMonoidStablePartition
open CellularAutomata.IterateMonoidStableFiberDynamics
open CellularAutomata.IterateMonoidStableFiberBranching
open CellularAutomata.IterateMonoidStableFiberDepth
open CellularAutomata.IterateMonoidStableFiberLayerPreimage

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 有限部分集合 `T` の完全逆像を全配位から走査した表。 -/
noncomputable def subsetPreimageTable (T : Finset (V → State)) : Finset (V → State) :=
  Finset.univ.filter fun y => globalMap N f y ∈ T

/-- 有限部分集合 `T` に属する各元の一段前像表の合併。 -/
noncomputable def subsetPredecessorUnionTable
    (T : Finset (V → State)) : Finset (V → State) :=
  T.biUnion (predecessorTable N f)

/-- 有限部分集合の完全逆像は各元の一段前像集合へ分解される。 -/
theorem subsetPreimageTable_eq_subsetPredecessorUnionTable
    (T : Finset (V → State)) :
    subsetPreimageTable N f T = subsetPredecessorUnionTable N f T := by
  classical
  ext y
  simp [subsetPreimageTable, subsetPredecessorUnionTable,
    mem_predecessorTable_iff, predecessorSet]

/-- 一段前像表は相異なる目標配位について対ごとに非交差である。 -/
theorem predecessorTables_pairwiseDisjoint (T : Finset (V → State)) :
    ((T : Finset (V → State)) : Set (V → State)).PairwiseDisjoint
      (predecessorTable N f) := by
  intro z _hz w _hw hzw
  change Disjoint (predecessorTable N f z) (predecessorTable N f w)
  rw [Finset.disjoint_left]
  intro y hyz hyw
  apply hzw
  exact ((mem_predecessorTable_iff N f z y).1 hyz).symm.trans
    ((mem_predecessorTable_iff N f w y).1 hyw)

/-- 正の層へ流れ込む一段前像数は一つ上の層の個数に等しい。 -/
theorem positive_depthLayer_predecessorCount
    (q : stableImage N f) (k : ℕ) (hk : 0 < k) :
    (stableFiberDepthLayerTable N f q (k + 1)).card =
      ∑ z ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) k,
        predecessorCount N f z := by
  classical
  let T := stableFiberDepthLayerTable N f (stableIndexMap N f q) k
  calc
    (stableFiberDepthLayerTable N f q (k + 1)).card =
        (subsetPreimageTable N f T).card := by
      apply congrArg Finset.card
      ext y
      rw [mem_stableFiberDepthLayerTable_iff]
      simp only [subsetPreimageTable, Finset.mem_filter, Finset.mem_univ, true_and]
      rw [mem_stableFiberDepthLayerTable_iff]
      exact Set.ext_iff.mp (positive_depthLayer_exact_preimage N f q k hk) y |>.symm
    _ = (subsetPredecessorUnionTable N f T).card := by
      rw [subsetPreimageTable_eq_subsetPredecessorUnionTable]
    _ = ∑ z ∈ T, (predecessorTable N f z).card := by
      exact Finset.card_biUnion (predecessorTables_pairwiseDisjoint N f T)
    _ = ∑ z ∈ T, predecessorCount N f z := by
      apply Finset.sum_congr rfl
      intro z _hz
      rfl

/-- 零層へ流れ込む一段前像数は零層と一層の個数の和に等しい。 -/
theorem zero_depthLayer_predecessorCount (q : stableImage N f) :
    (stableFiberDepthLayerTable N f q 0).card +
        (stableFiberDepthLayerTable N f q 1).card =
      ∑ z ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) 0,
        predecessorCount N f z := by
  classical
  let Z := stableFiberDepthLayerTable N f q 0
  let O := stableFiberDepthLayerTable N f q 1
  let T := stableFiberDepthLayerTable N f (stableIndexMap N f q) 0
  have hdisjoint : Disjoint Z O := by
    rw [Finset.disjoint_left]
    intro y hyz hyo
    have hyz' := (mem_stableFiberDepthLayerTable_iff N f q 0 y).1 hyz
    have hyo' := (mem_stableFiberDepthLayerTable_iff N f q 1 y).1 hyo
    exact Nat.zero_ne_one (hyz'.2.symm.trans hyo'.2)
  calc
    Z.card + O.card = (Z ∪ O).card := (Finset.card_union_of_disjoint hdisjoint).symm
    _ = (subsetPreimageTable N f T).card := by
      apply congrArg Finset.card
      ext y
      simp only [Finset.mem_union]
      rw [mem_stableFiberDepthLayerTable_iff, mem_stableFiberDepthLayerTable_iff]
      simp only [subsetPreimageTable, Finset.mem_filter, Finset.mem_univ, true_and]
      rw [mem_stableFiberDepthLayerTable_iff]
      exact Set.ext_iff.mp (zero_depthLayer_exact_preimage N f q) y |>.symm
    _ = (subsetPredecessorUnionTable N f T).card := by
      rw [subsetPreimageTable_eq_subsetPredecessorUnionTable]
    _ = ∑ z ∈ T, (predecessorTable N f z).card := by
      exact Finset.card_biUnion (predecessorTables_pairwiseDisjoint N f T)
    _ = ∑ z ∈ T, predecessorCount N f z := by
      apply Finset.sum_congr rfl
      intro z _hz
      rfl

/-- 全ての層別分岐個数と、比較する層の個数を有限列挙する。 -/
noncomputable def depthLayerBranchingDataTable :
    Finset (stableImage N f × ℕ × ℕ × ℕ) :=
  Finset.univ.biUnion fun q =>
    (Finset.range (2 ^ Fintype.card V + 1)).image fun k =>
      (q, k,
        (stableFiberDepthLayerTable N f q k).card,
        ∑ z ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) k,
          predecessorCount N f z)

theorem mem_depthLayerBranchingDataTable_iff
    (q : stableImage N f) (k layerCard branchingTotal : ℕ) :
    (q, k, layerCard, branchingTotal) ∈ depthLayerBranchingDataTable N f ↔
      k < 2 ^ Fintype.card V + 1 ∧
      layerCard = (stableFiberDepthLayerTable N f q k).card ∧
      branchingTotal =
        ∑ z ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) k,
          predecessorCount N f z := by
  classical
  simp [depthLayerBranchingDataTable, eq_comm]

/-! ## 必要十分版からの導出 -/

/-- 層の有限走査表は必要十分版の層表の特殊化である。 -/
theorem stableFiberDepthLayerTable_eq_necessary_sufficient
    (q : stableImage N f) (k : ℕ) :
    stableFiberDepthLayerTable N f q k =
      CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.fiberDepthLayerTable
        (stableFiber N f) (minPreperiod N f) q k := by
  ext y
  rw [mem_stableFiberDepthLayerTable_iff,
    CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.mem_fiberDepthLayerTable_iff]
  exact Iff.rfl

/-- 層別分岐総和は必要十分版の総和の特殊化である。 -/
theorem depthLayerBranchingTotal_eq_necessary_sufficient
    (q : stableImage N f) (k : ℕ) :
    ∑ z ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) k,
        predecessorCount N f z =
      ∑ z ∈ CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.fiberDepthLayerTable
          (stableFiber N f) (minPreperiod N f) (stableIndexMap N f q) k,
        CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorCount
          (globalMap N f) z := by
  rw [stableFiberDepthLayerTable_eq_necessary_sufficient]
  exact Finset.sum_congr rfl fun z _hz => predecessorCount_eq_necessary_sufficient N f z

theorem subsetPreimageTable_eq_subsetPredecessorUnionTable_from_necessary_sufficient
    (T : Finset (V → State)) :
    subsetPreimageTable N f T = subsetPredecessorUnionTable N f T := by
  classical
  have hAT : ∀ y, y ∈ subsetPreimageTable N f T ↔ globalMap N f y ∈ T := by
    intro y
    simp [subsetPreimageTable]
  calc
    subsetPreimageTable N f T =
        CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorUnionTable
          (globalMap N f) T :=
      (CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorUnionTable_eq
        (globalMap N f) (subsetPreimageTable N f T) T hAT).symm
    _ = subsetPredecessorUnionTable N f T := by
      unfold CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorUnionTable
        subsetPredecessorUnionTable
      apply Finset.biUnion_congr rfl
      intro z _hz
      exact (predecessorTable_eq_necessary_sufficient N f z).symm

theorem predecessorTables_pairwiseDisjoint_from_necessary_sufficient
    (T : Finset (V → State)) :
    ((T : Finset (V → State)) : Set (V → State)).PairwiseDisjoint
      (predecessorTable N f) := by
  have hfun : predecessorTable N f =
      CellularAutomata.NecSuf.IterateMonoidStableFiberBranching.predecessorTable
        (globalMap N f) :=
    funext fun z => predecessorTable_eq_necessary_sufficient N f z
  rw [hfun]
  exact CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.predecessorTables_pairwiseDisjoint
    (globalMap N f) T

theorem positive_depthLayer_predecessorCount_from_necessary_sufficient
    (q : stableImage N f) (k : ℕ) (hk : 0 < k) :
    (stableFiberDepthLayerTable N f q (k + 1)).card =
      ∑ z ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) k,
        predecessorCount N f z := by
  rw [stableFiberDepthLayerTable_eq_necessary_sufficient,
    depthLayerBranchingTotal_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.positive_fiberDepthLayerTable_card
    (globalMap N f) (stableFiber N f) (minPreperiod N f) (stableIndexMap N f)
    (fun q y => globalMap_mem_stableFiber_index_iff_from_necessary_sufficient N f q y)
    (fun y => minPreperiod_globalMap_eq_zero_from_necessary_sufficient N f y)
    (fun y => minPreperiod_globalMap_eq_sub_one_from_necessary_sufficient N f y)
    q k hk

theorem zero_depthLayer_predecessorCount_from_necessary_sufficient
    (q : stableImage N f) :
    (stableFiberDepthLayerTable N f q 0).card +
        (stableFiberDepthLayerTable N f q 1).card =
      ∑ z ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) 0,
        predecessorCount N f z := by
  rw [stableFiberDepthLayerTable_eq_necessary_sufficient N f q 0,
    stableFiberDepthLayerTable_eq_necessary_sufficient N f q 1,
    depthLayerBranchingTotal_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.zero_fiberDepthLayerTable_card
    (globalMap N f) (stableFiber N f) (minPreperiod N f) (stableIndexMap N f)
    (fun q y => globalMap_mem_stableFiber_index_iff_from_necessary_sufficient N f q y)
    (fun y => minPreperiod_globalMap_eq_zero_from_necessary_sufficient N f y)
    (fun y => minPreperiod_globalMap_eq_sub_one_from_necessary_sufficient N f y)
    q

theorem mem_depthLayerBranchingDataTable_iff_from_necessary_sufficient
    (q : stableImage N f) (k layerCard branchingTotal : ℕ) :
    (q, k, layerCard, branchingTotal) ∈ depthLayerBranchingDataTable N f ↔
      k < 2 ^ Fintype.card V + 1 ∧
      layerCard = (stableFiberDepthLayerTable N f q k).card ∧
      branchingTotal =
        ∑ z ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) k,
          predecessorCount N f z := by
  classical
  have htable : depthLayerBranchingDataTable N f =
      CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.layerBranchingDataTable
        (globalMap N f) (stableFiber N f) (minPreperiod N f) (stableIndexMap N f)
        (Finset.range (2 ^ Fintype.card V + 1)) := by
    unfold depthLayerBranchingDataTable
      CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.layerBranchingDataTable
    apply Finset.biUnion_congr rfl
    intro q _hq
    apply Finset.image_congr
    intro k _hk
    dsimp only
    rw [stableFiberDepthLayerTable_eq_necessary_sufficient,
      depthLayerBranchingTotal_eq_necessary_sufficient]
  rw [htable,
    CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching.mem_layerBranchingDataTable_iff,
    Finset.mem_range,
    ← depthLayerBranchingTotal_eq_necessary_sufficient,
    ← stableFiberDepthLayerTable_eq_necessary_sufficient]

end CellularAutomata.IterateMonoidStableFiberLayerBranching
