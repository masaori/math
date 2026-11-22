import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordMap

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- A complete endpoint word and its image have signs related by the sign of the map. -/
theorem matchingPairWordSignMap_necSuf (σ : Equiv.Perm J) (first second : List J)
    (hcomplete : IsCompleteWord first) (hmap : second = first.map σ) :
    matchingWordSign second =
      sign (fun x y : J => x < y) σ * matchingWordSign first := by
  rw [hmap]
  exact matchingWordSign_map first hcomplete σ

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
