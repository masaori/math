# 積差百十五をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_one_hundred_fifteen_hyperbolic_types`
- 対象: 百十五の正整数因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
|---|---|---|
| 百十五の正の因子対の全列挙 | PASS | `(1,115)`, `(5,23)`, `(23,5)`, `(115,1)` だけである |
| 因子対から次数対への復元 | PASS | 四つの分類済み次数対と一致した |
| 双曲不等式 | PASS | 全次数対で `2(p+q)<pq` が成立した |
| 整数上の積差 | PASS | 全次数対で `(p-2)(q-2)=115` が成立した |

## 実行履歴

- 2026-08-28: 直前の積差百十四を再検算する最初の呼び出しは、作業ディレクトリとリポジトリ相対パスの重複により対象ファイル未検出で終了した。絶対パスへ修正し、同じ四検算を再実行して全件 PASS。
- 2026-08-28: 百十五に対する四つの検算を実行し、すべて PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-one-hundred-fifteen-hyperbolic-types/*.sage; do
  sage "$f"
done
```
