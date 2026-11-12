# 非退化な二次形式の直交基底の存在の検算

- 対象ラベル: `claim_polarization_of_quadratic_form_is_linear_in_second_argument`
- 対象ラベル: `claim_polarization_of_quadratic_form_on_diagonal_is_twice_value`
- 対象ラベル: `claim_quadratic_form_at_sum_with_scalar_multiple`
- 対象ラベル: `claim_member_of_linearly_independent_family_is_nonzero`
- 対象ラベル: `claim_element_orthogonal_to_spanning_family_is_zero`
- 対象ラベル: `claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged`
- 対象ラベル: `claim_linear_combination_of_family_adding_multiples_of_one_member`
- 対象ラベル: `claim_family_adding_multiples_of_one_member_to_basis_is_basis`
- 対象ラベル: `claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value`
- 対象ラベル: `claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero`
- 対象ラベル: `claim_orthogonalization_step_extends_orthogonalized_part`
- 対象ラベル: `claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form`
- 検算: [check_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form.sage](check_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form.sage)
- 方法: $`V=\mathbb{Q}^n`$、$`q(x)=x^{\mathsf T}Ax`$（$`A`$ は有理数の対称行列で行列式が 0 でない）とし、偏極 $`B_q`$ は定義どおり $`q(x+y)-q(x)-q(y)`$ で計算する。
  本文の証明の手順（第 $`k+1`$ 元で $`q`$ が 0 なら、直交しない後ろの元 $`e_j`$ の $`t\in\{1,-1\}`$ 倍を足す → 第 $`k+1`$ 元の倍を後ろの元から引いて直交化する）をそのまま実装し、
  各段で、族が基底であること、第 $`k`$ 元まで直交化された基底の三つの条件、一つの元の倍を足した族の線型結合の式、係数の選び方の鎖の行
  （$`q(e_{k+1}+te_j)=\gamma+t\beta`$、$`2\beta`$ が二つの値の差で書けること）、直交化の鎖の行を確かめる。
  補題（第二引数の線型性、$`B_q(x,x)=2q(x)`$、$`q(x+ty)`$ の展開、張る族と直交する元が零）は乱数の元で確かめる。
  固定した 6 例（対による二次形式の形、$`t=-1`$ が要る例を含む）と、対角を一部 0 にした乱数の 40 例（$`n=1,\dots,5`$）で回した。取り替えの段は 33 回、$`t=-1`$ は 3 回通った。
  否定の対照: 係数の 2 を落として $`q(v)`$ で割ると後ろに直交しない元が残ること（105 回）、退化した形 $`\mathrm{diag}(0,1)`$ では第一元と直交しない元が無いこと、
  足す元自身の係数が 0 でない族は基底にならない例があることを確かめた。計算は有理数の厳密計算（`QQ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/existence-of-orthogonal-basis-for-nondegenerate-quadratic-form/check_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。
- 位置づけ: $`\mathbb{C}`$ 上の一般の線型空間についての主張を、$`\mathbb{Q}^n`$ と有限個の例で確かめた裏取りであり、証明の代わりではない。
