# 正則型の双曲型判定の検算

**対象ラベル**: `def_finite_cellulation_hyperbolic_regular_type`

## 対象

- 構造化本文: 「正則型の双曲型判定」
- 検算範囲: 正則型述語と有理不等式 `1/p + 1/q < 1/2` の連言
- 帰属: 自然数、有理数、真偽値。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | `{3,7}` と `{4,5}` を受理し、等号二例、球面型一例、正則型述語が偽の一例を拒否する | PASS | 六つの厳密な `QQ` 比較で期待する真偽値と一致した |

実行日: 2026-08-15

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-cellulation-hyperbolic-regular-type/check.sage
```
