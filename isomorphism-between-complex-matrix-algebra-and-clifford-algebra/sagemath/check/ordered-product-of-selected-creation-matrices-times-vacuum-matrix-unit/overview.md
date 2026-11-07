# 部分集合の元の番号の生成作用素の行列を番号順に掛けた積を、空集合の位置の行列単位に左から掛けると、その部分集合の行の行列単位になることの検算

- 対象ラベル: `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit`
- 検算: [check_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit.sage](check_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_t`$・$`\delta`$・$`E_{x,y}`$ を `def_count_of_subset_elements_below_index`・`def_sign_of_nonnegative_integer`・
  `def_creation_operator_matrix`・`def_kronecker_delta`・`def_matrix_unit` の式どおりに $`\mathbb{Z}`$ 上の行列として作り、
  $`y_t:=c_t`$（$`t\in S`$）、$`1`$（$`t\notin S`$）、$`\Pi_0:=1`$、$`\Pi_m:=\Pi_{m-1}y_m`$（`def_ordered_product_in_algebra`）とする。
  $`M=1,2,3`$ のすべての $`m`$ と、すべての元が $`m+1`$ 以上の $`R`$ について、準備（$`\star`$）$`c_mE_{R,\emptyset}=E_{R\cup\{m\},\emptyset}`$ と、
  その三つの場合の中間の値（$`m\notin X`$ で 0、$`m\in X`$ で $`\varsigma(N_m(X'))\cdot(E_{R,\emptyset})_{X',U}`$、$`X'=R`$ と $`X=R\cup\{m\}`$ の同値、$`N_m(R)=0`$）を確かめる。
  すべての $`S`$ で、集合の等式 $`R^{\langle 0\rangle}=R`$・$`(R\cup\{m\})^{\langle m-1\rangle}=R^{\langle m\rangle}`$（$`m\in S`$）・$`R^{\langle m-1\rangle}=R^{\langle m\rangle}`$（$`m\notin S`$）・
  $`\emptyset^{\langle M\rangle}=S`$、帰納法の命題 $`\Pi_mE_{R,\emptyset}=E_{R^{\langle m\rangle},\emptyset}`$、主張 $`\Pi_ME_{\emptyset,\emptyset}=E_{S,\emptyset}`$ を確かめる。
  整数の厳密計算で、浮動小数点は使わない。
- 否定コントロール: $`y_t`$ を $`t=M,\dots,1`$ の逆順に掛けた積は、$`S`$ の元が 2 個か 3 個なら符号が反転して $`E_{S,\emptyset}`$ にならないことを、$`M=2,3`$ の 5 件で確かめた。
- 実行: `micromamba run -n sage sage sagemath/check/ordered-product-of-selected-creation-matrices-times-vacuum-matrix-unit/check_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit.sage`（SageMath 10.9、2026-11-07）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
