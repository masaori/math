// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_all_edge_variables_to_one_indeterminate_gives_partition_polynomial",
  "claim_boundary_response_outer_box_independence",
  "claim_boundary_response_outer_box_stability",
  "claim_boundary_response_specialization_homomorphism",
  "claim_broken_complement",
  "claim_coarse_graining_not_necessary_for_symmetrized_limit_quantity",
  "claim_coarse_graining_values_agree_implies_partition_values_agree",
  "claim_discriminant_does_not_determine_polynomial",
  "claim_discriminant_free_vs_periodic_differ_at_L3",
  "claim_distinct_roots_do_not_determine_polynomial",
  "claim_edge_endpoints_parity",
  "claim_even_multiplicity",
  "claim_factorization_type_determines_root_minimal_degrees",
  "claim_finite_box_equalities_transfer_to_limit_quantity",
  "claim_full_boundary_response_common_outer_box_comparison",
  "claim_full_boundary_response_degree_at_most_one",
  "claim_full_boundary_response_degree_exactly_one",
  "claim_full_boundary_response_monomial_maps_to_monomial_under_outer_edges_to_one",
  "claim_full_boundary_response_outer_edges_to_one",
  "claim_full_boundary_response_outer_edges_to_one_is_sum_of_inner_monomials",
  "claim_full_boundary_response_outer_edges_to_one_then_value_at_one",
  "claim_full_boundary_response_total_degree_is_edge_count",
  "claim_full_boundary_response_value_at_one",
  "claim_galois_hyperoctahedral_bound",
  "claim_limit_quantity_depends_only_on_finite_box_sequence",
  "claim_odd_flip_involution",
  "claim_odd_flip_reverses_edges",
  "claim_palindrome",
  "claim_partition_coefficients_nonnegative",
  "claim_partition_support_endpoints",
  "claim_partition_value_at_one",
  "claim_partition_value_coarse_graining_is_sufficient_for_limit_quantity",
  "claim_periodic_constant_unbroken",
  "claim_periodic_no_all_broken",
  "claim_periodic_not_palindrome",
  "claim_periodic_successor_not_palindrome",
  "claim_rational_values_determine_partition_polynomial",
  "claim_roots_leading_coefficient_multiplicities_determine_polynomial",
  "claim_same_partition_different_pair_data",
  "claim_shifted_free_family_discriminant_does_not_determine_limit_quantity",
  "claim_shifted_free_family_factorization_type_does_not_determine_limit_quantity",
  "claim_shifted_free_family_galois_group_does_not_determine_limit_quantity",
  "claim_shifted_free_family_partition_value_does_not_determine_limit_quantity",
  "claim_shifted_free_family_partition_values_differ_but_finite_box_quantities_agree",
  "claim_splitting_degree_galois_group_do_not_determine_polynomial",
  "claim_structural_palindrome",
  "claim_symmetrized_prime_exponent_data_is_reciprocal_invariant",
  "claim_tail_agreement_is_equivalence_relation",
  "claim_tail_agreement_is_sufficient_for_limit_quantity",
  "claim_two_dimensional_boundary_response_even_subgraph_sum",
  "claim_two_dimensional_boundary_response_pfaffian_prediction",
  "def_bipartite_successor_system",
  "def_boundary_response_polynomial",
  "def_box",
  "def_broken_count",
  "def_coarse_graining_sufficient_and_not_necessary_for_limit_quantity",
  "def_configuration",
  "def_constant_coarse_graining_from_q_independent_invariant",
  "def_edge_set",
  "def_endpoint_maps",
  "def_finite_box_prime_exponent_sequence",
  "def_full_boundary_response_polynomial",
  "def_global_spin_flip",
  "def_limit_quantity_from_finite_box_sequence",
  "def_multiplicity",
  "def_nonfixed_reciprocal_roots",
  "def_odd_flip",
  "def_odd_sites",
  "def_partition_polynomial",
  "def_periodic_broken_count",
  "def_periodic_edge_set",
  "def_periodic_endpoint_maps",
  "def_periodic_multiplicity",
  "def_periodic_successor_edges",
  "def_periodic_successor_multiplicity",
  "def_periodic_successor_system",
  "def_positive_rational_prime_exponent_data",
  "def_signed_pair_polynomial",
  "def_structural_broken_count",
  "def_structural_color_flip",
  "def_structural_configuration",
  "def_structural_multiplicity",
  "def_symmetrized_limit_quantity",
  "def_tail_equivalence_of_finite_box_sequences",
  "def_two_dimensional_boundary_response_polynomial",
  "remark_boundary_response_only_outer_count_survives",
  "remark_null_model_positioning",
  "remark_odd_period_positioning",
  "remark_two_dimensional_prediction_filter",
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
