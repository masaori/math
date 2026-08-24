// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_partition_polynomial_coefficient_expansion",
  "claim_partition_polynomial_value_at_one",
  "claim_single_vertex_spin_flip_involution",
  "claim_spin_reversal_integer_realization",
  "def_broken_edge_multiplicity",
  "def_broken_edge_set",
  "def_edge_endpoint_label_set",
  "def_edge_spin_sign",
  "def_even_edge_subset",
  "def_even_subgraph_polynomial",
  "def_finite_graph_input",
  "def_fisher_zero_algebraic_shifted_reciprocal_sum",
  "def_formal_edge_weight_sum",
  "def_ising_partition_polynomial",
  "def_mod_two_boundary_parity",
  "def_single_vertex_spin_flip",
  "def_spin_configuration_set",
  "def_spin_integer_realization",
  "def_spin_label_reversal",
  "def_spin_label_set",
  "theorem_coefficient_symmetry_characterizes_full_cut",
  "theorem_even_incident_edge_counts_evaluation_minus_one",
  "theorem_even_linear_factor_characterizes_odd_incident_edge_count",
  "theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio",
  "theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient",
  "theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio",
  "theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio",
  "theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio",
  "theorem_fisher_zero_cube_sum_coefficient_ratio",
  "theorem_fisher_zero_elementary_symmetric_coefficient_ratio",
  "theorem_fisher_zero_fourth_power_sum_coefficient_ratio",
  "theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio",
  "theorem_fisher_zero_power_sum_newton_recurrence",
  "theorem_fisher_zero_product_coefficient_ratio",
  "theorem_fisher_zero_rational_shifted_product_coefficient_ratio",
  "theorem_fisher_zero_reciprocal_sum_coefficient_ratio",
  "theorem_fisher_zero_shifted_product_configuration_count",
  "theorem_fisher_zero_square_sum_coefficient_ratio",
  "theorem_fisher_zero_sum_coefficient_ratio",
  "theorem_fisher_zeros_nonzero",
  "theorem_formal_high_temperature_expansion",
  "theorem_full_cut_coefficient_symmetry",
  "theorem_full_cut_distinct_fisher_zero_product",
  "theorem_full_cut_distinct_fisher_zero_product_support_parity",
  "theorem_full_cut_fisher_zero_minus_one_multiplicity_parity",
  "theorem_full_cut_fisher_zero_product",
  "theorem_full_cut_fisher_zero_product_away_from_minus_one",
  "theorem_full_cut_fisher_zero_reciprocal_multiplicity",
  "theorem_full_cut_fisher_zero_support_parity_characterization",
  "theorem_full_cut_positive_rational_evaluation_reciprocity",
  "theorem_linear_factor_characterizes_odd_incident_edge_count",
  "theorem_no_linear_factor_x_minus_one",
  "theorem_no_positive_rational_root",
  "theorem_odd_incident_edge_count_root_minus_one",
  "theorem_partition_polynomial_coefficient_evenness",
  "theorem_partition_polynomial_degree_maximum_broken_edge_count",
  "theorem_partition_polynomial_degree_maximum_cut_size",
  "theorem_partition_polynomial_positive_rational_evaluation_at_least_configuration_count",
  "theorem_partition_polynomial_positive_rational_evaluation_at_most_configuration_count",
  "theorem_partition_polynomial_positive_rational_evaluation_equal_configuration_count",
  "theorem_partition_polynomial_positive_rational_evaluation_injectivity",
  "theorem_partition_polynomial_positive_rational_evaluation_monotonicity",
  "theorem_partition_polynomial_positive_rational_evaluation_order_reflection",
  "theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity",
  "theorem_partition_polynomial_positive_rational_evaluation_strictly_above_configuration_count",
  "theorem_partition_polynomial_positive_rational_evaluation_strictly_below_configuration_count",
  "theorem_partition_polynomial_positive_rational_evaluation_weak_order_reflection",
  "theorem_partition_polynomial_reciprocity_characterizes_full_cut",
  "theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio",
  "theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio",
  "theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio",
  "theorem_reciprocal_fisher_zero_power_sum_newton_recurrence",
  "theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio",
  "theorem_root_minus_one_characterizes_odd_incident_edge_count",
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
