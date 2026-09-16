/-
正本: content/finite-difference-temperature-derivative-boundary.ts の具体版。

def_prime_vector_real_logarithmic_evaluation
  → logarithmicRealEvaluation
claim_prime_vector_real_evaluation_of_prime_logarithm
  → logarithmicRealEvaluation_logarithm
def_binary_ca_real_fiber_entropy_sample
  → realFiberEntropySample
claim_binary_ca_unit_difference_real_evaluation
  → beta_realEvaluation
def_binary_ca_real_entropy_interpolants
  → linearInterpolant, quadraticInterpolant, interpolants_endpoints
def_binary_ca_interpolated_derivative_temperature
  → linearInterpolant_hasDerivAt, quadraticInterpolant_hasDerivAt
claim_binary_ca_finite_difference_does_not_determine_derivative
  → binaryCAFiniteDifference_doesNotDetermineDerivative

有限舞台、二元状態、有限繊維状態数、有限台整数素数ベクトル、実数に固定し、
正の有限状態数の実対数差と、同じ端点を通る二つの実多項式の微分値の相違を
本文と同じ順序で示す。零の対数、無限和、完備化、複素数体は使わない。
-/
import CellularAutomata.BinaryCALogarithmicCounts
import CellularAutomata.FiniteRationalEntropyBoundary
import Mathlib

namespace CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary

open CellularAutomata.EssentialDependency
open CellularAutomata.PrimeLogarithm
open CellularAutomata.BinaryCALogarithmicCounts
open CellularAutomata.FiniteRationalEntropyBoundary
open CellularAutomata.CyclicStageLogarithmicDensity

noncomputable section

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V) (f : (v : V) → (↥(N v) → State) → State)
variable (H : (V → State) → ℤ)

/-! ## 対数順序群と有限状態数の実対数評価 -/

/-- 有限台整数素数ベクトルを有理係数へ埋め、素数の実対数の有限和へ送る。 -/
noncomputable def logarithmicRealEvaluation (a : LogVector) : ℝ :=
  FiniteRationalEntropyBoundary.logarithmicRealEvaluation (rationalEmbedding a)

/-- 正の有理数の素数指数表の実評価は、その有理数の実対数である。 -/
theorem logarithmicRealEvaluation_logarithm (q : PositiveRational) :
    logarithmicRealEvaluation (logarithm q) = Real.log (q.val : ℝ) := by
  exact rationalPrimeValuationVector_realLog q

/-- 正の有限繊維状態数を実対数へ送る。 -/
noncomputable def realFiberEntropySample
    (n : PositiveTime) (u : ℤ) (_hu : u ∈ levels N f H n) : ℝ :=
  Real.log (multiplicity N f H n u : ℝ)

/-- 対数順序群値の隣接差の実評価は、二つの有限実対数の差に一致する。 -/
theorem beta_realEvaluation
    (n : PositiveTime) (u : ℤ)
    (hu : u ∈ levels N f H n) (hv : u + 1 ∈ levels N f H n) :
    logarithmicRealEvaluation (beta N f H n u hu hv) =
      realFiberEntropySample N f H n (u + 1) hv -
        realFiberEntropySample N f H n u hu := by
  rw [beta_ratio]
  rw [logarithmicRealEvaluation_logarithm]
  unfold realFiberEntropySample
  change Real.log
      ((((multiplicity N f H n (u + 1) : ℚ) /
        (multiplicity N f H n u : ℚ)) : ℚ) : ℝ) = _
  push_cast
  rw [Real.log_div]
  · exact_mod_cast (ne_of_gt ((mem_levels N f H n (u + 1)).1 hv))
  · exact_mod_cast (ne_of_gt ((mem_levels N f H n u).1 hu))

/-! ## 同じ有限端点を持つ二つの微分可能補間 -/

/-- 左端値 `S₀` と単位刻みの差 `d` を結ぶ一次補間。 -/
def linearInterpolant (a S₀ d : ℝ) : ℝ → ℝ :=
  (fun _ => S₀) + fun t => (t - a) * d

/-- 一次補間に両端で消える二次項を加えた補間。 -/
def quadraticInterpolant (a S₀ d : ℝ) : ℝ → ℝ :=
  linearInterpolant a S₀ d + (fun t => t - a) * fun t => t - (a + 1)

/-- 二つの補間は同じ二つの端点値を持つ。 -/
theorem interpolants_endpoints (a S₀ d : ℝ) :
    linearInterpolant a S₀ d a = S₀ ∧
    linearInterpolant a S₀ d (a + 1) = S₀ + d ∧
    quadraticInterpolant a S₀ d a = S₀ ∧
    quadraticInterpolant a S₀ d (a + 1) = S₀ + d := by
  constructor
  · simp [linearInterpolant]
  constructor
  · simp [linearInterpolant]
  constructor <;> simp [quadraticInterpolant, linearInterpolant]

