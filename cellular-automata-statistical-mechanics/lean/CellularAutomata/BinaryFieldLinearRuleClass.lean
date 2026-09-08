/-
正本: structured-latex/content/binary-field-linear-rule-class.ts の具体版。

有限舞台、二元状態、有限近傍上の局所規則族を固定し、二元体の加法・乗法を有限表で定義する。
局所規則族の零保存・加法保存・スカラー倍保存、その三条件が大域写像へ移ること、有限決定可能性、
および一セルの状態入れ替え規則による反例を、人手証明と同じ対象・仮定・順序で形式化する。

有限型と二元体の有限表だけを使う。対数、除算、全配位の極限、実数体・複素数体は使わない。
-/
import CellularAutomata.TimeExpansionDependency

namespace CellularAutomata.BinaryFieldLinearRuleClass

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency

/-- 状態集合上の二元体加法。 -/
def stateAdd : State → State → State
  | State.zero, a => a
  | State.one, State.zero => State.one
  | State.one, State.one => State.zero

/-- 状態集合上の二元体乗法。 -/
def stateMul : State → State → State
  | State.zero, _ => State.zero
  | State.one, a => a

/-- 任意の有限入力型上の零入力。 -/
def zeroInput {S : Type} : S → State := fun _ => State.zero

/-- 任意の有限入力型上の点ごとの和。 -/
def pointwiseAdd {S : Type} (x y : S → State) : S → State :=
  fun w => stateAdd (x w) (y w)

/-- 任意の有限入力型上の点ごとのスカラー倍。 -/
def scalarMultiply {S : Type} (a : State) (x : S → State) : S → State :=
  fun w => stateMul a (x w)

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 有限舞台上の局所規則族。 -/
abbrev LocalRuleFamily (N : V → Finset V) :=
  (v : V) → (↥(N v) → State) → State

/-- 全セルで零・和・スカラー倍を保存する局所規則族。 -/
def IsBinaryFieldLinear (N : V → Finset V) (f : LocalRuleFamily N) : Prop :=
  ∀ v : V,
    f v zeroInput = State.zero ∧
      (∀ x y : ↥(N v) → State, f v (pointwiseAdd x y) = stateAdd (f v x) (f v y)) ∧
      (∀ a : State, ∀ x : ↥(N v) → State,
        f v (scalarMultiply a x) = stateMul a (f v x))

/-- 局所線形性は大域写像の零保存を与える。 -/
theorem globalMap_preserves_zero (N : V → Finset V) (f : LocalRuleFamily N)
    (hlinear : IsBinaryFieldLinear N f) :
    globalMap N f zeroInput = zeroInput := by
  funext v
  change f v zeroInput = State.zero
  exact (hlinear v).1

/-- 局所線形性は大域写像の加法保存を与える。 -/
theorem globalMap_additive (N : V → Finset V) (f : LocalRuleFamily N)
    (hlinear : IsBinaryFieldLinear N f) (p q : V → State) :
    globalMap N f (pointwiseAdd p q) =
      pointwiseAdd (globalMap N f p) (globalMap N f q) := by
  funext v
  change f v (pointwiseAdd (restrict (N v) p) (restrict (N v) q)) =
    stateAdd (f v (restrict (N v) p)) (f v (restrict (N v) q))
  exact (hlinear v).2.1 _ _

/-- 局所線形性は大域写像のスカラー倍保存を与える。 -/
theorem globalMap_preserves_scalar_multiplication (N : V → Finset V)
    (f : LocalRuleFamily N) (hlinear : IsBinaryFieldLinear N f)
    (a : State) (p : V → State) :
    globalMap N f (scalarMultiply a p) = scalarMultiply a (globalMap N f p) := by
  funext v
  change f v (scalarMultiply a (restrict (N v) p)) =
    stateMul a (f v (restrict (N v) p))
  exact (hlinear v).2.2 a _

/-- 全セル・全局所入力を有限走査することで局所線形性を決定できる。 -/
instance binaryFieldLinearDecidable (N : V → Finset V) (f : LocalRuleFamily N) :
    Decidable (IsBinaryFieldLinear N f) := by
  unfold IsBinaryFieldLinear
  infer_instance

/-- 反例で使う一セル舞台の閉近傍。 -/
def singleNeighborhood (_ : Unit) : Finset Unit := {()}

/-- 一セルの状態を入れ替える局所規則。 -/
def swapRule (v : Unit) (x : ↥(singleNeighborhood v) → State) : State :=
  nu (x ⟨(), by simp [singleNeighborhood]⟩)

/-- 一セルの状態入れ替え規則が定める大域写像。 -/
def swapGlobalMap : (Unit → State) → (Unit → State) :=
  globalMap singleNeighborhood swapRule

/-- 一セル反例では零配位が一配位へ移る。 -/
theorem swapGlobalMap_zero_apply : swapGlobalMap zeroInput () = State.one := by
  rfl

/-- 一セル反例の大域写像は零配位を保存しない。 -/
theorem swapGlobalMap_does_not_preserve_zero : swapGlobalMap zeroInput ≠ zeroInput := by
  intro h
  have hvalue := congrFun h ()
  change State.one = State.zero at hvalue
  exact State.noConfusion hvalue

/-- 一セルの状態入れ替え規則は二元体上で線形でない。 -/
theorem swapRule_not_binaryFieldLinear :
    ¬ IsBinaryFieldLinear singleNeighborhood swapRule := by
  intro hlinear
  have hzero := (hlinear ()).1
  change State.one = State.zero at hzero
  exact State.noConfusion hzero

end CellularAutomata.BinaryFieldLinearRuleClass
