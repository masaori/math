/-
「周期境界の自由エネルギー密度は分散因子の積分に等しい」（`theorem_periodic_density_onsager_integral`）と
「分散因子の積分の Onsager 表示への書換え」（`claim_onsager_hyperbolic_integral_form`）の合成の段のうち、
対数順序群の鎖を `claim_partition_log_order_bounds` の具体版で与え、四つのモード和の極限
（`claim_shifted_mode_riemann_sums`）だけを仮定 `hmode` に残す段の具体版。

  人手証明                                                         このファイル
  `I_q := (1/8π²)∫₀^{2π}∫₀^{2π} log_ℝ B_q`、`B_q` は `claim_dispersion_angle_log_continuous` の被対数
                                                                    `dispersionIntegral`
  `theorem_periodic_density_onsager_integral` の証明の鎖は `claim_partition_log_order_bounds` から取る
                                                                    `partitionLogOrderBounds`
  四つの `u_{L,a,b} → I_q`（`claim_shifted_mode_riemann_sums`）から `f^per(q) = I_q`
                                                                    `periodicFreeEnergyDensity_eq_dispersionIntegral_of_modeLimits`
  `claim_onsager_hyperbolic_integral_form` の最初の行 `f^per(q) = I_q`
    （`theorem_periodic_density_onsager_integral`）と、書換えの段の残りの行
    （`I_q = log_ℝ 2 + log_ℝ r + (1/8π²)∫∫ log_ℝ H_q`、`c_q = cosh(2K_q)`、`s_q = sinh(2K_q)`、`H_q > 0`）
                                                                    `periodicFreeEnergyDensity_onsagerForm_of_modeLimits`

人手証明の残り（四つの列 `u_{L,a,b}` が `I_q` に収束すること＝`claim_shifted_mode_riemann_sums`）は、
仮定 `hmode` として受け、その主張の具体版ができたときに当てて二つの本文ブロックの `lean:` を登録する。
必要十分版の定理は使わない（`NecSuf.` を参照しない）。
実数体への脱出: 実現写像 `ρ_{R→ℝ}`、実対数、実数列の極限、上限、Riemann 積分、指数評価（引いた段で宣言済み）。
-/
import Ising2DLambda.RealEscape.PeriodicDensityModeMaxLimit
import Ising2DLambda.RealEscape.OnsagerHyperbolicIntegralRewrite
import Ising2DLambda.KacWard.PartitionLogOrderBounds

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Ising2DLambda.KacWard
open Ising2DLambda.FisherZero Ising2DLambda.AlgebraicEigenvalue
open Filter Topology

/-- `I_q := (1/8π²)∫₀^{2π}∫₀^{2π} log_ℝ B_q(θ₁,θ₂) dθ₂ dθ₁`。 -/
noncomputable def dispersionIntegral (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) : ℝ :=
  1 / (8 * Real.pi ^ 2) *
    (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
      dispersionAngleLog q hq0 hq1 (θ₁, θ₂))

/-- `theorem_periodic_density_onsager_integral` の合成: 鎖を `claim_partition_log_order_bounds` から取り、
四つの `u_{L,a,b} → I_q` から `f^per(q) = I_q`。 -/
theorem periodicFreeEnergyDensity_eq_dispersionIntegral_of_modeLimits
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hmode : ∀ s : SpinStructure,
      Tendsto (modeLogDensity data q s) atTop (𝓝 (dispersionIntegral q hq0 hq1))) :
    periodicFreeEnergyDensity q = dispersionIntegral q hq0 hq1 :=
  periodicFreeEnergyDensity_eq_of_modeLimits data z hz4 q hq0 hq1 (dispersionIntegral q hq0 hq1)
    -- 鎖: claim_partition_log_order_bounds
    (fun L _ => partitionLogOrderBounds (L := L) data z hz4 q hq0 hq1)
    -- 四つのモード和の極限: claim_shifted_mode_riemann_sums
    hmode

/-- `claim_onsager_hyperbolic_integral_form` の合成: `c_q = cosh(2K_q)`、`s_q = sinh(2K_q)`、`H_q > 0`、
`f^per(q) = log_ℝ 2 + log_ℝ r + (1/8π²)∫∫ log_ℝ H_q`。 -/
theorem periodicFreeEnergyDensity_onsagerForm_of_modeLimits
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hmode : ∀ s : SpinStructure,
      Tendsto (modeLogDensity data q s) atTop (𝓝 (dispersionIntegral q hq0 hq1))) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
      paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
      (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
      periodicFreeEnergyDensity q =
        realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
  obtain ⟨hc, hs, hH, hint⟩ := onsager_hyperbolic_integral_rewrite q hq0 hq1
  refine ⟨hc, hs, hH, ?_⟩
  calc periodicFreeEnergyDensity q
      = dispersionIntegral q hq0 hq1 :=
        -- theorem_periodic_density_onsager_integral
        periodicFreeEnergyDensity_eq_dispersionIntegral_of_modeLimits data z hz4 q hq0 hq1 hmode
    _ = realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) :=
        -- 書換えの段の残りの行
        hint

end Ising2DLambda.RealEscape
