# 有限セル分割の正則型の検算

**対象ラベル**: `def_finite_cellulation_regular_type`

## 対象

- 構造化本文: 「有限セル分割の正則型」
- 検算範囲: 各面の辺出現数が `p`、各頂点の角出現数が `q` であり、向き付け閉曲面述語を満たすという有限述語
- 帰属: 辺端・向き・位置の各形式的ラベルからなる有限集合、自然数、真偽値。向きラベルに整数演算を入れず、浮動小数点と非可算集合も使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | 二面三角形の球面を正則型 `{3,2}` として受理し、面 incidence、頂点 incidence、向き付け閉曲面条件の各不一致を拒否する | PASS | 四つの有限入力で期待する真偽値と一致した |

実行日: 2026-08-15

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-cellulation-regular-type/check.sage
```
