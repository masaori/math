/-
必要十分版 `NecSuf.false_of_nontrivial_common_divisor_of_one_plus` から、具体版の
「底の既約分母が偶数なら、その素数 2 の指数は 1 にもなりえない」を導く。

法 4 で有限和を評価して素数 2 の指数の釣り合い式を得るところまでは具体側に残る。
箱・分配多項式・素因子分解を落とした後に必要なのは、1 より大きい共通因子が
補正項と総量をともに割る一方で、総量が補正項に 1 を足した値であることの不両立だけである。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentOneImpossible
import Ising3DCut.NecSuf.RationalPowerBaseDenTwoExponentAtLeastTwoImpossible

namespace Ising3DCut.LimitQuantity

open Finset

/-- `rational_power_base_den_two_exponent_one_impossible` を必要十分版から導いた版。 -/
theorem rational_power_base_den_two_exponent_one_impossible_viaNecSuf
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
  have hb2 : (2 : ℕ) ∣ b := by
    have hpow :=
      (Nat.Prime.pow_dvd_iff_le_factorization Nat.prime_two hb.ne').mpr (le_of_eq heb.symm)
    simpa using hpow
  have hN2 : 2 ≤ N := by
    have h1 : 1 ≤ M - 1 := by omega
    have h4 : 4 ≤ M ^ 2 := by nlinarith
    calc 2 ≤ 3 * 4 * 1 := by norm_num
      _ ≤ 3 * M ^ 2 * (M - 1) := by
          exact Nat.mul_le_mul (Nat.mul_le_mul_left 3 h4) h1
  have ha2 : ¬ 2 ∣ a := not_two_dvd_numerator_of_two_dvd_denominator a b hab hb2
  have hmod : P % 4 = 2 :=
    partition_value_mod_four_of_penultimate_zero Omega a b N hN2 hb2 hOmegaPen hOmegaTop ha2
  have hPpos : 0 < P := by omega
  have hval : P.factorization 2 = 1 := two_valuation_of_mod_four_eq_two P hmod
  have hbal := rational_power_base_den_two_exponent_balance a b u v P (M ^ 3) N
    ha hb hu hv hPpos hab huv hv2 hb2 hid
  have heq : 1 + M ^ 3 * v.factorization 2 = 3 * M ^ 2 * (M - 1) := by
    have h := hbal.2.2.2.2
    rw [hval, heb, mul_one] at h
    rw [← hNdef]
    exact h
  have hd : 2 ≤ M ^ 2 := by nlinarith
  have hcorrection : M ^ 2 ∣ M ^ 3 * v.factorization 2 :=
    ⟨M * v.factorization 2, by ring⟩
  have htotal : M ^ 2 ∣ 3 * M ^ 2 * (M - 1) :=
    ⟨3 * (M - 1), by ring⟩
  exact Ising3DCut.NecSuf.false_of_nontrivial_common_divisor_of_one_plus
    (M ^ 2) (M ^ 3 * v.factorization 2) (3 * M ^ 2 * (M - 1))
    hd hcorrection htotal heq

end Ising3DCut.LimitQuantity
