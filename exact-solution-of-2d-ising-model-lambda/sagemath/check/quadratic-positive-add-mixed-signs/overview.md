# SageMath Check: 二つの混合符号条件の和

**対象ラベル**: `claim_quadratic_positive_add_mixed_signs`

本文の表示・準備・三場合の計算・所属の118行を、一行一ファイルで検査する。
係数は `QQ`、表示と所属は二次体の正規形を用い、二つの `s²=2` の根について確かめる。
既存の67308組（第一条件46944組、第二条件10182組、第三条件10182組）の統合検査も維持する。
有限標本の検算を一般の証明とは扱わない。浮動小数点は使わない。

背理法内の「同時零」「第一係数零・第二係数負」「第一係数負・第二係数非正」は二つの正錐条件と両立しない。
その局所計算には、正の有理数 `1/2, 1, 2, 3` の四係数から局所仮定だけを満たす16組・24組・60組を別に選ぶ。
各ファイルで件数を固定し、空の検査を通過とはしない。矛盾の排除と各場合の所属は元の標本で検査する。

| 本文の行 | ファイル | 標本 | 状態 |
|---|---|---|---|
| 和の表示 | `check_sum_representation.sage` | 二根で134616組 | PASS |
| 第一係数の定義 | `check_first_sum_definition.sage` | 全67308組 | PASS |
| 第一係数を逆元の減法へ | `check_first_sum_subtraction.sage` | 全67308組 | PASS |
| 第一係数の置換 | `check_first_sum_replace.sage` | 全67308組 | PASS |
| 第二係数の定義 | `check_second_sum_definition.sage` | 全67308組 | PASS |
| 第二係数の加法交換 | `check_second_sum_commute.sage` | 全67308組 | PASS |
| 第二係数を逆元の減法へ | `check_second_sum_subtraction.sage` | 全67308組 | PASS |
| 第二係数の置換 | `check_second_sum_replace.sage` | 全67308組 | PASS |
| 第一係数の正値 | `check_first_positive.sage` | 全67308組 | PASS |
| 反転した第一係数の正値 | `check_negated_first_positive.sage` | 全67308組 | PASS |
| 反転した第二係数の正値 | `check_negated_second_positive.sage` | 全67308組 | PASS |
| 第二の元の第二係数の正値 | `check_second_prime_positive.sage` | 全67308組 | PASS |
| 反転した第二係数の平方の定義 | `check_second_square_definition.sage` | 全67308組 | PASS |
| 第二係数の平方の符号消去 | `check_second_square_signs.sage` | 全67308組 | PASS |
| 反転した第一係数の平方の定義 | `check_first_square_definition.sage` | 全67308組 | PASS |
| 第一係数の平方の符号消去 | `check_first_square_signs.sage` | 全67308組 | PASS |
| 第二条件の平方を置換 | `check_left_square_replace.sage` | 全67308組 | PASS |
| 第二条件の平方比較 | `check_left_square_bound.sage` | 全67308組 | PASS |
| 第三条件の平方を置換 | `check_right_square_replace.sage` | 全67308組 | PASS |
| 第三条件の平方比較 | `check_right_square_bound.sage` | 全67308組 | PASS |
| 反転した第二係数の平方の正値 | `check_second_square_positive.sage` | 全67308組 | PASS |
| 第二の元の第二係数の平方の正値 | `check_second_prime_square_positive.sage` | 全67308組 | PASS |
| 左交差積の正値 | `check_cross_left_positive.sage` | 全67308組 | PASS |
| 左交差積の非負性 | `check_cross_left_nonnegative.sage` | 全67308組 | PASS |
| 右交差積の正値 | `check_cross_right_positive.sage` | 全67308組 | PASS |
| 右交差積の非負性 | `check_cross_right_nonnegative.sage` | 全67308組 | PASS |
| 交差積の平方の括弧を移す | `check_cross_square_expand.sage` | 全67308組 | PASS |
| 交差積の内側の因子を交換 | `check_cross_square_expand_middle.sage` | 全67308組 | PASS |
| 交差積の同じ因子をまとめる | `check_cross_square_expand_finish.sage` | 全67308組 | PASS |
| 第三条件への右乗法 | `check_cross_square_right_condition.sage` | 全67308組 | PASS |
| 交差積の重みを外へ出す | `check_cross_square_rearrange.sage` | 全67308組 | PASS |
| 交差積の二つの平方因子を交換 | `check_cross_square_rearrange_middle.sage` | 全67308組 | PASS |
| 交差積の重みを左の平方因子へ | `check_cross_square_rearrange_finish.sage` | 全67308組 | PASS |
| 第二条件への右乗法 | `check_cross_square_left_condition.sage` | 全67308組 | PASS |
| 右交差積の平方へ括弧を移す | `check_cross_square_fold.sage` | 全67308組 | PASS |
| 右交差積の内側の因子を交換 | `check_cross_square_fold_middle.sage` | 全67308組 | PASS |
| 右交差積の平方へまとめる | `check_cross_square_fold_finish.sage` | 全67308組 | PASS |
| 交差積の比較 | `check_cross_comparison.sage` | 全67308組 | PASS |
| 同時零の第一成分 | `check_nonnegative_zero_first.sage` | 同時零の局所標本16組 | PASS |
| 同時零の第二成分 | `check_nonnegative_zero_second.sage` | 同時零の局所標本16組 | PASS |
| 第一係数の差が零 | `check_nonnegative_first_equal.sage` | 同時零の局所標本16組 | PASS |
| 第二係数の差が零 | `check_nonnegative_second_equal.sage` | 同時零の局所標本16組 | PASS |
| 同時零から交差積を置換 | `check_nonnegative_cross_first.sage` | 同時零の局所標本16組 | PASS |
| 同時零から交差積が一致 | `check_nonnegative_cross_second.sage` | 同時零の局所標本16組 | PASS |
| 非負の場合の同時零を排除 | `check_nonnegative_pair_nonzero.sage` | 非負の場合46944組 | PASS |
| 非負係数条件から所属 | `check_nonnegative_membership.sage` | 二根で93888組 | PASS |
| 負の第二係数から元の係数を比較 | `check_negative_second_order.sage` | 第二係数が負の10182組 | PASS |
| 第一係数が零なら元の係数が一致 | `check_negative_second_zero_first.sage` | 第一係数零・第二係数負の局所標本24組 | PASS |
| 第一係数が零なら反対向きの交差積比較 | `check_negative_second_opposite_strict.sage` | 第一係数零・第二係数負の局所標本24組 | PASS |
| 反対向きの交差積へ置換 | `check_negative_second_opposite_equal.sage` | 第一係数零・第二係数負の局所標本24組 | PASS |
| 第二係数が負なら第一係数は正 | `check_negative_second_first_positive.sage` | 第二係数が負の10182組 | PASS |
| 負の第二係数の大きさの定義 | `check_negative_second_magnitude_definition.sage` | 第二係数が負の10182組 | PASS |
| 差の順序を交換 | `check_negative_second_magnitude_negate.sage` | 第二係数が負の10182組 | PASS |
| 負の第二係数の大きさ | `check_negative_second_magnitude_replace.sage` | 第二係数が負の10182組 | PASS |
| 負の第二係数の大きさの正値 | `check_negative_second_magnitude_positive.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比の比較の定義 | `check_negative_second_ratio_definition.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比を分配 | `check_negative_second_ratio_expand.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比の狭義比較 | `check_negative_second_ratio_strict.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比を因数分解 | `check_negative_second_ratio_factor.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比の積を交換 | `check_negative_second_ratio_commute.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比へ第一係数を代入 | `check_negative_second_ratio_replace.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比の左辺の正値 | `check_negative_second_ratio_left_positive.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比の右辺の正値 | `check_negative_second_ratio_right_positive.sage` | 第二係数が負の10182組 | PASS |
| 負の第二係数の大きさの平方の正値 | `check_negative_second_square_positive.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比の平方へ右乗法 | `check_negative_second_ratio_square_right.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比の平方へ左乗法 | `check_negative_second_ratio_square_left.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の重み付き平方の括弧を移す | `check_negative_second_scaled_rearrange.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の重みと平方因子を交換 | `check_negative_second_scaled_rearrange_middle.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の平方仮定への右乗法 | `check_negative_second_scaled_condition.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の左積の平方へ括弧を移す | `check_negative_second_scaled_fold.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の左積の内側の因子を交換 | `check_negative_second_scaled_fold_middle.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の左積の平方へまとめる | `check_negative_second_scaled_fold_finish.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の比の平方比較を代入 | `check_negative_second_scaled_ratio.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の共通因子へ括弧を移す | `check_negative_second_scaled_expand.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の共通因子へ内側の積を交換 | `check_negative_second_scaled_expand_middle.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の共通平方因子をまとめる | `check_negative_second_scaled_expand_finish.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の正の平方因子を消去 | `check_negative_second_cancel.sage` | 第二係数が負の10182組 | PASS |
| 第二係数の平方へ符号を代入 | `check_negative_second_square_replace.sage` | 第二係数が負の10182組 | PASS |
| 第二係数の平方の符号消去 | `check_negative_second_square_negations.sage` | 第二係数が負の10182組 | PASS |
| 第二条件の最後の平方置換 | `check_negative_second_final_replace.sage` | 第二係数が負の10182組 | PASS |
| 和の第二条件の平方比較 | `check_negative_second_final_bound.sage` | 第二係数が負の10182組 | PASS |
| 負の第二係数条件から所属 | `check_negative_second_membership.sage` | 二根で20364組 | PASS |
| 負の第一係数から元の係数を比較 | `check_negative_first_order.sage` | 第一係数が負の10182組 | PASS |
| 第二係数が非正なら元の係数の広義比較 | `check_negative_first_nonpositive_second.sage` | 第一係数負・第二係数非正の局所標本60組 | PASS |
| 第一係数が負の場合の反対向きの狭義比較 | `check_negative_first_opposite_strict.sage` | 第一係数負・第二係数非正の局所標本60組 | PASS |
| 第一係数が負の場合の反対向きの広義比較 | `check_negative_first_opposite_weak.sage` | 第一係数負・第二係数非正の局所標本60組 | PASS |
| 第一係数が負なら第二係数は正 | `check_negative_first_second_positive.sage` | 第一係数が負の10182組 | PASS |
| 負の第一係数の大きさの定義 | `check_negative_first_magnitude_definition.sage` | 第一係数が負の10182組 | PASS |
| 第一係数の差の順序を交換 | `check_negative_first_magnitude_negate.sage` | 第一係数が負の10182組 | PASS |
| 負の第一係数の大きさ | `check_negative_first_magnitude_replace.sage` | 第一係数が負の10182組 | PASS |
| 負の第一係数の大きさの正値 | `check_negative_first_magnitude_positive.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比の比較の定義 | `check_negative_first_ratio_definition.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比を分配 | `check_negative_first_ratio_expand.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の二つの積を交換 | `check_negative_first_ratio_commute.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比の狭義比較 | `check_negative_first_ratio_strict.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比を因数分解 | `check_negative_first_ratio_factor.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比へ第二係数を代入 | `check_negative_first_ratio_replace.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比の左辺の正値 | `check_negative_first_ratio_left_positive.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比の右辺の正値 | `check_negative_first_ratio_right_positive.sage` | 第一係数が負の10182組 | PASS |
| 正の第二係数の平方の正値 | `check_negative_first_square_positive.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比の平方へ右乗法 | `check_negative_first_ratio_square_right.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比の平方へ左乗法 | `check_negative_first_ratio_square_left.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の左積の平方へ括弧を移す | `check_negative_first_scaled_fold.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の左積の内側の因子を交換 | `check_negative_first_scaled_fold_middle.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の左積の平方へまとめる | `check_negative_first_scaled_fold_finish.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の比の平方比較を代入 | `check_negative_first_scaled_ratio.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の右積の括弧を移す | `check_negative_first_scaled_expand.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の右積の内側の因子を交換 | `check_negative_first_scaled_expand_middle.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の右積の平方因子をまとめる | `check_negative_first_scaled_expand_finish.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の平方仮定への右乗法 | `check_negative_first_scaled_condition.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の重みと平方因子を交換 | `check_negative_first_scaled_rearrange.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の共通平方因子を外へ出す | `check_negative_first_scaled_rearrange_middle.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の正の平方因子を消去 | `check_negative_first_cancel.sage` | 第一係数が負の10182組 | PASS |
| 第一係数の平方へ符号を代入 | `check_negative_first_square_replace.sage` | 第一係数が負の10182組 | PASS |
| 第一係数の平方の符号消去 | `check_negative_first_square_negations.sage` | 第一係数が負の10182組 | PASS |
| 第三条件の最後の平方置換 | `check_negative_first_final_replace.sage` | 第一係数が負の10182組 | PASS |
| 和の第三条件の平方比較 | `check_negative_first_final_bound.sage` | 第一係数が負の10182組 | PASS |
| 負の第一係数条件から所属 | `check_negative_first_membership.sage` | 二根で20364組 | PASS |

プロジェクト直下で実行する。

```sh
/home/masaori/.local/share/math-mamba/envs/sage/bin/sage sagemath/check/quadratic-positive-add-mixed-signs/check.sage
```

2026-10-11 実行: 本文118行・計3458568件の行別検査と、既存67308組の統合検査がすべて通過した。
