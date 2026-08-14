/-
人手証明の「詰め寄りの述語の定式化」の具体版。

正の有理数を部分型で表し、格子サイズ・Fisher 零点・正の有理点の存在量化だけで
詰め寄りを定義する。距離の二乗の非零性は本文と同じ背理法で示す。

住処: Q と Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.DistanceSquaredToRational
import Ising2DLambda.FisherZero.PositiveRationalNotFisherZero

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 正の有理数。 -/
abbrev PositiveRational := {q : ℚ // 0 < q}

/-- 正の格子サイズ。 -/
abbrev PositiveLatticeSize := {L : ℕ // 0 < L}

/-- 正の格子サイズにおける Fisher 零点集合。 -/
def fisherZeroSetAtPositiveSize (L : PositiveLatticeSize) : Set Qbar :=
  letI : NeZero L.1 := ⟨Nat.ne_of_gt L.2⟩
  FisherZeroSet L.1

/-- `def_zero_pinching_predicate` の具体版。 -/
noncomputable def zeroPinchingPredicate
    (data : RealClosedSubfieldData) (eps : PositiveRational) : Prop :=
  ∃ (L : PositiveLatticeSize) (xi : Qbar) (q : PositiveRational),
    xi ∈ fisherZeroSetAtPositiveSize L ∧
      realAlgebraicLt data
        (distanceSquaredToRational data xi q.1)
        ⟨((eps.1 * eps.1 : ℚ) : Qbar), rational_mem_realClosedCarrier data (eps.1 * eps.1)⟩

/-- `claim_distance_positive_on_fisher_zeros` の具体版。 -/
theorem distanceSquaredToPositiveRational_ne_zero
    (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    {xi : Qbar} (hxi : xi ∈ FisherZeroSet L) (q : PositiveRational) :
    distanceSquaredToRational data xi q.1 ≠ 0 := by
  intro hzero
  have hxiq : xi = (q.1 : Qbar) :=
    (distanceSquaredToRational_eq_zero_iff data xi q.1).mp hzero
  have hnot : (q.1 : Qbar) ∉ FisherZeroSet L :=
    positiveRational_not_mem_fisherZero L q.2
  apply hnot
  rw [← hxiq]
  exact hxi

/-- `def_phase_transition_countable_statement` の具体版。 -/
noncomputable def phaseTransitionCountableStatement
    (data : RealClosedSubfieldData) : Prop :=
  ∀ eps : PositiveRational, zeroPinchingPredicate data eps

end Ising2DLambda.FisherZero
