# 番号を含まない部分集合の生成の積に生成作用素にあたる元を左から掛けた積の検算

- 対象ラベル: `claim_creation_generator_times_ordered_creation_product_without_index`
- 検算: [check_creation_generator_times_ordered_creation_product_without_index.sage](check_creation_generator_times_ordered_creation_product_without_index.sage)
- 方法: クリフォード代数の中の等式を、準同型 $`\Phi`$（$`\Phi(a^{\dagger}_i)=c_i`$、$`\Phi(a_i)=c_i^{\mathsf T}`$、$`\Phi(1)=I`$）による行列の像で確かめる。$`a^{\dagger}_S`$・$`a_T`$・$`P`$ の像は、因子の像を同じ順に掛けた行列の積とし、$`x_i`$ の像は $`c_i^{\mathsf T}c_i`$ とする。すべての $`T\in\mathcal{P}_M`$ と $`i`$ と $`m\in\{0,\dots,i-1\}`$ について、部分積 $`\Pi_m`$ の像で $`c_i\Pi_m=\varsigma(N_{m+1}(T))\,\Pi_mc_i`$（`claim_creation_generator_passes_initial_creation_factors_with_sign` の像）を確かめ、$`i\notin T`$ のとき主張の像 $`c_i\Phi(a^{\dagger}_T)=\varsigma(N_i(T))\,\Phi(a^{\dagger}_{T\cup\{i\}})`$ を確かめる。否定コントロールとして、$`\varsigma(N_i(T))=-1`$ のときに符号を落とした等式が成り立たないことを確かめた。計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/creation-generator-times-ordered-creation-product-without-index/check_creation_generator_times_ordered_creation_product_without_index.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 行列への像での確認であり、クリフォード代数の中の等式の証明ではない。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
