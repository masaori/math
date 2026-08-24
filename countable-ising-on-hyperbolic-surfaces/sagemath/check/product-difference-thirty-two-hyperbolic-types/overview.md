# 積差三十二をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_thirty_two_hyperbolic_types`
- 対象: 正整数の因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 正の因数対 | PASS | `32` の正の順序付き因数対は `(1,32),(2,16),(4,8),(8,4),(16,2),(32,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,34),(4,18),(6,10),(10,6),(18,4),(34,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=32` |

## 実行履歴

- 2026-08-25: 四つの検算を実行し、すべて PASS。
- 2026-08-25: 最終再検証の初回は `structured-latex/` からリポジトリ直下相対の glob を指定したため、対象ファイル未検出で ERROR。検算内容は実行されていない。リポジトリ直下から同じ四検算を再実行して全件 PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-thirty-two-hyperbolic-types/*.sage; do
  sage "$f"
done
```
