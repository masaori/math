# SageMath Check: 二つの混合符号条件の積

**対象ラベル**: `claim_quadratic_positive_mul_mixed_signs`

2026-10-11 に本文93行と保存した統合検算がすべて PASS。

対象は `structured-latex/content/main-text.ts` の `fisher_zero_claim_quadratic_positive_mul_mixed_signs`。本文93計算・判定行を一行一ファイルへ対応させた。既存の `check.sage` は変更せず保持している。

恒等式69行は `QQ[a,u,cp,bp,p,q,r,t]` の多項式の等式として検査する。符号を反転した係数は `b=-u`、`ap=-cp` と定義する。結合則・可換則・分配則の別々の行を、それぞれ別ファイルで検査する。

順序比較22行は、分子と分母がともに1〜6の正有理数から選んだ67,308組で検査する。入力条件は $a,u,c',b'>0$、$2u^2<a^2$、$(c')^2<2(b')^2$ だけであり、$A<0$、$B>0$、$D>0$ や結論の平方比較を標本選択の条件にしない。すべての比較は `QQ` の厳密な順序で判定する。

積の表示の一行は、多項式環を係数とする二次商環の両根について実際の積を計算し、正規形から係数を取り出す。最後の所属の一行は、二次数体の両根の134,616例で実際の積から表示を復元し、正錐の負の第一係数条件を直接判定する。平方比較の括弧も本文の定義 $A\cdot A<(2\cdot B)\cdot B$ と揃える。浮動小数点や実数体への脱出はない。

有限標本の順序比較・所属検算は一般命題の証明ではない。任意の入力に対する証明は本文と Lean が担う。

## 行ごとの対応

表の順序が本文の順序であり、各ファイルの冒頭に等式・不等式の両辺と根拠を記載する。

