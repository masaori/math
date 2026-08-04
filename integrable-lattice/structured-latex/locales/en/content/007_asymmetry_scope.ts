/**
 * Chapter 7 (the asymmetry of decidability) and Chapter 8 (scope, limitations, formal verification),
 * English version.
 *
 * **正本は日本語版 `../../../content/007_asymmetry_scope.ts` である。**
 * ブロック id・`labels`・`habitat`・`realEscape` の有無・**数式**は日本語版と完全に同じ文字列を使う
 * （`tools/verify-localization.ts` の構造照合が検査する）。訳語は
 * `integrable-lattice/docs/paper001-en-glossary.md` を正本とする。
 *
 * 相互参照は 2026-08-01 の校閲ですべて `ref()` へ復元した
 * （`paper_prop_D` / `paper_remark_D_limits` / `paper_prop_F` / `paper_claim_resultant` /
 * `paper_four_axes` / `paper_positioning` / `paper_prop_W`）。
 *
 * `paper_082_remark_formalization` にあったリポジトリ内部のパス
 * （`\texttt{integrable-lattice/lean/README.md}`・`\texttt{verification}`・`\texttt{lean}`・
 * `\texttt{sagemath/tools/verify-check-linkage.ts}`）は、投稿稿にふさわしくないので落とし、
 * 同じ内容を投稿稿の言い方へ置き換えた。数式の多重集合が日本語版とずれるため、
 * このブロックは `locales/en/structure-exceptions.ts` へ理由つきで登録してある。
 */

