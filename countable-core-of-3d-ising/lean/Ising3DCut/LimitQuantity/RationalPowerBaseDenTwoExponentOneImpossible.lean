/-
人手証明「点数乗表示の底の既約分母が偶数なら分母の素数 2 の指数は 1 にもなりえない」
（ラベル `claim_rational_power_base_den_two_exponent_one_impossible`）の Lean 具体版。

人手証明と同じ五段で進む。
第一段: `2 ∣ v` のもとで釣り合い式 `v_2(P_M) + #V_M * e_v = #E_M * e_b` を取る
        （`rational_power_base_den_two_exponent_balance` の適用）。
第二段: `e_b = 1` すなわち `2 ∣ b` から、`m ≤ #E_M - 2` の各項は `b^2` で割れるので 4 で割れ、
        法 4 に残るのは最高次とその一つ下の二項だけになる。
第三段: 回文性と `Ω_M(1) = 0` から `Ω_M(#E_M - 1) = 0` となり、一つ下の項も消える。
第四段: `Ω_M(#E_M) = 2` と `a` の奇数性から `P_M ≡ 2 (mod 4)`、したがって `v_2(P_M) = 1`。
第五段: 釣り合い式へ `v_2(P_M) = 1`、`e_b = 1`、`#V_M = M^3`、`#E_M = 3M^2(M-1)` を入れると
        `1 + M^3 e_v = 3M^2(M-1)` となり、両辺の差から `M^2 ∣ 1` が出て `M ≥ 2` に矛盾する。

第四段の後半（法 4 で 2 なら素数 2 の指数が 1）と第五段の矛盾は、指数 2 以上の場合の具体版で
証明した `two_valuation_of_mod_four_eq_two` と `square_divisibility_contradiction` と同一の
段であり、そのまま引く（人手証明でも同じ段を指している）。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentAtLeastTwoImpossible

namespace Ising3DCut.LimitQuantity

open Finset

/-- 人手証明の第二段の最初の段。`2 ∣ b` のとき、指数 `N - m` が 2 以上である項、
すなわち `m + 2 ≤ N` を満たす `m` の項は 4 で割り切れる。
使うのは `b^2` が項を割ることと `4 ∣ b^2` であることだけである。 -/
theorem lower_terms_divisible_by_four_of_two_dvd
    (Omega : ℕ → ℕ) (a b N m : ℕ) (hb2 : 2 ∣ b) (hm : m + 2 ≤ N) :
    4 ∣ Omega m * a ^ m * b ^ (N - m) := by
  obtain ⟨t, rfl⟩ := hb2
  have h4 : (4 : ℕ) ∣ (2 * t) ^ 2 := ⟨t ^ 2, by ring⟩
  have hpow : (2 * t) ^ 2 ∣ (2 * t) ^ (N - m) := pow_dvd_pow (2 * t) (by omega)
  exact Dvd.dvd.mul_left (h4.trans hpow) _

/-- 人手証明の第二段から第四段の前半。最高次の二つ下までの項が 4 で消え、
回文性から従う `Ω(N-1) = 0` で一つ下の項も消え、端係数 2 と `a` の奇数性から
有限和は法 4 で 2 に決まる。 -/
theorem partition_value_mod_four_of_penultimate_zero
    (Omega : ℕ → ℕ) (a b N : ℕ) (hN : 2 ≤ N) (hb2 : 2 ∣ b)
    (hOmegaPen : Omega (N - 1) = 0) (hOmegaN : Omega N = 2) (ha : ¬ 2 ∣ a) :
    (∑ m ∈ range (N + 1), Omega m * a ^ m * b ^ (N - m)) % 4 = 2 := by
  obtain ⟨K, rfl⟩ : ∃ K, N = K + 2 := ⟨N - 2, by omega⟩
  have hpen : Omega (K + 1) = 0 := by simpa using hOmegaPen
  have hlow : 4 ∣ ∑ m ∈ range (K + 1), Omega m * a ^ m * b ^ (K + 2 - m) :=
    Finset.dvd_sum fun m hm =>
      lower_terms_divisible_by_four_of_two_dvd Omega a b (K + 2) m hb2
        (by have := Finset.mem_range.mp hm; omega)
  obtain ⟨t, ht⟩ := hlow
  have h2 : a % 2 = 1 := by
    rcases Nat.even_or_odd a with h | h
    · exact absurd h.two_dvd ha
    · exact Nat.odd_iff.mp h
  obtain ⟨k, hk⟩ : Odd (a ^ (K + 2)) := (Nat.odd_iff.mpr h2).pow
  rw [Finset.sum_range_succ, Finset.sum_range_succ, ht, hpen, hOmegaN,
    Nat.sub_self, pow_zero, mul_one, hk]
  omega

