# 全辺二分割をもつ有限グラフの Fisher 零点積の検算

**対象ラベル**: `theorem_full_cut_fisher_zero_product`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_fisher_zero_product`）
- 範囲: 重複度込み一次因子分解、零点積の符号抽出、定数項と最高次係数の対称性、零点積の決定
- 併せて検証: `theorem_full_cut_fisher_zero_reciprocal_multiplicity`、`theorem_full_cut_coefficient_symmetry`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_linear_factorization.sage` | `QQbar[x]` 上の重複度込み一次因子分解を復元する | PASS | 全五例で次数と因子積から多項式を復元 |
| `check_constant_term_substitution.sage` | 一次因子分解への零代入が定数項に一致する | PASS | 全五例で零代入と定数係数が一致 |
| `check_sign_extraction_and_coefficient_symmetry.sage` | 有限積からの符号抽出と全辺二分割による係数対称性を照合する | PASS | 全五例で符号抽出と両端係数の一致を確認 |
| `check_zero_product.sage` | 重複度込み零点積が `(-1)^|E|` に一致する | PASS | 無辺グラフの空積を含む全五例で一致 |

## 備考

- 一頂点無辺、一辺、三頂点道、四頂点サイクル、二本の平行辺を用いる。無辺グラフでは零点列を空列、積を `1` とする。
- 有限集合、`NN`、`ZZ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-product/check_*.sage; do
  sage "$file"
done
```
