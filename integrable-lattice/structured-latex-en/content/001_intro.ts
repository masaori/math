/**
 * Chapter 1: Introduction (English version).
 *
 * **正本は日本語版 `../../structured-latex/content/001_intro.ts` である。**
 * このファイルはその英訳であり、ブロック id・ラベル・`habitat`・`verification` / `lean` は
 * **日本語版と完全に同じ文字列**を使う（`tools/verify-ja-en-correspondence.ts` がこれを検査する）。
 * 訳語は `integrable-lattice/docs/paper001-en-glossary.md` を正本とする。
 *
 * **現状は 2 ブロックだけである。** 残り 31 ブロックは後続の翻訳担当が足す
 * （足すまで `npm run verify:correspondence` は欠落として失敗する。それが正しい状態である）。
 */

import { defineBlocks, list, math, paragraph } from "../schema.ts";

export default defineBlocks([
  {
    id: "paper_010_heading_intro",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex-en/content/001_intro.ts", ordinal: 1 },
    title: {
      text: "Introduction — the two places of an integer spectral curve, and decidability on the Λ side",
    },
    labels: [],
  },
  {
    id: "paper_011_remark_positioning",
    kind: "remark",
    origin: { path: "structured-latex-en/content/001_intro.ts", ordinal: 2 },
    title: { text: "What this paper is (stated up front)" },
    labels: ["paper_positioning"],
    habitat: "mixed",
    realEscape:
      "This block is a statement of positioning. ℝ occurs here only as a name, inside the description of " +
      "contribution (d), namely that Lehmer's problem is specific to the ℝ side. No element of ℝ is " +
      "constructed and no argument is carried out over ℝ. The only place where this paper genuinely uses " +
      "ℝ is the single limit L → ∞ in Chapter 3.",
    statement: [
      paragraph([
        "This paper is a **reframing** of known mathematics. It claims no new theorem, no new exact ",
        "solution, and no new deep number theory. All of the mathematical content is known, and Chapters 3 ",
        "and 5 identify the sources by name of reference and number of proposition.",
      ]),
      paragraph(["What this paper does provide is exactly the following four items."]),
      list([
        [
          "**(a) A dictionary between the two places**: for one and the same integer spectral curve ",
          math(String.raw`P`),
          ", we place side by side the quantity at the archimedean place (the free energy density, that is, ",
          "the Mahler measure) and the quantities at each ",
          math(String.raw`p`),
          "-adic place (the prime factorisation structure of the finite-size Massieu free entropy), and give ",
          "an explicit dictionary relating them to the quantities of statistical mechanics.",
        ],
        [
          "**(b) A sharpening of the countabilisation**: the precise statement that the ",
          math(String.raw`\Lambda`),
          " side does **not** require ",
          math(String.raw`\mathbb{Q}_p`),
          " (which is uncountable).",
        ],
        [
          "**(c) A determination of a family of decidable propositions**: we pin down the finite, elementary, ",
          "decidable face of the ",
          math(String.raw`\Lambda`),
          " side as propositions that come with an explicit decision procedure and a witness ",
          "(Propositions A, B, C, N, L of Chapter 4, and Propositions T, V, W of Chapter 6).",
        ],
        [
          "**(d) A map of the asymmetry of decidability**: the observation, organised in Chapter 7, that ",
          "Lehmer's problem is specific to the ",
          math(String.raw`\mathbb{R}`),
          " side, and that no corresponding open continuous gap exists on the ",
          math(String.raw`\Lambda`),
          " side.",
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
]);
