/-
章「周期点の個数」の具体版。
人手証明の正本は structured-latex/content/periodic-point-count.ts。

前章の反復 F^n・衝突移送・最小前周期 μ(y)・最小周期 π(y)・周期の倍数を受けて、人手証明と同じ
対象・仮定・順序で、各 n ≥ 1 の反復の不動点集合 Fix_n(F) とその個数 Z_n(F) ∈ ℕ、周期点集合 Per(F)、
「y ∈ Per(F) ⟺ μ(y) = 0」、「y ∈ Fix_n(F) ⟺ μ(y) = 0 かつ ∃k, n = k π(y)」（ℕ の除法の原理と
π(y) の最小性）、Z_n(F) の最小周期ごとの個数への分解、Fix_n の所属と Z_n の有限決定を形式化する。
ℕ について使うのは加法・乗法・大小比較・等号・除法の原理だけで、R / C は使わない。
「分配関数」「トレース」の名前は使わず、Z_n は Finset の個数としてだけ定義する。
等号検査回数のコストモデル自体は形式化していない（前章までと同じ）。

対応表（人手証明 → この file）
  def_fixed_points_of_iterate                 `fixedPoints`, `mem_fixedPoints`, `fixedPointCount`
  def_periodic_points                         `IsPeriodicPoint`, `isPeriodicPoint_iff_exists_mem_fixedPoints`
  claim_periodic_iff_min_preperiod_zero       `isPeriodicPoint_iff_minPreperiod_zero`
  claim_fixed_iff_min_period_divides          `mem_fixedPoints_iff_minPeriod_dvd`
  claim_fixed_point_count_decomposition       `minPeriodClass`, `divisorSet`, `mem_divisorSet`,
                                              `fixedPointCount_eq_sum_minPeriodClass`
  claim_fixed_point_count_finite_decidability `mem_fixedPoints_iff_config_eq`,
                                              `instance : DecidablePred (· ∈ fixedPoints N f n)`,
                                              `fixedPointCount_eq_card_filter_univ`, `card_univ_config`
-/
import CellularAutomata.MinimalPreperiodPeriod

namespace CellularAutomata.PeriodicPointCount

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.MinimalPreperiodPeriod

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 反復の不動点集合 Fix_n(F) := { y ∈ A^V : F^n y = y }（`def_fixed_points_of_iterate`）。 -/
def fixedPoints (n : ℕ) : Finset (V → State) :=
  Finset.univ.filter (fun y => iterate N f n y = y)

theorem mem_fixedPoints (n : ℕ) (y : V → State) :
    y ∈ fixedPoints N f n ↔ iterate N f n y = y := by
  simp [fixedPoints]

/-- Z_n(F) := |Fix_n(F)| ∈ ℕ（`def_fixed_points_of_iterate`）。 -/
def fixedPointCount (n : ℕ) : ℕ := (fixedPoints N f n).card

/-- y ∈ Per(F)（`def_periodic_points`）: ∃ n ≥ 1, F^n y = y。 -/
def IsPeriodicPoint (y : V → State) : Prop := ∃ n : ℕ, 1 ≤ n ∧ iterate N f n y = y

theorem isPeriodicPoint_iff_exists_mem_fixedPoints (y : V → State) :
    IsPeriodicPoint N f y ↔ ∃ n : ℕ, 1 ≤ n ∧ y ∈ fixedPoints N f n := by
  simp only [IsPeriodicPoint, mem_fixedPoints]

/-- 周期点であることは最小前周期が 0 であることと同値（`claim_periodic_iff_min_preperiod_zero`）。 -/
theorem isPeriodicPoint_iff_minPreperiod_zero (y : V → State) :
    IsPeriodicPoint N f y ↔ minPreperiod N f y = 0 := by
  constructor
  · rintro ⟨n, hn, h⟩
    -- F^{0+n} y = F^0 y なので (0,n) ∈ P(y)、よって 0 ∈ I(y)、最小性から μ(y) ≤ 0。
    have h0 : iterate N f (0 + n) y = iterate N f 0 y := by
      rw [Nat.zero_add, iterate_zero]; exact h
    have hpair : IsPeriodicityPair N f y 0 n :=
      (isPeriodicityPair_iff_collision N f y 0 n).2 ⟨hn, h0⟩
    have hle := minPreperiod_le N f y ⟨n, hpair⟩
    omega
  · intro hμ
    -- (μ(y), π(y)) = (0, π(y)) ∈ P(y) から F^{π(y)} y = y。証人は n := π(y)。
    refine ⟨minPeriod N f y, one_le_minPeriod N f y, ?_⟩
    have hcol := ((isPeriodicityPair_iff_collision N f y _ _).1 (minPeriod_spec N f y)).2
    rw [hμ, Nat.zero_add, iterate_zero] at hcol
    exact hcol

