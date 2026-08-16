/-
章「反復モノイドの最小正周期」の必要十分版。

具体版と同じ手順（最小衝突開始位置で戻る正周期の述語、Π_F の非空性、自然数の整列性による
最小正周期、最小性、加法則による周期の伝播、自然数の除法と帰納法による整除、各候補の有限判定）を
保ち、実際に使う構造だけを残す。

* 正周期の述語と最小正周期に要るのは、型 X、自己写像 F : X → X、および衝突開始位置の存在
  （前章の必要十分版の `minCollisionStart` の入力）だけである。X の有限性はこの存在を与える
  ためにだけ使い、この章の定理には現れない。
* Π_F の非空性は最小衝突開始位置の定義（`minCollisionStart_spec`）そのものから従う。
* 周期の伝播に要るのは反復写像の加法則（`iterateMap_comp_add`）だけである。
* 整除に要るのは、周期の伝播、自然数の除法（商と余り）、余りについての帰納法、および
  最小性だけである。
* 各候補の有限判定に要るのは X → X の等号判定だけである（走査の各段は写像の等号 1 回）。
* 二値状態、セル、近傍、局所規則は現れない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidStabilizationIndex

namespace CellularAutomata.NecSuf.IterateMonoidMinimalPeriod

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex

variable {X : Type}

/-- p が最小衝突開始位置で戻る正周期であること。X に構造は要らず、
    衝突開始位置の存在だけを仮定する。 -/
def IsPositivePeriod (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) (p : ℕ) : Prop :=
  0 < p ∧ iterateMap F (minCollisionStart F hex) =
    iterateMap F (minCollisionStart F hex + p)

/-- Π_F は空でない。最小衝突開始位置の定義から従う。 -/
theorem exists_positivePeriod (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) :
    ∃ p : ℕ, IsPositivePeriod F hex p := by
  rcases minCollisionStart_spec F hex with ⟨p, hp, h⟩
  exact ⟨p, hp, h⟩

open Classical in
/-- λ_F := min Π_F（自然数の整列性）。 -/
noncomputable def minPositivePeriod (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) : ℕ :=
  Nat.find (p := fun p => IsPositivePeriod F hex p) (exists_positivePeriod F hex)

theorem minPositivePeriod_spec (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) :
    IsPositivePeriod F hex (minPositivePeriod F hex) := by
  classical
  exact Nat.find_spec (exists_positivePeriod F hex)

theorem minPositivePeriod_le (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) {p : ℕ}
    (h : IsPositivePeriod F hex p) : minPositivePeriod F hex ≤ p := by
  classical
  exact Nat.find_min' (exists_positivePeriod F hex) h

theorem minPositivePeriod_pos (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) :
    0 < minPositivePeriod F hex :=
  (minPositivePeriod_spec F hex).1

/-- 最小衝突開始位置での周期は、その位置以後へ伝わる。加法則だけを使う。 -/
theorem period_propagates_after_collision_start (F : X → X)
    (hex : ∃ n : ℕ, IsCollisionStart F n) {p n : ℕ}
    (hp : 0 < p ∧ iterateMap F (minCollisionStart F hex) =
      iterateMap F (minCollisionStart F hex + p))
    (hn : minCollisionStart F hex ≤ n) :
    iterateMap F n = iterateMap F (n + p) := by
  let k := n - minCollisionStart F hex
  have hnk : n = minCollisionStart F hex + k := by omega
  have hcomp := congrArg (fun g => iterateMap F k ∘ g) hp.2
  rw [iterateMap_comp_add, iterateMap_comp_add] at hcomp
  simpa [hnk, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hcomp

/-- 最小正周期は全ての正周期を割り切る。除法・帰納法・最小性だけを使う。 -/
theorem minPositivePeriod_dvd (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) {p : ℕ}
    (hp : IsPositivePeriod F hex p) : minPositivePeriod F hex ∣ p := by
  set μ := minCollisionStart F hex with hμ
  set lam := minPositivePeriod F hex with hlam
  have hlam_pos : 0 < lam := by simpa [hlam] using minPositivePeriod_pos F hex
  have hlam_period : IsPositivePeriod F hex lam := by
    simpa [hlam] using minPositivePeriod_spec F hex
  obtain ⟨q, r, hpqr, hr⟩ : ∃ q r : ℕ, p = q * lam + r ∧ r < lam :=
    ⟨p / lam, p % lam, (Nat.div_add_mod' p lam).symm,
      Nat.mod_lt p hlam_pos⟩
  have hmultiple : ∀ d : ℕ, iterateMap F (μ + r) =
      iterateMap F (μ + r + d * lam) := by
    intro d
    induction d with
    | zero => simp
    | succ d ih =>
      have hstep : iterateMap F (μ + r + d * lam) =
          iterateMap F (μ + r + d * lam + lam) :=
        period_propagates_after_collision_start F hex hlam_period (by omega)
      calc
        iterateMap F (μ + r) = iterateMap F (μ + r + d * lam) := ih
        _ = iterateMap F (μ + r + (d + 1) * lam) := by
          simpa [Nat.succ_mul, Nat.add_assoc] using hstep
  have hr_collision : iterateMap F μ = iterateMap F (μ + r) := by
    have hq := hmultiple q
    have hp_eq : iterateMap F μ = iterateMap F (μ + p) := by
      simpa [hμ] using hp.2
    calc
      iterateMap F μ = iterateMap F (μ + p) := hp_eq
      _ = iterateMap F (μ + r + q * lam) := by
        simp [hpqr, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm]
      _ = iterateMap F (μ + r) := hq.symm
  have hr_zero : r = 0 := by
    by_contra hne
    have hr_period : IsPositivePeriod F hex r := by
      refine ⟨by omega, ?_⟩
      simpa [hμ] using hr_collision
    have hle : lam ≤ r := by
      simpa [hlam] using minPositivePeriod_le F hex hr_period
    omega
  refine ⟨q, ?_⟩
  simpa [hlam, hr_zero, Nat.mul_comm] using hpqr

/-- 各候補 p の Π_F への所属は、X → X の等号判定 1 回で決定できる。 -/
noncomputable instance (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n) [DecidableEq (X → X)]
    (p : ℕ) :
    Decidable (IsPositivePeriod F hex p) :=
  instDecidableAnd

end CellularAutomata.NecSuf.IterateMonoidMinimalPeriod
