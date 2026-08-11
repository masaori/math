/-
「零でない代数的数を正の個数だけ足した有限和は零でない」の必要十分版。

必要なのは、和の積への分解・単位元の和の非零性・零元でない左因子の消去の 3 つだけである。
和や積の法則そのもの（結合則・可換性・分配則）も、体・部分体・代数閉性も使わない。
有限和も積も、性質を仮定した記号としてしか現れない。
住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 和の積への分解と単位元の和の非零性と左因子の消去から、
同じ元の有限和の非零性を得る必要十分な手順。 -/
theorem repeated_sum_ne_zero_necSuf {M : Type*}
    (zero : M) (mul : M → M → M)
    (repeatedSum : M → ℕ → M) (unitSum : ℕ → M)
    (hfactor : ∀ (a : M) (n : ℕ), repeatedSum a n = mul (unitSum n) a)
    (hunit_ne_zero : ∀ n : ℕ, 1 ≤ n → unitSum n ≠ zero)
    (hcancel : ∀ {u a : M}, u ≠ zero → mul u a = zero → a = zero) :
    ∀ {a : M}, a ≠ zero → ∀ n : ℕ, 1 ≤ n → repeatedSum a n ≠ zero := by
  intro a ha n hn hsum_zero
  have hprod_zero : mul (unitSum n) a = zero :=
    (hfactor a n).symm.trans hsum_zero
  exact ha (hcancel (hunit_ne_zero n hn) hprod_zero)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
