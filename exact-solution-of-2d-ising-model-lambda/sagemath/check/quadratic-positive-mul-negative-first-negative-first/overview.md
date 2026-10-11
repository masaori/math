# SageMath Check: 負の第一係数条件どうしの積

**対象ラベル**: `claim_quadratic_positive_mul_negative_first_negative_first`

2026-10-11 実行済み。本文93計算・判定行を一行一ファイルで検査し、保存した統合検算と合わせた94ファイルがすべて PASS。

恒等式69行は `QQ` 上の多項式環、順序比較22行は分子・分母が1〜6の正有理数から取った99,856組で検査する。標本は $(a,b)=(-c,b)$、$(a',b')=(-c',b')$ が負の第一係数条件を満たすように選び、結論で絞り込まない。

積の表示1行は、有理係数の多項式を係数とする二次商環で両根について実際に積を作り、その正規形から係数を抽出する。最後の所属1行は、二次数体の両根に対する199,712組で実際の積から表示を復元し、正錐の負の第二係数条件を直接検査する。所属条件の積の括弧も本文の定義と揃える。浮動小数点や実数体への脱出はない。

有限標本の検算は、任意の入力に対する本文とLeanの証明の代用ではない。

| ファイル | 本文の計算・判定 | 状態 | 結果 |
|---|---|---|---|
| `check.sage` | 既存の統合検算 | PASS | 99,856組 |
| `check_representation_multiplication.sage` | 積の表示：積の表示の主張 | PASS | 二次商環の両根 |
| `check_representation_product.sage` | 積の表示：A,B の定義 | PASS | QQ多項式の恒等式 |
| `check_input_first_negative.sage` | 入力係数の符号：正錐の定義 | PASS | 99,856組 |
| `check_input_second_negative.sage` | 入力係数の符号：正錐の定義 | PASS | 99,856組 |
| `check_input_first_positive.sage` | 入力係数の符号：正錐の定義 | PASS | 99,856組 |
| `check_input_second_positive.sage` | 入力係数の符号：正錐の定義 | PASS | 99,856組 |
| `check_negated_first_positive.sage` | 入力係数の符号：負数の加法逆元 | PASS | 99,856組 |
| `check_negated_second_positive.sage` | 入力係数の符号：負数の加法逆元 | PASS | 99,856組 |
| `check_first_negative_involution.sage` | 入力係数の符号：加法逆元の二重適用 | PASS | QQ多項式の恒等式 |
| `check_second_negative_involution.sage` | 入力係数の符号：加法逆元の二重適用 | PASS | QQ多項式の恒等式 |
| `check_first_input_square_substitute_negative.sage` | 第一入力の平方比較：c の定義 | PASS | QQ多項式の恒等式 |
| `check_first_input_square_negative_product.sage` | 第一入力の平方比較：負号どうしの積 | PASS | QQ多項式の恒等式 |
| `check_first_input_square_input_comparison.sage` | 第一入力の平方比較：正錐の定義 | PASS | 99,856組 |
| `check_first_input_square_association.sage` | 第一入力の平方比較：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_input_square_substitute_negative.sage` | 第二入力の平方比較：c' の定義 | PASS | QQ多項式の恒等式 |
| `check_second_input_square_negative_product.sage` | 第二入力の平方比較：負号どうしの積 | PASS | QQ多項式の恒等式 |
| `check_second_input_square_input_comparison.sage` | 第二入力の平方比較：正錐の定義 | PASS | 99,856組 |
| `check_second_input_square_association.sage` | 第二入力の平方比較：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_regroup_associate_outer.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_regroup_associate_middle.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_regroup_commute_middle.sage` | 四因子の並べ替え：積の可換則 | PASS | QQ多項式の恒等式 |
| `check_regroup_reassociate_middle.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_regroup_regroup_outer.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_definition.sage` | 第一係数の表示：A の定義 | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_negative_substitution.sage` | 第一係数の表示：a=-c, a'=-c' | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_negative_product.sage` | 第一係数の表示：負号どうしの積 | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_definition.sage` | 第二係数の表示：B の定義 | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_negative_substitution.sage` | 第二係数の表示：a=-c, a'=-c' | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_left_negative.sage` | 第二係数の表示：左因子の負号 | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_right_negative.sage` | 第二係数の表示：右因子の負号 | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_negative_sum.sage` | 第二係数の表示：和の負号 | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_v_definition.sage` | 第二係数の表示：V の定義 | PASS | QQ多項式の恒等式 |
| `check_two_positive.sage` | 係数と平方差の符号：有理数の順序 | PASS | 99,856組 |
| `check_first_product_positive.sage` | 係数と平方差の符号：0<c, 0<c' | PASS | 99,856組 |
| `check_second_parts_product_positive.sage` | 係数と平方差の符号：0<b, 0<b' | PASS | 99,856組 |
| `check_doubled_second_parts_positive.sage` | 係数と平方差の符号：0<2, 0<b· b' | PASS | 99,856組 |
| `check_first_coefficient_positive_sum.sage` | 係数と平方差の符号：正数どうしの和 | PASS | 99,856組 |
| `check_first_coefficient_positive.sage` | 係数と平方差の符号：第一係数の表示 | PASS | QQ多項式の恒等式 |
| `check_left_cross_positive.sage` | 係数と平方差の符号：0<c, 0<b' | PASS | 99,856組 |
| `check_right_cross_positive.sage` | 係数と平方差の符号：0<b, 0<c' | PASS | 99,856組 |
| `check_cross_sum_positive.sage` | 係数と平方差の符号：正数どうしの和 | PASS | 99,856組 |
| `check_cross_sum_definition.sage` | 係数と平方差の符号：V の定義 | PASS | QQ多項式の恒等式 |
| `check_second_coefficient_negative_substitution.sage` | 係数と平方差の符号：第二係数の表示 | PASS | QQ多項式の恒等式 |
| `check_second_coefficient_negative.sage` | 係数と平方差の符号：0<V | PASS | 99,856組 |
| `check_difference_positive.sage` | 係数と平方差の符号：c· c<2·(b· b) の移項 | PASS | 99,856組 |
| `check_difference_definition.sage` | 係数と平方差の符号：D の定義 | PASS | QQ多項式の恒等式 |
| `check_difference_comparison_factor_difference.sage` | 正因子による比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_difference_comparison_d_definition.sage` | 正因子による比較：D の定義 | PASS | QQ多項式の恒等式 |
| `check_difference_comparison_multiply_strict.sage` | 正因子による比較：正因子 D を掛ける | PASS | 99,856組 |
| `check_difference_comparison_d_substitution.sage` | 正因子による比較：D の定義 | PASS | QQ多項式の恒等式 |
| `check_difference_comparison_expand_difference.sage` | 正因子による比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_move_difference_terms.sage` | 比較の移項：上の比較の移項 | PASS | 99,856組 |
| `check_first_square_substitute_coefficient.sage` | 第一係数の平方展開：第一係数の表示 | PASS | QQ多項式の恒等式 |
| `check_first_square_distribute_left.sage` | 第一係数の平方展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_first_square_distribute_right.sage` | 第一係数の平方展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_first_square_regroup_squares.sage` | 第一係数の平方展開：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_first_square_regroup_last_square.sage` | 第一係数の平方展開：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_first_square_unregroup_last.sage` | 第一係数の平方展開：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_first_square_associate_cross.sage` | 第一係数の平方展開：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_first_square_commute_cross.sage` | 第一係数の平方展開：積の可換則 | PASS | QQ多項式の恒等式 |
| `check_first_square_reassociate_cross.sage` | 第一係数の平方展開：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_first_square_associate_sum.sage` | 第一係数の平方展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_first_square_factor_two_copies.sage` | 第一係数の平方展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_first_square_add_constants.sage` | 第一係数の平方展開：2+2=4 | PASS | QQ多項式の恒等式 |
| `check_first_square_associate_last_sum.sage` | 第一係数の平方展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_first_square_commute_last_sum.sage` | 第一係数の平方展開：和の可換則 | PASS | QQ多項式の恒等式 |
| `check_first_square_reassociate_last_sum.sage` | 第一係数の平方展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_first_square_commute_output.sage` | 第一係数の平方展開：和の可換則 | PASS | QQ多項式の恒等式 |
| `check_second_square_substitute_coefficient.sage` | 第二係数の平方からの比較：第二係数の表示 | PASS | QQ多項式の恒等式 |
| `check_second_square_negative_product.sage` | 第二係数の平方からの比較：負号どうしの積 | PASS | QQ多項式の恒等式 |
| `check_second_square_v_substitution.sage` | 第二係数の平方からの比較：V の定義 | PASS | QQ多項式の恒等式 |
| `check_second_square_distribute_left.sage` | 第二係数の平方からの比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_distribute_right.sage` | 第二係数の平方からの比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_regroup_products.sage` | 第二係数の平方からの比較：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_second_square_commute_factors.sage` | 第二係数の平方からの比較：積の可換則 | PASS | QQ多項式の恒等式 |
| `check_second_square_regroup_cross.sage` | 第二係数の平方からの比較：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_second_square_distribute_two_outer.sage` | 第二係数の平方からの比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_distribute_two_inner.sage` | 第二係数の平方からの比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_associate_sum.sage` | 第二係数の平方からの比較：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_factor_two_copies.sage` | 第二係数の平方からの比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_add_constants.sage` | 第二係数の平方からの比較：2+2=4 | PASS | QQ多項式の恒等式 |
| `check_second_square_associate_square_coefficients.sage` | 第二係数の平方からの比較：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_commute_square_coefficient.sage` | 第二係数の平方からの比較：積の可換則 | PASS | QQ多項式の恒等式 |
| `check_second_square_reassociate_square_coefficient.sage` | 第二係数の平方からの比較：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_associate_last_sum.sage` | 第二係数の平方からの比較：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_commute_last_sum.sage` | 第二係数の平方からの比較：和の可換則 | PASS | QQ多項式の恒等式 |
| `check_second_square_reassociate_last_sum.sage` | 第二係数の平方からの比較：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_commute_comparison.sage` | 第二係数の平方からの比較：和の可換則 | PASS | QQ多項式の恒等式 |
| `check_second_square_add_same_cross.sage` | 第二係数の平方からの比較：移項した比較の両辺へ同じ項を加える | PASS | 99,856組 |
| `check_second_square_first_square.sage` | 第二係数の平方からの比較：第一係数の平方の展開 | PASS | QQ多項式の恒等式 |
| `check_output_square_association.sage` | 定義の形での平方比較：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_output_square_comparison.sage` | 定義の形での平方比較：上で示した平方の比較 | PASS | 99,856組 |
| `check_product_positive_cone_both_roots.sage` | 正錐所属：0<A, B<0, (2· B)· B<A· A, 正錐の定義 | PASS | 199,712組 |

既存の統合検算の記録は2026-08-14、99,856組で PASS。同じコードを保存して今回も再実行した。

実行方法（プロジェクト直下。各ファイルは単独でも実行できる）:

```sh
sage -c "from pathlib import Path; fs=sorted(Path('sagemath/check/quadratic-positive-mul-negative-first-negative-first').glob('check*.sage')); [(globals().update(__file__=str(f)),load(str(f))) for f in fs]"
```
