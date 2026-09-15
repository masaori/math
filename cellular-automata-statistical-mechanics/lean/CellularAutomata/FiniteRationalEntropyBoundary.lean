/-
正本: content/finite-rational-entropy-boundary.ts の具体版。

def_finite_rational_probability_distribution_support
  → IsFiniteRationalProbabilityDistribution, positiveSupport
def_finite_rational_prime_vector_entropy → rationalPrimeVectorEntropy
def_rational_prime_vector_logarithmic_real_evaluation → logarithmicRealEvaluation
claim_finite_rational_entropy_real_comparison
  → rationalPrimeVectorEntropy_realComparison
claim_finite_real_distribution_not_always_rational
  → irrationalBinaryDistribution_notRational

有限型、有理確率分布、有限台有理素数ベクトル、実数に固定し、
正の台、有限加重和、実対数評価、無理数重みの非対応を本文と同じ順序で示す。
零の対数、無限和、極限、完備化、複素数体は使わない。
-/
import CellularAutomata.CyclicStageLogarithmicDensity
import CellularAutomata.PrimeLogarithm
import Mathlib.NumberTheory.Real.Irrational
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace CellularAutomata.FiniteRationalEntropyBoundary

open scoped BigOperators
open CellularAutomata.PrimeLogarithm
open CellularAutomata.CyclicStageLogarithmicDensity

noncomputable section

variable {X : Type*} [Fintype X] [DecidableEq X]

/-! ## 有限有理確率分布と正の台 -/

/-- 有限型上の有理確率分布であること。 -/
def IsFiniteRationalProbabilityDistribution (p : X → ℚ) : Prop :=
  (∀ x, 0 ≤ p x ∧ p x ≤ 1) ∧ ∑ x : X, p x = 1

/-- 有理確率分布の正の重みを持つ有限台。 -/
def positiveSupport (p : X → ℚ) : Finset X :=
  Finset.univ.filter fun x => 0 < p x

theorem mem_positiveSupport_iff (p : X → ℚ) (x : X) :
    x ∈ positiveSupport p ↔ 0 < p x := by
  simp [positiveSupport]

/-- 正の台では有理重みを正の有理数として素数指数へ渡せる。 -/
def supportedPositiveWeight (p : X → ℚ) (x : X) : PositiveRational :=
  if h : 0 < p x then ⟨p x, h⟩ else ⟨1, by norm_num⟩

theorem supportedPositiveWeight_eq (p : X → ℚ) (x : X)
    (hx : x ∈ positiveSupport p) :
    (supportedPositiveWeight p x).val = p x := by
  rw [mem_positiveSupport_iff] at hx
  simp [supportedPositiveWeight, hx]

/-! ## 有限台有理素数ベクトル値エントロピー -/

/-- 正の有理数の素数指数を有理係数へ送る。 -/
noncomputable def rationalPrimeValuationVector (q : PositiveRational) : RationalLogVector :=
  rationalEmbedding (logarithm q)

theorem rationalPrimeValuationVector_apply (q : PositiveRational) (prime : Prime) :
    rationalPrimeValuationVector q prime = (valuation q prime : ℚ) := by
  rfl

/-- 正の台だけで取る有限有理加重和。 -/
noncomputable def rationalPrimeVectorEntropy (p : X → ℚ) : RationalLogVector :=
  ∑ x ∈ positiveSupport p,
    (-p x) • rationalPrimeValuationVector (supportedPositiveWeight p x)

theorem rationalPrimeVectorEntropy_apply (p : X → ℚ) (prime : Prime) :
    rationalPrimeVectorEntropy p prime =
      -∑ x ∈ positiveSupport p, p x * (valuation (supportedPositiveWeight p x) prime : ℚ) := by
  classical
  simp [rationalPrimeVectorEntropy, rationalPrimeValuationVector_apply]

/-! ## 実対数評価 -/

/-- 一つの素数係数を、その素数の実対数倍へ送る有理線形写像。 -/
noncomputable def primeLogLinear (prime : Prime) : ℚ →ₗ[ℚ] ℝ where
  toFun coefficient := (coefficient : ℝ) * Real.log (prime.val : ℝ)
  map_add' left right := by push_cast; ring
  map_smul' scalar coefficient := by
    simp only [smul_eq_mul, RingHom.id_apply, Rat.cast_mul, Rat.smul_def]
    ring

