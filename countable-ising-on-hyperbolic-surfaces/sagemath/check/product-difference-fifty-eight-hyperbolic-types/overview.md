# 積差五十八をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_fifty_eight_hyperbolic_types`
- 対象: 正整数の因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
| --- | --- | --- |
| 正の因数対 | PASS | `58` の正の順序付き因数対は `(1,58),(2,29),(29,2),(58,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,60),(4,31),(31,4),(60,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=58` |

## 実行履歴

- 2026-08-26: 四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-fifty-eight-hyperbolic-types/*.sage; do
  sage "$f"
done
```
