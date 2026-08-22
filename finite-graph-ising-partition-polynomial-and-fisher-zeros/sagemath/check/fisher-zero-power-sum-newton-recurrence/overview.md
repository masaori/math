# 一般有限グラフの Fisher 零点冪和の Newton 漸化式と係数比の検算

**対象ラベル**: `theorem_fisher_zero_power_sum_newton_recurrence`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_power_sum_newton_recurrence`）
- 範囲: 選択部分集合の内外による有限和分割、交代和の相殺、Newton 漸化式、高次係数比の代入
- 依存する本文ラベル: `theorem_fisher_zero_elementary_symmetric_coefficient_ratio`、`theorem_partition_polynomial_degree_maximum_broken_edge_count`、`claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_split_selected_index.sage` | 基本対称式と冪和の積を選択添字の内外へ分ける | PASS | 全例の全対象次数で一致 |
| `check_alternating_cancellation.sage` | 交代和で中間の添字和が相殺する | PASS | 全例の全対象次数で一致 |
| `check_newton_recurrence.sage` | 任意次数の Newton 漸化式を得る | PASS | 全例の全対象次数で一致 |
| `check_substitute_coefficient_ratios.sage` | 基本対称式を高次係数比へ置き換える | PASS | 全例の全対象次数で一致 |
| `check_final_coefficient_recurrence.sage` | 冪和を高次係数による有理漸化式へまとめる | PASS | 全例の全対象次数で一致 |

## 備考

- 一辺グラフ、四辺道、五サイクル、四頂点完全グラフを用い、各分配多項式の次数以下の全冪和を検査する。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-power-sum-newton-recurrence/check_*.sage; do
  sage "$file"
done
```
