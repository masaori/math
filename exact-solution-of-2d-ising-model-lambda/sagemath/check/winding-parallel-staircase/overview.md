# SageMath Check: 巻き付きベクトルの平行階段

**対象ラベル**: `claim_winding_parallel_staircase_step_increase`

$L=1,2,3$ の非零巻き付きの頂点単純な閉じた非後退辺列について、正の平行階段の各差が
四つの単位格子ベクトルのいずれかであり、平行座標が各歩で真に増えることを `ZZ` で検査する。
始点が $(0,0)$、終点が一周期の並進ベクトル $(Lw_{\mathrm v},Lw_{\mathrm h})$ であること、
全頂点の相異なりも同時に確かめる。

- 実行: `sage sagemath/check/winding-parallel-staircase/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付きの頂点単純閉路 3,464 本に対する平行階段 14,872 歩を全列挙した。
- 計算: 有限列挙、整数の絶対値・場合分け・四則と順序だけ。浮動小数点は使わない。
