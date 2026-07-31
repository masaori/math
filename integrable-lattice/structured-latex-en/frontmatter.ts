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
 * 【後続の担当者へ】以下の中身はすべて**暫定**である。差し替えること。
 *   - `title` / `abstract` … Expositiones Mathematicae の Survey Article として読者
 *     （「研究を始めた学生や、その話題の専門家でない数学者」）に向けた文面へ書き直す。
 *   - `authors` … 実際の著者名・所属を書く。**このファイルの現在の値は仮の記述であり、
 *     確認していない事実を書いてはならない**（未確定なら未確定と書いたまま投稿しない）。
 *   - `keywords` / `msc2020` … MSC 2020 の分類番号は
 *     https://msc2020.org/ 等の一次情報で確認してから確定する。
 *     **下の値は本文の主題（Mahler 測度・岩澤理論・決定可能性）から当てた暫定値であり、
 *     一次情報で照合していない。** 照合するまで投稿に使わないこと。
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

  // 暫定。実際の著者情報へ差し替えること（確認していない所属を書かない）。
  authors: [{ name: "TODO: author name" }],

  // 暫定。Survey Article の読者像に合わせて書き直すこと。
  abstract: [
    paragraph([
      "TODO (placeholder abstract; to be rewritten by the translation pass). ",
      "For a Laurent polynomial with integer coefficients — an integer spectral curve — the same object ",
      "governs two apparently unrelated quantities: at the archimedean place, the Mahler measure, which is ",
      "the entropy of the associated algebraic dynamical system and the free energy density of an ",
      "associated lattice model; at each ",
      math(String.raw`p`),
      "-adic place, the prime factorisation of the number of periodic points, whose growth obeys an ",
      "Iwasawa-type asymptotic formula. This survey places the two side by side, and isolates the single ",
      "point at which the argument leaves the countable world.",
    ]),
  ],

  // 暫定。本文の主題から当てたものであり、一次情報で照合していない。
  keywords: [
    "Mahler measure",
    "Iwasawa theory",
    "algebraic dynamical systems",
    "periodic points",
    "decidability",
    "formal verification",
  ],

  // 暫定。msc2020 の公式分類表と照合していない。
  msc2020: {
    primary: ["11R06"],
    secondary: ["11R23", "37B40", "03D35", "68V20"],
  },
};
