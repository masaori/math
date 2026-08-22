# 一般有限グラフの Fisher 零点逆数の二乗和と係数比の検算

**対象ラベル**: `theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio`）
- 範囲: 逆数有限和の平方展開、逆数二乗和の取り出し、逆数族基本対称式の代入、低次三係数による有理式への変形
- 依存する本文ラベル: `theorem_fisher_zeros_nonzero`、`theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio`、`def_spin_configuration_set`、`def_broken_edge_set`、`def_broken_edge_multiplicity`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_square_of_reciprocal_sum_expansion.sage` | 逆数有限和の平方を逆数二乗項と相異なる添字の逆数積へ展開する | PASS | 全四例で一致 |
| `check_isolate_reciprocal_square_sum.sage` | 平方展開を移項して逆数二乗和を取り出す | PASS | 全四例で一致 |
| `check_substitute_reciprocal_symmetric_ratios.sage` | 逆数族の一次・二次基本対称式の係数比を代入する | PASS | 全四例で一致 |
| `check_square_of_negative_quotient.sage` | 負の低次係数比の平方から符号を除く | PASS | 全四例で一致 |
| `check_common_denominator.sage` | 非零な定数項を用いて共通分母へ移す | PASS | 全四例で一致 |
| `check_combined_coefficient_ratio.sage` | 同じ分母の二項を一つの係数比へまとめる | PASS | 全四例で一致 |

## 備考

- 三角形、四サイクル、三角形と孤立頂点の非連結和、五辺グラフを用い、次数二以上の例だけを検査する。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-square-sum-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
