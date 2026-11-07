# 左から生成作用素の行列を掛けた行列の成分の検算

- 対象ラベル: `claim_entry_of_creation_operator_matrix_times_matrix`
- 検算: [check_entry_of_creation_operator_matrix_times_matrix.sage](check_entry_of_creation_operator_matrix_times_matrix.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_i`$ を `def_count_of_subset_elements_below_index`・`def_sign_of_nonnegative_integer`・
  `def_creation_operator_matrix` の式どおりに作り、成分がすべて不定元の行列 $`A`$（$`\mathbb{Q}`$ 上の多項式環の元）に左から $`c_i`$ を掛ける。
  $`M=1,2,3`$ のすべての $`i,S,U`$ で、$`i\notin S`$ の場合の準備の等式（条件が成り立たず各項が零）と成分が $`0`$ であること、
  $`i\in S`$ の場合の $`S'\in\mathcal{P}_M`$、条件と $`T=S'`$ の同値、$`(c_i)_{S,T}=\delta_{S',T}\varsigma(N_i(S'))`$、項の書き直し、
  デルタによる一項の取り出し、主張の式を確かめる。成分が不定元なので、$`A`$ の成分の値によらない多項式の等式として確かめている。浮動小数点は使わない。
- 否定コントロール: 符号 $`\varsigma(N_i(S'))`$ を落とした式 $`A_{S',U}`$ が、符号が $`-1`$ になる 36 組で成分と一致しないことを確かめた。
- 実行: `micromamba run -n sage sage sagemath/check/entry-of-creation-operator-matrix-times-matrix/check_entry_of_creation_operator_matrix_times_matrix.sage`（SageMath 10.9、2026-11-07）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
