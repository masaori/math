# 系「Jordan–Wigner 行列への接続」の後半（番号の行列環への移し）の検算

- 対象ラベル: `def_reversal_of_subsets`
- 対象ラベル: `claim_membership_in_reversed_subset`
- 対象ラベル: `claim_reversal_of_subsets_is_involution`
- 対象ラベル: `def_numbering_of_power_set_with_first_site_as_highest_digit`
- 対象ラベル: `claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set`
- 対象ラベル: `def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit`
- 対象ラベル: `def_reindexing_of_matrices_by_inverse_of_numbering_with_first_site_as_highest_digit`
- 対象ラベル: `def_tuples_of_ones_and_twos`
- 対象ラベル: `def_tuple_of_membership_indices`
- 対象ラベル: `def_positions_of_two_in_tuple`
- 対象ラベル: `claim_tuple_of_membership_indices_of_positions_of_two_is_original`
- 対象ラベル: `def_ordered_sum_of_integers`
- 対象ラベル: `claim_ordered_sum_of_integers_splits_off_first_term`
- 対象ラベル: `claim_ordered_sum_of_integers_is_unchanged_by_shifting_index`
- 対象ラベル: `def_number_of_tuple_with_first_site_as_highest_digit`
- 対象ラベル: `claim_number_of_membership_tuple_of_reversed_subset_without_top_element`
- 対象ラベル: `claim_number_of_membership_tuple_of_reversed_subset_with_top_element`
- 対象ラベル: `claim_number_of_membership_tuple_after_numbering_with_first_site_as_highest_digit`
- 対象ラベル: `claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection`
- 対象ラベル: `def_kronecker_product_indexed_by_numbers`
- 対象ラベル: `claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit`
- 対象ラベル: `def_single_site_family_of_matrices`
- 対象ラベル: `def_initial_part_family_of_matrices`
- 対象ラベル: `claim_ordered_products_in_complex_numbers_with_equal_factors_are_equal`
- 対象ラベル: `claim_kronecker_products_of_factorwise_equal_families_are_equal`
- 対象ラベル: `claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal`
- 対象ラベル: `claim_ordered_product_of_single_site_kronecker_products`
- 対象ラベル: `def_site_pauli_matrices_indexed_by_numbers`
- 対象ラベル: `def_factors_of_jordan_wigner_matrices_indexed_by_numbers`
- 対象ラベル: `def_jordan_wigner_z_matrix_indexed_by_numbers`
- 対象ラベル: `def_jordan_wigner_y_matrix_indexed_by_numbers`
- 対象ラベル: `claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers`
- 対象ラベル: `claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers`
- 対象ラベル: `def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers`
- 対象ラベル: `def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers`
- 対象ラベル: `claim_homomorphism_to_matrices_indexed_by_numbers_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix`
- 対象ラベル: `claim_homomorphism_to_matrices_indexed_by_numbers_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix`
- 対象ラベル: `theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms`
- 検算: [check_jordan_wigner_matrices_indexed_by_numbers.sage](check_jordan_wigner_matrices_indexed_by_numbers.sage)（主張の両辺と全体の通し）、
  [check_rows_of_number_and_reindexing_proofs.sage](check_rows_of_number_and_reindexing_proofs.sage)（証明の途中の行を一行ずつ）
- 方法: $`M=1,2,3`$ で、本文の定義どおりに $`\varrho_M`$・$`r_M=\varrho_M\circ e_M`$・$`\bar{o}_M`$・$`\mathrm{pos}_M`$・$`\mathrm{num}_M`$ を作り、
  逆順の部分集合に入る番号の言い換え、$`\varrho_M\circ\varrho_M=\mathrm{id}`$、$`r_M`$ が全単射であること、$`\bar{o}_M(\mathrm{pos}_M(I))=I`$、
  番号 $`M`$ を含まない・足した部分集合の二つの主張（$`\mathcal{P}_{M-1}`$ のすべての $`S`$）、$`\mathrm{num}_M(\bar{o}_M(r_M(k)))=k`$（すべての $`k`$）、
  $`\mathrm{num}_M`$ が $`\{1,\dots,2^M\}`$ への全単射で $`\mathrm{num}_M(I)=r_M^{-1}(\mathrm{pos}_M(I))`$ であることを確かめた。
  番号で添字づけたクロネッカー積は、本文の定義（$`\mathrm{num}_M`$ の逆で組を引く）と、複素行列版イジングの論文の `def_kronecker` と同じ並び（第 1 因子が最上位の桁）の
  Sage の `tensor_product` の二通りで作って一致を確かめ、乱数の因子（`QQbar` の Gauss 整数）で $`\nu_{r_M}(\boxtimes A)=\widehat{\boxtimes}A`$ を確かめた。
  一つの因子だけを残したクロネッカー積の番号順の積が $`\boxtimes f^{[\le p]}`$ であることを、すべての $`p`$ と乱数の族で確かめた。
  サイトごとの Pauli 行列と $`Z^{(2^M)}_m`$・$`Y^{(2^M)}_m`$ は `tensor_product` と行列の積で独立に作り（あちらの論文の定義の形）、本文の定義の形（$`\widehat{\boxtimes}`$）と一致すること、
  証明の途中の行（$`\nu_{r_M}(\vartheta_j)=F^{(b)}_{m,j}`$、$`\prod \vartheta_j=Z_m`$・$`Y_m`$）と $`\nu_{r_M}(Z_m)=Z^{(2^M)}_m`$・$`\nu_{r_M}(Y_m)=Y^{(2^M)}_m`$ を確かめた。
  系の側は、生成作用素の行列 $`c_m`$ から $`\nu_{r_M}(\kappa_{U,U'}(c_m+c_m^{\mathsf T}))=Z^{(2^M)}_m`$ と $`\nu_{r_M}(\kappa_{U,U'}((-\mathrm{i})c_m+\mathrm{i}c_m^{\mathsf T}))=Y^{(2^M)}_m`$ を通しで確かめ
  （$`\Omega(\gamma_Y(e_m))=\kappa_{U,U'}(c_m+c_m^{\mathsf T})`$ などは前半の検算 `jordan-wigner-matrices-from-general-even-dimensional-corollary` が確かめている）、
  $`\nu_{r_M}`$ と $`\mu_{r_M}`$ が互いに逆で $`\nu_{r_M}`$ が積を保つことを乱数の行列で確かめた。
  否定の対照（41 件）: 2 進の番号付け $`e_M`$ では $`\mathrm{num}_M\circ\bar{o}_M\circ e_M`$ が恒等写像にならないこと、$`\nu_{e_M}`$ では番号で添字づけたクロネッカー積・あちらの論文の
  Jordan–Wigner 行列にならないこと（$`M\ge2`$）、番号順の積は番号 $`p+1`$ の因子を含まないこと、$`Z`$ の側が $`\sigma^x_m`$ と、$`Y`$ の側が $`-Y^{(2^M)}_m`$ と一致しないこと。
