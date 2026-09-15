/-
正本: content/finite-word-real-normalization-boundary.ts の具体版。

def_prime_vector_additive_real_realization
  → IsAdditiveRealization
claim_prime_vector_additive_realization_natural_multiple
  → additiveRealization_naturalMultiple
def_finite_word_realized_logarithmic_density
  → finiteWordLogarithmicCount, finiteWordRealizedDensity
claim_full_two_symbol_word_realized_density_constant
  → finiteWordLogarithmicCount_eq_naturalMultiple,
    fullTwoSymbolWordRealizedDensity_constant

有限二元語の個数、素数上の有限台整数ベクトル、実数値の
加法的実現、正の語長による除算に固定し、本文と同じ順序で示す。
一般語族の極限、位相的エントロピー、複素数体は使わない。
-/
import CellularAutomata.FiniteWordComplexityBoundary
import CellularAutomata.PrimeLogarithm
import Mathlib

namespace CellularAutomata.FiniteWordRealNormalizationBoundary

open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.FiniteWordComplexityBoundary
open CellularAutomata.PrimeLogarithm

noncomputable section

/-! ## 対数順序群の加法的な実数実現 -/

/-- 有限台整数ベクトルから実数への写像が零と加法を保つこと。 -/
def IsAdditiveRealization (ρ : LogVector → ℝ) : Prop :=
  ρ 0 = 0 ∧ ∀ a b : LogVector, ρ (a + b) = ρ a + ρ b

/-- 整数ベクトルの自然数倍は、実数実現の下で実数の自然数倍へ移る。 -/
theorem additiveRealization_naturalMultiple
    (ρ : LogVector → ℝ) (hρ : IsAdditiveRealization ρ)
    (a : LogVector) (k : ℕ) :
    ρ (scale (k : ℤ) a) = (k : ℝ) * ρ a := by
  induction k with
  | zero =>
      have hzeroInt : ((0 : ℕ) : ℤ) = 0 := by norm_num
      have hzeroReal : ((0 : ℕ) : ℝ) = 0 := by norm_num
      rw [hzeroInt, hzeroReal, zero_mul]
      have hscale : scale (0 : ℤ) a = 0 := by
        ext p
        simp [scale_apply]
      rw [hscale]
      exact hρ.1
  | succ k ih =>
      have hscale : scale ((k + 1 : ℕ) : ℤ) a = scale (k : ℤ) a + a := by
        ext p
        simp only [scale_apply, Finsupp.add_apply]
        push_cast
        ring
      rw [hscale, hρ.2, ih]
      push_cast
      ring

/-! ## 正の有限語個数の実数規格化 -/

/-- 有限二元語の正の個数を対数順序群へ送る。 -/
noncomputable def finiteWordLogarithmicCount (n : PositiveStage) : LogVector :=
  logarithm
    (positiveNat (finiteTwoSymbolWordSet n).card (by
      rw [finiteTwoSymbolWordSet_card]
      positivity))

/-- 二の自然数乗の対数順序群値は、`log_Λ 2` の自然数倍である。 -/
theorem logarithm_two_power (k : ℕ) :
    logarithm (positiveNat (2 ^ k) (pow_pos (by decide) k)) =
      scale (k : ℤ) (logarithm (positiveNat 2 (by decide))) := by
  induction k with
  | zero =>
      simp only [pow_zero]
      rw [logarithm_one]
      ext p
      simp [scale_apply]
  | succ k ih =>
      have hproduct :
          positiveNat (2 ^ (k + 1)) (pow_pos (by decide) (k + 1)) =
            positiveMul
              (positiveNat (2 ^ k) (pow_pos (by decide) k))
              (positiveNat 2 (by decide)) := by
        apply Subtype.ext
        simp [positiveNat, positiveMul, pow_succ]
      rw [hproduct, logarithm_product, ih]
      ext p
      simp only [scale_apply, Finsupp.add_apply]
      push_cast
      ring

/-- 有限二元語の対数個数は `log_Λ 2` の語長倍である。 -/
theorem finiteWordLogarithmicCount_eq_naturalMultiple (n : PositiveStage) :
    finiteWordLogarithmicCount n =
      scale (n.val : ℤ) (logarithm (positiveNat 2 (by decide))) := by
  calc
    finiteWordLogarithmicCount n =
        logarithm (positiveNat (2 ^ n.val) (pow_pos (by decide) n.val)) := by
      apply congrArg logarithm
      apply Subtype.ext
      simp [positiveNat, finiteTwoSymbolWordSet_card]
    _ = scale (n.val : ℤ) (logarithm (positiveNat 2 (by decide))) :=
      logarithm_two_power n.val

/-- 加法的実数実現で評価した対数個数を、正の語長で割る。 -/
def finiteWordRealizedDensity (ρ : LogVector → ℝ) (n : PositiveStage) : ℝ :=
  ρ (finiteWordLogarithmicCount n) / (n.val : ℝ)

/-- 全二元語族の実数規格化値は、各正の有限語長で `log_Λ 2` の像に等しい。 -/
theorem fullTwoSymbolWordRealizedDensity_constant
    (ρ : LogVector → ℝ) (hρ : IsAdditiveRealization ρ)
    (n : PositiveStage) :
    finiteWordRealizedDensity ρ n = ρ (logarithm (positiveNat 2 (by decide))) := by
  rw [finiteWordRealizedDensity, finiteWordLogarithmicCount_eq_naturalMultiple,
    additiveRealization_naturalMultiple ρ hρ]
  have hn : (n.val : ℝ) ≠ 0 := by
    exact_mod_cast n.property.ne'
  apply (div_eq_iff hn).2
  ring

end

end CellularAutomata.FiniteWordRealNormalizationBoundary
