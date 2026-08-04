/**
 * **検査 O の台帳**（本論文が自分で定義する語・記号と、その定義が前提とする語）。
 *
 * 型と、なぜ台帳制にするのかは `definition-order-model.ts` の doc を正本とする。要点だけ:
 *
 * - **ここに載っている語は、定義より前に現れてはならない**（見出しを含む）。
 * - **依存する語の定義は、その語の定義より前になければならない**（トポロジカル順序）。
 * - **ここに載っていない語は素通りする。** 台帳の網羅性がこの検査の強さの上限である。
 *
 * 本論文が定義しない標準的な語彙（素点・Newton 多角形・Lehmer 問題・$\mathbb{R}$ 等）は
 * 載せない。本論文の中に「定義の位置」が無いので、順序を論じる対象にならない。
 *
 * 日本語版と英語版で字面が違うので、ロケールごとに台帳を持つ。
 */

import type { TermDeclaration } from "./definition-order-model.ts";

const JAPANESE: readonly TermDeclaration[] = [
  {
    token: "\\Lambda",
    aliases: ["対数順序群"],
    definedIn: "paper_def_ladder",
    dependsOn: [],
    note: "決定可能性の梯子の定義が、可算側の最上段として Λ を導入する。",
  },
  {
    token: "\\overline{\\mathbb{Q}}",
    definedIn: "paper_def_ladder",
    dependsOn: [],
    note: "同じ定義が代数的数の段として導入する。",
  },
  {
    token: "決定可能",
    definedIn: "paper_def_ladder",
    dependsOn: [],
    note: "梯子の各段が「何が決定可能か」で並んでいる。この語の内容はそこで与えられる。",
  },
  {
    token: "四軸",
    aliases: ["帰属"],
    definedIn: "paper_four_axes",
    dependsOn: ["決定可能"],
    note: "四つの軸のうち「帰属」は梯子のどの段に住むかを言うので、梯子が先に要る。",
  },
  {
    token: "整数スペクトル曲線",
    aliases: ["スペクトル曲線"],
    definedIn: "paper_def_curve",
    dependsOn: [],
  },
  {
    token: "周期点数",
    definedIn: "paper_def_curve",
    dependsOn: ["整数スペクトル曲線"],
  },
  {
    token: "Massieu 自由エントロピー",
    aliases: ["自由エントロピー"],
    definedIn: "paper_def_massieu",
    dependsOn: ["\\Lambda", "周期点数"],
    note: "Λ に住むことを主張する定義なので、Λ と周期点数の両方が先に要る。",
  },
  {
    token: "Mahler 測度",
    definedIn: "paper_thm_archimedean",
    dependsOn: ["整数スペクトル曲線"],
    note: "本論文で Mahler 測度に内容が与えられるのは、この定理（エントロピー＝Mahler 測度）である。",
  },
  {
    token: "消滅深度",
    definedIn: "paper_prop_G",
    dependsOn: [],
    note: "命題 G の (G6) が定義する。以降の章（命題 J・K・R）はこれを使う。",
  },
];

const ENGLISH: readonly TermDeclaration[] = [
  { token: "\\Lambda", definedIn: "paper_def_ladder", dependsOn: [] },
  { token: "\\overline{\\mathbb{Q}}", definedIn: "paper_def_ladder", dependsOn: [] },
  { token: "decidab", definedIn: "paper_def_ladder", dependsOn: [], note: "decidable / decidability の共通部分。" },
  { token: "four axes", aliases: ["membership"], definedIn: "paper_four_axes", dependsOn: ["decidab"] },
  { token: "integer spectral curve", definedIn: "paper_def_curve", dependsOn: [] },
  { token: "periodic points", definedIn: "paper_def_curve", dependsOn: ["integer spectral curve"] },
  {
    token: "Massieu free entropy",
    definedIn: "paper_def_massieu",
    dependsOn: ["\\Lambda", "periodic points"],
  },
  { token: "Mahler measure", definedIn: "paper_thm_archimedean", dependsOn: ["integer spectral curve"] },
  { token: "vanishing depth", definedIn: "paper_prop_G", dependsOn: [] },
];

export const DEFINITION_ORDER_TERMS: Readonly<Record<string, readonly TermDeclaration[]>> = {
  ja: JAPANESE,
  en: ENGLISH,
};
