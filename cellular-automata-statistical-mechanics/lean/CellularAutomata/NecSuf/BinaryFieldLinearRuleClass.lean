/-
章「有限舞台上で二元体線形な局所規則族」の Lean 必要十分版。

必要な構造の検査結果:
  - 局所保存則を大域保存則へ運ぶ段には、添字型・大域入力型・局所入力型・出力型、
    および零、二項演算、スカラー作用と、それらを保存する制限写像だけを要する。
  - 舞台と局所入力の有限性、等号判定、二元状態、体の公理は要らない。
  - 局所保存則の有限決定にだけ、添字型と各局所入力型の有限性、および出力の等号判定を要する。
  - 対数、除算、全配位の極限、実数体、複素数体は使わない。
-/
import CellularAutomata.BinaryFieldLinearRuleClass

namespace CellularAutomata.NecSuf.BinaryFieldLinearRuleClass

universe uI uP uX uA uS

variable {I : Type uI} {P : Type uP} {X : I → Type uX}
  {A : Type uA} {S : Type uS}

/-- 添字ごとの局所写像が零、二項演算、スカラー作用を保存すること。 -/
def LocalPreservesOperations
    (zeroX : (i : I) → X i)
    (addX : (i : I) → X i → X i → X i)
    (smulX : (i : I) → S → X i → X i)
    (zeroA : A) (addA : A → A → A) (smulA : S → A → A)
    (f : (i : I) → X i → A) : Prop :=
  ∀ i : I,
    f i (zeroX i) = zeroA ∧
      (∀ x y : X i, f i (addX i x y) = addA (f i x) (f i y)) ∧
      (∀ a : S, ∀ x : X i, f i (smulX i a x) = smulA a (f i x))

/-- 大域入力から各局所入力への制限写像が三つの演算を保存すること。 -/
def RestrictionsPreserveOperations
    (zeroP : P) (addP : P → P → P) (smulP : S → P → P)
    (zeroX : (i : I) → X i)
    (addX : (i : I) → X i → X i → X i)
    (smulX : (i : I) → S → X i → X i)
    (restriction : (i : I) → P → X i) : Prop :=
  ∀ i : I,
    restriction i zeroP = zeroX i ∧
      (∀ p q : P, restriction i (addP p q) = addX i (restriction i p) (restriction i q)) ∧
      (∀ a : S, ∀ p : P, restriction i (smulP a p) = smulX i a (restriction i p))

/-- 局所写像族と制限写像から組み立てる大域写像。 -/
def assembledMap (restriction : (i : I) → P → X i)
    (f : (i : I) → X i → A) (p : P) (i : I) : A :=
  f i (restriction i p)

/-- 制限写像と局所写像が零を保存すれば、組み立てた大域写像も零を保存する。 -/
theorem assembledMap_preserves_zero
    (zeroP : P) (zeroX : (i : I) → X i) (zeroA : A)
    (restriction : (i : I) → P → X i) (f : (i : I) → X i → A)
    (hrestriction : ∀ i : I, restriction i zeroP = zeroX i)
    (hlocals : ∀ i : I, f i (zeroX i) = zeroA) :
    assembledMap restriction f zeroP = fun _ => zeroA := by
  funext i
  calc
    assembledMap restriction f zeroP i = f i (restriction i zeroP) := rfl
    _ = f i (zeroX i) := congrArg (f i) (hrestriction i)
    _ = zeroA := hlocals i

/-- 制限写像と局所写像が二項演算を保存すれば、組み立てた大域写像も保存する。 -/
theorem assembledMap_preserves_addition
    (addP : P → P → P)
    (addX : (i : I) → X i → X i → X i)
    (addA : A → A → A)
    (restriction : (i : I) → P → X i) (f : (i : I) → X i → A)
    (hrestriction : ∀ i : I, ∀ p q : P,
      restriction i (addP p q) = addX i (restriction i p) (restriction i q))
    (hlocals : ∀ i : I, ∀ x y : X i, f i (addX i x y) = addA (f i x) (f i y))
    (p q : P) :
    assembledMap restriction f (addP p q) =
      fun i => addA (assembledMap restriction f p i) (assembledMap restriction f q i) := by
  funext i
  calc
    assembledMap restriction f (addP p q) i = f i (restriction i (addP p q)) := rfl
    _ = f i (addX i (restriction i p) (restriction i q)) :=
      congrArg (f i) (hrestriction i p q)
    _ = addA (f i (restriction i p)) (f i (restriction i q)) := hlocals i _ _
    _ = addA (assembledMap restriction f p i) (assembledMap restriction f q i) := rfl

/-- 制限写像と局所写像がスカラー作用を保存すれば、組み立てた大域写像も保存する。 -/
theorem assembledMap_preserves_scalar_action
    (smulP : S → P → P)
    (smulX : (i : I) → S → X i → X i)
    (smulA : S → A → A)
    (restriction : (i : I) → P → X i) (f : (i : I) → X i → A)
    (hrestriction : ∀ i : I, ∀ a : S, ∀ p : P,
      restriction i (smulP a p) = smulX i a (restriction i p))
    (hlocals : ∀ i : I, ∀ a : S, ∀ x : X i,
      f i (smulX i a x) = smulA a (f i x))
    (a : S) (p : P) :
    assembledMap restriction f (smulP a p) =
      fun i => smulA a (assembledMap restriction f p i) := by
  funext i
  calc
    assembledMap restriction f (smulP a p) i = f i (restriction i (smulP a p)) := rfl
    _ = f i (smulX i a (restriction i p)) := congrArg (f i) (hrestriction i a p)
    _ = smulA a (f i (restriction i p)) := hlocals i a _
    _ = smulA a (assembledMap restriction f p i) := rfl

