/-
章「反復モノイドの巡回部にある唯一の冪等元」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-cycle-idempotent.ts。

有限舞台上の二値 CA の大域写像について、安定後にある最小の周期倍数指数、
その反復写像の巡回部所属と冪等性、巡回部内での一意性、有限決定を、
人手証明と同じ順序で形式化する。有限集合と自然数だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidTailCycleDecomposition
import Mathlib.Data.Nat.ModEq

namespace CellularAutomata.IterateMonoidCycleIdempotent

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidPrincipalIdealTail
open CellularAutomata.IterateMonoidStabilizationIndex
open CellularAutomata.IterateMonoidMinimalPeriod
open CellularAutomata.IterateMonoidTailCycleDecomposition

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- D_F への所属: 最小衝突開始位置以後にある最小正周期の倍数。 -/
def IsStablePeriodMultiple (n : ℕ) : Prop :=
  minCollisionStart N f ≤ n ∧ minPositivePeriod N f ∣ n

/-- D_F は空でない（`claim_iterate_monoid_stable_period_multiple_exists`）。 -/
theorem exists_stablePeriodMultiple : ∃ n : ℕ, IsStablePeriodMultiple N f n := by
  let μ := minCollisionStart N f
  let lam := minPositivePeriod N f
  have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos N f
  refine ⟨μ * lam, ?_, ⟨μ, by simp [lam, Nat.mul_comm]⟩⟩
  exact Nat.le_mul_of_pos_right μ hlam

/-- e_F := min D_F。 -/
noncomputable def minStablePeriodMultiple : ℕ := by
  classical
  exact Nat.find (exists_stablePeriodMultiple N f)

theorem minStablePeriodMultiple_spec :
    IsStablePeriodMultiple N f (minStablePeriodMultiple N f) :=
  by
    classical
    exact Nat.find_spec (exists_stablePeriodMultiple N f)

theorem minStablePeriodMultiple_le {n : ℕ} (hn : IsStablePeriodMultiple N f n) :
    minStablePeriodMultiple N f ≤ n :=
  by
    classical
    exact Nat.find_min' (exists_stablePeriodMultiple N f) hn

/-- E_F := F^{e_F}。 -/
noncomputable def cycleIdempotent : (V → State) → (V → State) :=
  iterateMap N f (minStablePeriodMultiple N f)

/-- 最小正周期を安定後から q 回適用する。 -/
theorem minPeriod_multiple_after_start {n : ℕ}
    (hn : minCollisionStart N f ≤ n) (q : ℕ) :
    iterateMap N f n = iterateMap N f (n + q * minPositivePeriod N f) := by
  induction q with
  | zero => simp
  | succ q ih =>
    calc
      iterateMap N f n = iterateMap N f (n + q * minPositivePeriod N f) := ih
      _ = iterateMap N f (n + q * minPositivePeriod N f + minPositivePeriod N f) :=
        period_propagates_after_collision_start N f (minPositivePeriod_spec N f) (by omega)
      _ = iterateMap N f (n + (q + 1) * minPositivePeriod N f) := by
        congr 1
        simp [Nat.succ_mul, Nat.add_assoc]

/-- 安定後の指数を最小正周期の剰余へ還元する。 -/
theorem iterateMap_reduce_to_cycle (k : ℕ) :
    iterateMap N f (minCollisionStart N f + k) =
      iterateMap N f
        (minCollisionStart N f + k % minPositivePeriod N f) := by
  let lam := minPositivePeriod N f
  have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos N f
  have hkform : k = k % lam + (k / lam) * lam := by
    simpa [Nat.mul_comm] using (Nat.mod_add_div k lam).symm
  have h := minPeriod_multiple_after_start N f
    (n := minCollisionStart N f + k % lam) (by omega) (k / lam)
  rw [hkform]
  simpa [lam, Nat.add_assoc] using h.symm

/-- E_F は巡回部に属し、冪等である
    （`claim_iterate_monoid_cycle_idempotent_candidate_is_idempotent`）。 -/
