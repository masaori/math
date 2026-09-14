/-
章「有限遷移重みの転送行列・跡・決定論的状態数との比較」の Lean 必要十分版。

必要な構造の検査結果:
  - 行列化は有限型上の二変数関数へ名前を付けるだけで、値の構造を要しない。
  - 行列冪と跡、および決定論的核との比較には、有限な状態型、等号判定、半環の有限和積だけを要する。
  - 既存の有限回遷移重みとの比較だけは、その既存定義が要求する可換半環を引き継ぐ。
  - 決定論的核には自己写像と零一指示値だけを要する。
  - 跡と反復不動点数の一致には、自然数を半環へ送る標準写像だけを追加で使う。
  - セル、近傍、局所規則、二元状態、有理数の順序、対数、除算、極限、実数体、複素数体は要らない。
-/
import CellularAutomata.FiniteTransferMatrixComparison
import CellularAutomata.NecSuf.PeriodicPointCount
import CellularAutomata.NecSuf.ProbabilisticRuleClass

namespace CellularAutomata.NecSuf.FiniteTransferMatrixComparison

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.PeriodicPointCount
open scoped BigOperators

variable {P W : Type}

/-- 有限状態型上の核を、行を現在状態、列を次状態とする行列として読む比較写像。 -/
def transferMatrix (kernel : P → P → W) : P → P → W := kernel

section MatrixOperations

variable [Fintype P] [DecidableEq P] [Semiring W]

/-- 恒等行列から有限和積だけで再帰的に作る核の冪。 -/
def transferPower (kernel : P → P → W) : ℕ → P → P → W
  | 0, x, y => if x = y then 1 else 0
  | n + 1, x, y => ∑ z : P, transferPower kernel n x z * transferMatrix kernel z y

/-- 核の冪の対角成分を有限和した跡。 -/
def transferTrace (kernel : P → P → W) (n : ℕ) : W :=
  ∑ x : P, transferPower kernel n x x

end MatrixOperations

section FiniteStepComparison

variable [Fintype P] [DecidableEq P] [CommSemiring W]

/-- 行列冪は、同じ核から有限和積で作る有限回遷移重みそのものである。 -/
theorem transferPower_eq_finiteStepWeight (kernel : P → P → W) :
    ∀ n : ℕ, ∀ x y : P,
      transferPower kernel n x y =
        CellularAutomata.NecSuf.ProbabilisticRuleClass.finiteStepWeight kernel n x y := by
  intro n
  induction n with
  | zero =>
      intro x y
      rfl
  | succ n ih =>
      intro x y
      simp only [transferPower,
        CellularAutomata.NecSuf.ProbabilisticRuleClass.finiteStepWeight,
        transferMatrix]
      congr 1
      funext z
      rw [ih x z]

end FiniteStepComparison

section DeterministicKernel

variable [Fintype P] [DecidableEq P] [Semiring W]

/-- 自己写像が定める零一遷移核。 -/
def deterministicKernel (step : P → P) (x y : P) : W :=
  if y = step x then 1 else 0

/-- 零一遷移核の冪は、自己写像の反復遷移の指示値である。 -/
theorem transferPower_deterministic (step : P → P) :
    ∀ n : ℕ, ∀ x y : P,
      transferPower (deterministicKernel (W := W) step) n x y =
        if y = iterate step n x then (1 : W) else 0 := by
  intro n
  induction n with
  | zero =>
      intro x y
      simp [transferPower, iterate, eq_comm]
  | succ n ih =>
      intro x y
      rw [transferPower]
      simp_rw [ih]
      rw [show (∑ z : P,
          (if z = iterate step n x then (1 : W) else 0) *
            transferMatrix (deterministicKernel (W := W) step) z y) =
          transferMatrix (deterministicKernel (W := W) step)
            (iterate step n x) y by simp]
      rfl

/-- 零一遷移核の跡は、自己写像の反復不動点数を半環へ送った値に等しい。 -/
theorem transferTrace_deterministic (step : P → P) (n : ℕ) :
    transferTrace (deterministicKernel (W := W) step) n =
      (fixedPointCount step n : W) := by
  classical
  unfold transferTrace
  calc
    (∑ x : P, transferPower (deterministicKernel (W := W) step) n x x) =
        ∑ x : P, if x ∈ fixedPoints step n then (1 : W) else 0 := by
      apply Finset.sum_congr rfl
      intro x _
      rw [transferPower_deterministic]
      by_cases hx : x ∈ fixedPoints step n
      · have hiterate := (mem_fixedPoints step n x).1 hx
        rw [if_pos hiterate.symm, if_pos hx]
      · have hiterate : x ≠ iterate step n x := by
          intro h
          exact hx ((mem_fixedPoints step n x).2 h.symm)
        rw [if_neg hiterate, if_neg hx]
    _ = (fixedPointCount step n : W) := by
      unfold fixedPointCount
      simp

end DeterministicKernel

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.EssentialDependency
open CellularAutomata.FiniteTransferMatrixComparison
open CellularAutomata.GlobalMapIteration
open CellularAutomata.PeriodicPointCount
open CellularAutomata.ProbabilisticRuleClass
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 具体版の行列冪は、一般の有限型上の核の冪の特殊化である。 -/
theorem transferPower_eq_necessary_sufficient
    (N : V → Finset V) (kappa : LocalRuleFamily N) :
    ∀ n : ℕ, ∀ x y : Configuration (V := V),
      CellularAutomata.FiniteTransferMatrixComparison.transferPower N kappa n x y =
        transferPower
          (CellularAutomata.FiniteTransferMatrixComparison.transferMatrix N kappa) n x y := by
  intro n
  induction n with
  | zero =>
      intro x y
      rfl
  | succ n ih =>
      intro x y
      simp only [CellularAutomata.FiniteTransferMatrixComparison.transferPower, transferPower]
      congr 1
      funext z
      rw [ih x z]
      rfl

/-- 具体版の零一転送行列は、一般の自己写像の零一遷移核の特殊化である。 -/
theorem deterministic_transferMatrix_eq_necessary_sufficient
    (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State) :
    CellularAutomata.FiniteTransferMatrixComparison.transferMatrix N
        (deterministicToProbabilistic N f) =
      deterministicKernel (W := ℚ) (globalMap N f) := by
  funext x y
  exact transferMatrix_deterministic_entry N f x y

/-- 具体版の跡と反復不動点数の一致は、有限型上の一般定理の特殊化である。 -/
theorem transferTrace_eq_fixedPointCount_of_necSuf
    (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State) (n : ℕ) (_hn : 1 ≤ n) :
    CellularAutomata.FiniteTransferMatrixComparison.transferTrace N
        (deterministicToProbabilistic N f) n =
      (CellularAutomata.PeriodicPointCount.fixedPointCount N f n : ℚ) := by
  rw [show CellularAutomata.FiniteTransferMatrixComparison.transferTrace N
        (deterministicToProbabilistic N f) n =
      transferTrace
        (CellularAutomata.FiniteTransferMatrixComparison.transferMatrix N
          (deterministicToProbabilistic N f)) n by
    unfold CellularAutomata.FiniteTransferMatrixComparison.transferTrace transferTrace
    apply Finset.sum_congr rfl
    intro x _
    exact transferPower_eq_necessary_sufficient N (deterministicToProbabilistic N f) n x x]
  rw [deterministic_transferMatrix_eq_necessary_sufficient]
  rw [transferTrace_deterministic]
  rw [← CellularAutomata.PeriodicPointCount.fixedPointCount_eq_necessary_sufficient]

end Derivation

end CellularAutomata.NecSuf.FiniteTransferMatrixComparison
