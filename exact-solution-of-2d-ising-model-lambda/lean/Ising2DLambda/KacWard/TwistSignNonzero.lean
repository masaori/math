/-
本文「短い対に現れるねじれ符号は零でない」に対応する。
ねじれ偶奇の二つの場合、整数から代数的数への埋込み、定数多項式への埋込みを順に確認する。
住処は ℕ、ℤ、Qbar、Qbar[x] であり、ℝ と ℂ は現れない。
-/
import Ising2DLambda.KacWard.TwistSignParity
import Ising2DLambda.NecSuf.KacWard.TwistSignNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The seam parity makes the integer twist sign either one or minus one. -/
theorem twistSign_eq_one_or_neg_one {L : ℕ} (s : SpinStructure)
    (e : OrientedEdge L) : twistSign s e = 1 ∨ twistSign s e = -1 := by
  rw [twistSign_eq_neg_one_pow_twistParity]
  rcases twistParity_eq_zero_or_one s e with h | h
  · left
    rw [h, pow_zero]
  · right
    rw [h, pow_one]

/-- The integer sign remains nonzero after embedding in the algebraic numbers. -/
theorem twistSign_qbar_ne_zero {L : ℕ} (s : SpinStructure)
    (e : OrientedEdge L) : ((twistSign s e : ℤ) : Qbar) ≠ 0 := by
  rcases twistSign_eq_one_or_neg_one s e with h | h
  · rw [h]
    norm_num
  · rw [h]
    norm_num

/-- The constant polynomial of the twist sign is nonzero. -/
theorem twistSign_constant_nonzero {L : ℕ} (s : SpinStructure)
    (e : OrientedEdge L) :
    Polynomial.C (((twistSign s e : ℤ) : Qbar)) ≠ 0 := by
  intro h
  apply twistSign_qbar_ne_zero s e
  exact Polynomial.C_injective (by simpa using h)

/-- The concrete seam parity specializes the two-value argument. -/
theorem twistSign_qbar_ne_zero_from_necSuf {L : ℕ} (s : SpinStructure)
    (e : OrientedEdge L) : ((twistSign s e : ℤ) : Qbar) ≠ 0 := by
  rw [twistSign_eq_neg_one_pow_twistParity]
  push_cast
  exact Ising2DLambda.NecSuf.KacWard.two_value_power_ne_zero
    ((-1 : Qbar)) (by norm_num) (twistParity s e)
    (twistParity_eq_zero_or_one s e)

end Ising2DLambda.KacWard
