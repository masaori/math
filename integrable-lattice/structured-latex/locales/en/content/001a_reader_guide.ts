/**
 * 第 1 章の末尾: Survey Article としての枠づけ（**英語版限定**）。
 *
 * ## なぜこのブロック群が要るのか
 *
 * 投稿先調査 `../../outputs/reports/paper001_submission_venue_survey.md` §3.1 が、
 * Expositiones Mathematicae の Survey Article へ出すうえでの**唯一の構造的な弱点**として
 * 次を挙げている（同誌公式サイトの記事種別定義を一次情報として）:
 *
 *   > Survey Article の種別の想定は「その領域の概観」であり、論文 001 は概観ではなく
 *   > **特定の辞書と命題群**なので、**序論で**「何を概観として与えるか」を書き足す必要がある。
 *
 * ここはその書き足しである。**新しい数学的主張は 1 つも足していない。**
 * 書いてあるのは、日本語版の本文とリポジトリ内の一次情報から確認できることの整理だけである。
 *
 * ## なぜファイル名が `000_...` ではなく `001a_...` なのか（重要）
 *
 * 当初の指示はこの内容を `content/000_reader_guide.ts` へ置くことだった。**そうしていない。**
 * 理由は、そうすると**本文中の章番号がすべて 1 つずれて誤りになる**ためである。
 *
 *   - `content/` は**ファイル名の昇順が文書順**であり（システムの `listSourceFiles` は素の `.sort()`）、
 *     生成器は `level: 1` の見出しを `\section` に落とす（`tools/build-latex.ts`）。
 *   - したがって `000_...` に `level: 1` の見出しを置くと、序論が第 2 章へ、以降がすべて 1 つ後ろへずれる。
 *   - ところが本文は章番号を**地の文の literal** で書いている（英訳済みの `001_intro.ts` が
 *     "Chapters 3 and 5 identify the sources", "Propositions A, B, C, N, L of Chapter 4",
 *     "organised in Chapter 7", "(Chapter 8)" と書いている。日本語版も「第 3 章」等）。
 *     章がずれると、これらが**全部** 1 つずつ誤りになる。
 *
 * そこで**新しい `level: 1` 見出しを作らず**、ファイル名を `001_intro.ts` と `002_setup.ts` の間に
 * 挿さる `001a_...` にして、ブロックを**第 1 章（序論）の末尾**へ置いた。章番号は 1 つも動かない。
 * これは投稿先調査が「**序論で**書き足す必要がある」と書いていることとも一致する。
 * （`'_'` = 0x5F < `'a'` = 0x61 なので、`001_intro.ts` < `001a_reader_guide.ts` < `002_setup.ts`。）
 *
 * 章番号を動かさずに済むので、後ろに足す章（`008_theta_padic.ts` = 第 9 章、
 * `009_prior_art.ts` = 第 10 章）だけが新しい章になる。
 *
 * ## 2026-08-01 の校閲で直したこと（数学レビューの指摘。いずれも正しさの問題である）
 *
 * - 【致命】`paper_014_remark_survey_scope` が「Λ 側の**すべての**命題に決定手続きがある」と
 *   全称で書いていた。本論文自身が反例を持つ（命題 F (F2) は決定不能、命題 D の低位項に明示式が無い、
 *   命題 W の ν は有理数であって整数ではない）。**限定列挙へ戻し、決定不能な 2 箇所を明示した。**
 * - 【重要】`paper_015_remark_reading_guide` の前提知識の一覧が、本文が実際に使う道具と
 *   合っていなかった。引用として使う結果（黒箱）と、1 命題だけで使う道具（差積・停止問題・
 *   Newton 多面体）を分けて書き直した。
 * - 【重要】「岩澤理論を引くのは第 3 章と第 5 章」は事実誤り（第 3 章は力学系、第 6 章が抜けていた）。
 *   **第 5 章と第 6 章**へ直した。
 */

