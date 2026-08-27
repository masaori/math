/-
「有理点 2 では有限箱の量は末尾周期的にならない」の具体版が、必要十分版の特殊化として
得られることの明示。指標を素数 2 の指数に、値の列を有理点 2 での有限箱値に、
指数の列を箱の点数に取る。

必要十分版には値の正値性も法 4 の条件も無い。具体版が経由していた「法 4 で 2」は、
交差冪等式の否定そのものには効いておらず、素数 2 の指数が 1 になるという中間結論だけが
使われていたことがここで分かる。
-/
import Ising3DCut.LimitQuantity.EventuallyPeriodicAtTwoImpossible
import Ising3DCut.NecSuf.EventuallyPeriodicAtTwoImpossible

namespace Ising3DCut.LimitQuantity

open NullModel

/-- `claim_eventually_periodic_at_two_is_impossible` を必要十分版から導いたもの。 -/
theorem eventually_periodic_at_two_power_identity_impossible_fromNecSuf :
    ¬ ∃ L₀ p : ℕ, 0 < L₀ ∧ 0 < p ∧
      ∀ L, L₀ ≤ L →
        partitionValueAtTwoNat L ^ Fintype.card (Site (L + p)) =
          partitionValueAtTwoNat (L + p) ^ Fintype.card (Site L) := by
  rintro ⟨L₀, p, hL₀, hp, hcross⟩
  refine NecSuf.no_eventual_cross_power_identity_of_pow_additive_index_eq_one
    (fun n : ℕ => n.factorization 2) ?_ partitionValueAtTwoNat
    (fun L => Fintype.card (Site L)) L₀ p ?_ ?_ hcross
  · intro n k
    simpa using congrArg (fun f => f 2) (Nat.factorization_pow n k)
  · intro L hL
    exact two_valuation_of_mod_four_eq_two _ (partitionValueAtTwoNat_mod_four hL)
  · intro L hL
    rw [card_site, card_site]
    have hlt : L ^ 3 < (L + p) ^ 3 :=
      Nat.pow_lt_pow_left (Nat.lt_add_of_pos_right hp) (by norm_num)
    exact Nat.ne_of_gt hlt

end Ising3DCut.LimitQuantity
