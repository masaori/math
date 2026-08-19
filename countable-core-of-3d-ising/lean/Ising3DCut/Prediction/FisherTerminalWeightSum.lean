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

/-- Fisher terminal graph の全完全マッチング重み和へ共通分母を掛けたとき、
各完全マッチングの分母消去後の重みが対応する偶部分グラフの重みに等しければ、
分母消去後の有限和全体も偶部分グラフの重み和に等しい。 -/
theorem terminalMatching_clearedWeightSum_eq_evenSubgraph_weightSum
    {Matching EvenSubgraph R : Type*}
    [Fintype Matching] [Fintype EvenSubgraph] [CommRing R]
    (encode : Matching ≃ EvenSubgraph)
    (matchingWeight : Matching → R) (evenSubgraphWeight : EvenSubgraph → R)
    (commonDenominator : R)
    (hClearedWeight : ∀ matching,
      commonDenominator * matchingWeight matching = evenSubgraphWeight (encode matching)) :
    commonDenominator * ∑ matching, matchingWeight matching =
      ∑ evenSubgraph, evenSubgraphWeight evenSubgraph := by
  rw [Finset.mul_sum]
  exact terminalMatching_weightSum_eq_evenSubgraph_weightSum
    encode
    (fun matching ↦ commonDenominator * matchingWeight matching)
    evenSubgraphWeight
    hClearedWeight

end Ising3DCut.Prediction
