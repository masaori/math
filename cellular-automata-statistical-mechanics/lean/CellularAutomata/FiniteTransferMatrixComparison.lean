/-
正本: structured-latex/content/finite-transfer-matrix-comparison.ts の具体版。

人手証明のブロックとこのファイルの対応:
  def_rational_transition_transfer_matrix
    `transferMatrix`
  def_rational_transfer_matrix_power_trace
    `transferPower`, `transferTrace`
  claim_transfer_matrix_power_equals_finite_step_weight
    `transferPower_eq_finiteStepWeight`
  def_deterministic_rule_zero_one_embedding
    既存の `deterministicToProbabilistic`
  claim_deterministic_transfer_matrix_entry
    `localOutputWeight_deterministic`, `transferMatrix_deterministic_entry`,
    `transferMatrix_deterministic_row_one_iff`
  claim_deterministic_transfer_matrix_power_entry
    `transferPower_deterministic_entry`
  theorem_deterministic_transfer_trace_equals_fixed_point_count
    `transferTrace_eq_fixedPointCount`

有限舞台、二元状態、有理重みを人手証明と同じまま固定する。有限和・有限積、
有理数、自然数だけを使い、対数、除算、全配位の逆極限、極限、実数体、複素数体は使わない。
-/
import CellularAutomata.ProbabilisticRuleClass
import CellularAutomata.PeriodicPointCount

namespace CellularAutomata.FiniteTransferMatrixComparison

open CellularAutomata.EssentialDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.PeriodicPointCount
open CellularAutomata.ProbabilisticRuleClass
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open scoped BigOperators

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 有理大域遷移重みを、現在配位を行、次配位を列とする有限行列へ送る。 -/
def transferMatrix (N : V → Finset V) (kappa : LocalRuleFamily N)
    (x y : Configuration (V := V)) : ℚ :=
  globalTransitionWeight N kappa x y

/-- 恒等行列から有限和積だけで再帰的に作る有限転送行列の冪。 -/
def transferPower (N : V → Finset V) (kappa : LocalRuleFamily N) :
    ℕ → Configuration (V := V) → Configuration (V := V) → ℚ
  | 0, x, y => if x = y then 1 else 0
  | n + 1, x, y => ∑ z : Configuration (V := V),
      transferPower N kappa n x z * transferMatrix N kappa z y

/-- 有限転送行列の冪の対角成分を有限和した跡。 -/
def transferTrace (N : V → Finset V) (kappa : LocalRuleFamily N) (n : ℕ) : ℚ :=
  ∑ x : Configuration (V := V), transferPower N kappa n x x

/-- 行列冪は、既存の有限回遷移重みと全成分で一致する。 -/
theorem transferPower_eq_finiteStepWeight (N : V → Finset V) (kappa : LocalRuleFamily N) :
    ∀ n : ℕ, ∀ x y : Configuration (V := V),
      transferPower N kappa n x y = finiteStepWeight N kappa n x y := by
  intro n
  induction n with
  | zero =>
      intro x y
      rfl
  | succ n ih =>
      intro x y
      simp only [transferPower, finiteStepWeight, transferMatrix]
      congr 1
      funext z
      rw [ih x z]

omit [Fintype V] [DecidableEq V] in
/-- 零一埋め込みの一セル出力重みは、決定論的出力の指示値である。 -/
theorem localOutputWeight_deterministic (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (v : V) (z : ↥(N v) → State) (a : State) :
    localOutputWeight N (deterministicToProbabilistic N f) v z a =
      if a = f v z then 1 else 0 := by
  cases h : f v z <;> cases a <;>
    simp [localOutputWeight, deterministicToProbabilistic, h]

/-- 零一重みの転送行列成分は、決定論的大域写像の遷移指示値である。 -/
theorem transferMatrix_deterministic_entry (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (x y : Configuration (V := V)) :
    transferMatrix N (deterministicToProbabilistic N f) x y =
      if y = globalMap N f x then 1 else 0 := by
  classical
  by_cases hxy : y = globalMap N f x
  · rw [if_pos hxy]
    subst y
    unfold transferMatrix globalTransitionWeight
    apply Finset.prod_eq_one
    intro v _
    rw [localOutputWeight_deterministic]
    simp [globalMap]
  · rw [if_neg hxy]
    have hv : ∃ v : V, y v ≠ globalMap N f x v := by
      by_contra h
      apply hxy
      funext v
      simp only [not_exists, not_not] at h
      exact h v
    obtain ⟨v, hv⟩ := hv
    unfold transferMatrix globalTransitionWeight
    apply Finset.prod_eq_zero (Finset.mem_univ v)
    rw [localOutputWeight_deterministic]
    have hv' : y v ≠ f v (restrict (N v) x) := by
      simpa [globalMap] using hv
    simp [hv']

/-- 各行で重み一を持つ列は、決定論的大域写像の像だけである。 -/
theorem transferMatrix_deterministic_row_one_iff (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State)
    (x y : Configuration (V := V)) :
    transferMatrix N (deterministicToProbabilistic N f) x y = 1 ↔
      y = globalMap N f x := by
  rw [transferMatrix_deterministic_entry]
  by_cases h : y = globalMap N f x <;> simp [h]

/-- 零一重みの行列冪は、決定論的大域写像の反復遷移指示値である。 -/
theorem transferPower_deterministic_entry (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State) :
    ∀ n : ℕ, ∀ x y : Configuration (V := V),
      transferPower N (deterministicToProbabilistic N f) n x y =
        if y = iterate N f n x then 1 else 0 := by
  intro n
  induction n with
  | zero =>
      intro x y
      simp [transferPower, iterate, eq_comm]
  | succ n ih =>
      intro x y
      rw [transferPower]
      simp_rw [ih]
      rw [show (∑ z : Configuration (V := V),
          (if z = iterate N f n x then 1 else 0) *
            transferMatrix N (deterministicToProbabilistic N f) z y) =
          transferMatrix N (deterministicToProbabilistic N f) (iterate N f n x) y by simp]
      rw [transferMatrix_deterministic_entry]
      rfl

/-- 零一重みの正の冪の跡は、反復不動点集合の元数に等しい。 -/
theorem transferTrace_eq_fixedPointCount (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State) (n : ℕ) (_hn : 1 ≤ n) :
    transferTrace N (deterministicToProbabilistic N f) n =
      (fixedPointCount N f n : ℚ) := by
  classical
  unfold transferTrace fixedPointCount fixedPoints
  simp_rw [transferPower_deterministic_entry]
  have hindicator (x : Configuration (V := V)) :
      (if x = iterate N f n x then (1 : ℚ) else 0) =
        if iterate N f n x = x then 1 else 0 := by
    by_cases h : x = iterate N f n x
    · rw [if_pos h, if_pos h.symm]
    · rw [if_neg h, if_neg]
      intro h'
      exact h h'.symm
  simp_rw [hindicator]
  simp

end CellularAutomata.FiniteTransferMatrixComparison
