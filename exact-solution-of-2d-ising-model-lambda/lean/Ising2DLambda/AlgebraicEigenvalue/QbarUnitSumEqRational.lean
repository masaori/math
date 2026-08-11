/-
「単位元の有限和は、自然数の与える有理数に等しい」の具体版。
人手証明と 1 対 1 に対応させる。

  人手証明                                        このファイル
  空の有限和は 0                                 `Finset.sum_empty`
  自然数 0 は有理数 0 であり ℚ̄ の零元に一致     `Nat.cast_zero` と `map_zero`
  n+1 個の和から最後の項を分ける                 `Finset.sum_range_succ`
  帰納法の仮定                                    `ih`
  部分体の加法の一致と自然数の和の一致           `Nat.cast_add_one` と `map_add`・`map_one`

人手証明の「部分集合の鎖 ℕ ⊂ ℚ ⊂ ℚ̄」を、Lean では
`Nat.cast : ℕ → ℚ` と `algebraMap ℚ Qbar` の合成として書く
（mathlib の体は部分集合ではなく埋め込みで扱うため）。
有限和とキャストをまとめた既製定理（`Nat.cast_sum` 等）へは委ねない。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 単位元 1 の n 個の有限和は、自然数 n の与える有理数を ℚ̄ の元と見たものに等しい
（`claim_qbar_unit_sum_eq_rational`）。 -/
theorem qbarUnitSumEqRational : ∀ n : ℕ,
    (∑ _i ∈ Finset.range n, (1 : Qbar)) = algebraMap ℚ Qbar (n : ℚ) := by
  intro n
  induction n with
  | zero =>
      calc
        (∑ _i ∈ Finset.range 0, (1 : Qbar)) = 0 := by
              rw [Finset.range_zero, Finset.sum_empty]
        _ = algebraMap ℚ Qbar ((0 : ℕ) : ℚ) := by
              rw [Nat.cast_zero, map_zero]
  | succ n ih =>
      calc
        (∑ _i ∈ Finset.range (n + 1), (1 : Qbar))
            = (∑ _i ∈ Finset.range n, (1 : Qbar)) + 1 := by
              rw [Finset.sum_range_succ]
        _ = algebraMap ℚ Qbar (n : ℚ) + 1 := by rw [ih]
        _ = algebraMap ℚ Qbar (((n : ℕ) + 1 : ℕ) : ℚ) := by
              rw [Nat.cast_add_one, map_add, map_one]

end Ising2DLambda.AlgebraicEigenvalue
