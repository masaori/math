/-
人手証明「点数乗表示の底の既約分母が偶数なら分母の素数 2 の指数は 2 以上になりえない」
（ラベル `claim_rational_power_base_den_two_exponent_at_least_two_impossible`）の Lean 具体版。

人手証明と同じ三段で進む。
第一段: `2 ∣ v` のもとで釣り合い式 `v_2(P_M) + #V_M * e_v = #E_M * e_b` を取る
        （`rational_power_base_den_two_exponent_balance` の適用）。
第二段: `e_b ≥ 2` すなわち `4 ∣ b` から、`m < #E_M` の各項が 4 で割れるので
        `P_M ≡ Ω_M(#E_M) * a^(#E_M) (mod 4)` となり、`Ω_M(#E_M) = 2` と `a` の奇数性から
        `P_M ≡ 2 (mod 4)`、したがって `v_2(P_M) = 1` が決まる。
第三段: 釣り合い式へ `v_2(P_M) = 1`、`#V_M = M^3`、`#E_M = 3M^2(M-1)` を入れると
        `1 + M^3 e_v = 3M^2(M-1) e_b` となり、両辺の差から `M^2 ∣ 1` が出て `M ≥ 2` に矛盾する。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentBalance

namespace Ising3DCut.LimitQuantity

open Finset

/-- 人手証明の第二段の最初の段。`4 ∣ b` のとき、最高次 `m = N` 未満の各項は 4 で割り切れる。
使うのは指数 `N - m` が 1 以上であることだけである。 -/
theorem lower_terms_divisible_by_four
    (Omega : ℕ → ℕ) (a b N m : ℕ) (hb4 : 4 ∣ b) (hm : m < N) :
    4 ∣ Omega m * a ^ m * b ^ (N - m) := by
  have hne : N - m ≠ 0 := by omega
  have hbp : b ∣ b ^ (N - m) := dvd_pow_self b hne
  exact Dvd.dvd.mul_left (hb4.trans hbp) _

/-- 人手証明の第二段の残り。最高次未満の項が 4 で消えたあと、端係数 2 と `a` の奇数性から
有限和は法 4 で 2 に決まる。 -/
theorem partition_value_mod_four
    (Omega : ℕ → ℕ) (a b N : ℕ) (hb4 : 4 ∣ b)
    (hOmegaN : Omega N = 2) (ha : ¬ 2 ∣ a) :
    (∑ m ∈ range (N + 1), Omega m * a ^ m * b ^ (N - m)) % 4 = 2 := by
  have hlow : 4 ∣ ∑ m ∈ range N, Omega m * a ^ m * b ^ (N - m) :=
    Finset.dvd_sum fun m hm =>
      lower_terms_divisible_by_four Omega a b N m hb4 (Finset.mem_range.mp hm)
  obtain ⟨t, ht⟩ := hlow
  have h2 : a % 2 = 1 := by
    rcases Nat.even_or_odd a with h | h
    · exact absurd h.two_dvd ha
    · exact Nat.odd_iff.mp h
  obtain ⟨k, hk⟩ : Odd (a ^ N) := (Nat.odd_iff.mpr h2).pow
  rw [Finset.sum_range_succ, ht, hOmegaN, Nat.sub_self, pow_zero, mul_one, hk]
  omega

/-- 人手証明の第二段の結び。法 4 で 2 であることは、素数 2 の指数が 1 であることを与える。 -/
theorem two_valuation_of_mod_four_eq_two (P : ℕ) (hP : P % 4 = 2) :
    P.factorization 2 = 1 := by
  obtain ⟨q, hq⟩ : ∃ q, P = 2 * (2 * q + 1) := ⟨P / 4, by omega⟩
  have hodd : ¬ 2 ∣ (2 * q + 1) := by omega
  rw [hq, Nat.factorization_mul (by norm_num) (by omega), Finsupp.add_apply,
    Nat.factorization_eq_zero_of_not_dvd hodd, Nat.Prime.factorization Nat.prime_two]
  simp

