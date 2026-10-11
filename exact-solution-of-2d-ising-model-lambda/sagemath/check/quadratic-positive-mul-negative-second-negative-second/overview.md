# SageMath Check: 負の第二係数条件どうしの積

**対象ラベル**: `claim_quadratic_positive_mul_negative_second_negative_second`

本文の計算・判定 87 行を一行一ファイルで確認する。恒等式は `QQ` 上の多項式環、順序比較は分子・分母が 1〜6 の正有理数のうち負の第二係数条件を満たす 45,369 組を使う。積の表示は二次商環で実際の積から係数を取り出し、最後の正錐所属は二次数体の両根を使う 90,738 組で直接確かめる。浮動小数点や実数体への脱出はない。

実行日: 2026-10-11。有限検算は一般の証明の代用ではない。

| ファイル | 本文の計算・判定 | 状態 | 結果 |
|---|---|---|---|
| `check.sage` | 既存の統合検算 | PASS | 45,369 組 |
| `check_representation_multiplication.sage` | 二次商環での積の表示 | PASS | 二次商環の積の係数 |
| `check_representation_product.sage` | 積の表示と係数の定義 | PASS | QQ 上の恒等式 |
| `check_input_first_positive.sage` | \blkref{def_quadratic_positive_cone} | PASS | 45,369 組 |
| `check_input_second_positive.sage` | \blkref{def_quadratic_positive_cone} | PASS | 45,369 組 |
| `check_input_first_negative.sage` | \blkref{def_quadratic_positive_cone} | PASS | 45,369 組 |
| `check_input_second_negative.sage` | \blkref{def_quadratic_positive_cone} | PASS | 45,369 組 |
| `check_negated_first_positive.sage` | \text{負数の加法逆元} | PASS | 45,369 組 |
| `check_negated_second_positive.sage` | \text{負数の加法逆元} | PASS | 45,369 組 |
| `check_first_negative_involution.sage` | \text{加法逆元の二重適用} | PASS | QQ 上の恒等式 |
| `check_second_negative_involution.sage` | \text{加法逆元の二重適用} | PASS | QQ 上の恒等式 |
| `check_first_input_square_substitute_negative.sage` | 入力の平方比較：u と u′ の定義 | PASS | QQ 上の恒等式 |
| `check_first_input_square_negative_product.sage` | 入力の平方比較：負号どうしの積 | PASS | QQ 上の恒等式 |
| `check_first_input_square_input_comparison.sage` | 入力の平方比較：正錐の仮定 | PASS | 45,369 組 |
| `check_second_input_square_substitute_negative.sage` | 入力の平方比較：u と u′ の定義 | PASS | QQ 上の恒等式 |
| `check_second_input_square_negative_product.sage` | 入力の平方比較：負号どうしの積 | PASS | QQ 上の恒等式 |
| `check_second_input_square_input_comparison.sage` | 入力の平方比較：正錐の仮定 | PASS | 45,369 組 |
| `check_regroup_associate_outer.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ 上の恒等式 |
| `check_regroup_associate_middle.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ 上の恒等式 |
| `check_regroup_commute_middle.sage` | 四因子の並べ替え：積の可換則 | PASS | QQ 上の恒等式 |
| `check_regroup_reassociate_middle.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ 上の恒等式 |
| `check_regroup_regroup_outer.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ 上の恒等式 |
| `check_coefficient_a_definition.sage` | 第一係数の表示：A の定義 | PASS | QQ 上の恒等式 |
| `check_coefficient_a_negative_substitution.sage` | 第一係数の表示：b=-u と b′=-u′ | PASS | QQ 上の恒等式 |
| `check_coefficient_a_negative_product.sage` | 第一係数の表示：負号どうしの積 | PASS | QQ 上の恒等式 |
| `check_coefficient_b_definition.sage` | 第二係数の表示：B の定義 | PASS | QQ 上の恒等式 |
| `check_coefficient_b_negative_substitution.sage` | 第二係数の表示：b=-u と b′=-u′ | PASS | QQ 上の恒等式 |
| `check_coefficient_b_right_negative.sage` | 第二係数の表示：右因子の負号 | PASS | QQ 上の恒等式 |
| `check_coefficient_b_left_negative.sage` | 第二係数の表示：左因子の負号 | PASS | QQ 上の恒等式 |
| `check_coefficient_b_negative_sum.sage` | 第二係数の表示：和の負号 | PASS | QQ 上の恒等式 |
| `check_coefficient_b_v_definition.sage` | 第二係数の表示：V の定義 | PASS | QQ 上の恒等式 |
| `check_two_positive.sage` | \text{有理数の順序} | PASS | 45,369 組 |
| `check_first_product_positive.sage` | 0<a,\ 0<a\prime | PASS | 45,369 組 |
| `check_negative_parts_product_positive.sage` | 0<u,\ 0<u\prime | PASS | 45,369 組 |
| `check_doubled_negative_parts_positive.sage` | 0<2,\ 0<u\cdot u\prime | PASS | 45,369 組 |
| `check_first_coefficient_positive_sum.sage` | \text{正数どうしの和} | PASS | 45,369 組 |
| `check_first_coefficient_positive.sage` | \text{第一係数の表示} | PASS | QQ 上の恒等式 |
| `check_left_cross_positive.sage` | 0<a,\ 0<u\prime | PASS | 45,369 組 |
| `check_right_cross_positive.sage` | 0<u,\ 0<a\prime | PASS | 45,369 組 |
| `check_cross_sum_positive.sage` | \text{正数どうしの和} | PASS | 45,369 組 |
| `check_cross_sum_definition.sage` | V\text{ の定義} | PASS | QQ 上の恒等式 |
| `check_second_coefficient_negative_substitution.sage` | \text{第二係数の表示} | PASS | QQ 上の恒等式 |
| `check_second_coefficient_negative.sage` | 0<V | PASS | 45,369 組 |
| `check_difference_positive.sage` | 2\cdot(u\cdot u)<a\cdot a\text{ の移項} | PASS | 45,369 組 |
| `check_difference_definition.sage` | D\text{ の定義} | PASS | QQ 上の恒等式 |
| `check_difference_comparison_factor_difference.sage` | 正因子を掛けた比較：分配則 | PASS | QQ 上の恒等式 |
| `check_difference_comparison_d_definition.sage` | 正因子を掛けた比較：D の定義 | PASS | QQ 上の恒等式 |
| `check_difference_comparison_multiply_strict.sage` | 正因子を掛けた比較：正因子 D を掛ける | PASS | 45,369 組 |
| `check_difference_comparison_d_substitution.sage` | 正因子を掛けた比較：D の定義 | PASS | QQ 上の恒等式 |
| `check_difference_comparison_expand_difference.sage` | 正因子を掛けた比較：分配則 | PASS | QQ 上の恒等式 |
| `check_move_difference_terms.sage` | \text{上の比較の移項} | PASS | 45,369 組 |
| `check_first_square_substitute_coefficient.sage` | 第一係数の平方の展開：第一係数の表示 | PASS | QQ 上の恒等式 |
| `check_first_square_distribute_left.sage` | 第一係数の平方の展開：分配則 | PASS | QQ 上の恒等式 |
| `check_first_square_distribute_right.sage` | 第一係数の平方の展開：分配則 | PASS | QQ 上の恒等式 |
| `check_first_square_regroup_squares.sage` | 第一係数の平方の展開：上の四因子の並べ替え | PASS | QQ 上の恒等式 |
| `check_first_square_regroup_last_square.sage` | 第一係数の平方の展開：上の四因子の並べ替え | PASS | QQ 上の恒等式 |
| `check_first_square_unregroup_last.sage` | 第一係数の平方の展開：上の四因子の並べ替え | PASS | QQ 上の恒等式 |
| `check_first_square_associate_cross.sage` | 第一係数の平方の展開：積の結合則 | PASS | QQ 上の恒等式 |
| `check_first_square_commute_cross.sage` | 第一係数の平方の展開：積の可換則 | PASS | QQ 上の恒等式 |
| `check_first_square_reassociate_cross.sage` | 第一係数の平方の展開：積の結合則 | PASS | QQ 上の恒等式 |
| `check_first_square_associate_sum.sage` | 第一係数の平方の展開：和の結合則 | PASS | QQ 上の恒等式 |
| `check_first_square_factor_two_copies.sage` | 第一係数の平方の展開：分配則 | PASS | QQ 上の恒等式 |
| `check_first_square_add_constants.sage` | 第一係数の平方の展開：2+2=4 | PASS | QQ 上の恒等式 |
| `check_first_square_associate_last_sum.sage` | 第一係数の平方の展開：和の結合則 | PASS | QQ 上の恒等式 |
| `check_first_square_commute_last_sum.sage` | 第一係数の平方の展開：和の可換則 | PASS | QQ 上の恒等式 |
| `check_first_square_reassociate_last_sum.sage` | 第一係数の平方の展開：和の結合則 | PASS | QQ 上の恒等式 |
| `check_second_square_substitute_coefficient.sage` | 第二係数の平方から第一係数の平方への比較：第二係数の表示 | PASS | QQ 上の恒等式 |
| `check_second_square_negative_product.sage` | 第二係数の平方から第一係数の平方への比較：負号どうしの積 | PASS | QQ 上の恒等式 |
| `check_second_square_v_substitution.sage` | 第二係数の平方から第一係数の平方への比較：V の定義 | PASS | QQ 上の恒等式 |
| `check_second_square_distribute_left.sage` | 第二係数の平方から第一係数の平方への比較：分配則 | PASS | QQ 上の恒等式 |
| `check_second_square_distribute_right.sage` | 第二係数の平方から第一係数の平方への比較：分配則 | PASS | QQ 上の恒等式 |
| `check_second_square_regroup_products.sage` | 第二係数の平方から第一係数の平方への比較：上の四因子の並べ替え | PASS | QQ 上の恒等式 |
| `check_second_square_commute_factors.sage` | 第二係数の平方から第一係数の平方への比較：積の可換則 | PASS | QQ 上の恒等式 |
| `check_second_square_regroup_cross.sage` | 第二係数の平方から第一係数の平方への比較：上の四因子の並べ替え | PASS | QQ 上の恒等式 |
| `check_second_square_distribute_two_outer.sage` | 第二係数の平方から第一係数の平方への比較：分配則 | PASS | QQ 上の恒等式 |
| `check_second_square_distribute_two_inner.sage` | 第二係数の平方から第一係数の平方への比較：分配則 | PASS | QQ 上の恒等式 |
| `check_second_square_associate_sum.sage` | 第二係数の平方から第一係数の平方への比較：和の結合則 | PASS | QQ 上の恒等式 |
| `check_second_square_factor_two_copies.sage` | 第二係数の平方から第一係数の平方への比較：分配則 | PASS | QQ 上の恒等式 |
| `check_second_square_add_constants.sage` | 第二係数の平方から第一係数の平方への比較：2+2=4 | PASS | QQ 上の恒等式 |
| `check_second_square_associate_square_coefficients.sage` | 第二係数の平方から第一係数の平方への比較：積の結合則 | PASS | QQ 上の恒等式 |
| `check_second_square_commute_square_coefficient.sage` | 第二係数の平方から第一係数の平方への比較：積の可換則 | PASS | QQ 上の恒等式 |
| `check_second_square_reassociate_square_coefficient.sage` | 第二係数の平方から第一係数の平方への比較：積の結合則 | PASS | QQ 上の恒等式 |
| `check_second_square_associate_last_sum.sage` | 第二係数の平方から第一係数の平方への比較：和の結合則 | PASS | QQ 上の恒等式 |
| `check_second_square_commute_last_sum.sage` | 第二係数の平方から第一係数の平方への比較：和の可換則 | PASS | QQ 上の恒等式 |
| `check_second_square_reassociate_last_sum.sage` | 第二係数の平方から第一係数の平方への比較：和の結合則 | PASS | QQ 上の恒等式 |
| `check_second_square_add_same_cross.sage` | 第二係数の平方から第一係数の平方への比較：移項した比較の両辺へ同じ項を加える | PASS | 45,369 組 |
| `check_second_square_first_square.sage` | 第二係数の平方から第一係数の平方への比較：第一係数の平方の展開 | PASS | QQ 上の恒等式 |
| `check_product_positive_cone_both_roots.sage` | 二次数体の両根で実際の積の正錐所属 | PASS | 両根で 90,738 組 |

既存の統合検算の実行記録: 2026-08-14、45,369 組で PASS。

実行方法（各ファイルは単独でも実行できる）:

```sh
sage -c "import glob; fs=sorted(glob.glob('sagemath/check/quadratic-positive-mul-negative-second-negative-second/check*.sage')); [(globals().update(__file__=f),load(f)) for f in fs]"
```
