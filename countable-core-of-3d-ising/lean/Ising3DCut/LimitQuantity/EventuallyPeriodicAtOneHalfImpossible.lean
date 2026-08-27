/-
人手証明「有理点 2 分の 1 では有限箱の量は末尾周期的にならない」
（ラベル `claim_eventually_periodic_at_one_half_is_impossible`）の Lean 具体版。

回文性で `2 ^ #E_M * Z_M(1/2) = Z_M(2)` と移し、右辺の素数 2 の
指数が 1 であることから `Z_M(1/2)` の素指数を `1 - #E_M` と定める。
周期だけ離れた二箱の交差冪等式へこの指数を適用すると、自由境界箱の
辺数と点数の有限な整式計算に反する。箱の大きさの極限は使わない。
-/
import Ising3DCut.LimitQuantity.EventualPowerFormAtOneHalfImpossible
import Ising3DCut.LimitQuantity.EventuallyPeriodicAtTwoImpossible
import Ising3DCut.NullModel.BrokenComplement
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 有理点 `1/2` の有限箱値に含まれる素数 2 の指数は `1 - #E_L` である。 -/
theorem padicValRat_partitionValueAtOneHalfRat
    {L : ℕ} (hL : 2 ≤ L) :
    padicValRat 2 (partitionValueAtOneHalfRat L) =
      1 - (Fintype.card (Edge L) : ℤ) := by
  have hmod := partitionValueAtTwoNat_mod_four hL
  have hNat0 : partitionValueAtTwoNat L ≠ 0 := by omega
  have hhalf0 : partitionValueAtOneHalfRat L ≠ 0 := by
    intro hzero
    have hscaled := two_pow_edge_mul_partitionValueAtOneHalf_eq_partitionValueAtTwo L
    rw [hzero, mul_zero] at hscaled
    apply hNat0
    exact_mod_cast hscaled.symm
  have hscaled := two_pow_edge_mul_partitionValueAtOneHalf_eq_partitionValueAtTwo L
  have hvaluation := congrArg (padicValRat 2) hscaled
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have htwo : padicValRat 2 (2 : ℚ) = 1 := by
    calc
      padicValRat 2 (2 : ℚ) = (padicValNat 2 2 : ℤ) :=
        (padicValRat_of_nat (p := 2) 2).symm
      _ = 1 := by rw [padicValNat_self]; norm_num
  rw [padicValRat.mul (pow_ne_zero _ (by norm_num : (2 : ℚ) ≠ 0)) hhalf0,
    padicValRat.pow, htwo, padicValRat.of_nat,
    ← Nat.factorization_def _ Nat.prime_two,
    two_valuation_of_mod_four_eq_two _ hmod] at hvaluation
  omega

/-- 周期だけ離れた二箱では、有理点 `1/2` の有限箱値の交差冪等式は成り立たない。 -/
theorem partitionValueAtOneHalfRat_cross_power_ne
    {L p : ℕ} (hL : 2 ≤ L) (hp : 0 < p) :
    partitionValueAtOneHalfRat L ^ Fintype.card (Site (L + p)) ≠
      partitionValueAtOneHalfRat (L + p) ^ Fintype.card (Site L) := by
  intro hcross
  have hLp : 2 ≤ L + p := le_trans hL (Nat.le_add_right L p)
  have hvalL := padicValRat_partitionValueAtOneHalfRat hL
  have hvalLp := padicValRat_partitionValueAtOneHalfRat hLp
  have hvaluation := congrArg (padicValRat 2) hcross
  rw [padicValRat.pow, padicValRat.pow, hvalL, hvalLp] at hvaluation
  rw [card_site, card_site, card_edge, card_edge] at hvaluation
  have hfirstNat : L ^ 3 < (L + p) ^ 3 :=
    Nat.pow_lt_pow_left (Nat.lt_add_of_pos_right hp) (by norm_num)
  have hfirst : (0 : ℤ) < (L + p : ℤ) ^ 3 - L ^ 3 := by
    apply sub_pos.mpr
    exact_mod_cast hfirstNat
  have hsecond : (0 : ℤ) ≤ 3 * p * L ^ 2 * (L + p) ^ 2 := by positivity
  have hpositive :
      0 < ((L + p : ℤ) ^ 3 - L ^ 3 + 3 * p * L ^ 2 * (L + p) ^ 2 : ℤ) :=
    add_pos_of_pos_of_nonneg hfirst hsecond
  have hLsub : ((L - 1 : ℕ) : ℤ) = (L : ℤ) - 1 := by omega
  have hLpsub : ((L + p - 1 : ℕ) : ℤ) = (L + p : ℤ) - 1 := by omega
  have hdifference :
      ((1 - (3 * (L - 1) * L ^ 2 : ℕ) : ℤ) * ((L + p) ^ 3 : ℕ) -
        (1 - (3 * (L + p - 1) * (L + p) ^ 2 : ℕ) : ℤ) * (L ^ 3 : ℕ)) =
        (L + p : ℤ) ^ 3 - L ^ 3 + 3 * p * L ^ 2 * (L + p) ^ 2 := by
    push_cast
    rw [hLsub, hLpsub]
    ring
  have hzero :
      ((1 - (3 * (L - 1) * L ^ 2 : ℕ) : ℤ) * ((L + p) ^ 3 : ℕ) -
        (1 - (3 * (L + p - 1) * (L + p) ^ 2 : ℕ) : ℤ) * (L ^ 3 : ℕ)) = 0 := by
    simpa [mul_comm] using sub_eq_zero.mpr hvaluation
  rw [hdifference] at hzero
  omega

/-- `claim_eventually_periodic_at_one_half_is_impossible` の具体版。 -/
theorem eventually_periodic_at_one_half_power_identity_impossible :
    ¬ ∃ L₀ p : ℕ, 0 < L₀ ∧ 0 < p ∧
      ∀ L, L₀ ≤ L →
        partitionValueAtOneHalfRat L ^ Fintype.card (Site (L + p)) =
          partitionValueAtOneHalfRat (L + p) ^ Fintype.card (Site L) := by
  rintro ⟨L₀, p, hL₀, hp, hcross⟩
  let L := max L₀ 2
  exact partitionValueAtOneHalfRat_cross_power_ne (le_max_right _ _) hp
    (hcross L (le_max_left _ _))

end Ising3DCut.LimitQuantity
