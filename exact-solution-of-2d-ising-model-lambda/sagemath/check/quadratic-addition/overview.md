# SageMath Check: 二次体の加法による閉性と和の表示

**対象ラベル**: `claim_quadratic_addition_mem`、`claim_quadratic_addition_representation`

- 実行日: 2026-10-11
- 結果: 通過。既存の和の両立49組・和の鎖と表示4,802組に加え、閉性の本文十三行を九等号43,218件・四所属19,208件で検算した。
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

有理数標本は分子 −2 から 2、分母 1 から 2 で得る相異なる七値、根は平方が 2 となる二つである。
二組の係数の全4,802入力を使い、包含写像を `QQbar` として各行の両辺を計算する。
入力と和の表示係数は最小多項式から独立に回収し、原式への代入を確認する。
有限標本の検算であり、一般の主張の証明は Lean が担う。

## 本文の行との対応

全行の対象ラベルは `claim_quadratic_addition_mem`。各ファイルは単独でも実行でき、`check_lines.sage` が十三本を実行する。

| 本文の行 | ファイル | 通過した検査 |
|---|---|---|
| 表示の代入 | check_representation_substitution.sage | 4,802等式 |
| 外側の結合則 | check_outer_association.sage | 4,802等式 |
| 内側の結合則を逆向きに適用 | check_inner_association_left.sage | 4,802等式 |
| 中央の二項の可換則 | check_middle_commutation.sage | 4,802等式 |
| 内側の結合則 | check_inner_association_right.sage | 4,802等式 |
| 左の二係数をまとめる結合則 | check_first_coefficients_grouping.sage | 4,802等式 |
| 右の係数への分配則 | check_right_distributivity.sage | 4,802等式 |
| 左の係数の和を包含写像へ戻す | check_first_coefficient_map_add.sage | 4,802等式 |
| 右の係数の和を包含写像へ戻す | check_second_coefficient_map_add.sage | 4,802等式 |
| 左の係数の和は有理数 | check_first_sum_rational.sage | 4,802所属確認 |
| 右の係数の和は有理数 | check_second_sum_rational.sage | 4,802所属確認 |
| 二次体の台集合への所属の証人 | check_coefficient_witness.sage | 4,802所属確認 |
| 和の二次体の台集合への所属 | check_sum_membership.sage | 4,802所属確認 |

既存の `check.sage` は有理数の和と包含後の和の両立、和の表示の計算、表示の一意性への接続を保ち、最後に行別検算を実行する。
`_prelude.sage` は標本と独立な表示回収だけを共有する。

## 実行方法

プロジェクト直下で実行する。

```sh
sage sagemath/check/quadratic-addition/check.sage
```
