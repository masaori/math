/-
人手証明 `claim_leading_distance_pinching_implies_predicate` の具体版。

  人手証明                                                      このファイル
  η := ε²/4 ∈ Q_{>0}（Q の四則と順序）                          `etaQ`・`hetaQ`
  仮定を η に当てて L（2 ≤ L）を取る                            `hHyp etaQ hetaQ`
  上界の同値の第一→第二で ξ ∈ F_L を取る                        `leadingDistance_lt_iff` の mp
  有理近似で q ∈ Q_{>0} を取る                                  `criticalPoint_exists_positiveRational_squareDiff_lt`
  一意表示 ξ = α + β·ω                                          `realClosedComponents`
  x_c ∈ R、q ∈ R（臨界点の所属・有理数の所属）                   `criticalPoint_mem_realClosed`・`rational_mem_realClosedCarrier`
  証人 c₁・c₂・g の用意                                          `hCrit`・`hApprox`・`hSquare`
  t·t = 2 と式変形の鎖（z₁, z₂, z₃ の合成）                     `calc` の各段
  ε² = 4·η の書き戻しと Pinch の証人の提示                       本定理の結び
-/
import Ising2DLambda.CriticalExponent.LeadingDistanceLtIff
import Ising2DLambda.CriticalExponent.CriticalPointRationalApproximation
import Ising2DLambda.CriticalExponent.SquareOfSumLeTwiceSquares
import Ising2DLambda.FisherZero.ZeroPinchingPredicate
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 先頭距離の詰め寄りの仮定から、詰め寄りの述語 `Pinch(ε)` が従う。 -/
theorem leadingDistance_pinching_implies_predicate
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2)
    (hHyp : ∀ eta : ℚ, 0 < eta →
      ∃ (L : ℕ) (inst : NeZero L) (hL : 2 ≤ L),
        realAlgebraicLt data.toRealClosedSubfieldData
          (@leadingDistance L inst hL data.toRealClosedSubfieldData s hs)
          ⟨(eta : Qbar),
            rational_mem_realClosedCarrier data.toRealClosedSubfieldData eta⟩)
    (eps : PositiveRational) :
    zeroPinchingPredicate data.toRealClosedSubfieldData eps := by
  classical
  let base := data.toRealClosedSubfieldData
  -- η := ε²/4 ∈ Q_{>0}（Q の四則と順序）。
  set etaQ : ℚ := eps.1 * eps.1 / 4 with hetaQ_def
  have hetaQ : 0 < etaQ := div_pos (mul_pos eps.2 eps.2) (by norm_num)
  obtain ⟨L, instL, hL, hd1⟩ := hHyp etaQ hetaQ
  haveI := instL
  -- 上界の同値の第一→第二: ξ ∈ F_L を取る。
  obtain ⟨xi, hxi, hdsq⟩ :=
    (leadingDistance_lt_iff L hL base s hs
      ⟨(etaQ : Qbar), rational_mem_realClosedCarrier base etaQ⟩).mp hd1
  -- 有理近似: q ∈ Q_{>0} を取る。
  obtain ⟨q, hq, happrox⟩ :=
    criticalPoint_exists_positiveRational_squareDiff_lt data hs etaQ hetaQ
  -- 一意表示の係数と臨界点・有理点・η の R への埋め込み。
  let ab := realClosedComponents base xi
  -- x_c ∈ R（`claim_critical_point_mem_real_closed`）の元。
  let xc : base.carrier := Classical.choose (criticalPoint_mem_realClosed base s hs)
  let qR : base.carrier := ⟨(q : Qbar), rational_mem_realClosedCarrier base q⟩
  let etaR : base.carrier := ⟨(etaQ : Qbar), rational_mem_realClosedCarrier base etaQ⟩
  -- 証人 c₁: η − dsq_c(ξ) の零元でない平方表示（狭義順序の定義そのもの）。
  have hCrit : ∃ c1 : base.carrier, c1 ≠ 0 ∧
      etaR - ((ab.1 - xc) * (ab.1 - xc) + ab.2 * ab.2) = c1 * c1 := by
    simpa [distanceSquaredToCriticalPoint, criticalPointRealClosed, realAlgebraicLt, ab, xc, etaR]
      using hdsq
  -- 証人 c₂: η − (x_c − q)² の零元でない平方表示。
  have hApprox : ∃ c2 : base.carrier, c2 ≠ 0 ∧
      etaR - (xc - qR) * (xc - qR) = c2 * c2 := by
    simpa [criticalPointRealClosed, realAlgebraicLt, xc, qR, etaR] using happrox
  -- 証人 g: 和の平方の評価の差の平方表示（等号の枝は g := 0）。
  have hSquare : ∃ g : base.carrier,
      ((1 + 1) * ((ab.1 - xc) * (ab.1 - xc)) + (1 + 1) * ((xc - qR) * (xc - qR)))
        - ((ab.1 - xc) + (xc - qR)) * ((ab.1 - xc) + (xc - qR)) = g * g := by
    rcases squareOfSum_le_twiceSumOfSquares base (ab.1 - xc) (xc - qR) with hlt | heq
    · obtain ⟨g, _, hgeq⟩ := hlt
      exact ⟨g, by linear_combination hgeq⟩
    · exact ⟨0, by linear_combination -heq⟩
  -- t·t = 2（本文: claim_two_is_square_in_real_closed）。
  obtain ⟨t, ht0, ht⟩ := two_is_square_in_realClosed base
  obtain ⟨c1, hc10, hc1⟩ := hCrit
  obtain ⟨c2, hc20, hc2⟩ := hApprox
  obtain ⟨g, hg⟩ := hSquare
  have htc1 : t * c1 ≠ 0 := mul_ne_zero ht0 hc10
  obtain ⟨z1, hz1⟩ := realClosed_sum_of_two_squares_is_square base (t * c1) (t * c2)
  have hz10 : z1 ≠ 0 := by
    intro h0
    have hsum : (t * c1) * (t * c1) + (t * c2) * (t * c2) = 0 := by
      rw [hz1, h0]; ring
    have hzero := realClosed_sq_add_sq_eq_zero base (t * c1) (t * c2) (by
      exact_mod_cast hsum)
    exact htc1 hzero.1
  obtain ⟨z2, hz2⟩ := realClosed_sum_of_two_squares_is_square base z1 g
  have hz20 : z2 ≠ 0 := by
    intro h0
    have hsum : z1 * z1 + g * g = 0 := by rw [hz2, h0]; ring
    have hzero := realClosed_sq_add_sq_eq_zero base z1 g (by exact_mod_cast hsum)
    exact hz10 hzero.1
  obtain ⟨z3, hz3⟩ := realClosed_sum_of_two_squares_is_square base z2 ab.2
  have hz30 : z3 ≠ 0 := by
    intro h0
    have hsum : z2 * z2 + ab.2 * ab.2 = 0 := by rw [hz3, h0]; ring
    have hzero := realClosed_sq_add_sq_eq_zero base z2 ab.2 (by exact_mod_cast hsum)
    exact hz20 hzero.1
  have hz : ((1 + 1) * (1 + 1)) * etaR
      - ((ab.1 - qR) * (ab.1 - qR) + ab.2 * ab.2) = z3 * z3 := by
    calc
      ((1 + 1) * (1 + 1)) * etaR
          - ((ab.1 - qR) * (ab.1 - qR) + ab.2 * ab.2)
          = ((1 + 1) * (1 + 1)) * etaR
              - ((((ab.1 - xc) + (xc - qR)) * ((ab.1 - xc) + (xc - qR)))
                + ab.2 * ab.2) := by ring
      _ = (1 + 1) * (etaR - ((ab.1 - xc) * (ab.1 - xc) + ab.2 * ab.2))
            + (1 + 1) * (etaR - (xc - qR) * (xc - qR))
            + (((1 + 1) * ((ab.1 - xc) * (ab.1 - xc))
                + (1 + 1) * ((xc - qR) * (xc - qR)))
              - ((ab.1 - xc) + (xc - qR)) * ((ab.1 - xc) + (xc - qR)))
            + ab.2 * ab.2 := by ring
      _ = (1 + 1) * (c1 * c1) + (1 + 1) * (c2 * c2)
            + g * g + ab.2 * ab.2 := by rw [hc1, hc2, hg]
      _ = (t * c1) * (t * c1) + (t * c2) * (t * c2)
            + g * g + ab.2 * ab.2 := by
              linear_combination (-(c1 * c1) - c2 * c2) * ht
      _ = z1 * z1 + g * g + ab.2 * ab.2 := by rw [hz1]
      _ = z2 * z2 + ab.2 * ab.2 := by rw [hz2]
      _ = z3 * z3 := hz3
  -- Pinch の証人: L（1 ≤ L は 2 ≤ L から）、ξ ∈ F_L、q ∈ Q_{>0}。
  refine ⟨⟨L, by omega⟩, xi, ⟨q, hq⟩, hxi, ?_⟩
  refine ⟨z3, hz30, ?_⟩
  -- ε² = 4·η（Q の四則）を R の元の等式として書き戻す。
  have hepsEta : (⟨((eps.1 * eps.1 : ℚ) : Qbar),
      rational_mem_realClosedCarrier base (eps.1 * eps.1)⟩ : base.carrier)
      = ((1 + 1) * (1 + 1)) * etaR := by
    apply Subtype.ext
    have hQ : (eps.1 * eps.1 : ℚ) = (1 + 1) * (1 + 1) * etaQ := by
      rw [hetaQ_def]; ring
    calc ((eps.1 * eps.1 : ℚ) : Qbar)
        = (((1 + 1) * (1 + 1) * etaQ : ℚ) : Qbar) :=
          congrArg (fun r : ℚ => (r : Qbar)) hQ
      _ = ((1 + 1) * (1 + 1)) * ((etaQ : ℚ) : Qbar) := by push_cast; ring
  have hdsqEq : distanceSquaredToRational base xi q
      = (ab.1 - qR) * (ab.1 - qR) + ab.2 * ab.2 := rfl
  show (⟨((eps.1 * eps.1 : ℚ) : Qbar),
      rational_mem_realClosedCarrier base (eps.1 * eps.1)⟩ : base.carrier)
      - distanceSquaredToRational base xi q = z3 * z3
  rw [hepsEta, hdsqEq]
  exact hz

end Ising2DLambda.CriticalExponent
