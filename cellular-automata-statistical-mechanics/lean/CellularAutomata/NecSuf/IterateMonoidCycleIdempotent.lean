/-
章「反復モノイドの巡回部にある唯一の冪等元」の必要十分版。

具体版と同じ手順（安定後周期倍数指数の存在と最小元、周期の逐次適用、安定後指数の一周期への
剰余還元、候補 E_F の巡回部所属と冪等性、巡回部の冪等元の一意性、有限決定）を保ち、
実際に使う構造だけを残す。

* 安定後周期倍数の存在と最小元、周期の逐次適用、剰余還元、E_F の冪等性、および
  「巡回部の指数 μ_F + r（r < λ_F）にある冪等な反復写像は E_F に等しい」ことには、
  型 X、自己写像 F : X → X、衝突開始位置の存在だけが要る。X の有限性はその存在を与える側に
  だけ現れ、この章の定理には現れない。
* X → X の等号判定（`DecidableEq (X → X)`）は、巡回部を前章の `Finset` として書き、
  「E_F ∈ C_F」「g ∈ C_F かつ冪等 → g = E_F」の形で述べる段階にだけ要る。使わない定理には
  `omit` を付けた。
* 有限決定は、e_F の定義域の所属判定が自然数の等号と整除の判定に分解されることだけである。
* 二値状態、セル、近傍、局所規則は現れない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidTailCycleDecomposition
import Mathlib.Data.Nat.ModEq

namespace CellularAutomata.NecSuf.IterateMonoidCycleIdempotent

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail
open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
open CellularAutomata.NecSuf.IterateMonoidMinimalPeriod
open CellularAutomata.NecSuf.IterateMonoidTailCycleDecomposition

