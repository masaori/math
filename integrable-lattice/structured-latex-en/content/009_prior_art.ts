/**
 * 第 10 章: 先行研究との関係（**英語版限定**）。
 *
 * ## なぜ英語版だけに要るのか
 *
 * 日本語版では既出性の記述が**各命題の proof の中に散らばっている**
 * （`../../structured-latex/content/006_propositions_TVW.ts` の命題 V・T・W の証明末尾、
 * `007_asymmetry_scope.ts` の `paper_remark_qp_motivation` と `paper_remark_scope`、
 * `005_duality.ts` の命題 G の適用例）。読み進めれば全部書いてあるが、**1 箇所にまとまっていない。**
 * 投稿稿で査読者が最初に見るのは「この論文は何が既出で何が違うのか」であり、
 * それが 14 ページに散っていると、**正直に書いてあるのに読み取ってもらえない**。
 * この章はその情報を 1 箇所へ集めたものである。
 *
 * ## この章が守っていること
 *
 * - **主張を強めない。** 元の記述より強い言い方（"new"、"first"、"we could not find" を超える含意）を
 *   一切足していない。「調べた範囲では見つからなかった」は "we did not find" のままである。
 * - **caveat を落とさない。** 調査手段の限界（MathSciNet 未使用、arXiv 検索は abstract 検索であって
 *   本文検索ではない）を最後の節で明示する。**0 件を新規性の根拠にしない**という本論文自身の
 *   方針（命題 C の注記）と整合させる。
 * - **cycle 18 の判定が最新である。** cycle 17 の「Monsky 1989 は未取得」は
 *   `../../outputs/reports/cycle18_T1_monsky1989_acquisition.md` で解消済みであり、
 *   ここには**入手して読んだ結果**を書く。
 *
 * 一次情報:
 *   `../../outputs/reports/cycle17_T1_prior_art_check.md` §0 の結論サマリと §7 の敵対的レビュー
 *   `../../outputs/reports/cycle18_T1_monsky1989_acquisition.md` §0・§2・§3
 *   `../../docs/tasks/auto-loop-state.md` の「cycle 18 総括」
 *   日本語版本文の既出性の記述（上記）
 *
 * ## `ref()` を使っていない理由
 *
 * 本文からは命題 V・T・W・D を指したいが、**それらのラベルは他の担当が翻訳を終えるまで
 * 英語版に存在せず、存在しないラベルへの `ref()` は型検査で落ちる。**
 * したがって安全側に倒して地の文で "Proposition V" 等と書いてある。
 * **翻訳が全部揃ったら `ref("paper_prop_V")` 等へ置き換えてよい**（呼び出し元の判断）。
 * 唯一 `paper_positioning` だけは既に英語版に存在するので `ref()` で指している。
 */

