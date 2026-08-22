# 一般有限グラフの Fisher 零点の非零性の検算

**対象ラベル**: `theorem_fisher_zeros_nonzero`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zeros_nonzero`）
- 範囲: 正の定数項と最高次係数、重複度込み Fisher 零点積の非零性、各 Fisher 零点の非零性
- 依存する本文ラベル: `theorem_fisher_zero_product_coefficient_ratio`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_endpoint_coefficients_positive.sage` | 定数項と最高次係数が正である | PASS | 無辺グラフを含む全五例で成立 |
| `check_root_product_nonzero.sage` | 重複度込み零点積が符号付き両端係数比に一致し、非零である | PASS | 空積を含む全五例で成立 |
| `check_each_root_nonzero.sage` | 零点積の非零性から各 Fisher 零点が非零である | PASS | 全五例で零点リストに零なし |

## 備考

- 一頂点無辺、一辺、三角形、三角形と孤立頂点の非連結和、五辺グラフを用いる。
- 有限集合、`NN`、`ZZ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算まで完了した。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zeros-nonzero/check_*.sage; do
  sage "$file"
done
```