/-- 人手証明の第三段。釣り合い式に点数と辺数を入れた自然数の等式から、
両辺の差として `M^2 ∣ 1` が出て `M ≥ 2` に矛盾する。 -/
theorem square_divisibility_contradiction (M ev eb : ℕ) (hM : 2 ≤ M)
    (h : 1 + M ^ 3 * ev = 3 * M ^ 2 * (M - 1) * eb) : False := by
  have hy : M ^ 2 ∣ 3 * M ^ 2 * (M - 1) * eb := ⟨3 * (M - 1) * eb, by ring⟩
  have hx : M ^ 2 ∣ M ^ 3 * ev := ⟨M * ev, by ring⟩
  have hsub := Nat.dvd_sub hy hx
  have hdiff : 3 * M ^ 2 * (M - 1) * eb - M ^ 3 * ev = 1 := by omega
  rw [hdiff] at hsub
  have hle : M ^ 2 ≤ 1 := Nat.le_of_dvd (by norm_num) hsub
  have h4 : 2 ^ 2 ≤ M ^ 2 := Nat.pow_le_pow_left hM 2
  exact absurd (le_trans h4 hle) (by norm_num)

/-- 人手証明の全体。底の既約分母が偶数で、かつ分母 `b` の素数 2 の指数が 2 以上のとき矛盾する。
`P_M` は破れ辺数についての有限和として与える。 -/
theorem rational_power_base_den_two_exponent_at_least_two_impossible
    (Omega : ℕ → ℕ) (a b u v M : ℕ)
    (ha : 0 < a) (hb : 0 < b) (hu : 0 < u) (hv : 0 < v)
    (hab : Nat.Coprime a b) (huv : Nat.Coprime u v)
    (hv2 : 2 ∣ v) (hM : 2 ≤ M)
    (hOmegaTop : Omega (3 * M ^ 2 * (M - 1)) = 2)
    (heb : 2 ≤ b.factorization 2)
    (hid : (∑ m ∈ range (3 * M ^ 2 * (M - 1) + 1),
              Omega m * a ^ m * b ^ (3 * M ^ 2 * (M - 1) - m)) * v ^ (M ^ 3)
            = u ^ (M ^ 3) * b ^ (3 * M ^ 2 * (M - 1))) :
    False := by
  set N := 3 * M ^ 2 * (M - 1) with hNdef
  set P := ∑ m ∈ range (N + 1), Omega m * a ^ m * b ^ (N - m) with hPdef
  -- `e_b ≥ 2` は `4 ∣ b` を意味する（人手証明の第二段の入口）
  have hb4 : (4 : ℕ) ∣ b := by
    have := (Nat.Prime.pow_dvd_iff_le_factorization Nat.prime_two hb.ne').mpr heb
    simpa using this
  have hb2 : (2 : ℕ) ∣ b := dvd_trans (by norm_num) hb4
  -- 第一段: 釣り合い式
  have ha2 : ¬ 2 ∣ a := not_two_dvd_numerator_of_two_dvd_denominator a b hab hb2
  -- 第二段: 法 4 での決定と素数 2 の指数
  have hmod : P % 4 = 2 := partition_value_mod_four Omega a b N hb4 hOmegaTop ha2
  have hPpos : 0 < P := by omega
  have hval : P.factorization 2 = 1 := two_valuation_of_mod_four_eq_two P hmod
  have hbal := rational_power_base_den_two_exponent_balance a b u v P (M ^ 3) N
    ha hb hu hv hPpos hab huv hv2 hb2 hid
  -- 第三段: 点数と辺数を入れて矛盾
  have heq : 1 + M ^ 3 * v.factorization 2 = 3 * M ^ 2 * (M - 1) * b.factorization 2 := by
    have := hbal.2.2.2.2
    rw [hval] at this
    rw [← hNdef]
    exact this
  exact square_divisibility_contradiction M (v.factorization 2) (b.factorization 2) hM heq

end Ising3DCut.LimitQuantity
