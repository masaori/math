# 積差八十一をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_eighty_one_hyperbolic_types`
- 対象: 八十一の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
| --- | --- | --- |
| 正の因数対 | PASS | `81` の正の順序付き因数対は `(1,81),(3,27),(9,9),(27,3),(81,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,83),(5,29),(11,11),(29,5),(83,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=81` |

## 実行履歴

- 2026-08-27: 四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-eighty-one-hyperbolic-types/*.sage; do
  sage "$f"
done
```
