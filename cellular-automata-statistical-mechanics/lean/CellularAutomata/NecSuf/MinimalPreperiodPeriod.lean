/-
章「最小前周期と最小周期」の必要十分版。

具体版と同じく、前周期・周期の組を一回の衝突で特徴づけ、Nat.find で二つの最小元を取り、
周期の倍数と最小前周期への移送を経て上界と有限走査を示す。必要なのは自己写像と有限性、
有限走査の決定には等号判定だけである。二値状態、セル、近傍、局所規則、R / C は使わない。
-/
import CellularAutomata.NecSuf.GlobalMapIteration

namespace CellularAutomata.NecSuf.MinimalPreperiodPeriod

open CellularAutomata.NecSuf.GlobalMapIteration

variable {X : Type} (F : X → X)

def IsPeriodicityPair (x : X) (i p : ℕ) : Prop :=
  1 ≤ p ∧ ∀ n : ℕ, i ≤ n → iterate F (n + p) x = iterate F n x

theorem exists_periodicityPair [Fintype X] (x : X) :
    ∃ i p : ℕ, IsPeriodicityPair F x i p := by
  obtain ⟨i, p, hp, _, h⟩ := eventual_periodicity F x
  exact ⟨i, p, hp, h⟩

theorem isPeriodicityPair_iff_collision (x : X) (i p : ℕ) :
    IsPeriodicityPair F x i p ↔ (1 ≤ p ∧ iterate F (i + p) x = iterate F i x) := by
  constructor
  · rintro ⟨hp, h⟩
    exact ⟨hp, h i le_rfl⟩
  · rintro ⟨hp, h⟩
    refine ⟨hp, ?_⟩
    intro n hn
    have hk := collision_shift F x h (n - i)
    have h1 : i + p + (n - i) = n + p := by omega
    have h2 : i + (n - i) = n := by omega
    rw [h1, h2] at hk
    exact hk

def IsPreperiod (x : X) (i : ℕ) : Prop := ∃ p : ℕ, IsPeriodicityPair F x i p

theorem exists_preperiod [Fintype X] (x : X) : ∃ i : ℕ, IsPreperiod F x i := by
  obtain ⟨i, p, h⟩ := exists_periodicityPair F x
  exact ⟨i, p, h⟩

instance [DecidableEq X] (x : X) (i p : ℕ) : Decidable (IsPeriodicityPair F x i p) :=
  decidable_of_iff _ (isPeriodicityPair_iff_collision F x i p).symm

open Classical in
noncomputable def minPreperiod [Fintype X] (x : X) : ℕ :=
  Nat.find (p := fun i => IsPreperiod F x i) (exists_preperiod F x)

theorem minPreperiod_spec [Fintype X] (x : X) : IsPreperiod F x (minPreperiod F x) := by
  classical
  exact Nat.find_spec (exists_preperiod F x)

theorem minPreperiod_le [Fintype X] (x : X) {i : ℕ} (h : IsPreperiod F x i) :
    minPreperiod F x ≤ i := by
  classical
  exact Nat.find_min' (exists_preperiod F x) h

theorem exists_period_at_minPreperiod [Fintype X] (x : X) :
    ∃ p : ℕ, IsPeriodicityPair F x (minPreperiod F x) p := minPreperiod_spec F x

open Classical in
noncomputable def minPeriod [Fintype X] (x : X) : ℕ :=
  Nat.find (p := fun p => IsPeriodicityPair F x (minPreperiod F x) p)
    (exists_period_at_minPreperiod F x)

theorem minPeriod_spec [Fintype X] (x : X) :
    IsPeriodicityPair F x (minPreperiod F x) (minPeriod F x) := by
  classical
  exact Nat.find_spec (exists_period_at_minPreperiod F x)

theorem minPeriod_le [Fintype X] (x : X) {p : ℕ}
    (h : IsPeriodicityPair F x (minPreperiod F x) p) : minPeriod F x ≤ p := by
  classical
  exact Nat.find_min' (exists_period_at_minPreperiod F x) h

theorem one_le_minPeriod [Fintype X] (x : X) : 1 ≤ minPeriod F x := (minPeriod_spec F x).1

