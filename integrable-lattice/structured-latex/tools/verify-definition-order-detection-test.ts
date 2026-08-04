#!/usr/bin/env node
/**
 * **検査 O（定義の登場順序）が実際に検出できることの実証。**
 *
 * 「本番で違反 0 件だった」は検査が効いていることの根拠にならない（cycle 22 の教訓）。
 * 再現データは**ユーザーが指摘した当の形**（第 1 章の見出しが $\Lambda$ と
 * 整数スペクトル曲線を定義前に使っていた）である。
 *
 * **ファイルは 1 バイトも書き換えない。** メモリ上の並びに対して判定を回す。
 */

import { type OrderedBlock, type TermDeclaration, violationsIn } from "./definition-order-model.ts";
import {
  type SweptBlock,
  coveredByLedger,
  definedAtomsIn,
  traceSymbols,
  usedBeforeDefinition,
} from "./definition-order-symbol-model.ts";
import {
  type VocabularyBlock,
  coveredByLedger as coveredByTermLedger,
  japaneseTermBefore,
  traceVocabulary,
  usedBeforeNaming,
} from "./definition-order-vocabulary-model.ts";

let failures = 0;
let checks = 0;
const report = (name: string, ok: boolean, detail: string): void => {
  checks += 1;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**失敗**"}: ${name}`);
  console.log(`      ${detail}`);
};

const block = (
  index: number,
  id: string,
  kind: string,
  title: string,
  body = "",
  labels: string[] = [],
): OrderedBlock => ({ index, id, kind, labels, title, text: `${title} ${body}` });

console.log("");
console.log("定義の登場順序の検査（検査 O）の検出テスト");
console.log("  再現データ: ユーザーが指摘した当の形（第 1 章の見出しが Λ を定義前に使っていた）。");

/** 直す前の並び。見出しが Λ と整数スペクトル曲線を、定義より前に使っていた。 */
const BEFORE: OrderedBlock[] = [
  block(0, "heading_intro", "heading", "序論 — 整数スペクトル曲線の二素点と、Λ 側の決定可能性"),
  block(1, "remark_positioning", "remark", "本論文の位置づけ", "同一の整数スペクトル曲線 P について \\Lambda 側の量を並置する"),
  block(2, "def_ladder", "definition", "決定可能性の梯子", "\\Lambda は対数順序群である", ["paper_def_ladder"]),
  block(3, "def_curve", "definition", "整数スペクトル曲線と周期点数", "整数スペクトル曲線を定める", ["paper_def_curve"]),
];

/** 直したあとの並び。見出しから語を落とし、位置づけが語を使わない書き方になっている。 */
const AFTER: OrderedBlock[] = [
  block(0, "heading_intro", "heading", "序論"),
  block(1, "remark_positioning", "remark", "本論文の位置づけ", "同一の整数係数多項式 P について 2 つの側の量を並置する"),
  block(2, "def_ladder", "definition", "決定可能性の梯子", "\\Lambda は対数順序群である", ["paper_def_ladder"]),
  block(3, "def_curve", "definition", "整数スペクトル曲線と周期点数", "整数スペクトル曲線を定める", ["paper_def_curve"]),
];

const TERMS: TermDeclaration[] = [
  { token: "\\Lambda", aliases: ["対数順序群"], definedIn: "paper_def_ladder", dependsOn: [] },
  { token: "整数スペクトル曲線", definedIn: "paper_def_curve", dependsOn: [] },
];

{
  const found = violationsIn(TERMS, BEFORE);
  const inTitle = found.filter(
    (v) => v.kind === "定義より前に使われている" && v.usedIn === "title",
  );
  report(
    "見出しが定義前の語を使っている（ユーザーが指摘した当の形）",
    inTitle.length >= 1,
    `違反 ${found.length} 件（うち見出し ${inTitle.length} 件。期待 1 件以上）`,
  );
  report(
    "本文が定義前の語を使っている",
    found.some((v) => v.kind === "定義より前に使われている"),
    `Λ と整数スペクトル曲線がどちらも定義より前に現れる並びで挙がる`,
  );
}

report(
  "直したあとの並びでは挙がらない（偽陽性でない）",
  violationsIn(TERMS, AFTER).length === 0,
  `違反 ${violationsIn(TERMS, AFTER).length} 件（期待 0）`,
);

