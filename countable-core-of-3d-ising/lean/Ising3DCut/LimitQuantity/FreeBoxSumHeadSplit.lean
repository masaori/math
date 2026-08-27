/-
「有限箱の量が末尾で一定となる正の有理点は 1 に限られる」の接続のうち、
既約分母が `2` の場合へ渡す第一歩。

分母を払った自由境界箱の有限和 `∑_{m≤E} Ω(m) a^m b^{E-m}` を、
破れ辺数が `0` の項とそれ以外へ分け、それ以外がすべて既約分子 `a` の倍数で
あることを示す。分母 `2` の場合の接続定理が要求する
`b^E * c^n = b^E * Ω(0) + a * S` の形の右辺は、この分解そのものである。

一つの有限箱に固定した有限和だけの主張であり、極限も無限和も現れない。
-/
import Ising3DCut.LimitQuantity.EventuallyConstantOnlyAtOneBundleFreeBox
import Ising3DCut.LimitQuantity.DenominatorTwoNumeratorEqualsOne

namespace Ising3DCut.LimitQuantity

/-- 有限和の破れ辺数 `0` の項を取り出すと、残りは既約分子 `a` の倍数になる。
残りの各項は `a ^ m`（`m ≥ 1`）を因子に持つからである。 -/
theorem brokenCountSum_head_split (Ω : ℕ → ℕ) (a b E : ℕ) :
    ∃ S : ℕ, brokenCountSum Ω a b E = Ω 0 * b ^ E + a * S := by
  refine ⟨∑ m ∈ Finset.range E, Ω (m + 1) * a ^ m * b ^ (E - (m + 1)), ?_⟩
  rw [brokenCountSum, Finset.sum_range_succ']
  simp only [pow_zero, mul_one, Nat.sub_zero]
  rw [Finset.mul_sum]
  rw [add_comm]
  congr 1
  refine Finset.sum_congr rfl ?_
  intro m _
  ring

/-- 既約分母が `2` の場合の接続。閾値の自由境界箱の分母を払った等式を、
上の分解で `b ^ E * c ^ n = b ^ E * Ω(0) + a * S` の形に整え、既に閉じた
分母 `2` の判定へ渡すと、有理点の既約分子は `1` になる。
一つの有限箱に固定した整数の等式・整除だけであり、極限も無限和も現れない。 -/
theorem denominator_two_numerator_eq_one_of_rational_value_form
    {q c : ℚ} {L₀ : ℕ} (hq : 0 < q) (hL₀ : 0 < L₀)
    (hden : q.den = 2) (hc : 0 < c) (hcden : c.den = 1)
    (hform : ∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3))
    (hdvd : (q.num.natAbs : ℤ) ∣ 2 * ((c.num.natAbs : ℤ) ^ (L₀ ^ 3) - 1)) :
    q.num.natAbs = 1 := by
  obtain ⟨S, hS⟩ := brokenCountSum_head_split (NullModel.multiplicity L₀)
    q.num.natAbs q.den (Fintype.card (NullModel.Edge L₀))
  have hInt := integer_equation_of_rational_value_form hq hc (le_refl L₀) hform
  rw [hcden] at hInt
  simp only [one_pow, mul_one] at hInt
  rw [hS] at hInt
  have hscaled : (2 : ℤ) ^ Fintype.card (NullModel.Edge L₀) *
        (c.num.natAbs : ℤ) ^ (L₀ ^ 3) =
      (2 : ℤ) ^ Fintype.card (NullModel.Edge L₀) *
        (NullModel.multiplicity L₀ 0 : ℤ) + (q.num.natAbs : ℤ) * S := by
    rw [hden] at hInt
    have hNat : 2 ^ Fintype.card (NullModel.Edge L₀) * c.num.natAbs ^ (L₀ ^ 3) =
        2 ^ Fintype.card (NullModel.Edge L₀) * NullModel.multiplicity L₀ 0
          + q.num.natAbs * S := by
      ring_nf
      ring_nf at hInt
      omega
    exact_mod_cast hNat
  have hcoprime : Nat.Coprime q.num.natAbs 2 := by
    have := q.reduced
    rw [hden] at this
    exact this
  exact denominator_two_numerator_eq_one_from_finite_box (L := L₀) (S := S)
    hL₀ hcoprime hscaled hdvd

end Ising3DCut.LimitQuantity
