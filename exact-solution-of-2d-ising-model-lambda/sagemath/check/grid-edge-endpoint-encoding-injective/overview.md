# SageMath Check: 格子辺の端点集合による符号化

**対象ラベル**: `claim_grid_edge_endpoint_encoding_injective`

向きと始点の異なる単位格子辺が同じ端点集合を持たないことを、整数座標 $-4$ から $4$ の 162 辺で確認する。これは有限例の検算であり、全整数についての証明は本文と Lean が担う。

- 実行: `sage sagemath/check/grid-edge-endpoint-encoding-injective/check.sage`
- 状態: PASS（2026-11-10）。162 辺の端点集合がすべて相異なる。
- 計算: `ZZ` の整数加算と有限集合の等号のみ。浮動小数点を使わない。