/-- 反復の不動点であることは μ(y) = 0 かつ π(y) が n を割り切ることと同値
    （`claim_fixed_iff_min_period_divides`）。 -/
theorem mem_fixedPoints_iff_minPeriod_dvd (n : ℕ) (hn : 1 ≤ n) (y : V → State) :
    y ∈ fixedPoints N f n ↔
      (minPreperiod N f y = 0 ∧ ∃ k : ℕ, n = k * minPeriod N f y) := by
  rw [mem_fixedPoints]
  set q := minPeriod N f y with hq
  have hq1 : 1 ≤ q := one_le_minPeriod N f y
  constructor
  · intro h
    -- y ∈ Per(F) なので μ(y) = 0。
    have hμ : minPreperiod N f y = 0 :=
      (isPeriodicPoint_iff_minPreperiod_zero N f y).1 ⟨n, hn, h⟩
    refine ⟨hμ, ?_⟩
    -- F^{0+q} y = F^0 y。
    have hμq : iterate N f (0 + q) y = iterate N f 0 y := by
      have := ((isPeriodicityPair_iff_collision N f y _ _).1 (minPeriod_spec N f y)).2
      rw [hμ] at this
      exact this
    -- 除法の原理: n = k q + r, r < q。
    obtain ⟨k, r, hkr, hlt⟩ : ∃ k r : ℕ, n = k * q + r ∧ r < q :=
      ⟨n / q, n % q, (Nat.div_add_mod' n q).symm, Nat.mod_lt n (by omega)⟩
    refine ⟨k, ?_⟩
    -- r = 0 を示す。r ≥ 1 と仮定して矛盾を導く。
    by_contra hne
    set m := k * q with hm
    have hr : 1 ≤ r := by omega
    -- 周期の倍数: F^{0+kq} y = F^0 y。
    have hmul : iterate N f (0 + m) y = iterate N f 0 y := period_multiples N f y hμq k
    -- 衝突移送を F^{0+kq} y = F^0 y と r に適用: F^{0+kq+r} y = F^{0+r} y。
    have hsh := collision_shift N f y hmul r
    have hn' : 0 + m + r = n := by omega
    rw [hn', h] at hsh
    -- F^{0+r} y = F^0 y かつ r ≥ 1 なので (0,r) ∈ P(y)。μ(y) = 0 なので π(y) ≤ r。
    have hpair : IsPeriodicityPair N f y 0 r :=
      (isPeriodicityPair_iff_collision N f y 0 r).2 ⟨hr, by rw [← hsh, iterate_zero]⟩
    have hpair' : IsPeriodicityPair N f y (minPreperiod N f y) r := by rw [hμ]; exact hpair
    have hle : q ≤ r := minPeriod_le N f y hpair'
    -- r < q と矛盾。
    omega
  · rintro ⟨hμ, k, hk⟩
    -- F^{0+q} y = F^0 y、周期の倍数で F^{0+kq} y = F^0 y = y。
    have hμq : iterate N f (0 + q) y = iterate N f 0 y := by
      have := ((isPeriodicityPair_iff_collision N f y _ _).1 (minPeriod_spec N f y)).2
      rw [hμ] at this
      exact this
    have hmul := period_multiples N f y hμq k
    rw [Nat.zero_add, iterate_zero] at hmul
    rw [hk]
    exact hmul

open Classical in
/-- 最小周期 d のクラス C_d(F) := { y : μ(y) = 0 かつ π(y) = d }（`claim_fixed_point_count_decomposition`）。 -/
noncomputable def minPeriodClass (d : ℕ) : Finset (V → State) :=
  Finset.univ.filter (fun y => minPreperiod N f y = 0 ∧ minPeriod N f y = d)

/-- 和の添字集合: n を割り切る d ∈ [1,n]_ℕ。 -/
def divisorSet (n : ℕ) : Finset ℕ := (Finset.Icc 1 n).filter (fun d => d ∣ n)

theorem mem_divisorSet (n d : ℕ) :
    d ∈ divisorSet n ↔ (1 ≤ d ∧ d ≤ n ∧ ∃ k : ℕ, n = k * d) := by
  simp only [divisorSet, Finset.mem_filter, Finset.mem_Icc]
  constructor
  · rintro ⟨⟨h1, h2⟩, ⟨c, hc⟩⟩
    exact ⟨h1, h2, c, by rw [hc, Nat.mul_comm]⟩
  · rintro ⟨h1, h2, c, hc⟩
    exact ⟨⟨h1, h2⟩, ⟨c, by rw [hc, Nat.mul_comm]⟩⟩

/-- Z_n(F) = Σ_{d ∈ [1,n]_ℕ, d ∣ n} |C_d(F)|（`claim_fixed_point_count_decomposition`）。
    Fix_n を π(y) の値ごとに分ける（各 y の π(y) は一意なので互いに素）。 -/
theorem fixedPointCount_eq_sum_minPeriodClass (n : ℕ) (hn : 1 ≤ n) :
    fixedPointCount N f n = ∑ d ∈ divisorSet n, (minPeriodClass N f d).card := by
  classical
  unfold fixedPointCount
  -- Fix_n の各 y について π(y) ∈ divisorSet n（π(y) ≤ k π(y) = n）。
  have hmaps : ∀ y ∈ fixedPoints N f n, minPeriod N f y ∈ divisorSet n := by
    intro y hy
    obtain ⟨hμ, k, hk⟩ := (mem_fixedPoints_iff_minPeriod_dvd N f n hn y).1 hy
    apply (mem_divisorSet n _).2
    have hq1 := one_le_minPeriod N f y
    have hk1 : 1 ≤ k := by
      rcases k with _ | k
      · simp at hk; omega
      · omega
    refine ⟨hq1, ?_, k, hk⟩
    calc minPeriod N f y = 1 * minPeriod N f y := (Nat.one_mul _).symm
      _ ≤ k * minPeriod N f y := Nat.mul_le_mul_right _ hk1
      _ = n := hk.symm
  rw [Finset.card_eq_sum_card_fiberwise hmaps]
  apply Finset.sum_congr rfl
  intro d hd
  congr 1
  -- Fix_n ∩ {π = d} = C_d（d ∣ n のとき）。
  ext y
  simp only [Finset.mem_filter, minPeriodClass, Finset.mem_univ, true_and]
  obtain ⟨_, _, k, hk⟩ := (mem_divisorSet n d).1 hd
  constructor
  · rintro ⟨hy, hπ⟩
    exact ⟨((mem_fixedPoints_iff_minPeriod_dvd N f n hn y).1 hy).1, hπ⟩
  · rintro ⟨hμ, hπ⟩
    refine ⟨(mem_fixedPoints_iff_minPeriod_dvd N f n hn y).2 ⟨hμ, k, ?_⟩, hπ⟩
    rw [hπ]; exact hk

/-- Fix_n の所属は配位の等号 F^n y = y の 1 回で決まる（`claim_fixed_point_count_finite_decidability`）。 -/
theorem mem_fixedPoints_iff_config_eq (n : ℕ) (y : V → State) :
    y ∈ fixedPoints N f n ↔ ∀ v : V, iterate N f n y v = y v := by
  rw [mem_fixedPoints, config_eq_iff]

/-- 所属は決定可能（配位の等号は各セルの状態の等号の有限個の連言）。 -/
instance (n : ℕ) : DecidablePred (· ∈ fixedPoints N f n) := fun _ =>
  Finset.decidableMem _ _

/-- Z_n(F) は全配位を走査して等号が成り立つものを数えた個数である。 -/
theorem fixedPointCount_eq_card_filter_univ (n : ℕ) :
    fixedPointCount N f n =
      (Finset.univ.filter (fun y : V → State => iterate N f n y = y)).card := rfl

/-- 走査する配位の総数は |A^V| = 2^{|V|}。 -/
theorem card_univ_config : (Finset.univ : Finset (V → State)).card = 2 ^ Fintype.card V := by
  rw [Finset.card_univ, card_config]

end CellularAutomata.PeriodicPointCount
