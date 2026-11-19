import Ising2DLambda.FisherZero.SquareRootAdjoinedWeightedSquareSumExcludesMinusOne
import Ising2DLambda.FisherZero.PositiveWeightedSquareSums
import Ising2DLambda.FisherZero.EnumeratedPreconeChain
import Ising2DLambda.FisherZero.CoveringPreconePositiveCone
import Ising2DLambda.AlgebraicEigenvalue.AlgebraicNumbersEnumeration

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- A positive square root can be adjoined while extending the given positive cone. -/
theorem squareRootAdjoined_positiveCone_extension (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) (a b : Qbar) (ha : a ∈ CF)
    (hb : b * b = a) (hbF : b ∉ F) :
    ∃ CE : Set Qbar,
      ExtendsPositiveCone F
        (Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar))) CF CE := by
  set E : Subfield Qbar := Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) with hE
  have hFE : ∀ z : Qbar, z ∈ F → z ∈ E := by
    intro z hz
    exact Subfield.subset_closure (Set.mem_union_left _ hz)
  have hT : IsSubfieldPrecone F E CF (positiveWeightedSquareSums E CF) :=
    positiveWeightedSquareSums_isSubfieldPrecone F E CF hFE hCF
  have hneg : (-1 : Qbar) ∉ positiveWeightedSquareSums E CF :=
    squareRootAdjoinedWeightedSquareSum_ne_neg_one F CF hCF a b ha hb hbF
  obtain ⟨ξ, hξ⟩ := algebraicNumbersEnumeration
  obtain ⟨hT', hneg', hcov⟩ :=
    preconeChainUnion_covers_signs F E CF (positiveWeightedSquareSums E CF) hT hneg ξ hξ
  exact ⟨preconeNonzeroPart (preconeChainUnion E (positiveWeightedSquareSums E CF) ξ),
    coveringPrecone_extendsPositiveCone F E CF _ hT' hneg' hcov⟩

end Ising2DLambda.FisherZero
