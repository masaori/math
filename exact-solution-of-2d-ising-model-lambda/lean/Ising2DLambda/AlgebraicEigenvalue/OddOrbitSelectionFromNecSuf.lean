import Ising2DLambda.AlgebraicEigenvalue.OddOrbitSelection
import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalOrbitFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.LeastFeatureSelection

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

theorem invariantSubsetReversal_oddOrbitPoints_from_necSuf (C : Finset J)
    (σ : Equiv.Perm J) (hC : ∀ j, σ j ∈ C ↔ j ∈ C) :
    oddOrbitPoints (invariantSubsetReversal C σ hC) = oddOrbitPoints σ := by
  classical
  simpa only [oddOrbitPoints, featurePoints] using featurePoints_eq_necSuf Finset.univ
    (finitePermutationOrbitLength (invariantSubsetReversal C σ hC))
    (finitePermutationOrbitLength σ) Odd
    (fun j _ => invariantSubsetReversal_orbitLength_from_necSuf C σ hC j)

theorem invariantSubsetReversal_oddOrbitPoints_nonempty_from_necSuf (C : Finset J)
    (σ : Equiv.Perm J) (hC : ∀ j, σ j ∈ C ↔ j ∈ C)
    (hσ : (oddOrbitPoints σ).Nonempty) :
    (oddOrbitPoints (invariantSubsetReversal C σ hC)).Nonempty := by
  classical
  simpa only [oddOrbitPoints, featurePoints] using featurePoints_nonempty_necSuf Finset.univ
    (finitePermutationOrbitLength (invariantSubsetReversal C σ hC))
    (finitePermutationOrbitLength σ) Odd
    (fun j _ => invariantSubsetReversal_orbitLength_from_necSuf C σ hC j)
    (by simpa only [oddOrbitPoints, featurePoints] using hσ)

theorem invariantSubsetReversal_leastOddOrbitPoint_from_necSuf (C : Finset J)
    (σ : Equiv.Perm J) (hC : ∀ j, σ j ∈ C ↔ j ∈ C)
    (hσ : (oddOrbitPoints σ).Nonempty)
    (hρ : (oddOrbitPoints (invariantSubsetReversal C σ hC)).Nonempty) :
    leastOddOrbitPoint (invariantSubsetReversal C σ hC) hρ =
      leastOddOrbitPoint σ hσ := by
  classical
  simpa only [leastOddOrbitPoint, leastFeaturePoint, oddOrbitPoints, featurePoints] using
    leastFeaturePoint_eq_necSuf Finset.univ
    (finitePermutationOrbitLength (invariantSubsetReversal C σ hC))
    (finitePermutationOrbitLength σ) Odd
    (fun j _ => invariantSubsetReversal_orbitLength_from_necSuf C σ hC j)
    (by simpa only [oddOrbitPoints, featurePoints] using hρ)
    (by simpa only [oddOrbitPoints, featurePoints] using hσ)

theorem invariantSubsetReversal_selectedOddOrbit_from_necSuf (C : Finset J)
    (σ : Equiv.Perm J) (hC : ∀ j, σ j ∈ C ↔ j ∈ C)
    (hσ : (oddOrbitPoints σ).Nonempty)
    (hρ : (oddOrbitPoints (invariantSubsetReversal C σ hC)).Nonempty) :
    selectedOddOrbit (invariantSubsetReversal C σ hC) hρ = selectedOddOrbit σ hσ := by
  classical
  simpa only [selectedOddOrbit, selectedFeatureValue, leastOddOrbitPoint,
    leastFeaturePoint, oddOrbitPoints, featurePoints] using selectedFeatureValue_eq_necSuf Finset.univ
    (finitePermutationOrbitLength (invariantSubsetReversal C σ hC))
    (finitePermutationOrbitLength σ) Odd
    (finitePermutationOrbit (invariantSubsetReversal C σ hC)) (finitePermutationOrbit σ)
    (fun j _ => invariantSubsetReversal_orbitLength_from_necSuf C σ hC j)
    (fun j _ => invariantSubsetReversal_orbit_from_necSuf C σ hC j)
    (by simpa only [oddOrbitPoints, featurePoints] using hρ)
    (by simpa only [oddOrbitPoints, featurePoints] using hσ)

end Ising2DLambda.AlgebraicEigenvalue
