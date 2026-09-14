/-
章「有限舞台上の二次の局所規則族」の Lean 必要十分版。

必要な構造の検査結果:
  - 基礎写像族の回復には、添字型、入力型、出力型、零元、二項演算だけを要する。
  - 基礎写像族の一意性には、零元が二項演算の右単位元であることだけを追加で要する。
  - 二時刻発展の可逆性には、二項演算の二つの消去等式だけを要する。有限性、等号判定、
    二元状態、体の公理、局所性は要らない。
  - 二次条件の有限決定にだけ、添字型、各入力型、出力型の有限性と出力の等号判定を要する。
  - 対数、除算、全配位の極限、実数体、複素数体は使わない。
-/
import CellularAutomata.SecondOrderRuleClass

namespace CellularAutomata.NecSuf.SecondOrderRuleClass

universe uI uX uA uP

variable {I : Type uI} {X : I → Type uX} {A : Type uA} {P : Type uP}

/-- 二時刻写像族が、零入力から回復した写像と前入力の二項演算で得られること。 -/
def HasSecondOrderForm (zero : A) (add : A → A → A)
    (h : (i : I) → (X i × A) → A) : Prop :=
  ∀ i : I, ∀ x : X i, ∀ a : A, h i (x, a) = add (h i (x, zero)) a

/-- 零入力から回復した基礎写像族。 -/
def recoveredFamily (zero : A) (h : (i : I) → (X i × A) → A) :
    (i : I) → X i → A :=
  fun i x => h i (x, zero)

/-- 基礎写像族から二時刻写像族を作る。 -/
def liftedFamily (add : A → A → A) (f : (i : I) → X i → A) :
    (i : I) → (X i × A) → A :=
  fun i xa => add (f i xa.1) xa.2

/-- 二次形の写像族は、零入力から回復した族を持ち上げたものに等しい。 -/
theorem secondOrderForm_eq_lifted_recovered (zero : A) (add : A → A → A)
    (h : (i : I) → (X i × A) → A) (hsecond : HasSecondOrderForm zero add h) :
    h = liftedFamily add (recoveredFamily zero h) := by
  funext i xa
  exact hsecond i xa.1 xa.2

/-- 零元が右単位元なら、二次形を表す基礎写像族は零入力から一意に回復する。 -/
theorem baseFamily_unique
    (zero : A) (add : A → A → A) (hright : ∀ a : A, add a zero = a)
    (h : (i : I) → (X i × A) → A) (f : (i : I) → X i → A)
    (hf : ∀ i x a, h i (x, a) = add (f i x) a) :
    f = recoveredFamily zero h := by
  funext i x
  calc
    f i x = add (f i x) zero := (hright (f i x)).symm
    _ = h i (x, zero) := (hf i x zero).symm
    _ = recoveredFamily zero h i x := rfl

section FiniteDecision

variable [Fintype I] [∀ i : I, Fintype (X i)] [Fintype A] [DecidableEq A]

/-- 有限な添字族・入力型・出力型では、二次形への所属を有限決定できる。 -/
instance hasSecondOrderFormDecidable (zero : A) (add : A → A → A)
    (h : (i : I) → (X i × A) → A) : Decidable (HasSecondOrderForm zero add h) := by
  unfold HasSecondOrderForm
  infer_instance

end FiniteDecision

/-- 任意の自己写像と二項演算から作る二時刻発展。 -/
def evolution (add : P → P → P) (f : P → P) : P × P → P × P :=
  fun pc => (pc.2, add (f pc.2) pc.1)

/-- 二時刻発展に対する逆写像候補。 -/
def inverse (add : P → P → P) (f : P → P) : P × P → P × P :=
  fun cn => (add cn.2 (f cn.1), cn.1)

/-- 同じ左入力を二度施すと消えるなら、逆写像候補を発展の後に施すと元へ戻る。 -/
theorem inverse_after_evolution (add : P → P → P) (f : P → P)
    (hcancel : ∀ a b : P, add (add a b) a = b) (pc : P × P) :
    inverse add f (evolution add f pc) = pc := by
  rcases pc with ⟨p, c⟩
  apply Prod.ext
  · exact hcancel (f c) p
  · rfl

/-- 外側の右入力と内側の右入力が等しいときに消えるなら、発展を逆写像候補の後に施すと元へ戻る。 -/
theorem evolution_after_inverse (add : P → P → P) (f : P → P)
    (hcancel : ∀ a b : P, add a (add b a) = b) (cn : P × P) :
    evolution add f (inverse add f cn) = cn := by
  rcases cn with ⟨c, n⟩
  apply Prod.ext
  · rfl
  · exact hcancel (f c) n

