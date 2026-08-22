# 全辺二分割をもつ有限グラフの正の有理評価における逆数対称性の検算

**対象ラベル**: `theorem_full_cut_positive_rational_evaluation_reciprocity`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_positive_rational_reciprocity`）
- 範囲: 係数対称性から `Z_G(q)=q^{|E|}Z_G(q^{-1})` を得る六つの等式
- 併せて検証: `theorem_full_cut_coefficient_symmetry`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_partition_evaluation.sage` | 多項式評価を多重度の有限和へ展開 | PASS | 全五例・全五評価点で一致 |
| `check_coefficient_symmetry_substitution.sage` | 係数対称性を有限和へ代入 | PASS | 全五例・全五評価点で一致 |
| `check_reverse_finite_sum.sage` | `n=|E|-m` による有限和の添字付け替え | PASS | 全五例・全五評価点で一致 |
| `check_split_rational_power.sage` | 有理数の冪法則 | PASS | 全五例・全五評価点で一致 |
| `check_factor_rational_power.sage` | 有限和の分配律 | PASS | 全五例・全五評価点で一致 |
| `check_reciprocal_evaluation.sage` | 逆数点での評価と最終等式 | PASS | 全五例・全五評価点で一致 |

## 備考

- 一頂点無辺、一辺、三頂点道、四頂点サイクル、二本の平行辺と、正の有理評価点 `1/3, 1/2, 1, 3/2, 2` を用いる。
- 有限集合、`NN`、`QQ`、`QQ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-positive-rational-evaluation-reciprocity/check_*.sage; do
  sage "$file"
done
```
