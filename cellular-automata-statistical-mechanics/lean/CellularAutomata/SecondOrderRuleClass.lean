/-
正本: structured-latex/content/second-order-rule-class.ts の具体版。

有限舞台、二元状態、有限近傍上の二時刻局所規則族を固定し、基礎局所規則族の一意回復、
所属の有限決定、二時刻大域写像の明示逆写像、および一般の一段規則の一セル反例を、
人手証明と同じ対象・仮定・順序で形式化する。

有限型と二元体加法の有限表だけを使う。対数、除算、全配位の極限、実数体、複素数体は使わない。
-/
import CellularAutomata.BinaryFieldLinearRuleClass

namespace CellularAutomata.SecondOrderRuleClass

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.BinaryFieldLinearRuleClass

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 有限舞台上の二時刻局所規則族。第二引数の成分は現在の近傍入力と一時刻前の状態である。 -/
abbrev TwoTimeLocalRuleFamily (N : V → Finset V) :=
  (v : V) → ((↥(N v) → State) × State) → State

/-- 二時刻局所規則族が、前状態との二元体加法で得られるという二次条件。 -/
def IsSecondOrder (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) : Prop :=
  ∀ v : V, ∀ z : ↥(N v) → State, ∀ a : State,
    h v (z, a) = stateAdd (h v (z, State.zero)) a

/-- 二次規則から、前状態を零に固定して回復した基礎局所規則族。 -/
def recoveredBaseFamily (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) :
    BinaryFieldLinearRuleClass.LocalRuleFamily N :=
  fun v z => h v (z, State.zero)

/-- 基礎局所規則族から二次規則族を作る。 -/
def liftBaseFamily (N : V → Finset V)
    (f : BinaryFieldLinearRuleClass.LocalRuleFamily N) : TwoTimeLocalRuleFamily N :=
  fun v za => stateAdd (f v za.1) za.2

/-- 二次規則は、零入力から回復した基礎局所規則族から元どおりに作られる。 -/
theorem secondOrder_eq_lift_recovered (N : V → Finset V)
    (h : TwoTimeLocalRuleFamily N) (hsecond : IsSecondOrder N h) :
    h = liftBaseFamily N (recoveredBaseFamily N h) := by
  funext v za
  exact hsecond v za.1 za.2

/-- 同じ二次規則を表す基礎局所規則族は、零入力から回復した族に等しい。 -/
theorem baseFamily_unique (N : V → Finset V) (h : TwoTimeLocalRuleFamily N)
    (_hsecond : IsSecondOrder N h) (g : BinaryFieldLinearRuleClass.LocalRuleFamily N)
    (hg : ∀ v z a, h v (z, a) = stateAdd (g v z) a) :
    g = recoveredBaseFamily N h := by
  funext v z
  have hzero := hg v z State.zero
  change g v z = h v (z, State.zero)
  cases hvalue : g v z <;> simpa [hvalue, stateAdd] using hzero.symm

/-- 全セル・全二時刻局所入力を有限走査することで二次条件を決定できる。 -/
instance secondOrderDecidable (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) :
    Decidable (IsSecondOrder N h) := by
  unfold IsSecondOrder
  infer_instance

/-- 有限舞台の二時刻配位空間。 -/
abbrev TwoTimeConfiguration := (V → State) × (V → State)

/-- 二時刻配位空間の元数は `2 ^ (2 * |V|)` である。 -/
theorem twoTimeConfiguration_card :
    Fintype.card (TwoTimeConfiguration (V := V)) = 2 ^ (2 * Fintype.card V) := by
  rw [Fintype.card_prod, Fintype.card_fun, card_state]
  rw [← Nat.pow_add]
  congr 1
  omega

/-- 二次規則から回復した基礎局所規則族の一段大域写像。 -/
def recoveredGlobalMap (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) :
    (V → State) → (V → State) :=
  globalMap N (recoveredBaseFamily N h)

/-- 二次規則の二時刻大域写像。 -/
def globalEvolution (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) :
    TwoTimeConfiguration (V := V) → TwoTimeConfiguration (V := V) :=
  fun pc => (pc.2, pointwiseAdd (recoveredGlobalMap N h pc.2) pc.1)

