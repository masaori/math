/-
人手証明 `claim_real_algebraic_archimedean`（実閉部分体の順序は Archimedes 性を持つ）の具体版。

  人手証明                                                         このファイル
  −B <_R a <_R B となる B ∈ Q_{>0}（有理上下界）                     `realAlgebraic_rational_bounds`
  B = h/k、h, k ∈ N_{>0}、N := h + 1                                 本定理の冒頭
  B = h/k ≤ h < N（有理数の順序）                                     `rational_lt_succ_numerator`
  0 <_R N − B（正の有理数の正値性を N − B に）                        `realAlgebraic_rat_sub_pos`
  B <_R N（狭義順序の定義）                                           `realAlgebraic_rat_lt_of_sub_pos`
  −N <_R −B（狭義順序の定義と (−B) − (−N) = N − B）                   `realAlgebraic_neg_rat_lt_of_sub_pos`
  −N <_R a、a <_R N（推移律）                                         `realAlgebraic_archimedean`

必要十分版の定理・定義は使わない。住処: Q と Qbar（実閉部分体 R ⊂ Qbar）。実数体・複素数体は現れない。
-/
import Ising2DLambda.CriticalExponent.RealAlgebraicRationalBounds

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 有理数の順序: `B = h/k`（`h, k ∈ N_{>0}`）なら `B ≤ h < h + 1`。 -/
theorem rational_lt_succ_numerator {B : ℚ} (hB : 0 < B) :
    0 < B.num.natAbs ∧ B < ((B.num.natAbs + 1 : ℕ) : ℚ) := by
  have hnum : 0 < B.num := Rat.num_pos.mpr hB
  have hh : ((B.num.natAbs : ℕ) : ℚ) = (B.num : ℚ) := by
    rw [Nat.cast_natAbs, Int.cast_abs, abs_of_pos (by exact_mod_cast hnum)]
  have hk : (1 : ℚ) ≤ (B.den : ℚ) := by exact_mod_cast B.den_pos
  refine ⟨Int.natAbs_pos.mpr hnum.ne', ?_⟩
  calc B = (B.num : ℚ) / (B.den : ℚ) := (Rat.num_div_den B).symm
    _ ≤ (B.num : ℚ) := div_le_self (by exact_mod_cast hnum.le) hk
    _ = ((B.num.natAbs : ℕ) : ℚ) := hh.symm
    _ < ((B.num.natAbs + 1 : ℕ) : ℚ) := by push_cast; linarith

/-- `claim_positive_rational_positive_in_real_closed` を差 `N − B ∈ Q_{>0}` に当てる。 -/
theorem realAlgebraic_rat_sub_pos (data : RealClosedSubfieldData) {B N : ℚ} (hBN : B < N) :
    realAlgebraicLt data 0 (realClosedRat data N - realClosedRat data B) := by
  have h : realClosedRat data N - realClosedRat data B = ((N - B : ℚ) : data.carrier) := by
    rw [realClosedRat_eq_cast, realClosedRat_eq_cast]
    push_cast
    rfl
  rw [h]
  exact realAlgebraic_rat_pos data (sub_pos.mpr hBN)

/-- 狭義順序の定義: `0 <_R N − B` から `B <_R N`。 -/
theorem realAlgebraic_rat_lt_of_sub_pos (data : RealClosedSubfieldData) {B N : ℚ}
    (h : realAlgebraicLt data 0 (realClosedRat data N - realClosedRat data B)) :
    realAlgebraicLt data (realClosedRat data B) (realClosedRat data N) :=
  (realAlgebraicLt_iff_pos_sub data _ _).mpr h

/-- 狭義順序の定義と `(−B) − (−N) = N − B`: `0 <_R N − B` から `−N <_R −B`。 -/
theorem realAlgebraic_neg_rat_lt_of_sub_pos (data : RealClosedSubfieldData) {B N : ℚ}
    (h : realAlgebraicLt data 0 (realClosedRat data N - realClosedRat data B)) :
    realAlgebraicLt data (realClosedRat data (-N)) (realClosedRat data (-B)) := by
  rw [realAlgebraicLt_iff_pos_sub]
  have hdiff : realClosedRat data (-B) - realClosedRat data (-N)
      = realClosedRat data N - realClosedRat data B := by
    simp only [realClosedRat_eq_cast]
    push_cast
    ring
  rw [hdiff]
  exact h

/-- `claim_real_algebraic_archimedean` の具体版: `−N <_R a <_R N` となる `N ∈ N_{>0}` がある。 -/
theorem realAlgebraic_archimedean (data : RealClosedSubfieldData) (a : data.carrier) :
    ∃ N : ℕ, 0 < N ∧
      realAlgebraicLt data (realClosedRat data (-(N : ℚ))) a ∧
      realAlgebraicLt data a (realClosedRat data (N : ℚ)) := by
  -- 有理上下界 −B <_R a <_R B。
  obtain ⟨B, hB, hlower, hupper⟩ := realAlgebraic_rational_bounds data a
  -- B = h/k、N := h + 1、B < N。
  obtain ⟨_, hBN⟩ := rational_lt_succ_numerator hB
  set N : ℕ := B.num.natAbs + 1 with hNdef
  -- 0 <_R N − B。
  have hpos := realAlgebraic_rat_sub_pos data hBN
  -- B <_R N と −N <_R −B。
  have hBltN := realAlgebraic_rat_lt_of_sub_pos data hpos
  have hnegN := realAlgebraic_neg_rat_lt_of_sub_pos data hpos
  refine ⟨N, Nat.succ_pos _, ?_, ?_⟩
  · -- −N <_R −B <_R a（推移律）。
    exact realAlgebraicLt_trans data _ _ _ hnegN hlower
  · -- a <_R B <_R N（推移律）。
    exact realAlgebraicLt_trans data _ _ _ hupper hBltN

end Ising2DLambda.CriticalExponent
