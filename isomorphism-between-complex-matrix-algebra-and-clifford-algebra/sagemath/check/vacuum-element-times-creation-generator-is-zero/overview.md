# 真空への射影にあたる元に生成作用素にあたる元を右から掛けると零になることの検算

- 対象ラベル: `claim_vacuum_element_times_creation_generator_is_zero`
- 検算: [check_vacuum_element_times_creation_generator_is_zero.sage](check_vacuum_element_times_creation_generator_is_zero.sage)
- 方法: クリフォード代数の中の等式を、準同型 $`\Phi`$（$`\Phi(a^{\dagger}_i)=c_i`$、$`\Phi(a_i)=c_i^{\mathsf T}`$、$`\Phi(1)=I`$）による行列の像で確かめる。$`a^{\dagger}_S`$・$`a_T`$・$`P`$ の像は、因子の像を同じ順に掛けた行列の積とし、$`x_i`$ の像は $`c_i^{\mathsf T}c_i`$ とする。各 $`i`$ について、番号の違う $`x_j`$ との交換 $`c_ix_j=x_jc_i`$（`claim_creation_generator_commutes_with_other_number_pair` の像）、分解 $`\Phi(P)=L(x_iR)`$、準備の $`c_iR=Rc_i`$、$`x_ic_i=0`$ と、主張の像 $`\Phi(P)c_i=0`$ を確かめる。否定コントロールとして、$`\Phi(P)c_i^{\mathsf T}\neq0`$ を確かめた。計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/vacuum-element-times-creation-generator-is-zero/check_vacuum_element_times_creation_generator_is_zero.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 行列への像での確認であり、クリフォード代数の中の等式の証明ではない。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
