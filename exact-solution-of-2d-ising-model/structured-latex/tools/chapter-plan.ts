/**
 * 2026-10-31 に代表が承認した章立て（`docs/tasks/six-chapter-organization-proposal.md`）の機械可読版。
 *
 * 棚卸しの生成器（`build-flat-inventory.ts`）は、ここに書いた章の順に、各章のゴールのブロックから
 * 依存閉包を取り、まだどの章にも入っていないイジング側の項をその章へ割り当てる。
 * 章の題は、本文冒頭の章立ての説明（`content/chapter_organization.ts`）の各章のゴールの remark の題と
 * 同じにする（生成器が一致を検査する）。本文の章見出しを組み直すときも、この題を見出しに使う。
 *
 * `goalLabels` は、章立て案のその章の「ゴールの式」を構成する主張・定義のブロックのラベルである。
 * 依存閉包はこれらから取るので、ゴールの式に現れる対象を定める定義もここに挙げる。
 * `proposalEntryCount` は章立て案に書いた項目数で、実際の割り当て数との差の理由は状態台帳に書く。
 */
import type { Label } from "../labels.generated.ts";

export type ChapterTitle = { readonly text: string } | { readonly tex: string };

export type PlannedChapter = {
  readonly title: ChapterTitle;
  readonly organizationGoalLabel: Label;
  readonly goalLabels: readonly Label[];
  readonly proposalEntryCount: number;
};

export type PlannedPart = {
  readonly title: string;
  readonly chapters: readonly PlannedChapter[];
};

export const mathematicalToolPartTitle = "数学的道具立て";

export const plannedParts: readonly PlannedPart[] = [
  {
    title: "分配関数",
    chapters: [
      {
        title: { text: "転送行列による表示" },
        organizationGoalLabel: "chapter_organization_goal_transfer_matrix_representation",
        goalLabels: ["partition_function_via_pauli_transfer_matrices"],
        proposalEntryCount: 20,
      },
      {
        title: { tex: String.raw`\varepsilon \text{ の固有値 } +1 \text{ の固有空間への射影と Jordan–Wigner 表示}` },
        organizationGoalLabel: "chapter_organization_goal_projection_and_jordan_wigner",
        goalLabels: ["symmetrized_transfer_matrix_on_sector_exponential_form"],
        proposalEntryCount: 27,
      },
    ],
  },
  {
    title: "固有値問題",
    chapters: [
      {
        title: { tex: String.raw`\text{離散 Fourier 変換による }2\times2\text{ 行列 }A(\tilde\theta_\mu)\text{ への帰着}` },
        organizationGoalLabel: "chapter_organization_goal_reduction_to_A_theta",
        goalLabels: ["T_V_plus_check_Z_Y_via_B1_B2_B1"],
        proposalEntryCount: 27,
      },
      {
        title: { tex: String.raw`A(\tilde\theta_\mu)\text{ の対角化と }V^{(+)}\text{ の指数表示}` },
        organizationGoalLabel: "chapter_organization_goal_diagonalization_and_exponential_form",
        // ゴールの式は一般の実数 θ での γ(θ) を定めるので、それを定める主張も挙げる。
        goalLabels: ["V_plus_eq_c_exp_sum_gamma_check_number_operator", "gamma1_lower_bound_all_theta"],
        proposalEntryCount: 27,
      },
      {
        title: { tex: String.raw`V^{(+)}\text{ の固有値}` },
        organizationGoalLabel: "chapter_organization_goal_eigenvalues_of_V_plus",
        goalLabels: ["V_plus_eigenvalues_with_c_value_and_strict_maximum"],
        proposalEntryCount: 15,
      },
      {
        title: { tex: String.raw`V^{(+)}\text{ の最大固有値に属する固有ベクトル}` },
        organizationGoalLabel: "chapter_organization_goal_eigenvector_of_max_eigenvalue",
        goalLabels: [
          "trace_of_epsilon_V_plus",
          "max_eigenvector_in_even_sector",
        ],
        proposalEntryCount: 17,
      },
    ],
  },
  {
    title: "熱力学極限",
    chapters: [
      {
        title: { tex: String.raw`N\to\infty\text{ の極限と最大固有値 }c(M)` },
        organizationGoalLabel: "chapter_organization_goal_row_limit_and_max_eigenvalue",
        goalLabels: [
          "def_rayleigh_sup",
          "partition_function_sandwich",
          "limit_of_log_Z_in_N_row",
        ],
        proposalEntryCount: 9,
      },
      {
        title: { tex: String.raw`M\to\infty\text{ の極限と閉形式}` },
        organizationGoalLabel: "chapter_organization_goal_column_limit_and_closed_form",
        goalLabels: [
          "def_sector_rayleigh_sup",
          "c_plus_equals_Lambda_half_integer",
          "onsager_exact_solution",
        ],
        proposalEntryCount: 9,
      },
    ],
  },
  {
    title: "臨界点",
    chapters: [
      {
        title: { tex: String.raw`\text{臨界点 }K_c\text{ と }\frac{d^2f}{dK^2}\text{ の対数発散}` },
        organizationGoalLabel: "chapter_organization_goal_critical_point_and_log_divergence",
        goalLabels: [
          "kappa_of_K_basic",
          "specific_heat_log_divergence",
        ],
        proposalEntryCount: 10,
      },
    ],
  },
];
