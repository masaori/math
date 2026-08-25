# 積差五十三をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_fifty_three_hyperbolic_types`
- 対象: 正整数の因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
| --- | --- | --- |
| 素数性と正の因数対 | PASS | `53` は素数であり、正の順序付き因数対は `(1,53),(53,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,55),(55,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=53` |

## 実行履歴

- 2026-08-26: 四つの検算を実行し、すべて PASS。
- 2026-08-26: remote 取り込み後の再検証を `structured-latex/` からリポジトリ相対 glob で起動したため、対象 `.sage` ファイル未検出で ERROR。リポジトリ直下から同じ四検算を再実行して復旧した。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-fifty-three-hyperbolic-types/*.sage; do
  sage "$f"
done
```