/-- 有限台有理素数ベクトルを、各素数の実対数による有限和へ送る有理線形写像。 -/
noncomputable def logarithmicRealEvaluationLinear : RationalLogVector →ₗ[ℚ] ℝ :=
  Finsupp.lsum ℚ primeLogLinear

noncomputable def logarithmicRealEvaluation (a : RationalLogVector) : ℝ :=
  logarithmicRealEvaluationLinear a

theorem logarithmicRealEvaluation_zero : logarithmicRealEvaluation (0 : RationalLogVector) = 0 := by
  exact map_zero logarithmicRealEvaluationLinear

theorem logarithmicRealEvaluation_add (a b : RationalLogVector) :
    logarithmicRealEvaluation (a + b) =
      logarithmicRealEvaluation a + logarithmicRealEvaluation b := by
  exact map_add logarithmicRealEvaluationLinear a b

theorem logarithmicRealEvaluation_smul (c : ℚ) (a : RationalLogVector) :
    logarithmicRealEvaluation (c • a) = (c : ℝ) * logarithmicRealEvaluation a := by
  exact map_smul logarithmicRealEvaluationLinear c a

/-- 正整数の素因数指数表を、有理係数の素数ベクトルへ送る。 -/
noncomputable def naturalRationalPrimeVector (n : ℕ) : RationalLogVector :=
  rationalEmbedding
    ((n.factorization.mapRange (fun exponent : ℕ => (exponent : ℤ)) (by rfl)).subtypeDomain Nat.Prime)

/-- 正整数の素因数指数表の実対数評価は、その整数の実対数である。 -/
theorem naturalRationalPrimeVector_realLog (n : ℕ) (hn : n ≠ 0) :
    logarithmicRealEvaluation (naturalRationalPrimeVector n) = Real.log (n : ℝ) := by
  classical
  simp only [logarithmicRealEvaluation, logarithmicRealEvaluationLinear,
    naturalRationalPrimeVector, rationalEmbedding]
  rw [Finsupp.lsum_apply]
  rw [Finsupp.sum_mapRange_index (fun _ => by simp)]
  simp only [primeLogLinear, LinearMap.coe_mk, AddHom.coe_mk]
  have hprime : ∀ k ∈
      (n.factorization.mapRange (fun exponent : ℕ => (exponent : ℤ)) (by rfl)).support,
      Nat.Prime k := by
    intro k hk
    by_contra hnotPrime
    have hzero : n.factorization k = 0 := Nat.factorization_eq_zero_of_not_prime n hnotPrime
    exact Finsupp.mem_support_iff.mp hk (by simp [hzero])
  have hrestrict := Finsupp.sum_subtypeDomain_index
    (v := n.factorization.mapRange (fun exponent : ℕ => (exponent : ℤ)) (by rfl))
    (h := fun k exponent => (((exponent : ℚ) : ℝ) * Real.log (k : ℝ))) hprime
  rw [hrestrict]
  rw [Finsupp.sum_mapRange_index (fun _ => by simp)]
  simp only [Int.cast_natCast]
  simpa using (Real.log_nat_eq_sum_factorization n).symm

