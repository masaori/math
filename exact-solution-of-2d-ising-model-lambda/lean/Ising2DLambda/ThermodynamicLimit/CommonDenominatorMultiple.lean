/-
人手証明「共通分母の正整数倍は共通分母である」（`claim_common_denominator_multiple`）と
「有理係数の対数順序群の二元は共通の共通分母を持つ」（`claim_common_common_denominator_exists`）の具体版。

`N` が `λ ∈ Λ_ℚ` の共通分母（証人 `λ_N`）で `k ≥ 1` なら、`kN` も共通分母で証人は `k·λ_N`。
証明は本文と同じ三段の鎖: 有理数倍の結合則 → `N` は共通分母 → 整数倍と `ι` の交換。
二元については `N_λ N_μ` が `λ`（`k = N_μ`）と `μ`（`k = N_λ`）の共通分母であることを、
`claim_common_denominator_exists` と上の主張と ℕ の積の可換性から出す。
住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.CommonDenominatorExists

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `claim_common_denominator_multiple`: `kN` は共通分母で、証人は `k·λ_N`。 -/
theorem commonDenominator_mul (k N : ℕ) (l : RationalLogOrderGroup) (lN : LogOrderGroup)
    (h : IsCommonDenominator N l lN) :
    IsCommonDenominator (k * N) l (((k : ℤ)) • lN) := by
  unfold IsCommonDenominator at h ⊢
  calc
    (((k * N : ℕ) : ℚ)) • l
        = ((k : ℚ) * (N : ℚ)) • l := by rw [Nat.cast_mul]
    _ = (k : ℚ) • ((N : ℚ) • l) := (smul_smul _ _ _).symm            -- 有理数倍の結合則
    _ = (k : ℚ) • toRational lN := by rw [h]                          -- N は λ の共通分母、証人 λ_N
    _ = (((k : ℤ) : ℚ)) • toRational lN := by rw [Int.cast_natCast]
    _ = toRational (((k : ℤ)) • lN) := toRational_intSmul _ _          -- 整数倍と ι の交換

/-- `claim_common_common_denominator_exists`: `N_λ N_μ` は `λ` と `μ` の両方の共通分母。 -/
theorem commonCommonDenominator_exists (l m : RationalLogOrderGroup) :
    IsCommonDenominator (denominatorProduct l * denominatorProduct m) l
        (((denominatorProduct m : ℤ)) • commonDenominatorWitness l) ∧
      IsCommonDenominator (denominatorProduct l * denominatorProduct m) m
        (((denominatorProduct l : ℤ)) • commonDenominatorWitness m) := by
  refine ⟨?_, ?_⟩
  · -- N_μ N_λ は λ の共通分母（k = N_μ、N = N_λ）、ℕ の積の可換性で N_λ N_μ
    have h := commonDenominator_mul (denominatorProduct m) (denominatorProduct l) l
      (commonDenominatorWitness l) (commonDenominator_exists l)
    rw [Nat.mul_comm] at h
    exact h
  · -- N_λ N_μ は μ の共通分母（k = N_λ、N = N_μ）
    exact commonDenominator_mul (denominatorProduct l) (denominatorProduct m) m
      (commonDenominatorWitness m) (commonDenominator_exists m)

end Ising2DLambda.ThermodynamicLimit
