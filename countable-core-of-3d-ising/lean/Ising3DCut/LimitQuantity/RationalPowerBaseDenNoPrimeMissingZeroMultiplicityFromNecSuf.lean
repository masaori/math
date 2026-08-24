/-
必要十分版 `NecSuf.false_of_positive_adjacent_balance` から、具体版の
「点数乗表示の底の既約分母は破れ数ゼロの配位数を割らない素数では割り切れない」を導く。
具体側には、合同式と素因子分解から隣接二箱の釣り合い式を得る段だけが残る。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenNoPrimeMissingZeroMultiplicity
import Ising3DCut.NecSuf.RationalPowerBaseDenNoPrimeMissingZeroMultiplicity

namespace Ising3DCut.LimitQuantity

/-- `rational_power_base_den_no_prime_missing_zero_multiplicity` を必要十分版から導いた版。 -/
theorem rational_power_base_den_no_prime_missing_zero_multiplicity_viaNecSuf
    (K : ℕ) (a b u v : ℕ) (ΩL ΩL1 PL PL1 : ℕ) (p : ℕ) (hp : p.Prime)
    (ha : 0 < a) (hb : 0 < b) (hu : 0 < u) (hv : 0 < v)
    (hPL : 0 < PL) (hPL1 : 0 < PL1)
    (hab : Nat.Coprime a b) (huv : Nat.Coprime u v)
    (hpb : p ∣ b)
    (hpΩL : ¬ p ∣ ΩL) (hpΩL1 : ¬ p ∣ ΩL1)
    (hcongL : (PL : ℤ) ≡ (ΩL : ℤ) * (a : ℤ) ^ (3 * ((K + 1) * (K + 1)) * K)
      [ZMOD (b : ℤ)])
    (hcongL1 : (PL1 : ℤ) ≡ (ΩL1 : ℤ) * (a : ℤ) ^ (3 * ((K + 2) * (K + 2)) * (K + 1))
      [ZMOD (b : ℤ)])
    (hidL : PL * v ^ ((K + 1) * (K + 1) * (K + 1))
      = u ^ ((K + 1) * (K + 1) * (K + 1)) * b ^ (3 * ((K + 1) * (K + 1)) * K))
    (hidL1 : PL1 * v ^ ((K + 2) * (K + 2) * (K + 2))
      = u ^ ((K + 2) * (K + 2) * (K + 2)) * b ^ (3 * ((K + 2) * (K + 2)) * (K + 1))) :
    ¬ p ∣ v := by
  intro hpv
  have hpa : ¬ p ∣ a := fun h => Nat.Prime.one_lt hp |>.ne'
    (Nat.dvd_one.mp (hab ▸ Nat.dvd_gcd h hpb))
  have hpu : ¬ p ∣ u := fun h => Nat.Prime.one_lt hp |>.ne'
    (Nat.dvd_one.mp (huv ▸ Nat.dvd_gcd h hpv))
  have hpPL : ¬ p ∣ PL :=
    not_dvd_bridge_integer_of_not_dvd_zero_multiplicity PL ΩL a b _ p hp hpb hpΩL hpa hcongL
  have hpPL1 : ¬ p ∣ PL1 :=
    not_dvd_bridge_integer_of_not_dvd_zero_multiplicity PL1 ΩL1 a b _ p hp hpb hpΩL1 hpa hcongL1
  have hexpL := exponent_equation_of_integer_identity PL u v b _ _ p hp hPL hu hv hb hpPL hpu hidL
  have hexpL1 :=
    exponent_equation_of_integer_identity PL1 u v b _ _ p hp hPL1 hu hv hb hpPL1 hpu hidL1
  have hL := box_exponent_equation_cancel K (v.factorization p) (b.factorization p) hexpL
  have hL1 : (K + 2) * v.factorization p = 3 * (K + 1) * b.factorization p := by
    have h := box_exponent_equation_cancel (K + 1) (v.factorization p) (b.factorization p)
      (by simpa using hexpL1)
    simpa using h
  have heb : 0 < b.factorization p := Nat.Prime.factorization_pos_of_dvd hp hb.ne' hpb
  exact Ising3DCut.NecSuf.false_of_positive_adjacent_balance
    K 3 (v.factorization p) (b.factorization p) (by decide) heb hL hL1

end Ising3DCut.LimitQuantity
