/-
人手証明「点数乗表示の底の分母の素因子は、有理点の分母の素因子に限られる」
（ラベル `claim_rational_power_base_denominator_primes`）の Lean 具体版の第一段。

有限箱値を `P / b ^ E` と書いたあと、`p ∤ b` ならその素指数が `P` の素指数に等しく、
したがって非負であることを、人手証明と同じ商・冪・非整除の順で示す。
-/
import Ising3DCut.LimitQuantity.PowerIdentityIffRationalPowerForm

namespace Ising3DCut.LimitQuantity

/-- 人手証明の第一段。分母を割らない素数では、正整数の商 `P / b^E` の素指数は非負である。 -/
theorem padicValRat_nat_div_pow_nonneg
    (p P b E : ℕ) (hp : p.Prime) (hP : 0 < P) (hb : 0 < b) (hpNotDvd : ¬ p ∣ b) :
    0 ≤ padicValRat p ((P : ℚ) / (b : ℚ) ^ E) := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have hP0 : (P : ℚ) ≠ 0 := by exact_mod_cast hP.ne'
  have hb0 : (b : ℚ) ≠ 0 := by exact_mod_cast hb.ne'
  have hValB : padicValNat p b = 0 := by
    rw [padicValNat.eq_zero_iff]
    exact Or.inr (Or.inr hpNotDvd)
  calc
    padicValRat p ((P : ℚ) / (b : ℚ) ^ E)
        = padicValRat p (P : ℚ) - padicValRat p ((b : ℚ) ^ E) := by
            rw [padicValRat.div hP0 (pow_ne_zero E hb0)]
    _ = padicValRat p (P : ℚ) - (E : ℤ) * padicValRat p (b : ℚ) := by
          rw [padicValRat.pow]
    _ = (padicValNat p P : ℤ) - (E : ℤ) * (padicValNat p b : ℤ) := by
          rw [padicValRat.of_nat, padicValRat.of_nat]
    _ = (padicValNat p P : ℤ) := by rw [hValB]; ring
    _ ≥ 0 := by exact Int.natCast_nonneg _

/-- 人手証明の第二段。点数乗表示 `Z = c ^ N`（`N` は正）と `0 ≤ v_p(Z)` から `0 ≤ v_p(c)` を得る。
本文の「`#V_L v_p(c) = v_p(Z_L(q)) ≥ 0` と `#V_L > 0` から `v_p(c) ≥ 0`」に 1 対 1 で対応する。 -/
theorem padicValRat_base_nonneg_of_pow
    (p N : ℕ) (hp : p.Prime) (hN : 0 < N) (c : ℚ) (hc : 0 < c)
    (hnonneg : 0 ≤ padicValRat p (c ^ N)) :
    0 ≤ padicValRat p c := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have hc0 : c ≠ 0 := hc.ne'
  have hmul : (N : ℤ) * padicValRat p c = padicValRat p (c ^ N) := by
    rw [padicValRat.pow]
    try exact hc0
  have hNpos : (0 : ℤ) < (N : ℤ) := by exact_mod_cast hN
  nlinarith [hmul, hnonneg, hNpos]

/-- 人手証明の第三段。素指数が非負な正の有理数の既約分母は `p` で割り切れない。 -/
theorem not_dvd_den_of_padicValRat_nonneg
    (p : ℕ) (hp : p.Prime) (c : ℚ) (_hc : 0 < c)
    (hnonneg : 0 ≤ padicValRat p c) :
    ¬ p ∣ c.den := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  intro hdvd
  have hden : 0 < c.den := c.pos
  have hval : 1 ≤ padicValNat p c.den := by
    exact one_le_padicValNat_of_dvd hden.ne' hdvd
  have hnum : padicValInt p c.num = 0 := by
    have hcop : Nat.Coprime c.num.natAbs c.den := c.reduced
    have : ¬ p ∣ c.num.natAbs := by
      intro h
      have hpd : p ∣ Nat.gcd c.num.natAbs c.den := Nat.dvd_gcd h hdvd
      rw [hcop] at hpd
      exact hp.one_lt.ne' (Nat.dvd_one.mp hpd)
    unfold padicValInt
    rw [padicValNat.eq_zero_iff]
    exact Or.inr (Or.inr this)
  have hdef : padicValRat p c = padicValInt p c.num - padicValNat p c.den := rfl
  rw [hdef, hnum] at hnonneg
  omega

/-- 人手証明の全体。分母 `b` を割らない素数 `p` について、点数乗表示の底 `c` の既約分母は
`p` で割り切れない。第一段・第二段・第三段を本文と同じ順で束ねる。 -/
theorem rational_power_base_den_not_dvd_of_not_dvd
    (p P b E N : ℕ) (hp : p.Prime) (hP : 0 < P) (hb : 0 < b) (hN : 0 < N)
    (hpNotDvd : ¬ p ∣ b) (c : ℚ) (hc : 0 < c)
    (hrep : (P : ℚ) / (b : ℚ) ^ E = c ^ N) :
    ¬ p ∣ c.den := by
  have h1 : 0 ≤ padicValRat p ((P : ℚ) / (b : ℚ) ^ E) :=
    padicValRat_nat_div_pow_nonneg p P b E hp hP hb hpNotDvd
  rw [hrep] at h1
  exact not_dvd_den_of_padicValRat_nonneg p hp c hc
    (padicValRat_base_nonneg_of_pow p N hp hN c hc h1)

end Ising3DCut.LimitQuantity
