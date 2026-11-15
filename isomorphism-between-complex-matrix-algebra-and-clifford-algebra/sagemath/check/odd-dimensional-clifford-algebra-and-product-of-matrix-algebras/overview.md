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
- 対象ラベル: `def_added_generator_of_odd_extension_clifford_algebra`
- 対象ラベル: `claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism`
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
- 対象ラベル: `claim_added_generator_commutes_with_image_of_parity_factor`
- 対象ラベル: `claim_added_generator_commutes_with_image_of_parity_element`
- 対象ラベル: `claim_central_element_commutes_with_image_of_split_space`
- 対象ラベル: `claim_central_element_commutes_with_added_generator`
- 対象ラベル: `claim_image_of_odd_extension_element_is_sum_of_images`
- 対象ラベル: `claim_central_element_commutes_with_every_element`
- 対象ラベル: `claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element`
- 検算: [check_odd_dimensional_clifford_algebra_and_product_of_matrix_algebras.sage](check_odd_dimensional_clifford_algebra_and_product_of_matrix_algebras.sage)
- 方法: $`M=1,2,3`$ で生成作用素の行列 $`c_i`$ と消滅作用素の行列 $`c_i^{\mathsf T}`$ を定義どおり（符号 $`(-1)^{N_i(T)}`$）に `QQ` で作り、
  $`\Phi(\chi_i)=c_i^{\mathsf T}c_i-c_ic_i^{\mathsf T}`$（$`\Phi`$ が準同型であることから）と $`\Phi(\varepsilon)=\prod_i\Phi(\chi_i)`$（番号順の積）について、符号の因子の四つの積の式・平方・番号の違う生成元や因子との交換・$`\Phi(\varepsilon)^2=I`$・生成元との反交換を確かめた。
  有理数の乱数の係数 6 組で $`\Phi(\gamma((x,\xi)))`$ を作り、平方が $`q_W((x,\xi))I`$、$`\Phi(\varepsilon)`$ と反交換すること、一般の補題 $`(X+sY)^2=(\alpha+s^2)I`$、$`\varphi'(x)^2=q'(x)(I,I)`$ を確かめた。
  $`\Phi'`$ は手で置かず、生成元の像から組み立てた：$`\Phi\circ\gamma`$ を基底 $`d`$ の座標で $`\sum y_kc_k+\sum y_{M+k}c_k^{\mathsf T}`$ とし、$`\varphi'((v,t))=(\Phi(\gamma(v))+t\Phi(\varepsilon),\ \Phi(\gamma(v))+(-t)\Phi(\varepsilon))`$ から
  $`\Phi'(\gamma'(\mathrm{in}'_1(d_k)))=\varphi'((d_k,0))`$ と $`\Phi'(g)=\varphi'((0_V,1))`$ を計算した。$`\Phi'(j(a))=(\Phi(a),\Phi(a))`$ と $`\Phi'(g)=(\Phi(\varepsilon),-\Phi(\varepsilon))`$ の式変形の各行（$`v`$ は基底の元と乱数の元 3 つ）を一行ずつ比べた。
  $`\Phi'(j(\varepsilon))`$ は $`\Phi'(j(\chi_i))=\Phi'(j(a_i))\Phi'(j(a^{\dagger}_i))-\Phi'(j(a^{\dagger}_i))\Phi'(j(a_i))`$ の番号順の積として生成元の像から作り、$`(\Phi(\varepsilon),\Phi(\varepsilon))`$ と比べた。
  $`\Phi'(z)=\Phi'(j(\varepsilon))\Phi'(g)`$ を計算し、中心の元の値の式変形の各行と $`(I,-I)`$ を比べた。$`\Phi'(e_{\pm})=h((I,I)\pm\Phi'(z))`$ を期待値 $`(I,0)`$・$`(0,I)`$ と比べ、冪等元の四つの関係の像を期待値（$`(I,0)`$、$`(0,0)`$、$`(I,I)`$、$`(I,-I)`$）と比べた。
  $`\Phi(\Psi(F))`$ を $`\sum F_{S,T}c_{S}\Phi(P)c^{\mathsf T}_{T}`$ で計算して $`\Phi'(\Psi'((F,G)))=(F,G)`$（乱数の行列 3 組）を確かめた。
  $`2M+1`$ 個の生成元の像の番号順の部分積 $`2^{2M+1}`$ 個の階数が $`2\cdot4^M`$（$`B\times B`$ の次元）であることも確かめた（$`\Phi'`$ が全射であることの像での裏取り）。
  z の中心性の主張の像を、生成元の像から組み立てた値で確かめた：$`\Phi'(g)`$ と $`\Phi'(j(\chi_i))`$・$`\Phi'(j(\varepsilon))`$ の交換、$`\Phi'(z)`$ と $`\Phi'(j(\gamma(v)))`$（$`v`$ は基底の元と乱数の元 3 つ）・$`\Phi'(g)`$ の交換、$`\gamma'((v,t))`$ の像 $`\varphi'((v,t))`$ が $`\Phi'(j(\gamma(v)))+t\Phi'(g)`$ に等しいこと（$`t`$ は 0、1、$`-3/2`$ と乱数）、$`\Phi'(z)`$ と $`\Phi'(e_{\pm})`$ が乱数の組 $`X\in B\times B`$（3 組）と交換すること。$`\Phi'`$ の像が $`B\times B`$ 全体であることは下の階数の確認による。
  参考として $`\Phi(\varepsilon)`$ が対角行列 $`\mathrm{diag}((-1)^{\#T})`$ であることも確かめた（本文はこの形を使わない）。
  否定の対照（各 $`M`$）: 因子の符号を $`+`$ にした積は単位行列になり反交換しないこと、最後の因子を落とした積は $`M`$ 番の生成元と反交換しないこと（$`M=2,3`$）、$`\Phi'(g)`$ を $`(\Phi(\varepsilon),\Phi(\varepsilon))`$ にすると部分積の階数が $`4^M`$ に落ちること、
  $`\varphi'`$ の第二成分で $`t`$ の符号を反転しない写像とは値が違うこと、$`\chi_i`$ の符号を $`+`$ にした $`\Phi'(j(\varepsilon))`$ や第二成分の符号を反転しない $`\Phi'(g)`$ からは $`\Phi'(z)=(I,-I)`$ にならないこと、
  $`\Phi'(g)`$ と $`\Phi'(j(\gamma(d_1)))`$ は乱数の組と交換せず、互いにも交換しないこと、$`\gamma'((v,t))`$ の像で $`g`$ の係数を $`-t`$ にすると一致しないこと、
  $`\sigma`$ の符号を入れ替えた $`e_{\mp}`$ は期待値と一致しないこと、$`h`$ を落とした $`1\pm z`$ の像は $`(I,0)`$ でも冪等でもなく、その和は $`(I,I)`$、差は $`(I,-I)`$ にならないこと。
