/-
章「安定ファイバーの最小前周期層」の必要十分版。

具体版と同じ手順（一意な層分割、前周期・周期組を一段ずつ移す二方向、
正の層の降下、有限走査による個数分解）を保ち、実際に使う構造だけを残す。

* 最小前周期の一段減少には有限型 X と自己写像 F : X → X だけが要る。
* 層とその一意な分割には、安定ファイバーを定める自己写像 E と
  自然数値の深さ写像 μ だけが要る。反復・冪等性・有限性は要らない。
* 正の層の降下には、E と F のファイバー間移送、および深さの一段減少だけが要る。
* 有限走査には X の有限性と等号判定を要る。

二値状態、セル、近傍、局所規則、R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics
import CellularAutomata.NecSuf.MinimalPreperiodPeriod

namespace CellularAutomata.NecSuf.IterateMonoidStableFiberDepth

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.MinimalPreperiodPeriod
open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
open CellularAutomata.NecSuf.IterateMonoidCycleIdempotent
open CellularAutomata.NecSuf.IterateMonoidStablePartition
open CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics

/-! ## 一般層: ファイバーと深さ写像だけで成り立つ部分 -/

section GeneralLayer

variable {X Q : Type} (E : X → Q) (μ : X → ℕ)

def depthLayer (q : Q) (k : ℕ) : Set X :=
  {y | E y = q ∧ μ y = k}

theorem existsUnique_mem_depthLayer (q : Q) (y : X) (hy : E y = q) :
    ∃! k : ℕ, y ∈ depthLayer E μ q k := by
  refine ⟨μ y, ⟨hy, rfl⟩, ?_⟩
  intro k hk
  exact hk.2.symm

theorem distinct_depthLayers_disjoint (q : Q) {k l : ℕ} (hkl : k ≠ l) :
    depthLayer E μ q k ∩ depthLayer E μ q l = ∅ := by
  ext y
  constructor
  · rintro ⟨⟨_hyq, hyk⟩, _hylq, hyl⟩
    exact (hkl (hyk.symm.trans hyl)).elim
  · simp

end GeneralLayer

/-! ## 自己写像の一段発展で最小前周期が減る部分 -/

section Preperiod

variable {X : Type} [Fintype X] (F : X → X)

theorem iterate_map (n : ℕ) (y : X) :
    iterate F n (F y) = iterate F (n + 1) y := by
  induction n with
  | zero => rfl
  | succ n ih => exact congrArg F ih

theorem minPreperiod_map_eq_sub_one (y : X) (hpos : 0 < minPreperiod F y) :
    minPreperiod F (F y) = minPreperiod F y - 1 := by
  let m := minPreperiod F y
  let p := minPeriod F y
  have hmpos : 0 < m := by simpa [m] using hpos
  have hmp : IsPeriodicityPair F y m p := minPeriod_spec F y
  have hfirstPair : IsPeriodicityPair F (F y) (m - 1) p := by
    refine ⟨hmp.1, ?_⟩
    intro n hn
    have hn1 : m ≤ n + 1 := by omega
    have h := hmp.2 (n + 1) hn1
    calc
      iterate F (n + p) (F y) = iterate F (n + p + 1) y := iterate_map F (n + p) y
      _ = iterate F (n + 1 + p) y := by congr 1 <;> omega
      _ = iterate F (n + 1) y := h
      _ = iterate F n (F y) := (iterate_map F n y).symm
  have hupper : minPreperiod F (F y) ≤ m - 1 :=
    minPreperiod_le F (F y) ⟨p, hfirstPair⟩
  let j := minPreperiod F (F y)
  let r := minPeriod F (F y)
  have hjr : IsPeriodicityPair F (F y) j r := minPeriod_spec F (F y)
  have hsecondPair : IsPeriodicityPair F y (j + 1) r := by
    refine ⟨hjr.1, ?_⟩
    intro n hn
    have hnsub : j ≤ n - 1 := by omega
    have h := hjr.2 (n - 1) hnsub
    calc
      iterate F (n + r) y = iterate F (n - 1 + r + 1) y := by congr 1 <;> omega
      _ = iterate F (n - 1 + r) (F y) := (iterate_map F (n - 1 + r) y).symm
      _ = iterate F (n - 1) (F y) := h
      _ = iterate F (n - 1 + 1) y := iterate_map F (n - 1) y
      _ = iterate F n y := by congr 1 <;> omega
  have hlower : m ≤ j + 1 := minPreperiod_le F y ⟨r, hsecondPair⟩
  change j = m - 1
  omega

