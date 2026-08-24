# 積差十四をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_fourteen_hyperbolic_types`

## 対象

- 構造化本文: 「積差十四をもつ双曲正則型の分類」
- 検算範囲: 十四の全正因子対、次数対の復元、双曲不等式、整数積差
- 帰属: 因子対と次数対は `NN`、標準単射後の積差は `ZZ`。除算、実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_classification.sage` | 十四の全正因子対を次数対へ移し、双曲性と積差を照合する | PASS | 正因子対は `(1,14)`, `(2,7)`, `(7,2)`, `(14,1)`、次数対は `(3,16)`, `(4,9)`, `(9,4)`, `(16,3)` に一致 |

## 実行履歴

- 2026-08-24: リポジトリ直下から実行し、終了コード `0` で全件 PASS。
- 2026-08-24: 最終再検証の初回は構造化本文ディレクトリからリポジトリ相対パスを指定したため、対象ファイル未検出で終了コード `2` の ERROR。実行場所をリポジトリ直下へ戻した再実行は終了コード `0` で PASS。

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-fourteen-hyperbolic-types/check_classification.sage
```
