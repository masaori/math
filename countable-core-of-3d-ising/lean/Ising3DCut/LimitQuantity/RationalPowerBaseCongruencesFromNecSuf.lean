/-
必要十分版 `NecSuf.base_congruences_of_integer_equation` から具体版の合同条件を導く。
具体側には、有理数表示からの整数等式、有限和の両端合同、自然数冪の整除、
および `a,b` の互いに素性だけを残す。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseCongruences
import Ising3DCut.NecSuf.RationalPowerBaseCongruences

namespace Ising3DCut.LimitQuantity

/-- `rational_power_base_congruences` を必要十分版から導いた版。 -/
theorem rational_power_base_congruences_viaNecSuf
    (Ω : ℕ → ℕ) (a b u v E N : ℕ) (hb : 0 < b) (hv : 0 < v) (hE : 1 ≤ E)
    (hab : Nat.Coprime a b) (hpal : Ω E = Ω 0)
    (hrep : (brokenCountSum Ω a b E : ℚ) / (b : ℚ) ^ E = ((u : ℚ) / (v : ℚ)) ^ N) :
    (((Ω 0 : ℤ) * (v : ℤ) ^ N ≡ (u : ℤ) ^ N [ZMOD (a : ℤ)])
      ∧ (b : ℤ) ∣ (Ω 0 : ℤ) * (v : ℤ) ^ N) := by
  have heq : (brokenCountSum Ω a b E : ℤ) * (v : ℤ) ^ N =
      (u : ℤ) ^ N * (b : ℤ) ^ E :=
    integer_equation_of_rational_representation _ b u v E N hb hv hrep
  have hcop : IsCoprime (a : ℤ) (b : ℤ) :=
    Int.isCoprime_iff_gcd_eq_one.mpr (by simpa [Int.gcd_natCast_natCast] using hab)
  apply Ising3DCut.NecSuf.base_congruences_of_integer_equation
    (brokenCountSum Ω a b E : ℤ) (Ω 0 : ℤ) ((u : ℤ) ^ N) ((v : ℤ) ^ N)
    (a : ℤ) (b : ℤ) ((a : ℤ) ^ E) ((b : ℤ) ^ E)
  · exact heq
  · exact brokenCountSum_modEq_a Ω a b E
  · exact brokenCountSum_modEq_b Ω a b E hpal
  · exact hcop.symm.pow_left
  · exact hcop.symm.pow_right
  · exact Dvd.dvd.mul_left (dvd_pow_self (b : ℤ) (by omega : E ≠ 0)) _

end Ising3DCut.LimitQuantity
