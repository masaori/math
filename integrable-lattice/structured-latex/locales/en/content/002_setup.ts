/**
 * Chapter 2: Setting (English version).
 *
 * **正本は日本語版 `../../structured-latex/content/002_setup.ts` である。**
 * このファイルはその英訳であり、ブロック id・ラベル・`habitat`・`verification` / `lean`・
 * **数式**は日本語版と完全に同じ文字列を使う（`tools/verify-ja-en-correspondence.ts` が検査する）。
 * 訳語は `integrable-lattice/docs/paper001-en-glossary.md` を正本とする。
 */

import { defineTranslatedBlocks as defineBlocks, displayMath, math, paragraph, refInTranslation as ref } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "paper_020_heading_setup",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex/locales/en/content/002_setup.ts", ordinal: 1 },
    title: { text: "Setting — integer spectral curves and the number of periodic points" },
    labels: [],
  },
  {
    id: "paper_021_definition_curve",
    kind: "definition",
    origin: { path: "structured-latex/locales/en/content/002_setup.ts", ordinal: 2 },
    title: { text: "Integer spectral curves and the number of periodic points" },
    labels: ["paper_def_curve", "paper_def_aL"],
    habitat: "Z",
    statement: [
      paragraph([
        "Let ",
        math(String.raw`d\ge1`),
        " be an integer, and let ",
        math(String.raw`P\in\mathbb{Z}[z_1^{\pm1},\dots,z_d^{\pm1}]\setminus\{0\}`),
        " be a Laurent polynomial with integer coefficients (an **integer spectral curve**).",
      ]),
      paragraph([
        "For ",
        math(String.raw`L\ge1`),
        " we define the **number of periodic points** and the **reduced number of periodic points** by",
      ]),
      displayMath(
        String.raw`a_L:=\prod_{z_1^{L}=\dots=z_d^{L}=1}P(z_1,\dots,z_d),
\qquad
a^{\mathrm{red}}_L:=\prod_{\substack{z_1^{L}=\dots=z_d^{L}=1\\ P(z)\neq0}}P(z_1,\dots,z_d)`,
      ),
      paragraph([
        "Both are Galois-invariant algebraic integers, and therefore lie in ",
        math(String.raw`\mathbb{Z}`),
        ". The two agree whenever ",
        math(String.raw`P`),
        " has no zero at a tuple of roots of unity.",
      ]),
      paragraph([
        "Multiplication by a monomial leaves ",
        math(String.raw`a_L`),
        " unchanged. Indeed ",
        math(String.raw`\prod_{z_i^L=1}z_i^{a}=\bigl((-1)^{L+1}\bigr)^{aL}`),
        ", and ",
        math(String.raw`L(L+1)`),
        " is even whatever the parity of ",
        math(String.raw`L`),
        ", so the value is ",
        math(String.raw`+1`),
        ". From now on we may therefore assume that ",
        math(String.raw`P\in\mathbb{Z}[z_1,\dots,z_d]`),
        ".",
      ]),
    ],
  },
  {
    id: "paper_022_claim_resultant",
    kind: "claim",
    origin: { path: "structured-latex/locales/en/content/002_setup.ts", ordinal: 3 },
    title: { text: "The number of periodic points is computed exactly by a nested resultant" },
    labels: ["paper_claim_resultant"],
    habitat: "Z",
    verification: [
      "sagemath/check/cycle14_T1_vp_two_var",
      "sagemath/check/cycle15_T1_monsky_shape",
    ],
    statement: [
      paragraph([
        "The quantity ",
        math(String.raw`a_L`),
        " of ",
        ref("paper_def_aL"),
        " can be written as a nested resultant. For ",
        math(String.raw`d=2`),
        ",",
      ]),
      displayMath(
        String.raw`a_L=\mathrm{Res}_{z}\Bigl(z^L-1,\ \mathrm{Res}_{w}\bigl(w^L-1,\ P(z,w)\bigr)\Bigr).`,
      ),
      paragraph([
        "For general ",
        math(String.raw`d`),
        " it suffices to nest the resultant ",
        math(String.raw`d`),
        " times.",
      ]),
    ],
    proof: [
      paragraph([
        "Since ",
        math(String.raw`z^L-1`),
        " and ",
        math(String.raw`w^L-1`),
        " are monic, the leading coefficient in the standard property of the resultant, ",
        math(String.raw`\mathrm{Res}(f,g)=\mathrm{lc}(f)^{\deg g}\prod_{f(\alpha)=0}g(\alpha)`),
        ", satisfies ",
        math(String.raw`\mathrm{lc}(f)=1`),
        ", so that the resultant yields the product over the roots itself. Apply this in ",
        math(String.raw`w`),
        " on the inside and in ",
        math(String.raw`z`),
        " on the outside.",
      ]),
      paragraph([
        "**This expression is a finite computation with integer coefficients.** It uses neither ",
        "ℝ",
        " nor ",
        math(String.raw`\mathbb{Q}_p`),
        ". Consequently, for every finite ",
        math(String.raw`L`),
        ", the quantity ",
        math(String.raw`v_p(a_L)\in\mathbb{Z}_{\ge0}`),
        " is determined by a finite procedure: compute the resultant as an exact integer, and factor it ",
        "into primes.",
      ]),
    ],
  },
  {
    id: "paper_023_definition_massieu",
    kind: "definition",
    origin: { path: "structured-latex/locales/en/content/002_setup.ts", ordinal: 4 },
    title: { text: "The Λ-membership of the Massieu free entropy" },
    labels: ["paper_def_massieu"],
    habitat: "Lambda",
    verification: ["sagemath/check/D_phi_lambda", "sagemath/check/potts_phi"],
    statement: [
      paragraph([
        "Let the partition function of a finite, discrete model be ",
        math(String.raw`Z_N(x)=\sum_m\Omega_N(m)x^m\in\mathbb{Z}[x]`),
        ", where ",
        math(String.raw`\Omega_N(m)\in\mathbb{N}`),
        " is the multiplicity. At a rational point ",
        math(String.raw`q\in\mathbb{Q}_{>0}`),
        " we define the **Massieu free entropy** by",
      ]),
      displayMath(String.raw`\Phi_N:=\log Z_N(q)\in\Lambda`),
      paragraph([
        "The exponent vector of the prime factorisation of ",
        math(String.raw`Z_N(q)\in\mathbb{Q}_{>0}`),
        " is itself an element of ",
        math(String.raw`\Lambda`),
        ", so this definition does not pass through ",
        "ℝ",
        ".",
      ]),
      paragraph([
        "The habitats of the quantities involved are as follows: the multiplicities ",
        math(String.raw`\Omega_N(m)\in\mathbb{N}`),
        ", the partition polynomial ",
        math(String.raw`Z_N\in\mathbb{Z}[x]`),
        ", the Massieu free entropy ",
        math(String.raw`\Phi_N\in\Lambda`),
        ", the transfer matrix ",
        math(String.raw`T(x)\in M_d(\mathbb{Z}[x])`),
        ", and the eigenvalues and the zeros of the partition function ",
        math(String.raw`\in\overline{\mathbb{Q}}`),
        ".",
      ]),
    ],
  },
]);
