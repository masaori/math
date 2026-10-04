# SageMath Check: 自己双対条件は二次方程式と同値

**対象ラベル**: `claim_kw_self_dual_quadratic_equivalence`

本文の六つの等式鎖を、隣接する式の対ごとに一ファイルへ分ける。
既存の代数的数17点（有理数、平方根、虚数単位、原始三乗根・八乗根）を保ち、すべて `QQbar` で厳密に検算する。
全点が分母非零の条件を満たす。自己双対条件を使う行は `KW(xi)=xi` で選んだ二根、
二次方程式を使う行は二次式が零となる二根で検算する。それ以外の41行は17点すべてを用いる。
検算対象の二根は $\sqrt2-1$ と $-1-\sqrt2$ である。これらの有限点の検算を一般の証明とは扱わない。

| 鎖 | ファイル | 等式 | 状態 | 結果 |
|---|---|---|---|---|
| 双対変換と分母の積 | `check_product_definition.sage` | $\mathrm{KW}(\xi)\cdot(1+\xi)=\bigl((1-\xi)\cdot(1+\xi)^{-1}\bigr)\cdot(1+\xi)$ | PASS | 17点で一致 |
| 双対変換と分母の積 | `check_product_association.sage` | $\bigl((1-\xi)\cdot(1+\xi)^{-1}\bigr)\cdot(1+\xi)=(1-\xi)\cdot\bigl((1+\xi)^{-1}\cdot(1+\xi)\bigr)$ | PASS | 17点で一致 |
| 双対変換と分母の積 | `check_product_commutation.sage` | $(1-\xi)\cdot\bigl((1+\xi)^{-1}\cdot(1+\xi)\bigr)=(1-\xi)\cdot\bigl((1+\xi)\cdot(1+\xi)^{-1}\bigr)$ | PASS | 17点で一致 |
| 双対変換と分母の積 | `check_product_inverse.sage` | $(1-\xi)\cdot\bigl((1+\xi)\cdot(1+\xi)^{-1}\bigr)=(1-\xi)\cdot 1$ | PASS | 17点で一致 |
| 双対変換と分母の積 | `check_product_unit.sage` | $(1-\xi)\cdot 1=1-\xi$ | PASS | 17点で一致 |
| 倍数の定義 | `check_double_units.sage` | $\xi+\xi=1\cdot\xi+1\cdot\xi$ | PASS | 17点で一致 |
| 倍数の定義 | `check_double_distribution.sage` | $1\cdot\xi+1\cdot\xi=(1+1)\cdot\xi$ | PASS | 17点で一致 |
| 倍数の定義 | `check_double_definition.sage` | $(1+1)\cdot\xi=2\xi$ | PASS | 17点で一致 |
| 順方向の積 | `check_forward_self_duality.sage` | $\xi\cdot(1+\xi)=\mathrm{KW}(\xi)\cdot(1+\xi)$ | PASS | 2点で一致 |
| 順方向の積 | `check_forward_product_identity.sage` | $\mathrm{KW}(\xi)\cdot(1+\xi)=1-\xi$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_insert_cancellation.sage` | $\xi^2+2\xi-1=\bigl((\xi^2+\xi)-\xi\bigr)+2\xi-1$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_sum_commutation.sage` | $\bigl((\xi^2+\xi)-\xi\bigr)+2\xi-1=\bigl((\xi+\xi^2)-\xi\bigr)+2\xi-1$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_square_definition.sage` | $\bigl((\xi+\xi^2)-\xi\bigr)+2\xi-1=\bigl((\xi+\xi\cdot\xi)-\xi\bigr)+2\xi-1$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_unit_insertion.sage` | $\bigl((\xi+\xi\cdot\xi)-\xi\bigr)+2\xi-1=\bigl((\xi\cdot1+\xi\cdot\xi)-\xi\bigr)+2\xi-1$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_distribution.sage` | $\bigl((\xi\cdot1+\xi\cdot\xi)-\xi\bigr)+2\xi-1=\bigl(\xi\cdot(1+\xi)-\xi\bigr)+2\xi-1$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_product_substitution.sage` | $\bigl(\xi\cdot(1+\xi)-\xi\bigr)+2\xi-1=\bigl((1-\xi)-\xi\bigr)+2\xi-1$ | PASS | 2点で一致 |
| 順方向の整理 | `check_forward_subtraction_association.sage` | $\bigl((1-\xi)-\xi\bigr)+2\xi-1=\bigl(1-(\xi+\xi)\bigr)+2\xi-1$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_double_substitution.sage` | $\bigl(1-(\xi+\xi)\bigr)+2\xi-1=(1-2\xi)+2\xi-1$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_cancel_double.sage` | $(1-2\xi)+2\xi-1=1-1$ | PASS | 17点で一致 |
| 順方向の整理 | `check_forward_cancel_one.sage` | $1-1=0$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_distribution.sage` | $(1+\xi)\cdot\bigl(\mathrm{KW}(\xi)-\xi\bigr)=(1+\xi)\cdot\mathrm{KW}(\xi)-(1+\xi)\cdot\xi$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_product_commutation.sage` | $(1+\xi)\cdot\mathrm{KW}(\xi)-(1+\xi)\cdot\xi=\mathrm{KW}(\xi)\cdot(1+\xi)-\xi\cdot(1+\xi)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_product_substitution.sage` | $\mathrm{KW}(\xi)\cdot(1+\xi)-\xi\cdot(1+\xi)=(1-\xi)-\xi\cdot(1+\xi)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_expansion.sage` | $(1-\xi)-\xi\cdot(1+\xi)=(1-\xi)-(\xi\cdot1+\xi\cdot\xi)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_unit.sage` | $(1-\xi)-(\xi\cdot1+\xi\cdot\xi)=(1-\xi)-(\xi+\xi\cdot\xi)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_square.sage` | $(1-\xi)-(\xi+\xi\cdot\xi)=(1-\xi)-(\xi+\xi^2)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_subtract_sum.sage` | $(1-\xi)-(\xi+\xi^2)=1-\xi-\xi-\xi^2$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_collect_subtractions.sage` | $1-\xi-\xi-\xi^2=\bigl(1-(\xi+\xi)\bigr)-\xi^2$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_double_substitution.sage` | $\bigl(1-(\xi+\xi)\bigr)-\xi^2=1-2\xi-\xi^2$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_subtraction_definition.sage` | $1-2\xi-\xi^2=(1-2\xi)+(-\xi^2)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_outer_commutation.sage` | $(1-2\xi)+(-\xi^2)=-\xi^2+(1-2\xi)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_left_association.sage` | $-\xi^2+(1-2\xi)=(-\xi^2+1)-2\xi$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_inner_commutation.sage` | $(-\xi^2+1)-2\xi=(1+(-\xi^2))-2\xi$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_right_association.sage` | $(1+(-\xi^2))-2\xi=1+(-\xi^2-2\xi)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_constant_commutation.sage` | $1+(-\xi^2-2\xi)=-\xi^2-2\xi+1$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_negative_sum_expansion.sage` | $-\xi^2-2\xi+1=\bigl(-\xi^2+(-(2\xi))\bigr)+1$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_negative_sum.sage` | $\bigl(-\xi^2+(-(2\xi))\bigr)+1=-(\xi^2+2\xi)+1$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_double_negation.sage` | $-(\xi^2+2\xi)+1=-(\xi^2+2\xi)+(-(-1))$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_negation_distribution.sage` | $-(\xi^2+2\xi)+(-(-1))=-\bigl((\xi^2+2\xi)+(-1)\bigr)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_quadratic_notation.sage` | $-\bigl((\xi^2+2\xi)+(-1)\bigr)=-\bigl(\xi^2+2\xi-1\bigr)$ | PASS | 17点で一致 |
| 逆方向の差と分母の積 | `check_difference_quadratic_substitution.sage` | $-\bigl(\xi^2+2\xi-1\bigr)=-0$ | PASS | 2点で一致 |
| 逆方向の差と分母の積 | `check_difference_negative_zero.sage` | $-0=0$ | PASS | 17点で一致 |
| 差が零から結論へ | `check_conclusion_insert_difference.sage` | $\mathrm{KW}(\xi)=\bigl(\mathrm{KW}(\xi)-\xi\bigr)+\xi$ | PASS | 17点で一致 |
| 差が零から結論へ | `check_conclusion_difference_substitution.sage` | $\bigl(\mathrm{KW}(\xi)-\xi\bigr)+\xi=0+\xi$ | PASS | 2点で一致 |
| 差が零から結論へ | `check_conclusion_zero.sage` | $0+\xi=\xi$ | PASS | 17点で一致 |

`check.sage` は45本を実行後、既存の17点について同値と元の中間段を独立に確かめる。
同値が成立する側は二点、不成立の側は十五点であることも確認する。
全ての行を合わせて705等式が一致した。浮動小数点は使わない。

プロジェクト直下で実行する。

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage sagemath/check/kw-self-dual-quadratic-equivalence/check.sage
```

2026-10-04 実行: 行別45本・計705等式と、既存17点の同値・中間段の統合検査がすべて通過した。
