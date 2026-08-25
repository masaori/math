# 積差四十二をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_forty_two_hyperbolic_types`
- 対象: 正整数の因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
| --- | --- | --- |
| 正の因数対 | PASS | `42` の正の順序付き因数対は `(1,42),(2,21),(3,14),(6,7),(7,6),(14,3),(21,2),(42,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,44),(4,23),(5,16),(8,9),(9,8),(16,5),(23,4),(44,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=42` |

## 実行履歴

- 2026-08-25: 四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-forty-two-hyperbolic-types/*.sage; do
  sage "$f"
done
```
