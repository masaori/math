// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（と、翻訳ロケールにしか無いブロックの labels）
// 再生成: node <system>/codegen/structured-text-index/cli.ts --project <このディレクトリ>
//
// このユニオン型が「実在するラベル」の全体であり、ref() / ノートの targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "claim_dependency_transfer",
  "claim_event_set_cardinality",
  "claim_finite_propagation_boundary",
  "claim_flip_test_equivalence",
  "claim_global_flip_characterization",
  "claim_no_dependency_on_redundant_element",
  "claim_no_mutual_reachability",
  "claim_one_step_dependency_finite_decidability",
  "claim_one_step_subset_reachability",
  "claim_path_time_increment_exact",
  "claim_path_time_strictly_increases",
  "claim_propagation_ball_finite",
  "claim_reachability_irreflexive",
  "claim_reachability_minimal",
  "claim_reachability_partial_order",
  "claim_reachability_transitive",
  "claim_start_cell_in_propagation_ball",
  "claim_support_finite_decidability",
  "claim_support_invariance",
  "claim_time_strictly_increases",
  "def_base_value_extension",
  "def_cardinality_notation",
  "def_dependency_path",
  "def_dependency_source_set",
  "def_essential_dependency",
  "def_essential_dependency_support",
  "def_event_set",
  "def_finite_ca",
  "def_finite_stage",
  "def_flip_map",
  "def_global_map",
  "def_local_truth_table",
  "def_negation_map",
  "def_one_step_dependency",
  "def_partial_order",
  "def_propagation_ball",
  "def_reachability",
  "def_redundant_extension",
  "def_reflexive_reachability",
  "def_restriction_map",
  "def_state_set",
  "def_time_interval",
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
