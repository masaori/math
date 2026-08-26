/-
「有限箱の量が末尾で一定となる正の有理点は 1 に限られる」の Lean 具体版へ
向けた接続の第一段。冪等式から得た正の有理数の底について、既約分母が 1 と
既に示されていれば、自然数の底を持つ `EventualPowerFormAt` へ移す。

扱うのは有限箱の有理評価と自然数冪だけであり、極限は使わない。
-/
import Ising3DCut.LimitQuantity.EventualPowerFormOnlyAtOne
import Ising3DCut.LimitQuantity.RationalRootFromDivisiblePrimeExponents
import Ising3DCut.LimitQuantity.RationalPowerPointNumeratorDividesBasePowerDifference

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 正の有理数の底の既約分母が 1 なら、同じ末尾表示を正の自然数の底で書ける。 -/
theorem eventualPowerFormAt_of_rationalPowerForm_den_one
    {q c : ℚ} {L₀ : ℕ}
    (hc : 0 < c) (hden : c.den = 1) (hL₀ : 0 < L₀)
    (hpower : ∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) :
    EventualPowerFormAt q := by
  let n : ℕ := c.num.natAbs
  have hn : 0 < n := by
    exact Int.natAbs_pos.mpr (Rat.num_ne_zero.mpr hc.ne')
  have hcn : c = (n : ℚ) := by
    calc
      c = (c.num : ℚ) := eq_num_of_den_eq_one c hden
      _ = (c.num.natAbs : ℚ) := by
        rw [Nat.cast_natAbs, abs_of_pos (Rat.num_pos.mpr hc)]
  refine ⟨L₀, n, hL₀, hn, ?_⟩
  intro L hL
  have h := hpower L hL
  rw [hcn] at h
  simpa [rationalValueSeq, partitionPolynomial, evalAtRational, polyOfMultiplicity, card_site,
    map_sum, Polynomial.eval_finsetSum, Polynomial.eval_mul, Polynomial.eval_C,
    Polynomial.eval_pow, Polynomial.eval_X, Polynomial.eval₂_monomial] using h

end Ising3DCut.LimitQuantity
