# 行列環への準同型が消滅作用素にあたる元を消滅作用素の行列へ移すことの検算

- 対象ラベル: `claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix`
- 検算: [check_homomorphism_to_matrix_algebra_on_annihilation_generator.sage](check_homomorphism_to_matrix_algebra_on_annihilation_generator.sage)
- 方法: $`W:=\mathbb{Q}^M`$、基底 $`w`$ を標準基底、双対基底 $`f`$ を $`f_i(w_k)=\delta_{i,k}`$ とし、$`\mathrm{in}_2(f_i)=(0,f_i)`$ の値 $`\beta^w_k(0_W)=0`$ と $`f_i(w_k)`$ を $`\varphi`$ の式に入れて、二つの線型結合の和が $`c_i^{\mathsf T}`$ になることを確かめる。クリフォード代数の中の元 $`a_i`$ そのものは計算せず、$`\Phi(a_i)=\varphi(\mathrm{in}_2(f_i))`$ の右辺での確認である。整数の厳密計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/homomorphism-to-matrix-algebra-on-annihilation-generator/check_homomorphism_to_matrix_algebra_on_annihilation_generator.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
