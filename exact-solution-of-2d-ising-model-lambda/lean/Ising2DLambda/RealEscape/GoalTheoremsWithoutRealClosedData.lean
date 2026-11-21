/-
到達点のうち実閉部分体のデータを引数に取る三つの具体版
（`theorem_periodic_density_onsager_integral`、`claim_onsager_hyperbolic_integral_form`、
`claim_dispersion_minimum_self_dual_point`）から、そのデータの引数を外した形。

  人手証明                                                          このファイル
  `def_real_closed_subfield` の「5 条件を満たす組は `claim_real_closed_subfield_exists` により
    存在する。以下ではその 1 つを固定して使う」
                                                                    `realClosedSubfield_exists` で値を取る
  `s` は `claim_sqrt_two_exists` により存在が示された `s·s = 2` の元   `sqrtTwo_exists`

周期境界の密度と Onsager 表示は、主張に組 `(R, ω)` が現れないので、存在の主張で取った組を
既存の具体版へ渡すだけで引数が消える。分散因子の最小値の主張は `ξ ∈ R` について述べるので、
組の存在と、その組について主張が成り立つことを一つの存在として述べる。

`z⁴ = -1` を満たす `z`（本文の `ζ_8`。`def_rotation_phase` が `claim_eighth_root_exists` で存在を示して固定する）も
`eighthRoot_exists` で値を取るので、三つの主張はどれも引数を取らない。
最後の `goalTheorems` は、有限トーラス公式を含む到達点の四つを、仮定の無い一つの主張として述べる。
脱出理由: 引いた具体版と同じ（実対数、指数評価、連続極限、Riemann 積分、実数の角と余弦）。
必要十分版の定理・定義は使わない。
-/
import Ising2DLambda.RealEscape.ShiftedModeRiemannSums
import Ising2DLambda.RealEscape.DispersionMinimumSelfDualPoint
import Ising2DLambda.FisherZero.RealClosedSubfieldExists
import Ising2DLambda.FisherZero.SqrtTwoExists
import Ising2DLambda.FisherZero.EighthRootExists
import Ising2DLambda.KacWard.DeterminantSquareRootTorusFormula
import Ising2DLambda.KacWard.DeterminantPolynomialSquareRootExists

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.KacWard
open Ising2DLambda.PartitionPolynomial

/-- `claim_sqrt_two_exists` と `claim_real_closed_subfield_exists` から、本文が固定する組のデータを取る。 -/
theorem realClosedSubfieldData_exists : Nonempty RealClosedSubfieldData := by
  obtain ⟨s, hs⟩ := sqrtTwo_exists
  have hs' : s * s = algebraMap ℚ Qbar 2 := by
    rw [hs]
    exact (map_ofNat (algebraMap ℚ Qbar) 2).symm
  obtain ⟨data⟩ := realClosedSubfield_exists s hs'
  exact ⟨data.toRealClosedSubfieldData⟩

/-- `theorem_periodic_density_onsager_integral` の具体版から実閉部分体のデータの引数を外したもの:
`f^per(q) = I_q`。 -/
theorem periodicFreeEnergyDensity_eq_dispersionIntegral_withoutRealClosedData
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    periodicFreeEnergyDensity q = dispersionIntegral q hq0 hq1 := by
  obtain ⟨data⟩ := realClosedSubfieldData_exists
  obtain ⟨z, hz4⟩ := eighthRoot_exists
  exact periodicFreeEnergyDensity_eq_dispersionIntegral data z hz4 q hq0 hq1

