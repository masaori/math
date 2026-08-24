# 積差十一をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_eleven_hyperbolic_types`

## 対象

- 構造化本文: 「積差十一をもつ双曲正則型の分類」
- 検算範囲: 十一の全正因子対、次数対の復元、双曲不等式、整数積差
- 帰属: 因子対と次数対は `NN`、標準単射後の積差は `ZZ`。除算、実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_classification.sage` | 十一の全正因子対を次数対へ移し、双曲性と積差を照合する | PASS | 正因子対は `(1,11)`, `(11,1)`、次数対は `(3,13)`, `(13,3)` に一致 |

## 実行履歴

- 2026-08-24: リポジトリ直下から実行し、終了コード `0` で完了した。

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-eleven-hyperbolic-types/check_classification.sage
```