| ファイル | 本文の計算・判定 | 状態 | 結果 |
|---|---|---|---|
| `check.sage` | 保存した統合検算 | PASS | 67,308組（2026-10-11再実行） |
| `check_representation_multiplication.sage` | 積の表示：積の表示の主張 | PASS | 二次商環の両根 |
| `check_representation_product.sage` | 積の表示：A,B の定義 | PASS | QQ多項式の恒等式 |
| `check_input_first_positive.sage` | 入力係数の符号：正錐の定義 | PASS | 67,308組 |
| `check_input_first_second_negative.sage` | 入力係数の符号：正錐の定義 | PASS | 67,308組 |
| `check_input_second_first_negative.sage` | 入力係数の符号：正錐の定義 | PASS | 67,308組 |
| `check_input_second_positive.sage` | 入力係数の符号：正錐の定義 | PASS | 67,308組 |
| `check_negated_second_positive.sage` | 入力係数の符号：負数の加法逆元 | PASS | 67,308組 |
| `check_negated_first_positive.sage` | 入力係数の符号：負数の加法逆元 | PASS | 67,308組 |
| `check_coefficient_b_negative_involution.sage` | 入力係数の符号：加法逆元の二重適用 | PASS | QQ多項式の恒等式 |
| `check_coefficient_ap_negative_involution.sage` | 入力係数の符号：加法逆元の二重適用 | PASS | QQ多項式の恒等式 |
| `check_first_input_square_negative_substitution.sage` | 第一入力の平方比較：u の定義 | PASS | QQ多項式の恒等式 |
| `check_first_input_square_negative_product.sage` | 第一入力の平方比較：負号どうしの積 | PASS | QQ多項式の恒等式 |
| `check_first_input_square_association.sage` | 第一入力の平方比較：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_first_input_square_input_comparison.sage` | 第一入力の平方比較：正錐の定義 | PASS | 67,308組 |
| `check_second_input_square_negative_substitution.sage` | 第二入力の平方比較：c' の定義 | PASS | QQ多項式の恒等式 |
| `check_second_input_square_negative_product.sage` | 第二入力の平方比較：負号どうしの積 | PASS | QQ多項式の恒等式 |
| `check_second_input_square_input_comparison.sage` | 第二入力の平方比較：正錐の定義 | PASS | 67,308組 |
| `check_second_input_square_association.sage` | 第二入力の平方比較：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_regroup_associate_outer.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_regroup_associate_middle.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_regroup_commute_middle.sage` | 四因子の並べ替え：積の可換則 | PASS | QQ多項式の恒等式 |
| `check_regroup_reassociate_middle.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_regroup_regroup_outer.sage` | 四因子の並べ替え：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_definition.sage` | 第一係数の表示：A の定義 | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_negative_substitution.sage` | 第一係数の表示：b=-u, a'=-c' | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_right_negative.sage` | 第一係数の表示：右因子の負号 | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_left_negative.sage` | 第一係数の表示：左因子の負号 | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_doubled_negative.sage` | 第一係数の表示：右因子の負号 | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_negative_sum.sage` | 第一係数の表示：和の負号 | PASS | QQ多項式の恒等式 |
| `check_coefficient_a_positive_sum_definition.sage` | 第一係数の表示：C の定義 | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_definition.sage` | 第二係数の表示：B の定義 | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_negative_substitution.sage` | 第二係数の表示：b=-u, a'=-c' | PASS | QQ多項式の恒等式 |
| `check_coefficient_b_negative_product.sage` | 第二係数の表示：負号どうしの積 | PASS | QQ多項式の恒等式 |
| `check_two_positive.sage` | 第一係数を負にする正因子：有理数の順序 | PASS | 67,308組 |
| `check_first_product_positive.sage` | 第一係数を負にする正因子：0<a, 0<c' | PASS | 67,308組 |
| `check_second_parts_product_positive.sage` | 第一係数を負にする正因子：0<u, 0<b' | PASS | 67,308組 |
| `check_doubled_second_parts_positive.sage` | 第一係数を負にする正因子：0<2, 0<u· b' | PASS | 67,308組 |
| `check_positive_sum_positive.sage` | 補助量 C の正値性：正数どうしの和 | PASS | 67,308組 |
| `check_positive_sum_definition.sage` | 補助量 C の正値性：C の定義 | PASS | QQ多項式の恒等式 |
| `check_first_coefficient_negative_substitution.sage` | 第一係数の負値性：第一係数の表示 | PASS | QQ多項式の恒等式 |
| `check_first_coefficient_negative.sage` | 第一係数の負値性：0<C | PASS | 67,308組 |
| `check_left_cross_positive.sage` | 第二係数を正にする正因子：0<a, 0<b' | PASS | 67,308組 |
| `check_right_cross_positive.sage` | 第二係数を正にする正因子：0<u, 0<c' | PASS | 67,308組 |
| `check_cross_sum_positive.sage` | 第二係数の正値性：正数どうしの和 | PASS | 67,308組 |
| `check_cross_sum_definition.sage` | 第二係数の正値性：第二係数の表示 | PASS | QQ多項式の恒等式 |
| `check_difference_positive.sage` | 平方差の正値性：2·(u· u)<a· a の移項 | PASS | 67,308組 |
| `check_difference_definition.sage` | 平方差の正値性：D の定義 | PASS | QQ多項式の恒等式 |
| `check_difference_comparison_factor_difference.sage` | 正因子による比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_difference_comparison_d_definition.sage` | 正因子による比較：D の定義 | PASS | QQ多項式の恒等式 |
| `check_difference_comparison_multiply_strict.sage` | 正因子による比較：正因子 D を掛ける | PASS | 67,308組 |
| `check_difference_comparison_d_substitution.sage` | 正因子による比較：D の定義 | PASS | QQ多項式の恒等式 |
| `check_difference_comparison_expand_difference.sage` | 正因子による比較：分配則 | PASS | QQ多項式の恒等式 |
| `check_move_difference_terms.sage` | 比較の移項：上の比較の移項 | PASS | 67,308組 |
| `check_positive_sum_square_definition.sage` | 補助量 C の平方展開：C の定義 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_distribute_left.sage` | 補助量 C の平方展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_distribute_right.sage` | 補助量 C の平方展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_regroup_squares.sage` | 補助量 C の平方展開：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_regroup_last_square.sage` | 補助量 C の平方展開：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_unregroup_last.sage` | 補助量 C の平方展開：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_associate_cross.sage` | 補助量 C の平方展開：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_commute_cross.sage` | 補助量 C の平方展開：積の可換則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_reassociate_cross.sage` | 補助量 C の平方展開：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_associate_sum.sage` | 補助量 C の平方展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_factor_two_copies.sage` | 補助量 C の平方展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_add_constants.sage` | 補助量 C の平方展開：2+2=4 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_associate_last_sum.sage` | 補助量 C の平方展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_commute_last_sum.sage` | 補助量 C の平方展開：和の可換則 | PASS | QQ多項式の恒等式 |
| `check_positive_sum_square_reassociate_last_sum.sage` | 補助量 C の平方展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_substitute_coefficient.sage` | 第二係数の平方の二倍の展開：第二係数の表示 | PASS | QQ多項式の恒等式 |
| `check_second_square_distribute_left.sage` | 第二係数の平方の二倍の展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_distribute_right.sage` | 第二係数の平方の二倍の展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_regroup_products.sage` | 第二係数の平方の二倍の展開：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_second_square_commute_factors.sage` | 第二係数の平方の二倍の展開：積の可換則 | PASS | QQ多項式の恒等式 |
| `check_second_square_regroup_cross.sage` | 第二係数の平方の二倍の展開：上の四因子の並べ替え | PASS | QQ多項式の恒等式 |
| `check_second_square_distribute_two_outer.sage` | 第二係数の平方の二倍の展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_distribute_two_inner.sage` | 第二係数の平方の二倍の展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_associate_sum.sage` | 第二係数の平方の二倍の展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_factor_two_copies.sage` | 第二係数の平方の二倍の展開：分配則 | PASS | QQ多項式の恒等式 |
| `check_second_square_add_constants.sage` | 第二係数の平方の二倍の展開：2+2=4 | PASS | QQ多項式の恒等式 |
| `check_second_square_associate_square_coefficients.sage` | 第二係数の平方の二倍の展開：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_commute_square_coefficient.sage` | 第二係数の平方の二倍の展開：積の可換則 | PASS | QQ多項式の恒等式 |
| `check_second_square_reassociate_square_coefficient.sage` | 第二係数の平方の二倍の展開：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_associate_last_sum.sage` | 第二係数の平方の二倍の展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_second_square_commute_last_sum.sage` | 第二係数の平方の二倍の展開：和の可換則 | PASS | QQ多項式の恒等式 |
| `check_second_square_reassociate_last_sum.sage` | 第二係数の平方の二倍の展開：和の結合則 | PASS | QQ多項式の恒等式 |
| `check_first_square_negative_substitution.sage` | 二つの平方の比較：第一係数の表示 | PASS | QQ多項式の恒等式 |
| `check_first_square_negative_product.sage` | 二つの平方の比較：負号どうしの積 | PASS | QQ多項式の恒等式 |
| `check_first_square_expansion.sage` | 二つの平方の比較：C· C の展開 | PASS | QQ多項式の恒等式 |
| `check_first_square_add_same_cross.sage` | 二つの平方の比較：移項した比較の両辺へ同じ項を加える | PASS | 67,308組 |
| `check_second_square_expansion.sage` | 二つの平方の比較：2·(B· B) の展開 | PASS | QQ多項式の恒等式 |
| `check_output_square_comparison.sage` | 正錐の定義の括弧との接続：上で示した平方の比較 | PASS | 67,308組 |
| `check_output_square_association.sage` | 正錐の定義の括弧との接続：積の結合則 | PASS | QQ多項式の恒等式 |
| `check_product_positive_cone_both_roots.sage` | 積の正錐への所属：A<0, 0<B, A· A<(2· B)· B, 正錐の定義 | PASS | 二次数体の両根134,616例 |

## 実行

```sh
sage exact-solution-of-2d-ising-model-lambda/sagemath/check/quadratic-positive-mul-mixed-signs/check.sage
sage exact-solution-of-2d-ising-model-lambda/sagemath/check/quadratic-positive-mul-mixed-signs/check-lines.sage
```

`check-lines.sage` は93本の行別ファイルを読み込み、恒等式・比較・両根の表示・両根の所属の各件数も検査する。各 `check_*.sage` を個別に実行することもできる。実行環境は SageMath 10.9。

保存した統合検算の以前の実行結果は2026-08-14の PASS（67,308組）。
