/-
必要十分版 `NecSuf.false_of_nontrivial_common_divisor_of_one_plus` から、具体版の
「点数乗表示の底の既約分母が偶数なら分母の素数 2 の指数は 2 以上になりえない」を導く。
具体側には、有限和の法 4 による評価と素数 2 の指数の釣り合い式を得る段だけが残る。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentAtLeastTwoImpossible
import Ising3DCut.NecSuf.RationalPowerBaseDenTwoExponentAtLeastTwoImpossible

namespace Ising3DCut.LimitQuantity

open Finset

/-- `rational_power_base_den_two_exponent_at_least_two_impossible` を必要十分版から導いた版。 -/
theorem rational_power_base_den_two_exponent_at_least_two_impossible_viaNecSuf
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
  have hb4 : (4 : ℕ) ∣ b := by
    have hpow := (Nat.Prime.pow_dvd_iff_le_factorization Nat.prime_two hb.ne').mpr heb
    simpa using hpow
  have hb2 : (2 : ℕ) ∣ b := dvd_trans (by norm_num) hb4
  have ha2 : ¬ 2 ∣ a := not_two_dvd_numerator_of_two_dvd_denominator a b hab hb2
  have hmod : P % 4 = 2 := partition_value_mod_four Omega a b N hb4 hOmegaTop ha2
  have hPpos : 0 < P := by omega
  have hval : P.factorization 2 = 1 := two_valuation_of_mod_four_eq_two P hmod
  have hbal := rational_power_base_den_two_exponent_balance a b u v P (M ^ 3) N
    ha hb hu hv hPpos hab huv hv2 hb2 hid
  have heq : 1 + M ^ 3 * v.factorization 2 =
      3 * M ^ 2 * (M - 1) * b.factorization 2 := by
    have h := hbal.2.2.2.2
    rw [hval] at h
    rw [← hNdef]
    exact h
  have hd : 2 ≤ M ^ 2 := by nlinarith
  have hcorrection : M ^ 2 ∣ M ^ 3 * v.factorization 2 :=
    ⟨M * v.factorization 2, by ring⟩
  have htotal : M ^ 2 ∣ 3 * M ^ 2 * (M - 1) * b.factorization 2 :=
    ⟨3 * (M - 1) * b.factorization 2, by ring⟩
  exact Ising3DCut.NecSuf.false_of_nontrivial_common_divisor_of_one_plus
    (M ^ 2) (M ^ 3 * v.factorization 2)
    (3 * M ^ 2 * (M - 1) * b.factorization 2)
    hd hcorrection htotal heq

end Ising3DCut.LimitQuantity
