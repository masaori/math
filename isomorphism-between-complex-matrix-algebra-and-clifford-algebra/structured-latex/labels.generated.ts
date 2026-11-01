// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_dual_space_is_complex_vector_space",
  "claim_pointwise_scalar_multiple_of_linear_form_is_linear_form",
  "claim_pointwise_sum_of_linear_forms_is_linear_form",
  "claim_zero_map_is_linear_form",
  "def_basis",
  "def_complex_vector_space",
  "def_dual_space",
  "def_linear_combination",
  "def_linear_form",
  "def_linear_independence",
  "def_linear_map",
  "def_ring_homomorphism",
  "def_spanning_family",
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
