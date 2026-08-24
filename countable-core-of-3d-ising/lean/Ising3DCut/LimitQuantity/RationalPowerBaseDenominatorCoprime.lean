/-
人手証明「点数乗表示の底の既約分母は有理点の分子と互いに素である」
（ラベル `claim_rational_power_base_den_coprime_to_num`）の Lean 具体版。

人手証明と同じ順で進む。
第一段: `a` と `v` の両方を割る素数 `p` を取る（互いに素でないと仮定した背理法）。
第二段: 法 `a` の合同式を法 `p` へ移す。
第三段: `p` が `v` を割り `N` が正なので、右辺 `Ω 0 * v^N` は法 `p` で消え、`p ∣ u^N` を得る。
第四段: `p` は素数なので `p ∣ u`。`u` と `v` の互いに素性に反して矛盾する。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseCongruences

namespace Ising3DCut.LimitQuantity

/-- 人手証明の第二段と第三段。法 `a` の合同式と `p ∣ a`、`p ∣ v`、`0 < N` から `p ∣ u^N`。 -/
theorem dvd_pow_numerator_of_dvd_denominator
    (Ω0 u v a N : ℕ) (p : ℕ) (hN : 0 < N) (hpa : p ∣ a) (hpv : p ∣ v)
    (hcong : (Ω0 : ℤ) * (v : ℤ) ^ N ≡ (u : ℤ) ^ N [ZMOD (a : ℤ)]) :
    p ∣ u ^ N := by
  have hpaZ : (p : ℤ) ∣ (a : ℤ) := Int.natCast_dvd_natCast.mpr hpa
  -- 第二段: 法 a を法 p へ移す
  have hcongp : (Ω0 : ℤ) * (v : ℤ) ^ N ≡ (u : ℤ) ^ N [ZMOD (p : ℤ)] :=
    Int.ModEq.of_dvd hpaZ hcong
  -- 第三段: 左辺は法 p で 0
  have hpvN : (p : ℤ) ∣ (Ω0 : ℤ) * (v : ℤ) ^ N := by
    have hpvZ : (p : ℤ) ∣ (v : ℤ) := Int.natCast_dvd_natCast.mpr hpv
    exact Dvd.dvd.mul_left (hpvZ.trans (dvd_pow_self _ hN.ne')) _
  have hzero : (Ω0 : ℤ) * (v : ℤ) ^ N ≡ 0 [ZMOD (p : ℤ)] := (Int.modEq_zero_iff_dvd).mpr hpvN
  have hdvdZ : (p : ℤ) ∣ (u : ℤ) ^ N :=
    (Int.modEq_zero_iff_dvd).mp (hcongp.symm.trans hzero)
  have : (p : ℤ) ∣ ((u ^ N : ℕ) : ℤ) := by push_cast; exact hdvdZ
  exact Int.ofNat_dvd.mp this

/-- 人手証明の全体。法 `a` の合同式と底の既約性だけから、`a` と `v` の互いに素性が従う。 -/
theorem rational_power_base_denominator_coprime_to_numerator
    (Ω0 u v a N : ℕ) (hN : 0 < N) (huv : Nat.Coprime u v)
    (hcong : (Ω0 : ℤ) * (v : ℤ) ^ N ≡ (u : ℤ) ^ N [ZMOD (a : ℤ)]) :
    Nat.Coprime a v := by
  -- 第一段: 互いに素でないなら共通の素因子 p が取れる
  by_contra hnc
  obtain ⟨p, hp, hpa, hpv⟩ := Nat.Prime.not_coprime_iff_dvd.mp hnc
  have hpuN : p ∣ u ^ N :=
    dvd_pow_numerator_of_dvd_denominator Ω0 u v a N p hN hpa hpv hcong
  -- 第四段: p は素数なので p ∣ u。u と v の互いに素性に反する
  have hpu : p ∣ u := hp.dvd_of_dvd_pow hpuN
  have hp1 : p ∣ Nat.gcd u v := Nat.dvd_gcd hpu hpv
  rw [Nat.Coprime] at huv
  rw [huv] at hp1
  exact Nat.Prime.one_lt hp |>.ne' (Nat.dvd_one.mp hp1)

end Ising3DCut.LimitQuantity
