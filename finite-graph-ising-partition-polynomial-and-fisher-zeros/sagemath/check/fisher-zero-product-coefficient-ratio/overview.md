# 一般有限グラフの Fisher 零点積と両端係数比の検算

**対象ラベル**: `theorem_fisher_zero_product_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_product_coefficient_ratio`）
- 範囲: 一般有限グラフの重複度込み一次因子分解、零代入、有限積からの符号抽出、両端係数比による零点積

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_linear_factorization.sage` | `QQbar[x]` 上の重複度込み一次因子分解を復元する | PASS | 無辺グラフの空積を含む全五例で復元 |
| `check_constant_term_substitution.sage` | 一次因子分解への零代入が定数項に一致する | PASS | 全五例で定数係数と一致 |
| `check_product_ratio.sage` | 重複度込み零点積が符号付き両端係数比に一致する | PASS | 非二部グラフと孤立頂点を含む全五例で一致 |

## 備考

- 一頂点無辺、一辺、三角形、三角形と孤立頂点の非連結和、五辺グラフを用いる。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算まで完了した。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-product-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