import { cite, defineTranslatedBlocks as defineBlocks, list, math, paragraph, refInTranslation as ref } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "paper_070_heading_asymmetry",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex/locales/en/content/007_asymmetry_scope.ts", ordinal: 1 },
    title: {
      text: "The asymmetry of decidability — the hard continuous problems occur only on the ℝ side",
    },
    labels: [],
  },
  {
    id: "paper_071_remark_asymmetry",
    kind: "remark",
    origin: { path: "structured-latex/locales/en/content/007_asymmetry_scope.ts", ordinal: 2 },
    title: { text: "The two places are not equally difficult" },
    labels: ["paper_remark_asymmetry"],
    habitat: "mixed",
    realEscape:
      "This remark compares a quantity on the ℝ side (the Mahler measure) with a quantity on the Λ side " +
      "(the Iwasawa μ). ℝ occurs only on the left-hand side of the comparison, and the assertions this " +
      "paper makes on the Λ side do not depend on that comparison.",
    verification: ["sagemath/check/cycle10_T3_lehmer"],
    statement: [
      paragraph([
        "The two places of ",
        ref("paper_prop_D"),
        " arise from one and the same ",
        math(String.raw`P`),
        ", but they are not equally difficult.",
      ]),
      list([
        [
          "The ",
          math(String.raw`\mathbb{R}`),
          " side: the Mahler measure — equivalently the entropy, equivalently the free energy density — ",
          "is an element of ",
          math(String.raw`\mathbb{R}`),
          " and varies continuously. The question of its smallest positive value is Lehmer's problem, a ",
          "continuous gap that has been open since 1933. A general value may even be a non-computable real ",
          "number.",
        ],
        [
          "The ",
          math(String.raw`\Lambda`),
          " side: the Iwasawa-type invariant ",
          math(String.raw`\mu\in\mathbb{Z}_{\ge0}`),
          " is discrete. Its smallest positive value is ",
          math(String.raw`1`),
          ", which is trivial, and no Lehmer-type problem arises. For finite ",
          math(String.raw`L`),
          ", the valuation ",
          math(String.raw`v_p(a_L)`),
          " is decidable unconditionally (",
          ref("paper_claim_resultant"),
          ").",
        ],
      ]),
      paragraph([
        "The assertion: the hard open continuous problems occur only on the ",
        math(String.raw`\mathbb{R}`),
        " side, whereas the ",
        math(String.raw`\Lambda`),
        " side is discrete and decidable. This is a map of which place of the duality each of two known ",
        "theories — Lehmer/Mahler and Iwasawa/Ferrero–Washington ",
        cite(["Lehmer1933", "FerreroWashington1979"]),
        " — sits on. It is not a new theorem.",
      ]),
      paragraph([
        "A caution (we do not call a numerical coincidence of scale a connection): the spanning-tree ",
        "entropy ",
        math(String.raw`4G/\pi\approx1.166`),
        " of the ",
        math(String.raw`\mathbb{Z}^2`),
        " torus and the Lehmer number ",
        math(String.raw`\approx1.176`),
        " are numerically close, but this is a coincidence between quantities of different scales and not a connection. This paper does not connect the two.",
      ]),
    ],
  },
  {
    id: "paper_072_remark_qp_free",
    kind: "remark",
    origin: { path: "structured-latex/locales/en/content/007_asymmetry_scope.ts", ordinal: 3 },
    // 日本語版の表題は「Q_p を避ける動機は…」だが、地の文の "Q_p" は下線が literal に組まれて
    // 投稿稿の見出しとして読めなくなる（生成器が警告を出す）。表題に tex を持たせると日英対応検証の
    // 数式多重集合がずれるため、綴り出した形にした。指す対象は同じ p 進体である。
    title: { text: "The motivation for avoiding the field of p-adic numbers is not undecidability" },
    labels: ["paper_remark_qp_motivation"],
    habitat: "none",
    statement: [
      paragraph([
        "This paper builds its arguments without using ",
        math(String.raw`\mathbb{Q}_p`),
        ", which is uncountable. This motivation must not be misunderstood.",
      ]),
      paragraph([
        "The first-order theory of ",
        math(String.raw`\mathbb{Q}_p`),
        " is decidable in the language of valued fields with a normalised cross-section ",
        "(Ax–Kochen / Ershov) ",
        cite(["AxKochen1966", "Ershov1965"]),
        ". The reason for avoiding ",
        math(String.raw`\mathbb{Q}_p`),
        " is therefore not that the theory of ",
        math(String.raw`\mathbb{Q}_p`),
        " is undecidable.",
      ]),
      paragraph([
        "The motivation of this paper is to come down to the level of finite procedures and witnesses. ",
        "Equality in ",
        math(String.raw`\Lambda`),
        " is agreement of prime factorisations, and equality in ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " is separation of roots; both can be decided with an explicit certificate. ",
        "The result of the prior-art check: the move of handling an uncountable object through a ",
        "countable encoding is itself an established, standard technique. In reverse mathematics, real ",
        "numbers are encoded by rapidly converging Cauchy sequences and complete separable metric spaces ",
        "are treated as the generalisation of that encoding; in constructive algebra there is work that ",
        "constructs the Henselisation without passing through a completion (Alonso García–Lombardi–Perdry ",
        cite(["AlonsoLombardiPerdry2008"]),
        "). The difference in this paper is therefore not that it makes things countable, but the single ",
        "point that it brings equality down to a decidable level — under the encodings of reverse ",
        "mathematics, equality of real numbers and of ",
        math(String.raw`p`),
        "-adic numbers does not become decidable. We could not find, in the literature we searched, work ",
        "treating ",
        math(String.raw`p`),
        "-adic valuations and Iwasawa-type growth laws in this style; we do not take that failure to find as ",
        "grounds for a claim of novelty, since MathSciNet was not used and the searches were not full-text.",
      ]),
    ],
  },
  {
    id: "paper_080_heading_scope",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex/locales/en/content/007_asymmetry_scope.ts", ordinal: 4 },
    title: { text: "Scope, limitations, and formal verification" },
    labels: [],
  },
  {
    id: "paper_081_remark_scope",
    kind: "remark",
    origin: { path: "structured-latex/locales/en/content/007_asymmetry_scope.ts", ordinal: 5 },
    title: { text: "What this paper does not claim" },
    labels: ["paper_remark_scope"],
    habitat: "none",
    statement: [
      paragraph([
        "We restate ",
        ref("paper_positioning"),
        ". This paper is a reframing, and it claims no new theorem. The following makes explicit what ",
        "this paper does not claim.",
      ]),
      list([
        [
          "It claims nothing about solvability. Whether the thermodynamic limit has a closed form is a ",
          "question on the fourth axis, and it is independent of the first and second axes, which are the ",
          "ones this paper treats (",
          ref("paper_four_axes"),
          ").",
        ],
        [
          "It gives no new exact solution. Everything on the archimedean side in Chapter 3 is a citation ",
          "of known theorems.",
        ],
        [
          "It gives no new number theory. Propositions A, B, C, N, L of Chapter 4 are known elementary ",
          "number theory, and the ",
          math(String.raw`(p)`),
          " side of Proposition D in Chapter 5 is an application of theorems of Monsky and of ",
          "Cuoco–Monsky ",
          cite(["Monsky1981", "CuocoMonsky1981"]),
          ".",
        ],
        [
          "It claims no novelty for Propositions T, V, W either. The literature search gave the ",
          "following. Proposition V already appears in the literature for ",
          math(String.raw`d=1`),
          ", as a consequence of the Gauss–Dold congruence ",
          cite(["ByszewskiGraffWard2021"]),
          "; a weak form of Proposition T — that ",
          math(String.raw`v_2`),
          " is even — already appears (Kwon–Mednykh–Mednykh ",
          cite(["MednykhMednykh2019"]),
          "); the shape of Proposition W already appears for ",
          math(String.raw`d=1`),
          " (Vallières ",
          cite(["Vallieres2021"], "Corollary 5.7"),
          "). As for ",
          math(String.raw`\mu_1`),
          " in Proposition W, we have read the text of Monsky in the Open Access version ",
          cite(["Monsky1989"]),
          ". That paper asserts only the existence of the corresponding constant ",
          math(String.raw`\alpha^*`),
          " and, for ",
          math(String.raw`d=2`),
          ", its rationality; it gives no explicit expression (see the prior-art check in the proof of ",
          ref("paper_prop_W"),
          ").",
        ],
      ]),
      paragraph([
        "Two open points remain (they are recorded in ",
        ref("paper_remark_D_limits"),
        "): there is in general no explicit formula for the lower-order terms ",
        math(String.raw`\lambda_i,\mu_i,\nu`),
        " (",
        math(String.raw`i\ge1`),
        "), and there is no closed form for degenerate towers whose vanishing depth satisfies ",
        math(String.raw`\theta(P)\ge\ell+1`),
        ". (The computability of ",
        math(String.raw`\lambda=l_0(f)`),
        ", which used to be listed here as well, has been settled by ",
        ref("paper_prop_F"),
        " — but only in the case of finite support.) Both remaining points are stated explicitly as ",
        "limitations of Proposition D, and both narrow the reach of this paper.",
      ]),
    ],
  },
  {
    id: "paper_082_remark_formalization",
    kind: "remark",
    origin: { path: "structured-latex/locales/en/content/007_asymmetry_scope.ts", ordinal: 6 },
    title: { text: "What the formal verification achieves" },
    labels: ["paper_remark_formalization"],
    habitat: "none",
    statement: [
      paragraph([
        "This paper does not stop at the level demanded by our selection criterion, namely that a statement ",
        "be in principle amenable to ",
        math(String.raw`\mathrm{decide}`),
        " or carried by a witness: we have actually formalised it in Lean 4 with mathlib4. For the ",
        "propositions that have been formalised, freedom from ",
        math(String.raw`\mathrm{sorry}`),
        " has been checked mechanically.",
      ]),
      paragraph([
        "The coverage is not complete. Of the 24 assertions of this paper, 6 have their content ",
        "formalised, 16 are formalised in part, and 2 have not been started. Complete formalisation ",
        "is the goal we work towards, and the table below records which assertions remain and, for ",
        "each of them, what is left (or why it has not been started).",
      ]),
      paragraph([
        "The goal does not range over the assertions this paper makes on its own account alone. ",
        "External theorems that this paper cites without proving are also within the scope of what ",
        "we undertake to prove. To keep that scope from growing without bound, we draw the line by ",
        "three tests: whether the theorem is cited as a ground of one of our proofs, whether its ",
        "content lies on the countable side, and whether it is already available in mathlib. ",
        "Applying that line leaves 7 external theorems that we have undertaken to prove, none of ",
        "which is complete. Two further external theorems, whose substance is analysis on the real ",
        "side, we do not prove: we isolate them as points of escape, and in each case we record the ",
        "grounds on which the countable-side assertions do not depend on them.",
      ]),
      paragraph([
        "The current state of the formalisation — what is complete, what is partial, what has not been started, and the reason in each case — is recorded in a table in the accompanying Lean development. ",
        "For the propositions we could not formalise, we make concrete, from primary evidence (the code ",
        "we tried and the error output), what is missing in mathlib or at which step we got stuck. We never ",
        "record “it looks hard” as a reason.",
      ]),
      paragraph([
        "Each statement in this paper carries, alongside its habitat, a list of the numerical checks (in SageMath) ",
        "and of the Lean theorems that correspond to it. These two correspondences are not prose promises: ",
        "they are recorded in machine-readable form with the statement, and a checker verifies that every ",
        "name listed still exists and that no check has been orphaned.",
      ]),
    ],
  },
]);
