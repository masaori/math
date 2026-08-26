# 積差七十八をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_seventy_eight_hyperbolic_types`
- 対象: 七十八の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
| --- | --- | --- |
| 正の因数対 | PASS | 正の順序付き因数対は `(1,78),(2,39),(3,26),(6,13),(13,6),(26,3),(39,2),(78,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,80),(4,41),(5,28),(8,15),(15,8),(28,5),(41,4),(80,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=78` |

## 実行履歴

- 2026-08-27: 四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-seventy-eight-hyperbolic-types/*.sage; do
  sage "$f"
done
```
