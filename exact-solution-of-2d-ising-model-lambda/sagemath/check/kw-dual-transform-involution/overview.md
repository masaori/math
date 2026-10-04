# SageMath Check: 双対変換の対合性

## 対象

**対象ラベル**: `claim_kw_dual_transform_involution`

- 実行日: 2026-08-13
- 結果: 検査点 16 点すべて通過
- 帰属: `QQbar`（代数的数）の厳密計算。浮動小数点は使わない。

## 何を確かめるか

双対変換 $\mathrm{KW}(\xi):=(1-\xi)\cdot(1+\xi)^{-1}$（`def_kw_dual_transform`）について、
$1+\xi\ne0$ を満たす代数的数の検査点で

- 主張 $\mathrm{KW}(\mathrm{KW}(\xi))=\xi$（`claim_kw_dual_transform_involution`）
- 証明の鎖の中間段
  - $1+\mathrm{KW}(\xi)=2\cdot(1+\xi)^{-1}$
  - $1-\mathrm{KW}(\xi)=2\xi\cdot(1+\xi)^{-1}$
  - $\mathrm{KW}(\mathrm{KW}(\xi))\cdot(1+\mathrm{KW}(\xi))=1-\mathrm{KW}(\xi)$
  - $\xi\cdot(1+\mathrm{KW}(\xi))=1-\mathrm{KW}(\xi)$
  - $(1+\mathrm{KW}(\xi))\cdot(\mathrm{KW}(\mathrm{KW}(\xi))-\xi)=0$

