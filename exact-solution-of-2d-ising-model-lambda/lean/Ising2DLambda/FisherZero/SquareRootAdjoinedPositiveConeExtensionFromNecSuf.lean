import Ising2DLambda.FisherZero.SquareRootAdjoinedPositiveConeExtension
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.SquareRootAdjoinedPositiveConeExtension

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- Specialization of the abstract cone extension to the quadratic subfield of algebraic numbers. -/
theorem squareRootAdjoined_positiveCone_extension_from_necSuf
    (F : Subfield Qbar) (CF : Set Qbar) (hCF : IsSubfieldPositiveCone F CF)
    (a b : Qbar) (ha : a ∈ CF) (hb : b * b = a) (hbF : b ∉ F) :
    ∃ CE : Set Qbar,
      ExtendsPositiveCone F
        (Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar))) CF CE := by
  set E : Subfield Qbar := Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) with hE
  obtain ⟨ξ, hξ⟩ := algebraicNumbersEnumeration
  have hFE : ∀ z : Qbar, z ∈ F → z ∈ E := by
    intro z hz
    exact Subfield.subset_closure (Set.mem_union_left _ hz)
  obtain ⟨CE, hCE⟩ :=
    Ising2DLambda.NecSuf.FisherZero.weightedSquareSums_positiveCone_extension
      (F : Set Qbar) (E : Set Qbar) CF E.zero_mem E.one_mem
      (fun _ _ hx hy => E.add_mem hx hy) (fun _ _ hx hy => E.mul_mem hx hy)
      (fun _ hx => E.neg_mem hx) (fun _ hz _ => E.inv_mem hz)
      hFE ((isSubfieldPositiveCone_iff_from_necSuf F CF).mp hCF) F.one_mem
      (squareRootAdjoinedWeightedSquareSum_ne_neg_one F CF hCF a b ha hb hbF)
      ξ (fun z _ => hξ z)
  exact ⟨CE, (extendsPositiveCone_iff_from_necSuf F E CF CE).mpr hCE⟩

end Ising2DLambda.FisherZero
