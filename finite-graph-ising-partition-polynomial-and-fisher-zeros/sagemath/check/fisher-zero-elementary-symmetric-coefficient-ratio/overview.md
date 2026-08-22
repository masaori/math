# 一般有限グラフの Fisher 零点の基本対称式と係数比の検算

**対象ラベル**: `theorem_fisher_zero_elementary_symmetric_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_elementary_symmetric_coefficient_ratio`）
- 範囲: 一次因子分解の任意の高次係数、選択した零点積の符号抽出、基本対称式と係数比
- 依存する本文ラベル: `theorem_partition_polynomial_degree_maximum_broken_edge_count`、`claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_selected_product_expansion.sage` | 一次因子分解の任意の高次係数を符号付き選択積の和として復元する | PASS | 次数零を含む全五例・全ての `k` で一致 |
| `check_selected_product_sign_extraction.sage` | 各選択積の `k` 個の因子から `-1` を取り出す | PASS | 次数零を含む全五例・全ての `k` で一致 |
| `check_elementary_symmetric_coefficient_ratio.sage` | 任意次数の基本対称式が符号付き高次係数比に一致する | PASS | 次数零を含む全五例・全ての `k` で一致 |

## 備考

- 孤立頂点、一辺、三角形、三角形と孤立頂点の非連結和、五辺グラフを用いる。
- 次数零と空積を含む全ての `k` を検査する。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-elementary-symmetric-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
