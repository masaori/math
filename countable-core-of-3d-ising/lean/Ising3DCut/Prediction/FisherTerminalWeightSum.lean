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

/-- 各外部辺の具体的な分母消去等式は、有限辺集合上の積へ束ねられる。 -/
theorem fisherExternalEdgeWeights_cleared
    {Edge K : Type*} [Field K] (edges : Finset Edge) (x : Edge → K)
    (hDenominator : ∀ edge ∈ edges, 1 - x edge ≠ 0) :
    (∏ edge ∈ edges, (1 - x edge)) *
        (∏ edge ∈ edges, ((1 + x edge) / (1 - x edge))) =
      ∏ edge ∈ edges, (1 + x edge) := by
  calc
    (∏ edge ∈ edges, (1 - x edge)) *
        (∏ edge ∈ edges, ((1 + x edge) / (1 - x edge))) =
      ∏ edge ∈ edges, ((1 - x edge) * ((1 + x edge) / (1 - x edge))) := by
        rw [← Finset.prod_mul_distrib]
    _ = ∏ edge ∈ edges, (1 + x edge) := by
      apply Finset.prod_congr rfl
      intro edge hedge
      exact fisherExternalEdgeWeight_cleared (x edge) (hDenominator edge hedge)

/-- 一つの完全マッチングの外部辺集合が全外部辺集合に含まれるとき、
全外部辺の共通分母 `∏ (1 - x)` を掛けた分母消去後の重みは、
マッチング辺の因子 `1 + x` と非マッチング辺の因子 `1 - x` の積になる。
これは `terminalMatching_clearedWeightSum_eq_evenSubgraph_weightSum` の
仮定 `hClearedWeight` を Fisher の外部辺重みで満たすための接続段である。 -/
theorem fisherMatchingWeight_cleared
    {Edge K : Type*} [Field K] [DecidableEq Edge]
    (allEdges matchEdges : Finset Edge) (hSubset : matchEdges ⊆ allEdges)
    (x : Edge → K)
    (hDenominator : ∀ edge ∈ allEdges, 1 - x edge ≠ 0) :
    (∏ edge ∈ allEdges, (1 - x edge)) *
        (∏ edge ∈ matchEdges, ((1 + x edge) / (1 - x edge))) =
      (∏ edge ∈ matchEdges, (1 + x edge)) *
        ∏ edge ∈ allEdges \ matchEdges, (1 - x edge) := by
  calc
    (∏ edge ∈ allEdges, (1 - x edge)) *
        (∏ edge ∈ matchEdges, ((1 + x edge) / (1 - x edge))) =
      ((∏ edge ∈ allEdges \ matchEdges, (1 - x edge)) *
          ∏ edge ∈ matchEdges, (1 - x edge)) *
        (∏ edge ∈ matchEdges, ((1 + x edge) / (1 - x edge))) := by
      rw [Finset.prod_sdiff hSubset]
    _ = (∏ edge ∈ allEdges \ matchEdges, (1 - x edge)) *
        ((∏ edge ∈ matchEdges, (1 - x edge)) *
          ∏ edge ∈ matchEdges, ((1 + x edge) / (1 - x edge))) := by
      rw [mul_assoc]
    _ = (∏ edge ∈ allEdges \ matchEdges, (1 - x edge)) *
        ∏ edge ∈ matchEdges, (1 + x edge) := by
      rw [fisherExternalEdgeWeights_cleared matchEdges x
        (fun edge hedge ↦ hDenominator edge (hSubset hedge))]
    _ = (∏ edge ∈ matchEdges, (1 + x edge)) *
        ∏ edge ∈ allEdges \ matchEdges, (1 - x edge) := by
      rw [mul_comm]

/-- 全辺集合 `A` の完全マッチング辺集合をその部分集合 `S ⊆ A` として動かすとき、
共通分母 `∏_{e∈A}(1-x e)` を掛けた完全マッチング重み和は、
選ばれていない辺の集合 `F := A \ S` を添字にした偶部分グラフ重み和に一致する。
これが本文 `claim_two_dimensional_boundary_response_pfaffian_prediction` の証明前半にある
有限恒等式（分配法則だけで得る中間等式）の Lean 版である。 -/
theorem fisherBoundaryResponse_clearedWeightSum_eq_evenSubgraphSum
    {Edge K : Type*} [Field K] [DecidableEq Edge]
    (A : Finset Edge) (x : Edge → K)
    (hDenominator : ∀ edge ∈ A, 1 - x edge ≠ 0) :
    (∏ edge ∈ A, (1 - x edge)) *
        (∑ S ∈ A.powerset, ∏ edge ∈ S, ((1 + x edge) / (1 - x edge))) =
      ∑ F ∈ A.powerset, (∏ edge ∈ F, (1 - x edge)) * ∏ edge ∈ A \ F, (1 + x edge) := by
  rw [Finset.mul_sum,
    Finset.sum_congr rfl
      (fun S hS ↦ fisherMatchingWeight_cleared A S (Finset.mem_powerset.mp hS) x hDenominator)]
  refine Finset.sum_nbij' (fun S ↦ A \ S) (fun F ↦ A \ F) ?_ ?_ ?_ ?_ ?_
  · intro S _
    exact Finset.mem_powerset.mpr Finset.sdiff_subset
  · intro F _
    exact Finset.mem_powerset.mpr Finset.sdiff_subset
  · intro S hS
    exact Finset.sdiff_sdiff_eq_self (Finset.mem_powerset.mp hS)
  · intro F hF
    exact Finset.sdiff_sdiff_eq_self (Finset.mem_powerset.mp hF)
  · intro S hS
    rw [Finset.sdiff_sdiff_eq_self (Finset.mem_powerset.mp hS), mul_comm]

end Ising3DCut.Prediction
