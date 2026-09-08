/-
章「有限舞台上の有理重みの確率的局所規則族」の Lean 必要十分版。

必要な構造の検査結果:
  - 局所正規化から積重みの正規化を得るには、有限な添字型と出力型、可換半環だけを要する。
  - 正規化された核の有限回合成には、有限な状態型、等号判定、可換半環だけを要する。
  - 零一重みからの一意回復には、出力型が相異なる二元で尽くされ、重みの零と一が異なることだけを要する。
  - CA の局所性、二元体演算、有理数の順序、対数、除算、全配位の極限、実数体、複素数体は要らない。
-/
import CellularAutomata.ProbabilisticRuleClass

namespace CellularAutomata.NecSuf.ProbabilisticRuleClass

open scoped BigOperators

universe uI uA uW uP

section ProductNormalization

variable {I : Type uI} {A : Type uA} {W : Type uW}
variable [Fintype I] [DecidableEq I] [Fintype A] [CommSemiring W]

/-- 有限個の出力重みを掛け合わせた重み。 -/
def productWeight (localWeight : I → A → W) (output : I → A) : W :=
  ∏ i : I, localWeight i (output i)

/-- 各添字の有限重みが正規化されていれば、その積重みも正規化される。 -/
theorem productWeight_normalized (localWeight : I → A → W)
    (hlocal : ∀ i : I, ∑ a : A, localWeight i a = 1) :
    ∑ output : I → A, productWeight localWeight output = 1 := by
  classical
  unfold productWeight
  rw [← Fintype.prod_sum]
  simp only [hlocal, Finset.prod_const_one]

end ProductNormalization

section FiniteComposition

variable {P : Type uP} {W : Type uW}
variable [Fintype P] [DecidableEq P] [CommSemiring W]

/-- 零回の恒等重みから、有限和と有限積だけで反復する一般の核。 -/
def finiteStepWeight (kernel : P → P → W) : ℕ → P → P → W
  | 0, x, y => if x = y then 1 else 0
  | n + 1, x, y => ∑ z : P, finiteStepWeight kernel n x z * kernel z y

/-- 一段核が各入力で正規化されていれば、全ての有限回合成も正規化される。 -/
theorem finiteStepWeight_normalized (kernel : P → P → W)
    (hkernel : ∀ x : P, ∑ y : P, kernel x y = 1) :
    ∀ n : ℕ, ∀ x : P, ∑ y : P, finiteStepWeight kernel n x y = 1 := by
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
      simp_rw [hkernel]
      simp [ih]

end FiniteComposition

section ZeroOneRecovery

variable {I : Type uI} {X : I → Type uA} {A : Type uA} {W : Type uW}
variable [DecidableEq A] [DecidableEq W] [Zero W] [One W]

/-- 二つの出力値を重みの零と一へ送る一般の零一符号。 -/
def deterministicWeight (oneState : A)
    (f : (i : I) → X i → A) (i : I) (x : X i) : W :=
  if f i x = oneState then 1 else 0

/-- 重みが全て零か一であるという一般条件。 -/
def IsZeroOne (weight : (i : I) → X i → W) : Prop :=
  ∀ i : I, ∀ x : X i, weight i x = 0 ∨ weight i x = 1

/-- 重み一の場合に第二の出力値を選ぶ一般の回復写像。 -/
def recoverDeterministic (zeroState oneState : A)
    (weight : (i : I) → X i → W) : (i : I) → X i → A :=
  fun i x => if weight i x = 1 then oneState else zeroState

/-- 相異なる二元で尽くされた出力型では、零一重みを回復して再符号化すると元へ戻る。 -/
theorem zeroOne_recovered (zeroState oneState : A)
    (hneState : zeroState ≠ oneState) (hneWeight : (0 : W) ≠ 1)
    (weight : (i : I) → X i → W) (hzeroOne : IsZeroOne weight) :
    deterministicWeight oneState
      (recoverDeterministic zeroState oneState weight) = weight := by
  funext i x
  rcases hzeroOne i x with hzero | hone
  · have hnotone : weight i x ≠ 1 := by
      intro h
      exact hneWeight (hzero.symm.trans h)
    change (if (if weight i x = 1 then oneState else zeroState) = oneState then 1 else 0) =
      weight i x
    rw [hzero]
    simp [hneState, hneWeight]
  · simp [deterministicWeight, recoverDeterministic, hone]

/-- 同じ零一重みを与える二元出力写像は、回復写像に限る。 -/
theorem deterministic_recovery_unique (zeroState oneState : A)
    (hexhaustive : ∀ a : A, a = zeroState ∨ a = oneState)
    (hneState : zeroState ≠ oneState) (hneWeight : (0 : W) ≠ 1)
    (weight : (i : I) → X i → W) (f : (i : I) → X i → A)
    (hf : deterministicWeight (W := W) oneState f = weight) :
    f = recoverDeterministic zeroState oneState weight := by
  funext i x
  rcases hexhaustive (f i x) with hzero | hone
  · have hvalue : weight i x = 0 := by
      rw [← hf]
      simp [deterministicWeight, hzero, hneState]
    simp [recoverDeterministic, hzero, hvalue, hneWeight]
  · have hvalue : weight i x = 1 := by
      rw [← hf]
      simp [deterministicWeight, hone]
    simp [recoverDeterministic, hone, hvalue]

