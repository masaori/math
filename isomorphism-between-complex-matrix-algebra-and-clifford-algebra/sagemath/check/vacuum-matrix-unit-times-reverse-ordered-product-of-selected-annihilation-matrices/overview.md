# 空集合の位置の行列単位に、部分集合の元の番号の消滅作用素の行列を番号の逆順に右から掛けると、その部分集合の列の行列単位になることの検算

- 対象ラベル: `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices`
- 検算: [check_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices.sage](check_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_t`$・$`c_t^{\mathsf T}`$・$`\delta`$・$`E_{x,y}`$ を `def_count_of_subset_elements_below_index`・`def_sign_of_nonnegative_integer`・
  `def_creation_operator_matrix`・`def_annihilation_operator_matrix`・`def_kronecker_delta`・`def_matrix_unit` の式どおりに $`\mathbb{Z}`$ 上の行列として作り、
  $`z_t:=c_t^{\mathsf T}`$（$`t\in T`$）、$`1`$（$`t\notin T`$）、$`w_k:=z_{M+1-k}`$、$`\Pi_0:=1`$、$`\Pi_m:=\Pi_{m-1}w_m`$（`def_ordered_product_in_algebra`）とする。
  $`M=1,2,3`$ のすべての $`s`$ と、すべての元が $`s+1`$ 以上の $`R`$ について、準備（$`\star`$）$`E_{\emptyset,R}c_s^{\mathsf T}=E_{\emptyset,R\cup\{s\}}`$、
  中間の式（$`\dagger`$）$`(E_{\emptyset,R}c_s^{\mathsf T})_{X,U}=\delta_{\emptyset,X}(c_s)_{U,R}`$、二つの場合の値（$`U=R\cup\{s\}`$ で $`\varsigma(N_s(R))=1`$、それ以外で 0）、$`N_s(R)=0`$ を確かめる。
  すべての $`T`$ で、集合の等式 $`T^{\langle 0\rangle}=\emptyset`$・$`T^{\langle m-1\rangle}\cup\{s\}=T^{\langle m\rangle}`$（$`s\in T`$）・$`T^{\langle m-1\rangle}=T^{\langle m\rangle}`$（$`s\notin T`$）・
  $`T^{\langle M\rangle}=T`$、帰納法の命題 $`E_{\emptyset,\emptyset}\Pi_m=E_{\emptyset,T^{\langle m\rangle}}`$、主張 $`E_{\emptyset,\emptyset}\Pi_M=E_{\emptyset,T}`$ を確かめる。
  整数の厳密計算で、浮動小数点は使わない。
- 否定コントロール: $`z_t`$ を $`t=1,\dots,M`$ の番号順に掛けた積は、$`T`$ の元が 2 個か 3 個なら符号が反転して $`E_{\emptyset,T}`$ にならないことを、$`M=2,3`$ の 5 件で確かめた。
- 実行: `micromamba run -n sage sage sagemath/check/vacuum-matrix-unit-times-reverse-ordered-product-of-selected-annihilation-matrices/check_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices.sage`（SageMath 10.9、2026-11-07）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
