# 行列環への準同型が生成作用素にあたる元を生成作用素の行列へ移すことの検算

- 対象ラベル: `claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix`
- 検算: [check_homomorphism_to_matrix_algebra_on_creation_generator.sage](check_homomorphism_to_matrix_algebra_on_creation_generator.sage)
- 方法: $`W:=\mathbb{Q}^M`$、基底 $`w`$ を標準基底とし、$`\mathrm{in}_1(w_i)=(w_i,0)`$ の座標 $`\beta^w_k(w_i)=\delta_{k,i}`$ と $`0_{W^*}(w_k)=0`$ を $`\varphi`$ の式に入れて、二つの線型結合の和が $`c_i`$ になることを確かめる。クリフォード代数の中の元 $`a^{\dagger}_i`$ そのものは計算せず、$`\Phi(a^{\dagger}_i)=\varphi(\mathrm{in}_1(w_i))`$ の右辺での確認である。整数の厳密計算で、浮動小数点は使わない。
- 実行: `micromamba run -n sage sage sagemath/check/homomorphism-to-matrix-algebra-on-creation-generator/check_homomorphism_to_matrix_algebra_on_creation_generator.sage`（SageMath 10.9、2026-11-12）。
- 結果: 通過。$`M=1,2,3`$ のすべてで全項目が成り立った。
- 位置づけ: 有限個の $`M`$ での裏取りであり、すべての $`M`$ についての証明ではない。
