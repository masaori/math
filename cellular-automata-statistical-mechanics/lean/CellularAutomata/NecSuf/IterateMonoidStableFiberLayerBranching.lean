/-
章「安定ファイバーの層別分岐個数」の必要十分版。

具体版と同じ手順（層の完全逆像、一段前像表の非交差、非交和の個数の和、
一段前像数への置換、有限列挙）を保ち、実際に使う構造だけを残す。

* 一段前像表の対ごとの非交差には、写像 F : X → Y と有限走査
  （X の有限性・Y の等号判定）だけが要る。層・反復・冪等性は要らない。
* 正の層と零層の分岐個数には、前章と同じ三性質（ファイバー添字の点ごとの
  移送同値・零層保存・正の深さの一段減少）と、有限走査のための X の有限性・
  等号判定だけが要る。反復・冪等性・添字型 Q の有限性は要らない。
  個数の段は前章の必要十分版 predecessorCount_conservation をそのまま使う。
* 零層と一層の非交差は深さの値 0 ≠ 1 だけから従い、仮定を要しない。
* 有限列挙には Q の有限性と Q の等号判定を追加で要する。

二値状態、セル、近傍、局所規則、R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidStableFiberBranching
import CellularAutomata.NecSuf.IterateMonoidStableFiberLayerPreimage

namespace CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching

open CellularAutomata.NecSuf.IterateMonoidStableFiberBranching
open CellularAutomata.NecSuf.IterateMonoidStableFiberLayerPreimage

/-! ## 一般層: 写像と有限走査だけで成り立つ部分 -/

section General

variable {X Y : Type} [Fintype X] [DecidableEq Y] (F : X → Y)

/-- 一段前像表は相異なる目標について対ごとに非交差である。 -/
theorem predecessorTables_pairwiseDisjoint (T : Finset Y) :
    ((T : Finset Y) : Set Y).PairwiseDisjoint (predecessorTable F) := by
  intro z _hz w _hw hzw
  change Disjoint (predecessorTable F z) (predecessorTable F w)
  rw [Finset.disjoint_left]
  intro y hyz hyw
  apply hzw
  exact ((mem_predecessorTable_iff F z y).1 hyz).symm.trans
    ((mem_predecessorTable_iff F w y).1 hyw)

end General

/-! ## 計数層: 三性質と有限走査だけで成り立つ部分 -/

section CountingLayer

variable {X Q : Type} [Fintype X] [DecidableEq X]
variable (F : X → X) (B : Q → Set X) (μ : X → ℕ) (σ : Q → Q)

/-- 層 `L(q,k)` を全元から有限走査した表。 -/
noncomputable def fiberDepthLayerTable (q : Q) (k : ℕ) : Finset X := by
  classical
  exact Finset.univ.filter fun y => y ∈ fiberDepthLayer B μ q k

theorem mem_fiberDepthLayerTable_iff (q : Q) (k : ℕ) (y : X) :
    y ∈ fiberDepthLayerTable B μ q k ↔ y ∈ fiberDepthLayer B μ q k := by
  classical
  simp [fiberDepthLayerTable]

/-- 零層と一層は非交差である。深さの値 0 ≠ 1 だけから従う。 -/
theorem zero_one_fiberDepthLayerTable_disjoint (q : Q) :
    Disjoint (fiberDepthLayerTable B μ q 0) (fiberDepthLayerTable B μ q 1) := by
  rw [Finset.disjoint_left]
  intro y hy0 hy1
  have h0 := (mem_fiberDepthLayerTable_iff B μ q 0 y).1 hy0
  have h1 := (mem_fiberDepthLayerTable_iff B μ q 1 y).1 hy1
  exact Nat.zero_ne_one (h0.2.symm.trans h1.2)

/-- 正の層へ流れ込む一段前像数は一つ上の層の個数に等しい。
使う仮定は三性質と有限走査だけである。 -/
theorem positive_fiberDepthLayerTable_card
    (hfiber : ∀ q y, F y ∈ B (σ q) ↔ y ∈ B q)
    (hzero : ∀ y, μ y = 0 → μ (F y) = 0)
    (hdec : ∀ y, 0 < μ y → μ (F y) = μ y - 1)
    (q : Q) (k : ℕ) (hk : 0 < k) :
    (fiberDepthLayerTable B μ q (k + 1)).card =
      ∑ z ∈ fiberDepthLayerTable B μ (σ q) k, predecessorCount F z := by
  apply predecessorCount_conservation
  intro y
  rw [mem_fiberDepthLayerTable_iff, mem_fiberDepthLayerTable_iff]
  exact (Set.ext_iff.mp
    (positive_fiberDepthLayer_exact_preimage F B μ σ hfiber hzero hdec q k hk) y).symm

/-- 零層へ流れ込む一段前像数は零層と一層の個数の和に等しい。 -/
theorem zero_fiberDepthLayerTable_card
    (hfiber : ∀ q y, F y ∈ B (σ q) ↔ y ∈ B q)
    (hzero : ∀ y, μ y = 0 → μ (F y) = 0)
    (hdec : ∀ y, 0 < μ y → μ (F y) = μ y - 1)
    (q : Q) :
    (fiberDepthLayerTable B μ q 0).card + (fiberDepthLayerTable B μ q 1).card =
      ∑ z ∈ fiberDepthLayerTable B μ (σ q) 0, predecessorCount F z := by
  rw [← Finset.card_union_of_disjoint (zero_one_fiberDepthLayerTable_disjoint B μ q)]
  apply predecessorCount_conservation
  intro y
  rw [Finset.mem_union, mem_fiberDepthLayerTable_iff, mem_fiberDepthLayerTable_iff,
    mem_fiberDepthLayerTable_iff, ← Set.mem_union]
  exact (Set.ext_iff.mp
    (zero_fiberDepthLayer_exact_preimage F B μ σ hfiber hzero hdec q) y).symm

end CountingLayer

/-! ## 有限列挙: 添字型の有限性と等号判定を追加で要する部分 -/

section FiniteScan

variable {X Q : Type} [Fintype X] [DecidableEq X] [Fintype Q] [DecidableEq Q]
variable (F : X → X) (B : Q → Set X) (μ : X → ℕ) (σ : Q → Q)

/-- 深さ範囲 `K` の全ての層について、層の個数と層別分岐総和を有限列挙する。 -/
noncomputable def layerBranchingDataTable (K : Finset ℕ) : Finset (Q × ℕ × ℕ × ℕ) :=
  Finset.univ.biUnion fun q =>
    K.image fun k =>
      (q, k, (fiberDepthLayerTable B μ q k).card,
        ∑ z ∈ fiberDepthLayerTable B μ (σ q) k, predecessorCount F z)

theorem mem_layerBranchingDataTable_iff
    (K : Finset ℕ) (q : Q) (k layerCard branchingTotal : ℕ) :
    (q, k, layerCard, branchingTotal) ∈ layerBranchingDataTable F B μ σ K ↔
      k ∈ K ∧
      layerCard = (fiberDepthLayerTable B μ q k).card ∧
      branchingTotal =
        ∑ z ∈ fiberDepthLayerTable B μ (σ q) k, predecessorCount F z := by
  classical
  simp [layerBranchingDataTable, eq_comm]

end FiniteScan

end CellularAutomata.NecSuf.IterateMonoidStableFiberLayerBranching
