/**
 * 投稿稿のフロントマター（表題・著者・要旨・キーワード・MSC 2020）。
 *
 * 本文（`content/`）とは別モジュールにしてある。理由は 2 つ。
 *   1. 要旨・キーワード・MSC は**文書順を持つ本文ブロックではない**（`content/` の配列は文書順の
 *      正準表現であり、そこへ本文でないものを混ぜると順序の意味が壊れる）。
 *   2. 日英対応検証（`tools/verify-ja-en-correspondence.ts`）は content 同士を突き合わせる。
 *      日本語版に対応物が無いフロントマターを content へ入れると、対応検証が常に
 *      「英語版だけにあるブロック」を報告することになる。
 *
 * 要旨は**ノード列**である（数式を含められるようにするため。生成器が本文と同じ規則で組む）。
 *
 * ============================================================================
 * 【この版で暫定値を差し替えた。何を一次情報で確認し、何を確認できなかったか】
 *
 * - `title` … 日本語版の表題「ℝ/Λ 双対 — 整数スペクトル曲線の二素点と Λ 側の決定可能性」
 *   （`../structured-latex/content/001_intro.ts` の `paper_010_heading_intro`）を、
 *   内容以上のことを約束しない範囲で英語の表題にした。**新しい定理を約束する語を入れていない。**
 *
 * - `abstract` … Expositiones Mathematicae の Survey Article の読者像
 *   （「研究を始めた学生や、その話題の専門家でない数学者」。出典は
 *   `../outputs/reports/paper001_submission_venue_survey.md` §3.1）に向けて書き直した。
 *   本論文が新しい定理を主張しないことは維持しつつ、**何を新しく与えるか**（辞書・可算化の精密化・
 *   決定手続きと witness・非対称の地図）を先に述べる。これは
 *   同 §3.9 が指摘した「arXiv のモデレーションは独創性の欠如を却下事由に挙げている」への対応でもある。
 *   数学的主張は日本語版 `paper_011_remark_positioning` から強めても弱めてもいない。
 *
 * - `authors` … 名前は本リポジトリの git 設定（`git config user.name`）から取った。
 *   **所属はリポジトリのどこにも書かれていないので、推測で埋めず項目ごと置いていない。**
 *   **投稿前に著者本人が所属と連絡先を埋めること。**（`Author` 型の `affiliation` / `email` は
 *   optional なので、埋まっていないことは型では検出できない。ここに書いて残す。）
 *
 * - `keywords` … 本文に実際に現れる概念だけから選んだ（Mahler 測度・Lehmer 問題・岩澤型漸近公式・
 *   周期点・グラフ塔・全域木数・決定可能性・Lean での形式化）。
 *
 * - `msc2020` … **一次情報と照合済み。** zbMATH が配布する MSC2020 の公式分類表
 *   <https://zbmath.org/static/msc2020.pdf>（2026-08-01 取得、`pdftotext -layout` でテキスト化）
 *   から、下記 9 件の番号と項目名が一字一句一致することを確認した。項目名は次のとおり:
 *     11R06 PV-numbers and generalizations; other special algebraic numbers; Mahler measure
 *     11R23 Iwasawa theory
 *     03B25 Decidability of theories and sets of sentences
 *     03B30 Foundations of classical theories (including reverse mathematics)
 *     05C30 Enumeration in graph theory
 *     37B40 Topological entropy
 *     37P35 Arithmetic properties of periodic points
 *     68V20 Formalization of mathematics in connection with theorem provers
 *     82B20 Lattice systems (Ising, dimer, Potts, etc.) and systems on graphs arising in
 *           equilibrium statistical mechanics
 *   **確認していない番号は 1 つも書いていない。**（`msc2020.org` は分類表そのものを置いておらず、
 *   CSV の直リンクは 404 だった。上記 zbMATH の PDF が取得できた一次情報である。）
 * ============================================================================
 */

import type { Node } from "./schema.ts";
import { math, paragraph } from "./schema.ts";

export type Author = {
  name: string;
  /** 所属。未確定なら空文字ではなく、確定するまで項目ごと置かない。 */
  affiliation?: string;
  email?: string;
};

