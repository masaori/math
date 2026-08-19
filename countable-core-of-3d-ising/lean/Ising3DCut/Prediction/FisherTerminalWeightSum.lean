import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising3DCut.Prediction

open scoped BigOperators

/-- Fisher terminal graph の完全マッチングと偶部分グラフの有限全単射が
各項の重みを保つなら、二つの重み和は一致する。 -/
theorem terminalMatching_weightSum_eq_evenSubgraph_weightSum
    {Matching EvenSubgraph R : Type*}
    [Fintype Matching] [Fintype EvenSubgraph] [CommRing R]
    (encode : Matching ≃ EvenSubgraph)
    (matchingWeight : Matching → R) (evenSubgraphWeight : EvenSubgraph → R)
    (hWeight : ∀ matching, matchingWeight matching = evenSubgraphWeight (encode matching)) :
    ∑ matching, matchingWeight matching = ∑ evenSubgraph, evenSubgraphWeight evenSubgraph := by
  calc
    ∑ matching, matchingWeight matching =
        ∑ matching, evenSubgraphWeight (encode matching) :=
      Finset.sum_congr rfl fun matching _ ↦ hWeight matching
    _ = ∑ evenSubgraph, evenSubgraphWeight evenSubgraph := encode.sum_comp evenSubgraphWeight

end Ising3DCut.Prediction