- 対象外: 一つの次元を足した空間の線型代数の主張（ℂ の単位元の族が基底であること、$`q'`$ の偏極と二次形式であること、埋め込みが等長であること）、一般の ℂ-代数の補題（反交換する二元の積との交換、交換する元の部分代数、生成する部分集合）、$`j\circ\gamma=\gamma'\circ\mathrm{in}'_1`$（`claim_induced_homomorphism_into_odd_extension_after_generator_map`。$`j`$ を行列で独立に計算する手段が無く、検算は $`\Phi'(j(\gamma(d_k)))`$ をこの等式で $`\varphi'((d_k,0))`$ として使う）、二つの ℂ-代数の直積が ℂ-代数であること、$`\Psi'`$ が準同型であることは、行列の計算を含まない主張なので検算を置かない。記号を定めるだけの定義（`def_setting_of_odd_dimensional_corollary`、基底 $`d'`$ の `def_basis_of_odd_extension`、$`A'`$ の `def_clifford_algebra_of_odd_extension`、$`\gamma'`$ の `def_clifford_generator_map_of_odd_extension`、$`-_{\mathbb{C}}`$ の `def_additive_inverse_in_complex_numbers`、$`-1_{\mathbb{C}}`$ の `def_minus_one_in_complex_numbers`）も行列の計算を含まないので対象に入れない。
- 実行: `micromamba run -n sage sage sagemath/check/odd-dimensional-clifford-algebra-and-product-of-matrix-algebras/check_odd_dimensional_clifford_algebra_and_product_of_matrix_algebras.sage`（SageMath 10.9、2026-11-14、約 14 秒。z の中心性の像を足した 2026-11-15 に再実行）。
- 結果: 通過（2026-11-15 の再実行で確認 456 件、否定の対照 56 件）。
- 位置づけ: クリフォード代数の中の主張を行列（の組）への像で確かめた裏取りであり、証明の代わりではない。
