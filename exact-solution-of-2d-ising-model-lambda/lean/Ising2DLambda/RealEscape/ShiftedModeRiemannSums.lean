/-
「半格子ずれた四つのモード和は同じ積分へ収束する」（`claim_shifted_mode_riemann_sums`）、
「周期境界の自由エネルギー密度は分散因子の積分に等しい」（`theorem_periodic_density_onsager_integral`）、
「分散因子の積分の Onsager 表示への書換え」（`claim_onsager_hyperbolic_integral_form`）の具体版。

  人手証明                                                          このファイル
  最初の式鎖の一行目:
    L^{-2} log_ℝ |ρ(Q^{a,b}_L(q))| = (1/(2L²)) Σ_{(ϖ,ς)} log_ℝ ρ(Δ(q;ϖ,ς))   `realLogSum_of_dispersionProduct`
                                                  （claim_dispersion_product_real_log_sum の具体版
                                                    `dispersion_product_real_log_sum` から）
  最初の式鎖の二〜四行目と結論の式鎖                                   `modeLogDensity_tendsto_of_realLogSum`
  四つの (a,b) の極限から f^per(q) = I_q と Onsager 表示              `periodicFreeEnergyDensity_eq_dispersionIntegral_of_realLogSum`
                                                                     `periodicFreeEnergyDensity_onsagerForm_of_realLogSum`

和の項は `φ(ϖ,ς) := log_ℝ ρ(Δ(q;ϖ,ς))` で、`Δ(q;ϖ,ς)` は `dispersion_product_real_log_sum` が与える
実閉部分体の元である。同じ `Qbar` の値を持つ実閉部分体の元は等しいので、`hsum` の一つ目の条件が従う。

脱出理由: 実対数、指数評価（角表示）、連続極限（辺長を無限大へ送る）、Riemann 積分。いずれも引いた段で宣言済み。
必要十分版の定理・定義は使わない。
-/
import Ising2DLambda.RealEscape.ShiftedModeRiemannSumsOfRealLogSum
import Ising2DLambda.RealEscape.DispersionProductRealLogSum

namespace Ising2DLambda.RealEscape

open Filter Topology
open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.KacWard

/-- 最初の式鎖の一行目: `u_{L,a,b} = (1/(2L²)) Σ_{(ϖ,ς)} log_ℝ ρ(Δ(q;ϖ,ς))`
（`claim_dispersion_product_real_log_sum`）。 -/
theorem realLogSum_of_dispersionProduct (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (s : SpinStructure) (L : ℕ) [NeZero L] :
    ∃ φ : FourierModePair L s → ℝ,
      (∀ (m : FourierModePair L s) (D : data.carrier),
        (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) →
          φ m = Real.log (realAlgebraicCutRealization data D)) ∧
      modeLogDensity data q s L = 1 / (2 * (L : ℝ) ^ 2) * ∑ m : FourierModePair L s, φ m := by
  obtain ⟨Δ, hΔ, -, hlog⟩ := dispersion_product_real_log_sum (L := L) data z hz4 s q hq0 hq1
  refine ⟨fun m => Real.log (realAlgebraicCutRealization data (Δ m)), fun m D hD => ?_, ?_⟩
  · -- Δ(q;ϖ,ς) と D は同じ代数的数を表すので、実閉部分体の元として等しい
    have hΔD : Δ m = D := Subtype.ext ((hΔ m).trans hD.symm)
    show Real.log (realAlgebraicCutRealization data (Δ m)) = _
    rw [hΔD]
  · -- u_{L,a,b} の定義（L ≠ 0）と claim_dispersion_product_real_log_sum
    rw [modeLogDensity, dif_neg (NeZero.ne L)]
    exact hlog

/-- `claim_shifted_mode_riemann_sums` の具体版: `u_{L,a,b} → I_q`。 -/
theorem shiftedModeRiemannSums_tendsto (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (s : SpinStructure) :
    Tendsto (modeLogDensity data q s) atTop (𝓝 (dispersionIntegral q hq0 hq1)) :=
  modeLogDensity_tendsto_of_realLogSum data q hq0 hq1 s
    (fun L => realLogSum_of_dispersionProduct data z hz4 q hq0 hq1 s L)

/-- `theorem_periodic_density_onsager_integral` の具体版: `f^per(q) = I_q`。 -/
theorem periodicFreeEnergyDensity_eq_dispersionIntegral
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    periodicFreeEnergyDensity q = dispersionIntegral q hq0 hq1 :=
  periodicFreeEnergyDensity_eq_dispersionIntegral_of_realLogSum data z hz4 q hq0 hq1
    (fun s L => realLogSum_of_dispersionProduct data z hz4 q hq0 hq1 s L)

/-- `claim_onsager_hyperbolic_integral_form` の具体版。 -/
theorem periodicFreeEnergyDensity_onsagerForm
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
      paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
      (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
      periodicFreeEnergyDensity q =
        realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) :=
  periodicFreeEnergyDensity_onsagerForm_of_realLogSum data z hz4 q hq0 hq1
    (fun s L => realLogSum_of_dispersionProduct data z hz4 q hq0 hq1 s L)

end Ising2DLambda.RealEscape
