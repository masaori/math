# 積差七十二をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_seventy_two_hyperbolic_types`
- 対象: 七十二の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
| --- | --- | --- |
| 正の因数対 | PASS | `72` の正の順序付き因数対は十二組に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると十二組の次数対を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=72` |

## 実行履歴

- 2026-08-26: 初回は `structured-latex/` を作業ディレクトリとしたままリポジトリ相対 glob を渡したため、対象ファイル未検出で ERROR。リポジトリルートから同じ検算を再実行した。
- 2026-08-26: 四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-seventy-two-hyperbolic-types/*.sage; do
  sage "$f"
done
```