/-- 一次補間の左端微分値は有限差 `d` である。 -/
theorem linearInterpolant_hasDerivAt (a S₀ d : ℝ) :
    HasDerivAt (linearInterpolant a S₀ d) d a := by
  have h := HasDerivAt.add (hasDerivAt_const a S₀)
    (HasDerivAt.mul_const (HasDerivAt.sub_const a (hasDerivAt_id a)) d)
  simpa only [linearInterpolant, id_eq, zero_add, one_mul] using h

/-- 二次補間の左端微分値は `d - 1` である。 -/
theorem quadraticInterpolant_hasDerivAt (a S₀ d : ℝ) :
    HasDerivAt (quadraticInterpolant a S₀ d) (d - 1) a := by
  have hlinear := linearInterpolant_hasDerivAt a S₀ d
  have hfirst : HasDerivAt (fun t : ℝ => t - a) 1 a := by
    simpa only [id_eq, one_mul] using HasDerivAt.sub_const a (hasDerivAt_id a)
  have hsecond : HasDerivAt (fun t : ℝ => t - (a + 1)) 1 a := by
    simpa only [id_eq, one_mul] using HasDerivAt.sub_const (a + 1) (hasDerivAt_id a)
  have hproduct := HasDerivAt.mul hfirst hsecond
  have h := HasDerivAt.add hlinear hproduct
  have hcoefficient :
      d + (1 * (a - (a + 1)) + (a - a) * 1) = d - 1 := by ring
  change HasDerivAt
    (linearInterpolant a S₀ d + (fun t => t - a) * fun t => t - (a + 1)) (d - 1) a
  rw [← hcoefficient]
  exact h

/-- 同じ二端点を通る二補間は、左端で相異なる微分値を持つ。 -/
theorem finiteDifference_doesNotDetermineDerivative (a S₀ d : ℝ) :
    linearInterpolant a S₀ d a = quadraticInterpolant a S₀ d a ∧
    linearInterpolant a S₀ d (a + 1) = quadraticInterpolant a S₀ d (a + 1) ∧
    deriv (linearInterpolant a S₀ d) a = d ∧
    deriv (quadraticInterpolant a S₀ d) a = d - 1 ∧
    deriv (linearInterpolant a S₀ d) a ≠ deriv (quadraticInterpolant a S₀ d) a := by
  have hendpoints := interpolants_endpoints a S₀ d
  have hlinear := linearInterpolant_hasDerivAt a S₀ d
  have hquadratic := quadraticInterpolant_hasDerivAt a S₀ d
  refine ⟨hendpoints.1.trans hendpoints.2.2.1.symm,
    hendpoints.2.1.trans hendpoints.2.2.2.symm, hlinear.deriv, hquadratic.deriv, ?_⟩
  rw [hlinear.deriv, hquadratic.deriv]
  linarith

/--
正の有限繊維状態数が与える同じ有限差分を持ちながら、二つの実補間の
左端微分値は一だけ異なる。有限差分だけでは実数微分を決められない。
-/
theorem binaryCAFiniteDifference_doesNotDetermineDerivative
    (n : PositiveTime) (u : ℤ)
    (hu : u ∈ levels N f H n) (hv : u + 1 ∈ levels N f H n) :
    let a : ℝ := u
    let S₀ := realFiberEntropySample N f H n u hu
    let d := realFiberEntropySample N f H n (u + 1) hv - S₀
    logarithmicRealEvaluation (beta N f H n u hu hv) = d ∧
    linearInterpolant a S₀ d a = quadraticInterpolant a S₀ d a ∧
    linearInterpolant a S₀ d (a + 1) = quadraticInterpolant a S₀ d (a + 1) ∧
    deriv (linearInterpolant a S₀ d) a = d ∧
    deriv (quadraticInterpolant a S₀ d) a = d - 1 ∧
    deriv (linearInterpolant a S₀ d) a ≠ deriv (quadraticInterpolant a S₀ d) a := by
  dsimp only
  refine ⟨beta_realEvaluation N f H n u hu hv, ?_⟩
  exact finiteDifference_doesNotDetermineDerivative
    (u : ℝ) (realFiberEntropySample N f H n u hu)
      (realFiberEntropySample N f H n (u + 1) hv - realFiberEntropySample N f H n u hu)

end

end CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary
