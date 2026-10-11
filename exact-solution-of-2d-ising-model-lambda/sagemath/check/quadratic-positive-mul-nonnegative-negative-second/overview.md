# SageMath Check: 非負係数条件と負の第二係数条件の積

**対象ラベル**: `claim_quadratic_positive_mul_nonnegative_negative_second`

**実行結果**: PASS（2026-10-11）。本文157計算行を一行一ファイルで検査し、計2,370,178確認が通過した。既存統合検算122,475組も通過した。

有理数の標本は分子0〜4・分母1〜4の重複を除いた非負数12個から取り、$a,b$ はその全体、$a',u$ は正数11個を動く。基本標本は17,424組で、$b'=-u$、$A=aa'-2bu$、$B=ba'-au$、$V=-B$、$C=-A$ と置く。表の各ファイルで検査する式ペアと局所条件を明記し、実行件数が記載件数に一致することも検査する。

背理法の仮定をすべて同時に課すと標本が空になるため、各行の置換または順序操作に用いる局所条件だけを課す。特に零積の置換行は$a=0$または$b=0$を許し、非零の係数対という反対の仮定を課さない。正因子消去の行は消去前の比較を仮定し、矛盾する場合分けの仮定を課さない。これは各演算の検算であり、背理法全体の一般的妥当性はLeanが保証する。

積の表示と四分岐の所属は、基本標本から$(a,b)\ne(0,0)$と$2u^2<a'^2$を満たす6,721組を取り、二次体の二つの根について検査する。係数は積の係数公式を使わず数体の正規形から取得する。所属行では、各分岐に指定された正錐の条件をその係数へ適用する。

