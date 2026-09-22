/-
正本: content/finite-combinatorial-scattering-data.ts の Lean 具体版。

SageMath 検算と同じ二元基底、整数指数表、係数 1 と 1+q を固定する。
q=0 は有理関数の代数的評価であり、解析的極限、複素対数、内積は使わない。
-/
import Mathlib.FieldTheory.RatFunc.AsPolynomial
import Mathlib.LinearAlgebra.Finsupp.LSum
import Mathlib.Tactic

namespace CellularAutomata.CrystallizationExtractionNoninjectivity

noncomputable section

abbrev BasisPair := Bool × Bool
abbrev GradedBasis := BasisPair × ℤ
abbrev Coefficient := RatFunc ℚ
abbrev FreeModule := GradedBasis →₀ Coefficient

/-- 二元基底対の因子交換。 -/
def basisSwap : BasisPair ≃ BasisPair := Equiv.prodComm Bool Bool

/-- SageMath 検算と同じ整数指数表。 -/
def integerExponent : BasisPair → ℤ
  | (false, false) => -1
  | (false, true) => 0
  | (true, false) => 2
  | (true, true) => 1

/-- 基底対を交換し、整数指数だけ次数を移す全単射。 -/
def gradedBasisSwap : GradedBasis ≃ GradedBasis where
  toFun state := (basisSwap state.1, state.2 + integerExponent state.1)
  invFun state :=
    (basisSwap.symm state.1, state.2 - integerExponent (basisSwap.symm state.1))
  left_inv state := by
    rcases state with ⟨⟨b, c⟩, degree⟩
    cases b <;> cases c <;> simp [basisSwap, integerExponent]
  right_inv state := by
    rcases state with ⟨⟨b, c⟩, degree⟩
    cases b <;> cases c <;> simp [basisSwap, integerExponent]

/-- q=0 における有理関数の代数的評価。 -/
def evaluateAtZero (coefficient : Coefficient) : ℚ :=
  RatFunc.eval (RingHom.id ℚ) 0 coefficient

/-- 規格化前の係数。 -/
def coefficientZero : Coefficient := 1

/-- 1+q を掛けた規格化の係数。 -/
def coefficientOne : Coefficient := 1 + RatFunc.X

/-- 基底ベクトル。 -/
def basisVector (pair : BasisPair) (degree : ℤ) : FreeModule :=
  Finsupp.single (pair, degree) 1

/-- 因子交換から得る有限基底自由加群の同型。 -/
def operatorZero : FreeModule ≃ₗ[Coefficient] FreeModule :=
  Finsupp.lcongr gradedBasisSwap (LinearEquiv.refl Coefficient Coefficient)

/-- 係数 1 は q=0 で 1 へ評価される。 -/
theorem coefficientZero_evaluateAtZero : evaluateAtZero coefficientZero = 1 := by
  simp [evaluateAtZero, coefficientZero, RatFunc.eval]

/-- 係数 1+q も q=0 で 1 へ評価される。 -/
theorem coefficientOne_evaluateAtZero : evaluateAtZero coefficientOne = 1 := by
  rw [coefficientOne, evaluateAtZero]
  rw [RatFunc.eval_add]
  · rw [RatFunc.eval_one, RatFunc.eval_X]
    norm_num
  · simp
  · simp

/-- 1+q は有理関数体で零でない。 -/
theorem coefficientOne_ne_zero : coefficientOne ≠ 0 := by
  intro h
  have evaluated : evaluateAtZero coefficientOne = evaluateAtZero 0 := congrArg evaluateAtZero h
  rw [coefficientOne_evaluateAtZero] at evaluated
  simp [evaluateAtZero, RatFunc.eval] at evaluated

/-- 1+q が定める自由加群のスカラー同型。 -/
def scalarNormalization : FreeModule ≃ₗ[Coefficient] FreeModule :=
  DistribMulAction.toLinearEquiv Coefficient FreeModule
    (Units.mk0 coefficientOne coefficientOne_ne_zero)

/-- 因子交換の後に 1+q を掛けた第二の同型。 -/
def operatorOne : FreeModule ≃ₗ[Coefficient] FreeModule :=
  operatorZero.trans scalarNormalization

/-- 因子交換は全四基底入力上の全単射である。 -/
theorem basisSwap_bijective : Function.Bijective basisSwap := basisSwap.bijective

/-- 二つの係数は q=0 でともに 1 へ評価される。 -/
theorem coefficient_evaluation_at_zero :
    evaluateAtZero coefficientZero = 1 ∧ evaluateAtZero coefficientOne = 1 := by
  exact ⟨coefficientZero_evaluateAtZero, coefficientOne_evaluateAtZero⟩

/-- 各基底入力の整数指数は SageMath 検算の -1,0,1,2 と一致する。 -/
theorem integer_exponent_extraction :
    integerExponent (false, false) = -1 ∧
    integerExponent (false, true) = 0 ∧
    integerExponent (true, false) = 2 ∧
    integerExponent (true, true) = 1 := by
  decide

/-- 第一の同型は基底対を交換し、整数指数だけ次数を移す。 -/
theorem operatorZero_on_basis (pair : BasisPair) (degree : ℤ) :
    operatorZero (basisVector pair degree) =
      basisVector (basisSwap pair) (degree + integerExponent pair) := by
  simp [operatorZero, basisVector, gradedBasisSwap]

/-- 第二の同型は同じ次数移動を行い、係数だけを 1+q 倍する。 -/
theorem operatorOne_on_basis (pair : BasisPair) (degree : ℤ) :
    operatorOne (basisVector pair degree) =
      coefficientOne • basisVector (basisSwap pair) (degree + integerExponent pair) := by
  simp [operatorOne, operatorZero, scalarNormalization, basisVector, coefficientOne,
    gradedBasisSwap, Units.smul_def]

/-- 二つの自由加群同型は基底ベクトル上ですでに異なる。 -/
theorem operators_distinct : operatorZero ≠ operatorOne := by
  intro h
  have basisEquality := LinearEquiv.congr_fun h (basisVector (false, false) 0)
  rw [operatorZero_on_basis, operatorOne_on_basis] at basisEquality
  have coefficientEquality :=
    congrArg (fun vector : FreeModule => vector (basisSwap (false, false), -1)) basisEquality
  simp [basisVector, basisSwap, integerExponent, coefficientOne] at coefficientEquality
  exact RatFunc.X_ne_zero coefficientEquality

/-- q=0 評価後には、二つの規格化から同じ基底全単射と整数指数を抽出する。 -/
theorem same_crystallization_extraction (pair : BasisPair) :
    (evaluateAtZero coefficientZero, basisSwap pair, integerExponent pair) =
      (evaluateAtZero coefficientOne, basisSwap pair, integerExponent pair) := by
  rw [coefficient_evaluation_at_zero.1, coefficient_evaluation_at_zero.2]

end

end CellularAutomata.CrystallizationExtractionNoninjectivity
