/**
 * Chapter 1: Introduction (English version).
 *
 * **正本は日本語版 `../../../content/001_intro.ts` である。**
 * このファイルはその英訳であり、ブロック id・ラベル・`habitat`・`verification` / `lean` は
 * **日本語版と完全に同じ文字列**を使う（`tools/verify-localization.ts` の構造照合がこれを検査する）。
 * 訳語は `integrable-lattice/docs/paper001-en-glossary.md` を正本とする。
 *
 * **英訳は全ブロック揃っている**（cycle 24 step 2 時点。欠落があれば
 * `npm run verify:localization` が構造照合で落とす）。
 */

import { defineTranslatedBlocks as defineBlocks, displayMath, list, math, paragraph, refInTranslation as ref } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "paper_010_heading_intro",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex/locales/en/content/001_intro.ts", ordinal: 1 },
    title: { text: "Introduction" },
    labels: [],
  },
  {
    id: "paper_011_remark_positioning",
    kind: "remark",
    origin: { path: "structured-latex/locales/en/content/001_intro.ts", ordinal: 2 },
    title: { text: "What this paper is" },
    labels: ["paper_positioning"],
    habitat: "mixed",
    realEscape:
      "This block is a statement of positioning. The real side occurs here only as a turn of phrase, in " +
      "contributions (a) and (d). No element of ℝ is " +
      "constructed and no argument is carried out over ℝ. The only place where this paper genuinely uses " +
      "ℝ is the single limit in which L tends to infinity in Chapter 3.",
    statement: [
      paragraph([
        "This paper is a reframing of known mathematics. It claims no new theorem, no new exact ",
        "solution, and no new deep number theory. All of the mathematical content is known, and Chapters 3 ",
        "and 5 identify the sources by name of reference and number of proposition.",
      ]),
      paragraph([
        "What this paper does provide is exactly the following four items. The terms and symbols are ",
        "introduced in order in Chapters 1 to 3.",
      ]),
      list([
        [
          "(a) A dictionary between the two places: for one and the same polynomial with integer ",
          "coefficients ",
          math(String.raw`P`),
          ", we place side by side the quantity determined on the real side and the quantities determined ",
          "on the valuation side at each prime ",
          math(String.raw`p`),
          ", and give an explicit dictionary relating them to the quantities of statistical mechanics.",
        ],
        [
          "(b) A sharpening of the countabilisation: the precise statement that the valuation side does ",
          "not require the uncountable field ",
          math(String.raw`\mathbb{Q}_p`),
          ".",
        ],
        [
          "(c) A determination of a family of propositions that can be settled: we pin down the finite, ",
          "elementary face of the valuation side as propositions that come with a procedure terminating ",
          "in finitely many steps and with explicit evidence for the answer ",
          "(Propositions A, B, C, N, L of Chapter 4, and Propositions T, V, W of Chapter 6).",
        ],
        [
          "(d) A map of the asymmetry in difficulty: the observation, organised in Chapter 7, that an open ",
          "problem specific to the real side exists (Lehmer's problem), while no corresponding continuous ",
          "gap exists on the valuation side.",
        ],
      ]),
      paragraph([
        "Each of (a)–(d) is a rearrangement, a restatement, or a countabilisation of known theorems; none of ",
        "them is a mathematical novelty. Part of what this paper asserts has been formalised in Lean 4 with ",
        "mathlib4, and freedom from ",
        math(String.raw`\mathrm{sorry}`),
        " has been checked mechanically (Chapter 8).",
      ]),
    ],
  },
  {
    id: "paper_012_definition_ladder",
    kind: "definition",
    origin: { path: "structured-latex/locales/en/content/001_intro.ts", ordinal: 3 },
    title: { text: "The ladder of decidability" },
    labels: ["paper_def_ladder"],
    habitat: "mixed",
    realEscape:
      "This definition includes ℝ/ℂ as the topmost rung of the ladder. ℝ/ℂ occur here only in order to be " +
      "named as the undecidable rung; the only place where the assertions of this paper genuinely use ℝ is " +
      "the archimedean limit of Chapter 3, in which L tends to infinity, and nowhere else.",
    statement: [
      paragraph(["We fix the hierarchy of sets used in this paper as follows."]),
      displayMath(
        String.raw`\underbrace{\mathbb{N}\subset\mathbb{Z}\subset\mathbb{Q}\subset\Lambda\subset\overline{\mathbb{Q}}}_{\text{decidable unconditionally}}
\ \subset\ \underbrace{\overline{\mathbb{Q}}(\ell_p)\ \text{non-linear part}}_{\text{decidable under Schanuel}}
\ \subset\ \underbrace{\mathbb{R}/\mathbb{C}}_{\text{undecidable}}`,
      ),
      paragraph([
        "Here ",
        math(String.raw`\Lambda=\bigoplus_{p}\mathbb{Z}\,\ell_p`),
        " is the free abelian group indexed by the primes (the logarithmic ordered group), and ",
        math(String.raw`\ell_p`),
        " is a formal symbol. For a positive rational number ",
        math(String.raw`q=\prod_p p^{e_p}`),
        " we set ",
        math(String.raw`\log q:=\sum_p e_p\,\ell_p\in\Lambda`),
        ".",
      ]),
      paragraph([
        "In ",
        math(String.raw`\Lambda`),
        ", equality is agreement of prime factorisations, and the order is integer comparison of exponent vectors; ",
        "both are settled by a finite procedure. Equality and order in ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " are settled by minimal polynomials and separation of roots. Neither passes through ",
        math(String.raw`\mathbb{R}`),
        ".",
      ]),
      paragraph([
        "This paper uses ",
        math(String.raw`\mathbb{R}`),
        " at the single point in Chapter 3, and nowhere else. Every other assertion stays on the countable ",
        "side displayed above.",
      ]),
    ],
  },
  {
    id: "paper_013_remark_four_axes",
    kind: "remark",
    origin: { path: "structured-latex/locales/en/content/001_intro.ts", ordinal: 4 },
    title: {
      text: "The four axes (membership, computability, complexity, solvability), and what must not be confused",
    },
    labels: ["paper_four_axes"],
    habitat: "none",
    statement: [
      paragraph([
        "The ladder of ",
        ref("paper_def_ladder"),
        " deals with the first of the following four axes only. We say so explicitly, to forestall a ",
        "confusion.",
      ]),
      list([
        [
          "Axis 1 (membership): which set the quantity under study lives in. A finite, discrete quantity ",
          "lives on the countable side.",
        ],
        [
          "Axis 2 (computability): a finite, discrete quantity is always computable (enumeration ",
          "terminates). This axis is trivial in that it does not distinguish one model from another.",
        ],
        [
          "Axis 3 (complexity): whether the finite-size quantity is polynomial-time or #P-hard.",
        ],
        [
          "Axis 4 (solvability): whether the thermodynamic limit admits a closed form. This is ",
          "independent of Axis 3, and comes from other structures such as duality, the Yang–Baxter ",
          "equation, or free fermions.",
        ],
      ]),
      paragraph([
        "Axes 1 and 2 imply nothing whatsoever about Axis 4. That a finite-size quantity lives on the ",
        "countable side and is decidable shows nothing at all about whether the limit has a closed form. ",
        "This paper is a paper about Axis 1 (and part of Axis 2); it claims nothing about solvability.",
      ]),
    ],
  },
]);
