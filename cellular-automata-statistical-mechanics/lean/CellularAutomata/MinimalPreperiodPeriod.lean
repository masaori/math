/-
章「最小前周期と最小周期」の具体版。
人手証明の正本は structured-latex/content/minimal-preperiod-period.ts。

前章の反復 F^n・衝突移送・最終周期性を受けて、人手証明と同じ対象・仮定・順序で
前周期・周期の組の集合 P(y)、「(i,p) ∈ P(y) ⟺ p ≥ 1 かつ F^{i+p} y = F^i y」、
最小前周期 μ(y) と最小周期 π(y)（ℕ の整列性 = `Nat.find` による最小元）、周期の倍数も周期であること、
任意の周期が最小前周期の位置へ降りること、μ(y)+π(y) ≤ 2^{|V|} を形式化する。
ℕ について使うのは加法・乗法・大小比較・等号・整列性だけで、R / C は使わない。

対応表（人手証明 → この file）
  def_periodicity_pairs                      `IsPeriodicityPair`
  claim_periodicity_pair_iff_collision       `isPeriodicityPair_iff_collision`
  def_min_preperiod                          `IsPreperiod`, `minPreperiod`, `minPreperiod_spec`, `minPreperiod_le`
  def_min_period                             `minPeriod`, `minPeriod_spec`, `minPeriod_le`, `one_le_minPeriod`
  claim_period_multiples                     `period_multiples`
  claim_period_descends_to_min_preperiod     `period_descends_to_minPreperiod`
  claim_min_preperiod_period_bound           `minPreperiod_add_minPeriod_le`
  claim_min_preperiod_period_finite_decidability
                                                `scanPeriodicityPairs`, `minimal_pair_mem_scan`,
                                                `scan_pair_has_minimal_bounds`
-/
import CellularAutomata.GlobalMapIteration
import CellularAutomata.NecSuf.MinimalPreperiodPeriod

namespace CellularAutomata.MinimalPreperiodPeriod

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- (i, p) が y の前周期・周期の組であること（`def_periodicity_pairs`）:
    p ≥ 1 かつ ∀ n ≥ i, F^{n+p} y = F^n y。 -/
def IsPeriodicityPair (y : V → State) (i p : ℕ) : Prop :=
  1 ≤ p ∧ ∀ n : ℕ, i ≤ n → iterate N f (n + p) y = iterate N f n y

/-- P(y) ≠ ∅（`claim_finite_self_map_repeating_tail` による）。 -/
theorem exists_periodicityPair (y : V → State) : ∃ i p : ℕ, IsPeriodicityPair N f y i p := by
  obtain ⟨i, p, hp, _, h⟩ := eventual_periodicity N f y
  exact ⟨i, p, hp, h⟩

omit [Fintype V] [DecidableEq V] in
/-- 組の所属は 1 回の配位の等号と同値である（`claim_periodicity_pair_iff_collision`）。 -/
theorem isPeriodicityPair_iff_collision (y : V → State) (i p : ℕ) :
    IsPeriodicityPair N f y i p ↔ (1 ≤ p ∧ iterate N f (i + p) y = iterate N f i y) := by
  constructor
  · rintro ⟨hp, h⟩
    -- n := i（i ≤ i は反射性）
    exact ⟨hp, h i le_rfl⟩
  · rintro ⟨hp, h⟩
    refine ⟨hp, ?_⟩
    intro n hn
    -- k := n - i。衝突移送を F^{i+p} y = F^i y と k に適用する。
    have hk := collision_shift N f y h (n - i)
    have h1 : i + p + (n - i) = n + p := by omega
    have h2 : i + (n - i) = n := by omega
    rw [h1, h2] at hk
    exact hk

/-- i が y の前周期であること（I(y) の所属）: ∃ p, (i,p) ∈ P(y)。 -/
def IsPreperiod (y : V → State) (i : ℕ) : Prop := ∃ p : ℕ, IsPeriodicityPair N f y i p

theorem exists_preperiod (y : V → State) : ∃ i : ℕ, IsPreperiod N f y i := by
  obtain ⟨i, p, h⟩ := exists_periodicityPair N f y
  exact ⟨i, p, h⟩

