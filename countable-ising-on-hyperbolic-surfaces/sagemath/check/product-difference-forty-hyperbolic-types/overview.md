# 積差四十をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_forty_hyperbolic_types`
- 対象: 正整数の因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
| --- | --- | --- |
| 正の因数対 | PASS | `40` の正の順序付き因数対は `(1,40),(2,20),(4,10),(5,8),(8,5),(10,4),(20,2),(40,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,42),(4,22),(6,12),(7,10),(10,7),(12,6),(22,4),(42,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=40` |

## 実行履歴

- 2026-08-25: remote 取り込み後の再検証を `structured-latex` からリポジトリ相対 glob で起動したため、対象ファイル未検出で ERROR。リポジトリ直下から同じ検算を実行するよう修正した。
- 2026-08-25: 四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-forty-hyperbolic-types/*.sage; do
  sage "$f"
done
```
