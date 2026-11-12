# 生成の積と真空への射影にあたる元と消滅の逆順の積の、部分集合全体の上の和が 1 になることの検算

- 対象ラベル: `claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors`
- 対象ラベル: `claim_sum_over_subsets_of_selected_products_is_product_of_sums`
- 対象ラベル: `claim_decomposition_of_unity_in_split_clifford_algebra`
- 検算: [check_decomposition_of_unity_in_split_clifford_algebra.sage](check_decomposition_of_unity_in_split_clifford_algebra.sage)
- 方法: クリフォード代数の中の等式を、準同型 $`\Phi`$ による行列の像で確かめる。すべての $`S`$ と $`m`$ について $`(a^{\dagger}_{S,\le m}P_{\le m})a_{S,\le m}=\prod_{i\le m}u^S_i`$ の像と準備の二つの交換を確かめる。部分集合の 2 進の番号付け $`e_m`$ は、本文の定義（`def_binary_numbering_of_power_set`）の漸化式どおりの作り方と、それとは別に写像 $`S\mapsto1+\sum_{t\in S}2^{t-1}`$（$`\mathcal{P}_m\to\{1,\dots,2^m\}`$）の表を作って全単射であることを確かめ、その逆写像を表から作る作り方の二つで作り、$`m=0,\dots,M`$ で両者が一致することを確かめてから使う。そのうえで前半と後半の形（準備の二つ）を確かめ、$`g_i=c_ic_i^{\mathsf T}`$・$`h_i=c_i^{\mathsf T}c_i`$ で展開の主張を確かめ、主張の像 $`\sum_S(\Phi(a^{\dagger}_S)\Phi(P))\Phi(a_S)=I`$ を、部分集合全体を走る和と、番号付け $`e_M`$ の順に足した和の両方で確かめる。一般の ℂ-代数についての展開の主張は、交換しない 3 行 3 列の整数行列の族（乱数の種を固定）で確かめる。否定の対照として、$`P`$ を抜いた和が $`I`$ にならないこと、因子の順序を逆にした積の和が因子の和の積に一致しないこと（$`M\ge2`$）を確かめた。計算は整数行列の厳密計算（`ZZ`）である。
- 実行: `micromamba run -n sage sage sagemath/check/decomposition-of-unity-in-split-clifford-algebra/check_decomposition_of_unity_in_split_clifford_algebra.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立ち、二つの作り方の番号付けは $`m=0,\dots,3`$ のすべてで一致した。
- 位置づけ: 行列への像での確認と、特定の行列の族での確認であり、証明ではない。有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明でもない。
