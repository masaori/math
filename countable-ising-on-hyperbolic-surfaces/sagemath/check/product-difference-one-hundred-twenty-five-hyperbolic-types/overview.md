# 積差百二十五をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_one_hundred_twenty_five_hyperbolic_types`
- 対象: 百二十五の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 百二十五の正の因子対の全列挙 | PASS | `(1,125)`, `(5,25)`, `(25,5)`, `(125,1)` だけである |
| 因子対から次数対への復元 | PASS | 四つの分類済み次数対と一致した |
| 双曲不等式 | PASS | 全次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 全次数対で `(p-2)(q-2)=125` が成立した |

## 実行履歴

- 2026-08-29: 直前の積差百二十四に対する四つの検算を再実行し、すべて PASS。
- 2026-08-29: 百二十五に対する四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-one-hundred-twenty-five-hyperbolic-types/*.sage; do
  sage "$f"
done
```
