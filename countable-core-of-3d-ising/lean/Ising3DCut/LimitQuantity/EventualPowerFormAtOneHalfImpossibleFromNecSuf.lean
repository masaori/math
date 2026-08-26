/-
「有理点 2 分の 1 では点数乗表示は末尾で成り立たない」の具体版が、必要十分版の特殊化として
得られることの明示。素数を 2 に、法を `2 ^ 2 = 4` に、値の列を有理点 2 での有限箱値に、
尺度の指数の列を箱の辺数に、尺度倍される列を底の点数乗に取る。

必要十分版には素数性も底の正値性も無い。具体版が置いていた `0 < c` は、この論法では
使っていない。点数乗という形も、2 分の 1 での値が自然数であることを与える役目しかない。
-/
import Ising3DCut.LimitQuantity.EventualPowerFormAtOneHalfImpossible
import Ising3DCut.NecSuf.EventualPowerFormAtOneHalfImpossible

namespace Ising3DCut.LimitQuantity

open NullModel

/-- `claim_eventual_power_form_at_one_half_is_impossible` を必要十分版から導いたもの。 -/
theorem eventual_power_form_at_one_half_is_impossible_fromNecSuf :
    ¬ ∃ L₀ c : ℕ, 0 < L₀ ∧ 0 < c ∧
      ∀ L, L₀ ≤ L → partitionValueAtOneHalfRat L =
        (c ^ Fintype.card (Site L) : ℕ) := by
  rintro ⟨L₀, c, hL₀, hc, hpower⟩
  refine NecSuf.no_scaled_natural_value_of_prime_sq_residue (p := 2) (by norm_num)
    partitionValueAtTwoNat (fun L => Fintype.card (Edge L))
    (fun L => c ^ Fintype.card (Site L)) L₀ ?_ ?_ ?_
  · intro L hL
    have hscaled := two_pow_edge_mul_partitionValueAtOneHalf_eq_partitionValueAtTwo L
    rw [hpower L hL] at hscaled
    exact_mod_cast hscaled
  · intro L hL
    exact two_le_card_edge hL
  · intro L hL
    have hmod := partitionValueAtTwoNat_mod_four hL
    simpa using hmod
end Ising3DCut.LimitQuantity
