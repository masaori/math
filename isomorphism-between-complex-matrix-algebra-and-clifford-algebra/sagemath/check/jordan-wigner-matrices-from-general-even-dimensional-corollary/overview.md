# 系「複素行列版イジングの Jordan–Wigner 行列への接続」の検算

- 対象ラベル: `claim_product_of_two_ordered_products_in_complex_numbers`
- 対象ラベル: `claim_ordered_product_with_unit_factors_after_index`
- 対象ラベル: `claim_ordered_product_with_zero_factor_is_zero`
- 対象ラベル: `def_membership_index_of_subset`
- 対象ラベル: `claim_entry_of_product_of_matrices_indexed_by_two_element_set`
- 対象ラベル: `def_kronecker_product_indexed_by_power_set`
- 対象ラベル: `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers`
- 対象ラベル: `claim_product_of_kronecker_products_is_kronecker_product_of_products`
- 対象ラベル: `claim_kronecker_product_of_identity_matrices_is_identity_matrix`
- 対象ラベル: `claim_kronecker_product_is_linear_in_one_factor`
- 対象ラベル: `def_conjugation_of_matrices`
- 対象ラベル: `def_pauli_matrix_x`
- 対象ラベル: `def_pauli_matrix_y`
- 対象ラベル: `def_pauli_matrix_z`
- 対象ラベル: `def_matrix_exchanging_pauli_z_and_x`
- 対象ラベル: `def_half_of_matrix_exchanging_pauli_z_and_x`
- 対象ラベル: `claim_entries_of_combination_of_off_diagonal_matrix_units`
- 対象ラベル: `claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity`
- 対象ラベル: `claim_half_times_matrix_exchanging_pauli_matrices_is_identity`
- 対象ラベル: `claim_matrix_k_turns_pauli_z_into_pauli_x`
- 対象ラベル: `claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z`
- 対象ラベル: `claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y`
- 対象ラベル: `claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count`
- 対象ラベル: `claim_creation_operator_matrix_is_kronecker_product`
- 対象ラベル: `claim_annihilation_operator_matrix_is_kronecker_product`
- 対象ラベル: `def_jordan_wigner_z_matrix`
- 対象ラベル: `def_jordan_wigner_y_matrix`
- 対象ラベル: `def_kronecker_power_of_matrix_exchanging_pauli_z_and_x`
- 対象ラベル: `def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x`
- 対象ラベル: `claim_kronecker_power_of_k_times_that_of_its_half_is_identity`
- 対象ラベル: `claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity`
- 対象ラベル: `claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix`
- 対象ラベル: `claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix`
- 対象ラベル: `def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power`
- 対象ラベル: `def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power`
- 対象ラベル: `theorem_clifford_algebra_of_general_even_dimensional_space_sends_orthonormal_basis_to_jordan_wigner_matrices`
- 検算: [check_jordan_wigner_matrices_from_general_even_dimensional_corollary.sage](check_jordan_wigner_matrices_from_general_even_dimensional_corollary.sage)
- 方法: 行列を $`\mathcal{P}_M`$ の元の組から値への辞書として持ち、本文の定義どおり（番号付けを使わない添字 $`o_T(k)`$、$`\mathcal{P}_M`$ の上の和、$`\mathbb{C}`$ の中の番号順の積）に `QQbar` で厳密計算した。$`M=1,2,3`$、すべての $`m`$。
  2 次の行列の主張（$`KK'=K'K=1`$、$`K\sigma^z=\sigma^xK`$、$`KG=\sigma^zK`$、$`KG'=\sigma^yK`$、非対角の行列単位の線型結合の成分、積の成分の式）、$`\mathbb{C}`$ の番号順の積の三つの補題（乱数の族）、部分集合全体の上の和と因子の和の積、クロネッカー積の積・単位行列・一つの因子の線型性（乱数の因子）、$`UU'=U'U=1`$、符号の補題（すべての $`T`$）、$`c_m`$ と $`c_m^{\mathsf T}`$ のクロネッカー積の形、$`U(c_m+c_m^{\mathsf T})U'=Z_m`$、$`U((-\mathrm{i})c_m+\mathrm{i}c_m^{\mathsf T})U'=Y_m`$ を確かめた。
  主定理の系の側は行列への像で確かめた：$`\Omega(\gamma_Y(e_k))`$ にあたる $`Z_1,\dots,Z_M,Y_1,\dots,Y_M`$ が反交換関係 $`XY+YX=2\delta I`$ を満たすこと（$`\Omega`$ が準同型であることの像での裏取り）。
  否定の対照: $`U'`$ の代わりに $`U`$ で挟むと $`Z_m`$ にならないこと（$`h`$ を落とすと $`2^M`$ 倍になる）、$`m`$ 番目の因子を $`-\sigma^y`$ にした行列とは一致しないこと（すべての $`M,m`$）。
- 実行: `micromamba run -n sage sage sagemath/check/jordan-wigner-matrices-from-general-even-dimensional-corollary/check_jordan_wigner_matrices_from_general_even_dimensional_corollary.sage`（SageMath 10.9、2026-11-13、約 20 秒）。
- 結果: 通過（308 件）。
- 位置づけ: クリフォード代数の中の等式（$`\Phi_Y(\gamma_Y(e_m))=c_m+c_m^{\mathsf T}`$ など）は、行列への像での確認であり、証明の代わりではない。
