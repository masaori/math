/**
 * 塔とグラフ: 企画書で 証明済み と明記された命題 T・V・W の転記。
 *
 * 出典は `outputs/paper-plans/002_R_Lambda_duality.md` §2。
 * 企画書が証明の骨子まで書いているものは、その骨子を `proof` へ転記した
 * （骨子の転記であって、証明の再構成ではない）。詳細は各命題が指す report にある。
 */

import { defineBlocks, displayMath, math, paragraph, ref, todo } from "../schema.ts";

export default defineBlocks([
  {
    id: "towers_000_heading",
    kind: "heading",
    level: 1,
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 1,
    title: { text: "塔とグラフ: 非自明性の判定と閉形式" },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "towers_001_theorem_nontriviality_criterion",
    kind: "theorem",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 2,
    title: { tex: String.raw`\text{命題 V（}\Lambda\ \text{側が非自明になる条件）}` },
    labels: ["prop_V_nontriviality"],
    habitat: "Z",
    verification: ["sagemath/check/cycle14_T1_vp_two_var"],
    statement: [
      paragraph([
        ref("def_spectral_curve"),
        " の ",
        math(String.raw`P`),
        "、素数 ",
        math(String.raw`p`),
        "、",
        math(String.raw`L = p^n`),
        " とすると",
      ]),
      displayMath(
        String.raw`a_{p^n} \equiv P(1,\dots,1)^{\,p^{dn}} \pmod p,
\qquad\text{ゆえに}\qquad v_p(a_{p^n}) > 0 \iff p \mid P(1,\dots,1).`,
      ),
      paragraph([
        "これにより「いつ ",
        math(String.raw`\Lambda`),
        " 側に内容があるか」が、",
        math(String.raw`P(1,\dots,1)`),
        " という 1 個の整数の整除だけで決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\bmod\ p`),
        " では ",
        math(String.raw`z^{p^n} - 1 = (z-1)^{p^n}`),
        " となるので、終結式表示 ",
        math(String.raw`a_L = \mathrm{Res}(z^L - 1, \mathrm{Res}(w^L - 1, P))`),
        " が潰れる。完備体も代数的整数論も使わない初等証明である。",
      ]),
      todo(
        "詳細は outputs/reports/cycle14_T1_vp_growth_two_variable.md §3。構造化テキストへの移設は未実施。",
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "towers_002_theorem_spanning_tree_v2",
    kind: "theorem",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 3,
    title: { text: "命題 T（トーラス全域木数の 2 進付値）" },
    labels: ["prop_T_spanning_tree_v2"],
    habitat: "Qbar",
    verification: ["sagemath/check/cycle13_T1_tau_v2"],
    statement: [
      paragraph([
        math(String.raw`\tau(L)`),
        " を ",
        math(String.raw`L \times L`),
        " トーラス ",
        math(String.raw`C_L \times C_L`),
        " の全域木数とすると、任意の奇数 ",
        math(String.raw`L \geq 3`),
        " に対し",
      ]),
      displayMath(String.raw`v_2(\tau(L)) = 2(L-1)`),
      paragraph([
        "が成り立つ。偶数 ",
        math(String.raw`L`),
        " では成立しない（",
        math(String.raw`L = 2,\dots,14`),
        " で ",
        math(String.raw`v_2 = 5, 19, 29, 61, 53, 83, 77`),
        "。証明が使う 2 条件が破れるため）。",
      ]),
    ],
    proof: [
      paragraph([
        "骨子は次のとおり。",
        math(String.raw`r_j + r_j^{-1} = 4 - \zeta^j - \zeta^{-j}`),
        " として",
      ]),
      displayMath(
        String.raw`\tau(L) = \prod_{j=1}^{L-1}\bigl(r_j^L + r_j^{-L} - 2\bigr) = \prod_{j=1}^{L-1} \frac{(r_j^L - 1)^2}{r_j^L}`,
      ),
      paragraph([
        "へ分解する。",
        math(String.raw`L`),
        " が奇数なので 2 は ",
        math(String.raw`\mathbb{Q}(\zeta_L)`),
        " で不分岐であり、素イデアル ",
        math(String.raw`P`),
        " をとって ",
        math(String.raw`r_j \equiv \zeta^j \pmod P`),
        " が言える。",
        math(String.raw`r_j = \zeta^j(1 + m_j)`),
        " と書くと ",
        math(String.raw`m_j`),
        " の満たす 2 次式の Newton 多角形から ",
        math(String.raw`v(m_j) = 1`),
        " が出る。",
        math(String.raw`v(L) = 0`),
        " による LTE の段で ",
        math(String.raw`v(r_j^L - 1) = 1`),
        " となり、総和して ",
        math(String.raw`2(L-1)`),
        " を得る。",
      ]),
      paragraph([
        "使うのは Kirchhoff の matrix-tree 定理、Hensel の補題、Newton 多角形、二項展開だけである。",
      ]),
      todo(
        "詳細は outputs/reports/cycle13_T1_observation_T_settlement.md §3。構造化テキストへの移設は未実施。",
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "towers_003_theorem_nondegenerate_graph_tower",
    kind: "theorem",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 4,
    title: { text: "命題 W（非退化グラフ塔の閉形式）" },
    labels: ["prop_W_graph_tower_closed_form"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限連結多重グラフ、",
        math(String.raw`\alpha : E \to \mathbb{Z}^2`),
        " を voltage、",
        math(String.raw`\ell`),
        " を素数とし、",
        math(String.raw`f = \det L(1+T, 1+S)`),
        " の ",
        math(String.raw`\bmod\ \ell`),
        " 還元の最低次斉次部分 ",
        math(String.raw`H`),
        "（次数 ",
        math(String.raw`k`),
        "）が ",
        math(String.raw`\mathbb{P}^1(\mathbb{F}_\ell)`),
        " 上に零点をもたない（＝非退化。係数の有限計算で判定できる）とする。このとき ",
        math(String.raw`n \gg 0`),
        " で",
      ]),
      displayMath(
        String.raw`\mathrm{ord}_\ell(\kappa_n) = \mu\,\ell^{2n} + \frac{k(\ell+1)}{\ell-1}\,\ell^{n} - 2n + \nu,
\qquad \mu = v_\ell\bigl(\mathrm{content}_{z,w}\det L\bigr).`,
      ),
      paragraph([
        "本稿の ",
        math(String.raw`L \times L`),
        " トーラス（",
        math(String.raw`P(1,1) = 0`),
        " のレジーム）は ",
        math(String.raw`\ell = 3, 7, \dots`),
        "（",
        math(String.raw`-1`),
        " が非平方な ",
        math(String.raw`\ell`),
        "）で射程内であり、",
        math(String.raw`\ell = 2`),
        " は退化ケースで射程外である。",
      ]),
      paragraph([
        "新規性は主張しない。 Kataoka, arXiv:2606.03579 が同種の明示公式を与えている。",
      ]),
    ],
    proof: [
      todo(
        "証明本体は outputs/reports/cycle14_T3_two_variable_criterion.md 定理 5（独立な第 2 経路は " +
          "cycle14_T3_Zl2_tower_criterion.md）。μ の上界方向は cycle 15 で Cuoco–Monsky Thm 1.7 に帰着している。" +
          "構造化テキストへの移設は未実施。",
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "towers_004_remark_r_side_is_the_only_escape",
    kind: "remark",
    sourcePath: "outputs/paper-plans/002_R_Lambda_duality.md",
    sourceOrdinal: 5,
    title: { tex: String.raw`\mathbb{R}\ \text{脱出はどこか（隔離の宣言）}` },
    labels: ["remark_real_escape_isolation"],
    habitat: "mixed",
    realEscape:
      "本稿で実数を要するのは、周期点数の増大率が Mahler 測度へ収束するという " +
      "(∞ 素点) の主張、すなわち L → ∞ の極限ただ一点である。" +
      "この極限は非可算な ℝ の順序完備性と収束概念に依存しており、可算側へは移せない。" +
      "有限 L の主張（命題 A・B・C・N・L・T）はいずれも ℤ・Λ・ℚ̄ の中で閉じ、実数を使わない。",
    verification: ["sagemath/check/cycle9_T1_spanning_tree"],
    statement: [
      paragraph([
        "本稿の主張のうち、非可算な ",
        math(String.raw`\mathbb{R}`),
        " を必要とするのは (∞ 素点) の極限 ",
        math(String.raw`\frac{1}{L^d}\log|a^{\mathrm{red}}_L| \to \log m(P)`),
        " ただ一点である。",
      ]),
      paragraph([
        "この隔離が本稿の主眼（決定可能性の非対称）の土台になる。",
        ref("prop_V_nontriviality"),
        " や ",
        ref("prop_L_lte_minimal"),
        " のような ",
        math(String.raw`p`),
        " 素点側の主張は、",
        ref("def_vp_finite_procedure"),
        " のとおり整数上の有限手続きで閉じている。",
      ]),
      paragraph([
        "なお (∞ 素点) の主張そのもの（成立条件と一般性の範囲）は、外部定理への依拠関係を含めて",
        "移設対象から外してある。理由は docs/paper-001-migration-status.md に記録した。",
      ]),
    ],
    conversion: { status: "converted" },
  },
]);
