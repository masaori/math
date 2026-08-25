/-
人手証明「点数乗表示が成り立つ正の有理点の分子は隣接する二つの箱の底の点数乗の差を割る」
（ラベル `claim_rational_power_point_numerator_divides_base_power_difference`）の Lean 具体版。

人手証明と同じ三段で進む。
第一段: 底 `c` の既約分数表示の分母は 1 である（先行する主張
        `claim_rational_power_point_denominator_divides_two` の結論を仮定として受け取る）。
        よって `c` は正の整数 `u` に等しい。
第二段: 各箱について法 `a` の合同式 `u ^ (#V_L) ≡ Ω_L(0) * v ^ (#V_L)` へ第一段の `v = 1` と
        破れ数ゼロの配位数 `Ω_L(0) = 2` を入れて `u ^ (#V_L) ≡ 2` を得る。
        隣接する箱 `L + 1` にも同じ四行を適用して `u ^ (#V_{L+1}) ≡ 2` を得る。
第三段: 二つの合同式を突き合わせて `u ^ (#V_{L+1}) ≡ u ^ (#V_L)` とし、
        法 `a` の合同式の定義により `a ∣ u ^ (#V_{L+1}) - u ^ (#V_L)` を出す。

先行する主張は本文でも引くだけなので、ここでも結論を仮定として受け取る。
計算は整数の合同式の定義（差の整除）だけで行い、mathlib の一般論へ委ねない。
-/
import Ising3DCut.LimitQuantity.RationalPowerPointDenominatorDividesTwo

namespace Ising3DCut.LimitQuantity

/-- 人手証明の第一段。既約分母が 1 である正の有理数は、その分子である整数に等しい。 -/
theorem eq_num_of_den_eq_one (c : ℚ) (hden : c.den = 1) : c = (c.num : ℚ) := by
  conv_lhs => rw [← Rat.num_div_den c]
  rw [hden]
  simp

/-- 人手証明の第二段。既約分母 `v` が 1 であり破れ数ゼロの配位数 `Ω` が 2 のとき、
法 `a` の合同式 `u ^ N ≡ Ω * v ^ N` は `u ^ N ≡ 2` になる。
使うのは `1 ^ N = 1` と積の単位元だけである。 -/
theorem base_power_congr_two
    (a u v Ω : ℤ) (N : ℕ) (hv : v = 1) (hΩ : Ω = 2)
    (hcong : Int.ModEq a (u ^ N) (Ω * v ^ N)) :
    Int.ModEq a (u ^ N) 2 := by
  subst hv
  subst hΩ
  simpa using hcong

/-- 人手証明の第三段。隣接する二つの箱の法 `a` の合同式から、
合同式の定義（差の整除）により分子 `a` が底の点数乗の差を割る。 -/
theorem dvd_base_power_difference_of_congr_two
    (a u : ℤ) (N M : ℕ)
    (hN : Int.ModEq a (u ^ N) 2) (hM : Int.ModEq a (u ^ M) 2) :
    a ∣ u ^ M - u ^ N := by
  have h : Int.ModEq a (u ^ N) (u ^ M) := hN.trans hM.symm
  exact (Int.modEq_iff_dvd.mp h)

/-- 人手証明の全体。点数乗表示が成り立つ正の有理点について、底 `c` は正の整数であり、
その分子 `a` は隣接する二つの箱の底の点数乗の差を割る。

`hden` は先行する主張が与える第一段（底の既約分母は 1）の結論、
`hcongN` と `hcongM` は本文が引く各箱の法 `a` の合同式である。
`N` は `#V_L`、`M` は `#V_{L+1}` にあたる。 -/
theorem rational_power_point_numerator_divides_base_power_difference
    (c : ℚ) (a : ℤ) (N M : ℕ)
    (hden : c.den = 1)
    (hcongN : Int.ModEq a (c.num ^ N) (2 * (1 : ℤ) ^ N))
    (hcongM : Int.ModEq a (c.num ^ M) (2 * (1 : ℤ) ^ M)) :
    c = (c.num : ℚ) ∧ a ∣ c.num ^ M - c.num ^ N := by
  refine ⟨eq_num_of_den_eq_one c hden, ?_⟩
  have hN : Int.ModEq a (c.num ^ N) 2 :=
    base_power_congr_two a c.num 1 2 N rfl rfl hcongN
  have hM : Int.ModEq a (c.num ^ M) 2 :=
    base_power_congr_two a c.num 1 2 M rfl rfl hcongM
  exact dvd_base_power_difference_of_congr_two a c.num N M hN hM

end Ising3DCut.LimitQuantity
