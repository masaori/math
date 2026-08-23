# 積差六をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_six_hyperbolic_types`

## 対象

- 構造化本文: 「積差六をもつ双曲正則型の分類」
- 検算範囲: 六の全正因子対、次数対の復元、双曲不等式、整数積差
- 帰属: 因子対と次数対は `NN`、標準単射後の積差は `ZZ`。除算、実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_classification.sage` | 六の全正因子対を次数対へ移し、双曲性と積差を照合する | PASS | 正因子対は `(1,6)`, `(2,3)`, `(3,2)`, `(6,1)`、次数対は `(3,8)`, `(4,5)`, `(5,4)`, `(8,3)` に一致 |

## 実行履歴

- 2026-08-24: リポジトリ直下から実行し、終了コード `0` で完了した。

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-six-hyperbolic-types/check_classification.sage
```
