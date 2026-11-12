# 番号を含む部分集合の生成の積に生成作用素にあたる元を左から掛けると零になることの検算

- 対象ラベル: `claim_creation_generator_times_ordered_creation_product_with_index_is_zero`
- 検算: [check_creation_generator_times_ordered_creation_product_with_index_is_zero.sage](check_creation_generator_times_ordered_creation_product_with_index_is_zero.sage)
- 方法: クリフォード代数の中の等式を、準同型 $`\Phi`$（$`\Phi(a^{\dagger}_i)=c_i`$、$`\Phi(a_i)=c_i^{\mathsf T}`$、$`\Phi(1)=I`$）による行列の像で確かめる。$`a^{\dagger}_S`$・$`a_T`$・$`P`$ の像は、因子の像を同じ順に掛けた行列の積とし、$`x_i`$ の像は $`c_i^{\mathsf T}c_i`$ とする。すべての $`T\in\mathcal{P}_M`$ と $`i\in T`$ について、$`\Phi(a^{\dagger}_T)\neq0`$ と主張の像 $`c_i\Phi(a^{\dagger}_T)=0`$ を確かめる。否定コントロールとして、$`c_i\Phi(a^{\dagger}_{T\setminus\{i\}})\neq0`$ を確かめた。計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/creation-generator-times-ordered-creation-product-with-index-is-zero/check_creation_generator_times_ordered_creation_product_with_index_is_zero.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 行列への像での確認であり、クリフォード代数の中の等式の証明ではない。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