{
  // 依存関係のトポロジカル順序: A の定義が B を使うなら B の定義が先でなければならない。
  const swapped: OrderedBlock[] = [
    block(0, "def_massieu", "definition", "Massieu 自由エントロピー", "", ["paper_def_massieu"]),
    block(1, "def_curve", "definition", "周期点数", "", ["paper_def_curve"]),
  ];
  const terms: TermDeclaration[] = [
    { token: "Massieu 自由エントロピー", definedIn: "paper_def_massieu", dependsOn: ["周期点数"] },
    { token: "周期点数", definedIn: "paper_def_curve", dependsOn: [] },
  ];
  report(
    "依存する語より前に定義されている並びが挙がる",
    violationsIn(terms, swapped).some((v) => v.kind === "依存する語より前に定義されている"),
    "Massieu 自由エントロピーの定義が、依存する周期点数の定義より前にある並びで挙がる",
  );
  const ordered: OrderedBlock[] = [
    block(0, "def_curve", "definition", "周期点数", "", ["paper_def_curve"]),
    block(1, "def_massieu", "definition", "Massieu 自由エントロピー", "", ["paper_def_massieu"]),
  ];
  report(
    "順序が正しければ挙がらない（偽陽性でない）",
    violationsIn(terms, ordered).length === 0,
    `違反 ${violationsIn(terms, ordered).length} 件（期待 0）`,
  );
}

{
  // 同じブロックが複数の語をまとめて定義する場合は、ブロックの中の順序を論じない。
  const one: OrderedBlock[] = [
    block(0, "def_curve", "definition", "整数スペクトル曲線と周期点数", "", ["paper_def_curve"]),
  ];
  const terms: TermDeclaration[] = [
    { token: "整数スペクトル曲線", definedIn: "paper_def_curve", dependsOn: [] },
    { token: "周期点数", definedIn: "paper_def_curve", dependsOn: ["整数スペクトル曲線"] },
  ];
  report(
    "同じブロックがまとめて定義する場合は挙がらない（偽陽性でない）",
    violationsIn(terms, one).length === 0,
    `違反 ${violationsIn(terms, one).length} 件（期待 0）`,
  );
}

{
  // 台帳が腐ったら落ちる。
  const terms: TermDeclaration[] = [
    { token: "\\Lambda", definedIn: "paper_def_does_not_exist", dependsOn: [] },
  ];
  report(
    "台帳が指す定義ブロックが本文に無ければ挙がる",
    violationsIn(terms, AFTER).some((v) => v.kind === "台帳が指す定義ブロックが本文に無い"),
    "改名・削除で定義ブロックが消えたら赤くなる",
  );
  const dangling: TermDeclaration[] = [
    { token: "\\Lambda", definedIn: "paper_def_ladder", dependsOn: ["台帳に無い語"] },
  ];
  report(
    "台帳が指す依存語が台帳に無ければ挙がる",
    violationsIn(dangling, AFTER).some((v) => v.kind === "台帳が指す依存語が台帳に無い"),
    "依存関係の書き間違いが赤くなる",
  );
}

// --- 検査 O の後半（記号の初出の全数走査）-------------------------------------
//
// 再現データは**本サイクルで実際に見つかった 2 件**である。
// どちらも本文を直したので、直す前の並びをここへ写して検出を実証する。