end ZeroOneRecovery

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.EssentialDependency
open CellularAutomata.ProbabilisticRuleClass
open CellularAutomata.RedundantNeighbor

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 具体版の大域正規化は、有限積重みの一般正規化の特殊化である。 -/
theorem globalTransitionWeight_normalized_of_necSuf
    (N : V → Finset V) (kappa : LocalRuleFamily N)
    (x : Configuration (V := V)) :
    ∑ y : Configuration (V := V), globalTransitionWeight N kappa x y = 1 := by
  exact productWeight_normalized
    (fun v a => localOutputWeight N kappa v (restrict (N v) x) a)
    (fun v => localOutputWeight_sum N kappa v (restrict (N v) x))

/-- 具体版の有限回正規化は、正規化された有限核の一般反復の特殊化である。 -/
theorem finiteStepWeight_normalized_of_necSuf
    (N : V → Finset V) (kappa : LocalRuleFamily N) :
    ∀ n : ℕ, ∀ x : Configuration (V := V),
      ∑ y : Configuration (V := V),
        CellularAutomata.ProbabilisticRuleClass.finiteStepWeight N kappa n x y = 1 := by
  have hfunctions :
      CellularAutomata.ProbabilisticRuleClass.finiteStepWeight N kappa =
        CellularAutomata.NecSuf.ProbabilisticRuleClass.finiteStepWeight
          (fun x y => globalTransitionWeight N kappa x y) := by
    funext n
    induction n with
    | zero =>
        funext x y
        rfl
    | succ n ih =>
        funext x y
        simp only [CellularAutomata.ProbabilisticRuleClass.finiteStepWeight,
          CellularAutomata.NecSuf.ProbabilisticRuleClass.finiteStepWeight]
        congr 1
        funext z
        rw [congrFun (congrFun ih x) z]
  rw [hfunctions]
  exact finiteStepWeight_normalized
    (fun x y => globalTransitionWeight N kappa x y)
    (globalTransitionWeight_normalized N kappa)

/-- 具体版の零一回復は、相異なる二元出力に対する一般回復の特殊化である。 -/
theorem zeroOne_recovered_of_necSuf
    (N : V → Finset V) (kappa : LocalRuleFamily N)
    (hzeroOne : CellularAutomata.ProbabilisticRuleClass.IsZeroOne N kappa) :
    deterministicToProbabilistic N
      (CellularAutomata.ProbabilisticRuleClass.recoverDeterministic N kappa) = kappa := by
  have hgeneral := zeroOne_recovered State.zero State.one
    (by decide) (by norm_num)
    (fun v z => (kappa v z).val) hzeroOne
  funext v z
  apply Subtype.ext
  have hcomponent := congrFun (congrFun hgeneral v) z
  by_cases h : (kappa v z).val = 1
  · simpa [deterministicWeight, recoverDeterministic,
      deterministicToProbabilistic,
      CellularAutomata.ProbabilisticRuleClass.recoverDeterministic, h] using hcomponent
  · simpa [deterministicWeight, recoverDeterministic,
      deterministicToProbabilistic,
      CellularAutomata.ProbabilisticRuleClass.recoverDeterministic, h] using hcomponent

/-- 具体版の一意回復は、相異なる二元出力に対する一般一意性の特殊化である。 -/
theorem deterministic_recovery_unique_of_necSuf
    (N : V → Finset V) (kappa : LocalRuleFamily N)
    (f : (v : V) → (↥(N v) → State) → State)
    (hf : deterministicToProbabilistic N f = kappa) :
    f = CellularAutomata.ProbabilisticRuleClass.recoverDeterministic N kappa := by
  have hweight : deterministicWeight (W := ℚ) State.one f =
      fun v z => (kappa v z).val := by
    funext v z
    have hcomponent := congrArg (fun g : LocalRuleFamily N => (g v z).val) hf
    cases hvalue : f v z with
    | zero =>
        have hv : (0 : ℚ) = (kappa v z).val := by
          simpa [deterministicToProbabilistic, hvalue] using hcomponent
        simpa [deterministicWeight, hvalue] using hv
    | one =>
        have hv : (1 : ℚ) = (kappa v z).val := by
          simpa [deterministicToProbabilistic, hvalue] using hcomponent
        simpa [deterministicWeight, hvalue] using hv
  exact deterministic_recovery_unique State.zero State.one
    (by intro a; cases a <;> simp)
    (by decide) (by norm_num)
    (fun v z => (kappa v z).val) f hweight

end Derivation

end CellularAutomata.NecSuf.ProbabilisticRuleClass