/-- 正の有理数の素数指数表の実対数評価は、その有理数の実対数に等しい。 -/
theorem rationalPrimeValuationVector_realLog (q : PositiveRational) :
    logarithmicRealEvaluation (rationalPrimeValuationVector q) = Real.log (q.val : ℝ) := by
  classical
  let numeratorVector := naturalRationalPrimeVector q.val.num.natAbs
  let denominatorVector := naturalRationalPrimeVector q.val.den
  have hvector : rationalPrimeValuationVector q = numeratorVector - denominatorVector := by
    ext prime
    simp [rationalPrimeValuationVector, numeratorVector, denominatorVector,
      naturalRationalPrimeVector, rationalEmbedding, logarithm, valuation]
  rw [hvector]
  change logarithmicRealEvaluationLinear (numeratorVector - denominatorVector) = _
  rw [map_sub]
  change logarithmicRealEvaluation numeratorVector - logarithmicRealEvaluation denominatorVector = _
  rw [naturalRationalPrimeVector_realLog q.val.num.natAbs]
  rw [naturalRationalPrimeVector_realLog q.val.den]
  · have hnumNat : q.val.num.natAbs ≠ 0 := by
      simpa only [Int.natAbs_ne_zero, Rat.num_ne_zero] using ne_of_gt q.property
    have hdenNat : q.val.den ≠ 0 := q.val.den_ne_zero
    have hrat : (q.val.num.natAbs : ℚ) / (q.val.den : ℚ) = q.val := by
      calc
        (q.val.num.natAbs : ℚ) / (q.val.den : ℚ) =
            (q.val.num : ℚ) / (q.val.den : ℚ) := by
          congr 1
          simpa using congrArg (fun z : ℤ => (z : ℚ))
            (Int.natAbs_of_nonneg (Rat.num_pos.mpr q.property).le)
        _ = q.val := q.val.num_div_den
    rw [← Real.log_div (by exact_mod_cast hnumNat) (by exact_mod_cast hdenNat)]
    congr 1
    simpa using congrArg (fun r : ℚ => (r : ℝ)) hrat
  · exact q.val.den_ne_zero
  · simpa only [Int.natAbs_ne_zero, Rat.num_ne_zero] using ne_of_gt q.property

/-- 有限有理素数ベクトル値エントロピーの実対数評価は Shannon の有限和に一致する。 -/
theorem rationalPrimeVectorEntropy_realComparison
    (p : X → ℚ) (_hp : IsFiniteRationalProbabilityDistribution p) :
    logarithmicRealEvaluation (rationalPrimeVectorEntropy p) =
      -∑ x ∈ positiveSupport p, (p x : ℝ) * Real.log (p x : ℝ) := by
  classical
  change logarithmicRealEvaluationLinear (rationalPrimeVectorEntropy p) = _
  rw [rationalPrimeVectorEntropy]
  rw [map_sum]
  rw [← Finset.sum_neg_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  rw [map_smul]
  change (-p x : ℚ) •
      logarithmicRealEvaluation (rationalPrimeValuationVector (supportedPositiveWeight p x)) = _
  rw [rationalPrimeValuationVector_realLog]
  rw [supportedPositiveWeight_eq p x hx]
  simp only [Rat.smul_def]
  push_cast
  ring

/-! ## 有限実数値分布が有理分布だけでは尽くせない反例 -/

/-- 二元集合上の反例に使う、構造を持たない二状態。 -/
inductive BinaryPoint where
  | first
  | second
deriving DecidableEq, Fintype

/-- 平方根二の二分の一を一方の重みに持つ実数値分布。 -/
def irrationalBinaryWeight : BinaryPoint → ℝ
  | .first => Real.sqrt 2 / 2
  | .second => 1 - Real.sqrt 2 / 2

theorem irrationalBinaryWeight_positive (x : BinaryPoint) :
    0 < irrationalBinaryWeight x := by
  cases x <;> simp [irrationalBinaryWeight] <;> nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]

theorem irrationalBinaryWeight_sum :
    ∑ x : BinaryPoint, irrationalBinaryWeight x = 1 := by
  rw [show (Finset.univ : Finset BinaryPoint) = {BinaryPoint.first, BinaryPoint.second} by
    ext x
    cases x <;> simp]
  simp [irrationalBinaryWeight]

/-- この実数値分布は有理分布の標準実数像ではない。 -/
theorem irrationalBinaryDistribution_notRational :
    ¬ ∃ p : BinaryPoint → ℚ,
      IsFiniteRationalProbabilityDistribution p ∧
      ∀ x, (p x : ℝ) = irrationalBinaryWeight x := by
  rintro ⟨p, _hp, hp⟩
  have hfirst := hp BinaryPoint.first
  have hsqrt : Real.sqrt 2 = ((2 * p BinaryPoint.first : ℚ) : ℝ) := by
    norm_num [irrationalBinaryWeight] at hfirst ⊢
    linarith
  exact irrational_sqrt_two ⟨2 * p BinaryPoint.first, hsqrt.symm⟩

end

end CellularAutomata.FiniteRationalEntropyBoundary
