/-
章「反復モノイドの過渡部と巡回部への分解」の必要十分版。

具体版と同じ手順（μ_F より前の非衝突、過渡部と安定後尾の非交差、自然数の除法と周期伝播による
安定後尾の一周期分への還元、最小正周期の最小性による一周期内の相異性、二部分が反復モノイドを
尽くすこと、元数公式、有限集合への所属判定による有限決定）を保ち、実際に使う構造だけを残す。

* 非衝突・非交差・一周期分への還元・一周期内の相異性・尽くすことに要るのは、型 X、自己写像
  F : X → X、衝突開始位置の存在（前々章の `minCollisionStart` の入力）だけである。
  X の有限性はこの存在を与えるためにだけ使い、この章の定理には現れない。
* 過渡部・巡回部を `Finset` として書き、元数公式を述べるためにだけ X → X の等号判定
  （`DecidableEq (X → X)`）が要る（`Finset.image` と `Finset.card_image_iff` の入力）。
  所属の同値や非衝突は等号判定なしで成り立つが、Finset を書く段階で必要になるので
  この章では全体に置く。
* 有限決定は、上の二つの有限集合への所属判定を反復モノイドへの所属判定へ移すだけである。
* 二値状態、セル、近傍、局所規則は現れない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidMinimalPeriod

namespace CellularAutomata.NecSuf.IterateMonoidTailCycleDecomposition

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail
open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
open CellularAutomata.NecSuf.IterateMonoidMinimalPeriod

