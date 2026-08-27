/-
「有理点 2 分の 1 では有限箱の量は末尾周期的にならない」の具体版が、必要十分版の特殊化として
得られることの明示。指標を素数 2 の指数（`ℤ` 値）に、値の列を有理点 2 分の 1 での有限箱値に、
指数の列を箱の点数に取る。

必要十分版には回文性も有理数体も残っていない。具体版が回文性から取り出していたのは
「素数 2 の指数が `1 - #E_L` に等しい」という中間結論だけであり、交差冪等式の否定に効いているのは
その値と点数の積が二つの箱で相異なることだけだと、ここで分かる。
-/
import Ising3DCut.LimitQuantity.EventuallyPeriodicAtOneHalfImpossible
import Ising3DCut.NecSuf.EventuallyPeriodicAtOneHalfImpossible

namespace Ising3DCut.LimitQuantity

open NullModel

/-- `claim_eventually_periodic_at_one_half_is_impossible` を必要十分版から導いたもの。 -/
theorem eventually_periodic_at_one_half_power_identity_impossible_fromNecSuf :
    ¬ ∃ L₀ p : ℕ, 0 < L₀ ∧ 0 < p ∧
      ∀ L, L₀ ≤ L →
        partitionValueAtOneHalfRat L ^ Fintype.card (Site (L + p)) =
          partitionValueAtOneHalfRat (L + p) ^ Fintype.card (Site L) := by
  rintro ⟨L₀, p, hL₀, hp, hcross⟩
  refine NecSuf.no_eventual_cross_power_identity_of_pow_additive_index_mul_ne
    (padicValRat 2) partitionValueAtOneHalfRat
    (fun L => Fintype.card (Site L)) L₀ p ?_ ?_ hcross
  · intro L _ k
    exact padicValRat.pow _
  · intro L hL
    have hLp : 2 ≤ L + p := le_trans hL (Nat.le_add_right L p)
    rw [padicValRat_partitionValueAtOneHalfRat hL,
      padicValRat_partitionValueAtOneHalfRat hLp, card_site, card_site,
      card_edge, card_edge]
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
        ((((L + p) ^ 3 : ℕ) : ℤ) * (1 - (3 * (L - 1) * L ^ 2 : ℕ) : ℤ) -
          ((L ^ 3 : ℕ) : ℤ) * (1 - (3 * (L + p - 1) * (L + p) ^ 2 : ℕ) : ℤ)) =
          (L + p : ℤ) ^ 3 - L ^ 3 + 3 * p * L ^ 2 * (L + p) ^ 2 := by
      push_cast
      rw [hLsub, hLpsub]
      ring
    intro heq
    rw [heq, sub_self] at hdifference
    omega

end Ising3DCut.LimitQuantity
