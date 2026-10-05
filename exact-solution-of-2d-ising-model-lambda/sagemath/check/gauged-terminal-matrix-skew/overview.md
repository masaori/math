# 変換後の端末行列の反対称性の検算

**対象ラベル**: `claim_gauged_terminal_matrix_skew`

**実行日**: 2026-10-05。全87行別ファイルと統合検算が PASS。

本文の表示式77行を1ファイルずつ検査し、計1,164,128等式が一致した。方向表・条件の対称性・条件付き係数の10ファイルは計128,256比較が一致した。自然数冪から整数冪への型変換だけの Lean 行は、本文で宣言した一致として扱う。

辺長一・二・三、四つのねじれ、四つの原始八乗根の全48例を、円分体 `CyclotomicField(8)` とその一変数多項式環で計算する。行列は格子の端点から Kac–Ward 行列、反転行列、対角行列を作って直接掛け、全25,088成分の反対称性と零対角を確認する。辺長一で二条件が同時に真になる64成分でも、二つの寄与を独立に残す。有限例の検算であり、任意の辺長の証明は本文と Lean が担う。

```sh
sage sagemath/check/gauged-terminal-matrix-skew/check.sage
```

`check.sage` は全行別ファイルを読み、最後に行列全体を比較する。`_prelude.sage` は定義からの検算例と各計算鎖を用意する。

