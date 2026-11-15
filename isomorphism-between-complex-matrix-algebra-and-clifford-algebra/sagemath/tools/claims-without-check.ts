/**
 * SageMath の検算を置かない本文の主張・定理と、その理由（verify-check-linkage.ts が読む）。
 *
 * 検算を置くのは、行列の計算を含む主張と、クリフォード代数の中の計算を行列への像か SageMath の CliffordAlgebra で
 * 確かめられる主張である（runbook の「SageMath」）。ここに載せるのは、確かめる式変形が行列の計算を含まない主張で、
 * 検算を置いても定義や公理の写しになり、必ず通る比較にしかならないものである。
 *
 * chapters: 章のファイル（content/chapters/ の下の名前）ごと外す。その章の主張に検算を置いてもよい。
 * labels:   主張・定理のラベルごと外す。載せたラベルに検算を置いたら、ここから消す（verify-check-linkage.ts が落とす）。
 */

export type ExcludedChapter = { chapter: string; reason: string };
export type ExcludedLabels = { reason: string; labels: readonly string[] };

export const excludedChapters: readonly ExcludedChapter[] = [
  {
    chapter: "mathematical-toolkit.ts",
    reason:
      "行列を定義する前の章で、環・線型空間・有限集合の上の和・代数・商代数・テンソル積・テンソル代数・二次形式の一般の主張だけを置く。" +
      "行列の計算を含まない（台帳の数学的道具立ての行の SageMath の列が「不要」）",
  },
  {
    chapter: "clifford-algebra.ts",
    reason:
      "クリフォード代数の定義・普遍性・生成と、分裂した二次空間の生成元の関係を、偏極と二次形式の値から示す章で、行列の計算を含まない" +
      "（台帳のクリフォード代数の章の行の SageMath の列が「不要」。生成元の関係の行列の像は、同型の証明の章の生成作用素の行列の反交換関係の検算が確かめる）",
  },
];

export const excludedLabels: readonly ExcludedLabels[] = [
  {
    reason:
      "任意の有限集合で添字づけた行列についての一般の主張で、証明は成分の等式を ℂ の四則の公理へ帰着するか、ℂ-代数の公理を当てるだけである。" +
      "特定の行列の値を計算する行が無い（台帳の複素行列環の章の行の SageMath の列が「不要」）",
    labels: [
      "claim_matrices_indexed_by_finite_set_form_complex_vector_space",
      "claim_matrix_product_is_associative",
      "claim_matrix_product_distributes_over_sum_in_right_factor",
      "claim_matrix_product_distributes_over_sum_in_left_factor",
      "claim_identity_matrix_is_left_unit_of_matrix_product",
      "claim_identity_matrix_is_right_unit_of_matrix_product",
      "claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor",
      "claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor",
      "claim_matrices_indexed_by_finite_set_form_complex_algebra",
      "claim_matrix_entry_map_is_linear_map",
      "claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism",
      "claim_conjugations_by_mutually_inverse_matrices_compose_to_identity",
    ],
  },
  {
    reason:
      "整数・番号・ℂ の元についての主張で、行列を含まない（個数 N_i(T)・符号 ς(n) の性質は、それを使う生成作用素の行列の検算が成分ごとに確かめる）",
    labels: [
      "claim_number_of_pairs_of_subsets_is_at_least_one",
      "claim_two_element_set_is_finite_set",
      "claim_ordered_sums_of_integers_with_equal_terms_are_equal",
      "claim_count_below_index_after_adding_one_element",
      "claim_sign_of_nonnegative_integer_squares_to_one",
      "claim_count_below_index_vanishes_without_smaller_elements",
      "claim_one_plus_one_is_nonzero_in_complex_numbers",
      "claim_imaginary_unit_squares_to_minus_one",
    ],
  },
  {
    reason:
      "クリフォード代数の中の番号 m 以下の部分の積（a†_{U,≤m}・a_{T,≤m}・P_{≤m}・Q^{T,U}_m）を、番号順の積の定義で最後の因子に分けるか、" +
      "m=M で全体の積に一致させるだけの主張で、行列への像で確かめても定義の写しになる。これらを使う大域的な等式は検算が確かめる",
    labels: [
      "claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product",
      "claim_initial_ordered_creation_product_splits_off_last_number",
      "claim_initial_ordered_creation_product_up_to_last_number_is_whole_product",
      "claim_initial_part_of_vacuum_element_splits_off_last_factor",
      "claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element",
      "claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich",
    ],
  },
  {
    reason:
      "写像が線型であること・座標での展開・普遍性の一意性を当てる主張で、行列の値を計算する行が無い" +
      "（値の計算は、φ(v)·φ(v)=q(v)∗I、Ψ(E_{S,T})=ℰ_{S,T}、Ψ_Y∘Φ_Y=id、φ'(x)^2=q'(x)∗(I,I) などの検算済みの主張が持つ）",
    labels: [
      "claim_matrix_valued_map_on_split_quadratic_space_is_linear_map",
      "claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map",
      "claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators",
      "claim_homomorphisms_induced_by_inverse_isometries_compose_to_identity",
      "claim_map_from_odd_extension_to_pair_of_matrices_is_linear_map",
    ],
  },
  {
    reason:
      "j∘γ=γ'∘in'_1 は j の定義（等長写像が誘導する準同型）から従う主張で、j を行列で独立に計算する手段が無い" +
      "（奇数次元の検算は、この等式で Φ'(j(γ(d_k))) を φ'((d_k,0)) として使う）",
    labels: ["claim_induced_homomorphism_into_odd_extension_after_generator_map"],
  },
  {
    reason:
      "一般の線型空間・ℂ-代数・二次空間についての主張と、一つの次元を足した空間 V'=V⊕ℂ^vec の線型代数の主張で、行列を含まない",
    labels: [
      "claim_rearranging_sum_of_two_sums_in_vector_space",
      "claim_family_of_unit_is_basis_of_complex_numbers",
      "claim_polarization_of_odd_extension_quadratic_form",
      "claim_odd_extension_quadratic_form_is_quadratic_form",
      "claim_embedding_into_first_component_of_odd_extension_is_isometry",
      "claim_odd_extension_quadratic_form_at_added_unit_vector_is_one",
      "claim_polarization_of_odd_extension_between_first_component_and_added_unit_vector_is_zero",
      "claim_element_anticommuting_with_two_elements_commutes_with_their_product",
      "claim_elements_commuting_with_fixed_element_form_subalgebra",
      "claim_element_commuting_with_generating_subset_commutes_with_every_element",
      "claim_product_of_two_complex_algebras_is_complex_algebra",
      "claim_pair_of_algebra_homomorphisms_is_algebra_homomorphism",
    ],
  },
];
