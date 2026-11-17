/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SubfieldPositiveCone
import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の正錐は、必要十分版の正錐を部分体の台集合へ特殊化したものと同値である。 -/
theorem isSubfieldPositiveCone_iff_from_necSuf (F : Subfield Qbar) (C : Set Qbar) :
    IsSubfieldPositiveCone F C ↔
      Ising2DLambda.NecSuf.FisherZero.IsPositiveConeOn (F : Set Qbar) C := by
  constructor
  · intro h
    exact ⟨h.subset, h.add_mem, h.mul_mem, h.trichotomy⟩
  · intro h
    exact ⟨h.subset, h.add_mem, h.mul_mem, h.trichotomy⟩

/-- 具体版の正錐の延長は、必要十分版の延長を部分体の台集合へ特殊化したものと同値である。 -/
theorem extendsPositiveCone_iff_from_necSuf (F E : Subfield Qbar) (CF CE : Set Qbar) :
    ExtendsPositiveCone F E CF CE ↔
      Ising2DLambda.NecSuf.FisherZero.ExtendsPositiveConeOn
        (F : Set Qbar) (E : Set Qbar) CF CE := by
  constructor
  · intro h
    exact ⟨h.subfield_le, (isSubfieldPositiveCone_iff_from_necSuf F CF).mp h.cone_F,
      (isSubfieldPositiveCone_iff_from_necSuf E CE).mp h.cone_E, h.inter_eq⟩
  · intro h
    exact ⟨h.subset_le, (isSubfieldPositiveCone_iff_from_necSuf F CF).mpr h.cone_F,
      (isSubfieldPositiveCone_iff_from_necSuf E CE).mpr h.cone_E, h.inter_eq⟩

end Ising2DLambda.FisherZero
