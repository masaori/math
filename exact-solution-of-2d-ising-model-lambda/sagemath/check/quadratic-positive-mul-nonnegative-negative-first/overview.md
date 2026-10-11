# SageMath Check: 非負係数条件と負の第一係数条件の積

**対象ラベル**: `claim_quadratic_positive_mul_nonnegative_negative_first`

**結果**: PASS（2026-10-11。行別 150 本・延べ 2321196 件、統合 181700 組）。

本文の 145 計算行、積の表示式、四つの正錐への所属を、1 行 1 ファイルで検査する。
`check.sage` が全行と既存の統合検査 `check_global.sage` を実行する。

行別の有理数標本は、分子を 0 から 4、分母を 1 から 4 とした相異なる非負数 12 個、
そのうちの正数 11 個である。非負係数 a,b と正数 c,b′ の 17424 組から、
各行が使う条件だけを選ぶ。背理法の矛盾する仮定をまとめて課さず、平方比較と
消去の各段を非空な局所標本で検査する。等号の仮定と b=0 の枝も、各段を独立に検査する。

積の表示式と四つの所属判定では、`QuadraticField(2)` の二つの根をそれぞれ s とし、
xi と eta の積を実際に数体で計算する。積の係数公式を検査側の定義として用いず、
数体の正規形から係数を読み取る。すべて `QQ` と数体の厳密計算であり、浮動小数点は使わない。
これらは有限標本の検査であり、全称命題の証明は対応する Lean 具体版と必要十分版が担う。

