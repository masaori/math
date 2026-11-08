# SageMath Check: 右向き双対路の高さ一の列の有限台

**対象ラベル**: `claim_plane_dual_ray_height_finite_column_support`

有限セル集合の境界から得る偶辺集合について、最小列より左側と最大列以右の高さが零であり、高さ一の列が有限整数区間に含まれることを厳密な整数の偶奇で検査する。

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 3×3 セルの全部分集合 512 例の列境界 | PASS |

- 実行: `sage sagemath/check/plane-dual-ray-height-column-support/check.sage`
- 状態: 2026-11-08、SageMath 本体で実行して PASS。
- 計算: 整数と有限集合のみ。実数への脱出は無い。