{
  const swept = (index: number, id: string, ...texts: string[]): SweptBlock => ({
    index,
    id,
    kind: "theorem",
    texts,
  });

  // 1 件目: 命題 G′ が f_z を使い、その定義 f_z:=z+z^{-1}-2 は次の章にあった。
  const beforeFz = [
    swept(0, "prop_g_infty", String.raw`\psi_{(1,-1)}(\tilde E)`, String.raw`f_z`),
    swept(1, "prop_g_ell2", String.raw`f_z:=z+z^{-1}-2`),
  ];
  report(
    "定義が次の章にある記号を、初出の側で使っていると挙がる（本サイクルの f_z）",
    usedBeforeDefinition(traceSymbols(beforeFz)).some((trace) => trace.atom === "f_{z}"),
    "f_z の初出が、その `:=` の定義より前にある並びで挙がる",
  );
  const afterFz = [
    swept(0, "prop_g_infty", String.raw`\psi_{(1,-1)}(\tilde E)`, String.raw`z+z^{-1}-2`),
    swept(1, "prop_g_ell2", String.raw`f_z:=z+z^{-1}-2`),
  ];
  report(
    "記号を使わない書き方へ直すと挙がらない（偽陽性でない）",
    usedBeforeDefinition(traceSymbols(afterFz)).length === 0,
    `挙がった件数 ${usedBeforeDefinition(traceSymbols(afterFz)).length}（期待 0）`,
  );

  // 2 件目: 前の章が、後の命題で定義される平均 A_gen を式の中で使っていた。
  const beforeAgen = [
    swept(0, "drop_assumption", String.raw`c=\frac{\ell}{\ell-1}A_{\mathrm{gen}}`),
    swept(1, "general_closed_form", String.raw`A_{\mathrm{gen}}:=\frac{1}{\ell^{L}}\sum_P\theta(P)`),
  ];
  report(
    "後の章で定義される記号を前の章が式で使っていると挙がる（本サイクルの A_gen）",
    usedBeforeDefinition(traceSymbols(beforeAgen)).some(
      (trace) => trace.atom === "A_{\\mathrm{gen}}",
    ),
    "飾りを持つ記号なので、局所変数の使い回しとして外れることもない",
  );

  // 定義の左辺の読み取り: 引数を伴う形と、1 つの式に定義が 2 つ並ぶ形。
  report(
    "左辺が引数を伴っても定義される記号を取り違えない",
    definedAtomsIn(String.raw`\Phi_L(\beta):=\log Z_L(\beta)`).includes("\\Phi_{L}"),
    `読み取り結果 ${JSON.stringify(definedAtomsIn(String.raw`\Phi_L(\beta):=\log Z_L(\beta)`))}`,
  );
  const two = definedAtomsIn(String.raw`a_L:=\prod P,\qquad a^{\mathrm{red}}_L:=\prod' P`);
  report(
    "1 つの式に定義が 2 つ並んでいれば両方を読む",
    two.length === 2 && two.includes("a_{L}"),
    `読み取り結果 ${JSON.stringify(two)}`,
  );

  // 台帳との突き合わせ: 部分文字列で見ると、覆えていないものを覆っていると数えてしまう。
  report(
    "台帳の a^{red}_L は裸の a を覆わない（部分一致で数えない）",
    !coveredByLedger("a", ["a^{\\mathrm{red}}_L"]),
    "この誤りを実際に一度犯し、覆う件数が 19 件へ膨らんだ",
  );
  report(
    "波括弧の有無は同じものとして覆う",
    coveredByLedger("\\kappa_{n}", ["\\kappa_n"]),
    "台帳は \\kappa_n、走査は \\kappa_{n} と書く",
  );
}

// --- 検査 O の三つ目（散文の語の初出の全数走査）---------------------------------
//
// 再現データは**本文にいま在る形**である。cycle 30 の走査で挙がった 2 件
// （日本語の「全域木数」と「付値」）はどちらも順序の問題ではないと読んで免除したが、
// **検出そのものは効いている**ことをここで示す。あわせて、走査を作るときに
// 実データで潰した偽陽性（平仮名で終わる断片を語として拾ってしまう形）も固定する。

