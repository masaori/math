/-
章「安定ファイバーの最小前周期層」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-stable-fiber-depth.ts。

最小前周期層、一意な層分割、一段発展による正の層の降下、層別個数の
有限走査を人手証明と同じ対象・仮定・順序で形式化する。
有限集合・自然数・写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidStableFiberDynamics
import CellularAutomata.MinimalPreperiodPeriod
import CellularAutomata.NecSuf.IterateMonoidStableFiberDepth

namespace CellularAutomata.IterateMonoidStableFiberDepth

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.MinimalPreperiodPeriod
open CellularAutomata.IterateMonoidCycleIdempotent
open CellularAutomata.IterateMonoidStableImage
open CellularAutomata.IterateMonoidStablePartition
open CellularAutomata.IterateMonoidStableFiberDynamics

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- `L_F(q,k) := {y ∈ B_F(q) | μ(y) = k}`。 -/
def stableFiberDepthLayer (q : stableImage N f) (k : ℕ) : Set (V → State) :=
  {y | y ∈ stableFiber N f q ∧ minPreperiod N f y = k}

/-- 最小前周期層を全配位から有限走査した表。 -/
noncomputable def stableFiberDepthLayerTable (q : stableImage N f) (k : ℕ) :
    Finset (V → State) :=
  (stableFiberTable N f q).filter (fun y => minPreperiod N f y = k)

theorem mem_stableFiberDepthLayerTable_iff
    (q : stableImage N f) (k : ℕ) (y : V → State) :
    y ∈ stableFiberDepthLayerTable N f q k ↔ y ∈ stableFiberDepthLayer N f q k := by
  simp [stableFiberDepthLayerTable, stableFiberDepthLayer, mem_stableFiberTable_iff]

/-- 各安定ファイバーの元は、最小前周期が添字であるただ一つの層に属する。 -/
theorem existsUnique_mem_stableFiberDepthLayer
    (q : stableImage N f) (y : V → State) (hy : y ∈ stableFiber N f q) :
    ∃! k : ℕ, y ∈ stableFiberDepthLayer N f q k := by
  refine ⟨minPreperiod N f y, ⟨hy, rfl⟩, ?_⟩
  intro k hk
  exact hk.2.symm

/-- 異なる最小前周期層は交わらない。 -/
theorem distinct_stableFiberDepthLayers_disjoint
    (q : stableImage N f) {k l : ℕ} (hkl : k ≠ l) :
    stableFiberDepthLayer N f q k ∩ stableFiberDepthLayer N f q l = ∅ := by
  ext y
  constructor
  · rintro ⟨⟨_hyq, hyk⟩, _hylq, hyl⟩
    exact (hkl (hyk.symm.trans hyl)).elim
  · simp

/-- `F^n(F(y)) = F^{n+1}(y)`。人手証明で二度使う反復の定義。 -/
theorem iterate_globalMap (n : ℕ) (y : V → State) :
    iterate N f n (globalMap N f y) = iterate N f (n + 1) y := by
  induction n with
  | zero => rfl
  | succ n ih =>
      exact congrArg (globalMap N f) ih

