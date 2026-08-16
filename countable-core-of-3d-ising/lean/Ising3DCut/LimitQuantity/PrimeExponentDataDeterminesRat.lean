/-
「極限量が有限箱の列だけの関数であること」の Lean 具体版・第二歩（可算側の段）。

第一歩（`PrimeExponentDataDeterminesNat`）で正の自然数が素指数データで決まることを示した。
ここでは**正の有理数**へ広げる：素指数データ $\lambda_p(q)$ を `padicValRat p q` で表し、
すべての素数 $p$ で一致すれば $q = q'$ を、分子・分母の一致へ帰着して示す。
分子と分母は互いに素なので、$q$ の $p$ 進付値は分子の指数から分母の指数を引いたものであり、
分子・分母のどちらか一方だけが $p$ を割る。
-/
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Ising3DCut.LimitQuantity.PrimeExponentDataDeterminesNat

namespace Ising3DCut.LimitQuantity

open Rat

/-- 正の有理数 `q q'` について、すべての素数 `p` での `p` 進付値が一致すれば `q = q'`。 -/
theorem rat_eq_of_prime_exponents_eq {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q')
    (h : ∀ p : ℕ, p.Prime → padicValRat p q = padicValRat p q') : q = q' := by
  -- 分子・分母の指数へ落とす：`padicValRat p q = v(num) - v(den)`
  have hnum : q.num ≠ 0 := Rat.num_ne_zero.mpr hq.ne'
  have hnum' : q'.num ≠ 0 := Rat.num_ne_zero.mpr hq'.ne'
  have hden : q.den ≠ 0 := q.den_nz
  have hden' : q'.den ≠ 0 := q'.den_nz
  -- 正の有理数の分子は正なので `q.num.natAbs` で置き換える
  have hnat : q = (q.num.natAbs : ℚ) / (q.den : ℚ) := by
    have hpos : (0 : ℤ) < q.num := Rat.num_pos.mpr hq
    rw [Nat.cast_natAbs, abs_of_pos (by exact_mod_cast hpos), Rat.num_div_den]
  have hnat' : q' = (q'.num.natAbs : ℚ) / (q'.den : ℚ) := by
    have hpos : (0 : ℤ) < q'.num := Rat.num_pos.mpr hq'
    rw [Nat.cast_natAbs, abs_of_pos (by exact_mod_cast hpos), Rat.num_div_den]
  -- 素数ごとに、分子・分母の指数の一致を得る（互いに素なので一方の指数は 0）
  have key : ∀ p : ℕ, p.Prime →
      q.num.natAbs.factorization p = q'.num.natAbs.factorization p ∧
      q.den.factorization p = q'.den.factorization p := by
    intro p hp
    haveI := Fact.mk hp
    have e := h p hp
    rw [padicValRat, padicValRat] at e
    rw [padicValInt, padicValInt] at e
    have cop : Nat.Coprime q.num.natAbs q.den := q.reduced
    have cop' : Nat.Coprime q'.num.natAbs q'.den := q'.reduced
    rw [Nat.factorization_def _ hp, Nat.factorization_def _ hp,
      Nat.factorization_def _ hp, Nat.factorization_def _ hp]
    -- 互いに素：p はどちらか一方しか割らない
    have h1 : padicValNat p q.num.natAbs = 0 ∨ padicValNat p q.den = 0 := by
      by_contra hc
      push Not at hc
      have d1 : p ∣ q.num.natAbs := by
        have := hc.1
        by_contra hnd
        exact this (padicValNat.eq_zero_of_not_dvd hnd)
      have d2 : p ∣ q.den := by
        have := hc.2
        by_contra hnd
        exact this (padicValNat.eq_zero_of_not_dvd hnd)
      exact hp.one_lt.ne' (Nat.dvd_one.mp (cop ▸ Nat.dvd_gcd d1 d2))
    have h2 : padicValNat p q'.num.natAbs = 0 ∨ padicValNat p q'.den = 0 := by
      by_contra hc
      push Not at hc
      have d1 : p ∣ q'.num.natAbs := by
        by_contra hnd; exact hc.1 (padicValNat.eq_zero_of_not_dvd hnd)
      have d2 : p ∣ q'.den := by
        by_contra hnd; exact hc.2 (padicValNat.eq_zero_of_not_dvd hnd)
      exact hp.one_lt.ne' (Nat.dvd_one.mp (cop' ▸ Nat.dvd_gcd d1 d2))
    omega
  have hn : q.num.natAbs = q'.num.natAbs := by
    apply nat_eq_of_prime_exponents_eq (Int.natAbs_ne_zero.mpr hnum) (Int.natAbs_ne_zero.mpr hnum')
    intro p
    by_cases hp : p.Prime
    · exact (key p hp).1
    · simp [Nat.factorization_eq_zero_of_not_prime _ hp]
  have hd : q.den = q'.den := by
    apply nat_eq_of_prime_exponents_eq hden hden'
    intro p
    by_cases hp : p.Prime
    · exact (key p hp).2
    · simp [Nat.factorization_eq_zero_of_not_prime _ hp]
  rw [hnat, hnat', hn, hd]

end Ising3DCut.LimitQuantity