{
  const vocab = (
    index: number,
    id: string,
    kind: string,
    title: string,
    ...nodes: { kind: "text" | "math"; value: string }[]
  ): VocabularyBlock => ({ index, id, kind, title, nodes });

  const text = (value: string) => ({ kind: "text" as const, value });
  const math = (value: string) => ({ kind: "math" as const, value });

  // 双対命題 D が「グラフの全域木数」を使い、その名づけは 2 つ後の定義ブロックにある。
  const beforeSpanningTree = [
    vocab(0, "prop_duality", "theorem", "双対命題 D", text("その "), math("P"), text(" がグラフの全域木数 "), math(String.raw`\kappa`), text(" として実現できるとは限らない。")),
    vocab(1, "prop_l0", "theorem", "命題 F", text("ここは関係しない。")),
    vocab(2, "def_graph_tower", "definition", "voltage グラフ", text(" 段目の全域木数を "), math(String.raw`\kappa_n:=\kappa(X_{n,n})`), text(" と書く。")),
  ];
  report(
    "名づけより前に使われている散文の語が挙がる（本文にいま在る「全域木数」）",
    usedBeforeNaming(traceVocabulary(beforeSpanningTree, "ja")).some((t) => t.term === "全域木数"),
    `挙がった語 ${JSON.stringify(traceVocabulary(beforeSpanningTree, "ja").map((t) => t.term))}`,
  );

  // 語を使わない書き方へ直せば挙がらない。
  const afterSpanningTree = [
    vocab(0, "prop_duality", "theorem", "双対命題 D", text("その "), math("P"), text(" がグラフから来るとは限らない。")),
    vocab(1, "prop_l0", "theorem", "命題 F", text("ここは関係しない。")),
    vocab(2, "def_graph_tower", "definition", "voltage グラフ", text(" 段目の全域木数を "), math(String.raw`\kappa_n:=\kappa(X_{n,n})`), text(" と書く。")),
  ];
  report(
    "初出の側で語を使わない書き方へ直すと挙がらない（偽陽性でない）",
    usedBeforeNaming(traceVocabulary(afterSpanningTree, "ja")).length === 0,
    `挙がった件数 ${usedBeforeNaming(traceVocabulary(afterSpanningTree, "ja")).length}（期待 0）`,
  );

  // 名づけの言い回し（「と呼ぶ」）と、同じ文に鉤括弧で並ぶ語。
  const called = [
    vocab(0, "prop_q", "theorem", "命題 Q", text("この条件を満たす点を「良い点」、満たさない点を「悪い点」と呼ぶ。")),
  ];
  const calledTerms = traceVocabulary(called, "ja").map((t) => t.term);
  report(
    "「と呼ぶ」で並ぶ 2 語を両方拾う",
    calledTerms.includes("良い点") && calledTerms.includes("悪い点"),
    `拾った語 ${JSON.stringify(calledTerms)}`,
  );

  // 実データで潰した偽陽性。平仮名で終わる断片は語ではない。
  for (const fragment of ["したがって", "を取る", "と書き", "に対し", "このとき"]) {
    report(
      `平仮名で終わる断片を語として拾わない（${fragment}）`,
      japaneseTermBefore(`である。${fragment}`) === undefined,
      `切り出し結果 ${JSON.stringify(japaneseTermBefore(`である。${fragment}`))}`,
    );
  }
  report(
    "平仮名で始まる語は落とさない（ずれ指数）",
    japaneseTermBefore("(G1′ 補正が消える十分条件) ずれ指数 ") === "ずれ指数",
    `切り出し結果 ${JSON.stringify(japaneseTermBefore("(G1′ 補正が消える十分条件) ずれ指数 "))}`,
  );
  report(
    "助詞の直後で切る（「n 段目の全域木数を」→「全域木数」）",
    japaneseTermBefore(" 段目の全域木数を ") === "全域木数",
    `切り出し結果 ${JSON.stringify(japaneseTermBefore(" 段目の全域木数を "))}`,
  );

  // 台帳との突き合わせは包含で見る（記号のときと違う理由はモデルの doc に書いた）。
  report(
    "台帳の字面より長い語も覆われているとみなす",
    coveredByTermLedger("Massieu 自由エントロピーの Λ 帰属", ["Massieu 自由エントロピー"]),
    "定義ブロックの題は台帳の字面より長くなる",
  );
  report(
    "無関係な語は覆われない",
    !coveredByTermLedger("全域木数", ["voltage", "bouquet", "消滅深度"]),
    "台帳が覆っていない語を覆っていると数えない",
  );

  // 英語は言い回しの直後を取る（語順が違うので日本語の規則が移らない）。
  const englishNamed = [
    vocab(0, "prop_g", "theorem", "Proposition G", text("Define the vanishing depth of a direction "), math("P"), text(" by "), math(String.raw`\theta(P):=\min\{m\}`), text(".")),
  ];
  report(
    "英語は名づけの言い回しの直後から語を取る",
    traceVocabulary(englishNamed, "en").some((t) => t.term === "vanishing depth"),
    `拾った語 ${JSON.stringify(traceVocabulary(englishNamed, "en").map((t) => t.term))}`,
  );
}

console.log("");
if (failures > 0) {
  console.log(`**${failures} / ${checks} 件で検出できなかった。**`);
  process.exit(1);
}
console.log(`${checks} / ${checks} 件で検出を実証した。`);
