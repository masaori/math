# 積差百二十六をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_one_hundred_twenty_six_hyperbolic_types`
- 対象: 百二十六の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 百二十六の正の因子対の全列挙 | PASS | 十二個の順序付き正因子対だけである |
| 因子対から次数対への復元 | PASS | 十二個の分類済み次数対と一致した |
| 双曲不等式 | PASS | 全次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 全次数対で `(p-2)(q-2)=126` が成立した |

## 実行履歴

- 2026-08-29: 直前の積差百二十五に対する四つの検算を再実行し、すべて PASS。
- 2026-08-29: 百二十六に対する四つの検算を実行し、すべて PASS。
- 2026-08-29: remote 取り込み後の一括再検証を `structured-latex/` から起動したため、リポジトリルート相対の対象ファイルが見つからず ERROR。正しいリポジトリルートから再実行する。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-one-hundred-twenty-six-hyperbolic-types/*.sage; do
  sage "$f"
done
```
