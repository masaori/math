/-
正本: structured-latex/content/probabilistic-rule-class.ts の具体版。

有限舞台、二元状態、有理重みの有限局所表を固定し、一セルの相補重み、
大域遷移重みの正規化、有限回遷移の有理数閉性と正規化、所属の有限決定、
および決定論的規則と零一重みの境界を、人手証明と同じ順序で形式化する。

有限集合と有理数の有限和・有限積だけを使う。対数、全配位の逆極限、極限、
実数体、複素数体は使わない。
-/
import CellularAutomata.BlockPartitionRuleClass
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.BigOperators.GroupWithZero.Finset
import Mathlib.Data.Rat.Lemmas
import Mathlib.Data.Rat.Cast.Order
import Mathlib.Tactic.NormNum

namespace CellularAutomata.ProbabilisticRuleClass

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open scoped BigOperators

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 有理数の零以上一以下の部分型。実数区間ではない。 -/
abbrev RationalProbability := {q : ℚ // 0 ≤ q ∧ q ≤ 1}

/-- 有限舞台上の有理重みの確率的局所規則族。 -/
abbrev LocalRuleFamily (N : V → Finset V) :=
  (v : V) → (↥(N v) → State) → RationalProbability

/-- 入力 `z` のもとで一セルが `a` を出力する有理重み。 -/
def localOutputWeight (N : V → Finset V) (kappa : LocalRuleFamily N)
    (v : V) (z : ↥(N v) → State) (a : State) : ℚ :=
  match a with
  | State.zero => 1 - (kappa v z).val
  | State.one => (kappa v z).val

/-- 一セルの二つの出力重みの和は一である。 -/
theorem localOutputWeight_sum (N : V → Finset V) (kappa : LocalRuleFamily N)
    (v : V) (z : ↥(N v) → State) :
    ∑ a : State, localOutputWeight N kappa v z a = 1 := by
  rw [show (Finset.univ : Finset State) = {State.zero, State.one} by decide]
  simp [localOutputWeight]

/-- 一セルの出力重みは非負である。 -/
theorem localOutputWeight_nonnegative (N : V → Finset V) (kappa : LocalRuleFamily N)
    (v : V) (z : ↥(N v) → State) (a : State) :
    0 ≤ localOutputWeight N kappa v z a := by
  cases a with
  | zero => exact sub_nonneg.mpr (kappa v z).property.2
  | one => exact (kappa v z).property.1

/-- 有限舞台の配位集合。 -/
abbrev Configuration := V → State

/-- 各セルの次状態を条件付き独立に選ぶ大域遷移重み。 -/
def globalTransitionWeight (N : V → Finset V) (kappa : LocalRuleFamily N)
    (x y : Configuration (V := V)) : ℚ :=
  ∏ v : V, localOutputWeight N kappa v (restrict (N v) x) (y v)

/-- 大域遷移重みは各入力配位で一に正規化される。 -/
theorem globalTransitionWeight_normalized (N : V → Finset V)
    (kappa : LocalRuleFamily N) (x : Configuration (V := V)) :
    ∑ y : Configuration (V := V), globalTransitionWeight N kappa x y = 1 := by
  change (∑ y : V → State,
    ∏ v : V, localOutputWeight N kappa v (restrict (N v) x) (y v)) = 1
  rw [← Fintype.prod_sum]
  simp only [localOutputWeight_sum, Finset.prod_const_one]

/-- 大域遷移重みは非負である。 -/
theorem globalTransitionWeight_nonnegative (N : V → Finset V)
    (kappa : LocalRuleFamily N) (x y : Configuration (V := V)) :
    0 ≤ globalTransitionWeight N kappa x y := by
  unfold globalTransitionWeight
  exact Finset.prod_nonneg fun v _ =>
    localOutputWeight_nonnegative N kappa v (restrict (N v) x) (y v)

/-- 零回の恒等遷移から再帰的に作る有限回遷移重み。 -/
def finiteStepWeight (N : V → Finset V) (kappa : LocalRuleFamily N) :
    ℕ → Configuration (V := V) → Configuration (V := V) → ℚ
  | 0, x, y => if x = y then 1 else 0
  | n + 1, x, y => ∑ z : Configuration (V := V),
      finiteStepWeight N kappa n x z * globalTransitionWeight N kappa z y

/-- 有限回遷移重みは非負である。 -/
theorem finiteStepWeight_nonnegative (N : V → Finset V) (kappa : LocalRuleFamily N) :
    ∀ n : ℕ, ∀ x y : Configuration (V := V), 0 ≤ finiteStepWeight N kappa n x y := by
  intro n
  induction n with
  | zero =>
      intro x y
      rw [finiteStepWeight]
      split <;> norm_num
  | succ n ih =>
      intro x y
      simp only [finiteStepWeight]
      exact Finset.sum_nonneg fun z _ =>
        mul_nonneg (ih x z) (globalTransitionWeight_nonnegative N kappa z y)

/-- 各有限回遷移の出力重みの和は一である。 -/
theorem finiteStepWeight_normalized (N : V → Finset V) (kappa : LocalRuleFamily N) :
    ∀ n : ℕ, ∀ x : Configuration (V := V),
      ∑ y : Configuration (V := V), finiteStepWeight N kappa n x y = 1 := by
  intro n
  induction n with
  | zero =>
      intro x
      simp [finiteStepWeight]
  | succ n ih =>
      intro x
      simp only [finiteStepWeight]
      rw [Finset.sum_comm]
      simp_rw [← Finset.mul_sum]
      simp_rw [globalTransitionWeight_normalized]
      simp [ih]

/-- 候補となる有理局所表が確率的規則族であるための条件。 -/
def IsProbabilisticCandidate (N : V → Finset V)
    (r : (v : V) → (↥(N v) → State) → ℚ) : Prop :=
  ∀ v : V, ∀ z : ↥(N v) → State, 0 ≤ r v z ∧ r v z ≤ 1

/-- 全セル・全局所入力を有限走査して所属条件を決定できる。 -/
instance probabilisticCandidateDecidable (N : V → Finset V)
    (r : (v : V) → (↥(N v) → State) → ℚ) :
    Decidable (IsProbabilisticCandidate N r) := by
  unfold IsProbabilisticCandidate
  infer_instance

/-- 決定論的局所規則族を零一有理重みへ送る。 -/
def deterministicToProbabilistic (N : V → Finset V)
    (f : (v : V) → (↥(N v) → State) → State) : LocalRuleFamily N :=
  fun v z => match f v z with
    | State.zero => ⟨0, by norm_num⟩
    | State.one => ⟨1, by norm_num⟩

/-- 局所重みがすべて零か一であるという条件。 -/
def IsZeroOne (N : V → Finset V) (kappa : LocalRuleFamily N) : Prop :=
  ∀ v : V, ∀ z : ↥(N v) → State, (kappa v z).val = 0 ∨ (kappa v z).val = 1

/-- 零一重みから出力一の場合を選ぶ決定論的局所規則族。 -/
def recoverDeterministic (N : V → Finset V) (kappa : LocalRuleFamily N) :
    (v : V) → (↥(N v) → State) → State :=
  fun v z => if (kappa v z).val = 1 then State.one else State.zero

/-- 零一重みは回復した決定論的規則から元どおりに得られる。 -/
theorem zeroOne_recovered (N : V → Finset V) (kappa : LocalRuleFamily N)
    (hzeroOne : IsZeroOne N kappa) :
    deterministicToProbabilistic N (recoverDeterministic N kappa) = kappa := by
  funext v z
  rcases hzeroOne v z with hzero | hone
  · apply Subtype.ext
    simp [deterministicToProbabilistic, recoverDeterministic, hzero]
  · apply Subtype.ext
    simp [deterministicToProbabilistic, recoverDeterministic, hone]

/-- 同じ零一重みを与える決定論的規則族は回復した族に限る。 -/
theorem deterministic_recovery_unique (N : V → Finset V) (kappa : LocalRuleFamily N)
    (f : (v : V) → (↥(N v) → State) → State)
    (hf : deterministicToProbabilistic N f = kappa) :
    f = recoverDeterministic N kappa := by
  funext v z
  have hvalue := congrArg (fun g : LocalRuleFamily N => (g v z).val) hf
  cases h : f v z with
  | zero =>
      have hne : (kappa v z).val ≠ 1 := by
        intro hone
        norm_num [deterministicToProbabilistic, h, hone] at hvalue
      simp [recoverDeterministic, hne]
  | one =>
      have hone : (kappa v z).val = 1 := by
        simpa [deterministicToProbabilistic, h] using hvalue.symm
      simp [recoverDeterministic, hone]

/-- 一セル舞台上で常に二分の一を与える確率的規則。 -/
def halfWeightRule : LocalRuleFamily (V := Unit) (fun _ => Finset.univ) :=
  fun _ _ => ⟨1 / 2, by norm_num⟩

/-- 二分の一重みは零でも一でもなく、決定論的規則からは得られない。 -/
theorem halfWeightRule_not_deterministic :
    ¬ ∃ f : (v : Unit) → (↥((fun _ : Unit => Finset.univ) v) → State) → State,
      deterministicToProbabilistic (fun _ : Unit => Finset.univ) f = halfWeightRule := by
  rintro ⟨f, hf⟩
  have hvalue := congrArg
    (fun g : LocalRuleFamily (V := Unit) (fun _ => Finset.univ) => (g () (fun _ => State.zero)).val) hf
  cases h : f () (fun _ => State.zero) <;>
    norm_num [deterministicToProbabilistic, halfWeightRule, h] at hvalue

end CellularAutomata.ProbabilisticRuleClass
