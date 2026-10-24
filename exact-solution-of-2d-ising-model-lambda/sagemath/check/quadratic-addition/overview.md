# SageMath Check: 二次体の加法による閉性と和の表示

**対象ラベル**: `claim_quadratic_addition_mem`、`claim_quadratic_addition_representation`

- 実行日: 2026-10-11
- 結果: 通過。既存の和の両立49組・和の鎖と表示4,802組に加え、閉性の本文十三行を九等号43,218件・四所属19,208件、和の表示の本文十一行を十等号48,020件・一所属4,802件で検算した。
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

## 和の表示の各行

対象は `claim_quadratic_addition_representation`。九等号の係数整理、和の所属、一意表示の一等号を別々に照合する。十一行すべて通過した。

| 本文の行 | ファイル | 通過した検査 |
|---|---|---|
| 表示の代入 | `check_sum_representation_representation_substitution.sage` | 4,802等式 |
| 外側の結合則 | `check_sum_representation_outer_association.sage` | 4,802等式 |
| 内側の結合則を逆向きに適用 | `check_sum_representation_inner_association_left.sage` | 4,802等式 |
| 中央の二項の可換則 | `check_sum_representation_middle_commutation.sage` | 4,802等式 |
| 内側の結合則 | `check_sum_representation_inner_association_right.sage` | 4,802等式 |
| 左の二係数をまとめる結合則 | `check_sum_representation_first_coefficients_grouping.sage` | 4,802等式 |
| 右の係数への分配則 | `check_sum_representation_right_distributivity.sage` | 4,802等式 |
| 左の係数の加法保存 | `check_sum_representation_first_coefficient_map_add.sage` | 4,802等式 |
| 右の係数の加法保存 | `check_sum_representation_second_coefficient_map_add.sage` | 4,802等式 |
| 和の所属 | `check_sum_representation_membership.sage` | 4,802所属確認 |
| 一意な表示の係数 | `check_sum_representation_unique.sage` | 4,802等式 |

`check_sum_representation_lines.sage` はこの十一行を実行する。`check.sage` は既存の閉性の検算と併せて実行する。

## 加法閉性のレビュー

2026-10-24: 本文の根の条件へ包含写像を、表示係数へ所属集合を明示した。
必要十分版は終点の表示等式を仮定せず、表示仕様、加法の結合則、中央二項の可換性、
右乗法と包含写像の加法保存から本文と同じ九等号を導く。
通常 CLI の行別「表示の代入」4,802等式と統合検算が通過した。
閉性十三行の九等号43,218件・四所属19,208件に加え、既存の和の表示十一行と回帰検算も通過した。
有限標本の検算であり、一般の証明とは区別する。

## 和の表示のレビュー

2026-10-24: 和の表示の必要十分版は、係数整理の終点を仮定せず、
表示仕様と加法の演算則から本文と同じ九等号を導いて表示の一意性を適用する。
導出版は値の加法仕様・表示仕様・演算則・一意性を具体化する。
独立な具体版は同じ九等号を保持する。
`lake build Ising2DLambda.FisherZero.QuadraticAdditionFromNecSuf` が通過した。
SageMath の統合検算も再実行し、和の両立49組・和の鎖と表示4,802組、
閉性十三行および和の表示十一行がすべて通過した。
和の表示は九等号43,218件・所属4,802件・表示一意性4,802件を照合した。
有限標本の検算であり、一般の主張の証明ではない。
