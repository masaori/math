/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.PositiveWeightedSquareSums
import Ising2DLambda.NecSuf.FisherZero.PositiveWeightedSquareSums
import Ising2DLambda.FisherZero.SubfieldPreconeFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の集合は必要十分版の集合を部分体の台集合へ特殊化したものである。 -/
theorem positiveWeightedSquareSums_eq_from_necSuf (E : Subfield Qbar) (CF : Set Qbar) :
    positiveWeightedSquareSums E CF =
      Ising2DLambda.NecSuf.FisherZero.weightedSquareSums (E : Set Qbar) CF := rfl

/-- `claim_positive_weighted_square_sums_is_precone` を必要十分版から得る。
係数の集合の単位元の所属は、具体版の段 `one_mem_of_isSubfieldPositiveCone` から渡す。 -/
theorem positiveWeightedSquareSums_isSubfieldPrecone_from_necSuf (F E : Subfield Qbar)
    (CF : Set Qbar) (hFE : ∀ z : Qbar, z ∈ F → z ∈ E) (hCF : IsSubfieldPositiveCone F CF) :
    IsSubfieldPrecone F E CF (positiveWeightedSquareSums E CF) :=
  (isSubfieldPrecone_iff_from_necSuf F E CF _).mpr ⟨hFE, hCF,
    Ising2DLambda.NecSuf.FisherZero.weightedSquareSums_isPreconeOn_necSuf (E : Set Qbar) CF
      E.zero_mem E.one_mem (fun _ _ hx hy => E.add_mem hx hy)
      (fun _ _ hx hy => E.mul_mem hx hy) (fun c hc => hFE c (hCF.subset c hc))
      (one_mem_of_isSubfieldPositiveCone F CF hCF) hCF.mul_mem⟩

end Ising2DLambda.FisherZero
