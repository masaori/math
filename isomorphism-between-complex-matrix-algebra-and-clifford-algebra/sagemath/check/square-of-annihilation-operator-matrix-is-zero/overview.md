# 消滅作用素の行列の自分自身との積が零行列であることの検算

- 対象ラベル: `claim_square_of_annihilation_operator_matrix_is_zero`
- 検算: [check_square_of_annihilation_operator_matrix_is_zero.sage](check_square_of_annihilation_operator_matrix_is_zero.sage)
- 方法: $`c_i^{\mathsf T}`$ を $`(c_i^{\mathsf T})_{S,T}:=(c_i)_{T,S}`$ で作り、すべての $`i`$・$`S`$・$`U`$ で、和の項の書き直し（$`\sum_T(c_i^{\mathsf T})_{S,T}(c_i^{\mathsf T})_{T,U}=\sum_T(c_i)_{U,T}(c_i)_{T,S}`$）、$`(c_i^{\mathsf T}c_i^{\mathsf T})_{S,U}=(c_ic_i)_{U,S}`$、主張 $`c_i^{\mathsf T}c_i^{\mathsf T}=0`$ を確かめる。整数の厳密計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/square-of-annihilation-operator-matrix-is-zero/check_square_of_annihilation_operator_matrix_is_zero.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