theorem period_multiples (x : X) {i q : ℕ}
    (h : iterate F (i + q) x = iterate F i x) (k : ℕ) :
    iterate F (i + k * q) x = iterate F i x := by
  induction k with
  | zero => simp
  | succ k ih =>
    have hs := collision_shift F x h (k * q)
    have h1 : i + q + k * q = i + (k + 1) * q := by rw [Nat.succ_mul]; omega
    rw [h1] at hs
    rw [hs, ih]

theorem period_descends_to_minPreperiod [Fintype X] (x : X) {i p : ℕ}
    (h : IsPeriodicityPair F x i p) :
    iterate F (minPreperiod F x + p) x = iterate F (minPreperiod F x) x ∧
      IsPeriodicityPair F x (minPreperiod F x) p ∧ minPeriod F x ≤ p := by
  set μ := minPreperiod F x
  set q := minPeriod F x
  have hq1 : 1 ≤ q := one_le_minPeriod F x
  have hμq := ((isPeriodicityPair_iff_collision F x μ q).1 (minPeriod_spec F x)).2
  have hμi : μ ≤ i := minPreperiod_le F x ⟨p, h⟩
  set k := i - μ
  have hkq : i ≤ μ + k * q := by
    have : k ≤ k * q := Nat.le_mul_of_pos_right k hq1
    omega
  have hmul := period_multiples F x hμq k
  have hn := h.2 (μ + k * q) hkq
  have hsh := collision_shift F x hmul p
  have hcol : iterate F (μ + p) x = iterate F μ x := by rw [← hsh, hn, hmul]
  have hpair := (isPeriodicityPair_iff_collision F x μ p).2 ⟨h.1, hcol⟩
  exact ⟨hcol, hpair, minPeriod_le F x hpair⟩

theorem minPreperiod_add_minPeriod_le [Fintype X] (x : X) :
    minPreperiod F x + minPeriod F x ≤ Fintype.card X := by
  obtain ⟨i, p, hp, hM, hall⟩ := eventual_periodicity F x
  have hpair : IsPeriodicityPair F x i p := ⟨hp, hall⟩
  have h1 := minPreperiod_le F x ⟨p, hpair⟩
  have h2 := (period_descends_to_minPreperiod F x hpair).2.2
  omega

/-- 有限走査で調べる組。`i+p≤M` は人手証明の `p≤M-i` と同値。 -/
def scanPeriodicityPairs (M : ℕ) : Finset (ℕ × ℕ) :=
  (Finset.range (M + 1)).product (Finset.range (M + 1)) |>.filter
    (fun q => 1 ≤ q.2 ∧ q.1 + q.2 ≤ M)

theorem mem_scanPeriodicityPairs (M i p : ℕ) :
    (i, p) ∈ scanPeriodicityPairs M ↔ i ≤ M ∧ 1 ≤ p ∧ i + p ≤ M := by
  simp [scanPeriodicityPairs]
  omega

theorem minimal_pair_mem_scan [Fintype X] (x : X) :
    (minPreperiod F x, minPeriod F x) ∈ scanPeriodicityPairs (Fintype.card X) := by
  apply (mem_scanPeriodicityPairs _ _ _).2
  have h := minPreperiod_add_minPeriod_le F x
  exact ⟨by omega, one_le_minPeriod F x, h⟩

theorem scan_pair_has_minimal_bounds [Fintype X] (x : X) {i p : ℕ}
    (_ : (i, p) ∈ scanPeriodicityPairs (Fintype.card X))
    (h : iterate F (i + p) x = iterate F i x) :
    minPreperiod F x ≤ i ∧ minPeriod F x ≤ p := by
  have hpair := (isPeriodicityPair_iff_collision F x i p).2
    ⟨((mem_scanPeriodicityPairs _ i p).1 ‹_›).2.1, h⟩
  exact ⟨minPreperiod_le F x ⟨p, hpair⟩,
    (period_descends_to_minPreperiod F x hpair).2.2⟩

instance [DecidableEq X] (x : X) (M : ℕ) :
    Decidable (∃ q ∈ scanPeriodicityPairs M, iterate F (q.1 + q.2) x = iterate F q.1 x) :=
  Finset.decidableExistsAndFinset

end CellularAutomata.NecSuf.MinimalPreperiodPeriod