/-- `μ(y)>0` ならば一段発展で最小前周期はちょうど一つ減る。 -/
theorem minPreperiod_globalMap_eq_sub_one
    (y : V → State) (hpos : 0 < minPreperiod N f y) :
    minPreperiod N f (globalMap N f y) = minPreperiod N f y - 1 := by
  let m := minPreperiod N f y
  let p := minPeriod N f y
  have hmpos : 0 < m := by simpa [m] using hpos
  have hmp : IsPeriodicityPair N f y m p := minPeriod_spec N f y
  have hfirstPair : IsPeriodicityPair N f (globalMap N f y) (m - 1) p := by
    refine ⟨hmp.1, ?_⟩
    intro n hn
    have hn1 : m ≤ n + 1 := by omega
    have h := hmp.2 (n + 1) hn1
    calc
      iterate N f (n + p) (globalMap N f y) =
          iterate N f (n + p + 1) y := iterate_globalMap N f (n + p) y
      _ = iterate N f (n + 1 + p) y := by congr 1 <;> omega
      _ = iterate N f (n + 1) y := h
      _ = iterate N f n (globalMap N f y) := (iterate_globalMap N f n y).symm
  have hupper : minPreperiod N f (globalMap N f y) ≤ m - 1 :=
    minPreperiod_le N f (globalMap N f y) ⟨p, hfirstPair⟩
  let j := minPreperiod N f (globalMap N f y)
  let r := minPeriod N f (globalMap N f y)
  have hjupper : j ≤ m - 1 := by simpa [j] using hupper
  have hjr : IsPeriodicityPair N f (globalMap N f y) j r :=
    minPeriod_spec N f (globalMap N f y)
  have hsecondPair : IsPeriodicityPair N f y (j + 1) r := by
    refine ⟨hjr.1, ?_⟩
    intro n hn
    have hnsub : j ≤ n - 1 := by omega
    have h := hjr.2 (n - 1) hnsub
    calc
      iterate N f (n + r) y = iterate N f (n - 1 + r + 1) y := by congr 1 <;> omega
      _ = iterate N f (n - 1 + r) (globalMap N f y) :=
        (iterate_globalMap N f (n - 1 + r) y).symm
      _ = iterate N f (n - 1) (globalMap N f y) := h
      _ = iterate N f (n - 1 + 1) y := iterate_globalMap N f (n - 1) y
      _ = iterate N f n y := by congr 1 <;> omega
  have hlower : m ≤ j + 1 := minPreperiod_le N f y ⟨r, hsecondPair⟩
  change j = m - 1
  omega

/-- 一段発展は正の層を一つ下の次ファイバーへ写す。 -/
theorem globalMap_mem_next_depthLayer
    (q : stableImage N f) {k : ℕ} (hk : 0 < k) (y : V → State)
    (hy : y ∈ stableFiberDepthLayer N f q k) :
    globalMap N f y ∈ stableFiberDepthLayer N f (stableIndexMap N f q) (k - 1) := by
  refine ⟨(globalMap_mem_stableFiber_index_iff N f q y).2 hy.1, ?_⟩
  rw [minPreperiod_globalMap_eq_sub_one N f y (hy.2.symm ▸ hk), hy.2]

theorem globalMap_image_depthLayer_subset
    (q : stableImage N f) {k : ℕ} (hk : 0 < k) :
    globalMap N f '' stableFiberDepthLayer N f q k ⊆
      stableFiberDepthLayer N f (stableIndexMap N f q) (k - 1) := by
  rintro z ⟨y, hy, rfl⟩
  exact globalMap_mem_next_depthLayer N f q hk y hy

/-- 各ファイバーは `0,…,2^{|V|}` の層の有限走査で個数分解される。 -/
theorem stableFiberTable_card_eq_sum_depthLayerTable (q : stableImage N f) :
    (stableFiberTable N f q).card =
      ∑ k ∈ Finset.range (2 ^ Fintype.card V + 1),
        (stableFiberDepthLayerTable N f q k).card := by
  classical
  have hmaps : ∀ y ∈ stableFiberTable N f q,
      minPreperiod N f y ∈ Finset.range (2 ^ Fintype.card V + 1) := by
    intro y _hy
    have hbound := minPreperiod_add_minPeriod_le N f y
    simp only [Finset.mem_range]
    omega
  rw [Finset.card_eq_sum_card_fiberwise hmaps]
  apply Finset.sum_congr rfl
  intro k _hk
  rfl

