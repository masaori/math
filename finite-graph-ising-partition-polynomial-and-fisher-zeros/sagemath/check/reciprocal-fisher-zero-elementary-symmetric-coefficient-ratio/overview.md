# 一般有限グラフの Fisher 零点逆数族の基本対称式と係数比の検算

**対象ラベル**: `theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio`）
- 範囲: 逆数選択積と補集合積、相補次数の基本対称式との比、逆数族の基本対称式と低次係数比
- 依存する本文ラベル: `theorem_fisher_zeros_nonzero`、
  `theorem_fisher_zero_elementary_symmetric_coefficient_ratio`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_reciprocal_selected_product_complement.sage` | 各逆数選択積を補集合の零点積と全零点積の比へ移す | PASS | 次数零を含む全五例・全ての部分集合で一致 |
| `check_reciprocal_complementary_symmetric_ratio.sage` | 逆数族の基本対称式を元の零点族の相補次数基本対称式と全零点積の比へ移す | PASS | 次数零を含む全五例・全ての `k` で一致 |
| `check_reciprocal_elementary_symmetric_coefficient_ratio.sage` | 任意次数の逆数基本対称式を符号付き低次係数比として復元する | PASS | 次数零を含む全五例・全ての `k` で一致 |

## 備考

- 孤立頂点、一辺、三角形、三角形と孤立頂点の非連結和、五辺グラフを用いる。
- 次数零、空積、全ての `k` を検査する。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-elementary-symmetric-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
