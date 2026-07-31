/**
 * Chapter 3: The archimedean place (known) (English version).
 *
 * **正本は日本語版 `../../structured-latex/content/003_archimedean.ts` である。**
 * このファイルはその英訳であり、ブロック id・ラベル・`habitat`・`verification` / `lean`・
 * **数式**は日本語版と完全に同じ文字列を使う（`tools/verify-ja-en-correspondence.ts` が検査する）。
 * 訳語は `integrable-lattice/docs/paper001-en-glossary.md` を正本とする。
 *
 * 英語版だけの差: 地の文の書誌（"Invent. math. **101** (1990) 593--629" 等）は日本語版のまま
 * 英語で残したうえで、**加えて `cite` ノードで BibTeX の引用を付ける**（投稿稿は参考文献表を持つため）。
 * `cite` は数式ではないので、日英の数式多重集合の一致は壊れない。
 */

import { cite, defineBlocks, displayMath, list, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "paper_030_heading_archimedean",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex-en/content/003_archimedean.ts", ordinal: 1 },
    title: { text: "The archimedean place (known) — the only chapter that uses ℝ" },
    labels: [],
  },
  {
    id: "paper_031_theorem_lsw",
    kind: "theorem",
    origin: { path: "structured-latex-en/content/003_archimedean.ts", ordinal: 2 },
    title: {
      text: "Entropy equals the Mahler measure, and the growth rate of periodic points (both known)",
    },
    labels: ["paper_thm_archimedean"],
    habitat: "R",
    realEscape:
      "The conclusion of this theorem is itself a convergence to an element of ℝ, namely log m(P). This is " +
      "the one and only place where this paper uses ℝ, and none of the assertions on the Λ side from " +
      "Chapter 4 onwards depends on this theorem.",
    statement: [
      paragraph([
        "Let ",
        math(String.raw`m(P)`),
        " denote the Mahler measure of ",
        math(String.raw`P\in\mathbb{Z}[z_1^{\pm},\dots,z_d^{\pm}]\setminus\{0\}`),
        ", and let ",
        math(String.raw`\mathsf U(P)=\{z\in\mathbb{S}^d:P(z)=0\}`),
        " be its zero set on the complex unit torus. Each of the following is **known**.",
      ]),
      list([
        [
          "**(i)** The topological entropy of the algebraic ",
          math(String.raw`\mathbb{Z}^d`),
          " action equals ",
          math(String.raw`\log m(P)`),
          ". **There is no hypothesis** (Lind–Schmidt–Ward, Invent. math. **101** (1990) 593–629, Theorem 3.1; ",
          cite(["LindSchmidtWard1990"], "Theorem 3.1"),
          ").",
        ],
        [
          "**(ii)** That the growth rate of the periodic points agrees with the entropy **does not hold in general**. ",
          "It does hold for expansive actions, a condition equivalent to ",
          math(String.raw`\mathsf U(P)=\varnothing`),
          " (op. cit., Theorem 7.1; ",
          cite(["LindSchmidtWard1990"], "Theorem 7.1"),
          ").",
        ],
        [
          "**(iii)** It holds if ",
          math(String.raw`\mathsf U(P)`),
          " is a **finite set** (Lind–Schmidt–Verbitskiy, arXiv:1108.4989, Theorem 1.2; ",
          cite(["LindSchmidtVerbitskiy2013"], "Theorem 1.2"),
          ").",
        ],
        [
          "**(iv)** More generally, it holds if ",
          math(String.raw`\dim\mathsf U(P)\le d-2`),
          ", that is, if ",
          math(String.raw`P`),
          " is **atoral** (op. cit., Theorem 1.3; ",
          cite(["LindSchmidtVerbitskiy2013"], "Theorem 1.3"),
          ").",
        ],
      ]),
      paragraph([
        "Consequently, if ",
        math(String.raw`P`),
        " is atoral, then",
      ]),
      displayMath(
        String.raw`\frac{1}{L^{d}}\log\bigl|a^{\mathrm{red}}_L\bigr|\ \longrightarrow\ \log m(P)\qquad(L\to\infty).`,
      ),
    ],
    proof: [
      paragraph([
        "**We do not prove these. Items (i)–(iv) above are known theorems, and this paper merely cites them.** ",
        "The contribution of this paper is confined to identifying, with reference and proposition number, the ",
        "three levels of generality at which the statement holds (expansive / ",
        math(String.raw`\mathsf U`),
        " finite / atoral), and to connecting them with the setting of ",
        ref("paper_def_curve"),
        ".",
      ]),
      paragraph([
        "**A remark on a difference of conventions.** The quantity ",
        math(String.raw`\mathsf P_\Gamma`),
        " treated by Lind–Schmidt–Verbitskiy is the number of periodic components, and it differs from the ",
        math(String.raw`a^{\mathrm{red}}_L`),
        " of the present paper (the product with the zeros on the torus removed) by the factor ",
        math(String.raw`c_\Gamma(f)`),
        ". That paper states this discrepancy explicitly and then observes that, since ",
        math(String.raw`\frac{1}{|\mathbb{Z}^d/\Gamma|}\log c_\Gamma(f)\to0`),
        ", the two agree asymptotically ",
        cite(["LindSchmidtVerbitskiy2013"]),
        ". The display above is to be read in that sense.",
      ]),
    ],
  },
  {
    id: "paper_032_remark_ising_known",
    kind: "remark",
    origin: { path: "structured-latex-en/content/003_archimedean.ts", ordinal: 3 },
    title: { text: "Known results on the statistical-mechanics side" },
    labels: ["paper_remark_ising_known"],
    habitat: "R",
    realEscape:
      "The free energy density is itself a quantity of ℝ. This remark only records where the known results " +
      "are to be found, and no assertion of this paper depends on it.",
    statement: [
      paragraph([
        "That the free energy density of statistical mechanics can be written as a Mahler measure, and that ",
        "for the two-dimensional Ising model the Hasse–Weil ",
        math(String.raw`L`),
        "-function of an elliptic curve appears at special temperatures while a Dirichlet ",
        math(String.raw`L`),
        "-function appears at the critical point, are **known** ",
        "(arXiv:2407.19531 / Phys. Rev. E **110**, 054134 (2024); ",
        cite(["Viswanathan2024"]),
        ").",
      ]),
      paragraph([
        "It is likewise classical that the spanning-tree entropy of the ",
        math(String.raw`\mathbb{Z}^2`),
        " torus converges to ",
        math(String.raw`4G/\pi`),
        ", where ",
        math(String.raw`G`),
        " is Catalan's constant. In this paper we use this **only as a sanity check on the framework**, and ",
        "we claim no connection with any other quantity.",
      ]),
    ],
  },
]);
