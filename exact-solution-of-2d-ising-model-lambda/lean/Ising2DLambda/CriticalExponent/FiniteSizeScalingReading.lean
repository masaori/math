/-
人手証明 `def_finite_size_scaling_reading` の具体版。

  人手証明                                                       このファイル
  0 <_R d_1(L) を ρ で送り 0 < ρ(d_1(L))（分子の正値性）          `realizedLeadingDistance_pos`
  1 < ι(L)、log_ℝ の狭義単調性、log_ℝ(1) = 0（分母の正値性）      `latticeSizeCast_pos`・`latticeSizeRealLog_pos`
  a_ρ(L) := −log_ℝ(ρ(d_1(L))) / (2·log_ℝ(ι(L)))                  `scalingLogRatio`
  「指数 ν を読める」の ε–N 条件                                   `FiniteSizeScalingReads`

定義だけを置く。固定した実現データに対しこの条件を満たす ν の存在・一意性・値
（2 次元 Ising で ν = 1 となること）は主張しない。
住処: R（実対数と極限の量化による実数体への脱出）。
-/
import Ising2DLambda.CriticalExponent.RealClosedRealization
import Ising2DLambda.CriticalExponent.LeadingDistancePositive
import Ising2DLambda.ThermodynamicLimit.RealLogarithmIntPower

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.ThermodynamicLimit

/-- 分子の正値性: `0 <_R d_1(L)` を実現データで送ると `0 < ρ(d_1(L))`。 -/
theorem realizedLeadingDistance_pos (base : RealClosedSubfieldData)
    (real : RealClosedRealization base) (s : Qbar) (hs : s * s = 2)
    (L : ℕ) [NeZero L] (hL : 2 ≤ L) :
    0 < real.toRingHom (leadingDistance L hL base s hs) := by
  -- 人手証明: claim_leading_distance_positive で 0 <_R d_1(L)
  have h := leadingDistance_positive L hL base s hs
  -- 人手証明: 第二条件（狭義順序の保存）で ρ(0) < ρ(d_1(L))
  have h2 := real.map_lt 0 (leadingDistance L hL base s hs) h
  -- 人手証明: 第一条件から ρ(0) = 0
  rwa [map_zero] at h2

/-- 格子の大きさは実数として正である（`2 ≤ L` から）。 -/
theorem latticeSizeCast_pos (L : ℕ) (hL : 2 ≤ L) : (0 : ℝ) < (L : ℝ) := by
  exact_mod_cast (by omega : 0 < L)

/-- 分母の正値性: `1 < ι(L)`・`log_ℝ` の狭義単調性・`log_ℝ(1) = 0` から
    `0 < log_ℝ(ι(L))`。 -/
theorem latticeSizeRealLog_pos (L : ℕ) (hL : 2 ≤ L) :
    0 < realLog ⟨(L : ℝ), latticeSizeCast_pos L hL⟩ := by
  -- 人手証明: 2 ≤ L から 1 < L、包含は順序を保つので 1 = ι(1) < ι(L)
  have h1 : (1 : ℝ) < (L : ℝ) := by exact_mod_cast (by omega : 1 < L)
  -- 人手証明: log_ℝ の狭義単調性
  have hlt := realLog_lt_realLog ⟨1, one_pos⟩ ⟨(L : ℝ), latticeSizeCast_pos L hL⟩ h1
  -- 人手証明: log_ℝ(1) = 0（claim_real_logarithm_int_power）
  rwa [realLog_one] at hlt

/-- 読みの列 `a_ρ(L) := −log_ℝ(ρ(d_1(L))) / (2·log_ℝ(ι(L)))`。 -/
noncomputable def scalingLogRatio (base : RealClosedSubfieldData)
    (real : RealClosedRealization base) (s : Qbar) (hs : s * s = 2)
    (L : ℕ) (hL : 2 ≤ L) : ℝ :=
  haveI : NeZero L := ⟨by omega⟩;
  -(realLog ⟨real.toRingHom (leadingDistance L hL base s hs),
      realizedLeadingDistance_pos base real s hs L hL⟩) /
    (2 * realLog ⟨(L : ℝ), latticeSizeCast_pos L hL⟩)

/-- 「実現データ ρ の下で指数 ν を読める」の ε–N 条件。
    量化は ℕ と ℚ の上を走り、実数体に住むのは比較される値だけである。 -/
def FiniteSizeScalingReads (base : RealClosedSubfieldData)
    (real : RealClosedRealization base) (s : Qbar) (hs : s * s = 2)
    (nu : ℚ) (_hnu : 0 < nu) : Prop :=
  ∀ ε : ℚ, 0 < ε → ∃ N : ℕ, ∀ L : ℕ, ∀ hL : 2 ≤ L, N ≤ L →
    ((1 / nu : ℚ) : ℝ) - (ε : ℝ) < scalingLogRatio base real s hs L hL ∧
      scalingLogRatio base real s hs L hL < ((1 / nu : ℚ) : ℝ) + (ε : ℝ)

end Ising2DLambda.CriticalExponent