end Preperiod

/-! ## 反復層: 安定ファイバーの最小前周期層 -/

section Iterate

variable {X : Type} [Fintype X]
variable (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

def stableFiberDepthLayer
    (q : stableImage (cycleIdempotent F hex)) (k : ℕ) : Set X :=
  depthLayer (cycleIdempotent F hex) (minPreperiod F) q k

theorem existsUnique_mem_stableFiberDepthLayer
    (q : stableImage (cycleIdempotent F hex)) (y : X)
    (hy : y ∈ stableFiber (cycleIdempotent F hex) q) :
    ∃! k : ℕ, y ∈ stableFiberDepthLayer F hex q k :=
  existsUnique_mem_depthLayer (cycleIdempotent F hex) (minPreperiod F) q y hy

theorem distinct_stableFiberDepthLayers_disjoint
    (q : stableImage (cycleIdempotent F hex)) {k l : ℕ} (hkl : k ≠ l) :
    stableFiberDepthLayer F hex q k ∩ stableFiberDepthLayer F hex q l = ∅ :=
  distinct_depthLayers_disjoint (cycleIdempotent F hex) (minPreperiod F) q hkl

theorem map_mem_next_depthLayer
    (q : stableImage (cycleIdempotent F hex)) {k : ℕ} (hk : 0 < k) (y : X)
    (hy : y ∈ stableFiberDepthLayer F hex q k) :
    F y ∈ stableFiberDepthLayer F hex (iterateStableIndexMap F hex q) (k - 1) := by
  refine ⟨(iterate_globalMap_mem_stableFiber_index_iff F hex q y).2 hy.1, ?_⟩
  rw [minPreperiod_map_eq_sub_one F y (hy.2.symm ▸ hk), hy.2]

theorem map_image_depthLayer_subset
    (q : stableImage (cycleIdempotent F hex)) {k : ℕ} (hk : 0 < k) :
    F '' stableFiberDepthLayer F hex q k ⊆
      stableFiberDepthLayer F hex (iterateStableIndexMap F hex q) (k - 1) := by
  rintro z ⟨y, hy, rfl⟩
  exact map_mem_next_depthLayer F hex q hk y hy

end Iterate

/-! ## 有限走査 -/

section Counting

variable {X : Type} [Fintype X] [DecidableEq X]
variable (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

def depthLayerTable (A : Finset X) (μ : X → ℕ) (k : ℕ) : Finset X :=
  A.filter (fun y => μ y = k)

theorem card_eq_sum_depthLayerTable
    (A : Finset X) (μ : X → ℕ) (M : ℕ)
    (hmaps : ∀ y ∈ A, μ y ∈ Finset.range M) :
    A.card = ∑ k ∈ Finset.range M, (depthLayerTable A μ k).card := by
  rw [Finset.card_eq_sum_card_fiberwise hmaps]
  apply Finset.sum_congr rfl
  intro k _hk
  rfl

noncomputable def stableFiberDepthLayerTable
    (q : stableImage (cycleIdempotent F hex)) (k : ℕ) : Finset X :=
  depthLayerTable (stableFiberTable (cycleIdempotent F hex) q) (minPreperiod F) k

theorem mem_stableFiberDepthLayerTable_iff
    (q : stableImage (cycleIdempotent F hex)) (k : ℕ) (y : X) :
    y ∈ stableFiberDepthLayerTable F hex q k ↔
      y ∈ stableFiberDepthLayer F hex q k := by
  simp [stableFiberDepthLayerTable, depthLayerTable, stableFiberDepthLayer, depthLayer,
    mem_stableFiberTable_iff]

theorem stableFiberTable_card_eq_sum_depthLayerTable
    (q : stableImage (cycleIdempotent F hex)) :
    (stableFiberTable (cycleIdempotent F hex) q).card =
      ∑ k ∈ Finset.range (Fintype.card X + 1),
        (stableFiberDepthLayerTable F hex q k).card := by
  classical
  have hmaps : ∀ y ∈ stableFiberTable (cycleIdempotent F hex) q,
      minPreperiod F y ∈ Finset.range (Fintype.card X + 1) := by
    intro y _hy
    have hbound := minPreperiod_add_minPeriod_le F y
    simp only [Finset.mem_range]
    omega
  exact card_eq_sum_depthLayerTable _ _ _ hmaps

end Counting

end CellularAutomata.NecSuf.IterateMonoidStableFiberDepth
