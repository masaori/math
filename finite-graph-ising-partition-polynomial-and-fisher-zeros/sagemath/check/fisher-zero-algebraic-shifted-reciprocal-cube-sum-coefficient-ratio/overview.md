# SageMath Check: 代数的評価点における Fisher 零点差の逆三乗和と係数表示

## 対象

**対象ラベル**: `theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio`

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio`）
- 範囲: 係数表示と一次因子積の前三回の形式微分、有限三重和の分解、最終係数比
- 併せて検証: 逆数和と逆二乗和の既存係数表示の代入

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_rational_coefficient_expansion.sage` | 整数係数表示を有理数係数表示へ移す標準単射 | PASS | 全例で係数ごとの像が一致 |
| `check_polynomial_embedding_composition.sage` | 整数係数多項式から代数的数係数多項式への標準単射の合成 | PASS | 直接の像と有理数係数多項式を経由した像が一致 |
| `check_algebraic_coefficient_expansion.sage` | 有理数係数表示を代数的数係数表示へ移す標準単射 | PASS | 全例で係数ごとの像が一致 |
| `check_coefficient_formal_derivatives.sage` | 係数表示の前三回の形式微分 | PASS | 三つの多項式恒等式が一致 |
| `check_first_coefficient_formal_derivative.sage` | 係数表示の一回形式微分 | PASS | 本文の一回形式微分式が全例で一致 |
| `check_second_coefficient_formal_derivative.sage` | 係数表示の二回形式微分 | PASS | 本文の二回形式微分式が全例で一致 |
| `check_third_coefficient_formal_derivative.sage` | 係数表示の三回形式微分 | PASS | 本文の三回形式微分式が全例で一致 |
| `check_qbar_embedding_finite_product.sage` | 有理数から代数的数への標準単射の有限積保存 | PASS | 全例で四因子積が一致 |
| `check_qq_embedding_finite_product.sage` | 自然数から有理数への標準単射の有限積保存 | PASS | 全例で四因子積が一致 |
| `check_falling_factorial_expansion.sage` | 三因子下降積の展開 | PASS | 全例で有限積の展開が一致 |
| `check_natural_product_commutativity.sage` | 自然数積の並べ替え | PASS | 全例で積の並べ替えが一致 |
| `check_evaluate_third_coefficient_sum.sage` | 三回形式微分式への評価点代入 | PASS | 全例・全評価点で表示した係数有限和と一致 |
| `check_third_coefficient_sum_local_definition.sage` | 評価後の係数有限和と局所記号 `C_G(a)` | PASS | 表示した有限和と局所定義が一致 |
| `check_third_coefficient_sum_definition.sage` | 三回形式微分の評価と第三係数和 | PASS | 全例・全評価点で一致 |
| `check_first_product_formal_derivative.sage` | 一次因子積の一回形式微分 | PASS | 本文の一回形式微分式が全例で一致 |
| `check_second_product_formal_derivative.sage` | 一次因子積の二回形式微分 | PASS | 本文の二回形式微分式が全例で一致 |
| `check_third_product_formal_derivative.sage` | 一次因子積の三回形式微分 | PASS | 本文の三回形式微分式が全例で一致 |
| `check_product_formal_derivatives.sage` | 一次因子積の前三回の形式微分 | PASS | 順序付き除外添字和と一致 |
| `check_evaluate_product_third_derivative.sage` | 一次因子積の三回形式微分式への評価点代入 | PASS | 全例・全評価点で評価後の順序付き除外添字和と一致 |
| `check_linear_factorization.sage` | 代数的閉体上の重複度込み一次因子分解 | PASS | 全例で最高次係数と零点差の有限積が分配多項式に一致 |
| `check_evaluate_linear_factorization.sage` | 一次因子分解への評価点代入 | PASS | 全例・全評価点で評価値と最高次係数像を掛けた零点差積が一致 |
| `check_leading_multiplicity_nonzero.sage` | 自然数の最高次多重度の非零性 | PASS | 全例で正値性から非零性を確認 |
| `check_rational_embedded_leading_coefficient_nonzero.sage` | 自然数から有理数への標準単射像の非零性 | PASS | 全例で有理数像の非零性を確認 |
| `check_leading_coefficient_nonzero.sage` | 有理数から代数的数への標準単射像の非零性 | PASS | 全例で代数的数像の非零性を確認 |
| `check_evaluated_factorization_nonzero.sage` | 非零評価値を一次因子分解の評価式へ移した積の非零性 | PASS | 全ての非零評価で最高次係数像と零点差積の積が非零 |
| `check_root_difference_product_nonzero.sage` | 非零な最高次係数像との積から零点差積の非零性を導く一行 | PASS | 全ての非零な評価済み因子分解で零点差積が非零 |
| `check_root_differences_nonzero.sage` | 非零な零点差積から各零点差の非零性を導く一行 | PASS | 全ての非零な零点差積で各因子が非零 |
| `check_substitute_third_derivative_numerator.sage` | 三回形式微分比の分子へ一次因子積の三回形式微分式を代入 | PASS | 全ての非零評価で代入前後が一致 |
| `check_substitute_factorization_denominator.sage` | 三回形式微分比の分母へ評価済み一次因子分解を代入 | PASS | 全ての非零評価で代入前後が一致 |
| `check_cancel_leading_coefficient.sage` | 三回微分比の最高次係数消去 | PASS | 全ての非零評価で一致 |
| `check_distribute_third_derivative_ratio.sage` | 三重和への分母分配 | PASS | 全ての非零評価で一致 |
| `check_cancel_three_root_factors.sage` | 各三重和項の三因子消去 | PASS | 全ての非零評価で項別に一致 |
| `check_third_derivative_root_ratio.sage` | 三回微分と相異なる順序付き三重和 | PASS | 全ての非零評価で一致 |
| `check_substitute_third_coefficient_sum_into_root_ratio.sage` | 三回微分比へ第三係数和を代入 | PASS | 全ての非零評価で `C_G(a)/Pbar_G(a)=T_{G,3}(a)` が一致 |
| `check_substitute_reciprocal_sum_definition.sage` | 逆数和の定義の代入 | PASS | 逆数和を有限和へ置換しても積が一致 |
| `check_substitute_reciprocal_square_sum_definition.sage` | 逆二乗和の定義の代入 | PASS | 逆二乗和を有限和へ置換しても積が一致 |
| `check_distribute_reciprocal_product.sage` | 二つの有限和の積の分配 | PASS | 積と順序付き有限二重和が一致 |
| `check_reciprocal_product_decomposition.sage` | 順序付き有限二重和の対角・非対角分解 | PASS | 対角・非対角分解が一致 |
| `check_swap_non_diagonal_pair_indices.sage` | 非対角二重和の添字交換 | PASS | 二つの順序付き非対角和が一致 |
| `check_non_diagonal_pair_sum_local_definition.sage` | 非対角二重和の局所定義 | PASS | 逆数和と逆二乗和の積が `S_{G,3}+U_{G,2,1}` に一致 |
| `check_expand_reciprocal_cube.sage` | 逆数和の三乗の有限三重和への展開 | PASS | 三乗と順序付き有限三重和が一致 |
| `check_partition_reciprocal_cube_indices.sage` | 有限三重和の添字一致型による分割 | PASS | 対角・三つの二重一致・相異なる三重添字の五項が一致 |
| `check_swap_reciprocal_cube_pair_indices.sage` | 二重一致項の非対角添字交換 | PASS | `V_{G,1,2}=U_{G,2,1}` を厳密確認 |
| `check_natural_three_as_sum_of_ones.sage` | 自然数 `3` の三つの単位元への加法分解 | PASS | `3=1+1+1` を `NN` 内で厳密確認 |
| `check_apply_rational_embedding_to_three_sum.sage` | `3=1+1+1` への自然数から有理数への標準単射の適用 | PASS | 等式の両辺の有理数像が一致 |
| `check_rational_embedding_three_sum.sage` | 自然数から有理数への標準単射の三項加法保存 | PASS | `eta(3)=eta(1)+eta(1)+eta(1)` を厳密確認 |
| `check_apply_algebraic_embedding_to_three_sum.sage` | 有理数像の三項和への代数的数への標準単射の適用 | PASS | 等式の両辺の代数的数像が一致 |
| `check_algebraic_embedding_three_sum.sage` | 有理数から代数的数への標準単射の三項加法保存 | PASS | 三項和の像が像の三項和と一致 |
| `check_q3_as_triple_q1.sage` | 局所係数 `q_3` と三つの `q_1` の和 | PASS | `q_3=q_1+q_1+q_1` を厳密確認 |
| `check_substitute_q1_pair_terms.sage` | 三つの非対角和への `q_1=1` の適用 | PASS | 三項の各項へ同じ単位元を適用しても一致 |
| `check_factor_q1_pair_terms.sage` | 三つの `q_1` 付き非対角和の分配律による括り出し | PASS | 三項和が `(q_1+q_1+q_1)U_{G,2,1}` と一致 |
| `check_substitute_q3_pair_terms.sage` | `q_3=q_1+q_1+q_1` の非対角和への代入 | PASS | 括り出した係数が `q_3` 倍と一致 |
| `check_collect_reciprocal_cube_pair_terms.sage` | 三つの二重一致項の係数集約 | PASS | 三つの同一和が `q_3U_{G,2,1}` に一致 |
| `check_reciprocal_cube_decomposition.sage` | 逆数和の三乗の一致型分解 | PASS | 三つの添字一致型が一致 |
| `check_subtract_reciprocal_cube_from_decomposition.sage` | 一致型分解の両辺から逆三乗和を引く操作 | PASS | `R_G^3-S_{G,3}=q_3U_{G,2,1}+T_{G,3}` が一致 |
| `check_subtract_non_diagonal_term_from_triple_decomposition.sage` | 非対角二重和項を引く操作 | PASS | `R_G^3-S_{G,3}-q_3U_{G,2,1}=T_{G,3}` が一致 |
| `check_reverse_isolated_triple_sum.sage` | 孤立した相異なる三重和等式の対称律 | PASS | 左右を反転した等式が一致 |
| `check_isolate_triple_sum.sage` | 相異なる順序付き三重和の分離 | PASS | 一致型分解から `T_{G,3}` を移項した等式が一致 |
| `check_isolate_non_diagonal_pair_sum.sage` | 非対角二重和の分離 | PASS | 逆数積から `U_{G,2,1}` を移項した等式が一致 |
| `check_substitute_non_diagonal_pair_sum.sage` | 非対角二重和の代入 | PASS | 分離した `U_{G,2,1}` の式を三重和へ代入した等式が一致 |
| `check_distribute_eliminated_pair_sum.sage` | 非対角二重和代入後の分配 | PASS | 括弧を分配した等式が一致 |
| `check_reorder_eliminated_pair_sum.sage` | 非対角二重和代入後の並べ替え | PASS | 加法項を並べ替えた等式が一致 |
| `check_factor_eliminated_pair_sum.sage` | 非対角二重和代入後の係数括り出し | PASS | `S_{G,3}` の係数が `q_3-1_{Qbar}` に一致 |
| `check_eliminate_non_diagonal_pair_sum_before_integer_coefficient.sage` | 非対角二重和を消去した直後の係数 | PASS | 標準単射像の整数係数整理前に `q_3-1_{Qbar}` を持つ三次恒等式が一致 |
| `check_eliminate_non_diagonal_pair_sum.sage` | 非対角二重和の消去 | PASS | 三次恒等式が一致 |
| `check_third_coefficient_cubic_identity_transitivity.sage` | 第三係数和の比と三次逆数和恒等式の推移律 | PASS | `C_G(a)/Pbar_G(a)=T_{G,3}(a)` と三次恒等式から係数比と逆数和表示が一致 |
| `check_subtract_reciprocal_cube.sage` | 逆数和の三乗を両辺から引く操作 | PASS | 三乗を引いた後の等式が一致 |
| `check_add_reciprocal_product.sage` | 逆数和と逆二乗和の積を両辺へ加える操作 | PASS | 積を加えた後に `q_2S_{G,3}` が孤立する |
| `check_reverse_isolated_reciprocal_cube_sum.sage` | 孤立した逆三乗和等式の対称律 | PASS | 左右を反転した等式が一致 |
| `check_substitute_reciprocal_sum_coefficient_ratio.sage` | 逆数和の係数表示定理の代入 | PASS | `R_G=A_G/Pbar_G` の代入前後が一致 |
| `check_substitute_reciprocal_square_sum_coefficient_ratio.sage` | 逆二乗和の係数表示定理の代入 | PASS | `S_{G,2}=(A_G^2-Pbar_GB_G)/Pbar_G^2` の代入前後が一致 |
| `check_substitute_lower_reciprocal_sums.sage` | 既存の一次・二次係数表示の代入 | PASS | 既存二定理の代入後も一致 |
| `check_expand_cubed_quotient.sage` | 商の三乗 | PASS | 商の三乗と三乗どうしの商が一致 |
| `check_multiply_reciprocal_factors.sage` | 二つの商の積 | PASS | 分子の積と三次分母を持つ商に一致 |
| `check_evaluation_square_nonzero.sage` | 非零評価値の二乗の非零性 | PASS | `Pbar_G(a)\ne0` から `Pbar_G(a)^2\ne0` を厳密確認 |
| `check_raise_first_denominator.sage` | 第一項の分母引き上げ | PASS | 非零な分母の二乗を分子・分母へ掛けても一致 |
| `check_common_denominator.sage` | 同じ分母を持つ三項の結合 | PASS | 三つの商と結合後の一つの商が一致 |
| `check_rational_embedding_one_identity.sage` | 自然数から有理数への標準単射の乗法単位元保存 | PASS | `eta(1)=1_Q` を厳密確認 |
| `check_algebraic_embedding_one_identity.sage` | 有理数から代数的数への標準単射の乗法単位元保存 | PASS | `iota(eta(1))=1_Qbar` を厳密確認 |
| `check_q1_multiplicative_identity.sage` | 標準単射像 `q_1` と乗法単位元 | PASS | `q_1=1` を厳密確認 |
| `check_cubic_numerator_distribution.sage` | 三次分子の分配 | PASS | 全例・全評価点で一致 |
| `check_cubic_numerator_reordering.sage` | 三次分子の加法項の並べ替え | PASS | 全例・全評価点で一致 |
| `check_cubic_coefficient_factoring.sage` | 三次係数の括り出し | PASS | 全例・全評価点で一致 |
| `check_natural_three_as_one_plus_two.sage` | 自然数内の加法 `3=1+2` | PASS | `3=1+2` を `NN` 内で厳密確認 |
| `check_apply_rational_embedding_to_one_plus_two.sage` | `3=1+2` への自然数から有理数への標準単射の適用 | PASS | 等式の両辺の有理数像が一致 |
| `check_rational_embedding_one_plus_two.sage` | 自然数から有理数への標準単射の二項加法保存 | PASS | `eta(3)=eta(1)+eta(2)` を厳密確認 |
| `check_rational_embedding_three_minus_one.sage` | 有理数内の移項 | PASS | `eta(3)-eta(1)=eta(2)` を厳密確認 |
| `check_apply_algebraic_embedding_to_three_minus_one.sage` | 有理数内の差の等式への代数的数標準単射の適用 | PASS | `iota(eta(3)-eta(1))=iota(eta(2))` を厳密確認 |
| `check_algebraic_embedding_three_minus_one.sage` | 有理数から代数的数への標準単射の差の保存 | PASS | `iota(eta(3))-iota(eta(1))=iota(eta(2))` を厳密確認 |
| `check_q3_minus_q1_equals_q2.sage` | 局所係数の差 `q_3-q_1=q_2` | PASS | 三つの局所定義を適用した等式を単独で厳密確認 |
| `check_embedded_integer_coefficients.sage` | 標準単射像の整数係数整理 | PASS | `q_3-q_1=q_2` と分配を確認 |
| `check_substitute_q1_in_coefficient_difference.sage` | `q_1=1` の係数差への代入 | PASS | `q_3-1_{Qbar}=q_3-q_1` を厳密確認 |
| `check_coefficient_difference_transitivity.sage` | 係数差の二等式の推移律 | PASS | `q_3-1_{Qbar}=q_3-q_1` と `q_3-q_1=q_2` から `q_3-1_{Qbar}=q_2` を厳密確認 |
| `check_natural_two_positive.sage` | 自然数 `2` の正値性 | PASS | `2\in\mathbb N_{>0}` を `NN` 内で厳密確認 |
| `check_natural_two_nonzero.sage` | 自然数 `2` の非零性 | PASS | `2\ne0` を `NN` 内で厳密確認 |
| `check_rational_embedding_two_nonzero.sage` | 自然数 `2` の有理数への標準単射像の非零性 | PASS | `eta_{N,Q}(2) != 0` を厳密確認 |
| `check_algebraic_embedding_two_nonzero.sage` | 有理数 `eta_{N,Q}(2)` の代数的数への標準単射像の非零性 | PASS | `iota_{Q,Qbar}(eta_{N,Q}(2)) != 0` を厳密確認 |
| `check_q2_nonzero.sage` | 標準単射像 `q_2` の非零性 | PASS | `q_2\ne0` を厳密確認 |
| `check_scaled_reciprocal_cube_sum_coefficient_ratio.sage` | 最終係数整理後の `q_2` 倍された逆三乗和 | PASS | `q_2S_{G,3}` と三次係数商が一致 |
| `check_cancel_q2_from_reciprocal_cube_sum.sage` | 非零な `q_2` の消去 | PASS | `q_2S_{G,3}=N/P^3` から `S_{G,3}=q_2^{-1}(N/P^3)` へ移る等式を直接確認 |
| `check_merge_q2_denominator.sage` | `q_2` の消去後に商の結合律で三次分母へ結合 | PASS | 除算後の二重の商と結合後の分数が一致 |
| `check_reciprocal_cube_sum_local_definition.sage` | 定理本文の逆三乗有限和への局所定義の適用 | PASS | 表示した有限和と `S_{G,3}(a)` の局所定義が一致 |
| `check_final_coefficient_ratio.sage` | 最終逆三乗和係数比 | PASS | 全ての非零評価で一致 |
| `check_low_degree_empty_sums.sage` | 次数三未満の空和 | PASS | 第三係数和と三重和が零 |

## 備考

- `NN`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。
- `R/C` 脱出および浮動小数点計算は無い。
- Lean 具体版と必要十分版は未着手である。

## 実行方法

```bash
for f in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/check_*.sage; do
  sage "$f"
done
```
