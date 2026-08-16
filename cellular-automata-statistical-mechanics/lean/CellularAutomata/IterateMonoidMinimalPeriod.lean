/-
章「反復モノイドの最小正周期」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-minimal-period.ts。

有限舞台上の二値 CA の大域写像について、最小衝突開始位置で戻る正周期、
その最小元、周期の伝播、最小正周期が全正周期を割り切ること、有限判定を、
人手証明と同じ順序で形式化する。有限集合と自然数だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidStabilizationIndex

namespace CellularAutomata.IterateMonoidMinimalPeriod

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidStabilizationIndex

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- p が最小衝突開始位置で戻る正周期であること
    （`def_iterate_monoid_minimal_positive_period` の Π_F への所属）。 -/
def IsPositivePeriod (p : ℕ) : Prop :=
  0 < p ∧ iterateMap N f (minCollisionStart N f) =
    iterateMap N f (minCollisionStart N f + p)

/-- Π_F は空でない。 -/
theorem exists_positivePeriod : ∃ p : ℕ, IsPositivePeriod N f p := by
  rcases minCollisionStart_spec N f with ⟨p, hp, h⟩
  exact ⟨p, hp, h⟩

open Classical in
/-- λ_F := min Π_F（自然数の整列性）。 -/
noncomputable def minPositivePeriod : ℕ :=
  Nat.find (p := fun p => IsPositivePeriod N f p) (exists_positivePeriod N f)

theorem minPositivePeriod_spec : IsPositivePeriod N f (minPositivePeriod N f) := by
  classical
  exact Nat.find_spec (exists_positivePeriod N f)

theorem minPositivePeriod_le {p : ℕ} (h : IsPositivePeriod N f p) :
    minPositivePeriod N f ≤ p := by
  classical
  exact Nat.find_min' (exists_positivePeriod N f) h

theorem minPositivePeriod_pos : 0 < minPositivePeriod N f :=
  (minPositivePeriod_spec N f).1

/-- 最小衝突開始位置での周期は、その位置以後へ伝わる
    （`claim_iterate_monoid_period_propagates_after_collision_start`）。 -/
theorem period_propagates_after_collision_start {p n : ℕ}
    (hp : 0 < p ∧ iterateMap N f (minCollisionStart N f) =
      iterateMap N f (minCollisionStart N f + p))
    (hn : minCollisionStart N f ≤ n) :
    iterateMap N f n = iterateMap N f (n + p) := by
  let k := n - minCollisionStart N f
  have hnk : n = minCollisionStart N f + k := by omega
  have hcomp := congrArg (fun g => iterateMap N f k ∘ g) hp.2
  rw [iterateMap_comp_add, iterateMap_comp_add] at hcomp
  simpa [hnk, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hcomp

/-- 最小正周期は全ての正周期を割り切る
    （`claim_iterate_monoid_minimal_period_divides_every_period`）。 -/
theorem minPositivePeriod_dvd {p : ℕ} (hp : IsPositivePeriod N f p) :
    minPositivePeriod N f ∣ p := by
  set μ := minCollisionStart N f with hμ
  set lam := minPositivePeriod N f with hlam
  have hlam_pos : 0 < lam := by simpa [hlam] using minPositivePeriod_pos N f
  have hlam_period : IsPositivePeriod N f lam := by
    simpa [hlam] using minPositivePeriod_spec N f
  obtain ⟨q, r, hpqr, hr⟩ : ∃ q r : ℕ, p = q * lam + r ∧ r < lam :=
    ⟨p / lam, p % lam, (Nat.div_add_mod' p lam).symm,
      Nat.mod_lt p hlam_pos⟩
  have hmultiple : ∀ d : ℕ, iterateMap N f (μ + r) =
      iterateMap N f (μ + r + d * lam) := by
    intro d
    induction d with
    | zero => simp
    | succ d ih =>
      have hstep : iterateMap N f (μ + r + d * lam) =
          iterateMap N f (μ + r + d * lam + lam) :=
        period_propagates_after_collision_start N f hlam_period (by omega)
      calc
        iterateMap N f (μ + r) = iterateMap N f (μ + r + d * lam) := ih
        _ = iterateMap N f (μ + r + (d + 1) * lam) := by
          simpa [Nat.succ_mul, Nat.add_assoc] using hstep
  have hr_collision : iterateMap N f μ = iterateMap N f (μ + r) := by
    have hq := hmultiple q
    have hp_eq : iterateMap N f μ = iterateMap N f (μ + p) := by
      simpa [hμ] using hp.2
    calc
      iterateMap N f μ = iterateMap N f (μ + p) := hp_eq
      _ = iterateMap N f (μ + r + q * lam) := by
        simp [hpqr, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm]
      _ = iterateMap N f (μ + r) := hq.symm
  have hr_zero : r = 0 := by
    by_contra hne
    have hr_period : IsPositivePeriod N f r := by
      refine ⟨by omega, ?_⟩
      simpa [hμ] using hr_collision
    have hle : lam ≤ r := by
      simpa [hlam] using minPositivePeriod_le N f hr_period
    omega
  refine ⟨q, ?_⟩
  simpa [hlam, hr_zero, Nat.mul_comm] using hpqr

/-- 各候補 p の Π_F への所属は有限個の二値状態等号で決定できる。
    Π_F の非空性と自然数の整列性により、最初に成立する候補 λ_F も有限回で得られる
    （`claim_iterate_monoid_minimal_period_finite_decidability`）。 -/
noncomputable instance (p : ℕ) : Decidable (IsPositivePeriod N f p) :=
  instDecidableAnd

end CellularAutomata.IterateMonoidMinimalPeriod
