// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_certificate_gives_uniform_bound",
  "claim_finite_geometric_sum",
  "claim_minimal_separating_growth",
  "claim_negative_origin_has_separating_subset",
  "claim_partition_value_at_least_one",
  "claim_peierls_bound",
  "def_boundary_edges",
  "def_box",
  "def_broken_count",
  "def_cardinality_notation",
  "def_configuration",
  "def_inner_edges",
  "def_low_temperature_certificate",
  "def_low_temperature_rational_points",
  "def_minimal_separating_count",
  "def_negative_origin_polynomial",
  "def_negative_origin_ratio",
  "def_partition_polynomial",
  "def_path",
  "def_separating_set",
  "def_site_set",
  "remark_escape_policy",
  "remark_not_claimed",
  "remark_open_problem_coverage",
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
