/-
章「反復モノイドの過渡部と巡回部への分解」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-tail-cycle-decomposition.ts。

有限舞台上の二値 CA の大域写像について、最小衝突開始位置より前の過渡部と、
最小正周期一周期分の巡回部を定義し、非交和と元数公式を人手証明と同じ順序で示す。
有限集合と自然数だけを使い、無限極限、位相、R / C は使わない。
-/
import CellularAutomata.IterateMonoidMinimalPeriod

namespace CellularAutomata.IterateMonoidTailCycleDecomposition

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidPrincipalIdealTail
open CellularAutomata.IterateMonoidStabilizationIndex
open CellularAutomata.IterateMonoidMinimalPeriod

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- T_F: μ_F より前の反復写像を集めた有限集合。 -/
noncomputable def transientPart : Finset ((V → State) → (V → State)) :=
  (Finset.range (minCollisionStart N f)).image (iterateMap N f)

/-- C_F: μ_F から始まる λ_F 個の反復写像を集めた有限集合。 -/
noncomputable def cyclePart : Finset ((V → State) → (V → State)) :=
  (Finset.range (minPositivePeriod N f)).image
    (fun r => iterateMap N f (minCollisionStart N f + r))

/-- μ_F より前では反復写像は衝突しない。 -/
theorem iterateMap_injective_before_minCollisionStart {a b : ℕ}
    (ha : a < minCollisionStart N f) (hb : b < minCollisionStart N f)
    (h : iterateMap N f a = iterateMap N f b) : a = b := by
  by_contra hab
  rcases lt_or_gt_of_ne hab with hab' | hba
  · have hstart : IsCollisionStart N f a := by
      refine ⟨b - a, Nat.sub_pos_of_lt hab', ?_⟩
      simpa [Nat.add_sub_of_le (Nat.le_of_lt hab')] using h
    exact (Nat.not_le_of_lt ha) (minCollisionStart_le N f hstart)
  · have hstart : IsCollisionStart N f b := by
      refine ⟨a - b, Nat.sub_pos_of_lt hba, ?_⟩
      simpa [Nat.add_sub_of_le (Nat.le_of_lt hba)] using h.symm
    exact (Nat.not_le_of_lt hb) (minCollisionStart_le N f hstart)

/-- 過渡部の反復写像は安定後の反復写像と衝突しない。 -/
theorem iterateMap_before_ne_after_minCollisionStart {a n : ℕ}
    (ha : a < minCollisionStart N f) (hn : minCollisionStart N f ≤ n) :
    iterateMap N f a ≠ iterateMap N f n := by
  intro h
  have han : a < n := lt_of_lt_of_le ha hn
  have hstart : IsCollisionStart N f a := by
    refine ⟨n - a, Nat.sub_pos_of_lt han, ?_⟩
    simpa [Nat.add_sub_of_le (Nat.le_of_lt han)] using h
  exact (Nat.not_le_of_lt ha) (minCollisionStart_le N f hstart)

/-- 安定後の後尾集合は最小正周期の一周期分で尽くされる。 -/
theorem mem_tail_minCollisionStart_iff_mem_cyclePart
    (g : (V → State) → (V → State)) :
    g ∈ tail N f (minCollisionStart N f) ↔ g ∈ cyclePart N f := by
  constructor
  · rintro ⟨k, rfl⟩
    let lam := minPositivePeriod N f
    have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos N f
    let r := k % lam
    have hr : r < lam := Nat.mod_lt _ hlam
    have hperiod : IsPositivePeriod N f lam := by
      simpa [lam] using minPositivePeriod_spec N f
    have hreduce : iterateMap N f (minCollisionStart N f + r) =
        iterateMap N f (minCollisionStart N f + k) := by
      have hk : minCollisionStart N f ≤ minCollisionStart N f + r := by omega
      have hmultiple : ∀ d : ℕ, iterateMap N f (minCollisionStart N f + r) =
          iterateMap N f (minCollisionStart N f + r + d * lam) := by
        intro d
        induction d with
        | zero => simp
        | succ d ih =>
          exact ih.trans (by
            have hs := period_propagates_after_collision_start N f hperiod
              (n := minCollisionStart N f + r + d * lam) (by omega)
            simpa [Nat.succ_mul, Nat.add_assoc] using hs)
      have hkform : k = (k / lam) * lam + r := by
        simpa [r, Nat.add_comm, Nat.mul_comm] using (Nat.mod_add_div k lam).symm
      rw [hkform]
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hmultiple (k / lam)
    exact Finset.mem_image.mpr ⟨r, Finset.mem_range.mpr hr, hreduce⟩
  · intro hg
    rcases Finset.mem_image.mp hg with ⟨r, _hr, rfl⟩
    exact ⟨r, rfl⟩

/-- 一周期分の反復写像は互いに異なる。 -/
theorem iterateMap_injective_in_cycle {r s : ℕ}
    (hr : r < minPositivePeriod N f) (hs : s < minPositivePeriod N f)
    (h : iterateMap N f (minCollisionStart N f + r) =
      iterateMap N f (minCollisionStart N f + s)) : r = s := by
  have aux : ∀ {x y : ℕ}, x < y → y < minPositivePeriod N f →
      iterateMap N f (minCollisionStart N f + x) =
        iterateMap N f (minCollisionStart N f + y) → False := by
    intro x y hxy hy hxyMap
    let lam := minPositivePeriod N f
    have hcomp := congrArg (fun g => iterateMap N f (lam - x) ∘ g) hxyMap
    rw [iterateMap_comp_add, iterateMap_comp_add] at hcomp
    have hperiod : IsPositivePeriod N f lam := by
      simpa [lam] using minPositivePeriod_spec N f
    have hsmall : 0 < y - x ∧ y - x < lam := by omega
    have hcollision : iterateMap N f (minCollisionStart N f) =
        iterateMap N f (minCollisionStart N f + (y - x)) := by
      have hl := hperiod.2
      have hcomp' : iterateMap N f (minCollisionStart N f + lam) =
          iterateMap N f (minCollisionStart N f + lam + (y - x)) := by
        convert hcomp using 1 <;> congr 1 <;> omega
      have hrw : iterateMap N f (minCollisionStart N f + (y - x)) =
          iterateMap N f (minCollisionStart N f + (y - x) + lam) :=
        period_propagates_after_collision_start N f hperiod (by omega)
      calc
        iterateMap N f (minCollisionStart N f) =
            iterateMap N f (minCollisionStart N f + lam) := hperiod.2
        _ = iterateMap N f (minCollisionStart N f + lam + (y - x)) := hcomp'
        _ = iterateMap N f (minCollisionStart N f + (y - x) + lam) := by
          congr 1 <;> omega
        _ = iterateMap N f (minCollisionStart N f + (y - x)) := hrw.symm
    have hcandidate : IsPositivePeriod N f (y - x) := ⟨hsmall.1, hcollision⟩
    have hle := minPositivePeriod_le N f hcandidate
    omega
  by_contra hrs
  rcases lt_or_gt_of_ne hrs with hrs' | hsr
  · exact aux hrs' hs h
  · exact aux hsr hr h.symm

/-- T_F と C_F は交わらない。 -/
theorem transientPart_disjoint_cyclePart :
    Disjoint (transientPart N f) (cyclePart N f) := by
  rw [Finset.disjoint_left]
  intro g hgT hgC
  rcases Finset.mem_image.mp hgT with ⟨a, ha, rfl⟩
  rcases Finset.mem_image.mp hgC with ⟨r, _hr, hEq⟩
  exact iterateMap_before_ne_after_minCollisionStart N f
    (Finset.mem_range.mp ha) (Nat.le_add_right _ _) hEq.symm

/-- |T_F| = μ_F。 -/
theorem card_transientPart :
    (transientPart N f).card = minCollisionStart N f := by
  rw [transientPart, Finset.card_image_iff.mpr]
  · simp
  · intro a ha b hb h
    exact iterateMap_injective_before_minCollisionStart N f
      (Finset.mem_range.mp ha) (Finset.mem_range.mp hb) h

/-- |C_F| = λ_F。 -/
theorem card_cyclePart :
    (cyclePart N f).card = minPositivePeriod N f := by
  rw [cyclePart, Finset.card_image_iff.mpr]
  · simp
  · intro r hr s hs h
    exact iterateMap_injective_in_cycle N f
      (Finset.mem_range.mp hr) (Finset.mem_range.mp hs) h

/-- 過渡部と巡回部の和は反復モノイド P_F の全要素をちょうど列挙する。 -/
theorem mem_transientPart_union_cyclePart_iff_powerSet
    (g : (V → State) → (V → State)) :
    g ∈ transientPart N f ∪ cyclePart N f ↔ g ∈ powerSet N f := by
  constructor
  · intro hg
    rcases Finset.mem_union.mp hg with hgT | hgC
    · rcases Finset.mem_image.mp hgT with ⟨n, _hn, rfl⟩
      exact ⟨n, rfl⟩
    · rcases Finset.mem_image.mp hgC with ⟨r, _hr, rfl⟩
      exact ⟨minCollisionStart N f + r, rfl⟩
  · rintro ⟨n, rfl⟩
    by_cases hn : n < minCollisionStart N f
    · exact Finset.mem_union_left _
        (Finset.mem_image.mpr ⟨n, Finset.mem_range.mpr hn, rfl⟩)
    · have htail : iterateMap N f n ∈ tail N f (minCollisionStart N f) := by
        refine ⟨n - minCollisionStart N f, ?_⟩
        congr 1
        omega
      exact Finset.mem_union_right _
        ((mem_tail_minCollisionStart_iff_mem_cyclePart N f _).mp htail)

/-- P_F = T_F ⊔ C_F かつ |P_F| = μ_F + λ_F。 -/
theorem transient_cycle_partition_cardinality :
    Disjoint (transientPart N f) (cyclePart N f) ∧
      (transientPart N f ∪ cyclePart N f).card =
        minCollisionStart N f + minPositivePeriod N f := by
  have hdisjoint := transientPart_disjoint_cyclePart N f
  refine ⟨hdisjoint, ?_⟩
  rw [Finset.card_union_of_disjoint hdisjoint, card_transientPart, card_cyclePart]

/-- 有限真理値表から得た二つの有限集合への所属判定は P_F への所属判定と一致する。 -/
noncomputable instance (g : (V → State) → (V → State)) :
    Decidable (g ∈ powerSet N f) :=
  decidable_of_iff (g ∈ transientPart N f ∪ cyclePart N f)
    (mem_transientPart_union_cyclePart_iff_powerSet N f g)

end CellularAutomata.IterateMonoidTailCycleDecomposition
