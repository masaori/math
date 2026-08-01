// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "paper_claim_resultant",
  "paper_def_aL",
  "paper_def_curve",
  "paper_def_ladder",
  "paper_def_massieu",
  "paper_four_axes",
  "paper_lemma_V0",
  "paper_positioning",
  "paper_prop_A",
  "paper_prop_B",
  "paper_prop_C",
  "paper_prop_C_trace",
  "paper_prop_C_trace_ladder",
  "paper_prop_D",
  "paper_prop_F",
  "paper_prop_G",
  "paper_prop_G_ell2",
  "paper_prop_G_infty",
  "paper_prop_J",
  "paper_prop_K",
  "paper_prop_L",
  "paper_prop_M",
  "paper_prop_N",
  "paper_prop_Q",
  "paper_prop_R",
  "paper_prop_T",
  "paper_prop_U",
  "paper_prop_V",
  "paper_prop_W",
  "paper_remark_D_limits",
  "paper_remark_asymmetry",
  "paper_remark_formalization",
  "paper_remark_ising_known",
  "paper_remark_qp_motivation",
  "paper_remark_scope",
  "paper_thm_archimedean",
  "paper_wstar_different",
] as const

/** content/ に実在するラベル。相互参照はこの型の値しか指せない。 */
export type Label = (typeof ALL_LABELS)[number]

/**
 * 翻訳ロケールにしか無いブロックのラベル（locales.config.ts が理由つきで認めたもの）。
 * **原文はこれを指せない**。原文から指せば、原文の解決で未解決参照になる。
 */
export const TRANSLATION_ONLY_LABELS = [
  "paper_prior_art_countabilisation",
  "paper_prior_art_limits",
  "paper_prior_art_overall",
  "paper_prior_art_propositions",
  "paper_reading_guide",
  "paper_survey_scope",
] as const

export type TranslationOnlyLabel = (typeof TRANSLATION_ONLY_LABELS)[number]

/** 翻訳ロケールの content が使うラベル。原文のラベルに翻訳限定のものを足しただけ。 */
export type AnyLocaleLabel = Label | TranslationOnlyLabel
