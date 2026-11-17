/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SubfieldPrecone
import Ising2DLambda.NecSuf.FisherZero.SubfieldPrecone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の前錐は、本文の前提（`F ⊆ E`、`CF` は `F` の正錐）と、必要十分版の前錐を
部分体の台集合へ特殊化したものとの組に同値である。 -/
theorem isSubfieldPrecone_iff_from_necSuf (F E : Subfield Qbar) (CF T : Set Qbar) :
    IsSubfieldPrecone F E CF T ↔
      ((∀ z : Qbar, z ∈ F → z ∈ E) ∧ IsSubfieldPositiveCone F CF ∧
        Ising2DLambda.NecSuf.FisherZero.IsPreconeOn (E : Set Qbar) CF T) := by
  constructor
  · intro h
    exact ⟨h.subfield_le, h.cone_F,
      ⟨h.subset, h.add_mem, h.mul_mem, h.sq_mem, h.cone_subset⟩⟩
  · rintro ⟨hle, hcone, h⟩
    exact ⟨hle, hcone, h.subset, h.add_mem, h.mul_mem, h.sq_mem, h.cone_subset⟩

/-- 具体版の集合 `preconeAdjoin` は必要十分版の `adjoinSet` と同じ集合である。 -/
theorem preconeAdjoin_eq_adjoinSet (T : Set Qbar) (a : Qbar) :
    preconeAdjoin T a = Ising2DLambda.NecSuf.FisherZero.adjoinSet T a := rfl

/-- `claim_precone_adjoin_element_is_precone` を必要十分版から得る。 -/
theorem preconeAdjoin_isSubfieldPrecone_from_necSuf (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (a : Qbar) (ha : a ∈ E) :
    IsSubfieldPrecone F E CF (preconeAdjoin T a) ∧
      (∀ t : Qbar, t ∈ T → t ∈ preconeAdjoin T a) ∧ a ∈ preconeAdjoin T a := by
  obtain ⟨hle, hcone, hT'⟩ := (isSubfieldPrecone_iff_from_necSuf F E CF T).mp hT
  obtain ⟨hP, hincl, hself⟩ :=
    Ising2DLambda.NecSuf.FisherZero.preconeAdjoin_isPreconeOn_necSuf (E : Set Qbar) CF T
      E.zero_mem E.one_mem (fun _ _ hx hy => E.add_mem hx hy)
      (fun _ _ hx hy => E.mul_mem hx hy) hT' a ha
  exact ⟨(isSubfieldPrecone_iff_from_necSuf F E CF _).mpr ⟨hle, hcone, hP⟩, hincl, hself⟩

/-- `claim_precone_adjoin_one_side_avoids_minus_one` を必要十分版から得る。 -/
theorem neg_one_not_mem_preconeAdjoin_or_from_necSuf (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) (a : Qbar) (ha : a ∈ E) :
    (-1 : Qbar) ∉ preconeAdjoin T a ∨ (-1 : Qbar) ∉ preconeAdjoin T (-a) :=
  Ising2DLambda.NecSuf.FisherZero.neg_one_not_mem_adjoin_or_necSuf T hT.add_mem hT.mul_mem
    hneg a (hT.sq_mem a ha)

end Ising2DLambda.FisherZero