/-- 人手証明の全体。底の既約分母が偶数で、かつ分母 `b` の素数 2 の指数が 1 のとき矛盾する。
`P_M` は破れ辺数についての有限和として与える。
`hOmegaPen` は回文性と「破れ数がちょうど 1 の配位は存在しない」から得られる仮定であり、
`hOmegaTop` は回文性と「破れ数が 0 の配位は 2 つある」から得られる仮定である。 -/
theorem rational_power_base_den_two_exponent_one_impossible
    (Omega : ℕ → ℕ) (a b u v M : ℕ)
    (ha : 0 < a) (hb : 0 < b) (hu : 0 < u) (hv : 0 < v)
    (hab : Nat.Coprime a b) (huv : Nat.Coprime u v)
    (hv2 : 2 ∣ v) (hM : 2 ≤ M)
    (hOmegaPen : Omega (3 * M ^ 2 * (M - 1) - 1) = 0)
    (hOmegaTop : Omega (3 * M ^ 2 * (M - 1)) = 2)
    (heb : b.factorization 2 = 1)
    (hid : (∑ m ∈ range (3 * M ^ 2 * (M - 1) + 1),
              Omega m * a ^ m * b ^ (3 * M ^ 2 * (M - 1) - m)) * v ^ (M ^ 3)
            = u ^ (M ^ 3) * b ^ (3 * M ^ 2 * (M - 1))) :
    False := by
  set N := 3 * M ^ 2 * (M - 1) with hNdef
  set P := ∑ m ∈ range (N + 1), Omega m * a ^ m * b ^ (N - m) with hPdef
  -- `e_b = 1` は `2 ∣ b` を意味する（人手証明の第二段の入口）
  have hb2 : (2 : ℕ) ∣ b := by
    have := (Nat.Prime.pow_dvd_iff_le_factorization Nat.prime_two hb.ne').mpr (le_of_eq heb.symm)
    simpa using this
  -- `M ≥ 2` から `#E_M = 3M^2(M-1) ≥ 12 ≥ 2`
  have hN2 : 2 ≤ N := by
    have h1 : 1 ≤ M - 1 := by omega
    have h4 : 4 ≤ M ^ 2 := by nlinarith
    calc 2 ≤ 3 * 4 * 1 := by norm_num
      _ ≤ 3 * M ^ 2 * (M - 1) := by
          exact Nat.mul_le_mul (Nat.mul_le_mul_left 3 h4) h1
  -- 第一段: 釣り合い式
  have ha2 : ¬ 2 ∣ a := not_two_dvd_numerator_of_two_dvd_denominator a b hab hb2
  -- 第二段から第四段: 法 4 での決定と素数 2 の指数
  have hmod : P % 4 = 2 :=
    partition_value_mod_four_of_penultimate_zero Omega a b N hN2 hb2 hOmegaPen hOmegaTop ha2
  have hPpos : 0 < P := by omega
  have hval : P.factorization 2 = 1 := two_valuation_of_mod_four_eq_two P hmod
  have hbal := rational_power_base_den_two_exponent_balance a b u v P (M ^ 3) N
    ha hb hu hv hPpos hab huv hv2 hb2 hid
  -- 第五段: 点数と辺数を入れて矛盾
  have heq : 1 + M ^ 3 * v.factorization 2 = 3 * M ^ 2 * (M - 1) * 1 := by
    have := hbal.2.2.2.2
    rw [hval, heb] at this
    rw [← hNdef]
    exact this
  exact square_divisibility_contradiction M (v.factorization 2) 1 hM heq

end Ising3DCut.LimitQuantity
