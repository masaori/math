# 右から生成作用素の行列を掛けた行列の成分の検算

- 対象ラベル: `claim_entry_of_matrix_times_creation_operator_matrix`
- 検算: [check_entry_of_matrix_times_creation_operator_matrix.sage](check_entry_of_matrix_times_creation_operator_matrix.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_j`$ を `def_count_of_subset_elements_below_index`・`def_sign_of_nonnegative_integer`・
  `def_creation_operator_matrix` の式どおりに作り、成分がすべて不定元の行列 $`A`$（$`\mathbb{Q}`$ 上の多項式環の元）に右から $`c_j`$ を掛ける。
  $`M=1,2,3`$ のすべての $`j,S,U`$ で、$`j\in U`$ の場合の準備の等式（各項が零）と成分が $`0`$ であること、
  $`j\notin U`$ の場合の二つの準備の等式（$`(c_j)_{T,U}=\delta_{R,T}\varsigma(N_j(U))`$ と項の書き直し）、デルタによる一項の取り出し、
  主張の式を確かめる。成分が不定元なので、$`A`$ の成分の値によらない多項式の等式として確かめている。浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/entry-of-matrix-times-creation-operator-matrix/check_entry_of_matrix_times_creation_operator_matrix.sage`（SageMath 10.9、2026-11-07）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
