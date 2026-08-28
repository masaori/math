# 積差百七をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_one_hundred_seven_hyperbolic_types`
- 対象: 百七の素数性と正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 百七の素数性 | PASS | `107` が素数であることを確認した |
| 百七の正の因子対の全列挙 | PASS | `(1,107)`, `(107,1)` だけである |
| 因子対から次数対への復元 | PASS | 二つの分類済み次数対と一致した |
| 双曲不等式 | PASS | 全次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 全次数対で `(p-2)(q-2)=107` が成立した |

## 実行履歴

- 2026-08-28: 五つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-one-hundred-seven-hyperbolic-types/*.sage; do
  sage "$f"
done
```
