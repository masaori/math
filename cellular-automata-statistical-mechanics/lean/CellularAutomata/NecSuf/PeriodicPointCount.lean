/-
章「周期点の個数」の必要十分版。

具体版と同じ順序で、反復の不動点、周期点、最小前周期・最小周期による特徴づけ、
最小周期ごとの個数分解、有限走査を示す。必要なのは有限型 X 上の自己写像 F : X → X だけである。
有限走査を実行可能な判定として取り出す箇所では X の等号判定を使う。
二値状態、セル、近傍、局所規則、物理的名称、R / C は使わない。
-/
import CellularAutomata.NecSuf.MinimalPreperiodPeriod

namespace CellularAutomata.NecSuf.PeriodicPointCount

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.MinimalPreperiodPeriod

variable {X : Type} (F : X → X)

open Classical in
/-- 自己写像 F の n 回反復の不動点集合。 -/
noncomputable def fixedPoints [Fintype X] (n : ℕ) : Finset X :=
  Finset.univ.filter (fun x => iterate F n x = x)

theorem mem_fixedPoints [Fintype X] (n : ℕ) (x : X) :
    x ∈ fixedPoints F n ↔ iterate F n x = x := by
  classical
  simp [fixedPoints]

/-- n 回反復の不動点の個数。 -/
noncomputable def fixedPointCount [Fintype X] (n : ℕ) : ℕ :=
  (fixedPoints F n).card

/-- 周期点であること。有限性は定義には要らない。 -/
def IsPeriodicPoint (x : X) : Prop := ∃ n : ℕ, 1 ≤ n ∧ iterate F n x = x

theorem isPeriodicPoint_iff_exists_mem_fixedPoints [Fintype X] (x : X) :
    IsPeriodicPoint F x ↔ ∃ n : ℕ, 1 ≤ n ∧ x ∈ fixedPoints F n := by
  classical
  simp only [IsPeriodicPoint, mem_fixedPoints]

/-- 周期点であることは最小前周期が 0 であることと同値。 -/
theorem isPeriodicPoint_iff_minPreperiod_zero [Fintype X] (x : X) :
    IsPeriodicPoint F x ↔ minPreperiod F x = 0 := by
  constructor
  · rintro ⟨n, hn, h⟩
    have h0 : iterate F (0 + n) x = iterate F 0 x := by
      rw [Nat.zero_add, iterate_zero]
      exact h
    have hpair : IsPeriodicityPair F x 0 n :=
      (isPeriodicityPair_iff_collision F x 0 n).2 ⟨hn, h0⟩
    have hle := minPreperiod_le F x ⟨n, hpair⟩
    omega
  · intro hμ
    refine ⟨minPeriod F x, one_le_minPeriod F x, ?_⟩
    have hcol := ((isPeriodicityPair_iff_collision F x _ _).1 (minPeriod_spec F x)).2
    rw [hμ, Nat.zero_add, iterate_zero] at hcol
    exact hcol

