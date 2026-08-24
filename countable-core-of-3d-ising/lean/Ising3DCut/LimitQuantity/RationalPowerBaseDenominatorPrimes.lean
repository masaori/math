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

end Ising3DCut.LimitQuantity
