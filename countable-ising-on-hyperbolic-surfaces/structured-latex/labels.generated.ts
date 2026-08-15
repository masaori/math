// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_partition_polynomial_coefficient_expansion",
  "claim_partition_polynomial_value_at_one",
  "def_broken_edge_multiplicity",
  "def_broken_edge_set",
  "def_edge_spin_sign",
  "def_even_edge_subset",
  "def_even_subgraph_polynomial",
  "def_finite_cellulation_cell_sets",
  "def_finite_cellulation_connected_one_skeleton",
  "def_finite_cellulation_euler_characteristic",
  "def_finite_cellulation_face_boundary_word",
  "def_finite_cellulation_opposite_edge_occurrences",
  "def_finite_cellulation_regular_type",
  "def_finite_cellulation_vertex_links_are_cycles",
  "def_finite_graph_input",
  "def_formal_edge_weight_sum",
  "def_ising_partition_polynomial",
  "def_mod_two_boundary_parity",
  "def_oriented_closed_surface_cellulation",
  "def_spin_configuration_set",
  "theorem_formal_high_temperature_expansion",
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