/-- I(y) の所属は有限個の等号検査で決まる（配位の等号は決定可能）。人手証明の同値を通す。 -/
instance (y : V → State) (i p : ℕ) : Decidable (IsPeriodicityPair N f y i p) :=
  decidable_of_iff _ (isPeriodicityPair_iff_collision N f y i p).symm

open Classical in
/-- 最小前周期 μ(y) := min I(y)（`def_min_preperiod`。ℕ の整列性）。 -/
noncomputable def minPreperiod (y : V → State) : ℕ :=
  Nat.find (p := fun i => IsPreperiod N f y i) (exists_preperiod N f y)

theorem minPreperiod_spec (y : V → State) : IsPreperiod N f y (minPreperiod N f y) := by
  classical
  exact Nat.find_spec (exists_preperiod N f y)

theorem minPreperiod_le (y : V → State) {i : ℕ} (h : IsPreperiod N f y i) :
    minPreperiod N f y ≤ i := by
  classical
  exact Nat.find_min' (exists_preperiod N f y) h

/-- Q(y) := { p : (μ(y), p) ∈ P(y) } ≠ ∅（μ(y) ∈ I(y) による）。 -/
theorem exists_period_at_minPreperiod (y : V → State) :
    ∃ p : ℕ, IsPeriodicityPair N f y (minPreperiod N f y) p :=
  minPreperiod_spec N f y

open Classical in
/-- 最小周期 π(y) := min Q(y)（`def_min_period`）。 -/
noncomputable def minPeriod (y : V → State) : ℕ :=
  Nat.find (p := fun p => IsPeriodicityPair N f y (minPreperiod N f y) p)
    (exists_period_at_minPreperiod N f y)

theorem minPeriod_spec (y : V → State) :
    IsPeriodicityPair N f y (minPreperiod N f y) (minPeriod N f y) := by
  classical
  exact Nat.find_spec (exists_period_at_minPreperiod N f y)

theorem minPeriod_le (y : V → State) {p : ℕ}
    (h : IsPeriodicityPair N f y (minPreperiod N f y) p) : minPeriod N f y ≤ p := by
  classical
  exact Nat.find_min' (exists_period_at_minPreperiod N f y) h

theorem one_le_minPeriod (y : V → State) : 1 ≤ minPeriod N f y :=
  (minPeriod_spec N f y).1

omit [Fintype V] [DecidableEq V] in
/-- 周期の倍数も周期である（`claim_period_multiples`。k の帰納法）。 -/
theorem period_multiples (y : V → State) {i q : ℕ}
    (h : iterate N f (i + q) y = iterate N f i y) (k : ℕ) :
    iterate N f (i + k * q) y = iterate N f i y := by
  induction k with
  | zero => simp
  | succ k ih =>
    -- i + (k+1) q = (i + q) + k q。衝突移送を h と k q に適用し、帰納法の仮定へ繋ぐ。
    have hs := collision_shift N f y h (k * q)
    have h1 : i + q + k * q = i + (k + 1) * q := by rw [Nat.succ_mul]; omega
    rw [h1] at hs
    rw [hs, ih]

/-- 任意の周期は最小前周期の位置へ降りる（`claim_period_descends_to_min_preperiod`）:
    (i,p) ∈ P(y) ならば F^{μ+p} y = F^μ y、(μ,p) ∈ P(y)、π(y) ≤ p。 -/
theorem period_descends_to_minPreperiod (y : V → State) {i p : ℕ}
    (h : IsPeriodicityPair N f y i p) :
    iterate N f (minPreperiod N f y + p) y = iterate N f (minPreperiod N f y) y ∧
      IsPeriodicityPair N f y (minPreperiod N f y) p ∧ minPeriod N f y ≤ p := by
  set μ := minPreperiod N f y with hμ
  set q := minPeriod N f y with hq
  have hq1 : 1 ≤ q := one_le_minPeriod N f y
  have hμq : iterate N f (μ + q) y = iterate N f μ y :=
    ((isPeriodicityPair_iff_collision N f y μ q).1 (minPeriod_spec N f y)).2
  have hμi : μ ≤ i := minPreperiod_le N f y ⟨p, h⟩
  -- k := i - μ。kq ≥ k（q ≥ 1）なので μ + kq ≥ i。
  set k := i - μ with hk
  have hkq : i ≤ μ + k * q := by
    have : k ≤ k * q := Nat.le_mul_of_pos_right k hq1
    omega
  have hp1 : 1 ≤ p := h.1
  -- 周期の倍数: F^{μ+kq} y = F^μ y。
  have hmul := period_multiples N f y hμq k
  -- (i,p) ∈ P(y) の全称文を n := μ + kq に適用: F^{μ+kq+p} y = F^{μ+kq} y。
  have hn := h.2 (μ + k * q) hkq
  -- 衝突移送を F^{μ+kq} y = F^μ y と p に適用: F^{μ+kq+p} y = F^{μ+p} y。
  have hsh := collision_shift N f y hmul p
  have hcol : iterate N f (μ + p) y = iterate N f μ y := by
    rw [← hsh, hn, hmul]
  have hpair : IsPeriodicityPair N f y μ p :=
    (isPeriodicityPair_iff_collision N f y μ p).2 ⟨hp1, hcol⟩
  exact ⟨hcol, hpair, minPeriod_le N f y hpair⟩

