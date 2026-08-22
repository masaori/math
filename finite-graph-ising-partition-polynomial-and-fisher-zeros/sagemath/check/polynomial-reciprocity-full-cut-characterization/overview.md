# 多項式逆数対称性による全辺二分割の特徴付けの検算

**対象ラベル**: `theorem_partition_polynomial_reciprocity_characterizes_full_cut`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_polynomial_reciprocity_characterizes_full_cut`）
- 範囲: 全辺二分割から Laurent 多項式の逆数対称性を得る七つの等式と、逆数対称性から係数対称性を回収する四つの等式
- 併せて検証: `theorem_full_cut_coefficient_symmetry`、`theorem_coefficient_symmetry_characterizes_full_cut`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_reciprocal_substitution.sage` | 逆数代入を多重度の有限和へ展開 | PASS | 全七例で一致 |
| `check_distribute_laurent_monomial.sage` | Laurent 単項式の有限和への分配 | PASS | 全七例で一致 |
| `check_commute_laurent_factors.sage` | Laurent 多項式環における係数と単項式の積の交換 | PASS | 全七例で一致 |
| `check_add_laurent_exponents.sage` | Laurent 単項式の整数指数の加法 | PASS | 全七例で一致 |
| `check_reverse_finite_sum.sage` | `n=|E|-m` による有限和の添字付け替え | PASS | 全七例で一致 |
| `check_forward_coefficient_symmetry.sage` | 全辺二分割による係数対称性と分配多項式の回収 | PASS | 全辺二分割をもつ全五例で一致 |
| `check_reverse_coefficient_recovery.sage` | Laurent 多項式の等式から各係数対称性を回収 | PASS | 逆数対称性をもつ全五例・全係数で一致 |
| `check_equivalence.sage` | 全辺二分割の存在と多項式逆数対称性の同値性 | PASS | 全七例で真理値が一致 |

## 備考

- 一頂点無辺、一辺、三頂点道、三角形、四頂点サイクル、完全四頂点グラフ、二本の平行辺を用いる。
- 有限集合、`NN`、`ZZ`、`ZZ[x,x^(-1)]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/polynomial-reciprocity-full-cut-characterization/check_*.sage; do
  sage "$file"
done
```
