/-
正本: content/finite-difference-temperature-derivative-boundary.ts の必要十分版。

必要な構造の検査結果:
  - 有限差の評価には、始域と終域の加法可換群、および加法準同型だけを要る。
  - 同じ二端点を持つ補間の反例には、実数上の一次補間と、端点で消える
    非零係数の二次項だけを要る。
  - 有限舞台、二元状態、局所規則、有限台素数ベクトル、正値性、実対数は、
    具体版で一般定理の入力を供給する段階だけに残る。

具体版と同じく、差を加法的評価へ移し、同じ二端点を通る二つの実多項式の
左端微分値が異なることを同じ順序で示す。
-/
import CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary
import Mathlib

namespace CellularAutomata.NecSuf.FiniteDifferenceTemperatureDerivativeBoundary

noncomputable section

variable {Source Target : Type*}

/-! ## 有限差の加法的評価に必要な構造 -/

/-- 加法可換群間の加法準同型は差を差へ送る。 -/
theorem additiveEvaluation_difference
    [AddCommGroup Source] [AddCommGroup Target]
    (evaluation : Source →+ Target) (later earlier : Source) :
    evaluation (later - earlier) = evaluation later - evaluation earlier := by
  exact map_sub evaluation later earlier

/-! ## 二端点補間の反例に必要な構造 -/

/-- 一次補間に、両端で消える係数 `c` の二次項を加えた補間。 -/
def correctedInterpolant (a S₀ d c : ℝ) : ℝ → ℝ :=
  CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary.linearInterpolant a S₀ d +
    (fun t => c * (t - a)) * fun t => t - (a + 1)

/-- 係数付き二次補間は一次補間と同じ二端点値を持つ。 -/
theorem correctedInterpolant_endpoints (a S₀ d c : ℝ) :
    correctedInterpolant a S₀ d c a = S₀ ∧
    correctedInterpolant a S₀ d c (a + 1) = S₀ + d := by
  constructor <;>
    simp [correctedInterpolant,
      CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary.linearInterpolant]

/-- 係数付き二次補間の左端微分値は `d - c` である。 -/
theorem correctedInterpolant_hasDerivAt (a S₀ d c : ℝ) :
    HasDerivAt (correctedInterpolant a S₀ d c) (d - c) a := by
  open CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary in
  have hlinear := linearInterpolant_hasDerivAt a S₀ d
  have hfirst : HasDerivAt (fun t : ℝ => c * (t - a)) c a := by
    simpa only [id_eq, mul_one] using
      HasDerivAt.const_mul c (HasDerivAt.sub_const a (hasDerivAt_id a))
  have hsecond : HasDerivAt (fun t : ℝ => t - (a + 1)) 1 a := by
    simpa only [id_eq, one_mul] using
      HasDerivAt.sub_const (a + 1) (hasDerivAt_id a)
  have h := HasDerivAt.add hlinear (HasDerivAt.mul hfirst hsecond)
  have hcoefficient :
      d + (c * (a - (a + 1)) + (c * (a - a)) * 1) = d - c := by ring
  change HasDerivAt
    (CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary.linearInterpolant a S₀ d +
      (fun t => c * (t - a)) * fun t => t - (a + 1)) (d - c) a
  rw [← hcoefficient]
  exact h

/-- 非零の二次補正は端点を変えず、左端微分値だけを変える。 -/
theorem finiteDifference_doesNotDetermineDerivative
    (a S₀ d c : ℝ) (hc : c ≠ 0) :
    let linear :=
      CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary.linearInterpolant a S₀ d
    let corrected := correctedInterpolant a S₀ d c
    linear a = corrected a ∧
    linear (a + 1) = corrected (a + 1) ∧
    deriv linear a = d ∧
    deriv corrected a = d - c ∧
    deriv linear a ≠ deriv corrected a := by
  open CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary in
  dsimp only
  have hlinearEndpoints := interpolants_endpoints a S₀ d
  have hcorrectedEndpoints := correctedInterpolant_endpoints a S₀ d c
  have hlinear := linearInterpolant_hasDerivAt a S₀ d
  have hcorrected := correctedInterpolant_hasDerivAt a S₀ d c
  refine ⟨hlinearEndpoints.1.trans hcorrectedEndpoints.1.symm,
    hlinearEndpoints.2.1.trans hcorrectedEndpoints.2.symm,
    hlinear.deriv, hcorrected.deriv, ?_⟩
  rw [hlinear.deriv, hcorrected.deriv]
  intro hequal
  apply hc
  linarith

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.EssentialDependency
open CellularAutomata.PrimeLogarithm
open CellularAutomata.BinaryCALogarithmicCounts
open CellularAutomata.CyclicStageLogarithmicDensity
open CellularAutomata.FiniteDifferenceTemperatureDerivativeBoundary

