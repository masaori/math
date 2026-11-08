# SageMath Check: 右向き双対路の高さの左端での零

**対象ラベル**: `claim_plane_dual_ray_height_zero_left`

頂点の偶数次数を満たす有限辺集合について、左端の横辺の不在、隣接行の高さの一致、有限台の外の行の高さ零、全行での高さ零を整数の偶奇で確認する。

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check_row_constant.sage` | 左端での隣接行の高さの一致 | PASS（80例） |
| `check_left_zero.sage` | 台の外の行から全行への零の伝播 | PASS（240例） |

- 実行: `sage sagemath/check/plane-dual-ray-height-left-bound/check.sage`
- 状態: 2026-11-08、SageMath 本体で有限格子の偶辺集合16例を実行し PASS。
- 計算: 整数と有限集合のみ。実数への脱出は無い。
