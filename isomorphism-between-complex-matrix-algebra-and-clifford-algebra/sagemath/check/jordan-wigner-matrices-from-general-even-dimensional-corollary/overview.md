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
- 対象ラベル: `claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis`
- 対象ラベル: `claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis`
- 対象ラベル: `claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix`
- 対象ラベル: `claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix`
- 対象ラベル: `theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms`
- 検算: [check_jordan_wigner_matrices_from_general_even_dimensional_corollary.sage](check_jordan_wigner_matrices_from_general_even_dimensional_corollary.sage)
- 方法: 行列を $`\mathcal{P}_M`$ の元の組から値への辞書として持ち、本文の定義どおり（番号付けを使わない添字 $`o_T(k)`$、$`\mathcal{P}_M`$ の上の和、$`\mathbb{C}`$ の中の番号順の積）に `QQbar` で厳密計算した。$`M=1,2,3`$、すべての $`m`$。
  2 次の行列の主張（$`KK'=K'K=1`$、$`K\sigma^z=\sigma^xK`$、$`KG=\sigma^zK`$、$`KG'=\sigma^yK`$、非対角の行列単位の線型結合の成分、積の成分の式）、$`\mathbb{C}`$ の番号順の積の三つの補題（乱数の族）、部分集合全体の上の和と因子の和の積、クロネッカー積の積・単位行列・一つの因子の線型性（乱数の因子）、$`UU'=U'U=1`$、符号の補題（すべての $`T`$）、$`c_m`$ と $`c_m^{\mathsf T}`$ のクロネッカー積の形、$`U(c_m+c_m^{\mathsf T})U'=Z_m`$、$`U((-\mathrm{i})c_m+\mathrm{i}c_m^{\mathsf T})U'=Y_m`$ を確かめた。
  $`\kappa_{U,U'}(c_m+c_m^{\mathsf T})=Z_m`$ と $`\kappa_{U,U'}((-\mathrm{i})c_m+\mathrm{i}c_m^{\mathsf T})=Y_m`$ の証明の途中の行を一行ずつ比べた：（一）$`c_m+c_m^{\mathsf T}=1c_m+1c_m^{\mathsf T}=1\boxtimes A_k+1\boxtimes A'_k=\boxtimes G_k`$（Y の側は $`G'_k`$）、（二）すべての $`k`$ で $`KG_k=F_kK`$、本体の 11 行（$`(UX)U'`$ から $`Z_m`$・$`Y_m`$ まで）。
  $`\Phi_Y`$・$`\Omega`$・$`\Omega'`$ は具体的な $`(Y,Q)`$ で計算した：体は $`\mathbb{Q}(\mathrm{i})`$（`QuadraticField(-1)`、厳密計算）、$`Y:=\mathbb{Q}(\mathrm{i})^{2M}`$、正規直交基底 $`e`$ を有理数の可逆行列の列（乱数、各 $`M`$ で 2 通り）に取り $`Q(y):=y^{\mathsf T}(E^{-1})^{\mathsf T}E^{-1}y`$ と置いた。
  $`\theta=L_{e,u}`$ は $`e`$ の座標と族 $`u`$ で、$`\Phi\circ\gamma`$ は基底 $`d`$ の座標で $`\sum y_kc_k+\sum y_{M+k}c_k^{\mathsf T}`$ として計算した。
  $`\Phi_Y(\gamma_Y(e_m))=c_m+c_m^{\mathsf T}`$ と $`\Phi_Y(\gamma_Y(e_{M+m}))=(-\mathrm{i})c_m+\mathrm{i}c_m^{\mathsf T}`$ は、本文の式変形の各行（$`\theta(e_m)=u_m`$、組の形、$`\mathrm{in}_1(w_m)+\mathrm{in}_2(f_m)`$、埋め込みのスカラー倍、$`\Phi\circ\gamma`$ の線型性、$`\Phi(a^{\dagger}_m)=c_m`$・$`\Phi(a_m)=c_m^{\mathsf T}`$）を一行ずつ比べた。
  $`\Omega(\gamma_Y(e_m))=Z_m`$、$`\Omega(\gamma_Y(e_{M+m}))=Y_m`$ を確かめた。
  $`\Omega(\Omega'(F))=F`$ は、$`\Psi(F)=\sum F_{S,T}a^{\dagger}_SPa_T`$ の生成元を $`\Phi_Y(\gamma_Y(\theta'(d_i)))=\varphi(\theta(\theta'(d_i)))`$ に置き換えて $`\Phi_Y(\Psi_Y(G))`$ を評価し、$`\kappa_{U,U'}(\Phi_Y(\Psi_Y(\kappa_{U',U}(F))))`$ を $`F`$ と比べた（行列単位 $`4^M`$ 個と $`\mathbb{Q}(\mathrm{i})`$ の乱数の行列 3 つ）。
  $`\Omega'\circ\Omega=\mathrm{id}`$ は、クリフォード代数の元を $`\Phi_Y`$ の像で表し、生成元 $`\gamma_Y(e_k)`$（$`2M`$ 個）とその二つの積（$`4M^2`$ 個）について $`\Phi_Y(\Omega'(\Omega(a)))=\Phi_Y(a)`$ を確かめた。これは像での確認である（像から元へ戻すには $`\Phi_Y`$ が単射であることを使う）。
  主定理の系の側の裏取りとして、$`Z_1,\dots,Z_M,Y_1,\dots,Y_M`$ が反交換関係 $`XY+YX=2\delta I`$ を満たすことも確かめた。
  否定の対照: $`U'`$ の代わりに $`U`$ で挟むと $`Z_m`$ にならないこと、$`m`$ 番目の因子を $`-\sigma^y`$ にした行列とは一致しないこと（以上は確認の件数に含む、12 件）。
  以下は否定の対照の件数（90 件）に数えた：$`G_m`$ から $`E_{1,2}`$ の項を落とした積は $`c_m+c_m^{\mathsf T}`$（Y の側は $`X`$）と一致しないこと、$`KG_m`$ は $`\sigma^xK`$ と一致しないこと、
  $`\Phi_Y(\gamma_Y(e_m))\neq c_m-c_m^{\mathsf T}`$、$`\Phi_Y(\gamma_Y(e_{M+m}))\neq\mathrm{i}c_m-\mathrm{i}c_m^{\mathsf T}`$、$`\Omega(\gamma_Y(e_m))\neq Y_m`$、$`\Omega(\gamma_Y(e_{M+m}))\neq Z_m`$、
  $`\kappa_{U',U}`$ を落とした $`\Omega\circ\Psi_Y`$ と、$`U'`$ の代わりに $`U`$ で挟んだ合成は乱数の $`F`$ を戻さないこと、$`\Psi`$ の式で $`a_i`$ と $`a^{\dagger}_i`$ の像を取り違えると $`\gamma_Y(e_{M+1})`$ の像が戻らないこと。
  $`\kappa_{U,U'}`$ を二度当てる形は $`U\cdot U=2^M\cdot1`$・$`U'\cdot U'=2^{-M}\cdot1`$ のため恒等写像になり対照にならないので、使っていない。
- 実行: `micromamba run -n sage sage sagemath/check/jordan-wigner-matrices-from-general-even-dimensional-corollary/check_jordan_wigner_matrices_from_general_even_dimensional_corollary.sage`（SageMath 10.9、2026-11-14、約 14 秒）。
- 結果: 通過（確認 1030 件、否定の対照 90 件）。
- 位置づけ: クリフォード代数の中の等式（$`\Phi_Y(\gamma_Y(e_m))=c_m+c_m^{\mathsf T}`$、$`\Omega'\circ\Omega=\mathrm{id}`$ など）は、行列への像での確認であり、証明の代わりではない。
