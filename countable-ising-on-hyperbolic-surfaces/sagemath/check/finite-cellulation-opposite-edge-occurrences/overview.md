# 辺の逆向き二回出現述語の検算

**対象ラベル**: `def_finite_cellulation_opposite_edge_occurrences`

## 対象

- 構造化本文: 「辺の逆向き二回出現」
- 検算範囲: 各辺の出現回数が二回であり、二つの形式的向きラベルが反転写像で対応するという有限述語
- 帰属: 位置ラベルと向きラベルの有限集合、真偽値。整数の符号演算、浮動小数点、非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | 反対向きに貼った二面三角形を受理し、同方向・出現不足・四回出現を拒否する | PASS | 四つの有限入力で期待する真偽値と一致した |

実行日: 2026-08-15

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-cellulation-opposite-edge-occurrences/check.sage
```
