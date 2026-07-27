/**
 * $\Lambda$ 側の「有限・初等・決定可能な顔」— 企画書で 証明済み と明記された命題群。
 *
 * 出典は `outputs/paper-plans/002_R_Lambda_duality.md` §2「現時点で厳密に確定している部分命題」。
 * 主張文の転記であり、証明の再構成ではない。 証明本体は各命題の `proof` に置いた出典
 * （`outputs/reports/...`）にあり、構造化テキストへの移設は数学的判断を要するため未実施である
 * （何が未実施かは `integrable-lattice/docs/paper-001-migration-status.md`）。
 */

import { defineBlocks, displayMath, math, paragraph, ref, todo } from "../schema.ts";

export default defineBlocks([
  {
    id: "lambda_finite_000_heading",
    kind: "heading",
    level: 1,
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 1,
    title: { tex: String.raw`\Lambda\ \text{側の有限・決定可能な命題群}` },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "lambda_finite_001_claim_eventual_periodicity",
    kind: "claim",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 2,
    title: { tex: String.raw`\text{命題 A（}v_p\ \text{の最終周期性）}` },
    labels: ["prop_A_eventual_periodicity"],
    habitat: "Z",
    verification: ["sagemath/check/cycle3_T1_period_bound"],
    statement: [
      paragraph([
        math(String.raw`T \in M_d(\mathbb{Z})`),
        "、",
        math(String.raw`Z_N = \operatorname{Tr} T^N`),
        "、",
        math(String.raw`p \nmid \det T`),
        " とする。任意の切断 ",
        math(String.raw`k \geq 1`),
        " に対し ",
        math(String.raw`\min(v_p(Z_N), k)`),
        " は ",
        math(String.raw`N`),
        " について最終周期的であり、その周期は ",
        ref("def_period_pi"),
        " の ",
        math(String.raw`\pi(p,k)`),
        " を割る。",
      ]),
    ],
    proof: [
      paragraph(["有限集合上の鳩の巣原理による。"]),
      todo(
        "証明本体は outputs/reports/cycle3_T1_D-U2_rigorous.md と " +
          "outputs/candidates/D-U2_consolidated_proposition.md にある。構造化テキストへの移設は未実施。",
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "lambda_finite_002_claim_pi_p1_formula",
    kind: "claim",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 3,
    title: { tex: String.raw`\text{命題 B（}\pi(p,1)\ \text{の精密公式）}` },
    labels: ["prop_B_pi_p1_formula"],
    habitat: "Qbar",
    verification: ["sagemath/check/cycle3_T3_period"],
    statement: [
      paragraph([ref("def_period_pi"), " の ", math(String.raw`\pi(p,1)`), " について"]),
      displayMath(
        String.raw`\pi(p,1) = \operatorname{lcm}\bigl\{\operatorname{ord}(\lambda) : \lambda \in \overline{\mathbb{F}_p}^{\times}\ \text{相異固有値},\ p \nmid m_\lambda \bigr\}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`m_\lambda`),
        " は代数的重複度）。固有値は ",
        math(String.raw`\overline{\mathbb{F}_p}`),
        " の元であり、可算な対象の中で閉じている。",
      ]),
    ],
    proof: [
      paragraph(["指標の一次独立性による。"]),
      todo("証明本体は cycle 7–8 の report にある。構造化テキストへの移設は未実施。"),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "lambda_finite_003_claim_pisano_bound",
    kind: "claim",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 4,
    title: { text: "命題 C（Pisano 型上界と、Wall 型等式の反例）" },
    labels: ["prop_C_pisano_bound"],
    habitat: "Z",
    verification: ["sagemath/check/cycle3_T3_period"],
    statement: [
      paragraph([math(String.raw`\pi(p,k) \mid p^{k-1}\pi(p,1)`), " が成り立つ（既知の Pisano 型上界）。"]),
      paragraph([
        "等号（Wall 型）は一般には成り立たない。 六頂点模型の 572 件中 4.5% で反例があり、",
        "Pell 型の ",
        math(String.raw`p = 13`),
        " などが該当する（cycle 6）。",
      ]),
      paragraph([
        "この「魅力的だが偽の枝」を残す理由は、0 件観察を根拠にしてはならないという方法論上の教訓を",
        "本文で述べるためである。",
      ]),
    ],
    proof: [
      todo(
        "上界の証明は古典（線形漸化列の p 進付値）。反例の探索は " +
          "sagemath/check/cycle3_T3_period の wall_*.out にある。構造化テキストへの移設は未実施。",
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "lambda_finite_004_claim_newton_growth",
    kind: "claim",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 5,
    title: { text: "命題 N（線形成長率と Newton 多角形）" },
    labels: ["prop_N_newton_growth"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`v_p(Z_N)`),
        " の ",
        math(String.raw`N`),
        " についての線形成長率は",
      ]),
      displayMath(String.raw`\mu_{\min}(p) = \min_i v_p(\lambda_i)`),
      paragraph([
        "で与えられ、これは特性多項式 ",
        math(String.raw`\chi_T`),
        " の ",
        math(String.raw`p`),
        " 進 Newton 多角形から定まる。",
        "整数係数の付値の下方凸包という有限組合せ手続きであり、固有値を個別に構成する必要も、",
        "完備体を使う必要もない。",
      ]),
    ],
    proof: [
      todo(
        "証明本体は cycle の report にある（Newton 多角形の標準論法）。構造化テキストへの移設は未実施。",
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "lambda_finite_005_theorem_lte_minimal_example",
    kind: "theorem",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 6,
    title: { tex: String.raw`\text{命題 L（1 変数最小例}\ P(z)=z-c\ \text{の完全形）}` },
    labels: ["prop_L_lte_minimal"],
    habitat: "Z",
    verification: ["sagemath/check/cycle7_T1_lte"],
    statement: [
      paragraph([
        math(String.raw`c \in \mathbb{Z}_{\geq 2}`),
        " とし ",
        math(String.raw`P(z) = z - c`),
        " をとる。このとき ",
        math(String.raw`|a_L| = c^L - 1`),
        " であり、",
        math(String.raw`p`),
        " 素点の係数は次で完全に決まる。",
      ]),
      paragraph([
        "（1）",
        math(String.raw`p`),
        " が奇素数、",
        math(String.raw`p \nmid c`),
        "、",
        math(String.raw`d = \operatorname{ord}_p(c)`),
        " のとき",
      ]),
      displayMath(
        String.raw`v_p(c^L - 1) = \begin{cases} v_p(c^d - 1) + v_p(L) & (d \mid L) \\ 0 & (d \nmid L) \end{cases}`,
      ),
      paragraph(["（2）", math(String.raw`p = 2`), "、", math(String.raw`c`), " が奇数のとき"]),
      displayMath(
        String.raw`v_2(c^L - 1) = \begin{cases} v_2(c - 1) & (L\ \text{奇}) \\ v_2(c-1) + v_2(c+1) + v_2(L) - 1 & (L\ \text{偶}) \end{cases}`,
      ),
      paragraph([
        "いずれも初等整数論の LTE（lifting-the-exponent）で示せ、決定手続きに乗る。",
      ]),
    ],
    proof: [
      todo(
        "証明本体は outputs/reports/cycle8_T1_lte_proposition.md にある。構造化テキストへの移設は未実施。",
      ),
    ],
    conversion: { status: "converted" },
  },
]);
