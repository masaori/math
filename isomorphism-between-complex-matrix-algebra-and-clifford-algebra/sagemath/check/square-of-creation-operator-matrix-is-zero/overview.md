# 生成作用素の行列の自分自身との積が零行列であることの検算

- 対象ラベル: `claim_square_of_creation_operator_matrix_is_zero`
- 検算: [check_square_of_creation_operator_matrix_is_zero.sage](check_square_of_creation_operator_matrix_is_zero.sage)
- 方法: $`N_i(T)`$・$`\varsigma(n)`$・$`c_i`$ を定義の式どおりに $`\mathbb{Z}`$ 上の行列として作り、すべての $`i`$・$`S`$・$`U`$ で、$`i\in U`$ なら成分が 0、$`i\notin U`$ なら $`(c_i)_{S,U\cup\{i\}}=0`$ と成分の式 $`(c_i)_{S,U\cup\{i\}}\cdot\varsigma(N_i(U))`$、主張 $`c_ic_i=0`$ を確かめる。否定の対照として、$`c_i`$ 自身が零行列でないこと（非零成分が $`2^{M-1}`$ 個）、$`c_ic_i^{\mathsf T}`$・$`c_i^{\mathsf T}c_i`$・$`(c_i+c_i^{\mathsf T})^2`$・$`(c_ic_i^{\mathsf T})^2`$ が零行列でないこと、$`j\ne i`$ の $`c_ic_j`$ が零行列でないこと（$`M\ge2`$）を確かめ、主張が自明に通っていないことを見る。整数の厳密計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/square-of-creation-operator-matrix-is-zero/check_square_of_creation_operator_matrix_is_zero.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべての $`i`$（6 件）で全項目と否定の対照が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