import { cite, defineTranslatedBlocks as defineBlocks, list, math, paragraph, refInTranslation as ref } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "paper_014_remark_survey_scope",
    kind: "remark",
    origin: { path: "structured-latex/locales/en/content/001a_reader_guide.ts", ordinal: 1 },
    title: { text: "What this survey surveys" },
    labels: ["paper_survey_scope"],
    habitat: "mixed",
    realEscape:
      "This block describes which literatures the survey places side by side, and ℝ appears in it only as " +
      "the name of one of the two sides. No element of ℝ is constructed and no argument is carried out " +
      "over ℝ here. The only place where this paper genuinely uses ℝ is the single limit in which L tends to infinity in Chapter 3.",
    statement: [
      paragraph([
        "A survey is expected to give an overview of an area. It is worth saying at the outset what is ",
        "being given an overview of here, because it is not a single area.",
      ]),
      paragraph([
        "One and the same integer spectral curve ",
        math(String.raw`P`),
        " feeds two bodies of literature that are written by different communities and cite each other ",
        "rarely.",
      ]),
      list([
        [
          "**At the archimedean place**, ",
          math(String.raw`P`),
          " produces its Mahler measure. This is the entropy of the associated algebraic ",
          math(String.raw`\mathbb{Z}^d`),
          "-action ",
          cite(["LindSchmidtWard1990", "LindSchmidtVerbitskiy2013"]),
          ", and it is the free energy density of an associated lattice model ",
          cite(["Viswanathan2024"]),
          ". Its smallest positive value is the subject of Lehmer's problem ",
          cite(["Lehmer1933"]),
          ", open since 1933.",
        ],
        [
          "**At the non-archimedean places**, at each prime ",
          math(String.raw`p`),
          ", the same ",
          math(String.raw`P`),
          " produces the prime factorisation of the number of periodic points. Along a tower of graphs ",
          "this quantity is a number of spanning trees, and its growth obeys an Iwasawa-type asymptotic ",
          "formula ",
          cite(["Vallieres2021", "DuBoseVallieres2023", "Kataoka2026"]),
          ", governed by the same module theory that governs class numbers in ",
          math(String.raw`\mathbb{Z}_p^d`),
          "-extensions ",
          cite(["CuocoMonsky1981", "Monsky1989"]),
          ".",
        ],
      ]),
      paragraph([
        "**What this survey gives an overview of is these two literatures laid side by side along one axis: decidability.**",
        " The axis is not decoration. It separates them cleanly: on the archimedean ",
        "side the central quantity is a real number and the central open problem is a continuous gap, ",
        "while on the ",
        math(String.raw`\Lambda`),
        " side the quantities are discrete — integers, elements of ",
        math(String.raw`\Lambda`),
        ", rational numbers, or algebraic numbers — and a family of the statements about them comes with ",
        "an explicit decision procedure and a witness (Propositions A, B, C, N, L of Chapter 4 and ",
        "Propositions T, V, W of Chapter 6). **The countable side is not uniformly decidable**, and ",
        "Chapter 5 marks the two places where it is not: the predicate of Proposition F (F2) is ",
        "undecidable for ",
        math(String.raw`d\ge2`),
        ", and the lower-order coefficients of Proposition D admit no explicit formula. Chapter 7 states ",
        "the asymmetry that results.",
      ]),
      paragraph([
        "The four items this paper supplies, listed in ",
        ref("paper_positioning"),
        ", are what the two sides look like once they are put in this single frame. ",
        "**They are a rearrangement of known mathematics, not new theorems.** Chapter 12 says, ",
        "proposition by proposition, what is already in the literature and what was not found there.",
      ]),
    ],
  },
  {
    id: "paper_015_remark_reading_guide",
    kind: "remark",
    origin: { path: "structured-latex/locales/en/content/001a_reader_guide.ts", ordinal: 2 },
    title: { text: "How to read this survey, and what is not assumed" },
    labels: ["paper_reading_guide"],
    habitat: "mixed",
    realEscape:
      "This block names ℝ twice: once to say that Chapter 3 is the only chapter that uses it, and once to " +
      "describe the “escape to ℝ” label carried by the propositions. Both are mentions of ℝ as the name of " +
      "a set, not uses of it; no element of ℝ is constructed here and no argument is carried out over ℝ.",
    statement: [
      paragraph([
        "**What the reader is assumed to know.** The backbone is undergraduate algebra: finite fields, ",
        "the resultant of two polynomials, the Smith normal form of an integer matrix, the linear ",
        "independence of characters, and the Newton polygon of a polynomial over a valued field. Each of ",
        "these is used concretely and is recalled where it is first needed.",
      ]),
      paragraph([
        "**What is quoted rather than proved.** Three bodies of results are used as black boxes, always ",
        "with a reference and a proposition number: the topological entropy of an algebraic ",
        math(String.raw`\mathbb{Z}^d`),
        "-action (Chapter 3), the theorems of Monsky and of Cuoco–Monsky on Iwasawa modules over ",
        math(String.raw`\mathbb{Z}_p[[\Gamma]]`),
        " (Chapter 5), and the asymptotic formulae for towers of graphs (Chapters 5 and 6). A reader who ",
        "takes these on trust can follow every argument that this paper carries out itself.",
      ]),
      paragraph([
        "**Three isolated points go further, and each is confined to one statement.** Chapter 4 uses the ",
        "different and the ramification data of a number field, in Proposition W* alone; Chapter 5 uses ",
        "the halting problem, in part (F2) of Proposition F alone; and Chapter 5 uses Newton polytopes ",
        "and their Minkowski decomposition, in Proposition G' alone. Nothing later depends on any of the ",
        "three.",
      ]),
      paragraph([
        "**What the reader is not assumed to know.** Neither ",
        math(String.raw`p`),
        "-adic analysis nor Iwasawa theory is a prerequisite. This is not a courtesy to the reader but a ",
        "property of the argument: the ",
        math(String.raw`\Lambda`),
        "-side statements of this paper do not use ",
        math(String.raw`\mathbb{Q}_p`),
        " at all, which is precisely contribution (b). Where results from Iwasawa theory are quoted — in ",
        "Chapters 5 and 6 — they are quoted as known theorems, with reference and proposition number, and ",
        "are not reproved.",
      ]),
      paragraph([
        "**Where the real numbers are used.** Exactly one chapter uses ",
        math(String.raw`\mathbb{R}`),
        ": Chapter 3, and there it is the single limit ",
        math(String.raw`L\to\infty`),
        ". Every other chapter closes on the countable side. This is not an incidental remark about ",
        "style; separating the two is the organising principle of the paper.",
      ]),
      paragraph([
        "**The two labels attached to every proposition.** Each statement below carries a declared ",
        "habitat — the set its quantities live in, one of ",
        math(String.raw`\mathbb{N},\mathbb{Z},\mathbb{Q},\Lambda,\overline{\mathbb{Q}},\mathbb{R},\mathbb{C}`),
        " — and, whenever that habitat is uncountable, an explicit escape to ",
        math(String.raw`\mathbb{R}`),
        " recording what forced the argument out of the countable world. Reading only these two labels ",
        "down the length of the paper already gives the map that the paper is about.",
      ]),
      paragraph([
        "**The route through the chapters.** Chapter 2 fixes the integer spectral curve and the counting ",
        "quantities. Chapter 3 is the archimedean side and is entirely quotation of known results. ",
        "Chapter 4 develops the finite, decidable face of the ",
        math(String.raw`\Lambda`),
        " side. Chapter 5 is the dictionary itself, which is the centre of the paper. Chapter 6 gives ",
        "three propositions with explicit decision procedures. Chapter 7 draws the asymmetry, Chapter 8 ",
        "states what the paper does not claim and what the formalisation in Lean does and does not cover, ",
        "Chapter 9 refines the vanishing depth of Chapter 5 over the ",
        math(String.raw`\ell`),
        "-adic points, Chapters 10 and 11 close two gaps that the refinement leaves open — a decision ",
        "procedure for the points of infinite vanishing depth, and a recursion which shows that the ",
        "cancellation feared there cannot occur — ",
        "and Chapter 12 sets the propositions against the literature. A reader who wants only the dictionary ",
        "can read Chapters 2, 5 and 7.",
      ]),
    ],
  },
]);
