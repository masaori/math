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
  {
    token: "簡約周期点数",
    aliases: ["a^{\\mathrm{red}}_L"],
    definedIn: "paper_def_curve",
    dependsOn: ["整数スペクトル曲線"],
    note: "周期点数と同じ定義ブロックが、トーラス零点を除いた版として定める。",
  },
  {
    token: "\\pi_{\\mathrm{tr}}",
    aliases: ["トレース列の周期"],
    definedIn: "paper_prop_B",
    dependsOn: [],
    note:
      "命題 B がトレース列の最終周期として導入する。命題 A は行列冪列の周期 π(p,k) を扱い、" +
      "2 つを混同しないよう注意を書いているが、その注意はこの記号を使わずに書く（使えば定義より前になる）。",
  },
  {
    token: "voltage",
    definedIn: "paper_def_graph_tower",
    dependsOn: [],
    note: "voltage 割り当て。塔の定義がこれを前提にするので、塔より先に同じブロックで定める。",
  },
  {
    token: "\\kappa_n",
    aliases: ["\\kappa(G)"],
    definedIn: "paper_def_graph_tower",
    dependsOn: ["voltage"],
    note:
      "塔の n 段目の全域木数。塔（したがって voltage）が先に要る。" +
      "**追跡するのは記号だけで、「全域木数」という語は載せない。** 全域木の個数という概念は標準の語彙であり、" +
      "本論文が定義しているのは記号のほうだからである（命題 D は語を先に使うが、そこでは記号を導入していない）。",
  },
  {
    token: "L(z,w)",
    aliases: ["voltage ラプラシアン"],
    definedIn: "paper_def_graph_tower",
    dependsOn: ["voltage"],
    note:
      "命題 W は L を定義せずに使っていた（本論文のどこにも定義が無かった）。cycle 28 で定義を起こし、" +
      "命題 W はそれを参照する形にした。",
  },
  {
    token: "塔は非退化",
    aliases: ["塔が非退化", "非退化グラフ塔", "非退化な塔", "非退化ならば"],
    definedIn: "paper_def_graph_tower",
    dependsOn: ["L(z,w)"],
    note:
      "**単独の語「非退化」を追跡できない。** 命題 C が別の意味で「非退化な companion 行列」と書いており、" +
      "字面が同じで内容が違う。塔についての用法だけを拾うために語をつないだ形で登録する。" +
      "この判断は機械では検証できない（型ではなく人が読んで決めた）。",
  },
  {
    token: "bouquet",
    definedIn: "paper_def_graph_tower",
    dependsOn: ["voltage"],
    note: "1 頂点で全ての辺がループである多重グラフ。命題 G′・G″ が族の名として使う。",
  },
  {
    token: "型 II",
    definedIn: "paper_def_graph_tower",
    dependsOn: ["\\kappa_n"],
    note:
      "漸近形の n ℓ^n の係数が 0 かどうかで塔を呼び分ける語。命題 J の (J4) はこの二分の判定条件であって、" +
      "語そのものの定義ではない（定義より前に命題 G・G′ が使っていたので、cycle 28 で定義側を前へ出した）。",
  },
  {
    token: "型 III",
    definedIn: "paper_def_graph_tower",
    dependsOn: ["\\kappa_n"],
    note: "同上（係数が 0 でない側）。",
  },
  {
    token: "良い点",
    aliases: ["悪い点"],
    definedIn: "paper_prop_Q",
    dependsOn: ["消滅深度"],
    note: "命題 Q が (Q3) の等号が成り立つ点／成り立たない点として定める。",
  },
  {
    token: "過渡欠損",
    definedIn: "paper_prop_U",
    dependsOn: ["\\kappa_n"],
    note: "命題 U の (U2) が定数項の分解として定める。",
  },
  {
    token: "ずれ指数",
    definedIn: "paper_prop_G",
    dependsOn: [],
    note: "命題 G の (G1′) が定める。空集合になりうるので規約つき（検査 M の対象でもある）。",
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
  {
    token: "a^{\\mathrm{red}}_L",
    definedIn: "paper_def_curve",
    dependsOn: ["integer spectral curve"],
    note: "The reduced count, defined in the same block as the periodic points.",
  },
  {
    token: "\\pi_{\\mathrm{tr}}",
    definedIn: "paper_prop_B",
    dependsOn: [],
    note:
      "Introduced in Proposition B as the eventual period of the trace sequence. " +
      "The caution in Proposition A speaks of the two periods without using this symbol.",
  },
  {
    token: "voltage",
    definedIn: "paper_def_graph_tower",
    dependsOn: [],
  },
  {
    token: "\\kappa_n",
    aliases: ["\\kappa(G)"],
    definedIn: "paper_def_graph_tower",
    dependsOn: ["voltage"],
    note:
      "Only the notation is tracked. The notion of the number of spanning trees is standard vocabulary, " +
      "so the words themselves are not on the ledger.",
  },
  {
    token: "L(z,w)",
    definedIn: "paper_def_graph_tower",
    dependsOn: ["voltage"],
  },
  {
    token: "non-degenerate tower",
    aliases: ["the tower is non-degenerate", "non-degenerate towers"],
    definedIn: "paper_def_graph_tower",
    dependsOn: ["L(z,w)"],
    note:
      "The bare word cannot be tracked: Proposition C uses `non-degenerate companion matrices` " +
      "in a different sense. Only the phrases about towers are registered.",
  },
  {
    token: "bouquet",
    definedIn: "paper_def_graph_tower",
    dependsOn: ["voltage"],
  },
  {
    token: "type II",
    definedIn: "paper_def_graph_tower",
    dependsOn: ["\\kappa_n"],
  },
  {
    token: "type III",
    definedIn: "paper_def_graph_tower",
    dependsOn: ["\\kappa_n"],
  },
  {
    token: "bad point",
    aliases: ["bad points"],
    definedIn: "paper_prop_Q",
    dependsOn: ["vanishing depth"],
  },
  {
    token: "transient defect",
    definedIn: "paper_prop_U",
    dependsOn: ["\\kappa_n"],
  },
];

export const DEFINITION_ORDER_TERMS: Readonly<Record<string, readonly TermDeclaration[]>> = {
  ja: JAPANESE,
  en: ENGLISH,
};
