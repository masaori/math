# 有限セル分割データの双曲正則型集合の検算

**対象ラベル**: `def_finite_cellulation_hyperbolic_regular_type_set`

## 対象

- 構造化本文: 「有限セル分割データの双曲正則型集合」
- 検算範囲: 正則型集合から自然数不等式 `2(p+q) < pq` を満たす順序対だけを残す部分集合
- 帰属: 自然数の有限集合。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | `{(3,7)}` と `{(4,5)}` を保ち、等号二例と球面型一例を空集合へ送り、空の正則型集合も空集合へ送る | PASS | 自然数上の厳密比較で期待する有限集合と一致した |

実行日: 2026-08-22

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-cellulation-hyperbolic-regular-type/check.sage
```
