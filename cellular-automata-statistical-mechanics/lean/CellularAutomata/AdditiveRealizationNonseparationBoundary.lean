/-
正本: content/finite-word-real-normalization-boundary.ts の具体版。

def_prime_vector_zero_real_realization
  → zeroRealization
claim_prime_vector_zero_realization_additive
  → zeroRealization_isAdditive
claim_additive_realization_need_not_distinguish_counts
  → additiveRealization_needNotDistinguishCounts

有限台整数ベクトル、実数体、零写像、正の有限個数一・二に固定し、
本文と同じ順序で示す。単射性・順序保存性、一般語族の極限、
位相的エントロピー、複素数体は使わない。
-/
import CellularAutomata.FiniteWordRealNormalizationBoundary
import CellularAutomata.PrimeLogarithm
import Mathlib

namespace CellularAutomata.AdditiveRealizationNonseparationBoundary

open CellularAutomata.FiniteWordRealNormalizationBoundary
open CellularAutomata.PrimeLogarithm

noncomputable section

/-! ## 対数順序群の零実数実現 -/

/-- 有限台整数ベクトルを実数の零へ送る写像。 -/
def zeroRealization : LogVector → ℝ := fun _ => 0

/-- 零実数実現は零と加法を保つ。 -/
theorem zeroRealization_isAdditive : IsAdditiveRealization zeroRealization := by
  constructor
  · rfl
  · intro a b
    calc
      zeroRealization (a + b) = 0 := rfl
      _ = 0 + 0 := by norm_num
      _ = zeroRealization a + zeroRealization b := rfl

/-! ## 加法性だけでは異なる有限個数を識別しない -/

/-- 正の有限個数一・二の対数順序群値は異なる。 -/
theorem logarithm_one_ne_logarithm_two :
    logarithm (positiveNat 1 (by decide)) ≠
      logarithm (positiveNat 2 (by decide)) := by
  intro h
  have hReconstructed := congrArg reconstruct h
  rw [reconstruct_logarithm, reconstruct_logarithm] at hReconstructed
  have hValues := congrArg (fun q : PositiveRational => q.val) hReconstructed
  norm_num [positiveNat] at hValues

/-- 相異なる正の有限個数一・二を、加法的な零実数実現は同じ零へ送る。 -/
theorem additiveRealization_needNotDistinguishCounts :
    logarithm (positiveNat 1 (by decide)) ≠
        logarithm (positiveNat 2 (by decide)) ∧
      zeroRealization (logarithm (positiveNat 1 (by decide))) =
          zeroRealization (logarithm (positiveNat 2 (by decide))) ∧
      zeroRealization (logarithm (positiveNat 2 (by decide))) = 0 := by
  constructor
  · exact logarithm_one_ne_logarithm_two
  · constructor <;> rfl

end

end CellularAutomata.AdditiveRealizationNonseparationBoundary
