/-
人手証明 `claim_positive_rational_positive_in_real_closed` の具体版。

  人手証明                                                    このファイル
  帰納法: 1 = 1·1、1 ≠ 0                                       `natSucc_eq_square` の zero 枝
  帰納段: n+1 = c·c + 1·1 = e·e                                 `realClosed_sum_of_two_squares_is_square`
  e = 0 なら二平方和の零性から 1 = 0                            `realClosed_sq_add_sq_eq_zero`
  q = a/b、a = c·c、b = d·d、w := c·d⁻¹                          本定理の証人構成
  q − 0 = w·w、w ≠ 0 を狭義順序の定義へ当てる                    結論

住処: N, Q, Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.RealAlgebraicOrder
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresIsSquare
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero
import Mathlib.Tactic.FieldSimp

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 帰納法: 1 以上の自然数は零元でない元の平方である（`n + 1` の形で受ける）。 -/
theorem natSucc_eq_square (data : RealClosedSubfieldData) :
    ∀ n : ℕ, ∃ c : data.carrier, c ≠ 0 ∧ ((n + 1 : ℕ) : data.carrier) = c * c := by
  intro n
  induction n with
  | zero => exact ⟨1, one_ne_zero, by norm_num⟩
  | succ n ih =>
      obtain ⟨c, hc0, hc⟩ := ih
      -- 帰納段: n+1 = c·c から n+2 = c·c + 1·1 = e·e。
      obtain ⟨e, he⟩ := realClosed_sum_of_two_squares_is_square data c 1
      have he0 : e ≠ 0 := by
        intro heZero
        have hsumQ : (c : Qbar) * (c : Qbar) + (1 : Qbar) * (1 : Qbar) = 0 := by
          have hcast := congrArg (fun z : data.carrier => (z : Qbar)) he
          rw [heZero] at hcast
          push_cast at hcast
          simpa using hcast
        exact one_ne_zero (realClosed_sq_add_sq_eq_zero data c 1 hsumQ).2
      refine ⟨e, he0, ?_⟩
      rw [← he, ← hc]
      push_cast
      ring

/-- 正の有理数は実閉部分体の狭義順序で零元より大きい。 -/
theorem positiveRational_realAlgebraic_positive
    (data : RealClosedSubfieldData) (q : ℚ) (hq : 0 < q) :
    realAlgebraicLt data 0
      ⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩ := by
  -- 準備: q = a / b、1 ≤ a、1 ≤ b（正の有理数は正の整数の比）。
  have hnumPos : 0 < q.num := Rat.num_pos.mpr hq
  have haInt : ((q.num.toNat : ℕ) : ℤ) = q.num := Int.toNat_of_nonneg hnumPos.le
  have haPos : 1 ≤ q.num.toNat := by omega
  have hbPos : 1 ≤ q.den := q.den_pos
  -- 帰納法を分子と分母に当てる。
  obtain ⟨c, hc0, hc⟩ := natSucc_eq_square data (q.num.toNat - 1)
  obtain ⟨d, hd0, hd⟩ := natSucc_eq_square data (q.den - 1)
  have hcEq : ((q.num.toNat : ℕ) : data.carrier) = c * c := by
    have hsucc : q.num.toNat - 1 + 1 = q.num.toNat := by omega
    rwa [hsucc] at hc
  have hdEq : ((q.den : ℕ) : data.carrier) = d * d := by
    have hsucc : q.den - 1 + 1 = q.den := by omega
    rwa [hsucc] at hd
  -- 証人 w := c · d⁻¹。体は零因子を持たない。
  refine ⟨c * d⁻¹, mul_ne_zero hc0 (inv_ne_zero hd0), ?_⟩
  apply Subtype.ext
  push_cast
  have hcQ : ((q.num.toNat : ℕ) : Qbar) = (c : Qbar) * (c : Qbar) := by
    have hcast := congrArg (fun z : data.carrier => (z : Qbar)) hcEq
    push_cast at hcast
    exact hcast
  have hdQ : ((q.den : ℕ) : Qbar) = (d : Qbar) * (d : Qbar) := by
    have hcast := congrArg (fun z : data.carrier => (z : Qbar)) hdEq
    push_cast at hcast
    exact hcast
  have hdQ0 : (d : Qbar) ≠ 0 := by
    intro hzero
    exact hd0 (Subtype.ext hzero)
  -- q = 分子/分母 の表示で置き換え、体の四則で閉じる。
  have hqQ : (q : Qbar) = ((q.num.toNat : ℕ) : Qbar) / ((q.den : ℕ) : Qbar) := by
    rw [Rat.cast_def]
    congr 1
    exact_mod_cast haInt.symm
  rw [hqQ, hcQ, hdQ]
  field_simp
  ring

end Ising2DLambda.CriticalExponent
