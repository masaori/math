/**
 * 判断待ちの論点（参照用ノート。最終成果物には載らない）。
 *
 * 企画書 `outputs/paper-plans/002_R_Lambda_duality.md` から構造化テキストへ移すにあたり、
 * **数学的判断が要るために移さなかった／保留した**論点を、関係するブロックへ紐づけて残す。
 * 一覧と理由は `integrable-lattice/docs/paper-001-migration-status.md`。
 */

import { defineNotes, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_pending_a_red_vs_a",
    targets: ["def_periodic_points", "def_massieu_phi"],
    title: { text: "判断待ち: 周期点数と簡約周期点数の使い分け" },
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    body: [
      paragraph([
        "企画書は帰属台帳（§3）で ",
        math(String.raw`\Phi_L = \log|a_L|`),
        " と書き、§2 の各命題では ",
        math(String.raw`a^{\mathrm{red}}_L`),
        " を使う箇所がある。どちらを本文の正とするか、また各命題がどちらを指すかの統一は",
        "執筆時の判断であり、移設者が決めることではない。",
      ]),
      paragraph([
        "移設では台帳に合わせて ",
        math(String.raw`\Phi_L = \log|a_L|`),
        " を採り、",
        math(String.raw`a^{\mathrm{red}}_L`),
        " は「単位トーラス上の零点を除いた版」として併記した。",
      ]),
    ],
  },
  {
    id: "note_pending_habitat_of_B_and_N",
    targets: ["prop_B_pi_p1_formula", "prop_N_newton_growth"],
    title: { text: "判断待ち: 命題 B・N の住処の置き方" },
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    body: [
      paragraph([
        "命題 B の主張本体は ",
        math(String.raw`\overline{\mathbb{F}_p}^{\times}`),
        " の固有値の位数であって ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " ではない。一方、命題 N は固有値の付値 ",
        math(String.raw`v_p(\lambda_i)`),
        " を使うが、企画書の台帳は固有値を ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " に置いている。",
      ]),
      paragraph([
        "どちらの住処を宣言するのが正しいかは数学的判断なので、移設では企画書の台帳に近い方を",
        "暫定で置き、この論点を残す。判断が付いたら住処の宣言を直すこと",
        "（型と実行時の両方が、住処と数式の食い違いを検査する）。",
      ]),
    ],
  },
  {
    id: "note_pending_finite_L_list",
    targets: ["remark_real_escape_isolation"],
    title: { text: "判断待ち: 「有限 L の主張」に命題 V・W を含めるか" },
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    body: [
      paragraph([
        "企画書は「有限 ",
        math(String.raw`L`),
        " の主張（命題 A・B・C・N・L・T）は ",
        math(String.raw`\mathbb{Z}`),
        " と ",
        math(String.raw`\Lambda`),
        " と ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " で閉じ」と書いており、命題 V・W を含めていない。",
      ]),
      paragraph([
        "命題 W は ",
        math(String.raw`n \gg 0`),
        " の漸近公式であって有限 ",
        math(String.raw`L`),
        " の主張ではなく、",
        math(String.raw`\mu`),
        " の上界方向は外部定理に依拠する。命題 V を含めてよいかも含め、",
        "この列挙を伸ばすかは執筆判断である。移設では企画書どおりの列挙に留めた。",
      ]),
    ],
  },
]);