/-- 二つの消去等式があれば、任意の自己写像から作る二時刻発展は全単射である。 -/
theorem evolution_bijective (add : P → P → P) (f : P → P)
    (hleft : ∀ a b : P, add (add a b) a = b)
    (hright : ∀ a b : P, add a (add b a) = b) :
    Function.Bijective (evolution add f) := by
  constructor
  · intro x y hxy
    calc
      x = inverse add f (evolution add f x) := (inverse_after_evolution add f hleft x).symm
      _ = inverse add f (evolution add f y) := congrArg (inverse add f) hxy
      _ = y := inverse_after_evolution add f hleft y
  · intro y
    exact ⟨inverse add f y, evolution_after_inverse add f hright y⟩

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.BinaryFieldLinearRuleClass
open CellularAutomata.EssentialDependency
open CellularAutomata.SecondOrderRuleClass

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 具体版の二次条件は、一般の二次形そのものである。 -/
theorem concreteHasSecondOrderForm (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) :
    IsSecondOrder N h ↔ HasSecondOrderForm State.zero stateAdd h := by
  rfl

/-- 具体版の回復等式は、一般の二次形の特殊化である。 -/
theorem secondOrder_eq_lift_recovered_of_necSuf
    (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) (hsecond : IsSecondOrder N h) :
    h = liftBaseFamily N (recoveredBaseFamily N h) := by
  exact secondOrderForm_eq_lifted_recovered State.zero stateAdd h hsecond

/-- 具体版の基礎局所規則族の一意性は、右零単位元を使う一般主張の特殊化である。 -/
theorem baseFamily_unique_of_necSuf
    (N : V → Finset V) (h : TwoTimeLocalRuleFamily N)
    (g : BinaryFieldLinearRuleClass.LocalRuleFamily N)
    (hg : ∀ v z a, h v (z, a) = stateAdd (g v z) a) :
    g = recoveredBaseFamily N h := by
  exact baseFamily_unique State.zero stateAdd (by intro a; cases a <;> rfl) h g hg

/-- 具体版の二次条件の有限決定は、有限な型上の一般決定の特殊化である。 -/
theorem secondOrder_finite_decidable_of_necSuf
    (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) :
    IsSecondOrder N h ∨ ¬ IsSecondOrder N h := by
  change HasSecondOrderForm State.zero stateAdd h ∨
    ¬ HasSecondOrderForm State.zero stateAdd h
  exact @Decidable.em _ (hasSecondOrderFormDecidable State.zero stateAdd h)

/-- 具体版の左逆等式は、第一の消去等式を使う一般主張の特殊化である。 -/
theorem inverse_after_evolution_of_necSuf
    (N : V → Finset V) (h : TwoTimeLocalRuleFamily N)
    (pc : TwoTimeConfiguration (V := V)) :
    inverseCandidate N h (globalEvolution N h pc) = pc := by
  exact inverse_after_evolution pointwiseAdd (recoveredGlobalMap N h)
    (fun a b => (pointwiseAdd_cancellation a b).1) pc

/-- 具体版の右逆等式は、第二の消去等式を使う一般主張の特殊化である。 -/
theorem evolution_after_inverse_of_necSuf
    (N : V → Finset V) (h : TwoTimeLocalRuleFamily N)
    (cn : TwoTimeConfiguration (V := V)) :
    globalEvolution N h (inverseCandidate N h cn) = cn := by
  exact evolution_after_inverse pointwiseAdd (recoveredGlobalMap N h)
    (fun a b => (pointwiseAdd_cancellation a b).2) cn

/-- 具体版の全単射性は、二つの消去等式だけを使う一般主張の特殊化である。 -/
theorem globalEvolution_bijective_of_necSuf
    (N : V → Finset V) (h : TwoTimeLocalRuleFamily N) (_hsecond : IsSecondOrder N h) :
    Function.Bijective (globalEvolution N h) := by
  exact evolution_bijective pointwiseAdd (recoveredGlobalMap N h)
    (fun a b => (pointwiseAdd_cancellation a b).1)
    (fun a b => (pointwiseAdd_cancellation a b).2)

end Derivation

end CellularAutomata.NecSuf.SecondOrderRuleClass