import { cite, defineBlocks, list, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "paper_100_heading_prior_art",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex-en/content/009_prior_art.ts", ordinal: 1 },
    title: { text: "Relation to the literature — what is already known, and what we did not find" },
    labels: [],
  },
  {
    id: "paper_101_remark_prior_art_overall",
    kind: "remark",
    origin: { path: "structured-latex-en/content/009_prior_art.ts", ordinal: 2 },
    title: { text: "The overall verdict: broadly known" },
    labels: ["paper_prior_art_overall"],
    habitat: "none",
    statement: [
      paragraph([
        ref("paper_positioning"),
        " states that this paper claims no novelty. That statement is not modesty, and this chapter is ",
        "where it is made precise. The results of the prior-art check are collected here rather than left ",
        "distributed over the proofs, so that a reader can see the whole of it at once.",
      ]),
      paragraph([
        "**The overall verdict is that the content of this paper is broadly known.** Below, each ",
        "contribution and each of the three propositions of Chapter 6 is set against what the literature ",
        "already contains. In every case we state what is known, and we state the difference — where there ",
        "is one — without claiming that the difference is new.",
      ]),
    ],
  },
  {
    id: "paper_102_remark_prior_art_countabilisation",
    kind: "remark",
    origin: { path: "structured-latex-en/content/009_prior_art.ts", ordinal: 3 },
    title: { text: "Contribution (b), the countabilisation: the move itself is a standard device" },
    labels: ["paper_prior_art_countabilisation"],
    habitat: "none",
    statement: [
      paragraph([
        "**Contribution (b) must not be read as the idea of replacing an uncountable object by a countable code. That idea is standard and long established.**",
      ]),
      list([
        [
          "In reverse mathematics, everything treated in second-order arithmetic is either countable or ",
          "carried by a countable code: a real number is coded by a rapidly converging Cauchy sequence, and ",
          "a complete separable metric space is handled as the generalisation of that device. Since ",
          math(String.raw`\mathbb{Q}_p`),
          " is a complete separable metric space, it already falls inside that framework.",
        ],
        [
          "In constructive algebra there is a programme of dispensing with completion as an ideal object. ",
          "Alonso García, Lombardi and Perdry ",
          cite(["AlonsoLombardiPerdry2008"]),
          " give an elementary theory of Henselian local rings and construct the Henselisation without ",
          "passing through a completion. Haskell ",
          cite(["Haskell1992"]),
          " treats ",
          math(String.raw`p`),
          "-adic algebra constructively (we have not read this paper; we know it from its review only).",
        ],
      ]),
      paragraph([
        "**The difference this paper offers is therefore one single point, and it is not countability.** ",
        "In the reverse-mathematics coding, equality of real numbers and of ",
        math(String.raw`p`),
        "-adic numbers does **not** become decidable. On the ",
        math(String.raw`\Lambda`),
        " side used here, equality is agreement of prime factorisations, and in ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " it is separation of roots; both are decided by a finite procedure. The move that matters is thus ",
        "**not that the objects were made countable, but that equality was brought down to a decidable level.**",
      ]),
      paragraph([
        "We did not find literature treating ",
        math(String.raw`p`),
        "-adic valuations or Iwasawa-type growth laws in this style. We do not conclude from this that ",
        "none exists; see the final block of this chapter.",
      ]),
      paragraph([
        "It should also be recorded that the motivation here is **not** undecidability of ",
        math(String.raw`\mathbb{Q}_p`),
        ". The first-order theory of ",
        math(String.raw`\mathbb{Q}_p`),
        " is decidable ",
        cite(["AxKochen1966", "Ershov1965"]),
        ". The motivation is to descend to the level of finite procedures and witnesses.",
      ]),
    ],
  },
  {
    id: "paper_103_remark_prior_art_propositions",
    kind: "remark",
    origin: { path: "structured-latex-en/content/009_prior_art.ts", ordinal: 4 },
    title: { text: "Propositions V, T and W against the literature" },
    labels: ["paper_prior_art_propositions"],
    habitat: "none",
    statement: [
      paragraph([
        "The three propositions of Chapter 6 stand in three different relations to what is known. ",
        "The proofs in Chapter 6 carry the same information; it is repeated here in one place.",
      ]),
      list([
        [
          "**Proposition V is known in the one-variable case.** For ",
          math(String.raw`d=1`),
          ", the sequence counting periodic points is a Dold sequence, and the Gauss congruence built ",
          "into the definition of such a sequence gives ",
          math(String.raw`a_p\equiv a_1\pmod p`),
          " directly ",
          cite(["ByszewskiGraffWard2021"], "Definition 2.1"),
          "; iterating over ",
          math(String.raw`n=p^k`),
          " yields the statement. On the number-theoretic side the corresponding fact — that ",
          math(String.raw`p\nmid h_0`),
          " implies ",
          math(String.raw`p\nmid h_n`),
          " throughout a ",
          math(String.raw`\mathbb{Z}_p`),
          "-extension — is classical. **The difference here is confined to one point**: the argument given ",
          "below allows ",
          math(String.raw`a_L=0`),
          " and is unconditional for arbitrary ",
          math(String.raw`d`),
          ", whereas the route through Dold sequences requires the dynamical interpretation and hence ",
          math(String.raw`a_L\neq0`),
          ". We did not find the multivariate resultant form in the literature; the proof is elementary ",
          "enough that it may well be folklore.",
        ],
        [
          "**A weaker form of Proposition T is known.** Kwon, Mednykh and Mednykh ",
          cite(["MednykhMednykh2019"], "Theorem 5.1"),
          " show, for the circulant foliation over a graph, that for odd ",
          math(String.raw`n`),
          " the number of spanning trees factors as ",
          math(String.raw`n\,\tau(H)\,a(n)^2`),
          "; their §7.6 treats the discrete torus ",
          math(String.raw`C_L\times C_L`),
          " explicitly as an instance, giving ",
          math(String.raw`\tau(L)=L^2a(L)^2`),
          " and hence that ",
          math(String.raw`v_2(\tau(L))`),
          " **is even**. We read this in the original. Proposition T is a strengthening: it fixes the value ",
          "at ",
          math(String.raw`2(L-1)`),
          ". **We did not find the equality itself in the literature.** The two proofs proceed by different ",
          "mechanisms — unramifiedness, Hensel lifting and the Newton polygon here, versus squareness via ",
          "an involution on Galois conjugates there — so Proposition T does not follow from theirs.",
        ],
        [
          "**The shape of Proposition W is known in the one-variable case.** For ",
          math(String.raw`d=1`),
          ", Vallières ",
          cite(["Vallieres2021"], "Corollary 5.7"),
          " shows that a finitely checkable non-degeneracy condition on the low-order coefficients forces a ",
          "closed form; the pattern of argument is the same, and Proposition W is its ",
          math(String.raw`d=2`),
          " counterpart. The explicit coefficient is a different matter, and is treated in the next ",
          "paragraph.",
        ],
      ]),
      paragraph([
        "**The explicit low-order coefficient of Proposition W.** Three facts fix the position of ",
        math(String.raw`\mu_1`),
        ", all checked in the originals. ",
        "First, Kataoka ",
        cite(["Kataoka2026"]),
        " writes in §4.3 that identifying ",
        math(String.raw`\lambda_1,\mu_1,\nu`),
        " would require a more detailed analysis, which that paper does not pursue. ",
        "Second, DuBose and Vallières ",
        cite(["DuBoseVallieres2023"]),
        " obtain the corresponding coefficients in §7 by solving a linear system fitted to five ",
        "consecutive layers, and state themselves that they have not tried to prove that these are the ",
        "Greenberg coefficients — that is, it is a fit and not a proof. ",
        "Third, and this is the one that had to be settled before submission, Monsky ",
        cite(["Monsky1989"]),
        " **was obtained and read** (the Project Euclid copy is Open Access; an earlier check had ",
        "misdiagnosed a bot-blocking page as a subscription wall). Its Theorem 3.13 gives ",
        math(String.raw`e_n=(m_0p^n+\ell_0n+\alpha^*)p^{(d-1)n}+O(np^{(d-2)n})`),
        ", but asserts about ",
        math(String.raw`\alpha^*`),
        " — the constant occupying the position of our ",
        math(String.raw`\mu_1`),
        " — only its **existence, together with its rationality in the case** ",
        math(String.raw`d=2`),
        ". Monsky writes in the introduction that there is no easy description of ",
        math(String.raw`\alpha^*`),
        " and that it is not known whether it is always rational; the only coefficients identified ",
        "explicitly there are those of ",
        math(String.raw`p^{dn}`),
        " and ",
        math(String.raw`np^{(d-1)n}`),
        " (Theorem 1.20). The same reading is confirmed independently by Tateno and Ueki ",
        cite(["TatenoUeki2025"], "Theorem 2.3"),
        ", who quote Monsky's theorem and likewise record only existence and rationality for ",
        math(String.raw`d=2`),
        ".",
      ]),
      paragraph([
        "**The resulting position is therefore modest and should be stated as such.** Against Monsky's ",
        "general theorem, which guarantees that the constant is a rational number when ",
        math(String.raw`d=2`),
        ", this paper exhibits, for one family, the value of that rational number. It is also worth ",
        "keeping the two objects apart: Monsky's statement concerns ",
        math(String.raw`p`),
        "-adic valuations of class numbers of number fields, whereas Proposition W concerns numbers of ",
        "spanning trees of graph towers, and **Monsky's theorem must not be quoted as a statement on the graph side.**",
        " The general asymptotic on the graph side is Kataoka's ",
        cite(["Kataoka2026"], "Theorem 1.1"),
        ".",
      ]),
    ],
  },
  {
    id: "paper_104_remark_prior_art_limits",
    kind: "remark",
    origin: { path: "structured-latex-en/content/009_prior_art.ts", ordinal: 5 },
    title: { text: "The limits of this search, and why nothing is inferred from a count of zero" },
    labels: ["paper_prior_art_limits"],
    habitat: "none",
    statement: [
      paragraph([
        "**Every statement above of the form “we did not find” means exactly that, and nothing stronger.** ",
        "The search had definite limits, and they are recorded here so that the reader can weigh the ",
        "negative findings correctly.",
      ]),
      list([
        [
          "**MathSciNet was not used** (no subscription was available), and neither was Google Scholar. ",
          "The searches ran against the arXiv API, the zbMATH Open API, the OEIS, and directly retrieved ",
          "full texts.",
        ],
        [
          "**The arXiv search is a search of abstracts, not of full texts.** A paper that contains the ",
          "relevant statement in its body without announcing it in its abstract would not have been found. ",
          "The zbMATH searches were crossings of subject classifications with keywords, and classification ",
          "is applied unevenly.",
        ],
        [
          "**Several papers were located but not read in full** and are cited only from their reviews or ",
          "abstracts; these are marked as such where they occur.",
        ],
      ]),
      paragraph([
        "**We therefore do not treat a search returning nothing as evidence that nothing exists.** This is ",
        "not a general precaution but a rule this project has had to learn: a count of zero over a partial ",
        "corpus is compatible with a substantial rate of occurrence in the whole, and this paper elsewhere ",
        "warns against exactly this inference. Applying the warning to our own prior-art check is the ",
        "least that consistency requires.",
      ]),
      paragraph([
        "**A note on how these findings were arrived at.** Two of the corrections recorded in this chapter ",
        "were not produced by reading more carefully. One came from formalisation in Lean, which detected ",
        "errors in the prose statements in two successive rounds — in both cases the underlying arguments ",
        "were sound and the claim had been damaged in transcription. The other came from re-examining a ",
        "retrieval failure instead of accepting its first diagnosis: the paper recorded as inaccessible ",
        "behind a subscription turned out to be Open Access, and reading it changed what could be said ",
        "about Proposition W. We record both because a survey that reports only its successful checks ",
        "gives a misleading impression of how reliable such checks are.",
      ]),
    ],
  },
]);