/-- μ(y) + π(y) ≤ 2^{|V|}（`claim_min_preperiod_period_bound`）。 -/
theorem minPreperiod_add_minPeriod_le (y : V → State) :
    minPreperiod N f y + minPeriod N f y ≤ 2 ^ Fintype.card V := by
  obtain ⟨i, p, hp, hM, hall⟩ := eventual_periodicity N f y
  have hpair : IsPeriodicityPair N f y i p := ⟨hp, hall⟩
  have h1 : minPreperiod N f y ≤ i := minPreperiod_le N f y ⟨p, hpair⟩
  have h2 : minPeriod N f y ≤ p := (period_descends_to_minPreperiod N f y hpair).2.2
  omega

/-- 有限範囲 [0,M]×[1,M-i] に対応する候補組。 -/
def scanPeriodicityPairs (M : ℕ) : Finset (ℕ × ℕ) :=
  (Finset.range (M + 1)).product (Finset.range (M + 1)) |>.filter
    (fun q => 1 ≤ q.2 ∧ q.1 + q.2 ≤ M)

theorem mem_scanPeriodicityPairs (M i p : ℕ) :
    (i, p) ∈ scanPeriodicityPairs M ↔ i ≤ M ∧ 1 ≤ p ∧ i + p ≤ M := by
  simp [scanPeriodicityPairs]
  omega

/-- (μ(y),π(y)) は有限走査範囲に入る。 -/
theorem minimal_pair_mem_scan (y : V → State) :
    (minPreperiod N f y, minPeriod N f y) ∈ scanPeriodicityPairs (2 ^ Fintype.card V) := by
  apply (mem_scanPeriodicityPairs _ _ _).2
  have h := minPreperiod_add_minPeriod_le N f y
  exact ⟨by omega, one_le_minPeriod N f y, h⟩

/-- 走査中に見つかるどの周期組も、μ と π より前にはない。 -/
theorem scan_pair_has_minimal_bounds (y : V → State) {i p : ℕ}
    (hmem : (i, p) ∈ scanPeriodicityPairs (2 ^ Fintype.card V))
    (h : iterate N f (i + p) y = iterate N f i y) :
    minPreperiod N f y ≤ i ∧ minPeriod N f y ≤ p := by
  have hp := ((mem_scanPeriodicityPairs _ i p).1 hmem).2.1
  have hpair := (isPeriodicityPair_iff_collision N f y i p).2 ⟨hp, h⟩
  exact ⟨minPreperiod_le N f y ⟨p, hpair⟩,
    (period_descends_to_minPreperiod N f y hpair).2.2⟩

/-- 有限候補組に周期組があるという命題は有限個の配位等号で決定できる。 -/
instance (y : V → State) (M : ℕ) :
    Decidable (∃ q ∈ scanPeriodicityPairs M,
      iterate N f (q.1 + q.2) y = iterate N f q.1 y) :=
  Finset.decidableExistsAndFinset

/-! ## 必要十分版からの導出 -/

omit [Fintype V] [DecidableEq V] in
theorem isPeriodicityPair_iff_necessary_sufficient (y : V → State) (i p : ℕ) :
    IsPeriodicityPair N f y i p ↔
      CellularAutomata.NecSuf.MinimalPreperiodPeriod.IsPeriodicityPair
        (globalMap N f) y i p := by
  simp only [IsPeriodicityPair,
    CellularAutomata.NecSuf.MinimalPreperiodPeriod.IsPeriodicityPair,
    CellularAutomata.GlobalMapIteration.iterate_eq_necessary_sufficient]

