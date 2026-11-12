# 番号を含まない部分集合の消滅の逆順の積に消滅作用素にあたる元を右から掛けた積の検算

- 対象ラベル: `claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index`
- 検算: [check_reverse_ordered_annihilation_product_times_annihilation_generator_without_index.sage](check_reverse_ordered_annihilation_product_times_annihilation_generator_without_index.sage)
- 方法: クリフォード代数の中の等式を、準同型 $`\Phi`$（$`\Phi(a^{\dagger}_i)=c_i`$、$`\Phi(a_i)=c_i^{\mathsf T}`$、$`\Phi(1)=I`$）による行列の像で確かめる。$`a^{\dagger}_S`$・$`a_T`$・$`P`$ の像は、因子の像を同じ順に掛けた行列の積とし、$`x_i`$ の像は $`c_i^{\mathsf T}c_i`$ とする。すべての $`T\in\mathcal{P}_M`$ と $`i`$ と $`m\in\{0,\dots,i-1\}`$ について、$`Q_m`$ の像で $`Q_mc_i^{\mathsf T}=\varsigma(N_{m+1}(T))\,c_i^{\mathsf T}Q_m`$（`claim_initial_annihilation_factors_pass_annihilation_generator_with_sign` の像）を確かめ、$`i\notin T`$ のとき主張の像 $`\Phi(a_T)c_i^{\mathsf T}=\varsigma(N_i(T))\,\Phi(a_{T\cup\{i\}})`$ を確かめる。否定コントロールとして、$`\varsigma(N_i(T))=-1`$ のときに符号を落とした等式が成り立たないことを確かめた。計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/reverse-ordered-annihilation-product-times-annihilation-generator-without-index/check_reverse_ordered_annihilation_product_times_annihilation_generator_without_index.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 行列への像での確認であり、クリフォード代数の中の等式の証明ではない。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
