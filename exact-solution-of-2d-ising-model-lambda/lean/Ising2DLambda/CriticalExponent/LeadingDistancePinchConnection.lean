/-
人手証明 `claim_leading_distance_pinching_implies_predicate` の具体版。

  人手証明                                                      このファイル
  η := ε²/4 ∈ Q_{>0}（Q の四則と順序）                          `etaQ`・`hetaQ`
  仮定を η に当てて L（2 ≤ L）を取る                            `hHyp etaQ hetaQ`
  上界の同値の第一→第二で ξ ∈ F_L を取る                        `leadingDistance_lt_iff` の mp
  有理近似で q ∈ Q_{>0} を取る                                  `criticalPoint_exists_positiveRational_squareDiff_lt`
  一意表示 ξ = α + β·ω                                          `realClosedComponents`
  証人 c₁・c₂・g の用意                                          `hCrit`・`hApprox`・`hSquare`
  t·t = 2 と式変形の鎖（z₁, z₂, z₃ の合成）                     `pinch_bound_necSuf` へ委譲
  ε² = 4·η の書き戻しと Pinch の証人の提示                       本定理の結び
-/
import Ising2DLambda.CriticalExponent.LeadingDistanceLtIff
import Ising2DLambda.CriticalExponent.CriticalPointRationalApproximation
import Ising2DLambda.CriticalExponent.SquareOfSumLeTwiceSquares
import Ising2DLambda.FisherZero.ZeroPinchingPredicate
import Ising2DLambda.NecSuf.CriticalExponent.LeadingDistancePinchConnection

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
  let xc := criticalPointRealClosed base s hs
  let qR : base.carrier := ⟨(q : Qbar), rational_mem_realClosedCarrier base q⟩
  let etaR : base.carrier := ⟨(etaQ : Qbar), rational_mem_realClosedCarrier base etaQ⟩
  -- 証人 c₁: η − dsq_c(ξ) の零元でない平方表示（狭義順序の定義そのもの）。
  have hCrit : ∃ c1 : base.carrier, c1 ≠ 0 ∧
      etaR - ((ab.1 - xc) * (ab.1 - xc) + ab.2 * ab.2) = c1 * c1 := by
    simpa [distanceSquaredToCriticalPoint, realAlgebraicLt, ab, xc, etaR] using hdsq
  -- 証人 c₂: η − (x_c − q)² の零元でない平方表示。
  have hApprox : ∃ c2 : base.carrier, c2 ≠ 0 ∧
      etaR - (xc - qR) * (xc - qR) = c2 * c2 := by
    simpa [realAlgebraicLt, xc, qR, etaR] using happrox
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
  -- 式変形の鎖を必要十分版に委ねる。
  obtain ⟨z, hz0, hz⟩ :=
    Ising2DLambda.NecSuf.CriticalExponent.pinch_bound_necSuf
      (realClosed_sum_of_two_squares_is_square base)
      (fun a b hzero => by
        apply realClosed_sq_add_sq_eq_zero base a b
        exact_mod_cast hzero)
      t ht ab.1 ab.2 xc qR etaR hCrit hApprox hSquare
  -- Pinch の証人: L（1 ≤ L は 2 ≤ L から）、ξ ∈ F_L、q ∈ Q_{>0}。
  refine ⟨⟨L, by omega⟩, xi, ⟨q, hq⟩, hxi, ?_⟩
  refine ⟨z, hz0, ?_⟩
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
      - distanceSquaredToRational base xi q = z * z
  rw [hepsEta, hdsqEq]
  exact hz

end Ising2DLambda.CriticalExponent