theorem cycleIdempotent_mem_and_idempotent :
    cycleIdempotent N f ∈ cyclePart N f ∧
      cycleIdempotent N f ∘ cycleIdempotent N f = cycleIdempotent N f := by
  let e := minStablePeriodMultiple N f
  let lam := minPositivePeriod N f
  have he := minStablePeriodMultiple_spec N f
  rcases he.2 with ⟨q, hq⟩
  have heStart : minCollisionStart N f ≤ e := by simpa [e] using he.1
  have htail : iterateMap N f e ∈ tail N f (minCollisionStart N f) := by
    refine ⟨e - minCollisionStart N f, ?_⟩
    congr 1
    omega
  refine ⟨(mem_tail_minCollisionStart_iff_mem_cyclePart N f _).mp htail, ?_⟩
  rw [cycleIdempotent, iterateMap_comp_add]
  have hperiod := minPeriod_multiple_after_start N f he.1 q
  have heq : e = q * lam := by simpa [e, lam, Nat.mul_comm] using hq
  simpa [cycleIdempotent, e, lam, heq, Nat.add_assoc] using hperiod.symm

/-- 巡回部の冪等元は E_F に等しい
    （`claim_iterate_monoid_cycle_idempotent_unique`）。 -/
theorem cycle_idempotent_unique
    (g : (V → State) → (V → State))
    (hgCycle : g ∈ cyclePart N f) (hgIdem : g ∘ g = g) :
    g = cycleIdempotent N f := by
  rcases Finset.mem_image.mp hgCycle with ⟨r, hrMem, hgr⟩
  have hr : r < minPositivePeriod N f := Finset.mem_range.mp hrMem
  let μ := minCollisionStart N f
  let lam := minPositivePeriod N f
  let n := μ + r
  let s := (μ + 2 * r) % lam
  have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos N f
  have hs : s < lam := Nat.mod_lt _ hlam
  have hdouble : iterateMap N f (n + n) = iterateMap N f n := by
    rw [← iterateMap_comp_add]
    simpa [n, μ, hgr] using hgIdem
  have hreduce : iterateMap N f (n + n) = iterateMap N f (μ + s) := by
    have h := iterateMap_reduce_to_cycle N f (μ + 2 * r)
    simpa [n, μ, lam, s, Nat.add_assoc, two_mul, Nat.add_comm, Nat.add_left_comm] using h
  have hrs : r = s := by
    apply iterateMap_injective_in_cycle N f hr hs
    calc
      iterateMap N f (μ + r) = iterateMap N f n := rfl
      _ = iterateMap N f (n + n) := hdouble.symm
      _ = iterateMap N f (μ + s) := hreduce
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
  have hnStable : IsStablePeriodMultiple N f n := by
    exact ⟨by simp [n, μ], by simpa [lam] using hnDvd⟩
  have hen := minStablePeriodMultiple_le N f hnStable
  have heSpec := minStablePeriodMultiple_spec N f
  rcases heSpec.2 with ⟨a, ha⟩
  rcases hnDvd with ⟨b, hb⟩
  have ha' : minStablePeriodMultiple N f = lam * a := by simpa [lam] using ha
  have hab : a ≤ b := by
    apply Nat.le_of_mul_le_mul_left (c := lam) (by simpa [ha', hb] using hen) hlam
  let t := b - a
  have hnt : n = minStablePeriodMultiple N f + t * lam := by
    calc
      n = lam * b := hb
      _ = lam * (a + (b - a)) := by rw [Nat.add_sub_of_le hab]
      _ = lam * a + (b - a) * lam := by rw [Nat.mul_add]; congr 1; rw [Nat.mul_comm]
      _ = minStablePeriodMultiple N f + t * lam := by simpa [t] using congrArg (fun x => x + (b - a) * lam) ha'.symm
  have hprop := minPeriod_multiple_after_start N f heSpec.1 t
  calc
    g = iterateMap N f (μ + r) := hgr.symm
    _ = iterateMap N f n := rfl
    _ = iterateMap N f (minStablePeriodMultiple N f + t * lam) := by rw [hnt]
    _ = iterateMap N f (minStablePeriodMultiple N f) := hprop.symm
    _ = cycleIdempotent N f := rfl

/-- e_F の所属は決定可能で、自然数の整列性により有限走査で得られる。 -/
noncomputable instance (n : ℕ) : Decidable (IsStablePeriodMultiple N f n) :=
  instDecidableAnd

end CellularAutomata.IterateMonoidCycleIdempotent
