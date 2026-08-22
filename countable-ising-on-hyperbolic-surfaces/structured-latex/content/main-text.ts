import { hyperbolicFiniteGraphConnection } from "../../../finite-graph-ising-partition-polynomial-and-fisher-zeros/structured-latex/content/main-text.ts";

// 双曲曲面固有本文の 21 個の参照出現が要求する内容名ラベルと、その推移的依存閉包。
// 一般有限グラフ理論の正本でブロックを追加・並べ替えても、この集合の意味は変わらない。
export default [
  hyperbolicFiniteGraphConnection.heading,
  hyperbolicFiniteGraphConnection.edgeEndpointLabels,
  hyperbolicFiniteGraphConnection.finiteGraphInput,
  hyperbolicFiniteGraphConnection.spinLabels,
  hyperbolicFiniteGraphConnection.spinReversal,
  hyperbolicFiniteGraphConnection.spinConfigurations,
  hyperbolicFiniteGraphConnection.brokenEdgeSet,
  hyperbolicFiniteGraphConnection.brokenEdgeMultiplicity,
  hyperbolicFiniteGraphConnection.isingPartitionPolynomial,
  hyperbolicFiniteGraphConnection.partitionPolynomialCoefficientExpansion,
  hyperbolicFiniteGraphConnection.modTwoBoundaryParity,
  hyperbolicFiniteGraphConnection.evenEdgeSubset,
  hyperbolicFiniteGraphConnection.evenSubgraphPolynomial,
] as const;
