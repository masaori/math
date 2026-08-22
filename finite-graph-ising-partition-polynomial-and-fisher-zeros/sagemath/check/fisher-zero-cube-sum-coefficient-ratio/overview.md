# 一般有限グラフの Fisher 零点の三乗和と係数比の検算

**対象ラベル**: `theorem_fisher_zero_cube_sum_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_cube_sum_coefficient_ratio`）
- 範囲: 有限和の三乗展開、三次 Newton 恒等式の導出、基本対称式の代入、最高次側四係数による有理式への変形
- 依存する本文ラベル: `theorem_fisher_zero_elementary_symmetric_coefficient_ratio`、`theorem_partition_polynomial_degree_maximum_broken_edge_count`、`claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_cube_of_root_sum_expansion.sage` | 三つの添字の一致型で有限和の三乗を展開する | PASS | 全四例で一致 |
| `check_first_times_second_symmetric_expansion.sage` | 一次と二次の基本対称式の積を添字の所属で展開する | PASS | 全四例で一致 |
| `check_isolate_root_cube_sum.sage` | 三乗展開を移項して零点三乗和を取り出す | PASS | 全四例で一致 |
| `check_substitute_repeated_pair_sum.sage` | 重複添字和を一次・二次・三次基本対称式へ置き換える | PASS | 全四例で一致 |
| `check_distribute_repeated_pair_substitution.sage` | 重複添字和の置換後に分配律を適用する | PASS | 全四例で一致 |
| `check_combine_third_symmetric_terms.sage` | 三次基本対称式の二項をまとめる | PASS | 全四例で一致 |
| `check_substitute_elementary_symmetric_ratios.sage` | 一次から三次の基本対称式の係数比を代入する | PASS | 全四例で一致 |
| `check_simplify_signed_products.sage` | 符号付き商の三乗と積を整理する | PASS | 全四例で一致 |
| `check_common_denominator.sage` | 非零な最高次係数を用いて共通三乗分母へ移す | PASS | 全四例で一致 |
| `check_combined_coefficient_ratio.sage` | 同じ分母の三項を一つの係数比へまとめる | PASS | 全四例で一致 |

## 備考

- 三辺道、四サイクル、三辺道と孤立頂点の非連結和、四頂点完全グラフを用い、次数三以上の例だけを検査する。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
