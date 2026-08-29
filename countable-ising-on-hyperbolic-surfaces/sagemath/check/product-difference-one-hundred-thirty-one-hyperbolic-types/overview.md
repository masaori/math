# 積差百三十一をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_one_hundred_thirty_one_hyperbolic_types`
- 対象: 百三十一の素数性と正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 百三十一の素数性 | PASS | `131` が素数であることを確認した |
| 百三十一の正の因子対の全列挙 | PASS | `(1,131)`, `(131,1)` だけである |
| 因子対から次数対への復元 | PASS | 二つの分類済み次数対と一致した |
| 双曲不等式 | PASS | 両次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 両次数対で `(p-2)(q-2)=131` が成立した |

## 実行履歴

- 2026-08-29: 直前の積差百三十に対する四つの検算を再実行し、すべて PASS。
- 2026-08-29: 百三十一に対する五つの検算を実行し、すべて PASS。
- 2026-08-29: remote 取り込み後の一括再検証を `structured-latex/` からリポジトリ相対パスで起動し、対象 `.sage` ファイル未検出で ERROR。リポジトリルートから同じ検証を再実行して復旧した。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-one-hundred-thirty-one-hyperbolic-types/*.sage; do
  sage "$f"
done
```
