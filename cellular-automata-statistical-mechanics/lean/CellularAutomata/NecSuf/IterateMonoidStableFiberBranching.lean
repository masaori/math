/-
章「安定ファイバー間の分岐個数」の必要十分版。

具体版と同じ手順（一段前像集合、異なる値の前像の非交差、完全逆像の一段前像への分解、
元ファイバーと完全逆像の個数一致、非交和の個数の和、一段前像数への置換、有限列挙）を保ち、
実際に使う構造だけを残す。

* 一般層（型 X, Y と写像 F : X → Y）: 一段前像集合の非交差と、任意の部分集合 T ⊆ Y の
  完全逆像が前像集合の合併に分解されることには、写像 F だけが要る。安定像・安定ファイバー・
  冪等性・反復・衝突開始位置は要らず、X = Y であることすら要らない。
* 個数保存: 有限集合 A ⊆ X, T ⊆ Y が「y ∈ A ⟺ F y ∈ T」を満たすことだけから
  |A| = Σ_{z∈T} |Pre_F(z)| が従う。要るのは X の有限性（全配位の走査）と Y の等号判定
  （前像表の filter と非交差の判定）だけである。前章の完全逆像 F⁻¹(B(σ q)) = B(q) を
  A := B(q), T := B(σ q) として代入すれば分岐個数の保存になる。
* 反復層（E := E_F、A, T を安定ファイバーとする）: 前章の必要十分版の点ごとの完全逆像
  だけを使い、衝突開始位置の存在と X の有限性・等号判定で分岐個数の保存を得る。
* 有限列挙には Y の有限性と X, Y の等号判定が要る。

R / C は使わない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics

namespace CellularAutomata.NecSuf.IterateMonoidStableFiberBranching

open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
open CellularAutomata.NecSuf.IterateMonoidCycleIdempotent
open CellularAutomata.NecSuf.IterateMonoidStablePartition
open CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics

/-! ## 一般層: 写像 F : X → Y だけで成り立つ部分 -/

section General

variable {X Y : Type} (F : X → Y)

/-- `Pre_F(z) := {y | F y = z}`。 -/
def predecessorSet (z : Y) : Set X :=
  {y | F y = z}

/-- 異なる値の一段前像集合は交わらない。写像 F だけを使う。 -/
theorem distinct_predecessorSets_disjoint {z w : Y} (hzw : z ≠ w) :
    predecessorSet F z ∩ predecessorSet F w = ∅ := by
  ext y
  constructor
  · rintro ⟨hyz, hyw⟩
    exact (hzw (hyz.symm.trans hyw)).elim
  · simp

/-- 任意の部分集合 T ⊆ Y の完全逆像は、一段前像集合の合併に分解される。 -/
theorem preimage_eq_iUnion (T : Set Y) :
    F ⁻¹' T = ⋃ z ∈ T, predecessorSet F z := by
  ext y
  constructor
  · intro hy
    exact Set.mem_iUnion_of_mem (F y) (Set.mem_iUnion_of_mem hy (by rfl))
  · intro hy
    simp only [Set.mem_iUnion] at hy
    obtain ⟨z, hzT, hyz⟩ := hy
    change F y = z at hyz
    simpa [hyz] using hzT

end General

/-! ## 個数保存: X の有限性と Y の等号判定だけで成り立つ部分 -/

section Counting

variable {X Y : Type} [Fintype X] [DecidableEq Y] (F : X → Y)

/-- `Pre_F(z)` を全元から有限走査した表。 -/
def predecessorTable (z : Y) : Finset X :=
  Finset.univ.filter (fun y => F y = z)

theorem mem_predecessorTable_iff (z : Y) (y : X) :
    y ∈ predecessorTable F z ↔ y ∈ predecessorSet F z := by
  simp [predecessorTable, predecessorSet]

/-- `b_F(z) := |Pre_F(z)|`。 -/
def predecessorCount (z : Y) : ℕ :=
  (predecessorTable F z).card

/-- `T` に含まれる `z` について、全元で取った前像表は `A` 内の前像に一致する。 -/
theorem predecessorTable_eq_source_filter [DecidableEq X]
    (A : Finset X) (T : Finset Y) (hAT : ∀ y, y ∈ A ↔ F y ∈ T)
    (z : Y) (hz : z ∈ T) :
    predecessorTable F z = A.filter (fun y => F y = z) := by
  ext y
  simp only [predecessorTable, Finset.mem_filter, Finset.mem_univ, true_and]
  constructor
  · intro hyz
    exact ⟨(hAT y).2 (by rw [hyz]; exact hz), hyz⟩
  · exact fun hy => hy.2