variable {X : Type} [DecidableEq (X → X)]
variable (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

omit [DecidableEq (X → X)] in
/-- D_F への所属: 最小衝突開始位置以後にある最小正周期の倍数。 -/
def IsStablePeriodMultiple (n : ℕ) : Prop :=
  minCollisionStart F hex ≤ n ∧ minPositivePeriod F hex ∣ n

omit [DecidableEq (X → X)] in
/-- D_F は空でない。証人は μ_F · λ_F。 -/
theorem exists_stablePeriodMultiple : ∃ n : ℕ, IsStablePeriodMultiple F hex n := by
  let μ := minCollisionStart F hex
  let lam := minPositivePeriod F hex
  have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos F hex
  refine ⟨μ * lam, ?_, ⟨μ, by simp [lam, Nat.mul_comm]⟩⟩
  exact Nat.le_mul_of_pos_right μ hlam

omit [DecidableEq (X → X)] in
/-- e_F := min D_F。 -/
noncomputable def minStablePeriodMultiple : ℕ := by
  classical
  exact Nat.find (exists_stablePeriodMultiple F hex)

omit [DecidableEq (X → X)] in
theorem minStablePeriodMultiple_spec :
    IsStablePeriodMultiple F hex (minStablePeriodMultiple F hex) := by
  classical
  exact Nat.find_spec (exists_stablePeriodMultiple F hex)

omit [DecidableEq (X → X)] in
theorem minStablePeriodMultiple_le {n : ℕ} (hn : IsStablePeriodMultiple F hex n) :
    minStablePeriodMultiple F hex ≤ n := by
  classical
  exact Nat.find_min' (exists_stablePeriodMultiple F hex) hn

omit [DecidableEq (X → X)] in
/-- E_F := F^{e_F}。 -/
noncomputable def cycleIdempotent : X → X :=
  iterateMap F (minStablePeriodMultiple F hex)

omit [DecidableEq (X → X)] in
/-- 最小正周期を安定後から q 回適用する。周期伝播だけを使う。 -/
theorem minPeriod_multiple_after_start {n : ℕ}
    (hn : minCollisionStart F hex ≤ n) (q : ℕ) :
    iterateMap F n = iterateMap F (n + q * minPositivePeriod F hex) := by
  induction q with
  | zero => simp
  | succ q ih =>
    calc
      iterateMap F n = iterateMap F (n + q * minPositivePeriod F hex) := ih
      _ = iterateMap F (n + q * minPositivePeriod F hex + minPositivePeriod F hex) :=
        period_propagates_after_collision_start F hex (minPositivePeriod_spec F hex) (by omega)
      _ = iterateMap F (n + (q + 1) * minPositivePeriod F hex) := by
        congr 1
        simp [Nat.succ_mul, Nat.add_assoc]

omit [DecidableEq (X → X)] in
/-- 安定後の指数を最小正周期の剰余へ還元する。自然数の除法と周期の逐次適用だけを使う。 -/
theorem iterateMap_reduce_to_cycle (k : ℕ) :
    iterateMap F (minCollisionStart F hex + k) =
      iterateMap F
        (minCollisionStart F hex + k % minPositivePeriod F hex) := by
  let lam := minPositivePeriod F hex
  have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos F hex
  have hkform : k = k % lam + (k / lam) * lam := by
    simpa [Nat.mul_comm] using (Nat.mod_add_div k lam).symm
  have h := minPeriod_multiple_after_start F hex
    (n := minCollisionStart F hex + k % lam) (by omega) (k / lam)
  rw [hkform]
  simpa [lam, Nat.add_assoc] using h.symm

omit [DecidableEq (X → X)] in
/-- E_F は冪等である。加法則と周期の逐次適用だけを使う。 -/
theorem cycleIdempotent_idempotent :
    cycleIdempotent F hex ∘ cycleIdempotent F hex = cycleIdempotent F hex := by
  let e := minStablePeriodMultiple F hex
  let lam := minPositivePeriod F hex
  have he := minStablePeriodMultiple_spec F hex
  rcases he.2 with ⟨q, hq⟩
  rw [cycleIdempotent, iterateMap_comp_add]
  have hperiod := minPeriod_multiple_after_start F hex he.1 q
  have heq : e = q * lam := by simpa [e, lam, Nat.mul_comm] using hq
  simpa [cycleIdempotent, e, lam, heq, Nat.add_assoc] using hperiod.symm

/-- E_F は巡回部（Finset）に属する。ここでだけ等号判定が要る。 -/
theorem cycleIdempotent_mem_cyclePart :
    cycleIdempotent F hex ∈ cyclePart F hex := by
  have he := minStablePeriodMultiple_spec F hex
  have htail : iterateMap F (minStablePeriodMultiple F hex) ∈
      tail F (minCollisionStart F hex) := by
    refine ⟨minStablePeriodMultiple F hex - minCollisionStart F hex, ?_⟩
    congr 1
    have := he.1
    omega
  exact (mem_tail_minCollisionStart_iff_mem_cyclePart F hex _).mp htail

/-- E_F は巡回部に属し、冪等である。 -/
theorem cycleIdempotent_mem_and_idempotent :
    cycleIdempotent F hex ∈ cyclePart F hex ∧
      cycleIdempotent F hex ∘ cycleIdempotent F hex = cycleIdempotent F hex :=
  ⟨cycleIdempotent_mem_cyclePart F hex, cycleIdempotent_idempotent F hex⟩

omit [DecidableEq (X → X)] in
/-- 巡回部の指数 μ_F + r（r < λ_F）にある冪等な反復写像は E_F に等しい。
    一周期内の単射性、剰余の一致、最小性、周期の逐次適用だけを使い、等号判定は要らない。 -/
theorem cycle_idempotent_unique_of_index {r : ℕ}
    (hr : r < minPositivePeriod F hex)
    (hgIdem : iterateMap F (minCollisionStart F hex + r) ∘
      iterateMap F (minCollisionStart F hex + r) =
      iterateMap F (minCollisionStart F hex + r)) :
    iterateMap F (minCollisionStart F hex + r) = cycleIdempotent F hex := by
  let μ := minCollisionStart F hex
  let lam := minPositivePeriod F hex
  let n := μ + r
  let s := (μ + 2 * r) % lam
  have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos F hex
  have hs : s < lam := Nat.mod_lt _ hlam
  have hdouble : iterateMap F (n + n) = iterateMap F n := by
    rw [← iterateMap_comp_add]
    simpa [n, μ] using hgIdem
  have hreduce : iterateMap F (n + n) = iterateMap F (μ + s) := by
    have h := iterateMap_reduce_to_cycle F hex (μ + 2 * r)
    simpa [n, μ, lam, s, Nat.add_assoc, two_mul, Nat.add_comm, Nat.add_left_comm] using h
  have hrs : r = s := by
    apply iterateMap_injective_in_cycle F hex hr hs
    calc
      iterateMap F (μ + r) = iterateMap F n := rfl
      _ = iterateMap F (n + n) := hdouble.symm
      _ = iterateMap F (μ + s) := hreduce
  have hmodeq : μ + 2 * r ≡ r [MOD lam] := by
    show (μ + 2 * r) % lam = r % lam
    calc
      (μ + 2 * r) % lam = s := rfl
      _ = r := hrs.symm
      _ = r % lam := (Nat.mod_eq_of_lt hr).symm
  have hsum : (μ + r) + r ≡ 0 + r [MOD lam] := by
    simpa [Nat.add_assoc, two_mul] using hmodeq
  have hnDvd : lam ∣ n := by
    apply Nat.modEq_zero_iff_dvd.mp
    simpa [n] using (Nat.ModEq.rfl.add_right_cancel hsum)
  have hnStable : IsStablePeriodMultiple F hex n := by
    exact ⟨by simp [n, μ], by simpa [lam] using hnDvd⟩
  have hen := minStablePeriodMultiple_le F hex hnStable
  have heSpec := minStablePeriodMultiple_spec F hex
  rcases heSpec.2 with ⟨a, ha⟩
  rcases hnDvd with ⟨b, hb⟩
  have ha' : minStablePeriodMultiple F hex = lam * a := by simpa [lam] using ha
  have hab : a ≤ b := by
    apply Nat.le_of_mul_le_mul_left (c := lam) (by simpa [ha', hb] using hen) hlam
  let t := b - a
  have hnt : n = minStablePeriodMultiple F hex + t * lam := by
    calc
      n = lam * b := hb
      _ = lam * (a + (b - a)) := by rw [Nat.add_sub_of_le hab]
      _ = lam * a + (b - a) * lam := by rw [Nat.mul_add]; congr 1; rw [Nat.mul_comm]
      _ = minStablePeriodMultiple F hex + t * lam := by
        simpa [t] using congrArg (fun x => x + (b - a) * lam) ha'.symm
  have hprop := minPeriod_multiple_after_start F hex heSpec.1 t
  calc
    iterateMap F (μ + r) = iterateMap F n := rfl
    _ = iterateMap F (minStablePeriodMultiple F hex + t * lam) := by rw [hnt]
    _ = iterateMap F (minStablePeriodMultiple F hex) := hprop.symm
    _ = cycleIdempotent F hex := rfl

/-- 巡回部（Finset）の冪等元は E_F に等しい。等号判定は所属を Finset で述べるためだけに要る。 -/
theorem cycle_idempotent_unique
    (g : X → X) (hgCycle : g ∈ cyclePart F hex) (hgIdem : g ∘ g = g) :
    g = cycleIdempotent F hex := by
  rcases Finset.mem_image.mp hgCycle with ⟨r, hrMem, hgr⟩
  have hr : r < minPositivePeriod F hex := Finset.mem_range.mp hrMem
  subst hgr
  exact cycle_idempotent_unique_of_index F hex hr hgIdem

omit [DecidableEq (X → X)] in
/-- e_F の所属判定は自然数の大小と整除の判定に分解される。 -/
noncomputable def decidableIsStablePeriodMultiple (n : ℕ) :
    Decidable (IsStablePeriodMultiple F hex n) :=
  instDecidableAnd

end CellularAutomata.NecSuf.IterateMonoidCycleIdempotent
