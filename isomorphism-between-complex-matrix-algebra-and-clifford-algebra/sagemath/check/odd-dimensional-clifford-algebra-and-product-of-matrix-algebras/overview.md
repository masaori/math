# 系「奇数次元」：符号の因子・中心の元・行列環の直積との同型の検算

- 対象ラベル: `def_parity_factor_of_split_clifford_algebra`
- 対象ラベル: `claim_parity_factor_times_annihilation_generator`
- 対象ラベル: `claim_annihilation_generator_anticommutes_with_parity_factor`
- 対象ラベル: `claim_parity_factor_times_creation_generator`
- 対象ラベル: `claim_creation_generator_anticommutes_with_parity_factor`
- 対象ラベル: `claim_square_of_parity_factor_is_one`
- 対象ラベル: `claim_generators_commute_with_parity_factor_of_other_number`
- 対象ラベル: `claim_parity_factors_with_different_numbers_commute`
- 対象ラベル: `def_parity_element_of_split_clifford_algebra`
- 対象ラベル: `claim_square_of_parity_element_is_one`
- 対象ラベル: `claim_generators_anticommute_with_parity_element`
- 対象ラベル: `claim_image_of_split_space_anticommutes_with_parity_element`
- 対象ラベル: `claim_square_of_added_generator_is_one`
- 対象ラベル: `claim_added_generator_anticommutes_with_image_of_split_space`
- 対象ラベル: `claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity`
- 対象ラベル: `def_map_from_odd_extension_to_pair_of_matrices`
- 対象ラベル: `claim_square_of_map_from_odd_extension_to_pair_of_matrices`
- 対象ラベル: `claim_homomorphism_to_pair_of_matrices_on_added_generator`
- 対象ラベル: `claim_homomorphism_to_pair_of_matrices_on_central_element`
- 対象ラベル: `claim_square_of_central_element_is_one`
- 対象ラベル: `claim_homomorphism_to_pair_of_matrices_on_idempotents`
- 対象ラベル: `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself`
- 対象ラベル: `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero`
- 対象ラベル: `claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one`
- 対象ラベル: `claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element`
- 対象ラベル: `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity`
- 対象ラベル: `theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras`
- 検算: [check_odd_dimensional_clifford_algebra_and_product_of_matrix_algebras.sage](check_odd_dimensional_clifford_algebra_and_product_of_matrix_algebras.sage)
- 方法: $`M=1,2,3`$ で生成作用素の行列 $`c_i`$ と消滅作用素の行列 $`c_i^{\mathsf T}`$ を定義どおり（符号 $`(-1)^{N_i(T)}`$）に `QQ` で作り、
  $`\Phi(\chi_i)=c_i^{\mathsf T}c_i-c_ic_i^{\mathsf T}`$ と $`\Phi(\varepsilon)=\prod_i\Phi(\chi_i)`$（番号順の積）について、符号の因子の四つの積の式・平方・番号の違う生成元や因子との交換・$`\Phi(\varepsilon)^2=I`$・生成元との反交換を確かめた。
  有理数の乱数の係数 6 組で $`\Phi(\gamma((x,\xi)))`$ を作り、平方が $`q_W((x,\xi))I`$、$`\Phi(\varepsilon)`$ と反交換すること、一般の補題 $`(X+sY)^2=(\alpha+s^2)I`$、$`\varphi'(x)^2=q'(x)(I,I)`$ を確かめた。
  行列の組の側で $`\Phi'(g)=(\Phi(\varepsilon),-\Phi(\varepsilon))`$ の平方と反交換、$`\Phi'(z)=(I,-I)`$、$`\Phi'(e_{+})=(I,0)`$・$`\Phi'(e_{-})=(0,I)`$、冪等元の四つの関係の像、$`\Phi(\Psi(F))`$ を $`\sum F_{S,T}c_{S}\Phi(P)c^{\mathsf T}_{T}`$ で計算して $`\Phi'(\Psi'((F,G)))=(F,G)`$（乱数の行列 3 組）を確かめた。
  $`2M+1`$ 個の生成元の像の番号順の部分積 $`2^{2M+1}`$ 個の階数が $`2\cdot4^M`$（$`B\times B`$ の次元）であることも確かめた（$`\Phi'`$ が全射であることの像での裏取り）。
  参考として $`\Phi(\varepsilon)`$ が対角行列 $`\mathrm{diag}((-1)^{\#T})`$ であることも確かめた（本文はこの形を使わない）。
  否定の対照: 因子の符号を $`+`$ にした $`a_ia^{\dagger}_i+a^{\dagger}_ia_i`$ の積は単位行列になり反交換しないこと（$`M=1,2,3`$）、最後の因子を落とした積は $`M`$ 番の生成元と反交換しないこと（$`M=2,3`$）、$`\Phi'(g)`$ を $`(\Phi(\varepsilon),\Phi(\varepsilon))`$ にすると部分積の階数が $`4^M`$ に落ちること（$`M=1,2,3`$）。
- 対象外: 一つの次元を足した空間の線型代数の主張（ℂ の単位元の族が基底であること、$`q'`$ の偏極と二次形式であること、埋め込みが等長であること）、一般の ℂ-代数の補題（反交換する二元の積との交換、交換する元の部分代数、生成する部分集合）、二つの ℂ-代数の直積が ℂ-代数であること、$`\Psi'`$ が準同型であることは、行列の計算を含まない主張なので検算を置かない。
- 実行: `micromamba run -n sage sage sagemath/check/odd-dimensional-clifford-algebra-and-product-of-matrix-algebras/check_odd_dimensional_clifford_algebra_and_product_of_matrix_algebras.sage`（SageMath 10.9、2026-11-12、約 10 秒）。
- 結果: 通過（確認 192 件、否定の対照 8 件）。
- 位置づけ: クリフォード代数の中の主張を行列（の組）への像で確かめた裏取りであり、証明の代わりではない。
