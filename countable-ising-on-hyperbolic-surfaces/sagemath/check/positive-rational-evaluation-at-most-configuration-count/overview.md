# 正の有理評価が全配位数以下となる評価点の特徴付け

**対象ラベル**: `theorem_partition_polynomial_positive_rational_evaluation_at_most_configuration_count`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_positive_rational_evaluation_at_most_configuration_count`）
- 範囲: `Z_G(q)<=2^{|V|}` と `q<=1` の同値性
- 併せて検証: `claim_partition_polynomial_value_at_one`、`theorem_partition_polynomial_positive_rational_evaluation_weak_order_reflection`

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_value_at_one.sage` | `Z_G(1)=2^{|V|}` | PASS | 全七グラフで一致 |
| `check_replace_configuration_count.sage` | `Z_G(q)<=2^{|V|}` と `Z_G(q)<=Z_G(1)` の同値性 | PASS | 全七グラフ・全五評価点で成立 |
| `check_weak_order_at_one.sage` | `Z_G(q)<=Z_G(1)` と `q<=1` の同値性 | PASS | 全七グラフ・全五評価点で成立 |
| `check_configuration_count_threshold.sage` | `Z_G(q)<=2^{|V|}` と `q<=1` の同値性 | PASS | 全七グラフ・全五評価点で成立 |

## 備考

- 辺をもつ七つの有限グラフと、正の有理評価点 `1/3, 1/2, 1, 3/2, 2` を用いる。
- `NN`、`QQ`、`QQ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for check_file in countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-at-most-configuration-count/check_*.sage; do
  sage "$check_file"
done
```
