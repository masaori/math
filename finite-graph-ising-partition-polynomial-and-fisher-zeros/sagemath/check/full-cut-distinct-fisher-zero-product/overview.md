# 全辺二分割をもつ有限グラフの相異なる Fisher 零点積の検算

**対象ラベル**: `theorem_full_cut_distinct_fisher_zero_product`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_distinct_fisher_zero_product`）
- 範囲: 零点 `1` の不在、零点 `-1` 以外の逆数二元軌道積、相異なる零点積の分解、零点 `-1` と奇接続辺数頂点の同値性、最終の場合分け
- 併せて検証: `theorem_full_cut_fisher_zero_reciprocal_multiplicity`、`theorem_root_minus_one_characterizes_odd_incident_edge_count`、`claim_partition_polynomial_value_at_one`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_positive_one_absence.sage` | `1` における評価が全配位数で非零となり、零点台に属さないことを照合する | PASS | 全五例で評価値と零点台への不帰属を確認 |
| `check_inverse_orbit_products.sage` | `-1` 以外の各逆数二元軌道の積が `1` になることを照合する | PASS | 全五例で各逆数二元軌道の積を確認 |
| `check_root_product_decomposition.sage` | 相異なる零点積が `-1` の帰属だけで `-1` または `1` に定まることを照合する | PASS | 全五例で零点台の軌道分解と積を確認 |
| `check_minus_one_odd_incidence_equivalence.sage` | `-1` の零点台への帰属と奇接続辺数頂点の存在が同値であることを照合する | PASS | 全五例で零点条件と接続辺数条件を確認 |
| `check_distinct_root_product_formula.sage` | 相異なる零点積の奇接続辺数による場合分けを照合する | PASS | 全五例で最終の場合分けを確認 |

## 備考

- 一頂点無辺、一辺、三頂点道、四頂点サイクル、二本の平行辺を用いる。零点台が空である無辺グラフも含める。
- 有限集合、`NN`、`ZZ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-distinct-fisher-zero-product/check_*.sage; do
  sage "$file"
done
```
