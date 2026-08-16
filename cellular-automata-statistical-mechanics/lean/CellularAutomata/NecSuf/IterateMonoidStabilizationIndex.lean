/-
章「反復モノイドの衝突開始位置と主イデアル列の安定位置」の必要十分版。

具体版と同じ手順（衝突開始述語、自然数の整列性による最小衝突開始位置、
隣接後尾集合の等号と衝突開始の同値の両方向、最小性による真の減少、
衝突後の安定、有限走査した最初の安定位置と最小衝突開始位置の両側不等式）を保ち、
実際に使う構造だけを残す。

* 衝突開始述語と、隣接後尾集合の等号との同値には型 X と自己写像 F : X → X だけを使う。
  有限性も等号判定も要らない（前章の必要十分版の後尾集合の性質と ℕ の加法だけ）。
* 最小衝突開始位置 μ_F に要るのは「衝突開始位置が少なくとも一つ存在すること」だけである。
  X の有限性はこの存在を与えるためにだけ使う（`exists_collision_start`）。
  真の減少と以後の安定も、この存在仮定だけから従う。
* 有限走査した最初の安定位置との一致には、前章の走査に要る X → X の等号判定と、
  走査の入力である衝突証人 F^i = F^j（i < j）だけが要る。衝突証人自体が衝突開始位置の
  存在を与えるので、この定理にも X の有限性は要らない。
* 二値状態、セル、近傍、局所規則は現れない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail

namespace CellularAutomata.NecSuf.IterateMonoidStabilizationIndex

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail

variable {X : Type}

/-- n が衝突開始位置であること。X に構造は要らない。 -/
def IsCollisionStart (F : X → X) (n : ℕ) : Prop :=
  ∃ p : ℕ, 0 < p ∧ iterateMap F n = iterateMap F (n + p)

/-- 有限型上では衝突開始位置が存在する。有限性はここでだけ使う。 -/
theorem exists_collision_start [Fintype X] (F : X → X) : ∃ n : ℕ, IsCollisionStart F n := by
  obtain ⟨i, j, hij, _hj, h⟩ := iterateMap_collision F
  refine ⟨i, j - i, Nat.sub_pos_of_lt hij, ?_⟩
  simpa [Nat.add_sub_of_le (Nat.le_of_lt hij)] using h

/-- 衝突証人からも衝突開始位置が得られる（有限性は不要）。 -/
theorem isCollisionStart_of_collision (F : X → X) {i j : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) : IsCollisionStart F i := by
  refine ⟨j - i, Nat.sub_pos_of_lt hij, ?_⟩
  simpa [Nat.add_sub_of_le (Nat.le_of_lt hij)] using h

open Classical in
/-- 最小衝突開始位置。要るのは存在だけ（自然数の整列性）。 -/
noncomputable def minCollisionStart (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) : ℕ :=
  Nat.find (p := fun n => IsCollisionStart F n) hex

theorem minCollisionStart_spec (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) :
    IsCollisionStart F (minCollisionStart F hex) := by
  classical
  exact Nat.find_spec hex

theorem minCollisionStart_le (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) {n : ℕ}
    (h : IsCollisionStart F n) : minCollisionStart F hex ≤ n := by
  classical
  exact Nat.find_min' hex h

/-- 隣り合う後尾集合の等号は同じ位置で始まる衝突と同値である。X に構造は要らない。 -/
theorem tail_eq_succ_iff_collision_start (F : X → X) (n : ℕ) :
    tail F n = tail F (n + 1) ↔ IsCollisionStart F n := by
  constructor
  · intro htail
    have hmem : iterateMap F n ∈ tail F n := ⟨0, by simp⟩
    rw [htail] at hmem
    rcases hmem with ⟨k, hk⟩
    refine ⟨1 + k, by omega, ?_⟩
    simpa only [Nat.add_assoc] using hk.symm
  · rintro ⟨p, hp, h⟩
    have hnp : n < n + p := by omega
    exact (collision_stabilizes_tails F hnp h (n := n + 1) (by omega)).symm

/-- 最小衝突開始位置より前では後尾集合が真に減少する。存在仮定だけで従う。 -/
theorem tails_strict_before_minCollisionStart (F : X → X)
    (hex : ∃ n : ℕ, IsCollisionStart F n) {n : ℕ} (hn : n < minCollisionStart F hex) :
    tail F (n + 1) ⊆ tail F n ∧ tail F (n + 1) ≠ tail F n := by
  refine ⟨tails_descend F n, ?_⟩
  intro heq
  have hstart : IsCollisionStart F n :=
    (tail_eq_succ_iff_collision_start F n).mp heq.symm
  exact (Nat.not_le_of_lt hn) (minCollisionStart_le F hex hstart)

/-- 最小衝突開始位置以後は後尾集合が一定である。存在仮定だけで従う。 -/
theorem tails_stable_from_minCollisionStart (F : X → X)
    (hex : ∃ n : ℕ, IsCollisionStart F n) {n : ℕ} (hn : minCollisionStart F hex ≤ n) :
    tail F n = tail F (minCollisionStart F hex) := by
  rcases minCollisionStart_spec F hex with ⟨p, hp, h⟩
  exact collision_stabilizes_tails F (by omega) h hn

/-- 有限走査で得る最初の安定位置は最小衝突開始位置に等しい。
    要るのは走査用の等号判定と衝突証人だけで、有限性は要らない。 -/
theorem firstStableIndex_eq_minCollisionStart [DecidableEq (X → X)] (F : X → X)
    {i j : ℕ} (hij : i < j) (h : iterateMap F i = iterateMap F j) :
    firstStableIndex F hij h =
      minCollisionStart F ⟨i, isCollisionStart_of_collision F hij h⟩ := by
  set hex : ∃ n : ℕ, IsCollisionStart F n := ⟨i, isCollisionStart_of_collision F hij h⟩
  have hmu_le_i := minCollisionStart_le F hex (isCollisionStart_of_collision F hij h)
  have hmu_mem_range : minCollisionStart F hex ∈ Finset.range (i + 1) :=
    Finset.mem_range.mpr (by omega)
  have hmu_tail : tail F (minCollisionStart F hex) = tail F (minCollisionStart F hex + 1) :=
    (tail_eq_succ_iff_collision_start F _).mpr (minCollisionStart_spec F hex)
  have hmu_finite : finiteTail F j (minCollisionStart F hex) =
      finiteTail F j (minCollisionStart F hex + 1) := by
    ext g
    rw [mem_finiteTail_iff_tail F hij h, mem_finiteTail_iff_tail F hij h]
    exact Set.ext_iff.mp hmu_tail g
  have hmu_mem : minCollisionStart F hex ∈ stableIndices F i j :=
    Finset.mem_filter.mpr ⟨hmu_mem_range, hmu_finite⟩
  apply Nat.le_antisymm
  · exact Finset.min'_le _ _ hmu_mem
  · have hfirst := firstStableIndex_spec F hij h
    have hfirst_eq := (Finset.mem_filter.mp hfirst).2
    have htail : tail F (firstStableIndex F hij h) = tail F (firstStableIndex F hij h + 1) := by
      ext g
      rw [← mem_finiteTail_iff_tail F hij h, ← mem_finiteTail_iff_tail F hij h]
      exact Finset.ext_iff.mp hfirst_eq g
    exact minCollisionStart_le F hex ((tail_eq_succ_iff_collision_start F _).mp htail)

end CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
