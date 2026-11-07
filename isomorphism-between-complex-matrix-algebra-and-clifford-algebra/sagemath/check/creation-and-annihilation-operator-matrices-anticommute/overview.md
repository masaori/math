# 生成作用素の行列と消滅作用素の行列の反交換関係の検算

- 対象ラベル: `claim_creation_and_annihilation_operator_matrices_anticommute`
- 検算: [check_creation_and_annihilation_operator_matrices_anticommute.sage](check_creation_and_annihilation_operator_matrices_anticommute.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_i`$・$`c_i^{\mathsf T}`$・$`\delta`$ を `def_count_of_subset_elements_below_index`・`def_sign_of_nonnegative_integer`・
  `def_creation_operator_matrix`・`def_annihilation_operator_matrix`・`def_kronecker_delta` の式どおりに $`\mathbb{Z}`$ 上の行列として作る。
  $`M=1,2,3`$ のすべての $`i,j`$（$`i=j`$ を含む）と $`S,U`$ で、$`S'`$ について $`i\notin S'`$ と（$`\sharp`$）、右辺の成分（$`\flat`$）、
  準備の等式（$`\star_1`$）（$`\star_2`$）、$`i=j`$ での $`\mathrm{D}_1`$・$`\mathrm{D}_2`$ の言い換えと符号の自分自身との積、
  $`i\neq j`$ での $`\mathrm{D}_1`$・$`\mathrm{D}_2`$ と $`\mathrm{D}`$ の同値、$`\mathrm{D}`$ のもとでの $`S=S'\cup\{i\}`$・$`U=S'\cup\{j\}`$、
  $`j<i`$ と $`i<j`$ の鎖の各行（個数の値・符号の定義の行・分配法則から零までの行）、主張の式を確かめる。整数の厳密計算で、浮動小数点は使わない。
- 否定コントロール: 符号の打ち消しを落とした式 $`\alpha\beta+\alpha\beta`$ が、$`\mathrm{D}`$ が成り立つ 14 組のすべてで $`0`$ にならないことを確かめた。
- 実行: `micromamba run -n sage sage sagemath/check/creation-and-annihilation-operator-matrices-anticommute/check_creation_and_annihilation_operator_matrices_anticommute.sage`（SageMath 10.9、2026-11-07）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
