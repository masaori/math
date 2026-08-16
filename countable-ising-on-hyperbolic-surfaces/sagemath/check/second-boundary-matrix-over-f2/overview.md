# F_2 上の二次境界写像の検算

**対象ラベル**: `def_second_boundary_matrix_over_f2`

## 対象

- 構造化本文: 「F_2 上の二次境界写像」
- 検算範囲: 面境界の有限位置から作る辺・面 incidence 行列と、その行列積が与える各辺の出現回数の偶奇
- 帰属: 形式的な有限ラベル集合と `GF(2)` 上の有限行列。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | 逆向きの同じ三角形二面と、同じ辺が二回現れる面について行列を陽に照合し、全ての面部分集合で行列積と境界位置の直接計数を比較する | PASS | 八つの面部分集合で一致した |

実行日: 2026-08-16

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/second-boundary-matrix-over-f2/check.sage
```
