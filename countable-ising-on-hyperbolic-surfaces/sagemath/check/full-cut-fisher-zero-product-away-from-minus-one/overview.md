# 全辺二分割をもつ有限グラフの零点 -1 を除く Fisher 零点積の検算

**対象ラベル**: `theorem_full_cut_fisher_zero_product_away_from_minus_one`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_fisher_zero_product_away_from_minus_one`）
- 範囲: 零点 `1` の重複度零、零点 `-1` を除く逆数二元軌道、各軌道と全軌道の重複度込み積
- 併せて検証: `theorem_full_cut_fisher_zero_reciprocal_multiplicity`、`claim_partition_polynomial_value_at_one`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_positive_one_absence.sage` | `1` における評価が全配位数で非零となり、零点重複度が零であることを照合する | PASS | 全五例で評価値と重複度零を確認 |
| `check_nonfixed_inverse_orbits.sage` | `-1` 以外の零点が相異なる二元からなる逆数軌道へ分かれることを照合する | PASS | 全五例で逆数点の帰属・相異性・軌道分割を確認 |
| `check_inverse_orbit_product.sage` | 各逆数軌道の重複度込み積が `1` であることを照合する | PASS | 全五例の各逆数軌道で積 `1` を確認 |
| `check_total_product.sage` | `-1` 以外の全零点の重複度込み積が `1` であることを照合する | PASS | 無辺グラフの空積を含む全五例で積 `1` を確認 |

## 備考

- 一頂点無辺、一辺、三頂点道、四頂点サイクル、二本の平行辺を用いる。無辺グラフでは対象零点集合を空集合、積を空積 `1` として扱う。
- 有限集合、`NN`、`ZZ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。
- 構造化本文ディレクトリから実行した一度の試行では、リポジトリ相対の glob を解決できず `ERROR` となった。実行場所をリポジトリ直下へ戻して同じ四件を再実行し、全件 `PASS` した。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-product-away-from-minus-one/check_*.sage; do
  sage "$file"
done
```
