import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordMap

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard (trichotomous_of_linearOrder)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- A complete endpoint word and its image have signs related by the sign of the map. -/
theorem matchingPairWordSignMap_necSuf (σ : Equiv.Perm J) (first second : List J)
    (hcomplete : IsCompleteWord first) (hmap : second = first.map σ) :
    matchingWordSign second =
      sign (fun x y : J => x < y) σ * matchingWordSign first := by
  rw [hmap, matchingWordSign_eq _ (completeWord_map first hcomplete σ),
    matchingWordPermutation_map, sign_comp _ trichotomous_of_linearOrder,
    matchingWordSign_eq _ hcomplete]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
