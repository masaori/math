import Ising2DLambda.RealEscape.DispersionMinimumSelfDualPoint
import Ising2DLambda.NecSuf.RealEscape.DispersionMinimumSelfDualPoint
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

/-- 具体版の主張は、必要十分版を `R := 実閉部分体`、`K := ℝ`、`X := ℝ × ℝ`、`D := [0,2π]²`、
`x₀ := (0,0)`、`cⱼ := cos ∘ (第 j 成分)`、`ρ := realAlgebraicCutRealization`、`s := √2 の R での元` に
特殊化して得られる。 -/
theorem dispersion_minimum_self_dual_point_from_necSuf {s : Qbar}
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2) (ξ : data.carrier)
    (hξ0 : realAlgebraicLt data.toRealClosedSubfieldData 0 ξ)
    (hξ1 : realAlgebraicLt data.toRealClosedSubfieldData ξ 1) :
    IsLeast (dispersionMinimumValues (realAlgebraicCutRealization data.toRealClosedSubfieldData ξ))
        ((1 - 2 * realAlgebraicCutRealization data.toRealClosedSubfieldData ξ
          - realAlgebraicCutRealization data.toRealClosedSubfieldData ξ ^ 2) ^ 2) ∧
      dispersionMinimumArgument (realAlgebraicCutRealization data.toRealClosedSubfieldData ξ) 0 0 =
        (1 - 2 * realAlgebraicCutRealization data.toRealClosedSubfieldData ξ
          - realAlgebraicCutRealization data.toRealClosedSubfieldData ξ ^ 2) ^ 2 ∧
      ((1 - 2 * realAlgebraicCutRealization data.toRealClosedSubfieldData ξ
          - realAlgebraicCutRealization data.toRealClosedSubfieldData ξ ^ 2) ^ 2 = 0 ↔
        ξ = criticalPointRealClosed data.toRealClosedSubfieldData s hs) ∧
      kwDualTransform ((criticalPointRealClosed data.toRealClosedSubfieldData s hs : _) : Qbar) =
        ((criticalPointRealClosed data.toRealClosedSubfieldData s hs : _) : Qbar) := by
  obtain ⟨t, htval⟩ := sqrtTwo_mem_realClosed data.toRealClosedSubfieldData s hs
  have ht : t * t = 2 := by
    apply Subtype.ext; push_cast; rw [htval]; exact hs
  have hxc : criticalPointRealClosed data.toRealClosedSubfieldData s hs = -1 + t := by
    apply Subtype.ext; rw [criticalPointRealClosed_val]; push_cast; rw [htval]
  have htwo : (2 : data.carrier) ≠ 0 := by
    intro h
    have h2 : ((2 : data.carrier) : Qbar) = 0 := by rw [h]; rfl
    rw [realClosed_two_val] at h2
    exact two_ne_zero h2
  have hpos : Ising2DLambda.NecSuf.RealEscape.squareDifferenceLt (0 : data.carrier) (-1 + t) :=
    hxc ▸ criticalPoint_positive data hs
  have h := Ising2DLambda.NecSuf.RealEscape.dispersion_minimum_self_dual_point_necSuf
    (realClosed_sum_of_two_squares_is_square data.toRealClosedSubfieldData)
    (fun u v huv => realClosed_sq_add_sq_eq_zero data.toRealClosedSubfieldData u v
      (by have := congrArg (fun z : data.carrier => (z : Qbar)) huv; push_cast at this; exact this))
    htwo (realAlgebraicCutRealization data.toRealClosedSubfieldData)
    (cutRealization_preserves_addition data.toRealClosedSubfieldData)
    (cutRealization_preserves_multiplication data.toRealClosedSubfieldData)
    (cutRealization_zero _) (cutRealization_one _) (cutRealization_two _)
    (fun a b hab => cutRealization_preserves_strict_order _ hab)
    (cutRealization_injective _) t ht hpos ξ hξ0 hξ1
    (Set.Icc 0 (2 * Real.pi) ×ˢ Set.Icc 0 (2 * Real.pi)) (0, 0)
    ⟨⟨le_rfl, Real.two_pi_pos.le⟩, ⟨le_rfl, Real.two_pi_pos.le⟩⟩
    (fun θ : ℝ × ℝ => Real.cos θ.1) (fun θ : ℝ × ℝ => Real.cos θ.2)
    (fun θ => Real.cos_le_one θ.1) (fun θ => Real.cos_le_one θ.2) Real.cos_zero Real.cos_zero
  obtain ⟨hleast, hzero, hiff, hkw⟩ := h
  have hset : (Ising2DLambda.NecSuf.RealEscape.dispersionMinimumArgumentNecSuf
      (realAlgebraicCutRealization data.toRealClosedSubfieldData ξ)
      (fun θ : ℝ × ℝ => Real.cos θ.1) (fun θ : ℝ × ℝ => Real.cos θ.2) ''
        (Set.Icc 0 (2 * Real.pi) ×ˢ Set.Icc 0 (2 * Real.pi))) =
      dispersionMinimumValues (realAlgebraicCutRealization data.toRealClosedSubfieldData ξ) := by
    ext y
    constructor
    · rintro ⟨⟨θ₁, θ₂⟩, ⟨h₁, h₂⟩, rfl⟩
      exact ⟨θ₁, θ₂, h₁, h₂, rfl⟩
    · rintro ⟨θ₁, θ₂, h₁, h₂, rfl⟩
      exact ⟨(θ₁, θ₂), ⟨h₁, h₂⟩, rfl⟩
  refine ⟨hset ▸ hleast, hzero, by rw [hxc]; exact hiff, ?_⟩
  rw [hxc]
  have hkwQ := congrArg (fun z : data.carrier => (z : Qbar)) hkw
  push_cast at hkwQ
  unfold kwDualTransform
  push_cast
  linear_combination hkwQ

end Ising2DLambda.RealEscape