/-- n 回反復の不動点であることは、最小前周期が 0 で最小周期が n を割り切ることと同値。 -/
theorem mem_fixedPoints_iff_minPeriod_dvd [Fintype X]
    (n : ℕ) (hn : 1 ≤ n) (x : X) :
    x ∈ fixedPoints F n ↔
      (minPreperiod F x = 0 ∧ ∃ k : ℕ, n = k * minPeriod F x) := by
  classical
  rw [mem_fixedPoints]
  set q := minPeriod F x with hq
  have hq1 : 1 ≤ q := one_le_minPeriod F x
  constructor
  · intro h
    have hμ : minPreperiod F x = 0 :=
      (isPeriodicPoint_iff_minPreperiod_zero F x).1 ⟨n, hn, h⟩
    refine ⟨hμ, ?_⟩
    have hμq : iterate F (0 + q) x = iterate F 0 x := by
      have h' := ((isPeriodicityPair_iff_collision F x _ _).1 (minPeriod_spec F x)).2
      rw [hμ] at h'
      exact h'
    obtain ⟨k, r, hkr, hlt⟩ : ∃ k r : ℕ, n = k * q + r ∧ r < q :=
      ⟨n / q, n % q, (Nat.div_add_mod' n q).symm, Nat.mod_lt n (by omega)⟩
    refine ⟨k, ?_⟩
    by_contra hne
    set m := k * q with hm
    have hr : 1 ≤ r := by omega
    have hmul : iterate F (0 + m) x = iterate F 0 x := period_multiples F x hμq k
    have hsh := collision_shift F x hmul r
    have hn' : 0 + m + r = n := by omega
    rw [hn', h] at hsh
    have hpair : IsPeriodicityPair F x 0 r :=
      (isPeriodicityPair_iff_collision F x 0 r).2
        ⟨hr, by rw [← hsh, iterate_zero]⟩
    have hpair' : IsPeriodicityPair F x (minPreperiod F x) r := by
      rw [hμ]
      exact hpair
    have hle : q ≤ r := minPeriod_le F x hpair'
    omega
  · rintro ⟨hμ, k, hk⟩
    have hμq : iterate F (0 + q) x = iterate F 0 x := by
      have h' := ((isPeriodicityPair_iff_collision F x _ _).1 (minPeriod_spec F x)).2
      rw [hμ] at h'
      exact h'
    have hmul := period_multiples F x hμq k
    rw [Nat.zero_add, iterate_zero] at hmul
    rw [hk]
    exact hmul

open Classical in
/-- 最小周期 d の周期点の有限集合。 -/
noncomputable def minPeriodClass [Fintype X] (d : ℕ) : Finset X :=
  Finset.univ.filter (fun x => minPreperiod F x = 0 ∧ minPeriod F x = d)

/-- n を割り切る d ∈ [1,n]_N の有限集合。 -/
def divisorSet (n : ℕ) : Finset ℕ := (Finset.Icc 1 n).filter (fun d => d ∣ n)

theorem mem_divisorSet (n d : ℕ) :
    d ∈ divisorSet n ↔ (1 ≤ d ∧ d ≤ n ∧ ∃ k : ℕ, n = k * d) := by
  simp only [divisorSet, Finset.mem_filter, Finset.mem_Icc]
  constructor
  · rintro ⟨⟨h1, h2⟩, ⟨c, hc⟩⟩
    exact ⟨h1, h2, c, by rw [hc, Nat.mul_comm]⟩
  · rintro ⟨h1, h2, c, hc⟩
    exact ⟨⟨h1, h2⟩, ⟨c, by rw [hc, Nat.mul_comm]⟩⟩

/-- 不動点の個数を最小周期ごとの個数へ分解する。 -/
theorem fixedPointCount_eq_sum_minPeriodClass [Fintype X]
    (n : ℕ) (hn : 1 ≤ n) :
    fixedPointCount F n = ∑ d ∈ divisorSet n, (minPeriodClass F d).card := by
  classical
  unfold fixedPointCount
  have hmaps : ∀ x ∈ fixedPoints F n, minPeriod F x ∈ divisorSet n := by
    intro x hx
    obtain ⟨_, k, hk⟩ := (mem_fixedPoints_iff_minPeriod_dvd F n hn x).1 hx
    apply (mem_divisorSet n _).2
    have hq1 := one_le_minPeriod F x
    have hk1 : 1 ≤ k := by
      rcases k with _ | k
      · simp at hk
        omega
      · omega
    refine ⟨hq1, ?_, k, hk⟩
    calc minPeriod F x = 1 * minPeriod F x := (Nat.one_mul _).symm
      _ ≤ k * minPeriod F x := Nat.mul_le_mul_right _ hk1
      _ = n := hk.symm
  rw [Finset.card_eq_sum_card_fiberwise hmaps]
  apply Finset.sum_congr rfl
  intro d hd
  congr 1
  ext x
  simp only [Finset.mem_filter, minPeriodClass, Finset.mem_univ, true_and]
  obtain ⟨_, _, k, hk⟩ := (mem_divisorSet n d).1 hd
  constructor
  · rintro ⟨hx, hπ⟩
    exact ⟨((mem_fixedPoints_iff_minPeriod_dvd F n hn x).1 hx).1, hπ⟩
  · rintro ⟨hμ, hπ⟩
    refine ⟨(mem_fixedPoints_iff_minPeriod_dvd F n hn x).2 ⟨hμ, k, ?_⟩, hπ⟩
    rw [hπ]
    exact hk

/-- 不動点集合への所属は反復値の等号一つに帰着する。 -/
theorem mem_fixedPoints_iff_eq [Fintype X] (n : ℕ) (x : X) :
    x ∈ fixedPoints F n ↔ iterate F n x = x := mem_fixedPoints F n x

open Classical in
/-- 不動点の個数は有限集合 X 全体を filter した個数である。 -/
theorem fixedPointCount_eq_card_filter_univ [Fintype X] (n : ℕ) :
    fixedPointCount F n =
      (Finset.univ.filter (fun x : X => iterate F n x = x)).card := by
  classical
  rfl

/-- X の等号が決定可能なら、不動点条件 iterate F n x = x も決定可能である。 -/
instance [DecidableEq X] (n : ℕ) (x : X) : Decidable (iterate F n x = x) :=
  decEq _ _

end CellularAutomata.NecSuf.PeriodicPointCount
