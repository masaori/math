# 消滅作用素の行列と生成作用素の行列の積を番号順に掛けると、空集合の位置の行列単位になることの検算

- 対象ラベル: `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit`
- 検算: [check_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit.sage](check_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_i`$・$`c_i^{\mathsf T}`$・$`\delta`$・$`E_{\emptyset,\emptyset}`$ を `def_count_of_subset_elements_below_index`・`def_sign_of_nonnegative_integer`・
  `def_creation_operator_matrix`・`def_annihilation_operator_matrix`・`def_kronecker_delta`・`def_matrix_unit` の式どおりに $`\mathbb{Z}`$ 上の行列として作り、
  $`x_i:=c_i^{\mathsf T}c_i`$、$`\Pi_0:=1`$、$`\Pi_m:=\Pi_{m-1}x_m`$（`def_ordered_product_in_algebra`）とする。
  $`M=1,2,3`$ のすべての $`i,m,S,T,U`$ で、準備の一つ目（$`\star_1`$）と $`i\notin U`$ での条件と $`T=U`$ の同値、$`c_i^{\mathsf T}`$ の成分の付け替え、
  準備の二つ目の $`\mathrm{C}_m`$ の同値と（$`\star_2`$）、帰納法の各段の項の等式とデルタが一項を取り出す等式と $`(\Pi_m)_{S,U}=\chi_m(S,U)`$、
  本題の後半の $`\mathrm{C}_M(S,U)`$ と「$`S=U=\emptyset`$」の同値、主張 $`\Pi_M=E_{\emptyset,\emptyset}`$ を確かめる。整数の厳密計算で、浮動小数点は使わない。
- 否定コントロール: 因子の順を入れ替えた $`c_ic_i^{\mathsf T}`$ の番号順の積が $`E_{\emptyset,\emptyset}`$ にならないことを、$`M=1,2,3`$ の 3 件で確かめた。
- 実行: `micromamba run -n sage sage sagemath/check/ordered-product-of-annihilation-times-creation-matrices-is-vacuum-matrix-unit/check_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit.sage`（SageMath 10.9、2026-11-07）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
