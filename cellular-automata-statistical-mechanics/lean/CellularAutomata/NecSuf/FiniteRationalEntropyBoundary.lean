/-
正本: content/finite-rational-entropy-boundary.ts の必要十分版。

必要な構造の検査結果:
  - 有限有理素数ベクトル値エントロピーと実対数評価の交換には、有限添字集合、
    スカラー環、二つの加法可換群、加群、およびその間の線形写像だけを要る。
  - 有限実数値分布が有理分布だけでは尽くせない反例には、始域から終域への写像と、
    一つの成分がその像に入らないことだけを要る。
  - 確率分布の正規化、順序、正値性、素数、実対数、実数体、無理数性は、
    具体版で一般定理の仮定を供給する段階だけに残る。

具体版と同じく、正の台上の有限加重和を線形写像で評価し、各正重みの
素数指数表の評価を実対数へ書き換える。非対応は一成分の像外証人から導く。
-/
import CellularAutomata.FiniteRationalEntropyBoundary
import Mathlib

namespace CellularAutomata.NecSuf.FiniteRationalEntropyBoundary

open scoped BigOperators

noncomputable section

variable {I Scalar Vector Value Source Target : Type*}

/-! ## 有限加重和と線形評価 -/

/-- 有限添字集合上で、係数の負値を使って作る有限加重和。 -/
def finiteNegativeWeightedSum [Ring Scalar] [AddCommGroup Vector] [Module Scalar Vector]
    (support : Finset I) (weight : I → Scalar) (vector : I → Vector) : Vector :=
  ∑ i ∈ support, (-weight i) • vector i

/-- 線形評価は有限加重和と交換する。 -/
theorem linearEvaluation_finiteNegativeWeightedSum
    [Ring Scalar] [AddCommGroup Vector] [Module Scalar Vector]
    [AddCommGroup Value] [Module Scalar Value]
    (evaluation : Vector →ₗ[Scalar] Value)
    (support : Finset I) (weight : I → Scalar) (vector : I → Vector) :
    evaluation (finiteNegativeWeightedSum support weight vector) =
      ∑ i ∈ support, (-weight i) • evaluation (vector i) := by
  simp [finiteNegativeWeightedSum]

/-! ## 一成分の像外証人 -/

/-- 一成分が比較写像の像に入らなければ、対象関数全体も点ごとの像ではない。 -/
theorem no_pointwise_preimage_of_component_not_in_range
    (comparison : Source → Target) (target : I → Target) (witness : I)
    (hout : ∀ source : Source, comparison source ≠ target witness) :
    ¬ ∃ source : I → Source, ∀ i, comparison (source i) = target i := by
  rintro ⟨source, hsource⟩
  exact hout (source witness) (hsource witness)

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.FiniteRationalEntropyBoundary
open CellularAutomata.PrimeLogarithm
open CellularAutomata.CyclicStageLogarithmicDensity

/-- 具体版の有限台有理素数ベクトル値エントロピーは、有限加重和の特殊化である。 -/
theorem rationalPrimeVectorEntropy_eq_finiteNegativeWeightedSum
    {X : Type*} [Fintype X] [DecidableEq X] (p : X → ℚ) :
    rationalPrimeVectorEntropy p =
      finiteNegativeWeightedSum (positiveSupport p) p
        (fun x ↦ rationalPrimeValuationVector (supportedPositiveWeight p x)) := by
  rfl

/-- 具体版の実対数比較は、線形評価と有限加重和の交換から得られる。 -/
theorem rationalPrimeVectorEntropy_realComparison_of_necSuf
    {X : Type*} [Fintype X] [DecidableEq X]
    (p : X → ℚ) (_hp : IsFiniteRationalProbabilityDistribution p) :
    logarithmicRealEvaluation (rationalPrimeVectorEntropy p) =
      -∑ x ∈ positiveSupport p, (p x : ℝ) * Real.log (p x : ℝ) := by
  classical
  rw [rationalPrimeVectorEntropy_eq_finiteNegativeWeightedSum]
  change logarithmicRealEvaluationLinear
      (finiteNegativeWeightedSum (positiveSupport p) p
        (fun x ↦ rationalPrimeValuationVector (supportedPositiveWeight p x))) = _
  rw [linearEvaluation_finiteNegativeWeightedSum]
  rw [← Finset.sum_neg_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  change (-p x : ℚ) •
      logarithmicRealEvaluation
        (rationalPrimeValuationVector (supportedPositiveWeight p x)) = _
  rw [rationalPrimeValuationVector_realLog]
  rw [supportedPositiveWeight_eq p x hx]
  simp only [Rat.smul_def]
  push_cast
  ring

/-- 平方根二の二分の一は、有理数の標準実数像に入らない。 -/
theorem irrationalBinaryWeight_first_not_in_rational_range :
    ∀ q : ℚ, (q : ℝ) ≠ irrationalBinaryWeight BinaryPoint.first := by
  intro q hq
  have hsqrt : Real.sqrt 2 = ((2 * q : ℚ) : ℝ) := by
    norm_num [irrationalBinaryWeight] at hq ⊢
    linarith
  exact irrational_sqrt_two ⟨2 * q, hsqrt.symm⟩

/-- 具体版の無理数重み反例は、一成分の像外証人から得られる。 -/
theorem irrationalBinaryDistribution_notRational_of_necSuf :
    ¬ ∃ p : BinaryPoint → ℚ,
      IsFiniteRationalProbabilityDistribution p ∧
      ∀ x, (p x : ℝ) = irrationalBinaryWeight x := by
  have hnone : ¬ ∃ p : BinaryPoint → ℚ,
      ∀ x, (p x : ℝ) = irrationalBinaryWeight x :=
    no_pointwise_preimage_of_component_not_in_range
      (fun q : ℚ ↦ (q : ℝ)) irrationalBinaryWeight BinaryPoint.first
      irrationalBinaryWeight_first_not_in_rational_range
  rintro ⟨p, _hp, hp⟩
  exact hnone ⟨p, hp⟩

end Derivation

end

end CellularAutomata.NecSuf.FiniteRationalEntropyBoundary
