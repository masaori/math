import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Field.Basic

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

/-- Fisher terminal graph の元の辺に置く重み `(1 + x) / (1 - x)` は、
対応する分母 `1 - x` を掛けると整数係数の因子 `1 + x` へ戻る。 -/
theorem fisherExternalEdgeWeight_cleared
    {K : Type*} [Field K] (x : K) (hDenominator : 1 - x ≠ 0) :
    (1 - x) * ((1 + x) / (1 - x)) = 1 + x := by
  exact mul_div_cancel₀ (1 + x) hDenominator

end Ising3DCut.Prediction