omit [Fintype V] [DecidableEq V] in
theorem isPreperiod_iff_necessary_sufficient (y : V → State) (i : ℕ) :
    IsPreperiod N f y i ↔
      CellularAutomata.NecSuf.MinimalPreperiodPeriod.IsPreperiod
        (globalMap N f) y i := by
  constructor <;> rintro ⟨p, hp⟩
  · exact ⟨p, (isPeriodicityPair_iff_necessary_sufficient N f y i p).1 hp⟩
  · exact ⟨p, (isPeriodicityPair_iff_necessary_sufficient N f y i p).2 hp⟩

theorem minPreperiod_eq_necessary_sufficient (y : V → State) :
    minPreperiod N f y =
      CellularAutomata.NecSuf.MinimalPreperiodPeriod.minPreperiod (globalMap N f) y := by
  apply le_antisymm
  · apply minPreperiod_le N f y
    exact (isPreperiod_iff_necessary_sufficient N f y _).2
      (CellularAutomata.NecSuf.MinimalPreperiodPeriod.minPreperiod_spec (globalMap N f) y)
  · apply CellularAutomata.NecSuf.MinimalPreperiodPeriod.minPreperiod_le (globalMap N f) y
    exact (isPreperiod_iff_necessary_sufficient N f y _).1 (minPreperiod_spec N f y)

theorem minPeriod_eq_necessary_sufficient (y : V → State) :
    minPeriod N f y =
      CellularAutomata.NecSuf.MinimalPreperiodPeriod.minPeriod (globalMap N f) y := by
  apply le_antisymm
  · apply minPeriod_le N f y
    apply (isPeriodicityPair_iff_necessary_sufficient N f y _ _).2
    rw [minPreperiod_eq_necessary_sufficient N f y]
    exact CellularAutomata.NecSuf.MinimalPreperiodPeriod.minPeriod_spec (globalMap N f) y
  · apply CellularAutomata.NecSuf.MinimalPreperiodPeriod.minPeriod_le (globalMap N f) y
    rw [← minPreperiod_eq_necessary_sufficient N f y]
    exact (isPeriodicityPair_iff_necessary_sufficient N f y _ _).1 (minPeriod_spec N f y)

omit [Fintype V] [DecidableEq V] in
theorem period_multiples_from_necessary_sufficient (y : V → State) {i q : ℕ}
    (h : iterate N f (i + q) y = iterate N f i y) (k : ℕ) :
    iterate N f (i + k * q) y = iterate N f i y := by
  simp only [CellularAutomata.GlobalMapIteration.iterate_eq_necessary_sufficient] at h ⊢
  exact CellularAutomata.NecSuf.MinimalPreperiodPeriod.period_multiples
    (globalMap N f) y h k

theorem scanPeriodicityPairs_eq_necessary_sufficient (M : ℕ) :
    scanPeriodicityPairs M =
      CellularAutomata.NecSuf.MinimalPreperiodPeriod.scanPeriodicityPairs M := rfl

theorem minimal_scan_range_from_necessary_sufficient (y : V → State) :
    ∃ q ∈ scanPeriodicityPairs (2 ^ Fintype.card V),
      iterate N f (q.1 + q.2) y = iterate N f q.1 y := by
  exact ⟨(minPreperiod N f y, minPeriod N f y), minimal_pair_mem_scan N f y,
    ((isPeriodicityPair_iff_collision N f y _ _).1 (minPeriod_spec N f y)).2⟩

theorem minPreperiod_add_minPeriod_le_from_necessary_sufficient (y : V → State) :
    minPreperiod N f y + minPeriod N f y ≤ 2 ^ Fintype.card V := by
  have h := CellularAutomata.NecSuf.MinimalPreperiodPeriod.minPreperiod_add_minPeriod_le
    (globalMap N f) y
  rw [← minPreperiod_eq_necessary_sufficient N f y,
    ← minPeriod_eq_necessary_sufficient N f y] at h
  simpa only [GlobalMapIteration.card_config] using h

end CellularAutomata.MinimalPreperiodPeriod