- 方法（一行ずつの検算 `check_rows_of_number_and_reindexing_proofs.sage`）: 各行の値をその行の式の形どおりに別々に計算し、隣り合う行を比べた。
  整数の番号順の和は本文の定義どおり最後の項で帰納的に計算し（`ZZ`）、最初の項を分ける主張と番号をずらす主張の証明の基底・帰納の各行を乱数の族（各 60 通り）で確かめた。
  番号 $`M`$ を含まない・足した部分集合の組の番号の二つの主張は、$`M=1,2,3`$ のすべての $`S\in\mathcal{P}_{M-1}`$ で式変形の全行と準備の（一）（二）（$`o_{M,T}`$ と $`o_{M-1,T'}`$）を確かめた。
  因子ごとに等しい族の三つの主張は、因子を成分から直接作る経路と Pauli 行列の線型結合で作る経路の二通りで作り、$`\mathbb{C}`$ の部分積 $`P_m`$ のすべて、$`\boxtimes`$、$`\widehat{\boxtimes}`$ の証明の各行を確かめた。
  Z・Y の付け替えの主張は、（一）の各 $`j`$ の場合で $`\nu_{r_M}(\vartheta_j)`$（$`\mathrm{Mat}_{\mathcal{P}_M}`$ で作って付け替え）$`=\widehat{\boxtimes}\mathfrak{z}^{[j]}=\widehat{\boxtimes}(\sigma^a,I_2\text{ の族})=\sigma^a_j`$（Sage の `tensor_product`）$`=F_{m,j}`$、
  （二）、主の式変形の $`\nu_{r_M}(Z_m)`$ から $`\nu_{r_M}(\prod_B\vartheta_j)`$（$`\mathrm{Mat}_{\mathcal{P}_M}`$ で掛けてから付け替え）、$`\prod_{\widehat B}\nu_{r_M}(\vartheta_j)`$（付け替えてから $`\widehat B`$ で掛ける）、$`\prod F_{m,j}`$、
  一回の `tensor_product` で作った $`Z^{(2^M)}_m`$ までの 7 行を確かめた（$`Y`$ の側は $`\mathfrak{y}`$・$`\varpi_j`$ で同じ）。
  否定の対照（149 件）: 最初の項を落とした和・番号をずらさずに足した和・指数を付け替えない和は一致しないこと、番号 $`M`$ を足すと番号が $`2^{M-1}`$ ずれること、
  因子を一つ変えたクロネッカー積は一致しないこと、2 進の番号付け $`e_M`$ では中央以外のサイトで（一）の最初の行が成り立たないこと、$`j=m`$ の因子を除いた積は一致しないこと。
- 実行: `micromamba run -n sage sage sagemath/check/jordan-wigner-matrices-indexed-by-numbers/check_jordan_wigner_matrices_indexed_by_numbers.sage`（SageMath 10.9、2026-11-15、約 11 秒）と
  `micromamba run -n sage sage sagemath/check/jordan-wigner-matrices-indexed-by-numbers/check_rows_of_number_and_reindexing_proofs.sage`（2026-11-15、約 13 秒）。
- 結果: 通過（前者は確認 603 件・否定の対照 41 件、後者は確認 1175 件・否定の対照 149 件）。
- 位置づけ: 有限個の $`M`$ と有限個の行列での裏取りであり、証明ではない。
