// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_annihilation_operator_matrices_anticommute",
  "claim_binary_numbering_is_numbering_of_power_set",
  "claim_complex_numbers_as_vector_space_is_complex_vector_space",
  "claim_coordinate_map_is_linear_form",
  "claim_coordinate_maps_form_dual_basis",
  "claim_count_below_index_after_adding_one_element",
  "claim_count_below_index_vanishes_without_smaller_elements",
  "claim_creation_and_annihilation_operator_matrices_anticommute",
  "claim_creation_operator_matrices_anticommute",
  "claim_decomposition_of_identity_matrix_into_matrix_units",
  "claim_direct_sum_element_is_sum_of_embedded_components",
  "claim_direct_sum_of_two_vector_spaces_is_complex_vector_space",
  "claim_dual_basis_spans_dual_space",
  "claim_dual_space_is_complex_vector_space",
  "claim_embedding_into_first_component_is_linear_map",
  "claim_embedding_into_second_component_is_linear_map",
  "claim_entry_of_creation_operator_matrix_times_matrix",
  "claim_entry_of_matrix_times_creation_operator_matrix",
  "claim_family_member_is_kronecker_delta_linear_combination",
  "claim_homomorphisms_agreeing_on_generators_are_equal",
  "claim_identity_matrix_is_left_unit_of_matrix_product",
  "claim_identity_matrix_is_right_unit_of_matrix_product",
  "claim_interchange_of_double_sum_over_finite_sets",
  "claim_linear_form_maps_linear_combination_to_ordered_sum",
  "claim_linear_map_maps_sum_over_finite_set_to_sum_of_values",
  "claim_matrices_indexed_by_finite_set_form_complex_algebra",
  "claim_matrices_indexed_by_finite_set_form_complex_vector_space",
  "claim_matrix_entry_map_is_linear_map",
  "claim_matrix_product_distributes_over_sum_in_left_factor",
  "claim_matrix_product_distributes_over_sum_in_right_factor",
  "claim_matrix_product_is_associative",
  "claim_moving_term_of_linear_combination_to_last",
  "claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit",
  "claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit",
  "claim_ordered_sum_with_kronecker_delta_picks_term",
  "claim_pointwise_scalar_multiple_of_linear_form_is_linear_form",
  "claim_pointwise_sum_of_linear_forms_is_linear_form",
  "claim_product_of_matrix_units",
  "claim_reindexing_linear_combination_by_bijection",
  "claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor",
  "claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor",
  "claim_scalar_multiple_of_linear_combination",
  "claim_scalar_multiple_of_sum_over_finite_set",
  "claim_scalar_multiple_of_zero_vector_is_zero_vector",
  "claim_sign_of_nonnegative_integer_squares_to_one",
  "claim_sum_of_linear_combinations_of_same_family",
  "claim_sum_of_sums_over_finite_set_with_same_coefficients",
  "claim_sum_of_sums_over_finite_set_with_same_family",
  "claim_sum_over_finite_set_depends_only_on_terms",
  "claim_sum_over_finite_set_with_kronecker_delta_picks_term",
  "claim_uniqueness_of_coefficients_of_linear_combination",
  "claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices",
  "claim_value_of_linear_combination_in_dual_space",
  "claim_zero_map_is_linear_form",
  "claim_zero_scalar_multiple_is_zero_vector",
  "def_annihilation_operator_matrix",
  "def_basis",
  "def_binary_numbering_of_power_set",
  "def_complex_algebra",
  "def_complex_algebra_homomorphism",
  "def_complex_numbers_as_complex_vector_space",
  "def_complex_vector_space",
  "def_count_of_subset_elements_below_index",
  "def_creation_operator_matrix",
  "def_direct_sum_of_two_vector_spaces",
  "def_dual_basis",
  "def_dual_space",
  "def_embedding_into_first_component_of_direct_sum",
  "def_embedding_into_second_component_of_direct_sum",
  "def_kronecker_delta",
  "def_linear_combination",
  "def_linear_form",
  "def_linear_independence",
  "def_linear_map",
  "def_matrices_indexed_by_finite_set",
  "def_matrix_unit",
  "def_numbering_of_finite_set",
  "def_ordered_product_in_algebra",
  "def_ordered_sum_in_complex_numbers",
  "def_power_set_of_first_m_positive_integers",
  "def_ring_homomorphism",
  "def_sign_of_nonnegative_integer",
  "def_spanning_family",
  "def_subalgebra",
  "def_subset_generates_algebra",
  "def_sum_over_finite_set",
  "def_underlying_ring_and_vector_space_of_algebra",
  "def_unital_ring",
] as const

/** content/ に実在するラベル。相互参照はこの型の値しか指せない。 */
export type Label = (typeof ALL_LABELS)[number]

/**
 * 翻訳ロケールにしか無いブロックのラベル（locales.config.ts が理由つきで認めたもの）。
 * **原文はこれを指せない**。原文から指せば、原文の解決で未解決参照になる。
 */
export const TRANSLATION_ONLY_LABELS = [

] as const

export type TranslationOnlyLabel = (typeof TRANSLATION_ONLY_LABELS)[number]

/** 翻訳ロケールの content が使うラベル。原文のラベルに翻訳限定のものを足しただけ。 */
export type AnyLocaleLabel = Label | TranslationOnlyLabel