/-- 具体版の実評価を加法準同型として束ねる。 -/
noncomputable def logarithmicRealEvaluationAddHom : LogVector →+ ℝ where
  toFun := logarithmicRealEvaluation
  map_zero' := by
    change CellularAutomata.FiniteRationalEntropyBoundary.logarithmicRealEvaluation
      (rationalEmbedding 0) = 0
    have hembedding : rationalEmbedding (0 : LogVector) = 0 := by
      ext prime
      simp [rationalEmbedding_apply]
    rw [hembedding]
    exact CellularAutomata.FiniteRationalEntropyBoundary.logarithmicRealEvaluation_zero
  map_add' left right := by
    change CellularAutomata.FiniteRationalEntropyBoundary.logarithmicRealEvaluation
      (rationalEmbedding (left + right)) = _
    have hembedding : rationalEmbedding (left + right) =
        rationalEmbedding left + rationalEmbedding right := by
      ext prime
      simp [rationalEmbedding_apply]
    rw [hembedding]
    exact CellularAutomata.FiniteRationalEntropyBoundary.logarithmicRealEvaluation_add _ _

/-- 具体版の有限差比較は、加法準同型が差を保つ一般定理から得られる。 -/
theorem beta_realEvaluation_of_necSuf
    {V : Type} [Fintype V] [DecidableEq V]
    (N : V → Finset V) (f : (v : V) → (↥(N v) → State) → State)
    (H : (V → State) → ℤ) (n : PositiveTime) (u : ℤ)
    (hu : u ∈ levels N f H n) (hv : u + 1 ∈ levels N f H n) :
    logarithmicRealEvaluation (beta N f H n u hu hv) =
      realFiberEntropySample N f H n (u + 1) hv -
        realFiberEntropySample N f H n u hu := by
  unfold beta entropy realFiberEntropySample
  change logarithmicRealEvaluationAddHom
      (logarithm (positiveNat (multiplicity N f H n (u + 1))
        ((mem_levels N f H n (u + 1)).1 hv)) -
       logarithm (positiveNat (multiplicity N f H n u)
        ((mem_levels N f H n u).1 hu))) = _
  rw [additiveEvaluation_difference logarithmicRealEvaluationAddHom]
  change logarithmicRealEvaluation
      (logarithm (positiveNat (multiplicity N f H n (u + 1))
        ((mem_levels N f H n (u + 1)).1 hv))) -
      logarithmicRealEvaluation
      (logarithm (positiveNat (multiplicity N f H n u)
        ((mem_levels N f H n u).1 hu))) = _
  rw [logarithmicRealEvaluation_logarithm]
  rw [logarithmicRealEvaluation_logarithm]
  norm_num [positiveNat]

/-- 係数一の一般反例は、具体版の二次補間そのものである。 -/
theorem correctedInterpolant_one_eq_quadraticInterpolant (a S₀ d : ℝ) :
    correctedInterpolant a S₀ d 1 = quadraticInterpolant a S₀ d := by
  funext t
  simp [correctedInterpolant, quadraticInterpolant]

/-- 具体版の二補間反例は、非零係数の一般定理の特殊化である。 -/
theorem finiteDifference_doesNotDetermineDerivative_of_necSuf (a S₀ d : ℝ) :
    linearInterpolant a S₀ d a = quadraticInterpolant a S₀ d a ∧
    linearInterpolant a S₀ d (a + 1) = quadraticInterpolant a S₀ d (a + 1) ∧
    deriv (linearInterpolant a S₀ d) a = d ∧
    deriv (quadraticInterpolant a S₀ d) a = d - 1 ∧
    deriv (linearInterpolant a S₀ d) a ≠ deriv (quadraticInterpolant a S₀ d) a := by
  simpa [correctedInterpolant_one_eq_quadraticInterpolant] using
    finiteDifference_doesNotDetermineDerivative a S₀ d 1 (by norm_num)

/-- 具体的な CA の主張は、一般の差評価と補間反例を続けて適用して得られる。 -/
theorem binaryCAFiniteDifference_doesNotDetermineDerivative_of_necSuf
    {V : Type} [Fintype V] [DecidableEq V]
    (N : V → Finset V) (f : (v : V) → (↥(N v) → State) → State)
    (H : (V → State) → ℤ) (n : PositiveTime) (u : ℤ)
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
  refine ⟨beta_realEvaluation_of_necSuf N f H n u hu hv, ?_⟩
  exact finiteDifference_doesNotDetermineDerivative_of_necSuf
    (u : ℝ) (realFiberEntropySample N f H n u hu)
      (realFiberEntropySample N f H n (u + 1) hv - realFiberEntropySample N f H n u hu)

end Derivation

end

end CellularAutomata.NecSuf.FiniteDifferenceTemperatureDerivativeBoundary
