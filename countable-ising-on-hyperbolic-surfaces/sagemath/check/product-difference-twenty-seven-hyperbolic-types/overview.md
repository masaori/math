# 積差二十七をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_twenty_seven_hyperbolic_types`
- 対象: 正整数の因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 正の因数対 | PASS | `27` の正の順序付き因数対は `(1,27),(3,9),(9,3),(27,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,29),(5,11),(11,5),(29,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で `1/p+1/q<1/2` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=27` |

## 実行履歴

- 2026-08-25: 四つの検算を実行し、すべて PASS。
- 2026-08-25: `origin/main` 取り込み後の再検算初回は、構造化本文ディレクトリからリポジトリ相対パスを指定したため対象ファイルを検出できず、終了コード `2` で ERROR。リポジトリ直下から同じ四検算を再実行して全件 PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-twenty-seven-hyperbolic-types/*.sage; do
  sage "$f"
done
```
