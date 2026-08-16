/-
章「反復モノイドの衝突開始位置と主イデアル列の安定位置」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-stabilization-index.ts。

有限舞台上の二値 CA の大域写像について、正周期をもつ衝突の最小開始位置、
隣接する後尾集合の等号との同値、最小位置より前の厳密減少と以後の安定、
有限走査で得る最初の安定位置との一致を、人手証明と同じ順序で形式化する。
有限集合と自然数だけを使い、無限極限、位相、R / C は使わない。
-/
import CellularAutomata.IterateMonoidPrincipalIdealTail
import CellularAutomata.NecSuf.IterateMonoidStabilizationIndex

namespace CellularAutomata.IterateMonoidStabilizationIndex

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidPrincipalIdealTail

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- n が衝突開始位置であること（`def_iterate_monoid_collision_start`）。 -/
def IsCollisionStart (n : ℕ) : Prop :=
  ∃ p : ℕ, 0 < p ∧ iterateMap N f n = iterateMap N f (n + p)

theorem exists_collision_start : ∃ n : ℕ, IsCollisionStart N f n := by
  obtain ⟨i, j, hij, _hj, h⟩ := iterateMap_collision N f
  refine ⟨i, j - i, Nat.sub_pos_of_lt hij, ?_⟩
  simpa [Nat.add_sub_of_le (Nat.le_of_lt hij)] using h

open Classical in
/-- 最小衝突開始位置 μ_F（自然数の整列性）。 -/
noncomputable def minCollisionStart : ℕ :=
  Nat.find (p := fun n => IsCollisionStart N f n) (exists_collision_start N f)

theorem minCollisionStart_spec : IsCollisionStart N f (minCollisionStart N f) := by
  classical
  exact Nat.find_spec (exists_collision_start N f)

theorem minCollisionStart_le {n : ℕ} (h : IsCollisionStart N f n) :
    minCollisionStart N f ≤ n := by
  classical
  exact Nat.find_min' (exists_collision_start N f) h

omit [Fintype V] [DecidableEq V] in
/-- 隣り合う後尾集合の等号は同じ位置で始まる衝突と同値である
    （`claim_iterate_monoid_tail_equality_iff_collision_start`）。 -/
theorem tail_eq_succ_iff_collision_start (n : ℕ) :
    tail N f n = tail N f (n + 1) ↔ IsCollisionStart N f n := by
  constructor
  · intro htail
    have hmem : iterateMap N f n ∈ tail N f n := ⟨0, by simp⟩
    rw [htail] at hmem
    rcases hmem with ⟨k, hk⟩
    refine ⟨1 + k, by omega, ?_⟩
    simpa only [Nat.add_assoc] using hk.symm
  · rintro ⟨p, hp, h⟩
    have hnp : n < n + p := by omega
    exact (collision_stabilizes_tails N f hnp h (n := n + 1) (by omega)).symm

/-- μ_F より前では後尾集合が真に減少する
    （`claim_iterate_monoid_tails_strict_then_stable` の前半）。 -/
theorem tails_strict_before_minCollisionStart {n : ℕ} (hn : n < minCollisionStart N f) :
    tail N f (n + 1) ⊆ tail N f n ∧ tail N f (n + 1) ≠ tail N f n := by
  refine ⟨tails_descend N f n, ?_⟩
  intro heq
  have hstart : IsCollisionStart N f n :=
    (tail_eq_succ_iff_collision_start N f n).mp heq.symm
  exact (Nat.not_le_of_lt hn) (minCollisionStart_le N f hstart)

/-- μ_F 以後は後尾集合が I_{μ_F}(F) に等しい
    （`claim_iterate_monoid_tails_strict_then_stable` の後半）。 -/
theorem tails_stable_from_minCollisionStart {n : ℕ} (hn : minCollisionStart N f ≤ n) :
    tail N f n = tail N f (minCollisionStart N f) := by
  rcases minCollisionStart_spec N f with ⟨p, hp, h⟩
  exact collision_stabilizes_tails N f (by omega) h hn

/-- 任意の有限走査用衝突証人について、走査で得る最初の安定位置は μ_F に等しい
    （`claim_iterate_monoid_first_stable_equals_min_collision_start`）。 -/
theorem firstStableIndex_eq_minCollisionStart {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) :
    firstStableIndex N f hij h = minCollisionStart N f := by
  have hiStart : IsCollisionStart N f i := by
    refine ⟨j - i, Nat.sub_pos_of_lt hij, ?_⟩
    simpa [Nat.add_sub_of_le (Nat.le_of_lt hij)] using h
  have hmu_le_i := minCollisionStart_le N f hiStart
  have hmu_mem_range : minCollisionStart N f ∈ Finset.range (i + 1) :=
    Finset.mem_range.mpr (by omega)
  have hmu_tail : tail N f (minCollisionStart N f) =
      tail N f (minCollisionStart N f + 1) :=
    (tail_eq_succ_iff_collision_start N f _).mpr (minCollisionStart_spec N f)
  have hmu_finite : finiteTail N f j (minCollisionStart N f) =
      finiteTail N f j (minCollisionStart N f + 1) := by
    ext g
    rw [mem_finiteTail_iff_tail N f hij h, mem_finiteTail_iff_tail N f hij h]
    exact Set.ext_iff.mp hmu_tail g
  have hmu_mem : minCollisionStart N f ∈ stableIndices N f i j :=
    Finset.mem_filter.mpr ⟨hmu_mem_range, hmu_finite⟩
  apply Nat.le_antisymm
  · exact Finset.min'_le _ _ hmu_mem
  · have hfirst := firstStableIndex_spec N f hij h
    have hfirst_eq := (Finset.mem_filter.mp hfirst).2
    have htail : tail N f (firstStableIndex N f hij h) =
        tail N f (firstStableIndex N f hij h + 1) := by
      ext g
      rw [← mem_finiteTail_iff_tail N f hij h,
        ← mem_finiteTail_iff_tail N f hij h]
      exact Finset.ext_iff.mp hfirst_eq g
    exact minCollisionStart_le N f ((tail_eq_succ_iff_collision_start N f _).mp htail)