/-- `claim_onsager_hyperbolic_integral_form` の具体版から実閉部分体のデータの引数を外したもの。 -/
theorem periodicFreeEnergyDensity_onsagerForm_withoutRealClosedData
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
      paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
      (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
      periodicFreeEnergyDensity q =
        realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
  obtain ⟨data⟩ := realClosedSubfieldData_exists
  obtain ⟨z, hz4⟩ := eighthRoot_exists
  exact periodicFreeEnergyDensity_onsagerForm data z hz4 q hq0 hq1

/-- `claim_dispersion_minimum_self_dual_point` の具体版から実閉部分体のデータの引数を外したもの。
`s · s = 2` の `s` について、五条件を満たす組が在り、その組の任意の `0 <_R ξ <_R 1` で
最小値・達成点・零点の同定・自己双対性が成り立つ。 -/
theorem dispersion_minimum_self_dual_point_withoutRealClosedData {s : Qbar} (hs : s * s = 2) :
    ∃ data : RealClosedSubfieldSqrtTwoData s, ∀ (ξ : data.carrier),
      realAlgebraicLt data.toRealClosedSubfieldData 0 ξ →
      realAlgebraicLt data.toRealClosedSubfieldData ξ 1 →
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
  have hs' : s * s = algebraMap ℚ Qbar 2 := by
    rw [hs]
    exact (map_ofNat (algebraMap ℚ Qbar) 2).symm
  obtain ⟨data⟩ := realClosedSubfield_exists s hs'
  exact ⟨data, fun ξ hξ0 hξ1 => dispersion_minimum_self_dual_point data hs ξ hξ0 hξ1⟩

/-- 到達点の四つ（`claim_determinant_square_root_torus_formula`、`theorem_periodic_density_onsager_integral`、
`claim_onsager_hyperbolic_integral_form`、`claim_dispersion_minimum_self_dual_point`）を、仮定の無い一つの主張にまとめたもの。

一つ目は `ζ_8` の存在（`claim_eighth_root_exists`）である。二つ目の有限トーラス公式は、`z⁴ = -1` を満たす任意の `z` と
任意の辺長 `L ≥ 1` について、四つの Kac--Ward 行列式の定数項一の平方根がちょうど一つずつ存在し
（`claim_determinant_polynomial_square_root_exists`）、それらで分配多項式が `½` 倍の和に等しいことを述べる。
三つ目から五つ目は上の三つの `_withoutRealClosedData` である。 -/
theorem goalTheorems :
    (∃ z : Qbar, z ^ 4 = -1) ∧
    (∀ z : Qbar, z ^ 4 = -1 → ∀ (L : ℕ) [NeZero L],
      (∀ s : SpinStructure, ∃! S : QbarPoly,
        qbarPolynomialSquareRoot (kacWardDeterminant (kacWardTransitionMatrix L z s)) S) ∧
      ∀ S : SpinStructure → QbarPoly,
        (∀ s : SpinStructure,
          qbarPolynomialSquareRoot (kacWardDeterminant (kacWardTransitionMatrix L z s)) (S s)) →
        (partitionPolynomial L).map (Int.castRingHom Qbar) =
          Polynomial.C (1 / 2 : Qbar) * ∑ s : SpinStructure, S s) ∧
    (∀ (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1),
      periodicFreeEnergyDensity q = dispersionIntegral q hq0 hq1) ∧
    (∀ (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1),
      paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
        paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
        (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
        periodicFreeEnergyDensity q =
          realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
            1 / (8 * Real.pi ^ 2) *
              (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
                onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂))) ∧
    (∀ s : Qbar, ∀ hs : s * s = 2,
      ∃ data : RealClosedSubfieldSqrtTwoData s, ∀ (ξ : data.carrier),
        realAlgebraicLt data.toRealClosedSubfieldData 0 ξ →
        realAlgebraicLt data.toRealClosedSubfieldData ξ 1 →
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
            ((criticalPointRealClosed data.toRealClosedSubfieldData s hs : _) : Qbar)) :=
  ⟨eighthRoot_exists,
    fun z hz _ _ =>
      ⟨fun s => kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot z hz s,
        fun S hS => partitionPolynomial_eq_half_sum_kacWardSquareRoots z hz S hS⟩,
    periodicFreeEnergyDensity_eq_dispersionIntegral_withoutRealClosedData,
    periodicFreeEnergyDensity_onsagerForm_withoutRealClosedData,
    fun _ hs => dispersion_minimum_self_dual_point_withoutRealClosedData hs⟩

end Ising2DLambda.RealEscape
