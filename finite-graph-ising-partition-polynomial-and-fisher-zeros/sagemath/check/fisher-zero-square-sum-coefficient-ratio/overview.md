# 一般有限グラフの Fisher 零点の二乗和と係数比の検算

**対象ラベル**: `theorem_fisher_zero_square_sum_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_square_sum_coefficient_ratio`）
- 範囲: 有限和の平方展開、二乗和の取り出し、基本対称式の代入、最高次側三係数による有理式への変形
- 依存する本文ラベル: `theorem_fisher_zero_elementary_symmetric_coefficient_ratio`、`theorem_partition_polynomial_degree_maximum_broken_edge_count`、`claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_square_of_root_sum_expansion.sage` | 有限和の平方を二乗項と相異なる添字の積へ展開する | PASS | 全四例で一致 |
| `check_isolate_root_square_sum.sage` | 平方展開を移項して零点二乗和を取り出す | PASS | 全四例で一致 |
| `check_substitute_elementary_symmetric_ratios.sage` | 一次・二次基本対称式の係数比を代入する | PASS | 全四例で一致 |
| `check_square_of_negative_quotient.sage` | 負の係数比の平方から符号を除く | PASS | 全四例で一致 |
| `check_common_denominator.sage` | 非零な最高次係数を用いて共通分母へ移す | PASS | 全四例で一致 |
| `check_combined_coefficient_ratio.sage` | 同じ分母の二項を一つの係数比へまとめる | PASS | 全四例で一致 |

## 備考

- 三角形、四サイクル、三角形と孤立頂点の非連結和、五辺グラフを用い、次数二以上の例だけを検査する。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-square-sum-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