/-! ## 必要十分版からの導出
具体版は必要十分版を X := V → State、F := globalMap N f へ特殊化したものである。 -/

omit [Fintype V] [DecidableEq V] in
theorem isCollisionStart_eq_necessary_sufficient (n : ℕ) :
    IsCollisionStart N f n ↔
      CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.IsCollisionStart (globalMap N f) n := by
  simp only [IsCollisionStart,
    CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.IsCollisionStart,
    iterateMap_eq_necessary_sufficient]

theorem exists_collision_start_from_necessary_sufficient : ∃ n : ℕ, IsCollisionStart N f n := by
  obtain ⟨n, hn⟩ :=
    CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.exists_collision_start (globalMap N f)
  exact ⟨n, (isCollisionStart_eq_necessary_sufficient N f n).mpr hn⟩

/-- 具体版の最小衝突開始位置は、有限型上の存在から得た必要十分版の最小衝突開始位置に等しい
    （両方向の最小性で示す）。 -/
theorem minCollisionStart_eq_necessary_sufficient :
    minCollisionStart N f =
      CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.minCollisionStart (globalMap N f)
        (CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.exists_collision_start
          (globalMap N f)) := by
  apply Nat.le_antisymm
  · exact minCollisionStart_le N f ((isCollisionStart_eq_necessary_sufficient N f _).mpr
      (CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.minCollisionStart_spec _ _))
  · exact CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.minCollisionStart_le _ _
      ((isCollisionStart_eq_necessary_sufficient N f _).mp (minCollisionStart_spec N f))

omit [Fintype V] [DecidableEq V] in
theorem tail_eq_succ_iff_collision_start_from_necessary_sufficient (n : ℕ) :
    tail N f n = tail N f (n + 1) ↔ IsCollisionStart N f n := by
  rw [tail_eq_necessary_sufficient, tail_eq_necessary_sufficient,
    isCollisionStart_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.tail_eq_succ_iff_collision_start
    (globalMap N f) n

theorem tails_strict_before_minCollisionStart_from_necessary_sufficient {n : ℕ}
    (hn : n < minCollisionStart N f) :
    tail N f (n + 1) ⊆ tail N f n ∧ tail N f (n + 1) ≠ tail N f n := by
  rw [tail_eq_necessary_sufficient, tail_eq_necessary_sufficient]
  rw [minCollisionStart_eq_necessary_sufficient] at hn
  exact CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.tails_strict_before_minCollisionStart
    (globalMap N f) _ hn

theorem tails_stable_from_minCollisionStart_from_necessary_sufficient {n : ℕ}
    (hn : minCollisionStart N f ≤ n) :
    tail N f n = tail N f (minCollisionStart N f) := by
  rw [tail_eq_necessary_sufficient, tail_eq_necessary_sufficient,
    minCollisionStart_eq_necessary_sufficient]
  rw [minCollisionStart_eq_necessary_sufficient] at hn
  exact CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.tails_stable_from_minCollisionStart
    (globalMap N f) _ hn

/-- 有限走査した最初の安定位置と最小衝突開始位置の一致。必要十分版は衝突証人から作った
    存在証明を使うが、最小値は存在証明の取り方に依らない（証明無関係）ので具体版の μ_F に一致する。 -/
theorem firstStableIndex_eq_minCollisionStart_from_necessary_sufficient {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) :
    firstStableIndex N f hij h = minCollisionStart N f := by
  have h' : CellularAutomata.NecSuf.IterateMonoid.iterateMap (globalMap N f) i =
      CellularAutomata.NecSuf.IterateMonoid.iterateMap (globalMap N f) j := by
    simpa only [iterateMap_eq_necessary_sufficient] using h
  have hfirst : firstStableIndex N f hij h =
      CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.firstStableIndex
        (globalMap N f) hij h' := by
    simp only [firstStableIndex,
      CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.firstStableIndex,
      stableIndices_eq_necessary_sufficient]
  rw [hfirst,
    CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.firstStableIndex_eq_minCollisionStart
      (globalMap N f) hij h',
    minCollisionStart_eq_necessary_sufficient]
  -- 二つの最小衝突開始位置は存在証明だけが異なり、証明無関係により同じ項である。

end CellularAutomata.IterateMonoidStabilizationIndex