| ファイル | 本文の計算 | 結果 |
|---|---|---|
| `check_weight_definition.sage` | 重みの整数冪表示：定義の代入 | PASS・25,088等式 |
| `check_weight_inverse_powers.sage` | 重みの整数冪表示：逆重みの二冪を結合 | PASS・25,088等式 |
| `check_weight_direct_powers.sage` | 重みの整数冪表示：重みの二冪を結合 | PASS・25,088等式 |
| `check_weight_inner_product.sage` | 重みの整数冪表示：内側の冪を結合 | PASS・25,088等式 |
| `check_weight_outer_product.sage` | 重みの整数冪表示：外側の冪を結合 | PASS・25,088等式 |
| `check_weight_integer_arithmetic.sage` | 重みの整数冪表示：整数指数の整理 | PASS・25,088等式 |
| `check_sign_parity.sage` | 符号の整数冪表示：ねじれ偶奇へ置換 | PASS・896等式 |
| `check_sign_integer_embedding.sage` | 符号の整数冪表示：整数からの包含 | PASS・896等式 |
| `check_sign_fourth_power.sage` | 符号の整数冪表示：四乗が負の一 | PASS・896等式 |
| `check_sign_power_product.sage` | 符号の整数冪表示：冪の乗法則 | PASS・896等式 |
| `check_reversal_weight_formula.sage` | 反転辺との重み：重みの整数冪を代入 | PASS・896等式 |
| `check_reversal_parity_invariance.sage` | 反転辺との重み：反転で偶奇不変 | PASS・896等式 |
| `check_reversal_cancel_parity.sage` | 反転辺との重み：偶奇の項を取消 | PASS・896等式 |
| `check_reversal_direction_table.sage` | 反転辺との重み：反転方向の表 | PASS・896等式 |
| `check_reversal_root_values.sage` | 反転辺との重み：零乗と四乗 | PASS・896等式 |
| `check_phase_equal_table.sage` | 同方向の重み付き位相：方向位相の表 | PASS・16等式 |
| `check_phase_equal_zero_product.sage` | 同方向の重み付き位相：零との積 | PASS・16等式 |
| `check_phase_upper_table.sage` | 方向が増す場合の重み付き位相：方向位相の表 | PASS・24等式 |
| `check_phase_upper_power_addition.sage` | 方向が増す場合の重み付き位相：冪の加法則 | PASS・24等式 |
| `check_phase_upper_cancel_exponents.sage` | 方向が増す場合の重み付き位相：指数の取消 | PASS・24等式 |
| `check_phase_upper_zeroth_power.sage` | 方向が増す場合の重み付き位相：零乗 | PASS・24等式 |
| `check_phase_lower_table.sage` | 方向が減る場合の重み付き位相：方向位相の表 | PASS・24等式 |
| `check_phase_lower_power_addition.sage` | 方向が減る場合の重み付き位相：冪の加法則 | PASS・24等式 |
| `check_phase_lower_combine_exponents.sage` | 方向が減る場合の重み付き位相：指数を四へ整理 | PASS・24等式 |
| `check_phase_lower_fourth_power.sage` | 方向が減る場合の重み付き位相：四乗が負の一 | PASS・24等式 |
| `check_short_value_weight_formula.sage` | 短い対の補助係数：重みの整数冪を代入 | PASS・25,088等式 |
| `check_short_value_sign_formula.sage` | 短い対の補助係数：符号の整数冪を代入 | PASS・25,088等式 |
| `check_short_value_associate.sage` | 短い対の補助係数：乗法の結合 | PASS・25,088等式 |
| `check_short_value_power_addition.sage` | 短い対の補助係数：冪の加法則 | PASS・25,088等式 |
| `check_short_value_integer_arithmetic.sage` | 短い対の補助係数：整数指数の整理 | PASS・25,088等式 |
| `check_short_value_split_exponent.sage` | 短い対の補助係数：冪を二つへ分離 | PASS・25,088等式 |
| `check_short_value_associate_for_swap.sage` | 短い対の補助係数：交換前の結合 | PASS・25,088等式 |
| `check_short_value_commute.sage` | 短い対の補助係数：乗法の交換 | PASS・25,088等式 |
| `check_short_value_regroup.sage` | 短い対の補助係数：交換後の結合 | PASS・25,088等式 |
| `check_short_value_phase_value.sage` | 短い対の補助係数：方向位相の値を代入 | PASS・25,088等式 |
| `check_short_swap_value.sage` | 補助係数の交換：補助係数の値を代入 | PASS・25,088等式 |
| `check_short_swap_direction_sign.sage` | 補助係数の交換：方向交換の負号 | PASS・25,088等式 |
| `check_short_swap_negative_product.sage` | 補助係数の交換：負号と積 | PASS・25,088等式 |
| `check_short_swap_parity_sum.sage` | 補助係数の交換：偶奇の和を交換 | PASS・25,088等式 |
| `check_short_swap_reverse_value.sage` | 補助係数の交換：二辺を交換した係数へ戻す | PASS・25,088等式 |
| `check_long_true_condition.sage` | 反転辺である場合：条件の分岐を代入 | PASS・896等式 |
| `check_long_true_one_product.sage` | 反転辺である場合：一との積 | PASS・896等式 |
| `check_long_true_coefficient.sage` | 反転辺である場合：係数の定義へ戻す | PASS・896等式 |
| `check_long_false_condition.sage` | 反転辺でない場合：条件の分岐を代入 | PASS・24,192等式 |
| `check_long_false_zero_product.sage` | 反転辺でない場合：零との積 | PASS・24,192等式 |
| `check_long_false_zero_embedding.sage` | 反転辺でない場合：包含は零を保つ | PASS・24,192等式 |
| `check_long_false_coefficient.sage` | 反転辺でない場合：係数の定義へ戻す | PASS・24,192等式 |
| `check_short_true_condition.sage` | 始点一致・相異の条件が真の場合：条件の分岐を代入 | PASS・2,688等式 |
| `check_short_true_multiply_embedding.sage` | 始点一致・相異の条件が真の場合：包含は積を保つ | PASS・2,688等式 |
| `check_short_true_coefficient.sage` | 始点一致・相異の条件が真の場合：係数の定義へ戻す | PASS・2,688等式 |
| `check_short_false_condition.sage` | 始点一致・相異の条件が偽の場合：条件の分岐を代入 | PASS・22,400等式 |
| `check_short_false_zero_product.sage` | 始点一致・相異の条件が偽の場合：零との積 | PASS・22,400等式 |
| `check_short_false_zero_embedding.sage` | 始点一致・相異の条件が偽の場合：包含は零を保つ | PASS・22,400等式 |
| `check_short_false_coefficient.sage` | 始点一致・相異の条件が偽の場合：係数の定義へ戻す | PASS・22,400等式 |
| `check_entry_known_entry.sage` | 二つの寄与への成分分離：既知の成分式 | PASS・25,088等式 |
| `check_entry_distribute.sage` | 二つの寄与への成分分離：分配則 | PASS・25,088等式 |
| `check_entry_associate_left.sage` | 二つの寄与への成分分離：左へ結合 | PASS・25,088等式 |
| `check_entry_commute.sage` | 二つの寄与への成分分離：乗法の交換 | PASS・25,088等式 |
| `check_entry_associate_right.sage` | 二つの寄与への成分分離：右へ結合 | PASS・25,088等式 |
| `check_entry_long_coefficient.sage` | 二つの寄与への成分分離：反転辺の寄与を代入 | PASS・25,088等式 |
| `check_entry_short_coefficient.sage` | 二つの寄与への成分分離：始点一致の寄与を代入 | PASS・25,088等式 |
| `check_skew_separated_entry.sage` | 成分の反対称性：分離した成分式 | PASS・25,088等式 |
| `check_skew_long_sign.sage` | 成分の反対称性：反転辺の係数の負号 | PASS・25,088等式 |
| `check_skew_short_sign.sage` | 成分の反対称性：始点一致の係数の負号 | PASS・25,088等式 |
| `check_skew_long_negation_embedding.sage` | 成分の反対称性：左の負号を包含の外へ | PASS・25,088等式 |
| `check_skew_short_negation_embedding.sage` | 成分の反対称性：右の負号を包含の外へ | PASS・25,088等式 |
| `check_skew_negative_product.sage` | 成分の反対称性：負号と積 | PASS・25,088等式 |
| `check_skew_subtract_negative.sage` | 成分の反対称性：減法を加法へ | PASS・25,088等式 |
| `check_skew_negative_sum.sage` | 成分の反対称性：和の加法逆元 | PASS・25,088等式 |
| `check_skew_subtract_definition.sage` | 成分の反対称性：加法を減法へ | PASS・25,088等式 |
| `check_skew_reverse_entry.sage` | 成分の反対称性：二辺を交換した成分式 | PASS・25,088等式 |
| `check_diagonal_known_entry.sage` | 対角成分の零：既知の成分式 | PASS・896等式 |
| `check_diagonal_no_fixed_point.sage` | 対角成分の零：反転写像に不動点なし | PASS・896等式 |
| `check_diagonal_distinct_condition.sage` | 対角成分の零：同じ辺は相異ならない | PASS・896等式 |
| `check_diagonal_inner_zero_product.sage` | 対角成分の零：内側の零との積 | PASS・896等式 |
| `check_diagonal_subtract_zero.sage` | 対角成分の零：零の減法 | PASS・896等式 |
| `check_diagonal_outer_zero_product.sage` | 対角成分の零：外側の零との積 | PASS・896等式 |
| `check_aux_direction_sign_swap.sage` | 方向順序の符号は交換で反転する | PASS・64比較 |
| `check_aux_long_coefficient_skew.sage` | 反転辺の条件付き係数は反対称 | PASS・25,088比較 |
| `check_aux_long_condition.sage` | 反転辺という条件は交換で不変 | PASS・25,088比較 |
| `check_aux_phase_agreement.sage` | 反転辺からの位相と方向表が一致する | PASS・25,088比較 |
| `check_aux_phase_formula.sage` | 方向表と場合別の指数表示が一致する | PASS・64比較 |
| `check_aux_reversal_direction.sage` | 反転方向は二だけ進む | PASS・896比較 |
| `check_aux_reversal_exponent.sage` | 反転方向の代表から指数が零または四となる | PASS・896比較 |
| `check_aux_reversal_parity.sage` | 反転でねじれ偶奇は変わらない | PASS・896比較 |
| `check_aux_short_coefficient_skew.sage` | 始点一致の条件付き係数は反対称 | PASS・25,088比較 |
| `check_aux_short_condition.sage` | 同じ始点と相異の条件は交換で不変 | PASS・25,088比較 |
