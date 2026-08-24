/-
必要十分版 `NecSuf.balance_of_zero_contribution` から、具体版の
「素数 2 についての指数の釣り合い式」を導く。
具体側には、整数等式から素数 2 の指数の四項等式を得る段と、整除性から各指数の
正値・零値を得る段だけが残る。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentBalance
import Ising3DCut.NecSuf.RationalPowerBaseDenTwoExponentBalance

namespace Ising3DCut.LimitQuantity

/-- `rational_power_base_den_two_exponent_balance` を必要十分版から導いた版。 -/
theorem rational_power_base_den_two_exponent_balance_viaNecSuf
    (a b u v P V E : ℕ)
    (ha : 0 < a) (hb : 0 < b) (hu : 0 < u) (hv : 0 < v) (hP : 0 < P)
    (hab : Nat.Coprime a b) (huv : Nat.Coprime u v)
    (hv2 : 2 ∣ v) (hb2 : 2 ∣ b)
    (hid : P * v ^ V = u ^ V * b ^ E) :
    ¬ 2 ∣ a ∧ ¬ 2 ∣ u ∧ 0 < v.factorization 2 ∧ 0 < b.factorization 2 ∧
      P.factorization 2 + V * v.factorization 2 = E * b.factorization 2 := by
  have ha2 : ¬ 2 ∣ a := not_two_dvd_numerator_of_two_dvd_denominator a b hab hb2
  have hu2 : ¬ 2 ∣ u := not_two_dvd_numerator_of_two_dvd_denominator u v huv hv2
  have hev : 0 < v.factorization 2 :=
    Nat.Prime.factorization_pos_of_dvd Nat.prime_two hv.ne' hv2
  have heb : 0 < b.factorization 2 :=
    Nat.Prime.factorization_pos_of_dvd Nat.prime_two hb.ne' hb2
  have hraw :
      P.factorization 2 + V * v.factorization 2 =
        V * u.factorization 2 + E * b.factorization 2 := by
    have hfac := congrArg (fun n : ℕ => n.factorization 2) hid
    rw [Nat.factorization_mul hP.ne' (pow_ne_zero _ hv.ne'),
      Nat.factorization_mul (pow_ne_zero _ hu.ne') (pow_ne_zero _ hb.ne'),
      Nat.factorization_pow, Nat.factorization_pow] at hfac
    simpa [nsmul_eq_mul] using hfac
  have huzero : V * u.factorization 2 = 0 := by
    rw [Nat.factorization_eq_zero_of_not_dvd hu2, mul_zero]
  have hbalance := Ising3DCut.NecSuf.balance_of_zero_contribution
    (P.factorization 2) (V * v.factorization 2)
    (V * u.factorization 2) (E * b.factorization 2) hraw huzero
  exact ⟨ha2, hu2, hev, heb, hbalance⟩

end Ising3DCut.LimitQuantity
