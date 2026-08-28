# 積差百二十四をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_one_hundred_twenty_four_hyperbolic_types`
- 対象: 百二十四の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 百二十四の正の因子対の全列挙 | PASS | `(1,124)`, `(2,62)`, `(4,31)`, `(31,4)`, `(62,2)`, `(124,1)` だけである |
| 因子対から次数対への復元 | PASS | 六つの分類済み次数対と一致した |
| 双曲不等式 | PASS | 全次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 全次数対で `(p-2)(q-2)=124` が成立した |

## 実行履歴

- 2026-08-29: 直前の積差百二十三に対する四つの検算を再実行し、すべて PASS。
- 2026-08-29: 百二十四に対する四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-one-hundred-twenty-four-hyperbolic-types/*.sage; do
  sage "$f"
done
```
