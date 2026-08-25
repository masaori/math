/-
人手証明「点数乗表示が成り立つ正の有理点の既約分母は 2 を割る」
（ラベル `claim_rational_power_point_denominator_divides_two`）の Lean 具体版。

人手証明と同じ四段で進む。
第一段: 奇素数は底 `c` の既約分母 `v` を割らない（`Ω_L(0) = 2` に奇素数が現れないことと、
        素因子を持たない場合の主張の適用）。よって `v` を割る素数は 2 に限られる。
第二段: `2 ∣ v` も成り立たない（分母の素数 2 の指数が 1 の場合と 2 以上の場合が
        どちらも矛盾するため）。
第三段: 第一段と第二段より `v` を割る素数が存在しないので `v = 1`、すなわち `c` は正の整数。
第四段: 法 `b` の整除 `b ∣ Ω_L(0) * v ^ (#V_L)` へ `v = 1` と `Ω_L(0) = 2` を入れて `b ∣ 2`。

先行する三つの主張（奇素数の排除・指数 1 の不可能性・指数 2 以上の不可能性）は、
本文でも定理として引くだけなので、ここでもそれぞれの結論を仮定として受け取る。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentOneImpossible

namespace Ising3DCut.LimitQuantity

/-- 人手証明の第一段。奇素数がどれも既約分母を割らないなら、
既約分母を割る素数は 2 に限られる。 -/
theorem prime_dvd_den_eq_two_of_no_odd_prime
    (c : ℚ) (hodd : ∀ p : ℕ, p.Prime → p ≠ 2 → ¬ p ∣ c.den)
    (p : ℕ) (hp : p.Prime) (hdvd : p ∣ c.den) :
    p = 2 := by
  by_contra hne
  exact hodd p hp hne hdvd

/-- 人手証明の第三段。既約分母を割る素数が 2 に限られ、しかも 2 が割らないなら、
既約分母を割る素数は存在しないので既約分母は 1 である。 -/
theorem den_eq_one_of_no_odd_prime_and_not_two
    (c : ℚ) (hodd : ∀ p : ℕ, p.Prime → p ≠ 2 → ¬ p ∣ c.den)
    (htwo : ¬ (2 : ℕ) ∣ c.den) :
    c.den = 1 := by
  rw [Nat.eq_one_iff_not_exists_prime_dvd]
  intro p hp hdvd
  have hp2 : p = 2 := prime_dvd_den_eq_two_of_no_odd_prime c hodd p hp hdvd
  exact htwo (hp2 ▸ hdvd)

/-- 人手証明の第四段。法 `b` の整除へ `v = 1` と `Ω_L(0) = 2` を入れると `b ∣ 2` が出る。
使うのは `1 ^ N = 1` と積の単位元だけである。 -/
theorem dvd_two_of_dvd_zero_multiplicity_mul_den_pow
    (b v N : ℕ) (hv : v = 1) (hdvd : b ∣ 2 * v ^ N) :
    b ∣ 2 := by
  subst hv
  simpa using hdvd

/-- 人手証明の全体。点数乗表示が成り立つ正の有理点について、底 `c` の既約分母は 1 であり
（すなわち `c` は正の整数であり）、有理点の既約分母 `b` は 2 を割る。

`hodd` は本文の第一段（奇素数は底の既約分母を割らない）、
`htwo` は本文の第二段（2 も底の既約分母を割らない）の結論であり、
`hdvd` は本文が引く法 `b` の整除に `Ω_L(0) = 2` を代入したものである。 -/
theorem rational_power_point_denominator_divides_two
    (c : ℚ) (b N : ℕ)
    (hodd : ∀ p : ℕ, p.Prime → p ≠ 2 → ¬ p ∣ c.den)
    (htwo : ¬ (2 : ℕ) ∣ c.den)
    (hdvd : b ∣ 2 * c.den ^ N) :
    c.den = 1 ∧ b ∣ 2 := by
  have hv : c.den = 1 := den_eq_one_of_no_odd_prime_and_not_two c hodd htwo
  exact ⟨hv, dvd_two_of_dvd_zero_multiplicity_mul_den_pow b c.den N hv hdvd⟩

end Ising3DCut.LimitQuantity