section FiniteDecision

variable [Fintype I] [∀ i : I, Fintype (X i)] [DecidableEq A]

/-- 有限な添字族と有限な局所入力型では、局所保存則を有限決定できる。 -/
instance localPreservesOperationsDecidable
    (zeroX : (i : I) → X i)
    (addX : (i : I) → X i → X i → X i)
    (smulX : (i : I) → S → X i → X i)
    [Fintype S]
    (zeroA : A) (addA : A → A → A) (smulA : S → A → A)
    (f : (i : I) → X i → A) :
    Decidable (LocalPreservesOperations zeroX addX smulX zeroA addA smulA f) := by
  unfold LocalPreservesOperations
  infer_instance

end FiniteDecision

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.BinaryFieldLinearRuleClass

variable {V : Type}

/-- 配位の制限写像は、具体版の零・和・スカラー倍を保存する。 -/
theorem concreteRestrictionsPreserveOperations (N : V → Finset V) :
    RestrictionsPreserveOperations
      (zeroInput : V → State) pointwiseAdd scalarMultiply
      (fun _ => zeroInput : (v : V) → ↑(N v) → State)
      (fun _ => pointwiseAdd) (fun _ => scalarMultiply)
      (fun v p => restrict (N v) p) := by
  intro v
  exact ⟨rfl, ⟨fun _ _ => rfl, fun _ _ => rfl⟩⟩

/-- 具体版の局所線形性は、抽象的な局所保存則そのものである。 -/
theorem concreteLocalPreservesOperations (N : V → Finset V) (f : LocalRuleFamily N) :
    IsBinaryFieldLinear N f →
      LocalPreservesOperations
        (fun _ => zeroInput : (v : V) → ↑(N v) → State)
        (fun _ => pointwiseAdd) (fun _ => scalarMultiply)
        State.zero stateAdd stateMul f := by
  intro h
  exact h

/-- 具体版の零保存は、制限写像と局所写像の一般保存定理の特殊化である。 -/
theorem globalMap_preserves_zero_of_necSuf (N : V → Finset V) (f : LocalRuleFamily N)
    (hlinear : IsBinaryFieldLinear N f) :
    globalMap N f zeroInput = zeroInput := by
  exact assembledMap_preserves_zero
    (zeroInput : V → State)
    (fun _ => zeroInput : (v : V) → ↑(N v) → State)
    State.zero (fun v p => restrict (N v) p) f
    (fun v => (concreteRestrictionsPreserveOperations N v).1)
    (fun v => (concreteLocalPreservesOperations N f hlinear v).1)

/-- 具体版の加法保存は、制限写像と局所写像の一般保存定理の特殊化である。 -/
theorem globalMap_additive_of_necSuf (N : V → Finset V) (f : LocalRuleFamily N)
    (hlinear : IsBinaryFieldLinear N f) (p q : V → State) :
    globalMap N f (pointwiseAdd p q) = pointwiseAdd (globalMap N f p) (globalMap N f q) := by
  exact assembledMap_preserves_addition
    pointwiseAdd (fun _ => pointwiseAdd) stateAdd
    (fun v p => restrict (N v) p) f
    (fun v => (concreteRestrictionsPreserveOperations N v).2.1)
    (fun v => (concreteLocalPreservesOperations N f hlinear v).2.1) p q

/-- 具体版のスカラー倍保存は、制限写像と局所写像の一般保存定理の特殊化である。 -/
theorem globalMap_preserves_scalar_multiplication_of_necSuf
    (N : V → Finset V) (f : LocalRuleFamily N) (hlinear : IsBinaryFieldLinear N f)
    (a : State) (p : V → State) :
    globalMap N f (scalarMultiply a p) = scalarMultiply a (globalMap N f p) := by
  exact assembledMap_preserves_scalar_action
    scalarMultiply (fun _ => scalarMultiply) stateMul
    (fun v p => restrict (N v) p) f
    (fun v => (concreteRestrictionsPreserveOperations N v).2.2)
    (fun v => (concreteLocalPreservesOperations N f hlinear v).2.2) a p

/-- 具体版の有限判定は、有限な局所保存則族に対する一般決定の特殊化である。 -/
theorem binaryFieldLinear_finite_decidable_of_necSuf
    [Fintype V] [DecidableEq V]
    (N : V → Finset V) (f : LocalRuleFamily N) :
    IsBinaryFieldLinear N f ∨ ¬ IsBinaryFieldLinear N f := by
  change LocalPreservesOperations
      (fun _ => zeroInput : (v : V) → ↑(N v) → State)
      (fun _ => pointwiseAdd) (fun _ => scalarMultiply)
      State.zero stateAdd stateMul f ∨
    ¬ LocalPreservesOperations
      (fun _ => zeroInput : (v : V) → ↑(N v) → State)
      (fun _ => pointwiseAdd) (fun _ => scalarMultiply)
      State.zero stateAdd stateMul f
  exact @Decidable.em _ (localPreservesOperationsDecidable
    (fun _ => zeroInput : (v : V) → ↑(N v) → State)
    (fun _ => pointwiseAdd) (fun _ => scalarMultiply)
    State.zero stateAdd stateMul f)

end Derivation

end CellularAutomata.NecSuf.BinaryFieldLinearRuleClass
