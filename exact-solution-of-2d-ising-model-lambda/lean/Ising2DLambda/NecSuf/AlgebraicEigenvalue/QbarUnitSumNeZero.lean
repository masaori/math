/-
「単位元を正の個数だけ足した有限和は零でない」の必要十分版。

必要なのは、有限和が自然数の像に等しいことと、正の自然数の像が零でないことだけである。
加法も積も単位元も零元としての法則も、体・部分体・標数 0 という型の構造も使わない。
住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 自然数の像との等式と、その像の非零性から有限和の非零性を得る必要十分な手順。 -/
theorem unit_sum_ne_zero_necSuf {M : Type*}
    (zero : M) (sum cast : ℕ → M)
    (hsum_eq_cast : ∀ n : ℕ, sum n = cast n)
    (hcast_ne_zero : ∀ n : ℕ, 1 ≤ n → cast n ≠ zero) :
    ∀ n : ℕ, 1 ≤ n → sum n ≠ zero := by
  intro n hn hsum_zero
  exact hcast_ne_zero n hn ((hsum_eq_cast n).symm.trans hsum_zero)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
