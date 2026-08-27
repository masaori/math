# 積差八十二をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_eighty_two_hyperbolic_types`
- 対象: 八十二の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 八十二の正の因子対の全列挙 | PASS | `(1,82),(2,41),(41,2),(82,1)` と一致した |
| 因子対から次数対への復元 | PASS | `(3,84),(4,43),(43,4),(84,3)` と一致した |
| 双曲不等式 | PASS | 全次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 全次数対で `(p-2)(q-2)=82` が成立した |

## 実行履歴

- 2026-08-27: 四つの検算を実行し、すべて PASS。
- 2026-08-27: 検算対応検査の初回は対象ラベルの見出し形式が検査器の仕様と一致せず ERROR。見出しを正規形式へ修正した。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-eighty-two-hyperbolic-types/*.sage; do
  sage "$f"
done
```
