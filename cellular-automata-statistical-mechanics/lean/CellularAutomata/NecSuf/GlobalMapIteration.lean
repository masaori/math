/-
章「大域写像の反復と軌道の最終周期性」の必要十分版。

具体版と同じ反復の再帰、鳩の巣による衝突、衝突後の帰納法、
p := j - i による最終周期性、有限候補組の走査を保ち、実際に使う構造だけを残す。

* 反復・軌道・衝突の反復不変性には、型 X と自己写像 F : X → X だけを使う。
* 衝突と最終周期性には X の有限性だけを追加する。
* 衝突候補の有限決定可能性には X の等号判定だけを追加する。

二値状態、セル、近傍、局所規則、グラフ、物理的時間、R / C は使わない。
-/
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.Algebra.BigOperators.Intervals

namespace CellularAutomata.NecSuf.GlobalMapIteration

variable {X : Type}

/-- 自己写像 F の n 回反復。具体版と同じく n について再帰する。 -/
def iterate (F : X → X) : ℕ → X → X
  | 0, x => x
  | n + 1, x => F (iterate F n x)

theorem iterate_zero (F : X → X) (x : X) : iterate F 0 x = x := rfl

theorem iterate_succ (F : X → X) (n : ℕ) (x : X) :
    iterate F (n + 1) x = F (iterate F n x) := rfl

/-- x の軌道。自己写像以外の構造は要らない。 -/
def orbit (F : X → X) (x : X) : Set X := {z | ∃ n : ℕ, iterate F n x = z}

/-- 有限型 X 上の自己写像の軌道は、|X| 回までの反復の間に衝突する。 -/
theorem orbit_collision [Fintype X] (F : X → X) (x : X) :
    ∃ i j : ℕ, i < j ∧ j ≤ Fintype.card X ∧ iterate F i x = iterate F j x := by
  classical
  let M : ℕ := Fintype.card X
  let ι : Fin (M + 1) → X := fun n => iterate F n.val x
  have hcard : Fintype.card X < Fintype.card (Fin (M + 1)) := by
    rw [Fintype.card_fin]
    exact Nat.lt_succ_self _
  obtain ⟨a, b, hab, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt ι hcard
  rcases lt_or_gt_of_ne hab with h | h
  · exact ⟨a.val, b.val, Fin.lt_def.mp h, Nat.lt_succ_iff.mp b.isLt, heq⟩
  · exact ⟨b.val, a.val, Fin.lt_def.mp h, Nat.lt_succ_iff.mp a.isLt, heq.symm⟩

/-- 衝突は反復で保たれる。具体版と同じく k について帰納する。 -/
theorem collision_shift (F : X → X) (x : X) {i j : ℕ}
    (h : iterate F i x = iterate F j x) (k : ℕ) :
    iterate F (i + k) x = iterate F (j + k) x := by
  induction k with
  | zero => simpa using h
  | succ k ih =>
    show F (iterate F (i + k) x) = F (iterate F (j + k) x)
    rw [ih]

/-- 有限型上の自己写像の軌道は最終的に周期的である。 -/
theorem eventual_periodicity [Fintype X] (F : X → X) (x : X) :
    ∃ i p : ℕ, 1 ≤ p ∧ i + p ≤ Fintype.card X ∧
      ∀ n : ℕ, i ≤ n → iterate F (n + p) x = iterate F n x := by
  obtain ⟨i, j, hij, hjM, heq⟩ := orbit_collision F x
  refine ⟨i, j - i, by omega, by omega, ?_⟩
  intro n hn
  have hk := collision_shift F x heq (n - i)
  have h1 : i + (n - i) = n := by omega
  have h2 : j + (n - i) = n + (j - i) := by omega
  rw [h1, h2] at hk
  exact hk.symm

/-- 0 ≤ i < j ≤ M を表す有限な候補組。 -/
def scanPairs (M : ℕ) : Finset (Σ _ : ℕ, ℕ) :=
  (Finset.range (M + 1)).sigma fun j => Finset.range j

theorem mem_scanPairs (M i j : ℕ) :
    (⟨j, i⟩ : Σ _ : ℕ, ℕ) ∈ scanPairs M ↔ i < j ∧ j ≤ M := by
  simp only [scanPairs, Finset.mem_sigma, Finset.mem_range, Nat.lt_succ_iff]
  exact and_comm

/-- 候補組の総数の 2 倍は M(M+1)。 -/
theorem card_scanPairs_two_mul (M : ℕ) :
    (scanPairs M).card * 2 = (M + 1) * M := by
  simp only [scanPairs, Finset.card_sigma, Finset.card_range]
  simpa using Finset.sum_range_id_mul_two (M + 1)

/-- 有限型上では候補組の中に衝突が存在する。 -/
theorem exists_collision_in_scanPairs [Fintype X] (F : X → X) (x : X) :
    ∃ q ∈ scanPairs (Fintype.card X), iterate F q.2 x = iterate F q.1 x := by
  obtain ⟨i, j, hij, hjM, heq⟩ := orbit_collision F x
  exact ⟨⟨j, i⟩, (mem_scanPairs _ i j).mpr ⟨hij, hjM⟩, heq⟩

/-- X の等号が決定可能なら、有限候補組上の衝突存在文も決定可能である。 -/
instance [DecidableEq X] (F : X → X) (x : X) (M : ℕ) :
    Decidable (∃ q ∈ scanPairs M, iterate F q.2 x = iterate F q.1 x) :=
  Finset.decidableExistsAndFinset

end CellularAutomata.NecSuf.GlobalMapIteration
