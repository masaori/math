# 積差八十四をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_eighty_four_hyperbolic_types`
- 対象: 八十四の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 八十四の正の因子対の全列挙 | PASS | 十二個の順序付き因子対と一致した |
| 因子対から次数対への復元 | PASS | 十二個の分類済み次数対と一致した |
| 双曲不等式 | PASS | 全次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 全次数対で `(p-2)(q-2)=84` が成立した |

## 実行履歴

- 2026-08-27: 構造化本文ディレクトリからリポジトリ相対パスを指定した初回起動は、対象 glob を解決できず ERROR。作業ディレクトリをリポジトリルートへ戻して復旧実行した。
- 2026-08-27: 四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-eighty-four-hyperbolic-types/*.sage; do
  sage "$f"
done
```
