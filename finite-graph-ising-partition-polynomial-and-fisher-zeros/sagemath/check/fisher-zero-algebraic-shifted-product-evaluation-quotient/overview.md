# 二つの代数的評価点における Fisher 零点差積の商の検算

**対象ラベル**: `theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient`）
- 範囲: 分母側零点差積の非零性、二つの零点差積の商、次数零の空積
- 依存する本文ラベル: `theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_denominator_product_nonzero.sage` | 非零な分母評価値から分母側零点差積の非零性 | PASS | 全例・全対象評価点で一致 |
| `check_shifted_product_evaluation_quotient.sage` | 零点差積の商と評価値比 | PASS | 全例・全対象評価点対で `QQbar` 上一致 |
| `check_degree_zero_empty_products.sage` | 次数零の空積 | PASS | 空積の商と定数評価値比がともに `1` |

## 備考

- 無辺グラフ、一辺グラフ、四辺道、五サイクル、四頂点完全グラフを用いる。
- 代数的評価点は `t^2-2`、`t^2+1`、`t^3-2` の全ての `QQbar` 根とし、厳密演算だけを用いる。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-product-evaluation-quotient/check_*.sage; do
  sage "$file"
done
```
