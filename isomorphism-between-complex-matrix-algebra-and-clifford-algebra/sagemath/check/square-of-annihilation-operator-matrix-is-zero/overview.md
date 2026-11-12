# 消滅作用素の行列の自分自身との積が零行列であることの検算

- 対象ラベル: `claim_square_of_annihilation_operator_matrix_is_zero`
- 検算: [check_square_of_annihilation_operator_matrix_is_zero.sage](check_square_of_annihilation_operator_matrix_is_zero.sage)
- 方法: $`c_i^{\mathsf T}`$ を $`(c_i^{\mathsf T})_{S,T}:=(c_i)_{T,S}`$ で作り、すべての $`i`$・$`S`$・$`U`$ で、和の項の書き直し（$`\sum_T(c_i^{\mathsf T})_{S,T}(c_i^{\mathsf T})_{T,U}=\sum_T(c_i)_{U,T}(c_i)_{T,S}`$）、$`(c_i^{\mathsf T}c_i^{\mathsf T})_{S,U}=(c_ic_i)_{U,S}`$、主張 $`c_i^{\mathsf T}c_i^{\mathsf T}=0`$ を確かめる。否定の対照として、$`c_i^{\mathsf T}`$ 自身が零行列でないこと（非零成分が $`2^{M-1}`$ 個）、$`c_i^{\mathsf T}c_i`$・$`c_ic_i^{\mathsf T}`$・$`(c_i^{\mathsf T}+c_i)^2`$・$`(c_i^{\mathsf T}c_i)^2`$ が零行列でないこと、$`j\ne i`$ の $`c_i^{\mathsf T}c_j^{\mathsf T}`$ が零行列でないこと（$`M\ge2`$）を確かめ、主張が自明に通っていないことを見る。整数の厳密計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/square-of-annihilation-operator-matrix-is-zero/check_square_of_annihilation_operator_matrix_is_zero.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべての $`i`$（6 件）で全項目と否定の対照が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