| 本文の対象行 | ファイル | 検査件数 | 状態 |
| --- | --- | ---: | --- |
| 積の表示式 | `check_product_representation.sage` | 21164 | PASS |
| 入力の平方条件・c の定義 | `check_input_square_substitute_negative_first.sage` | 17424 | PASS |
| 入力の平方条件・二つの負号の積 | `check_input_square_remove_two_negatives.sage` | 17424 | PASS |
| 入力の平方条件・負の第一係数条件 | `check_input_square_strict_input_bound.sage` | 10656 | PASS |
| 入力の平方条件・積の結合則 | `check_input_square_associate_twice.sage` | 17424 | PASS |
| 第一係数の書き換え・a′=-c の代入 | `check_normalize_a_substitute_negative_first.sage` | 17424 | PASS |
| 第一係数の書き換え・積の負号 | `check_normalize_a_negative_factor.sage` | 17424 | PASS |
| 第一係数の書き換え・和の可換則 | `check_normalize_a_commute_sum.sage` | 17424 | PASS |
| 第一係数の書き換え・差の定義 | `check_normalize_a_difference_definition.sage` | 17424 | PASS |
| 第二係数の書き換え・a′=-c の代入 | `check_normalize_b_substitute_negative_first.sage` | 17424 | PASS |
| 第二係数の書き換え・積の負号 | `check_normalize_b_negative_factor.sage` | 17424 | PASS |
| 第二係数の書き換え・差の定義 | `check_normalize_b_difference_definition.sage` | 17424 | PASS |
| 平方が等しく b=0 の場合・仮定した平方の等号 | `check_zero_square_assumed_square_equality.sage` | 121 | PASS |
| 平方が等しく b=0 の場合・b=0 の代入 | `check_zero_square_substitute_zero.sage` | 1452 | PASS |
| 平方が等しく b=0 の場合・零との積 | `check_zero_square_inner_zero_product.sage` | 17424 | PASS |
| 平方が等しく b=0 の場合・零との積 | `check_zero_square_outer_zero_product.sage` | 17424 | PASS |
| 第一の場合で a=0 と仮定した平方・a=0 の代入 | `check_first_a_zero_substitute_zero.sage` | 1452 | PASS |
| 第一の場合で a=0 と仮定した平方・零との積 | `check_first_a_zero_zero_product.sage` | 17424 | PASS |
| 第一の場合の背理法で b=0 と仮定した積・b=0 の代入 | `check_first_b_zero_substitute_zero.sage` | 1452 | PASS |
| 第一の場合の背理法で b=0 と仮定した積・零との積 | `check_first_b_zero_zero_product.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_left_associate_outer.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_left_associate_inner.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の可換則 | `check_first_contradiction_left_commute_middle.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_left_associate_nested.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_left_group_square.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・非負の二数の平方の大小 | `check_first_contradiction_square_bound.sage` | 9094 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_right_ungroup_square.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_right_associate_nested.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の可換則 | `check_first_contradiction_right_commute_middle.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_right_associate_inner.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_right_group_products.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・正数を掛けると狭義不等号を保つ | `check_first_contradiction_strict_square_bound.sage` | 9768 | PASS |
| 第一の場合の背理法の平方比較・積の結合則 | `check_first_contradiction_associate_right_factor.sage` | 17424 | PASS |
| 第一の場合の背理法の平方比較・積の可換則 | `check_first_contradiction_commute_right_factor.sage` | 17424 | PASS |
| 第一の場合の矛盾となる比較・正因子 b′b′ の消去 | `check_first_cancel_cancel_positive_factor.sage` | 10285 | PASS |
| 第一の場合で第一係数が非負の積の所属 | `check_first_nonnegative_membership.sage` | 4398 | PASS |
| 第一係数の負号を外した量・C の定義 | `check_first_c_negative_definition.sage` | 17424 | PASS |
| 第一係数の負号を外した量・A の表示式の代入 | `check_first_c_substitute_first_coefficient.sage` | 17424 | PASS |
| 第一係数の負号を外した量・差の負号 | `check_first_c_negate_difference.sage` | 17424 | PASS |
| 第一の場合の非負係数倍・非負数を掛けると不等号を保つ | `check_first_step_multiply_bound.sage` | 10656 | PASS |
| 第一の場合の線形比較・C の表示式の代入 | `check_first_linear_substitute_negative_coefficient.sage` | 17424 | PASS |
| 第一の場合の線形比較・差に対する分配則 | `check_first_linear_distribute_left_factor.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の結合則 | `check_first_linear_associate_products.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の可換則 | `check_first_linear_commute_leading_factors.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の結合則 | `check_first_linear_associate_leading_products.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の結合則 | `check_first_linear_associate_inner_product.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の可換則 | `check_first_linear_commute_inner_products.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の結合則 | `check_first_linear_associate_inner_square.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の結合則 | `check_first_linear_group_twice_b.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の可換則 | `check_first_linear_commute_twice_b.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の結合則 | `check_first_linear_associate_multiplier.sage` | 17424 | PASS |
| 第一の場合の線形比較・同じ数から引くと不等号が逆向きになる | `check_first_linear_subtract_product_bound.sage` | 10656 | PASS |
| 第一の場合の線形比較・積の結合則 | `check_first_linear_associate_difference_factors.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の可換則 | `check_first_linear_commute_difference_factors.sage` | 17424 | PASS |
| 第一の場合の線形比較・積の結合則 | `check_first_linear_associate_difference_products.sage` | 17424 | PASS |
| 第一の場合の線形比較・差に対する分配則 | `check_first_linear_factor_difference.sage` | 17424 | PASS |
| 第一の場合の線形比較・B の表示式の代入 | `check_first_linear_restore_second_coefficient.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_left_associate_outer.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_left_associate_inner.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の可換則 | `check_first_square_left_commute_middle.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_left_associate_nested.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_left_group_square.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・非負の二数の平方の大小 | `check_first_square_square_linear_bound.sage` | 3023 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_right_ungroup_square.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_right_associate_nested.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の可換則 | `check_first_square_right_commute_middle.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_right_associate_inner.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_right_group_products.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・正数を掛けると狭義不等号を保つ | `check_first_square_strict_square_bound.sage` | 6819 | PASS |
| 第一の場合の線形比較の平方・積の可換則 | `check_first_square_commute_twice_square.sage` | 17424 | PASS |
| 第一の場合の線形比較の平方・積の結合則 | `check_first_square_group_right_factor.sage` | 17424 | PASS |
| 第一の場合の負の第一係数条件・二つの負号の積 | `check_first_final_insert_negative_squares.sage` | 17424 | PASS |
| 第一の場合の負の第一係数条件・C の定義 | `check_first_final_substitute_negative_first.sage` | 17424 | PASS |
| 第一の場合の負の第一係数条件・正因子 b′b′ の消去 | `check_first_final_cancel_positive_factor.sage` | 8287 | PASS |
| 第一の場合で第一係数が負の積の所属 | `check_first_negative_membership.sage` | 4186 | PASS |
| 第二の場合で b=0 と仮定した平方・b=0 の代入 | `check_second_b_zero_substitute_zero.sage` | 1452 | PASS |
| 第二の場合で b=0 と仮定した平方・零との積 | `check_second_b_zero_inner_zero_product.sage` | 17424 | PASS |
| 第二の場合で b=0 と仮定した平方・零との積 | `check_second_b_zero_outer_zero_product.sage` | 17424 | PASS |
| 第二の場合の背理法で a=0 と仮定した積・a=0 の代入 | `check_second_a_zero_substitute_zero.sage` | 1452 | PASS |
| 第二の場合の背理法で a=0 と仮定した積・零との積 | `check_second_a_zero_zero_product.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_associate_outer.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_associate_inner.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の可換則 | `check_second_contradiction_commute_middle.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_group_two_factors.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_inner_associate_outer.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_inner_associate_inner.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の可換則 | `check_second_contradiction_inner_commute_middle.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_inner_associate_nested.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_inner_group_square.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_ungroup_two_factors.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の可換則 | `check_second_contradiction_commute_two_factor.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_associate_right.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_group_doubled_square.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・非負の二数の平方の大小 | `check_second_contradiction_square_bound.sage` | 6803 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_right_ungroup_square.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_right_associate_nested.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の可換則 | `check_second_contradiction_right_commute_middle.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_right_associate_inner.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・積の結合則 | `check_second_contradiction_right_group_products.sage` | 17424 | PASS |
| 第二の場合の背理法の平方比較・正数を掛けると狭義不等号を保つ | `check_second_contradiction_strict_square_bound.sage` | 9768 | PASS |
| 第二の場合の矛盾となる比較・正因子 2(b′b′) の消去 | `check_second_cancel_cancel_positive_factor.sage` | 7018 | PASS |
| 第二の場合で第二係数が非負の積の所属 | `check_second_nonnegative_membership.sage` | 5898 | PASS |
| 第二係数の負号を外した量・V の定義 | `check_second_v_negative_definition.sage` | 17424 | PASS |
| 第二係数の負号を外した量・B の表示式の代入 | `check_second_v_substitute_second_coefficient.sage` | 17424 | PASS |
| 第二係数の負号を外した量・差の負号 | `check_second_v_negate_difference.sage` | 17424 | PASS |
| 第二の場合の非負係数倍・非負数を掛けると不等号を保つ | `check_second_step_multiply_bound.sage` | 10656 | PASS |
| 第二の場合の線形比較・V の表示式の代入 | `check_second_linear_substitute_negative_coefficient.sage` | 17424 | PASS |
| 第二の場合の線形比較・差に対する分配則 | `check_second_linear_distribute_left_factor.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_associate_two_products.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_associate_inner_products.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の可換則 | `check_second_linear_commute_inner_products.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_associate_inner_squares.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の可換則 | `check_second_linear_commute_inner_factors.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_group_twice_a.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の可換則 | `check_second_linear_commute_twice_a.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_associate_multiplier.sage` | 17424 | PASS |
| 第二の場合の線形比較・同じ数から引くと不等号が逆向きになる | `check_second_linear_subtract_product_bound.sage` | 10656 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_associate_difference_factors.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の可換則 | `check_second_linear_commute_difference_factors.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_associate_difference_products.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_group_twice_c.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の可換則 | `check_second_linear_commute_twice_c.sage` | 17424 | PASS |
| 第二の場合の線形比較・積の結合則 | `check_second_linear_associate_outer_products.sage` | 17424 | PASS |
| 第二の場合の線形比較・差に対する分配則 | `check_second_linear_factor_difference.sage` | 17424 | PASS |
| 第二の場合の線形比較・A の表示式の代入 | `check_second_linear_restore_first_coefficient.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_associate_outer.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_associate_inner.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の可換則 | `check_second_square_commute_middle.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_group_two_factors.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_inner_associate_outer.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_inner_associate_inner.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の可換則 | `check_second_square_inner_commute_middle.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_inner_associate_nested.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_inner_group_square.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_ungroup_two_factors.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の可換則 | `check_second_square_commute_two_factor.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_associate_right.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_group_doubled_square.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_associate_linear_factors.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・非負の二数の平方の大小 | `check_second_square_square_linear_bound.sage` | 4401 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_right_ungroup_square.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_right_associate_nested.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の可換則 | `check_second_square_right_commute_middle.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_right_associate_inner.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・積の結合則 | `check_second_square_right_group_products.sage` | 17424 | PASS |
| 第二の場合の線形比較の平方・正数を掛けると狭義不等号を保つ | `check_second_square_strict_square_bound.sage` | 8197 | PASS |
| 第二の場合の負の第二係数条件・二つの負号の積 | `check_second_final_insert_negative_squares.sage` | 17424 | PASS |
| 第二の場合の負の第二係数条件・V の定義 | `check_second_final_substitute_negative_second.sage` | 17424 | PASS |
| 第二の場合の負の第二係数条件・正因子 2(b′b′) の消去 | `check_second_final_cancel_positive_factor.sage` | 9016 | PASS |
| 第二の場合で第二係数が負の積の所属 | `check_second_negative_membership.sage` | 6682 | PASS |
| 統合検査（二つの平方比較・四つの符号場合） | `check_global.sage` | 181700 | PASS |

実行は次のとおり。すべて終了コード 0 で通過した。

```sh
/home/masaori/.local/share/math-mamba/envs/sage/bin/sage -c "__file__ = 'sagemath/check/quadratic-positive-mul-nonnegative-negative-first/check.sage'; load(__file__)"
```

統合検査の四場合は、第一の場合の非負第一係数 40060 組・負第一係数 34516 組、
第二の場合の非負第二係数 51254 組・負第二係数 55870 組だった。
行別の所属検査は、二つの根の合計で順に 4398 件・4186 件・5898 件・6682 件、
積の表示式は 21164 件だった。行別計算に失敗・空な検査はなかった。
