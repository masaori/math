# 積差百八をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_one_hundred_eight_hyperbolic_types`
- 対象: 百八の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 百八の正の因子対の全列挙 | PASS | 十二個の順序付き正因子対だけである |
| 因子対から次数対への復元 | PASS | 十二個の分類済み次数対と一致した |
| 双曲不等式 | PASS | 全次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 全次数対で `(p-2)(q-2)=108` が成立した |

## 実行履歴

- 2026-08-28: 四つの検算を実行し、すべて PASS。
- 2026-08-28: remote default branch 取り込み後の再検証を `structured-latex/` からリポジトリ相対パスで起動したため、対象 SageMath ファイルが未検出となり ERROR。正しいリポジトリ直下から同じ検算を再実行して復旧した。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-one-hundred-eight-hyperbolic-types/*.sage; do
  sage "$f"
done
```