を突き合わせる。検査点は `kw-dual-transform-domain` と同じ 16 点
（有理数・無理な実代数的数（$\sqrt2$、$\sqrt2-1$ を含む）・虚の代数的数
（虚数単位、1 の 3 乗根・8 乗根））である。
`QQbar` の等号・非零判定は厳密（根分離）であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```

## 行別検算

本文の六つの等式鎖を、隣接する式の対ごとに一ファイルへ分ける。既存の16代数的数を保ち、すべて `QQbar` で厳密に計算する。

| ファイル | 等式 | 状態 | 結果 |
|---|---|---|---|
| `check_plus_definition.sage` | $1+\mathrm{KW}(\xi)=1+(1-\xi)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_inverse.sage` | $1+(1-\xi)\cdot(1+\xi)^{-1}=(1+\xi)(1+\xi)^{-1}+(1-\xi)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_distribution.sage` | $(1+\xi)(1+\xi)^{-1}+(1-\xi)\cdot(1+\xi)^{-1}=\bigl((1+\xi)+(1-\xi)\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_subtraction.sage` | $\bigl((1+\xi)+(1-\xi)\bigr)\cdot(1+\xi)^{-1}=\bigl((1+\xi)+(1+(-\xi))\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_outer_association.sage` | $\bigl((1+\xi)+(1+(-\xi))\bigr)\cdot(1+\xi)^{-1}=\bigl(1+(\xi+(1+(-\xi)))\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_inner_association.sage` | $\bigl(1+(\xi+(1+(-\xi)))\bigr)\cdot(1+\xi)^{-1}=\bigl(1+((\xi+1)+(-\xi))\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_commutation.sage` | $\bigl(1+((\xi+1)+(-\xi))\bigr)\cdot(1+\xi)^{-1}=\bigl(1+((1+\xi)+(-\xi))\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_cancel_association.sage` | $\bigl(1+((1+\xi)+(-\xi))\bigr)\cdot(1+\xi)^{-1}=\bigl(1+(1+(\xi+(-\xi)))\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_cancel.sage` | $\bigl(1+(1+(\xi+(-\xi)))\bigr)\cdot(1+\xi)^{-1}=\bigl(1+(1+0)\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_zero.sage` | $\bigl(1+(1+0)\bigr)\cdot(1+\xi)^{-1}=\bigl(1+1\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_plus_two.sage` | $\bigl(1+1\bigr)\cdot(1+\xi)^{-1}=\bigl(2\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_definition.sage` | $1-\mathrm{KW}(\xi)=1-(1-\xi)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_inverse.sage` | $1-(1-\xi)\cdot(1+\xi)^{-1}=(1+\xi)(1+\xi)^{-1}-(1-\xi)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_distribution.sage` | $(1+\xi)(1+\xi)^{-1}-(1-\xi)\cdot(1+\xi)^{-1}=\bigl((1+\xi)-(1-\xi)\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_outer_subtraction.sage` | $\bigl((1+\xi)-(1-\xi)\bigr)\cdot(1+\xi)^{-1}=\bigl((1+\xi)+(-(1-\xi))\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_negated_difference.sage` | $\bigl((1+\xi)+(-(1-\xi))\bigr)\cdot(1+\xi)^{-1}=\bigl((1+\xi)+(\xi-1)\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_inner_subtraction.sage` | $\bigl((1+\xi)+(\xi-1)\bigr)\cdot(1+\xi)^{-1}=\bigl((1+\xi)+(\xi+(-1))\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_outer_association.sage` | $\bigl((1+\xi)+(\xi+(-1))\bigr)\cdot(1+\xi)^{-1}=\bigl(((1+\xi)+\xi)+(-1)\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_inner_association.sage` | $\bigl(((1+\xi)+\xi)+(-1)\bigr)\cdot(1+\xi)^{-1}=\bigl((1+(\xi+\xi))+(-1)\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_commutation.sage` | $\bigl((1+(\xi+\xi))+(-1)\bigr)\cdot(1+\xi)^{-1}=\bigl(((\xi+\xi)+1)+(-1)\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_cancel_association.sage` | $\bigl(((\xi+\xi)+1)+(-1)\bigr)\cdot(1+\xi)^{-1}=\bigl((\xi+\xi)+(1+(-1))\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_cancel.sage` | $\bigl((\xi+\xi)+(1+(-1))\bigr)\cdot(1+\xi)^{-1}=\bigl((\xi+\xi)+0\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_zero.sage` | $\bigl((\xi+\xi)+0\bigr)\cdot(1+\xi)^{-1}=\bigl(\xi+\xi\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_first_unit.sage` | $\bigl(\xi+\xi\bigr)\cdot(1+\xi)^{-1}=\bigl(1\cdot\xi+\xi\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_second_unit.sage` | $\bigl(1\cdot\xi+\xi\bigr)\cdot(1+\xi)^{-1}=\bigl(1\cdot\xi+1\cdot\xi\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_collect_units.sage` | $\bigl(1\cdot\xi+1\cdot\xi\bigr)\cdot(1+\xi)^{-1}=\bigl((1+1)\cdot\xi\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_minus_two.sage` | $\bigl((1+1)\cdot\xi\bigr)\cdot(1+\xi)^{-1}=\bigl(2\xi\bigr)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_double_definition.sage` | $\mathrm{KW}(\mathrm{KW}(\xi))\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)=\Bigl(\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)^{-1}\Bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)$ | PASS | 16代数的数で一致 |
| `check_double_association.sage` | $\Bigl(\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)^{-1}\Bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)=\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot\Bigl(\bigl(1+\mathrm{KW}(\xi)\bigr)^{-1}\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)\Bigr)$ | PASS | 16代数的数で一致 |
| `check_double_commutation.sage` | $\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot\Bigl(\bigl(1+\mathrm{KW}(\xi)\bigr)^{-1}\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)\Bigr)=\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot\Bigl(\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)^{-1}\Bigr)$ | PASS | 16代数的数で一致 |
| `check_double_inverse.sage` | $\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot\Bigl(\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)^{-1}\Bigr)=\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot1$ | PASS | 16代数的数で一致 |
| `check_double_unit.sage` | $\bigl(1-\mathrm{KW}(\xi)\bigr)\cdot1=1-\mathrm{KW}(\xi)$ | PASS | 16代数的数で一致 |
| `check_xi_plus_substitution.sage` | $\xi\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)=\xi\cdot\bigl(2\cdot(1+\xi)^{-1}\bigr)$ | PASS | 16代数的数で一致 |
| `check_xi_association.sage` | $\xi\cdot\bigl(2\cdot(1+\xi)^{-1}\bigr)=(\xi\cdot2)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_xi_commutation.sage` | $(\xi\cdot2)\cdot(1+\xi)^{-1}=(2\cdot\xi)\cdot(1+\xi)^{-1}$ | PASS | 16代数的数で一致 |
| `check_xi_minus_substitution.sage` | $(2\cdot\xi)\cdot(1+\xi)^{-1}=1-\mathrm{KW}(\xi)$ | PASS | 16代数的数で一致 |
| `check_difference_distribution.sage` | $\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\bigl(\mathrm{KW}(\mathrm{KW}(\xi))-\xi\bigr)=\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\mathrm{KW}(\mathrm{KW}(\xi))-\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\xi$ | PASS | 16代数的数で一致 |
| `check_difference_first_commutation.sage` | $\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\mathrm{KW}(\mathrm{KW}(\xi))-\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\xi=\mathrm{KW}(\mathrm{KW}(\xi))\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)-\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\xi$ | PASS | 16代数的数で一致 |
| `check_difference_second_commutation.sage` | $\mathrm{KW}(\mathrm{KW}(\xi))\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)-\bigl(1+\mathrm{KW}(\xi)\bigr)\cdot\xi=\mathrm{KW}(\mathrm{KW}(\xi))\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)-\xi\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)$ | PASS | 16代数的数で一致 |
| `check_difference_double_substitution.sage` | $\mathrm{KW}(\mathrm{KW}(\xi))\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)-\xi\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)=\bigl(1-\mathrm{KW}(\xi)\bigr)-\xi\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)$ | PASS | 16代数的数で一致 |
| `check_difference_xi_substitution.sage` | $\bigl(1-\mathrm{KW}(\xi)\bigr)-\xi\cdot\bigl(1+\mathrm{KW}(\xi)\bigr)=\bigl(1-\mathrm{KW}(\xi)\bigr)-\bigl(1-\mathrm{KW}(\xi)\bigr)$ | PASS | 16代数的数で一致 |
| `check_difference_cancel.sage` | $\bigl(1-\mathrm{KW}(\xi)\bigr)-\bigl(1-\mathrm{KW}(\xi)\bigr)=0$ | PASS | 16代数的数で一致 |
| `check_conclusion_restore_addend.sage` | $\mathrm{KW}(\mathrm{KW}(\xi))=\bigl(\mathrm{KW}(\mathrm{KW}(\xi))-\xi\bigr)+\xi$ | PASS | 16代数的数で一致 |
| `check_conclusion_zero_substitution.sage` | $\bigl(\mathrm{KW}(\mathrm{KW}(\xi))-\xi\bigr)+\xi=0+\xi$ | PASS | 16代数的数で一致 |
| `check_conclusion_zero_addition.sage` | $0+\xi=\xi$ | PASS | 16代数的数で一致 |

行別ファイルはプロジェクト直下から `sage -c "load('sagemath/check/kw-dual-transform-involution/check_plus_definition.sage')"` の形で実行する。

2026-10-04、SageMath 10.9 で行別45本が各16代数的数（計720等式）について通過し、既存の `check.sage` の16点の厳密検算も通過した。本文と Lean が任意の代数的数についての証明を担う。
