/- 必要十分版を Qbar の部分体と `ℕ_{<|P|+1}` へ特殊化する導出。住処: N と Qbar。 -/
import Ising2DLambda.FisherZero.TwoShiftedValuesSumProduct
import Ising2DLambda.NecSuf.FisherZero.TwoShiftedValuesSumProduct

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_pigeonhole_one_more_than_cardinality` を必要十分版から得る。 -/
theorem pigeonhole_one_more_than_cardinality_from_necSuf {P : Type*} [Fintype P] [DecidableEq P]
    (φ : Fin (Fintype.card P + 1) → P) :
    ∃ c c' : Fin (Fintype.card P + 1), c < c' ∧ φ c = φ c' :=
  Ising2DLambda.NecSuf.FisherZero.pigeonhole_lt_necSuf (by rw [Fintype.card_fin]; omega) φ

/-- `claim_two_shifted_values_determine_product` を必要十分版から得る。
`c - c'` の像が零でないことと `F` に属することは、具体版と同じく整数の包含と
`intCast_mem_subfield` から渡す。 -/
theorem mul_mem_of_two_shifted_mem_from_necSuf (F : Subfield Qbar) (α β : Qbar) (c c' : ℤ)
    (hcc' : c ≠ c')
    (hu : α + β + (c : Qbar) * (α * β) ∈ F) (hu' : α + β + (c' : Qbar) * (α * β) ∈ F) :
    α * β ∈ F :=
  Ising2DLambda.NecSuf.FisherZero.mul_mem_of_two_shifted_mem_necSuf (F : Set Qbar)
    (fun _ _ ha hb => F.sub_mem ha hb) (fun _ _ ha hb => F.div_mem ha hb) α β c c'
    (by exact_mod_cast sub_ne_zero.mpr hcc') (intCast_mem_subfield F (c - c')) hu hu'

/-- `claim_two_shifted_values_determine_sum_and_product` を必要十分版から得る。 -/
theorem add_mem_and_mul_mem_of_two_shifted_mem_from_necSuf (F : Subfield Qbar) (α β : Qbar)
    (c c' : ℤ) (hcc' : c ≠ c')
    (hu : α + β + (c : Qbar) * (α * β) ∈ F) (hu' : α + β + (c' : Qbar) * (α * β) ∈ F) :
    α + β ∈ F ∧ α * β ∈ F :=
  Ising2DLambda.NecSuf.FisherZero.add_mem_and_mul_mem_of_two_shifted_mem_necSuf (F : Set Qbar)
    (fun _ _ ha hb => F.sub_mem ha hb) (fun _ _ ha hb => F.mul_mem ha hb)
    (fun _ _ ha hb => F.div_mem ha hb) α β c c'
    (by exact_mod_cast sub_ne_zero.mpr hcc') (intCast_mem_subfield F (c - c'))
    (intCast_mem_subfield F c) hu hu'

end Ising2DLambda.FisherZero
