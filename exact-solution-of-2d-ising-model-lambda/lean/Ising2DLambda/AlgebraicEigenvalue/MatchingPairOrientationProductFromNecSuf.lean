/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrientationProduct` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrientationProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrientationProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- Derivation of the concrete statements from the ring argument. -/
theorem matchingPairOrientationProduct_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar))
    (hA : ∀ i j, A j i = -A i j) :
    (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ), A i (τ.val i)) =
      (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ),
        concreteOrientationFactor τ.val i) *
      (∏ p ∈ (Finset.univ.filter (· ∈ matchingPairColor τ υ)).image
        (concreteAscendingMatePair τ.val), A p.1 p.2) := by
  classical
  have hPair : concreteAscendingMatePair τ.val =
      NecSuf.AlgebraicEigenvalue.ascendingMatePair τ.val := by
    funext i
    rfl
  have hFactor : concreteOrientationFactor τ.val =
      (NecSuf.AlgebraicEigenvalue.orientationFactor τ.val : J → Polynomial Qbar) := by
    funext i
    rfl
  rw [hPair, hFactor]
  apply NecSuf.AlgebraicEigenvalue.orientationProduct_necSuf
  · intro i
    simp only [Finset.mem_filter, Finset.mem_univ, true_and]
    exact matchingPairColor_alternates τ υ i
  · exact hA

end Ising2DLambda.AlgebraicEigenvalue