variable {X : Type} [DecidableEq (X → X)]
variable (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

/-- T_F: μ_F より前の反復写像を集めた有限集合。 -/
noncomputable def transientPart : Finset (X → X) :=
  (Finset.range (minCollisionStart F hex)).image (iterateMap F)

/-- C_F: μ_F から始まる λ_F 個の反復写像を集めた有限集合。 -/
noncomputable def cyclePart : Finset (X → X) :=
  (Finset.range (minPositivePeriod F hex)).image
    (fun r => iterateMap F (minCollisionStart F hex + r))

omit [DecidableEq (X → X)] in
/-- μ_F より前では反復写像は衝突しない。最小衝突開始位置の最小性だけを使う。 -/
theorem iterateMap_injective_before_minCollisionStart {a b : ℕ}
    (ha : a < minCollisionStart F hex) (hb : b < minCollisionStart F hex)
    (h : iterateMap F a = iterateMap F b) : a = b := by
  by_contra hab
  rcases lt_or_gt_of_ne hab with hab' | hba
  · have hstart : IsCollisionStart F a := by
      refine ⟨b - a, Nat.sub_pos_of_lt hab', ?_⟩
      simpa [Nat.add_sub_of_le (Nat.le_of_lt hab')] using h
    exact (Nat.not_le_of_lt ha) (minCollisionStart_le F hex hstart)
  · have hstart : IsCollisionStart F b := by
      refine ⟨a - b, Nat.sub_pos_of_lt hba, ?_⟩
      simpa [Nat.add_sub_of_le (Nat.le_of_lt hba)] using h.symm
    exact (Nat.not_le_of_lt hb) (minCollisionStart_le F hex hstart)

omit [DecidableEq (X → X)] in
/-- 過渡部の反復写像は安定後の反復写像と衝突しない。 -/
theorem iterateMap_before_ne_after_minCollisionStart {a n : ℕ}
    (ha : a < minCollisionStart F hex) (hn : minCollisionStart F hex ≤ n) :
    iterateMap F a ≠ iterateMap F n := by
  intro h
  have han : a < n := lt_of_lt_of_le ha hn
  have hstart : IsCollisionStart F a := by
    refine ⟨n - a, Nat.sub_pos_of_lt han, ?_⟩
    simpa [Nat.add_sub_of_le (Nat.le_of_lt han)] using h
  exact (Nat.not_le_of_lt ha) (minCollisionStart_le F hex hstart)

/-- 安定後の後尾集合は最小正周期の一周期分で尽くされる。除法・帰納法・周期伝播だけを使う。 -/
theorem mem_tail_minCollisionStart_iff_mem_cyclePart (g : X → X) :
    g ∈ tail F (minCollisionStart F hex) ↔ g ∈ cyclePart F hex := by
  constructor
  · rintro ⟨k, rfl⟩
    let lam := minPositivePeriod F hex
    have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos F hex
    let r := k % lam
    have hr : r < lam := Nat.mod_lt _ hlam
    have hperiod : IsPositivePeriod F hex lam := by
      simpa [lam] using minPositivePeriod_spec F hex
    have hreduce : iterateMap F (minCollisionStart F hex + r) =
        iterateMap F (minCollisionStart F hex + k) := by
      have hmultiple : ∀ d : ℕ, iterateMap F (minCollisionStart F hex + r) =
          iterateMap F (minCollisionStart F hex + r + d * lam) := by
        intro d
        induction d with
        | zero => simp
        | succ d ih =>
          exact ih.trans (by
            have hs := period_propagates_after_collision_start F hex hperiod
              (n := minCollisionStart F hex + r + d * lam) (by omega)
            simpa [Nat.succ_mul, Nat.add_assoc] using hs)
      have hkform : k = (k / lam) * lam + r := by
        simpa [r, Nat.add_comm, Nat.mul_comm] using (Nat.mod_add_div k lam).symm
      rw [hkform]
      simpa [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hmultiple (k / lam)
    exact Finset.mem_image.mpr ⟨r, Finset.mem_range.mpr hr, hreduce⟩
  · intro hg
    rcases Finset.mem_image.mp hg with ⟨r, _hr, rfl⟩
    exact ⟨r, rfl⟩

omit [DecidableEq (X → X)] in
/-- 一周期分の反復写像は互いに異なる。加法則・周期伝播・最小正周期の最小性だけを使う。 -/
theorem iterateMap_injective_in_cycle {r s : ℕ}
    (hr : r < minPositivePeriod F hex) (hs : s < minPositivePeriod F hex)
    (h : iterateMap F (minCollisionStart F hex + r) =
      iterateMap F (minCollisionStart F hex + s)) : r = s := by
  have aux : ∀ {x y : ℕ}, x < y → y < minPositivePeriod F hex →
      iterateMap F (minCollisionStart F hex + x) =
        iterateMap F (minCollisionStart F hex + y) → False := by
    intro x y hxy hy hxyMap
    let lam := minPositivePeriod F hex
    have hcomp := congrArg (fun g => iterateMap F (lam - x) ∘ g) hxyMap
    rw [iterateMap_comp_add, iterateMap_comp_add] at hcomp
    have hperiod : IsPositivePeriod F hex lam := by
      simpa [lam] using minPositivePeriod_spec F hex
    have hsmall : 0 < y - x ∧ y - x < lam := by omega
    have hcollision : iterateMap F (minCollisionStart F hex) =
        iterateMap F (minCollisionStart F hex + (y - x)) := by
      have hcomp' : iterateMap F (minCollisionStart F hex + lam) =
          iterateMap F (minCollisionStart F hex + lam + (y - x)) := by
        convert hcomp using 1 <;> (congr 1; omega)
      have hrw : iterateMap F (minCollisionStart F hex + (y - x)) =
          iterateMap F (minCollisionStart F hex + (y - x) + lam) :=
        period_propagates_after_collision_start F hex hperiod (by omega)
      calc
        iterateMap F (minCollisionStart F hex) =
            iterateMap F (minCollisionStart F hex + lam) := hperiod.2
        _ = iterateMap F (minCollisionStart F hex + lam + (y - x)) := hcomp'
        _ = iterateMap F (minCollisionStart F hex + (y - x) + lam) := by
          (congr 1; omega)
        _ = iterateMap F (minCollisionStart F hex + (y - x)) := hrw.symm
    have hcandidate : IsPositivePeriod F hex (y - x) := ⟨hsmall.1, hcollision⟩
    have hle := minPositivePeriod_le F hex hcandidate
    omega
  by_contra hrs
  rcases lt_or_gt_of_ne hrs with hrs' | hsr
  · exact aux hrs' hs h
  · exact aux hsr hr h.symm

/-- T_F と C_F は交わらない。 -/
theorem transientPart_disjoint_cyclePart :
    Disjoint (transientPart F hex) (cyclePart F hex) := by
  rw [Finset.disjoint_left]
  intro g hgT hgC
  rcases Finset.mem_image.mp hgT with ⟨a, ha, rfl⟩
  rcases Finset.mem_image.mp hgC with ⟨r, _hr, hEq⟩
  exact iterateMap_before_ne_after_minCollisionStart F hex
    (Finset.mem_range.mp ha) (Nat.le_add_right _ _) hEq.symm

/-- |T_F| = μ_F。 -/
theorem card_transientPart :
    (transientPart F hex).card = minCollisionStart F hex := by
  rw [transientPart, Finset.card_image_iff.mpr]
  · simp
  · intro a ha b hb h
    exact iterateMap_injective_before_minCollisionStart F hex
      (Finset.mem_range.mp ha) (Finset.mem_range.mp hb) h

/-- |C_F| = λ_F。 -/
theorem card_cyclePart :
    (cyclePart F hex).card = minPositivePeriod F hex := by
  rw [cyclePart, Finset.card_image_iff.mpr]
  · simp
  · intro r hr s hs h
    exact iterateMap_injective_in_cycle F hex
      (Finset.mem_range.mp hr) (Finset.mem_range.mp hs) h

/-- 過渡部と巡回部の和は反復モノイド P_F の全要素をちょうど列挙する。 -/
theorem mem_transientPart_union_cyclePart_iff_powerSet (g : X → X) :
    g ∈ transientPart F hex ∪ cyclePart F hex ↔ g ∈ powerSet F := by
  constructor
  · intro hg
    rcases Finset.mem_union.mp hg with hgT | hgC
    · rcases Finset.mem_image.mp hgT with ⟨n, _hn, rfl⟩
      exact ⟨n, rfl⟩
    · rcases Finset.mem_image.mp hgC with ⟨r, _hr, rfl⟩
      exact ⟨minCollisionStart F hex + r, rfl⟩
  · rintro ⟨n, rfl⟩
    by_cases hn : n < minCollisionStart F hex
    · exact Finset.mem_union_left _
        (Finset.mem_image.mpr ⟨n, Finset.mem_range.mpr hn, rfl⟩)
    · have htail : iterateMap F n ∈ tail F (minCollisionStart F hex) := by
        refine ⟨n - minCollisionStart F hex, ?_⟩
        congr 1
        omega
      exact Finset.mem_union_right _
        ((mem_tail_minCollisionStart_iff_mem_cyclePart F hex _).mp htail)

/-- P_F = T_F ⊔ C_F かつ |P_F| = μ_F + λ_F。 -/
theorem transient_cycle_partition_cardinality :
    Disjoint (transientPart F hex) (cyclePart F hex) ∧
      (transientPart F hex ∪ cyclePart F hex).card =
        minCollisionStart F hex + minPositivePeriod F hex := by
  have hdisjoint := transientPart_disjoint_cyclePart F hex
  refine ⟨hdisjoint, ?_⟩
  rw [Finset.card_union_of_disjoint hdisjoint, card_transientPart, card_cyclePart]

/-- 二つの有限集合への所属判定は P_F への所属判定と一致する（hex は型クラス合成では
    渡せないので instance ではなく def として与える）。 -/
noncomputable def decidableMemPowerSet (g : X → X) : Decidable (g ∈ powerSet F) :=
  decidable_of_iff (g ∈ transientPart F hex ∪ cyclePart F hex)
    (mem_transientPart_union_cyclePart_iff_powerSet F hex g)

end CellularAutomata.NecSuf.IterateMonoidTailCycleDecomposition