export type Msc2020 = {
  /** 主分類（1 件以上）。 */
  primary: readonly string[];
  /** 副分類（0 件でもよい）。 */
  secondary: readonly string[];
};

export type Frontmatter = {
  title: string;
  authors: readonly Author[];
  /** 要旨。本文と同じノード列（数式を含められる）。 */
  abstract: readonly Node[];
  keywords: readonly string[];
  msc2020: Msc2020;
};

export const frontmatter: Frontmatter = {
  title:
    "The two places of an integer spectral curve: Mahler measure, Iwasawa-type asymptotics, " +
    "and decidability on the logarithmic ordered group",

  // 所属は一次情報が無いので空にした。投稿前に著者本人が埋めること（上のコメントを見よ）。
  authors: [{ name: "Masaori Hirono" }],

  abstract: [
    paragraph([
      "A Laurent polynomial ",
      math(String.raw`P`),
      " with integer coefficients — an integer spectral curve — governs two families of quantities that ",
      "are ordinarily studied by different communities. At the archimedean place it produces the Mahler ",
      "measure of ",
      math(String.raw`P`),
      ", which is at once the entropy of an algebraic ",
      math(String.raw`\mathbb{Z}^d`),
      "-action and the free energy density of an associated lattice model. At each ",
      math(String.raw`p`),
      "-adic place it produces the prime factorisation of the number of periodic points, whose growth ",
      "along a tower of graphs obeys an Iwasawa-type asymptotic formula and counts spanning trees.",
    ]),
    paragraph([
      "This survey puts the two places of one and the same ",
      math(String.raw`P`),
      " side by side, and organises the resulting picture along a single axis: which statements come with ",
      "a finite decision procedure. Four things are supplied. First, an explicit dictionary between the ",
      "archimedean and the ",
      math(String.raw`p`),
      "-adic quantities attached to ",
      math(String.raw`P`),
      ", together with their readings in statistical mechanics. Second, a sharpening of what the countable ",
      "side actually needs: the point is not that ",
      math(String.raw`\mathbb{Q}_p`),
      " admits a countable encoding — coding uncountable objects countably is a standard device of reverse ",
      "mathematics — but that equality itself descends to a decidable level, namely agreement of prime ",
      "factorisations in the logarithmic ordered group ",
      math(String.raw`\Lambda=\bigoplus_p\mathbb{Z}\,\ell_p`),
      " and separation of roots in ",
      math(String.raw`\overline{\mathbb{Q}}`),
      ". Third, a determination of a family of propositions on the ",
      math(String.raw`\Lambda`),
      " side that carry an explicit decision procedure and a witness. Fourth, a map of an asymmetry: ",
      "Lehmer's problem is specific to the ",
      math(String.raw`\mathbb{R}`),
      " side, and no corresponding open continuous gap stands on the ",
      math(String.raw`\Lambda`),
      " side.",
    ]),
    paragraph([
      "**None of these four is a new theorem.** Each is a rearrangement, a restatement or a ",
      "countabilisation of known results, and the sources are identified by name of reference and number ",
      "of proposition; where the literature already contains a proposition, we say so, including the cases ",
      "in which only a weaker form is known. Part of the material has been formalised in Lean 4 with ",
      "mathlib4, where 85 declarations have been checked mechanically to be free of ",
      math(String.raw`\mathrm{sorry}`),
      ", and the formalisation twice detected errors in the prose version. The material is drawn from ",
      "number theory, mathematical logic, dynamical systems, statistical mechanics and formal ",
      "verification, and the reader is assumed to be a specialist in none of them.",
    ]),
  ],

  // 本文に実際に現れる概念から選んだ。
  keywords: [
    "Mahler measure",
    "Lehmer's problem",
    "Iwasawa-type asymptotic formula",
    "periodic points",
    "towers of graphs",
    "spanning trees",
    "decidability",
    "formalisation in Lean 4",
  ],

  // 一次情報（zbMATH 配布の MSC2020 公式分類表）と照合済み。上のコメントに項目名を控えてある。
  msc2020: {
    primary: ["11R06"],
    secondary: ["03B25", "03B30", "05C30", "11R23", "37B40", "37P35", "68V20", "82B20"],
  },
};
