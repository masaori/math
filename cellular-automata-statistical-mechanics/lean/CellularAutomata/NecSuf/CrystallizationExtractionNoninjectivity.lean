/-
正本: content/finite-combinatorial-scattering-data.ts の必要十分版。

スカラー規格化の非単射性に必要なのは、有限基底の置換、係数環準同型で
1 と同じ値へ送られる 1 でない単元、整数指数標識だけである。二元基底、
有理関数、複素数、解析的極限、対数、内積、完備性は一般定理には要らない。
-/
import CellularAutomata.CrystallizationExtractionNoninjectivity

namespace CellularAutomata.NecSuf.CrystallizationExtractionNoninjectivity

variable {S K L : Type*}

noncomputable section

abbrev FreeModule (S K : Type*) [Semiring K] := S →₀ K

def basisVector [Semiring K] (s : S) : FreeModule S K := Finsupp.single s 1

def basisPermutationOperator [Semiring K] (swap : S ≃ S) :
    FreeModule S K ≃ₗ[K] FreeModule S K :=
  Finsupp.lcongr swap (LinearEquiv.refl K K)

def scalarNormalization [CommRing K] (unit : Kˣ) :
    FreeModule S K ≃ₗ[K] FreeModule S K :=
  DistribMulAction.toLinearEquiv K (FreeModule S K) unit

def normalizedOperator [CommRing K] (swap : S ≃ S) (unit : Kˣ) :
    FreeModule S K ≃ₗ[K] FreeModule S K :=
  basisPermutationOperator swap |>.trans (scalarNormalization unit)

/-- 基底置換の後に単元を掛けた作用素の基底上の作用。 -/
theorem normalizedOperator_on_basis [CommRing K]
    (swap : S ≃ S) (unit : Kˣ) (s : S) :
    normalizedOperator swap unit (basisVector s) =
      (unit : K) • basisVector (swap s) := by
  simp [normalizedOperator, basisPermutationOperator, scalarNormalization, basisVector,
    Units.smul_def]

/-- 単元が 1 でなければ、基底置換と規格化後の作用素は異なる。 -/
theorem normalizedOperator_ne_unscaled [CommRing K] [Nontrivial K]
    (swap : S ≃ S) (unit : Kˣ) (s : S) (hunit : (unit : K) ≠ 1) :
    basisPermutationOperator swap ≠ normalizedOperator swap unit := by
  intro h
  have basisEquality := LinearEquiv.congr_fun h (basisVector s)
  rw [normalizedOperator_on_basis] at basisEquality
  have coefficientEquality := congrArg (fun vector : FreeModule S K => vector (swap s)) basisEquality
  have hcoefficient : (1 : K) = unit := by
    simpa [basisPermutationOperator, basisVector] using coefficientEquality
  exact hunit hcoefficient.symm

/-- 係数環準同型で消える、零でないスカラー差。 -/
theorem nonzero_scalar_difference_in_ker [CommRing K] [CommRing L]
    (evaluation : K →+* L) (unit : Kˣ)
    (hunit : (unit : K) ≠ 1) (hevaluation : evaluation unit = 1) :
    (unit : K) - 1 ≠ 0 ∧ evaluation ((unit : K) - 1) = 0 := by
  constructor
  · intro h
    apply hunit
    exact sub_eq_zero.mp h
  · rw [map_sub, hevaluation, map_one, sub_self]

def evaluatedBasisData (evaluation : K → L) (coefficient : K)
    (swap : S ≃ S) (exponent : S → ℤ) (s : S) : L × S × ℤ :=
  (evaluation coefficient, swap s, exponent s)

/-- 評価が単元を 1 へ送るなら、規格化の前後で有限基底と整数標識の抽出は一致する。 -/
theorem scalar_normalization_same_extraction [CommRing K] [CommRing L]
    (evaluation : K →+* L) (swap : S ≃ S) (exponent : S → ℤ)
    (unit : Kˣ) (hevaluation : evaluation unit = 1) (s : S) :
    evaluatedBasisData evaluation 1 swap exponent s =
      evaluatedBasisData evaluation (unit : K) swap exponent s := by
  simp [evaluatedBasisData, hevaluation]

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.CrystallizationExtractionNoninjectivity

def polynomialEvaluationAtZero : Polynomial ℚ →+* ℚ := Polynomial.evalRingHom 0

/-- 具体例の係数 1 と 1+q の差 q は、多項式評価の核に入る非零元である。 -/
theorem concrete_scalar_difference_in_kernel :
    (Polynomial.X : Polynomial ℚ) ≠ 0 ∧
      polynomialEvaluationAtZero Polynomial.X = 0 := by
  constructor
  · exact Polynomial.X_ne_zero
  · simp [polynomialEvaluationAtZero]

/-- 具体版の二作用素の相違は、基底置換と 1 でない単元による一般定理の特殊化である。 -/
theorem operators_distinct_of_necSuf : operatorZero ≠ operatorOne := by
  let unit : Coefficientˣ := Units.mk0 coefficientOne coefficientOne_ne_zero
  have hunit : (unit : Coefficient) ≠ 1 := by
    intro h
    have hX : (RatFunc.X : Coefficient) = 0 := by
      have hsub := congrArg (fun x : Coefficient => x - 1) h
      simpa [unit, coefficientOne] using hsub
    exact RatFunc.X_ne_zero hX
  have h := normalizedOperator_ne_unscaled (K := Coefficient)
    gradedBasisSwap unit ((false, false), 0) hunit
  simpa [basisPermutationOperator, normalizedOperator, scalarNormalization,
    operatorZero, operatorOne,
    CellularAutomata.CrystallizationExtractionNoninjectivity.scalarNormalization,
    unit] using h

/-- 具体版の抽出一致は、係数評価後に同じ基底置換と整数標識を返す一般形である。 -/
theorem same_crystallization_extraction_of_necSuf (pair : BasisPair) :
    (evaluateAtZero coefficientZero, basisSwap pair, integerExponent pair) =
      (evaluateAtZero coefficientOne, basisSwap pair, integerExponent pair) := by
  rw [coefficientZero_evaluateAtZero, coefficientOne_evaluateAtZero]

end Derivation

end

end CellularAutomata.NecSuf.CrystallizationExtractionNoninjectivity
