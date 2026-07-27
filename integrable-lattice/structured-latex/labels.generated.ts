// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（tools/generate-index.ts）
// 再生成: node tools/generate-index.ts
//
// このユニオン型が「実在するラベル」の全体であり、ref() / notes の targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
  "def_massieu_phi",
  "def_period_pi",
  "def_periodic_points",
  "def_spectral_curve",
  "def_vp_finite_procedure",
  "prop_A_eventual_periodicity",
  "prop_B_pi_p1_formula",
  "prop_C_pisano_bound",
  "prop_L_lte_minimal",
  "prop_N_newton_growth",
  "prop_T_spanning_tree_v2",
  "prop_V_nontriviality",
  "prop_W_graph_tower_closed_form",
  "remark_real_escape_isolation",
  "scaffold_claim_placeholder",
  "scaffold_def_placeholder",
] as const;

/** content/ に実在するラベル。相互参照はこの型の値しか指せない。 */
export type Label = (typeof ALL_LABELS)[number];
