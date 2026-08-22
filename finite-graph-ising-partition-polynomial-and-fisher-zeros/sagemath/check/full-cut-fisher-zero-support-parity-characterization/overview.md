# 全辺二分割をもつ有限グラフの Fisher 零点台の奇偶による奇接続辺数頂点の特徴付けの検算

**対象ラベル**: `theorem_full_cut_fisher_zero_support_parity_characterization`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_fisher_zero_support_parity_characterization`）
- 範囲: 零点 `0,1` の不在、零点 `-1` 以外の逆数二元軌道、零点台の濃度分解、奇偶条件、零点 `-1` と奇接続辺数頂点の同値性
- 併せて検証: `theorem_full_cut_fisher_zero_reciprocal_multiplicity`、`theorem_root_minus_one_characterizes_odd_incident_edge_count`、`claim_partition_polynomial_value_at_one`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_zero_absence.sage` | 定数項が正であり、`0` が零点台に属さないことを照合する | PASS | 全五例で正の定数項と重複度零を確認 |
| `check_positive_one_absence.sage` | `1` における評価が全配位数で非零となり、零点台に属さないことを照合する | PASS | 全五例で評価値と重複度零を確認 |
| `check_nonminus_one_inverse_orbits.sage` | `-1` 以外の零点台が相異なる二元からなる逆数軌道へ分かれることを照合する | PASS | 全五例で逆数点の帰属・相異性・軌道分割を確認 |
| `check_root_support_cardinality_decomposition.sage` | 零点台の濃度が逆数二元軌道数の二倍と `-1` 指示子の和になることを照合する | PASS | 全五例で濃度分解を確認 |
| `check_root_support_parity_indicator.sage` | 零点台の濃度が奇数であることと `-1` 指示子が `1` であることの同値性を照合する | PASS | 全五例で奇偶条件を確認 |
| `check_minus_one_multiplicity_root_equivalence.sage` | `-1` 指示子、正の零点重複度、代数的多項式と整数係数多項式での零点条件の同値性を照合する | PASS | 全五例で三段の同値性を確認 |
| `check_odd_degree_characterization.sage` | `-1` が零点であることと奇接続辺数頂点の存在の同値性を照合する | PASS | 全五例で零点条件と接続辺数条件を確認 |

## 備考

- 一頂点無辺、一辺、三頂点道、四頂点サイクル、二本の平行辺を用いる。零点台が空である無辺グラフも含める。
- 有限集合、`NN`、`ZZ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-support-parity-characterization/check_*.sage; do
  sage "$file"
done
```
