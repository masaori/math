/-
「末尾で点数乗表示が成り立つ正の有理点は 1 に限られる」の具体版が、必要十分版の
特殊化として得られることの明示。性質を「有理点で末尾から点数乗になること」に、
三つの候補を有理点 2 分の 1・1・2 に取る。

必要十分版には有理数も有限箱も現れない。具体版が使っていたのは、候補が三点に
尽きることと、そのうち二点での不可能性の二つだけだったと分かる。
-/
import Ising3DCut.LimitQuantity.EventualPowerFormOnlyAtOne
import Ising3DCut.NecSuf.EventualPowerFormOnlyAtOne

namespace Ising3DCut.LimitQuantity

/-- `claim_eventual_power_form_only_at_one` の第一段と第二段を必要十分版から導いたもの。 -/
theorem eq_one_of_eventual_power_form_fromNecSuf
    {q : ℚ} (hpower : EventualPowerFormAt q)
    (hcandidates : q = 1 / 2 ∨ q = 1 ∨ q = 2) :
    q = 1 :=
  NecSuf.eq_of_three_candidates_of_two_impossible hpower hcandidates
    (fun h => eventual_power_form_at_one_half_is_impossible
      (by simpa [EventualPowerFormAt, partitionValueAtOneHalfRat] using h))
    (fun h => by
      refine eventual_power_form_at_two_is_impossible ?_
      rcases h with ⟨L₀, c, hL₀, hc, h⟩
      refine ⟨L₀, c, hL₀, hc, ?_⟩
      intro L hL
      have hvalue := h L hL
      rw [polyOfMultiplicity_eval_two_eq_partitionValueAtTwoNat] at hvalue
      exact_mod_cast hvalue)

end Ising3DCut.LimitQuantity
