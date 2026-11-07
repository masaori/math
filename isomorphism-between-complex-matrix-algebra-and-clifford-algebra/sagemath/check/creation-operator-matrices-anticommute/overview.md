# 生成作用素の行列どうしの反交換関係の検算

- 対象ラベル: `claim_creation_operator_matrices_anticommute`
- 検算: [check_creation_operator_matrices_anticommute.sage](check_creation_operator_matrices_anticommute.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_i`$ を `def_count_of_subset_elements_below_index`・`def_sign_of_nonnegative_integer`・
  `def_creation_operator_matrix` の式どおりに $`\mathbb{Z}`$ 上の行列として作る。$`M=1,2,3`$ のすべての $`k,l`$ と $`S,U`$ で、
  証明の準備の等式（$`\star`$）を確かめ、すべての $`i,j`$（$`i=j`$ を含む）と $`S,U`$ で、条件 $`\mathrm{C}_{i,j}(S,U)`$ と
  $`\mathrm{C}_{j,i}(S,U)`$ の同値、条件が成り立つときの $`j<i`$ と $`i<j`$ の鎖の各行（個数の値・符号の定義の行・
  結合法則から零までの行）、主張の式 $`c_ic_j+c_jc_i=0`$ を確かめる。整数の厳密計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/creation-operator-matrices-anticommute/check_creation_operator_matrices_anticommute.sage`（SageMath 10.9、2026-11-07）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
