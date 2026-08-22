# 一般有限グラフの Fisher 零点の逆数和と低次係数比の検算

**対象ラベル**: `theorem_fisher_zero_reciprocal_sum_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_reciprocal_sum_coefficient_ratio`）
- 範囲: 一次因子分解の一次係数、零点を一つ除いた積、非零 Fisher 零点の逆数和、低次係数比
- 依存する本文ラベル: `theorem_fisher_zeros_nonzero`、`theorem_fisher_zero_product_coefficient_ratio`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_linear_coefficient_expansion.sage` | 一次因子分解の一次係数を、零点を一つずつ除いた積の和として復元する | PASS | 辺をもつ全四例で一致 |
| `check_excluded_products_as_reciprocals.sage` | 零点を一つ除いた積を、全零点積とその零点の逆数の積へ書き換える | PASS | 全四例で零点が非零かつ式が一致 |
| `check_reciprocal_sum_ratio.sage` | 重複度込み逆数和が負の一次係数・定数項比に一致する | PASS | 非二部グラフと孤立頂点を含む全四例で一致 |

## 備考

- 一辺、三角形、三角形と孤立頂点の非連結和、五辺グラフを用いる。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算まで完了した。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-reciprocal-sum-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
