// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（tools/generate-index.ts）
// 再生成: node tools/generate-index.ts
//
// このユニオン型が「実在するラベル」の全体であり、ref() / notes の targets は
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
  "paper_prop_D",
  "paper_prop_L",
  "paper_prop_N",
  "paper_prop_T",
  "paper_prop_V",
  "paper_prop_W",
  "paper_remark_D_limits",
  "paper_remark_asymmetry",
  "paper_remark_formalization",
  "paper_remark_ising_known",
  "paper_remark_qp_motivation",
  "paper_remark_scope",
  "paper_thm_archimedean",
] as const;

/** content/ に実在するラベル。相互参照はこの型の値しか指せない。 */
export type Label = (typeof ALL_LABELS)[number];
