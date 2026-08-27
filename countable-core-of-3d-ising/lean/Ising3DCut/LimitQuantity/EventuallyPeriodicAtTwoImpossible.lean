/-
人手証明「有理点 2 では有限箱の量は末尾周期的にならない」
（ラベル `claim_eventually_periodic_at_two_is_impossible`）の Lean 具体版。

各有限箱値は法 4 で 2 なので、素数 2 の指数はちょうど 1 である。
周期だけ離れた二箱の冪等式の両辺で素数 2 の指数を取ると、
両辺の指数はそれぞれ二箱の点の個数になる。しかし正の周期だけ箱を
大きくすると点の個数は狭義に増えるため矛盾する。有限和・自然数の冪・
素因子指数だけを使い、箱の大きさの極限は使わない。
-/
import Ising3DCut.LimitQuantity.EventualPowerFormAtTwoImpossible
import Ising3DCut.LimitQuantity.EventuallyPeriodicIffPowerIdentity
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentAtLeastTwoImpossible

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 周期だけ離れた二箱では、有理点 `2` の有限箱値の交差冪等式は成り立たない。 -/
theorem partitionValueAtTwoNat_cross_power_ne
    {L p : ℕ} (hL : 2 ≤ L) (hp : 0 < p) :
    partitionValueAtTwoNat L ^ Fintype.card (Site (L + p)) ≠
      partitionValueAtTwoNat (L + p) ^ Fintype.card (Site L) := by
  intro hcross
  have hLp : 2 ≤ L + p := le_trans hL (Nat.le_add_right L p)
  have hvalL : (partitionValueAtTwoNat L).factorization 2 = 1 :=
    two_valuation_of_mod_four_eq_two _ (partitionValueAtTwoNat_mod_four hL)
  have hvalLp : (partitionValueAtTwoNat (L + p)).factorization 2 = 1 :=
    two_valuation_of_mod_four_eq_two _ (partitionValueAtTwoNat_mod_four hLp)
  have hvaluation := congrArg (fun n : ℕ => n.factorization 2) hcross
  rw [Nat.factorization_pow, Nat.factorization_pow] at hvaluation
  simp [hvalL, hvalLp] at hvaluation
  rw [card_site, card_site] at hvaluation
  have hlt : L ^ 3 < (L + p) ^ 3 := by
    exact Nat.pow_lt_pow_left (Nat.lt_add_of_pos_right hp) (by norm_num)
  exact (Nat.ne_of_gt hlt) hvaluation

/-- `claim_eventually_periodic_at_two_is_impossible` の有限箱の冪等式による具体版。 -/
theorem eventually_periodic_at_two_power_identity_impossible :
    ¬ ∃ L₀ p : ℕ, 0 < L₀ ∧ 0 < p ∧
      ∀ L, L₀ ≤ L →
        partitionValueAtTwoNat L ^ Fintype.card (Site (L + p)) =
          partitionValueAtTwoNat (L + p) ^ Fintype.card (Site L) := by
  rintro ⟨L₀, p, hL₀, hp, hcross⟩
  let L := max L₀ 2
  exact partitionValueAtTwoNat_cross_power_ne (le_max_right _ _) hp
    (hcross L (le_max_left _ _))

end Ising3DCut.LimitQuantity
