import Ising2DLambda.KacWard.AlternatingCycleMatchingSign
import Ising2DLambda.NecSuf.KacWard.AlternatingCycleMatchingSign

namespace Ising2DLambda.KacWard

/-- 二つの独立な隣接対の定義は、具体的な点列では一致する。 -/
theorem pairChunks_eq_consecutivePairs {K : Type*} :
    ∀ c : List K, NecSuf.KacWard.pairChunks c = consecutivePairs c
  | [] => rfl
  | [_] => rfl
  | a :: b :: rest => by
      change (a, b) :: NecSuf.KacWard.pairChunks rest =
        (a, b) :: consecutivePairs rest
      rw [pairChunks_eq_consecutivePairs rest]

end Ising2DLambda.KacWard
