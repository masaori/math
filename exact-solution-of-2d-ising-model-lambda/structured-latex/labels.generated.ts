// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_broken_bond_row_decomposition",
  "claim_coefficient_representation",
  "claim_coefficient_sum",
  "claim_configuration_partition",
  "claim_edge_row_partition",
  "claim_free_entropy_at_one",
  "claim_log_additive",
  "claim_log_power",
  "claim_matrix_pow_entry",
  "claim_rational_exponent_well_defined",
  "claim_rows_bijection",
  "claim_transfer_weight_product",
  "claim_value_at_rational_is_positive",
  "def_broken_bond_count",
  "def_configuration",
  "def_finite_free_entropy",
  "def_inter_row_broken_count",
  "def_intra_row_broken_count",
  "def_lattice",
  "def_log_order_group",
  "def_matrix_over_row_configs",
  "def_matrix_product",
  "def_matrix_trace",
  "def_multiplicity",
  "def_partition_polynomial",
  "def_prime_exponent",
  "def_rational_log",
  "def_row_configuration",
  "def_row_family",
  "def_row_restriction",
  "def_row_walk",
  "def_rows_map",
  "def_transfer_matrix",
  "def_walk_weight",
  "remark_planned_chapters",
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