| ファイル | 本文の計算 | 式ペア | 結果・確認数 |
|---|---|---|---|
| `check_product_representation.sage` | 積の二次体での表示 | $\mathrm{rep}_s(\xi\eta)=(a\cdot a'+2\cdot(b\cdot b'),a\cdot b'+b\cdot a')$ | PASS・13,442 |
| `check_input_square_substitute_negative_second.sage` | 入力の反数の平方比較・u の定義 | $2 \cdot (u \cdot u) = 2 \cdot ((-b') \cdot (-b'))$ | PASS・17,424 |
| `check_input_square_remove_two_negatives.sage` | 入力の反数の平方比較・二つの負号の積 | $2 \cdot ((-b') \cdot (-b')) = 2 \cdot (b' \cdot b')$ | PASS・17,424 |
| `check_input_square_associate_twice.sage` | 入力の反数の平方比較・結合則 | $2 \cdot (b' \cdot b') = 2 \cdot b' \cdot b'$ | PASS・17,424 |
| `check_input_square_strict_input_bound.sage` | 入力の反数の平方比較・負の第二係数条件 | $2 \cdot b' \cdot b' < a' \cdot a'$ | PASS・6,768 |
| `check_normalize_a_substitute_negative_second.sage` | 第一係数の表示の整理・b'=-u | $a \cdot a' + 2 \cdot (b \cdot b') = a \cdot a' + 2 \cdot (b \cdot (-u))$ | PASS・17,424 |
| `check_normalize_a_inner_negative_factor.sage` | 第一係数の表示の整理・右因子の負号 | $a \cdot a' + 2 \cdot (b \cdot (-u)) = a \cdot a' + 2 \cdot (-(b \cdot u))$ | PASS・17,424 |
| `check_normalize_a_outer_negative_factor.sage` | 第一係数の表示の整理・右因子の負号 | $a \cdot a' + 2 \cdot (-(b \cdot u)) = a \cdot a' + (-(2 \cdot (b \cdot u)))$ | PASS・17,424 |
| `check_normalize_a_difference_definition.sage` | 第一係数の表示の整理・差の定義 | $a \cdot a' + (-(2 \cdot (b \cdot u))) = a \cdot a' - 2 \cdot (b \cdot u)$ | PASS・17,424 |
| `check_normalize_b_substitute_negative_second.sage` | 第二係数の表示の整理・b'=-u | $a \cdot b' + b \cdot a' = a \cdot (-u) + b \cdot a'$ | PASS・17,424 |
| `check_normalize_b_negative_factor.sage` | 第二係数の表示の整理・右因子の負号 | $a \cdot (-u) + b \cdot a' = (-(a \cdot u)) + b \cdot a'$ | PASS・17,424 |
| `check_normalize_b_commute_sum.sage` | 第二係数の表示の整理・加法の可換則 | $(-(a \cdot u)) + b \cdot a' = b \cdot a' + (-(a \cdot u))$ | PASS・17,424 |
| `check_normalize_b_difference_definition.sage` | 第二係数の表示の整理・差の定義 | $b \cdot a' + (-(a \cdot u)) = b \cdot a' - a \cdot u$ | PASS・17,424 |
| `check_zero_square_assumed_square_equality.sage` | 第二係数が零の場合の平方等号・仮定した平方の等号 | $a \cdot a = 2 \cdot (b \cdot b)$ | PASS・121 |
| `check_zero_square_substitute_zero_coefficient.sage` | 第二係数が零の場合の平方等号・b=0 | $2 \cdot (b \cdot b) = 2 \cdot (0 \cdot 0)$ | PASS・1,452 |
| `check_zero_square_inner_zero_product.sage` | 第二係数が零の場合の平方等号・零との積 | $2 \cdot (0 \cdot 0) = 2 \cdot 0$ | PASS・17,424 |
| `check_zero_square_outer_zero_product.sage` | 第二係数が零の場合の平方等号・零との積 | $2 \cdot 0 = 0$ | PASS・17,424 |
| `check_first_a_zero_substitute_zero.sage` | 第一の場合の第一係数零の除外・a=0 | $a \cdot a = 0 \cdot 0$ | PASS・1,452 |
| `check_first_a_zero_zero_product.sage` | 第一の場合の第一係数零の除外・零との積 | $0 \cdot 0 = 0$ | PASS・17,424 |
| `check_first_b_zero_substitute_zero.sage` | 第一の場合の第二係数零の除外・b=0 | $2 \cdot (b \cdot u) = 2 \cdot (0 \cdot u)$ | PASS・1,452 |
| `check_first_b_zero_inner_zero_product.sage` | 第一の場合の第二係数零の除外・零との積 | $2 \cdot (0 \cdot u) = 2 \cdot 0$ | PASS・17,424 |
| `check_first_b_zero_outer_zero_product.sage` | 第一の場合の第二係数零の除外・零との積 | $2 \cdot 0 = 0$ | PASS・17,424 |
| `check_first_contradiction_associate_left_outer.sage` | 第一の場合の背理法の平方比較・結合則 | $(a \cdot a) \cdot (a' \cdot a') = a \cdot (a \cdot (a' \cdot a'))$ | PASS・17,424 |
| `check_first_contradiction_associate_left_inner.sage` | 第一の場合の背理法の平方比較・結合則 | $a \cdot (a \cdot (a' \cdot a')) = a \cdot ((a \cdot a') \cdot a')$ | PASS・17,424 |
| `check_first_contradiction_commute_left_middle.sage` | 第一の場合の背理法の平方比較・可換則 | $a \cdot ((a \cdot a') \cdot a') = a \cdot ((a' \cdot a) \cdot a')$ | PASS・17,424 |
| `check_first_contradiction_associate_left_nested.sage` | 第一の場合の背理法の平方比較・結合則 | $a \cdot ((a' \cdot a) \cdot a') = a \cdot (a' \cdot (a \cdot a'))$ | PASS・17,424 |
| `check_first_contradiction_group_left_square.sage` | 第一の場合の背理法の平方比較・結合則 | $a \cdot (a' \cdot (a \cdot a')) = (a \cdot a') \cdot (a \cdot a')$ | PASS・17,424 |
| `check_first_contradiction_square_bound.sage` | 第一の場合の背理法の平方比較・0≤a a'≤2(bu) の平方比較 | $(a \cdot a') \cdot (a \cdot a') \le (2 \cdot (b \cdot u)) \cdot (2 \cdot (b \cdot u))$ | PASS・11,326 |
| `check_first_contradiction_associate_twice_outer.sage` | 第一の場合の背理法の平方比較・結合則 | $(2 \cdot (b \cdot u)) \cdot (2 \cdot (b \cdot u)) = 2 \cdot ((b \cdot u) \cdot (2 \cdot (b \cdot u)))$ | PASS・17,424 |
| `check_first_contradiction_associate_twice_inner.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot ((b \cdot u) \cdot (2 \cdot (b \cdot u))) = 2 \cdot (((b \cdot u) \cdot 2) \cdot (b \cdot u))$ | PASS・17,424 |
| `check_first_contradiction_commute_twice_inner.sage` | 第一の場合の背理法の平方比較・可換則 | $2 \cdot (((b \cdot u) \cdot 2) \cdot (b \cdot u)) = 2 \cdot ((2 \cdot (b \cdot u)) \cdot (b \cdot u))$ | PASS・17,424 |
| `check_first_contradiction_group_twice_factor.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot ((2 \cdot (b \cdot u)) \cdot (b \cdot u)) = 2 \cdot (2 \cdot ((b \cdot u) \cdot (b \cdot u)))$ | PASS・17,424 |
| `check_first_contradiction_associate_b_outer.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot (2 \cdot ((b \cdot u) \cdot (b \cdot u))) = 2 \cdot (2 \cdot (b \cdot (u \cdot (b \cdot u))))$ | PASS・17,424 |
| `check_first_contradiction_associate_b_inner.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot (2 \cdot (b \cdot (u \cdot (b \cdot u)))) = 2 \cdot (2 \cdot (b \cdot ((u \cdot b) \cdot u)))$ | PASS・17,424 |
| `check_first_contradiction_commute_b_middle.sage` | 第一の場合の背理法の平方比較・可換則 | $2 \cdot (2 \cdot (b \cdot ((u \cdot b) \cdot u))) = 2 \cdot (2 \cdot (b \cdot ((b \cdot u) \cdot u)))$ | PASS・17,424 |
| `check_first_contradiction_associate_b_nested.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot (2 \cdot (b \cdot ((b \cdot u) \cdot u))) = 2 \cdot (2 \cdot (b \cdot (b \cdot (u \cdot u))))$ | PASS・17,424 |
| `check_first_contradiction_group_b_square.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot (2 \cdot (b \cdot (b \cdot (u \cdot u)))) = 2 \cdot (2 \cdot ((b \cdot b) \cdot (u \cdot u)))$ | PASS・17,424 |
| `check_first_contradiction_associate_twice_b_square.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot (2 \cdot ((b \cdot b) \cdot (u \cdot u))) = 2 \cdot ((2 \cdot (b \cdot b)) \cdot (u \cdot u))$ | PASS・17,424 |
| `check_first_contradiction_commute_twice_b_square.sage` | 第一の場合の背理法の平方比較・可換則 | $2 \cdot ((2 \cdot (b \cdot b)) \cdot (u \cdot u)) = 2 \cdot (((b \cdot b) \cdot 2) \cdot (u \cdot u))$ | PASS・17,424 |
| `check_first_contradiction_associate_right_inner.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot (((b \cdot b) \cdot 2) \cdot (u \cdot u)) = 2 \cdot ((b \cdot b) \cdot (2 \cdot (u \cdot u)))$ | PASS・17,424 |
| `check_first_contradiction_group_right_twice_square.sage` | 第一の場合の背理法の平方比較・結合則 | $2 \cdot ((b \cdot b) \cdot (2 \cdot (u \cdot u))) = (2 \cdot (b \cdot b)) \cdot (2 \cdot (u \cdot u))$ | PASS・17,424 |
| `check_first_contradiction_strict_square_bound.sage` | 第一の場合の背理法の平方比較・2u²<a'² の正因子 2b² による保存 | $(2 \cdot (b \cdot b)) \cdot (2 \cdot (u \cdot u)) < (2 \cdot (b \cdot b)) \cdot (a' \cdot a')$ | PASS・6,204 |
| `check_first_contradiction_cancel_positive_factor.sage` | 第一の場合の背理法の正因子消去・正因子 a'² の消去 | $a \cdot a < 2 \cdot (b \cdot b)$ | PASS・10,285 |
| `check_first_nonnegative_membership.sage` | 第一の場合で第二係数が非負の積の所属 | $\xi\eta\in P_s$ | PASS・2,430 |
| `check_first_v_negative_definition.sage` | 負の第二係数の反数の表示・V の定義 | $V = -B$ | PASS・17,424 |
| `check_first_v_substitute_second_coefficient.sage` | 負の第二係数の反数の表示・B の表示 | $-B = -(b \cdot a' - a \cdot u)$ | PASS・17,424 |
| `check_first_v_negate_difference.sage` | 負の第二係数の反数の表示・差の負号 | $-(b \cdot a' - a \cdot u) = a \cdot u - b \cdot a'$ | PASS・17,424 |
| `check_first_step_multiply_bound.sage` | 第二係数を掛けた平方比較・非負因子 b による比較の保存 | $b \cdot (2 \cdot (u \cdot u)) \le b \cdot (a' \cdot a')$ | PASS・6,768 |
| `check_first_linear_substitute_negative_coefficient.sage` | 負の第二係数の場合の線形比較・上で得た V の表示 | $a' \cdot V = a' \cdot (a \cdot u - b \cdot a')$ | PASS・17,424 |
| `check_first_linear_distribute_left_factor.sage` | 負の第二係数の場合の線形比較・分配則 | $a' \cdot (a \cdot u - b \cdot a') = a' \cdot (a \cdot u) - a' \cdot (b \cdot a')$ | PASS・17,424 |
| `check_first_linear_associate_two_products.sage` | 負の第二係数の場合の線形比較・結合則 | $a' \cdot (a \cdot u) - a' \cdot (b \cdot a') = (a' \cdot a) \cdot u - (a' \cdot b) \cdot a'$ | PASS・17,424 |
| `check_first_linear_commute_two_leading_factors.sage` | 負の第二係数の場合の線形比較・可換則 | $(a' \cdot a) \cdot u - (a' \cdot b) \cdot a' = (a \cdot a') \cdot u - (b \cdot a') \cdot a'$ | PASS・17,424 |
| `check_first_linear_associate_leading_products.sage` | 負の第二係数の場合の線形比較・結合則 | $(a \cdot a') \cdot u - (b \cdot a') \cdot a' = a \cdot (a' \cdot u) - b \cdot (a' \cdot a')$ | PASS・17,424 |
| `check_first_linear_commute_u_ap.sage` | 負の第二係数の場合の線形比較・可換則 | $a \cdot (a' \cdot u) - b \cdot (a' \cdot a') = a \cdot (u \cdot a') - b \cdot (a' \cdot a')$ | PASS・17,424 |
| `check_first_linear_subtract_product_bound.sage` | 負の第二係数の場合の線形比較・先に得た積の比較を差の右項に適用 | $a \cdot (u \cdot a') - b \cdot (a' \cdot a') \le a \cdot (u \cdot a') - b \cdot (2 \cdot (u \cdot u))$ | PASS・6,768 |
| `check_first_linear_associate_difference_factors.sage` | 負の第二係数の場合の線形比較・結合則 | $a \cdot (u \cdot a') - b \cdot (2 \cdot (u \cdot u)) = (a \cdot u) \cdot a' - (b \cdot 2) \cdot (u \cdot u)$ | PASS・17,424 |
| `check_first_linear_commute_difference_factors.sage` | 負の第二係数の場合の線形比較・可換則 | $(a \cdot u) \cdot a' - (b \cdot 2) \cdot (u \cdot u) = (u \cdot a) \cdot a' - (2 \cdot b) \cdot (u \cdot u)$ | PASS・17,424 |
| `check_first_linear_associate_difference_products.sage` | 負の第二係数の場合の線形比較・結合則 | $(u \cdot a) \cdot a' - (2 \cdot b) \cdot (u \cdot u) = u \cdot (a \cdot a') - 2 \cdot (b \cdot (u \cdot u))$ | PASS・17,424 |
| `check_first_linear_associate_b_u.sage` | 負の第二係数の場合の線形比較・結合則 | $u \cdot (a \cdot a') - 2 \cdot (b \cdot (u \cdot u)) = u \cdot (a \cdot a') - 2 \cdot ((b \cdot u) \cdot u)$ | PASS・17,424 |
| `check_first_linear_commute_b_u_u.sage` | 負の第二係数の場合の線形比較・可換則 | $u \cdot (a \cdot a') - 2 \cdot ((b \cdot u) \cdot u) = u \cdot (a \cdot a') - 2 \cdot (u \cdot (b \cdot u))$ | PASS・17,424 |
| `check_first_linear_group_twice_u.sage` | 負の第二係数の場合の線形比較・結合則 | $u \cdot (a \cdot a') - 2 \cdot (u \cdot (b \cdot u)) = u \cdot (a \cdot a') - (2 \cdot u) \cdot (b \cdot u)$ | PASS・17,424 |
| `check_first_linear_commute_twice_u.sage` | 負の第二係数の場合の線形比較・可換則 | $u \cdot (a \cdot a') - (2 \cdot u) \cdot (b \cdot u) = u \cdot (a \cdot a') - (u \cdot 2) \cdot (b \cdot u)$ | PASS・17,424 |
| `check_first_linear_associate_u_twice.sage` | 負の第二係数の場合の線形比較・結合則 | $u \cdot (a \cdot a') - (u \cdot 2) \cdot (b \cdot u) = u \cdot (a \cdot a') - u \cdot (2 \cdot (b \cdot u))$ | PASS・17,424 |
| `check_first_linear_factor_difference.sage` | 負の第二係数の場合の線形比較・分配則 | $u \cdot (a \cdot a') - u \cdot (2 \cdot (b \cdot u)) = u \cdot (a \cdot a' - 2 \cdot (b \cdot u))$ | PASS・17,424 |
| `check_first_linear_restore_first_coefficient.sage` | 負の第二係数の場合の線形比較・A の表示 | $u \cdot (a \cdot a' - 2 \cdot (b \cdot u)) = u \cdot A$ | PASS・17,424 |
| `check_first_square_associate_twice_square.sage` | 負の第二係数の場合の平方比較・結合則 | $(u \cdot u) \cdot (2 \cdot (V \cdot V)) = ((u \cdot u) \cdot 2) \cdot (V \cdot V)$ | PASS・17,424 |
| `check_first_square_commute_twice_square.sage` | 負の第二係数の場合の平方比較・可換則 | $((u \cdot u) \cdot 2) \cdot (V \cdot V) = (2 \cdot (u \cdot u)) \cdot (V \cdot V)$ | PASS・17,424 |
| `check_first_square_strict_square_bound.sage` | 負の第二係数の場合の平方比較・2u²<a'² を正因子 V² で乗算 | $(2 \cdot (u \cdot u)) \cdot (V \cdot V) < (a' \cdot a') \cdot (V \cdot V)$ | PASS・1,511 |
| `check_first_square_associate_left_outer.sage` | 負の第二係数の場合の平方比較・結合則 | $(a' \cdot a') \cdot (V \cdot V) = a' \cdot (a' \cdot (V \cdot V))$ | PASS・17,424 |
| `check_first_square_associate_left_inner.sage` | 負の第二係数の場合の平方比較・結合則 | $a' \cdot (a' \cdot (V \cdot V)) = a' \cdot ((a' \cdot V) \cdot V)$ | PASS・17,424 |
| `check_first_square_commute_left_middle.sage` | 負の第二係数の場合の平方比較・可換則 | $a' \cdot ((a' \cdot V) \cdot V) = a' \cdot ((V \cdot a') \cdot V)$ | PASS・17,424 |
| `check_first_square_associate_left_nested.sage` | 負の第二係数の場合の平方比較・結合則 | $a' \cdot ((V \cdot a') \cdot V) = a' \cdot (V \cdot (a' \cdot V))$ | PASS・17,424 |
| `check_first_square_group_left_square.sage` | 負の第二係数の場合の平方比較・結合則 | $a' \cdot (V \cdot (a' \cdot V)) = (a' \cdot V) \cdot (a' \cdot V)$ | PASS・17,424 |
| `check_first_square_square_linear_bound.sage` | 負の第二係数の場合の平方比較・0≤a'V≤uA の平方比較 | $(a' \cdot V) \cdot (a' \cdot V) \le (u \cdot A) \cdot (u \cdot A)$ | PASS・2,667 |
| `check_first_square_associate_right_outer.sage` | 負の第二係数の場合の平方比較・結合則 | $(u \cdot A) \cdot (u \cdot A) = u \cdot (A \cdot (u \cdot A))$ | PASS・17,424 |
| `check_first_square_associate_right_inner.sage` | 負の第二係数の場合の平方比較・結合則 | $u \cdot (A \cdot (u \cdot A)) = u \cdot ((A \cdot u) \cdot A)$ | PASS・17,424 |
| `check_first_square_commute_right_middle.sage` | 負の第二係数の場合の平方比較・可換則 | $u \cdot ((A \cdot u) \cdot A) = u \cdot ((u \cdot A) \cdot A)$ | PASS・17,424 |
| `check_first_square_associate_right_nested.sage` | 負の第二係数の場合の平方比較・結合則 | $u \cdot ((u \cdot A) \cdot A) = u \cdot (u \cdot (A \cdot A))$ | PASS・17,424 |
| `check_first_square_group_right_square.sage` | 負の第二係数の場合の平方比較・結合則 | $u \cdot (u \cdot (A \cdot A)) = (u \cdot u) \cdot (A \cdot A)$ | PASS・17,424 |
| `check_first_final_cancel_positive_factor.sage` | 負の第二係数条件の正因子消去・正因子 u² の消去 | $2 \cdot (V \cdot V) < A \cdot A$ | PASS・9,016 |
| `check_first_final_insert_negative_squares.sage` | 負の第二係数条件の確定・二つの負号の積 | $2 \cdot (B \cdot B) = 2 \cdot ((-B) \cdot (-B))$ | PASS・17,424 |
| `check_first_final_substitute_negative_second.sage` | 負の第二係数条件の確定・V=-B | $2 \cdot ((-B) \cdot (-B)) = 2 \cdot (V \cdot V)$ | PASS・17,424 |
| `check_first_final_cancel_positive_square.sage` | 負の第二係数条件の確定・正因子 u² の消去で得た不等式 | $2 \cdot (V \cdot V) < A \cdot A$ | PASS・9,016 |
| `check_first_negative_membership.sage` | 第一の場合で第二係数が負の積の所属 | $\xi\eta\in P_s$ | PASS・3,022 |
| `check_second_b_zero_substitute_zero.sage` | 第二の場合の第二係数零の除外・b=0 | $2 \cdot (b \cdot b) = 2 \cdot (0 \cdot 0)$ | PASS・1,452 |
| `check_second_b_zero_inner_zero_product.sage` | 第二の場合の第二係数零の除外・零との積 | $2 \cdot (0 \cdot 0) = 2 \cdot 0$ | PASS・17,424 |
| `check_second_b_zero_outer_zero_product.sage` | 第二の場合の第二係数零の除外・零との積 | $2 \cdot 0 = 0$ | PASS・17,424 |
| `check_second_a_zero_substitute_zero.sage` | 第二の場合の第一係数零の除外・a=0 | $a \cdot u = 0 \cdot u$ | PASS・1,452 |
| `check_second_a_zero_zero_product.sage` | 第二の場合の第一係数零の除外・零との積 | $0 \cdot u = 0$ | PASS・17,424 |
| `check_second_square_le_square_bound.sage` | 第二の場合の背理法の平方比較の準備・非負の両辺の平方比較 | $(b \cdot a') \cdot (b \cdot a') \le (a \cdot u) \cdot (a \cdot u)$ | PASS・9,094 |
| `check_second_contradiction_associate_twice_left.sage` | 第二の場合の背理法の平方比較・結合則 | $(2 \cdot (b \cdot b)) \cdot (a' \cdot a') = 2 \cdot ((b \cdot b) \cdot (a' \cdot a'))$ | PASS・17,424 |
| `check_second_contradiction_associate_left_outer.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot ((b \cdot b) \cdot (a' \cdot a')) = 2 \cdot (b \cdot (b \cdot (a' \cdot a')))$ | PASS・17,424 |
| `check_second_contradiction_associate_left_inner.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot (b \cdot (b \cdot (a' \cdot a'))) = 2 \cdot (b \cdot ((b \cdot a') \cdot a'))$ | PASS・17,424 |
| `check_second_contradiction_commute_left_middle.sage` | 第二の場合の背理法の平方比較・可換則 | $2 \cdot (b \cdot ((b \cdot a') \cdot a')) = 2 \cdot (b \cdot ((a' \cdot b) \cdot a'))$ | PASS・17,424 |
| `check_second_contradiction_associate_left_nested.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot (b \cdot ((a' \cdot b) \cdot a')) = 2 \cdot (b \cdot (a' \cdot (b \cdot a')))$ | PASS・17,424 |
| `check_second_contradiction_group_left_square.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot (b \cdot (a' \cdot (b \cdot a'))) = 2 \cdot ((b \cdot a') \cdot (b \cdot a'))$ | PASS・17,424 |
| `check_second_contradiction_twice_square_bound.sage` | 第二の場合の背理法の平方比較・先に得た平方比較を非負因子 2 で乗算 | $2 \cdot ((b \cdot a') \cdot (b \cdot a')) \le 2 \cdot ((a \cdot u) \cdot (a \cdot u))$ | PASS・9,094 |
| `check_second_contradiction_associate_right_outer.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot ((a \cdot u) \cdot (a \cdot u)) = 2 \cdot (a \cdot (u \cdot (a \cdot u)))$ | PASS・17,424 |
| `check_second_contradiction_associate_right_inner.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot (a \cdot (u \cdot (a \cdot u))) = 2 \cdot (a \cdot ((u \cdot a) \cdot u))$ | PASS・17,424 |
| `check_second_contradiction_commute_right_middle.sage` | 第二の場合の背理法の平方比較・可換則 | $2 \cdot (a \cdot ((u \cdot a) \cdot u)) = 2 \cdot (a \cdot ((a \cdot u) \cdot u))$ | PASS・17,424 |
| `check_second_contradiction_associate_right_nested.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot (a \cdot ((a \cdot u) \cdot u)) = 2 \cdot (a \cdot (a \cdot (u \cdot u)))$ | PASS・17,424 |
| `check_second_contradiction_group_right_square.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot (a \cdot (a \cdot (u \cdot u))) = 2 \cdot ((a \cdot a) \cdot (u \cdot u))$ | PASS・17,424 |
| `check_second_contradiction_group_twice_a_square.sage` | 第二の場合の背理法の平方比較・結合則 | $2 \cdot ((a \cdot a) \cdot (u \cdot u)) = (2 \cdot (a \cdot a)) \cdot (u \cdot u)$ | PASS・17,424 |
| `check_second_contradiction_commute_twice_a_square.sage` | 第二の場合の背理法の平方比較・可換則 | $(2 \cdot (a \cdot a)) \cdot (u \cdot u) = ((a \cdot a) \cdot 2) \cdot (u \cdot u)$ | PASS・17,424 |
| `check_second_contradiction_associate_twice_u_square.sage` | 第二の場合の背理法の平方比較・結合則 | $((a \cdot a) \cdot 2) \cdot (u \cdot u) = (a \cdot a) \cdot (2 \cdot (u \cdot u))$ | PASS・17,424 |
| `check_second_contradiction_strict_square_bound.sage` | 第二の場合の背理法の平方比較・2u²<a'² を正因子 a² で乗算 | $(a \cdot a) \cdot (2 \cdot (u \cdot u)) < (a \cdot a) \cdot (a' \cdot a')$ | PASS・6,204 |
| `check_second_contradiction_cancel_positive_factor.sage` | 第二の場合の背理法の正因子消去・正因子 a'² の消去 | $2 \cdot (b \cdot b) < a \cdot a$ | PASS・7,018 |
| `check_second_nonnegative_membership.sage` | 第二の場合で第一係数が非負の積の所属 | $\xi\eta\in P_s$ | PASS・3,142 |
| `check_second_c_negative_definition.sage` | 負の第一係数の反数の表示・C の定義 | $C = -A$ | PASS・17,424 |
| `check_second_c_substitute_first_coefficient.sage` | 負の第一係数の反数の表示・A の表示 | $-A = -(a \cdot a' - 2 \cdot (b \cdot u))$ | PASS・17,424 |
| `check_second_c_negate_difference.sage` | 負の第一係数の反数の表示・差の負号 | $-(a \cdot a' - 2 \cdot (b \cdot u)) = 2 \cdot (b \cdot u) - a \cdot a'$ | PASS・17,424 |
| `check_second_step_multiply_bound.sage` | 第一係数を掛けた平方比較・非負因子 a による比較の保存 | $a \cdot (2 \cdot (u \cdot u)) \le a \cdot (a' \cdot a')$ | PASS・6,768 |
| `check_second_linear_substitute_negative_coefficient.sage` | 負の第一係数の場合の線形比較・上で得た C の表示 | $a' \cdot C = a' \cdot (2 \cdot (b \cdot u) - a \cdot a')$ | PASS・17,424 |
| `check_second_linear_distribute_left_factor.sage` | 負の第一係数の場合の線形比較・分配則 | $a' \cdot (2 \cdot (b \cdot u) - a \cdot a') = a' \cdot (2 \cdot (b \cdot u)) - a' \cdot (a \cdot a')$ | PASS・17,424 |
| `check_second_linear_associate_two_products.sage` | 負の第一係数の場合の線形比較・結合則 | $a' \cdot (2 \cdot (b \cdot u)) - a' \cdot (a \cdot a') = (a' \cdot 2) \cdot (b \cdot u) - (a' \cdot a) \cdot a'$ | PASS・17,424 |
| `check_second_linear_commute_two_leading_factors.sage` | 負の第一係数の場合の線形比較・可換則 | $(a' \cdot 2) \cdot (b \cdot u) - (a' \cdot a) \cdot a' = (2 \cdot a') \cdot (b \cdot u) - (a \cdot a') \cdot a'$ | PASS・17,424 |
| `check_second_linear_associate_leading_products.sage` | 負の第一係数の場合の線形比較・結合則 | $(2 \cdot a') \cdot (b \cdot u) - (a \cdot a') \cdot a' = 2 \cdot (a' \cdot (b \cdot u)) - a \cdot (a' \cdot a')$ | PASS・17,424 |
| `check_second_linear_associate_b_u.sage` | 負の第一係数の場合の線形比較・結合則 | $2 \cdot (a' \cdot (b \cdot u)) - a \cdot (a' \cdot a') = 2 \cdot ((a' \cdot b) \cdot u) - a \cdot (a' \cdot a')$ | PASS・17,424 |
| `check_second_linear_commute_ap_b.sage` | 負の第一係数の場合の線形比較・可換則 | $2 \cdot ((a' \cdot b) \cdot u) - a \cdot (a' \cdot a') = 2 \cdot ((b \cdot a') \cdot u) - a \cdot (a' \cdot a')$ | PASS・17,424 |
| `check_second_linear_associate_b_ap.sage` | 負の第一係数の場合の線形比較・結合則 | $2 \cdot ((b \cdot a') \cdot u) - a \cdot (a' \cdot a') = 2 \cdot (b \cdot (a' \cdot u)) - a \cdot (a' \cdot a')$ | PASS・17,424 |
| `check_second_linear_commute_ap_u.sage` | 負の第一係数の場合の線形比較・可換則 | $2 \cdot (b \cdot (a' \cdot u)) - a \cdot (a' \cdot a') = 2 \cdot (b \cdot (u \cdot a')) - a \cdot (a' \cdot a')$ | PASS・17,424 |
| `check_second_linear_subtract_product_bound.sage` | 負の第一係数の場合の線形比較・先に得た積の比較を差の右項に適用 | $2 \cdot (b \cdot (u \cdot a')) - a \cdot (a' \cdot a') \le 2 \cdot (b \cdot (u \cdot a')) - a \cdot (2 \cdot (u \cdot u))$ | PASS・6,768 |
| `check_second_linear_associate_difference_factors.sage` | 負の第一係数の場合の線形比較・結合則 | $2 \cdot (b \cdot (u \cdot a')) - a \cdot (2 \cdot (u \cdot u)) = 2 \cdot ((b \cdot u) \cdot a') - (a \cdot 2) \cdot (u \cdot u)$ | PASS・17,424 |
| `check_second_linear_commute_difference_factors.sage` | 負の第一係数の場合の線形比較・可換則 | $2 \cdot ((b \cdot u) \cdot a') - (a \cdot 2) \cdot (u \cdot u) = 2 \cdot ((u \cdot b) \cdot a') - (2 \cdot a) \cdot (u \cdot u)$ | PASS・17,424 |
| `check_second_linear_associate_twice_b.sage` | 負の第一係数の場合の線形比較・結合則 | $2 \cdot ((u \cdot b) \cdot a') - (2 \cdot a) \cdot (u \cdot u) = (2 \cdot (u \cdot b)) \cdot a' - 2 \cdot (a \cdot (u \cdot u))$ | PASS・17,424 |
| `check_second_linear_associate_twice_u_and_a_u.sage` | 負の第一係数の場合の線形比較・結合則 | $(2 \cdot (u \cdot b)) \cdot a' - 2 \cdot (a \cdot (u \cdot u)) = ((2 \cdot u) \cdot b) \cdot a' - 2 \cdot ((a \cdot u) \cdot u)$ | PASS・17,424 |
| `check_second_linear_group_twice_u_b_ap.sage` | 負の第一係数の場合の線形比較・結合則 | $((2 \cdot u) \cdot b) \cdot a' - 2 \cdot ((a \cdot u) \cdot u) = (2 \cdot u) \cdot (b \cdot a') - 2 \cdot ((a \cdot u) \cdot u)$ | PASS・17,424 |
| `check_second_linear_commute_a_u_u.sage` | 負の第一係数の場合の線形比較・可換則 | $(2 \cdot u) \cdot (b \cdot a') - 2 \cdot ((a \cdot u) \cdot u) = (2 \cdot u) \cdot (b \cdot a') - 2 \cdot (u \cdot (a \cdot u))$ | PASS・17,424 |
| `check_second_linear_group_twice_u_a_u.sage` | 負の第一係数の場合の線形比較・結合則 | $(2 \cdot u) \cdot (b \cdot a') - 2 \cdot (u \cdot (a \cdot u)) = (2 \cdot u) \cdot (b \cdot a') - (2 \cdot u) \cdot (a \cdot u)$ | PASS・17,424 |
| `check_second_linear_factor_difference.sage` | 負の第一係数の場合の線形比較・分配則 | $(2 \cdot u) \cdot (b \cdot a') - (2 \cdot u) \cdot (a \cdot u) = (2 \cdot u) \cdot (b \cdot a' - a \cdot u)$ | PASS・17,424 |
| `check_second_linear_restore_second_coefficient.sage` | 負の第一係数の場合の線形比較・B の表示 | $(2 \cdot u) \cdot (b \cdot a' - a \cdot u) = (2 \cdot u) \cdot B$ | PASS・17,424 |
| `check_second_square_associate_left_outer.sage` | 負の第一係数の場合の平方比較・結合則 | $(a' \cdot a') \cdot (C \cdot C) = a' \cdot (a' \cdot (C \cdot C))$ | PASS・17,424 |
| `check_second_square_associate_left_inner.sage` | 負の第一係数の場合の平方比較・結合則 | $a' \cdot (a' \cdot (C \cdot C)) = a' \cdot ((a' \cdot C) \cdot C)$ | PASS・17,424 |
| `check_second_square_commute_left_middle.sage` | 負の第一係数の場合の平方比較・可換則 | $a' \cdot ((a' \cdot C) \cdot C) = a' \cdot ((C \cdot a') \cdot C)$ | PASS・17,424 |
| `check_second_square_associate_left_nested.sage` | 負の第一係数の場合の平方比較・結合則 | $a' \cdot ((C \cdot a') \cdot C) = a' \cdot (C \cdot (a' \cdot C))$ | PASS・17,424 |
| `check_second_square_group_left_square.sage` | 負の第一係数の場合の平方比較・結合則 | $a' \cdot (C \cdot (a' \cdot C)) = (a' \cdot C) \cdot (a' \cdot C)$ | PASS・17,424 |
| `check_second_square_square_linear_bound.sage` | 負の第一係数の場合の平方比較・0≤a'C≤(2u)B の平方比較 | $(a' \cdot C) \cdot (a' \cdot C) \le ((2 \cdot u) \cdot B) \cdot ((2 \cdot u) \cdot B)$ | PASS・3,651 |
| `check_second_square_associate_twice_u_products.sage` | 負の第一係数の場合の平方比較・結合則 | $((2 \cdot u) \cdot B) \cdot ((2 \cdot u) \cdot B) = (2 \cdot (u \cdot B)) \cdot (2 \cdot (u \cdot B))$ | PASS・17,424 |
| `check_second_square_associate_twice_outer.sage` | 負の第一係数の場合の平方比較・結合則 | $(2 \cdot (u \cdot B)) \cdot (2 \cdot (u \cdot B)) = 2 \cdot ((u \cdot B) \cdot (2 \cdot (u \cdot B)))$ | PASS・17,424 |
| `check_second_square_associate_twice_inner.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot ((u \cdot B) \cdot (2 \cdot (u \cdot B))) = 2 \cdot (((u \cdot B) \cdot 2) \cdot (u \cdot B))$ | PASS・17,424 |
| `check_second_square_commute_twice_inner.sage` | 負の第一係数の場合の平方比較・可換則 | $2 \cdot (((u \cdot B) \cdot 2) \cdot (u \cdot B)) = 2 \cdot ((2 \cdot (u \cdot B)) \cdot (u \cdot B))$ | PASS・17,424 |
| `check_second_square_group_twice_factor.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot ((2 \cdot (u \cdot B)) \cdot (u \cdot B)) = 2 \cdot (2 \cdot ((u \cdot B) \cdot (u \cdot B)))$ | PASS・17,424 |
| `check_second_square_associate_u_outer.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot (2 \cdot ((u \cdot B) \cdot (u \cdot B))) = 2 \cdot (2 \cdot (u \cdot (B \cdot (u \cdot B))))$ | PASS・17,424 |
| `check_second_square_associate_u_inner.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot (2 \cdot (u \cdot (B \cdot (u \cdot B)))) = 2 \cdot (2 \cdot (u \cdot ((B \cdot u) \cdot B)))$ | PASS・17,424 |
| `check_second_square_commute_u_middle.sage` | 負の第一係数の場合の平方比較・可換則 | $2 \cdot (2 \cdot (u \cdot ((B \cdot u) \cdot B))) = 2 \cdot (2 \cdot (u \cdot ((u \cdot B) \cdot B)))$ | PASS・17,424 |
| `check_second_square_associate_u_nested.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot (2 \cdot (u \cdot ((u \cdot B) \cdot B))) = 2 \cdot (2 \cdot (u \cdot (u \cdot (B \cdot B))))$ | PASS・17,424 |
| `check_second_square_group_u_square.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot (2 \cdot (u \cdot (u \cdot (B \cdot B)))) = 2 \cdot (2 \cdot ((u \cdot u) \cdot (B \cdot B)))$ | PASS・17,424 |
| `check_second_square_associate_twice_u_square.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot (2 \cdot ((u \cdot u) \cdot (B \cdot B))) = 2 \cdot ((2 \cdot (u \cdot u)) \cdot (B \cdot B))$ | PASS・17,424 |
| `check_second_square_commute_twice_u_square.sage` | 負の第一係数の場合の平方比較・可換則 | $2 \cdot ((2 \cdot (u \cdot u)) \cdot (B \cdot B)) = 2 \cdot (((u \cdot u) \cdot 2) \cdot (B \cdot B))$ | PASS・17,424 |
| `check_second_square_associate_twice_B_square.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot (((u \cdot u) \cdot 2) \cdot (B \cdot B)) = 2 \cdot ((u \cdot u) \cdot (2 \cdot (B \cdot B)))$ | PASS・17,424 |
| `check_second_square_group_right_twice_square.sage` | 負の第一係数の場合の平方比較・結合則 | $2 \cdot ((u \cdot u) \cdot (2 \cdot (B \cdot B))) = (2 \cdot (u \cdot u)) \cdot (2 \cdot (B \cdot B))$ | PASS・17,424 |
| `check_second_square_strict_square_bound.sage` | 負の第一係数の場合の平方比較・2u²<a'² を正因子 2B² で乗算 | $(2 \cdot (u \cdot u)) \cdot (2 \cdot (B \cdot B)) < (a' \cdot a') \cdot (2 \cdot (B \cdot B))$ | PASS・4,989 |
| `check_second_final_cancel_positive_factor.sage` | 負の第一係数条件の正因子消去・正因子 a'² の消去 | $C \cdot C < 2 \cdot (B \cdot B)$ | PASS・8,287 |
| `check_second_final_insert_negative_squares.sage` | 負の第一係数条件の確定・二つの負号の積 | $A \cdot A = (-A) \cdot (-A)$ | PASS・17,424 |
| `check_second_final_substitute_negative_first.sage` | 負の第一係数条件の確定・C=-A | $(-A) \cdot (-A) = C \cdot C$ | PASS・17,424 |
| `check_second_final_cancel_positive_square.sage` | 負の第一係数条件の確定・正因子 a'² の消去で得た不等式 | $C \cdot C < 2 \cdot (B \cdot B)$ | PASS・8,287 |
| `check_second_negative_membership.sage` | 第二の場合で第一係数が負の積の所属 | $\xi\eta\in P_s$ | PASS・4,848 |

基本標本に追加する局所条件は次のとおり。上表の他の行には追加条件がない。

| ファイル | 追加条件 |
|---|---|
| `check_product_representation.sage` | $(a,b) \ne (0,0)\ \land\ 2 \cdot u \cdot u < a' \cdot a'$ |
| `check_input_square_strict_input_bound.sage` | $2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_zero_square_assumed_square_equality.sage` | $a \cdot a = 2 \cdot (b \cdot b)$ |
| `check_zero_square_substitute_zero_coefficient.sage` | $b = 0$ |
| `check_first_a_zero_substitute_zero.sage` | $a = 0$ |
| `check_first_b_zero_substitute_zero.sage` | $b = 0$ |
| `check_first_contradiction_square_bound.sage` | $a \cdot a' \le 2 \cdot (b \cdot u)$ |
| `check_first_contradiction_strict_square_bound.sage` | $b > 0\ \land\ 2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_first_contradiction_cancel_positive_factor.sage` | $(a \cdot a) \cdot (a' \cdot a') < (2 \cdot (b \cdot b)) \cdot (a' \cdot a')$ |
| `check_first_nonnegative_membership.sage` | $(a,b) \ne (0,0)\ \land\ 2 \cdot u \cdot u < a' \cdot a'\ \land\ (2 \cdot (b \cdot b) < a \cdot a\ \land\ 0 \le B)$ |
| `check_first_step_multiply_bound.sage` | $2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_first_linear_subtract_product_bound.sage` | $2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_first_square_strict_square_bound.sage` | $V > 0\ \land\ 2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_first_square_square_linear_bound.sage` | $0 \le a' \cdot V\ \land\ a' \cdot V \le u \cdot A$ |
| `check_first_final_cancel_positive_factor.sage` | $(u \cdot u) \cdot (2 \cdot (V \cdot V)) < (u \cdot u) \cdot (A \cdot A)$ |
| `check_first_final_cancel_positive_square.sage` | $(u \cdot u) \cdot (2 \cdot (V \cdot V)) < (u \cdot u) \cdot (A \cdot A)$ |
| `check_first_negative_membership.sage` | $(a,b) \ne (0,0)\ \land\ 2 \cdot u \cdot u < a' \cdot a'\ \land\ (2 \cdot (b \cdot b) < a \cdot a\ \land\ B < 0)$ |
| `check_second_b_zero_substitute_zero.sage` | $b = 0$ |
| `check_second_a_zero_substitute_zero.sage` | $a = 0$ |
| `check_second_square_le_square_bound.sage` | $0 \le b \cdot a'\ \land\ b \cdot a' \le a \cdot u$ |
| `check_second_contradiction_twice_square_bound.sage` | $(b \cdot a') \cdot (b \cdot a') \le (a \cdot u) \cdot (a \cdot u)$ |
| `check_second_contradiction_strict_square_bound.sage` | $a > 0\ \land\ 2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_second_contradiction_cancel_positive_factor.sage` | $(2 \cdot (b \cdot b)) \cdot (a' \cdot a') < (a \cdot a) \cdot (a' \cdot a')$ |
| `check_second_nonnegative_membership.sage` | $(a,b) \ne (0,0)\ \land\ 2 \cdot u \cdot u < a' \cdot a'\ \land\ (a \cdot a < 2 \cdot (b \cdot b)\ \land\ 0 \le A)$ |
| `check_second_step_multiply_bound.sage` | $2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_second_linear_subtract_product_bound.sage` | $2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_second_square_square_linear_bound.sage` | $0 \le a' \cdot C\ \land\ a' \cdot C \le (2 \cdot u) \cdot B$ |
| `check_second_square_strict_square_bound.sage` | $B > 0\ \land\ 2 \cdot (u \cdot u) < a' \cdot a'$ |
| `check_second_final_cancel_positive_factor.sage` | $(a' \cdot a') \cdot (C \cdot C) < (a' \cdot a') \cdot (2 \cdot (B \cdot B))$ |
| `check_second_final_cancel_positive_square.sage` | $(a' \cdot a') \cdot (C \cdot C) < (a' \cdot a') \cdot (2 \cdot (B \cdot B))$ |
| `check_second_negative_membership.sage` | $(a,b) \ne (0,0)\ \land\ 2 \cdot u \cdot u < a' \cdot a'\ \land\ (a \cdot a < 2 \cdot (b \cdot b)\ \land\ A < 0)$ |

`check_global.sage` は分子0〜6・分母1〜6を用いる既存統合検算である。第一の場合で第二係数が非負の23,450組、負の26,818組、第二の場合で第一係数が非負の29,124組、負の43,083組が通過した。統合検算中の背理法の枝は到達不能であるため、その枝の式変形を検査済みとは数えない。上表の独立した行別検算が対応する。

すべて `QQ` または二次体での厳密計算であり、浮動小数点を使わず、実数体・複素数体への脱出はない。有限標本の検算は一般命題の証明を代用しない。

プロジェクト直下で `sage sagemath/check/quadratic-positive-mul-nonnegative-negative-second/check.sage` を実行する。ランナーは各ファイルのパスを明示して読み込み、157行と統合検算をすべて実行する。
