# 一般の偶数次元の非退化な二次空間から分裂した二次空間への等長写像と、誘導される同型の検算

- 対象ラベル: `claim_existence_of_square_root_in_complex_numbers`
- 対象ラベル: `claim_nonzero_scalar_multiples_of_basis_members_form_basis`
- 対象ラベル: `claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form`
- 対象ラベル: `claim_quadratic_form_of_linear_combination_of_orthogonal_family`
- 対象ラベル: `claim_rearranging_sum_of_two_sums_in_vector_space`
- 対象ラベル: `def_map_by_coordinates_and_family`
- 対象ラベル: `claim_map_by_coordinates_and_family_is_linear_map`
- 対象ラベル: `claim_map_by_coordinates_and_family_sends_basis_member_to_family_member`
- 対象ラベル: `claim_linear_map_fixing_basis_members_is_identity`
- 対象ラベル: `claim_linear_right_inverse_of_isometry_is_isometry`
- 対象ラベル: `claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry`
- 対象ラベル: `def_homomorphism_of_clifford_algebras_induced_by_isometry`
- 対象ラベル: `claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity`
- 対象ラベル: `def_setting_of_general_even_dimensional_corollary`
- 対象ラベル: `claim_negative_imaginary_unit_times_imaginary_unit_is_one`
- 対象ラベル: `def_family_in_split_space_for_isometry`
- 対象ラベル: `claim_quadratic_form_on_family_in_split_space_is_one`
- 対象ラベル: `claim_family_in_split_space_is_orthogonal`
- 対象ラベル: `def_map_to_split_quadratic_space`
- 対象ラベル: `claim_map_to_split_quadratic_space_is_isometry`
- 対象ラベル: `def_family_in_general_space_for_inverse_isometry`
- 対象ラベル: `def_map_from_split_quadratic_space`
- 対象ラベル: `claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis`
- 対象ラベル: `claim_map_to_split_quadratic_space_sends_family_to_basis`
- 対象ラベル: `claim_map_from_split_after_map_to_split_is_identity`
- 対象ラベル: `claim_map_to_split_after_map_from_split_is_identity`
- 対象ラベル: `claim_map_from_split_quadratic_space_is_isometry`
- 対象ラベル: `theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra`
- 検算: [check_isometry_onto_split_quadratic_space_and_induced_isomorphism.sage](check_isometry_onto_split_quadratic_space_and_induced_isomorphism.sage)
- 方法: 平方根の主張は、本文の場合分け（$`b=0`$ で $`a\ge0`$／$`a<0`$、$`b\ne0`$ で $`r=\sqrt{a^2+b^2}`$、$`u=\sqrt{(r+a)/2}`$、$`v=b/(2u)`$）を実代数的数 `AA` でそのまま実装し、30 個の $`z`$ で $`r+a>0`$、$`uu-vv=a`$、$`2uv=b`$、$`s^2=z`$ を確かめた。
  一般の空間は $`Y=K^{2M}`$、$`Q(x)=x^{\mathsf T}Ax`$（$`A`$ は有理数の対称行列で行列式が 0 でない。単位行列、符号の混ざった対角、対角成分がすべて 0 の分裂形、乱数 1 例）、$`K=`$ `QQbar`、$`M=1,2,3`$ の 12 例。
  直交基底を本文の前半の手順で作り、平方根で正規化して $`Q(e_k)=1`$・直交性・基底であることを確かめ、直交する族の線型結合での値の式を乱数の係数で確かめた。
  $`W=K^M`$（標準基底と双対基底）、$`V=W\oplus W^{*}`$ で族 $`u,v,d`$ と $`\theta=L_{e,u}`$・$`\theta'=L_{d,v}`$ を定義どおり（座標の写像を係数にした線型結合）に実装し、$`q(u_k)=1`$、$`u`$ の直交性、$`\theta'(u_k)=e_k`$、$`\theta(v_l)=d_l`$、$`\theta'\circ\theta`$ と $`\theta\circ\theta'`$ が恒等写像、$`\theta`$ と $`\theta'`$ が等長写像であることを確かめた。
  クリフォード代数の側は行列環への像で確かめた：$`\Phi\circ\mathrm{Cl}(\theta)`$ が $`\gamma_Y(e_k)`$ を送る $`\varphi(u_k)`$ が $`\varphi(u_k)\varphi(u_l)+\varphi(u_l)\varphi(u_k)=2\delta_{k,l}I`$ を満たすこと、その単調な積 $`4^M`$ 個が行列環を張ること、$`\varphi(\theta(v_l))`$ が $`c_m`$・$`c_m^{\mathsf T}`$ に一致すること（$`\Phi_Y(\Psi_Y(c_m))=c_m`$ の像）。
  否定の対照: 平方根で $`v`$ の符号を逆にすると $`b\ne0`$ の 5 例すべてで平方が $`z`$ にならないこと、$`u_{M+m}`$ の第一成分の係数を $`\mathrm{i}`$ にすると 12 例すべてで等長でなくなること、$`v`$ から $`h`$ を落とすと 12 例すべてで $`\theta'\circ\theta`$ が恒等写像の 2 倍になること。
- 実行: `micromamba run -n sage sage sagemath/check/isometry-onto-split-quadratic-space-and-induced-isomorphism/check_isometry_onto_split_quadratic_space_and_induced_isomorphism.sage`（SageMath 10.9、2026-11-12、約 4 分）。
- 結果: 通過。
- 位置づけ: ℂ 上の一般の線型空間とクリフォード代数についての主張を、代数的数の有限個の例と行列への像で確かめた裏取りであり、証明の代わりではない。