/-- 全層とその個数を有限集合として列挙する。 -/
noncomputable def stableFiberDepthDataTable :
    Finset (stableImage N f × ℕ × Finset (V → State) × ℕ) :=
  Finset.univ.biUnion fun q =>
    (Finset.range (2 ^ Fintype.card V + 1)).image fun k =>
      (q, k, stableFiberDepthLayerTable N f q k,
        (stableFiberDepthLayerTable N f q k).card)

/-! ## 必要十分版からの導出 -/

theorem existsUnique_mem_stableFiberDepthLayer_from_necessary_sufficient
    (q : stableImage N f) (y : V → State) (hy : y ∈ stableFiber N f q) :
    ∃! k : ℕ, y ∈ stableFiberDepthLayer N f q k := by
  change ∃! k : ℕ, y ∈
    CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.depthLayer
      (cycleIdempotent N f) (minPreperiod N f) q k
  exact CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.existsUnique_mem_depthLayer
    (cycleIdempotent N f) (minPreperiod N f) q y hy

theorem distinct_stableFiberDepthLayers_disjoint_from_necessary_sufficient
    (q : stableImage N f) {k l : ℕ} (hkl : k ≠ l) :
    stableFiberDepthLayer N f q k ∩ stableFiberDepthLayer N f q l = ∅ := by
  change
    CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.depthLayer
        (cycleIdempotent N f) (minPreperiod N f) q k ∩
      CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.depthLayer
        (cycleIdempotent N f) (minPreperiod N f) q l = ∅
  exact CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.distinct_depthLayers_disjoint
    (cycleIdempotent N f) (minPreperiod N f) q hkl

theorem minPreperiod_globalMap_eq_sub_one_from_necessary_sufficient
    (y : V → State) (hpos : 0 < minPreperiod N f y) :
    minPreperiod N f (globalMap N f y) = minPreperiod N f y - 1 := by
  have hpos' : 0 < CellularAutomata.NecSuf.MinimalPreperiodPeriod.minPreperiod
      (globalMap N f) y := by
    rwa [← minPreperiod_eq_necessary_sufficient N f y]
  have h := CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.minPreperiod_map_eq_sub_one
    (globalMap N f) y hpos'
  rw [← minPreperiod_eq_necessary_sufficient N f (globalMap N f y),
    ← minPreperiod_eq_necessary_sufficient N f y] at h
  exact h

theorem globalMap_mem_next_depthLayer_from_necessary_sufficient
    (q : stableImage N f) {k : ℕ} (hk : 0 < k) (y : V → State)
    (hy : y ∈ stableFiberDepthLayer N f q k) :
    globalMap N f y ∈ stableFiberDepthLayer N f (stableIndexMap N f q) (k - 1) := by
  refine ⟨(globalMap_mem_stableFiber_index_iff_from_necessary_sufficient N f q y).2 hy.1, ?_⟩
  rw [minPreperiod_globalMap_eq_sub_one_from_necessary_sufficient N f y
    (hy.2.symm ▸ hk), hy.2]

theorem globalMap_image_depthLayer_subset_from_necessary_sufficient
    (q : stableImage N f) {k : ℕ} (hk : 0 < k) :
    globalMap N f '' stableFiberDepthLayer N f q k ⊆
      stableFiberDepthLayer N f (stableIndexMap N f q) (k - 1) := by
  rintro z ⟨y, hy, rfl⟩
  exact globalMap_mem_next_depthLayer_from_necessary_sufficient N f q hk y hy

theorem stableFiberTable_card_eq_sum_depthLayerTable_from_necessary_sufficient
    (q : stableImage N f) :
    (stableFiberTable N f q).card =
      ∑ k ∈ Finset.range (2 ^ Fintype.card V + 1),
        (stableFiberDepthLayerTable N f q k).card := by
  classical
  apply CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.card_eq_sum_depthLayerTable
  intro y _hy
  have hbound := minPreperiod_add_minPeriod_le_from_necessary_sufficient N f y
  simp only [Finset.mem_range]
  omega

end CellularAutomata.IterateMonoidStableFiberDepth
