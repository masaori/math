/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。
差の閉性は `F.sub_mem`、`γβ = βγ` は Qbar の積の可換性 `mul_comm` から渡す。 -/
import Ising2DLambda.FisherZero.SumInSubfieldRootGivesBothNumbers
import Ising2DLambda.NecSuf.FisherZero.SumInSubfieldRootGivesBothNumbers

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_sum_in_subfield_root_gives_both_numbers` を必要十分版から得る。 -/
theorem mem_and_mem_of_sum_mem_of_root_mem_from_necSuf (F : Subfield Qbar) (α β γ : Qbar)
    (hsum : α + β ∈ F) (hγ : γ ∈ F)
    (hroot : γ * γ - (α + β) * γ + α * β = 0) :
    α ∈ F ∧ β ∈ F :=
  Ising2DLambda.NecSuf.FisherZero.mem_and_mem_of_sum_mem_of_root_mem_necSuf (F : Set Qbar)
    (fun _ _ ha hb => F.sub_mem ha hb) α β γ (mul_comm γ β) hsum hγ hroot

end Ising2DLambda.FisherZero
