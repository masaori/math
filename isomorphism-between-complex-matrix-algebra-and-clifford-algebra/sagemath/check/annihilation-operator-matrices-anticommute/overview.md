# 消滅作用素の行列どうしの反交換関係の検算

- 対象ラベル: `claim_annihilation_operator_matrices_anticommute`
- 検算: [check_annihilation_operator_matrices_anticommute.sage](check_annihilation_operator_matrices_anticommute.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_i`$ を `def_count_of_subset_elements_below_index`・`def_sign_of_nonnegative_integer`・
  `def_creation_operator_matrix` の式どおりに $`\mathbb{Z}`$ 上の行列として作り、$`c_i^{\mathsf T}`$ は
  `def_annihilation_operator_matrix` の成分の式 $`(c_i^{\mathsf T})_{S,T}:=(c_i)_{T,S}`$ で作る（転置の組み込み関数は使わない）。
  $`M=1,2,3`$ のすべての $`k,l,S,U,T`$ で準備の項の書き直しの各行と等式（$`\star`$）を、すべての $`i,j`$（$`i=j`$ を含む）と
  $`S,U`$ で本題の鎖の各行と主張の式 $`c_i^{\mathsf T}c_j^{\mathsf T}+c_j^{\mathsf T}c_i^{\mathsf T}=0`$ を確かめる。
  否定コントロールとして、$`M=1`$ の $`c_1c_1^{\mathsf T}+c_1^{\mathsf T}c_1`$ が零行列でないことを確かめる。整数の厳密計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/annihilation-operator-matrices-anticommute/check_annihilation_operator_matrices_anticommute.sage`（SageMath 10.9、2026-11-07）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