/-- 前像表の合併。 -/
def predecessorUnionTable [DecidableEq X] (T : Finset Y) : Finset X :=
  T.biUnion (predecessorTable F)

/-- 「y ∈ A ⟺ F y ∈ T」のとき、前像表の合併は A に一致する。 -/
theorem predecessorUnionTable_eq [DecidableEq X]
    (A : Finset X) (T : Finset Y) (hAT : ∀ y, y ∈ A ↔ F y ∈ T) :
    predecessorUnionTable F T = A := by
  ext y
  simp only [predecessorUnionTable, Finset.mem_biUnion, mem_predecessorTable_iff,
    predecessorSet, Set.mem_setOf_eq]
  constructor
  · rintro ⟨z, hz, hyz⟩
    exact (hAT y).2 (by rw [hyz]; exact hz)
  · intro hy
    exact ⟨F y, (hAT y).1 hy, rfl⟩

/-- 個数保存: `y ∈ A ⟺ F y ∈ T` ならば `|A| = Σ_{z∈T} b_F(z)`。 -/
theorem predecessorCount_conservation [DecidableEq X]
    (A : Finset X) (T : Finset Y) (hAT : ∀ y, y ∈ A ↔ F y ∈ T) :
    A.card = ∑ z ∈ T, predecessorCount F z := by
  have hdisjoint : ((T : Finset Y) : Set Y).PairwiseDisjoint (predecessorTable F) := by
    intro z _hz w _hw hzw
    change Disjoint (predecessorTable F z) (predecessorTable F w)
    rw [Finset.disjoint_left]
    intro y hyz hyw
    apply hzw
    exact ((mem_predecessorTable_iff F z y).1 hyz).symm.trans
      ((mem_predecessorTable_iff F w y).1 hyw)
  calc
    A.card = (predecessorUnionTable F T).card := by
      rw [predecessorUnionTable_eq F A T hAT]
    _ = ∑ z ∈ T, (predecessorTable F z).card := Finset.card_biUnion hdisjoint
    _ = ∑ z ∈ T, predecessorCount F z := by
      apply Finset.sum_congr rfl
      intro z _hz
      rfl

/-- 全ての一段前像集合と個数の有限列挙。Y の有限性と X の等号判定を追加で要する。 -/
def predecessorDataTable [Fintype Y] [DecidableEq X] : Finset (Y × Finset X × ℕ) :=
  Finset.univ.image (fun z => (z, predecessorTable F z, predecessorCount F z))

theorem mem_predecessorDataTable_iff [Fintype Y] [DecidableEq X]
    (z : Y) (P : Finset X) (d : ℕ) :
    (z, P, d) ∈ predecessorDataTable F ↔
      P = predecessorTable F z ∧ d = predecessorCount F z := by
  simp [predecessorDataTable, eq_comm]

end Counting

/-! ## 反復層: 安定ファイバー間の分岐個数 -/

section Iterate

variable {X : Type} [Fintype X] [DecidableEq X]
variable (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

/-- 元ファイバーと次のファイバーは「y ∈ B(q) ⟺ F y ∈ B(σ q)」を満たす。前章の完全逆像から従う。 -/
theorem stableFiberTable_iff_next
    (q : stableImage (cycleIdempotent F hex)) (y : X) :
    y ∈ stableFiberTable (cycleIdempotent F hex) q ↔
      F y ∈ stableFiberTable (cycleIdempotent F hex) (iterateStableIndexMap F hex q) := by
  rw [mem_stableFiberTable_iff, mem_stableFiberTable_iff]
  exact (iterate_globalMap_mem_stableFiber_index_iff F hex q y).symm

/-- 分岐個数の保存（反復層）。 -/
theorem iterate_predecessorCount_conservation
    (q : stableImage (cycleIdempotent F hex)) :
    (stableFiberTable (cycleIdempotent F hex) q).card =
      ∑ z ∈ stableFiberTable (cycleIdempotent F hex) (iterateStableIndexMap F hex q),
        predecessorCount F z :=
  predecessorCount_conservation F _ _ (stableFiberTable_iff_next F hex q)

end Iterate

end CellularAutomata.NecSuf.IterateMonoidStableFiberBranching
