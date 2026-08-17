// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_even_edge_subset_maps_to_first_cycle",
  "claim_integer_sign_character_multiplicativity",
  "claim_partition_polynomial_coefficient_expansion",
  "claim_partition_polynomial_value_at_one",
  "claim_single_vertex_spin_flip_involution",
  "claim_spin_reversal_integer_realization",
  "def_broken_edge_multiplicity",
  "def_broken_edge_set",
  "def_dual_edge_endpoint_map",
  "def_dual_face_boundary_word",
  "def_edge_endpoint_label_set",
  "def_edge_spin_sign",
  "def_edge_subset_coefficient_map_over_f2",
  "def_even_edge_subset",
  "def_even_edge_subset_homology_class_map",
  "def_even_subgraph_polynomial",
  "def_f2_linear_character_space",
  "def_face_boundary_space_over_f2",
  "def_finite_cellulation_cell_sets",
  "def_finite_cellulation_connected_one_skeleton",
  "def_finite_cellulation_corner_edge_end_map",
  "def_finite_cellulation_corner_side_label_set",
  "def_finite_cellulation_cyclic_position_system",
  "def_finite_cellulation_euler_characteristic",
  "def_finite_cellulation_face_boundary_word",
  "def_finite_cellulation_hyperbolic_regular_type",
  "def_finite_cellulation_opposite_edge_occurrences",
  "def_finite_cellulation_orientation_endpoint_selectors",
  "def_finite_cellulation_orientation_label_set",
  "def_finite_cellulation_orientation_reversal",
  "def_finite_cellulation_regular_type",
  "def_finite_cellulation_vertex_links_are_cycles",
  "def_finite_graph_input",
  "def_first_boundary_matrix_over_f2",
  "def_first_cycle_space_over_f2",
  "def_first_homology_group_over_f2",
  "def_formal_edge_weight_sum",
  "def_homology_class_generating_polynomial",
  "def_integer_sign_character_realization",
  "def_ising_partition_polynomial",
  "def_mod_two_boundary_parity",
  "def_oriented_closed_surface_cellulation",
  "def_primal_cocycle_to_dual_cycle_transport",
  "def_primal_cohomology_to_dual_homology_transport",
  "def_primal_dual_cell_correspondence",
  "def_primal_first_cocycle_space_over_f2",
  "def_primal_to_dual_edge_coefficient_transport",
  "def_second_boundary_matrix_over_f2",
  "def_single_vertex_spin_flip",
  "def_spin_configuration_set",
  "def_spin_integer_realization",
  "def_spin_label_reversal",
  "def_spin_label_set",
  "theorem_boundary_of_boundary_is_zero_over_f2",
  "theorem_finite_character_orthogonality",
  "theorem_finite_fourier_inverse_transform",
  "theorem_formal_high_temperature_expansion",
  "theorem_homology_class_polynomials_recombine",
  "theorem_primal_coboundary_transport_is_dual_boundary",
  "theorem_primal_cocycle_transport_is_dual_cycle",
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