/-- 二次規則の二時刻大域写像に対する明示逆写像候補。 -/
def inverseCandidate (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) :
    TwoTimeConfiguration (V := V) → TwoTimeConfiguration (V := V) :=
  fun cn => (pointwiseAdd cn.2 (recoveredGlobalMap N h cn.1), cn.1)

/-- 二元体加法では、同じ入力を二度加えると消える。 -/
theorem stateAdd_cancellation (a b : State) :
    stateAdd (stateAdd a b) a = b ∧ stateAdd a (stateAdd b a) = b := by
  cases a <;> cases b <;> decide

/-- 点ごとの二元体加法でも、同じ入力を二度加えると消える。 -/
theorem pointwiseAdd_cancellation (a b : V → State) :
    pointwiseAdd (pointwiseAdd a b) a = b ∧
      pointwiseAdd a (pointwiseAdd b a) = b := by
  constructor <;> funext v
  · exact (stateAdd_cancellation (a v) (b v)).1
  · exact (stateAdd_cancellation (a v) (b v)).2

/-- 逆写像候補を二次発展の後に施すと元の二時刻配位へ戻る。 -/
theorem inverse_after_evolution (N : V → Finset V) (h : TwoTimeLocalRuleFamily N)
    (_hsecond : IsSecondOrder N h) (pc : TwoTimeConfiguration (V := V)) :
    inverseCandidate N h (globalEvolution N h pc) = pc := by
  rcases pc with ⟨p, c⟩
  apply Prod.ext
  · exact (pointwiseAdd_cancellation (recoveredGlobalMap N h c) p).1
  · rfl

/-- 二次発展を逆写像候補の後に施すと元の二時刻配位へ戻る。 -/
theorem evolution_after_inverse (N : V → Finset V) (h : TwoTimeLocalRuleFamily N)
    (_hsecond : IsSecondOrder N h) (cn : TwoTimeConfiguration (V := V)) :
    globalEvolution N h (inverseCandidate N h cn) = cn := by
  rcases cn with ⟨c, n⟩
  apply Prod.ext
  · rfl
  · exact (pointwiseAdd_cancellation (recoveredGlobalMap N h c) n).2

/-- 二次規則の二時刻大域写像は、基礎大域写像の可逆性によらず全単射である。 -/
theorem globalEvolution_bijective (N : V → Finset V) (h : TwoTimeLocalRuleFamily N)
    (hsecond : IsSecondOrder N h) :
    Function.Bijective (globalEvolution N h) := by
  constructor
  · intro x y hxy
    calc
      x = inverseCandidate N h (globalEvolution N h x) := (inverse_after_evolution N h hsecond x).symm
      _ = inverseCandidate N h (globalEvolution N h y) := congrArg (inverseCandidate N h) hxy
      _ = y := inverse_after_evolution N h hsecond y
  · intro y
    exact ⟨inverseCandidate N h y, evolution_after_inverse N h hsecond y⟩

/-- 一セル舞台上の定値零局所規則。 -/
def constantZeroRule (v : Unit) (_ : ↥(BinaryFieldLinearRuleClass.singleNeighborhood v) → State) : State :=
  State.zero

/-- 一セル舞台上の定値零大域写像。 -/
def constantZeroGlobalMap : (Unit → State) → (Unit → State) :=
  globalMap BinaryFieldLinearRuleClass.singleNeighborhood constantZeroRule

/-- 一セルの零配位と一配位は異なる。 -/
theorem single_zero_ne_one : (λ _ : Unit => State.zero) ≠ (λ _ : Unit => State.one) := by
  intro h
  have hvalue := congrFun h ()
  exact State.noConfusion hvalue

/-- 一セルの定値零大域写像は、相異なる零配位と一配位を同じ像へ写す。 -/
theorem constantZeroGlobalMap_not_injective : ¬ Function.Injective constantZeroGlobalMap := by
  intro hinjective
  apply single_zero_ne_one
  apply hinjective
  rfl

/-- 一般の一段局所規則では、大域写像の全単射性は強制されない。 -/
theorem constantZeroGlobalMap_not_bijective : ¬ Function.Bijective constantZeroGlobalMap := by
  intro hbijective
  exact constantZeroGlobalMap_not_injective hbijective.1

end CellularAutomata.SecondOrderRuleClass
