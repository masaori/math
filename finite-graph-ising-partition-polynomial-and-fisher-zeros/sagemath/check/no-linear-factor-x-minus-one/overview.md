# 一次多項式 x-1 の非整除性の検算

**対象ラベル**: `theorem_no_linear_factor_x_minus_one`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_no_linear_factor_x_minus_one`）
- 範囲: `x-1` によるモニック一次除法、余りの `1` 評価への同定、係数総和による余りの非零性、非整除性
- 併せて検証: `claim_partition_polynomial_value_at_one`

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_division_remainder.sage` | 除法等式と余り `r_G=Z_G(1)` | PASS | 全八例で除法等式と評価による余りが一致 |
| `check_positive_remainder.sage` | `r_G=2^{|V|}` とその非零性 | PASS | 全八例で配位数、二の頂点数乗、非零余りが一致 |
| `check_nondivisibility.sage` | `x-1` による非整除性 | ERROR → PASS | 初回は整数多項式に存在しない `is_divisible_by` の呼出しで停止。除法余りの非零性による検査へ修正後、全八例で非整除性が成立 |

## 備考

- `NN`、`ZZ`、`ZZ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- 初回実行では `Polynomial_integer_dense_flint` に `is_divisible_by` が存在せず `AttributeError` となった。数学的に同値なモニック除法の非零余りを直接検査する形へ修正した。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for check_file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/no-linear-factor-x-minus-one/check_*.sage; do
  sage "$check_file"
done
```
