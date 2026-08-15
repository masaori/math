# F_2 上の一次境界写像の検算

**対象ラベル**: `def_first_boundary_matrix_over_f2`

## 対象

- 構造化本文: 「F_2 上の一次境界写像」
- 検算範囲: 辺端ラベルから作る有限 incidence 行列と、その行列積が与える各頂点の境界偶奇
- 帰属: 形式的な有限ラベル集合と `GF(2)` 上の有限行列。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | 三角形の incidence 行列を陽に照合し、全ての辺部分集合について行列積と端点の直接計数を比較する | PASS | 八つの辺部分集合で一致した |

実行日: 2026-08-15

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/first-boundary-matrix-over-f2/check.sage
```
