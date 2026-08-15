# 有限セル分割の Euler 標数の検算

**対象ラベル**: `def_finite_cellulation_euler_characteristic`

## 対象

- 構造化本文: 「有限セル分割の Euler 標数」
- 検算範囲: 頂点数から辺数を引き面数を加える整数値の定義
- 帰属: 有限集合、自然数、整数。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | 二面三角形の球面と `3 x 3` 周期正方格子トーラスの Euler 標数を整数演算で計算する | PASS | 球面で `2`、トーラスで `0` |

実行日: 2026-08-15

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-cellulation-euler-characteristic/check.sage
```
