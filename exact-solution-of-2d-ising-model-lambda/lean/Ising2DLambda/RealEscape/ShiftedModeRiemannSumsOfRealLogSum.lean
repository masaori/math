/-
「半格子ずれた四つのモード和は同じ積分へ収束する」（`claim_shifted_mode_riemann_sums`）の証明の合成の段と、
それを「周期境界の自由エネルギー密度は分散因子の積分に等しい」（`theorem_periodic_density_onsager_integral`）へつなぐ段の具体版。
最初の式鎖の一行目（`claim_dispersion_product_real_log_sum`）だけを仮定 `hsum` に残す。

  人手証明                                                          このファイル
  最初の式鎖の一行目:
    L^{-2} log_ℝ |ρ(Q^{a,b}_L(q))| = (1/(2L²)) Σ_{(ϖ,ς)} log_ℝ ρ(Δ(q;ϖ,ς))   仮定 `hsum`
  最初の式鎖の二〜四行目（再添字付けと角表示）                         `modeSum_realizedDispersionLog_eq_sampleSum`
  結論の式鎖:
    lim L^{-2} log_ℝ |ρ(Q)| = lim (1/(2L²)) Σ f_q(t)   （上の有限和の等式）
                            = I/(8π²)                   `halfInvSq_sampleSum_tendsto`
  I/(8π²) は `dispersionIntegral` の値                                 `dispersionAngleDoubleIntegral_div_eq`
  四つの (a,b) の極限から f^per(q) = I_q                            `periodicFreeEnergyDensity_eq_dispersionIntegral_of_realLogSum`

`hsum` の `φ` は和の項 `log_ℝ ρ(Δ(q;ϖ,ς))` で、その定め方と `Δ(q;ϖ,ς)` が `R` の元であることは
`modeSum_realizedDispersionLog_eq_sampleSum` の `hφ`・`hex` と同じである。`hsum` には
`ShiftedModeRiemannSums.lean` が `claim_dispersion_product_real_log_sum` の具体版を当てる。

脱出理由: 実対数、指数評価（角表示）、連続極限（辺長を無限大へ送る）、Riemann 積分。いずれも引いた段で宣言済み。
必要十分版の定理・定義は使わない。
-/
import Ising2DLambda.RealEscape.ShiftedModeSumReindex
import Ising2DLambda.RealEscape.PeriodicDensityOnsagerOfModeLimits

namespace Ising2DLambda.RealEscape

open Filter Topology
open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.KacWard

/-- `I/(8π²)` は `I_q`（`dispersionIntegral`）に等しい。 -/
theorem dispersionAngleDoubleIntegral_div_eq (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    dispersionAngleDoubleIntegral q hq0 hq1 / (8 * Real.pi ^ 2) = dispersionIntegral q hq0 hq1 := by
  rw [dispersionAngleDoubleIntegral, dispersionIntegral]
  ring

/-- `claim_shifted_mode_riemann_sums` の具体版を、最初の式鎖の一行目 `hsum` から合成する:
`u_{L,a,b} := L^{-2} log_ℝ |ρ(Q^{a,b}_L(q))| → I_q`。 -/
theorem modeLogDensity_tendsto_of_realLogSum (data : RealClosedSubfieldData)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (s : SpinStructure)
    (hsum : ∀ (L : ℕ) [NeZero L], ∃ φ : FourierModePair L s → ℝ,
      (∀ (m : FourierModePair L s) (D : data.carrier),
        (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) →
          φ m = Real.log (realAlgebraicCutRealization data D)) ∧
      (∀ m : FourierModePair L s, ∃ D : data.carrier,
        (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar)) ∧
      modeLogDensity data q s L = 1 / (2 * (L : ℝ) ^ 2) * ∑ m : FourierModePair L s, φ m) :
    Tendsto (modeLogDensity data q s) atTop (𝓝 (dispersionIntegral q hq0 hq1)) := by
  -- 結論の式鎖の二・三行目
  have hlim := halfInvSq_sampleSum_tendsto q hq0 hq1 s
  rw [dispersionAngleDoubleIntegral_div_eq] at hlim
  refine hlim.congr' ?_
  filter_upwards [eventually_ge_atTop 1] with L hL
  haveI : NeZero L := ⟨by omega⟩
  obtain ⟨φ, hφ, hex, hu⟩ := hsum L
  symm
  calc modeLogDensity data q s L
      -- 最初の式鎖の一行目: claim_dispersion_product_real_log_sum
      = 1 / (2 * (L : ℝ) ^ 2) * ∑ m : FourierModePair L s, φ m := hu
    -- 最初の式鎖の二〜四行目: 再添字付けと角表示
    _ = 1 / (2 * (L : ℝ) ^ 2) * ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
          dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l) := by
        rw [modeSum_realizedDispersionLog_eq_sampleSum data L s q hq0 hq1 φ hφ hex]

/-- `theorem_periodic_density_onsager_integral` の具体版を、四つの `(a,b)` の `hsum` から合成する。 -/
theorem periodicFreeEnergyDensity_eq_dispersionIntegral_of_realLogSum
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hsum : ∀ (s : SpinStructure) (L : ℕ) [NeZero L], ∃ φ : FourierModePair L s → ℝ,
      (∀ (m : FourierModePair L s) (D : data.carrier),
        (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) →
          φ m = Real.log (realAlgebraicCutRealization data D)) ∧
      (∀ m : FourierModePair L s, ∃ D : data.carrier,
        (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar)) ∧
      modeLogDensity data q s L = 1 / (2 * (L : ℝ) ^ 2) * ∑ m : FourierModePair L s, φ m) :
    periodicFreeEnergyDensity q = dispersionIntegral q hq0 hq1 :=
  periodicFreeEnergyDensity_eq_dispersionIntegral_of_modeLimits data z hz4 q hq0 hq1
    -- 四つのモード和の極限: claim_shifted_mode_riemann_sums
    (fun s => modeLogDensity_tendsto_of_realLogSum data q hq0 hq1 s (hsum s))

end Ising2DLambda.RealEscape
