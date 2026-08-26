/-
人手証明「末尾で点数乗表示が成り立つ正の有理点は 1 に限られる」
（ラベル `claim_eventual_power_form_only_at_one`）の Lean 具体版。

既に得た三点への候補の絞り込みを受け取り、2 分の 1 と 2 をそれぞれの
不可能性定理で除き、1 だけを残す。逆向きは分配多項式の 1 での値を使う。
扱うのは有理係数多項式の有限評価だけであり、極限は使わない。
-/
import Ising3DCut.LimitQuantity.DenominatorTwoPointAndFinalCandidateSet
import Ising3DCut.LimitQuantity.EventualPowerFormAtOneHalfImpossible
import Ising3DCut.LimitQuantity.EventualPowerFormAtTwoImpossible
import Ising3DCut.NullModel.PartitionValueAtOne

namespace Ising3DCut.LimitQuantity

open Finset NullModel Polynomial

/-- 有理点 `q` で有限箱値が末尾から点数乗になること。 -/
def EventualPowerFormAt (q : ℚ) : Prop :=
  ∃ L₀ c : ℕ, 0 < L₀ ∧ 0 < c ∧
    ∀ L, L₀ ≤ L →
      (polyOfMultiplicity (Fintype.card (Edge L)) (NullModel.multiplicity L)).eval q =
        (c ^ Fintype.card (Site L) : ℕ)

/-- 人手証明の第一段と第二段。候補が三点に絞られていれば、二つの不可能性を
除いた `q = 1` だけが残る。 -/
theorem eq_one_of_eventual_power_form
    {q : ℚ} (hpower : EventualPowerFormAt q)
    (hcandidates : q = 1 / 2 ∨ q = 1 ∨ q = 2) :
    q = 1 := by
  rcases hcandidates with hhalf | hone | htwo
  · subst q
    apply False.elim
    apply eventual_power_form_at_one_half_is_impossible
    simpa [EventualPowerFormAt, partitionValueAtOneHalfRat] using hpower
  · exact hone
  · subst q
    apply False.elim
    apply eventual_power_form_at_two_is_impossible
    rcases hpower with ⟨L₀, c, hL₀, hc, hpower⟩
    refine ⟨L₀, c, hL₀, hc, ?_⟩
    intro L hL
    have hvalue := hpower L hL
    rw [polyOfMultiplicity_eval_two_eq_partitionValueAtTwoNat] at hvalue
    exact_mod_cast hvalue

/-- 人手証明の第三段。`q = 1` では底 `c = 2` の点数乗表示が全ての箱で成り立つ。 -/
theorem eventual_power_form_at_one : EventualPowerFormAt 1 := by
  refine ⟨1, 2, by norm_num, by norm_num, ?_⟩
  intro L _
  simp only [polyOfMultiplicity, eval_finsetSum, eval_mul, eval_C, eval_pow, eval_X,
    one_pow, mul_one]
  norm_cast
  rw [sum_multiplicity_eq_config_card, config_card_eq_two_pow_site_card]

end Ising3DCut.LimitQuantity
