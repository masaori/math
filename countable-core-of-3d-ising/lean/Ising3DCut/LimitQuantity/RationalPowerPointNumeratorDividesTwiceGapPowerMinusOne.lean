/-
人手証明「点数乗表示が成り立つ正の有理点の分子は隣接する二つの箱の頂点数の差だけの
点数乗から 1 を引いた数の 2 倍を割る」
（ラベル `claim_rational_power_point_numerator_divides_twice_gap_power_minus_one`）の Lean 具体版。

人手証明と同じ三段で進む。
準備段: 頂点数 `#V_L = L ^ 3` について、隣接する二つの箱の頂点数の差が `3L² + 3L + 1` であり、
        `#V_{L+1} = #V_L + (3L² + 3L + 1)` を満たすことを確かめる。
第一段: 底 `c` の既約分母は 1 なので `c` はその分子である整数に等しい（先行する主張
        `claim_rational_power_point_denominator_divides_two` の結論を仮定として受け取る）。
第二段: 各箱の法 `a` の合同式へ `v = 1` と破れ数ゼロの配位数 `Ω = 2` を入れて
        `u ^ (#V_L) ≡ 2` と `u ^ (#V_{L+1}) ≡ 2` を得たうえで、
        本文の一連の変形と同じ順に `2 * u ^ g ≡ u ^ (#V_L) * u ^ g = u ^ (#V_{L+1}) ≡ 2` を辿る。
第三段: 法 `a` の合同式の定義（差の整除）により `a ∣ 2 * u ^ g - 2` を出し、
        `2 * u ^ g - 2 = 2 * (u ^ g - 1)` と書き直して主張の整除を得る。

先行する主張は本文でも引くだけなので、ここでも結論を仮定として受け取る。
計算は整数の合同式の定義と冪の指数法則だけで行い、mathlib の一般論へ委ねない。
-/
import Ising3DCut.LimitQuantity.RationalPowerPointNumeratorDividesBasePowerDifference

namespace Ising3DCut.LimitQuantity

/-- 人手証明の準備段。隣接する二つの箱の頂点数 `L ^ 3` と `(L + 1) ^ 3` について、
差が `3L² + 3L + 1` であること、すなわち大きい側が小さい側とその差の和であることを確かめる。 -/
theorem vertex_count_succ_eq_add_gap (L : ℕ) :
    (L + 1) ^ 3 = L ^ 3 + (3 * L ^ 2 + 3 * L + 1) := by
  ring

/-- 人手証明の第二段。隣接する二つの箱の法 `a` の合同式と、頂点数の分解
`M = N + g` から、本文の一連の変形と同じ順に `2 * u ^ g ≡ 2` を得る。
使うのは合同式の推移と冪の指数法則だけである。 -/
theorem two_mul_pow_gap_congr_two
    (a u : ℤ) (N M g : ℕ) (hsum : M = N + g)
    (hN : Int.ModEq a (u ^ N) 2) (hM : Int.ModEq a (u ^ M) 2) :
    Int.ModEq a (2 * u ^ g) 2 := by
  have hstep : Int.ModEq a (2 * u ^ g) (u ^ N * u ^ g) :=
    (hN.symm).mul_right (u ^ g)
  have hpow : u ^ N * u ^ g = u ^ M := by
    rw [hsum, pow_add]
  exact (hstep.trans (hpow ▸ hM))

/-- 人手証明の第三段。合同式 `2 * u ^ g ≡ 2` から、法 `a` の合同式の定義により
`a ∣ 2 * (u ^ g - 1)` を得る。 -/
theorem dvd_twice_pow_gap_sub_one_of_congr
    (a u : ℤ) (g : ℕ) (h : Int.ModEq a (2 * u ^ g) 2) :
    a ∣ 2 * (u ^ g - 1) := by
  have hdvd : a ∣ 2 - 2 * u ^ g := Int.modEq_iff_dvd.mp h
  have hneg : a ∣ -(2 - 2 * u ^ g) := hdvd.neg_right
  have hrw : -(2 - 2 * u ^ g) = 2 * (u ^ g - 1) := by ring
  exact hrw ▸ hneg

/-- 人手証明の全体。点数乗表示が成り立つ正の有理点について、底 `c` は正の整数であり、
その分子 `a` は、隣接する二つの箱の頂点数の差 `3L² + 3L + 1` だけの点数乗から
1 を引いた数の 2 倍を割る。

`hden` は先行する主張が与える第一段（底の既約分母は 1）の結論、
`hcongN` と `hcongM` は本文が引く箱 `L` と箱 `L + 1` の法 `a` の合同式である。 -/
theorem rational_power_point_numerator_divides_twice_gap_power_minus_one
    (c : ℚ) (a : ℤ) (L : ℕ)
    (hden : c.den = 1)
    (hcongN : Int.ModEq a (c.num ^ (L ^ 3)) (2 * (1 : ℤ) ^ (L ^ 3)))
    (hcongM : Int.ModEq a (c.num ^ ((L + 1) ^ 3)) (2 * (1 : ℤ) ^ ((L + 1) ^ 3))) :
    c = (c.num : ℚ) ∧ a ∣ 2 * (c.num ^ (3 * L ^ 2 + 3 * L + 1) - 1) := by
  refine ⟨eq_num_of_den_eq_one c hden, ?_⟩
  have hN : Int.ModEq a (c.num ^ (L ^ 3)) 2 :=
    base_power_congr_two a c.num 1 2 (L ^ 3) rfl rfl hcongN
  have hM : Int.ModEq a (c.num ^ ((L + 1) ^ 3)) 2 :=
    base_power_congr_two a c.num 1 2 ((L + 1) ^ 3) rfl rfl hcongM
  have hcong : Int.ModEq a (2 * c.num ^ (3 * L ^ 2 + 3 * L + 1)) 2 :=
    two_mul_pow_gap_congr_two a c.num (L ^ 3) ((L + 1) ^ 3) (3 * L ^ 2 + 3 * L + 1)
      (vertex_count_succ_eq_add_gap L) hN hM
  exact dvd_twice_pow_gap_sub_one_of_congr a c.num (3 * L ^ 2 + 3 * L + 1) hcong

end Ising3DCut.LimitQuantity
