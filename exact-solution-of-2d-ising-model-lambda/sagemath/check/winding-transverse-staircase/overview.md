# SageMath Check: 巻き付きベクトルの横断階段

**対象ラベル**: `claim_winding_transverse_staircase_step_increase`

$L=1,2,3$ の非零巻き付きの頂点単純な閉じた非後退辺列について、正の横断階段の各差が
四つの単位格子ベクトルのいずれかであり、整数横断座標が各歩で真に増えることを `ZZ` で検査する。
始点・終点と頂点の相異なりも同時に確かめる。

- 実行: `sage sagemath/check/winding-transverse-staircase/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付きの頂点単純閉路 3,464 本に対する横断階段 5,008 歩を全列挙した。
- 計算: 有限列挙、整数の絶対値・場合分け・四則と順序だけ。浮動小数点は使わない。
