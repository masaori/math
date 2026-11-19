import Ising2DLambda.NecSuf.FisherZero.PositiveWeightedSquareSums
import Ising2DLambda.NecSuf.FisherZero.EnumeratedPreconeChain
import Ising2DLambda.NecSuf.FisherZero.CoveringPreconePositiveCone
import Ising2DLambda.NecSuf.FisherZero.OnePlusWeightedSquareSumEvenDegree

namespace Ising2DLambda.NecSuf.FisherZero

/-- The extension step uses only a field, a cone, and the absence of `-1` from weighted squares. -/
theorem weightedSquareSums_positiveCone_extension
    {K : Type} [Field K] (F E C : Set K)
    (hE0 : (0 : K) ∈ E) (hE1 : (1 : K) ∈ E)
    (hEadd : ∀ x y : K, x ∈ E → y ∈ E → x + y ∈ E)
    (hEmul : ∀ x y : K, x ∈ E → y ∈ E → x * y ∈ E)
    (hEneg : ∀ x : K, x ∈ E → -x ∈ E)
    (hEinv : ∀ z : K, z ∈ E → z ≠ 0 → z⁻¹ ∈ E)
    (hFE : ∀ z : K, z ∈ F → z ∈ E)
    (hC : IsPositiveConeOn F C) (hF1 : (1 : K) ∈ F)
    (hneg : (-1 : K) ∉ weightedSquareSums E C)
    (ξ : ℕ → K) (hξ : ∀ z : K, z ∈ E → ∃ n : ℕ, ξ n = z) :
    ∃ CE : Set K, ExtendsPositiveConeOn F E C CE := by
  have hC1 : (1 : K) ∈ C := by
    have hsq := mul_self_mem_of_cover_necSuf C hC.mul_mem 1
      (hC.trichotomy 1 hF1).1 one_ne_zero
    simpa using hsq
  have hT : IsPreconeOn E C (weightedSquareSums E C) :=
    weightedSquareSums_isPreconeOn_necSuf E C hE0 hE1 hEadd hEmul
      (fun c hc => hFE c (hC.subset c hc)) hC1 hC.mul_mem
  obtain ⟨hT', hneg', hcov⟩ :=
    chainUnion_covers_signs_necSuf E C (weightedSquareSums E C)
      hE0 hE1 hEadd hEmul hEneg hT hneg ξ hξ
  exact ⟨nonzeroPart (chainUnion E (weightedSquareSums E C) ξ),
    coveringPrecone_extendsPositiveConeOn_necSuf F E C _
      hE0 hEinv hFE hC hT' hneg' hcov⟩

end Ising2DLambda.NecSuf.FisherZero
