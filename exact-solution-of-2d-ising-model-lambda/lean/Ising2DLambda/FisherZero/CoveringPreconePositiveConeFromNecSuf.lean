/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.CoveringPreconePositiveCone
import Ising2DLambda.NecSuf.FisherZero.CoveringPreconePositiveCone
import Ising2DLambda.FisherZero.SubfieldPreconeFromNecSuf
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_precone_avoiding_minus_one_meets_negation_at_zero` を必要十分版から得る。 -/
theorem precone_zero_mem_and_eq_zero_of_mem_neg_from_necSuf (F E : Subfield Qbar)
    (CF T : Set Qbar) (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) :
    (0 : Qbar) ∈ T ∧ ∀ z : Qbar, z ∈ T → -z ∈ T → z = 0 := by
  obtain ⟨_, _, hT'⟩ := (isSubfieldPrecone_iff_from_necSuf F E CF T).mp hT
  exact Ising2DLambda.NecSuf.FisherZero.precone_zero_mem_and_eq_zero_of_mem_neg_necSuf
    (E : Set Qbar) CF T E.zero_mem (fun _ hz _ => E.inv_mem hz) hT' hneg

/-- 具体版の `preconeNonzeroPart` は必要十分版の `nonzeroPart` と同じ集合である。 -/
theorem preconeNonzeroPart_eq_nonzeroPart (T : Set Qbar) :
    preconeNonzeroPart T = Ising2DLambda.NecSuf.FisherZero.nonzeroPart T := rfl

/-- `claim_covering_precone_gives_positive_cone_extension` を必要十分版から得る。 -/
theorem coveringPrecone_extendsPositiveCone_from_necSuf (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T)
    (hcov : ∀ z : Qbar, z ∈ E → z ∈ T ∨ -z ∈ T) :
    ExtendsPositiveCone F E CF (preconeNonzeroPart T) := by
  obtain ⟨hle, hcone, hT'⟩ := (isSubfieldPrecone_iff_from_necSuf F E CF T).mp hT
  rw [extendsPositiveCone_iff_from_necSuf, preconeNonzeroPart_eq_nonzeroPart]
  exact Ising2DLambda.NecSuf.FisherZero.coveringPrecone_extendsPositiveConeOn_necSuf
    (F : Set Qbar) (E : Set Qbar) CF T E.zero_mem (fun _ hz _ => E.inv_mem hz) hle
    ((isSubfieldPositiveCone_iff_from_necSuf F CF).mp hcone) hT' hneg hcov

end Ising2DLambda.FisherZero
