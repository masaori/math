# 積差二十三をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_twenty_three_hyperbolic_types`

## 対象

- 構造化本文: 「積差二十三をもつ双曲正則型の分類」
- 検算範囲: 二十三の全正因子対、次数対の復元、双曲不等式、整数積差
- 帰属: 因子対と次数対は `NN`、標準単射後の積差は `ZZ`。除算、実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_positive_factor_pairs.sage` | 二十三の全正因子対を列挙する | PASS | 正因子対は `(1,23)`, `(23,1)` に一致 |
| `check_degree_pair_recovery.sage` | 正因子対から次数対を復元する | PASS | 次数対は `(3,25)`, `(25,3)` に一致 |
| `check_hyperbolic_inequality.sage` | 復元した全次数対の双曲不等式を照合する | PASS | 全二対で `2(p+q)<pq` |
| `check_integer_product_difference.sage` | 標準単射後の整数積差を照合する | PASS | 全二対で `(p-2)(q-2)=23` |

## 実行履歴

- 2026-08-24: 四検算を実行し、終了コード `0` で全件 PASS。

## 実行方法

```bash
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-twenty-three-hyperbolic-types/check_*.sage; do
  sage "$file"
done
```
