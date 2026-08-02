/**
 * 転記検査の**中身**（`verify-transcription.ts` は入出力だけを持つ）。
 *
 * ここを分けてあるのは、**検出できることを実証するテスト**
 * （`verify-transcription-detection-test.ts`）が、本文ファイルを一切書き換えずに
 * 「事故が起きていた頃の本文」を人工的に作って同じ検査へ通せるようにするためである。
 * 本文（`content/`）は別 step の担当なので触らない。
 */

import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import type { ConvertedBlock, Node } from "../schema.ts";
import { atomsOf, proseTerms, tokenize, type Token } from "./tex-atoms.ts";

const here = dirname(fileURLToPath(import.meta.url));
/**
 * integrable-lattice/ の絶対パス。report のパスはここからの相対で書く。
 *
 * `TRANSCRIPTION_PROJECT_ROOT` で差し替えられる。用途は 1 つだけ——
 * **root を過去の版（`git archive` で取り出した snapshot）へ向けて、
 * 「report が実際に改訂されたとき、この検査が何件を赤にするか」を測ること**である
 * （cycle 24 step 3 の report §6 の実測）。本文（`content/`）はこの変数の影響を受けない。
 */
export const projectRoot = process.env["TRANSCRIPTION_PROJECT_ROOT"] ?? join(here, "..", "..");

// --- 本文ブロックの見え方 -------------------------------------------------------

/** 照合に使うブロックの見え方。 */
export type BlockView = {
  id: string;
  file: string;
  kind: string;
  title: string;
  /** 地の文（`text` ノードとタイトル）。ノード 1 つが 1 要素。 */
  proseParts: string[];
  /** 地の文を連結したもの。 */
  prose: string;
  /** 数式（`math` / `displayMath`）の tex。並びは文書順。 */
  formulas: string[];
};

export function viewOf(block: ConvertedBlock, file: string): BlockView {
  const prose: string[] = [];
  const formulas: string[] = [];
  const title = block.kind === "figure" ? "" : (block.title?.text ?? "");
  if (title !== "") prose.push(title);
  if (block.kind !== "figure" && block.title?.tex !== undefined) formulas.push(block.title.tex);
  const theoremLike = block as { statement?: readonly Node[]; proof?: readonly Node[] };
  walk(theoremLike.statement ?? [], prose, formulas);
  walk(theoremLike.proof ?? [], prose, formulas);
  return {
    id: block.id,
    file,
    kind: block.kind,
    title,
    proseParts: prose,
    prose: prose.join(" "),
    formulas,
  };
}

function walk(nodes: readonly Node[], prose: string[], formulas: string[]): void {
  for (const node of nodes) {
    if (node.type === "text" || node.type === "todo") prose.push(node.value);
    else if (node.type === "math" || node.type === "displayMath") formulas.push(node.tex);
    else if (node.type === "paragraph") walk(node.children, prose, formulas);
    else if (node.type === "list") node.items.forEach((item) => walk(item, prose, formulas));
  }
}

// --- 検査 A: 根拠 report からの取りこぼし ---------------------------------------

/** 根拠 report の中の、そのブロックが転記したはずの範囲。 */
export type Passage = {
  /** `integrable-lattice/` からの相対パス。 */
  report: string;
  /** 範囲の開始行に含まれる文字列（最初に一致した行から）。 */
  from: string;
  /** 範囲の終了行に含まれる文字列（`from` より後で最初に一致した行まで）。 */
  to: string;
  /**
   * その範囲が本文のどの項に対応するか。
   *
   * **cycle 26 step 4 まで「人が読むためのもの。検査には使わない」だった。**
   * いまは**条件文が 1 文も取れなかった passage に限り、ここを照合対象へ回す**。
   *
   * 理由: cycle 23 以来「照合対象が 0 件だったブロック」が 5 件あり
   * （`paper_023_definition_massieu` / `paper_045_theorem_lte` / `paper_054_remark_limits` /
   * `paper_072_remark_qp_free` / `paper_082_remark_formalization`）、
   * **台帳の目印が生きていることしか検査していなかった**。件数は毎回出していたが減らせていない、
   * というのが cycle 25 総括の指摘である。
   * `covers` は台帳の書き手が「この範囲は本文のこれに当たる」と宣言した文なので、
   * **そこに現れる数式アトムと専門語は本文にあるはずである**。それを検査する。
   */
  covers: string;
  /**
   * 範囲のうち**引用（`>` で始まる行）だけ**を見る。
   *
   * この report 群は定理・補題・系の**主張**を markdown の引用として書き、証明と注はその外に書く。
   * 主張だけを見たいとき（仮定は主張の側に書いてある）はこれを立てる。立てないと、
   * 証明の途中式や「step 2 §9.1 との関係」のような report 内部の履歴まで照合対象になり、
   * 免除の登録ばかりが増えて検査が読めなくなる（実測: 命題 K で未確認 38 件）。
   */
  quotedOnly?: boolean;
};

// --- 免除の根拠（cycle 24 step 3） -----------------------------------------------

/**
 * **免除の根拠。**
 *
 * cycle 23 で台帳の被覆は 97% になったが、**免除が 91 件**あり、検査の強さは免除の妥当性に
 * 完全に依存していた。免除は自然文の `reason` しか持たず、**根拠 report が書き換わっても
 * 本文が書き換わっても、免除は黙って生き残る**（cycle 23 総括の「正直な限界」）。
 *
 * そこで免除に**機械検証できる根拠**を持たせる。共通して次の 2 つを必ず検査する。
 *
 *   1. `reportQuote` が、その免除が属する passage の**条件文のちょうど 1 文**に現れること。
 *      → 根拠 report が書き換わったら落ちる。
 *   2. その文から**実際にその item が出る**こと（アトム／語の抽出をやり直して確かめる）。
 *      → 引用と項目の対応が壊れたら落ちる（別の文を貼っていたら落ちる）。
 *
 * さらに**型ごとに、腐り方が違うので別の検査を足す**（下の各型の doc を見よ）。
 * 型は cycle 23 report §4 が判定に使った 8 分類をそのまま持ち込んでいる。
 *
 * **機械検証できない型がある**ことを先に書く: `positioning`（report が自分の作業を
 * 位置づける言葉であって主張ではない、という判定）は、**「主張ではない」ことを機械で
 * 確かめる手段が無い**。この型は 1 と 2 しか検査しない。黙って緑にしないため、
 * `verify-transcription.ts` が**毎回その件数を出す**。
 */
export type ExemptionGrounds =
  /**
   * **記法の選択**: report と本文が同じ量を別の書き方で書いている。
   * 腐り方: 本文が採っている書き方（`bodyQuote`）が消えたら、免除の前提が崩れる。
   */
  | { type: "notation"; reportQuote: string; bodyQuote: string }
  /**
   * **本文のほうが弱い主張しかしていない**（強い方を主張していないので落としてよい）。
   * 腐り方: 本文の弱い側の記述（`bodyQuote`）が消えたら、何を主張しているのか分からなくなる。
   * **検証できないこと**: 「弱い」という含意関係そのものは機械で確かめられない（型の限界）。
   */
  | { type: "weaker"; reportQuote: string; bodyQuote: string }
  /**
   * **ブロック間の分担**: 同じ論文の別ブロックがその項目を持っている。
   * 腐り方: **分担先のブロックが消える／その項目を失う**と、論文全体からその内容が落ちる。
   * これは他の型と違い「別の場所にあること」を実際に確かめられる（`holder` / `holderItem`）。
   */
  | { type: "division"; reportQuote: string; holder: string; holderItem: string }
  /**
   * **report が自分の作業を位置づける言葉**（主張ではない）。
   * 腐り方: report が書き換わればその言葉自体が消える（検査 1・2 で捕まる）。
   *
   * **cycle 26 step 4 で機械検証を 1 つ足した**: 引用は
   * `POSITIONING_MARKERS`（下の閉じた語彙）のいずれかを**必ず含まねばならない**。
   * これにより「任意の数学的な文を positioning と名乗って黙らせる」ことができなくなる。
   * 語彙は「report が自分の作業について語るときの言い回し」だけで構成する。
   *
   * **なお検証できないこと**（型の限界は残る）: 目印を含む文が
   * 「本当に主張ではない」かどうかそのもの。件数は毎回出す。
   */
  | { type: "positioning"; reportQuote: string }
  /**
   * **例示・具体化の省略**（主張は保たれている）。
   * 腐り方: 主張を担っている本文の記述（`bodyQuote`）が消えたら、例だけでなく主張ごと落ちる。
   */
  | { type: "example"; reportQuote: string; bodyQuote: string }
  /**
   * **同じ主張の言い換え**。
   * 腐り方: 言い換え先の本文の記述（`bodyQuote`）が消えたら、言い換えではなく脱落になる。
   */
  | { type: "paraphrase"; reportQuote: string; bodyQuote: string }
  /**
   * **report のほうが古い**（後のサイクルが解消済み）。
   * 腐り方: 解消した側の記録（`supersededBy`）が消える／その report が書き換わると、
   * 「古い」という判定の根拠が無くなる。**両方の report を pin する**。
   */
  | { type: "reportStale"; reportQuote: string; supersededBy: { report: string; marker: string } }
  /**
   * **本文の不備**（免除で黙らせているのではなく、直すべきものとして記録済み）。
   * 腐り方: 記録（`recordedIn`）が消えたら、ただの黙殺になる。
   * なお本文が直れば item が本文に現れ、既存の「免除が余っている」検査が赤にする。
   */
  | { type: "bodyDefect"; reportQuote: string; recordedIn: { report: string; marker: string } };

export type Acknowledged = {
  item: string;
  reason: string;
  /** **必須**。根拠を書かない免除は作れない（型で強制する）。 */
  grounds: ExemptionGrounds;
};

export type SourceLink = {
  block: string;
  passages: readonly Passage[];
  /**
   * **その項目 1 つだけ**を免除する。ブロックを丸ごと免除する形にはしない
   * （ブロック単位の免除は cycle 21 で実際に検査の穴になった）。
   */
  acknowledged: readonly Acknowledged[];
};

export type CoverageFinding = {
  block: string;
  kind: "atom" | "term";
  item: string;
  /** その項目が現れる report の行（人が確認するため）。 */
  where: string;
};

export type CoverageResult = {
  block: string;
  passageLines: number;
  /** そのうち条件・例外・仮定を述べていると判定した文の数。 */
  conditionSentences: number;
  /**
   * 条件文が 1 文も取れず、台帳の `covers` を照合対象へ回した passage の数（cycle 26 step 4）。
   * **0 にするのが目標ではない**。`covers` へ回っていること自体は正常な運用であり、
   * 黙って何も照合しない状態を無くすための仕組みである。件数は毎回出す。
   */
  coversFallbacks: number;
  checkedAtoms: number;
  checkedTerms: number;
  acknowledgedUsed: number;
  acknowledgedUnused: string[];
  findings: CoverageFinding[];
};

/** report の該当範囲を切り出す。範囲が見つからなければ例外（登録が腐ったまま緑になるのを防ぐ）。 */
export async function readPassage(passage: Passage): Promise<{ lines: string[] }> {
  const path = join(projectRoot, passage.report);
  const all = (await readFile(path, "utf8")).split("\n");
  const start = all.findIndex((line) => line.includes(passage.from));
  if (start < 0) throw new Error(`${passage.report}: 開始の目印が無い: ${passage.from}`);
  const rel = all.slice(start).findIndex((line) => line.includes(passage.to));
  if (rel < 0) throw new Error(`${passage.report}: 終了の目印が無い: ${passage.to}`);
  return { lines: all.slice(start, start + rel + 1) };
}

/** 1 行を「数式の中」と「地の文」へ分ける（`$...$` と `$$...$$`）。 */
export function splitMath(line: string): { math: string[]; prose: string } {
  const math: string[] = [];
  const prose: string[] = [];
  let i = 0;
  while (i < line.length) {
    if (line[i] === "$") {
      const delim = line.startsWith("$$", i) ? "$$" : "$";
      const end = line.indexOf(delim, i + delim.length);
      if (end < 0) { prose.push(line.slice(i)); break; }
      math.push(line.slice(i + delim.length, end));
      i = end + delim.length;
      continue;
    }
    const next = line.indexOf("$", i);
    prose.push(line.slice(i, next < 0 ? undefined : next));
    if (next < 0) break;
    i = next;
  }
  return { math, prose: prose.join("") };
}

/**
 * **条件・例外・仮定を述べている文**の目印。
 *
 * 検査 A が探しているのは「report にあった**条件**が本文で落ちる」型の事故なので、
 * report の全文ではなくこの目印を含む文だけを見る。過去 3 件はいずれもここに入る:
 *   - cycle 18 の「**ただし** $S(N)$ が高位で消える **Skolem–Mahler–Lech 例外**（算術級数の有限和）」
 *   - cycle 20 の「最後の等号は cycle 18 補題 A2 (1)（$A_1\equiv0$ …）**から従う**」
 * 目印を増やすと拾う文が増え、免除の登録が増える。減らすと見落としが増える。
 * **どちらへ倒すかは「見落としを許さない」側**へ倒してある（免除は書けばよい）。
 */
const CONDITION_MARKERS = [
  "ただし", "例外", "仮定", "条件", "限る", "限り", "を除", "除く", "必要", "十分",
  "なければ", "でなければ", "ないと", "反例", "偽", "暗黙", "から従う", "使う", "要する",
  "とき", "ならば", "成り立たない", "注意", "一般に", "ときに限", "無限", "有限",
];

/**
 * **`positioning` の目印**（cycle 26 step 4）。
 *
 * `positioning` は「report が自分の作業を位置づける言葉であって主張ではない」という免除だが、
 * cycle 25 までは**引用が何であっても通った**（型の限界として件数を出すだけだった）。
 * ここに閉じた語彙を置き、**引用がこのどれかを含むことを必須にする**。
 * これで「ただの数学の文を positioning と名乗って黙らせる」ことができなくなる。
 *
 * 語彙は **report が自分（この作業・この文書）について語るときの言い回し**だけで構成する。
 * 数学の内容を指す語は入れない（入れると目印の意味が無くなる）。
 * 増やすときは、その語が自己言及であることを説明できる場合に限る。
 */
export const POSITIONING_MARKERS = [
  "本サイクル",
  "本 step",
  "本ステップ",
  "本レビュー",
  "本検証",
  "本論文",
  "本節",
  "副産物",
  "訂正",
  "以下では",
  "ここでは",
  "未確認",
  "新規性は主張しない",
  "記録として",
  "位置づけ",
] as const;

/** 条件・例外・仮定を述べている文だけを残す。 */
export function conditionSentences(lines: readonly string[]): string[] {
  // 1 つの文が改行で 2 行に分かれていることがある（実際 cycle 20 の $A_1\equiv0$ は
  // 「から従う」と別の行にあった）。空行と表の行を区切りとして、地続きの行を連結してから文へ切る。
  const paragraphs: string[] = [];
  let current: string[] = [];
  const flush = (): void => { if (current.length > 0) paragraphs.push(current.join("")); current = []; };
  for (const line of lines) {
    if (line.trim() === "" || line.trimStart().startsWith("|")) { flush(); if (line.trimStart().startsWith("|")) paragraphs.push(line); continue; }
    current.push(line.trim());
  }
  flush();
  const sentences = paragraphs
    .flatMap((line) => line.split(/(?<=。)/))
    .map((s) => s.trim())
    .filter((s) => s !== "");
  return sentences.filter((s) => CONDITION_MARKERS.some((marker) => s.includes(marker)));
}

/**
 * 検査 A 本体。
 *
 * report の該当範囲のうち**条件・例外・仮定を述べている文**に現れる
 * 飾りつきの数式アトムと専門語が、本文ブロックに 1 つも現れないなら
 * 「落ちた疑い」として挙げる。免除は項目単位でしか書けない。
 */
export function checkCoverage(
  link: SourceLink,
  view: BlockView,
  passageLines: readonly { passage: Passage; lines: string[] }[],
): CoverageResult {
  const blockAtoms = new Set<string>();
  for (const tex of view.formulas) for (const atom of atomsOf(tex)) blockAtoms.add(atom);
  const blockText = view.prose + " " + view.formulas.join(" ");

  const acknowledged = new Map(link.acknowledged.map((a) => [a.item, a.reason]));
  const used = new Set<string>();
  const findings: CoverageFinding[] = [];

  const atomWhere = new Map<string, string>();
  const termWhere = new Map<string, string>();
  const atoms = new Set<string>();
  const terms = new Set<string>();
  let lineCount = 0;
  let sentenceCount = 0;
  let coversFallbacks = 0;
  for (const { passage, lines } of passageLines) {
    const scoped = passage.quotedOnly === true
      ? lines.filter((line) => line.trimStart().startsWith(">"))
      : lines;
    lineCount += scoped.length;
    const fromReport = conditionSentences(scoped);
    sentenceCount += fromReport.length;
    // **条件文が 1 文も取れなかった passage は、台帳の `covers` を照合対象へ回す**
    // （cycle 26 step 4。それまでは何も照合せず、目印が生きていることしか見ていなかった）。
    const usedCovers = fromReport.length === 0;
    if (usedCovers) coversFallbacks += 1;
    const picked = usedCovers ? [passage.covers] : fromReport;
    for (const line of picked) {
      const found = itemsOfSentence(line);
      for (const atom of found.atoms) {
        atoms.add(atom);
        if (!atomWhere.has(atom)) atomWhere.set(atom, line.trim());
      }
      for (const term of found.terms) {
        terms.add(term);
        if (!termWhere.has(term)) termWhere.set(term, line.trim());
      }
    }
  }

  for (const atom of [...atoms].sort()) {
    if (blockAtoms.has(atom)) continue;
    if (acknowledged.has(atom)) { used.add(atom); continue; }
    findings.push({ block: link.block, kind: "atom", item: atom, where: atomWhere.get(atom) ?? "" });
  }
  for (const term of [...terms].sort()) {
    if (blockText.includes(term)) continue;
    if (acknowledged.has(term)) { used.add(term); continue; }
    findings.push({ block: link.block, kind: "term", item: term, where: termWhere.get(term) ?? "" });
  }

  return {
    block: link.block,
    passageLines: lineCount,
    conditionSentences: sentenceCount,
    coversFallbacks,
    checkedAtoms: atoms.size,
    checkedTerms: terms.size,
    acknowledgedUsed: used.size,
    acknowledgedUnused: [...acknowledged.keys()].filter((item) => !used.has(item)).sort(),
    findings,
  };
}

/**
 * 1 つの文から、照合対象になる**飾りつきの数式アトム**と**専門語**を取り出す。
 *
 * `checkCoverage` と、免除の根拠検査（`checkExemptionGrounds`）が**同じ手続き**を使う。
 * 別々に書くと、免除の根拠として指した文から実際にはその項目が出ない、という
 * 食い違いが起きうる（＝根拠が根拠になっていない状態が緑で通る）。
 */
export function itemsOfSentence(sentence: string): { atoms: Set<string>; terms: Set<string> } {
  const { math, prose } = splitMath(sentence);
  const atoms = new Set<string>();
  for (const tex of math) for (const atom of atomsOf(tex)) if (isDistinctiveAtom(atom)) atoms.add(atom);
  return { atoms, terms: new Set(proseTerms(prose)) };
}

/**
 * 照合に使うアトムかどうか。
 *
 * 裸の 1 文字（`x` / `N`）と数字は、どの文脈にも現れるので「落ちた」の証拠にならない。
 * **飾りのついた記号**（`A_1`, `\mu_\gamma`, `\bar A_{\ell^L}`）と**マクロ**（`\theta`, `\binom`）だけを見る。
 */
export function isDistinctiveAtom(atom: string): boolean {
  if (/^[0-9]/.test(atom)) return false;
  const base = /^\\?[a-zA-Z]*/.exec(atom)?.[0] ?? "";
  if (base === "" || OPERATOR_MACROS.has(base)) return false;
  if (atom.startsWith("\\")) return true;
  return atom.includes("_") || atom.includes("^");
}

/**
 * 関係・演算・組版のマクロ。**記号ではなく記号の間の書き方**なので、
 * report と本文で書き方が違っても内容は落ちていない。
 */
const OPERATOR_MACROS = new Set([
  "\\le", "\\ge", "\\lt", "\\gt", "\\neq", "\\ne", "\\equiv", "\\sim", "\\simeq", "\\cong",
  "\\in", "\\notin", "\\subset", "\\subseteq", "\\supset", "\\supseteq", "\\cup", "\\cap",
  "\\setminus", "\\times", "\\cdot", "\\pm", "\\mp", "\\mid", "\\nmid", "\\to", "\\mapsto",
  "\\rightarrow", "\\Rightarrow", "\\leftarrow", "\\Leftarrow", "\\iff", "\\implies",
  "\\forall", "\\exists", "\\emptyset", "\\infty", "\\dots", "\\cdots", "\\ldots", "\\vdots",
  "\\sum", "\\prod", "\\int", "\\min", "\\max", "\\inf", "\\sup", "\\lim", "\\bmod", "\\pmod",
  "\\blacksquare", "\\square", "\\displaystyle", "\\text", "\\textbf", "\\textit", "\\mbox",
  "\\frac", "\\binom", "\\sqrt", "\\bigl", "\\bigr", "\\Bigl", "\\Bigr", "\\left", "\\right",
  "\\lfloor", "\\rfloor", "\\lceil", "\\rceil", "\\langle", "\\rangle", "\\colon", "\\ast",
  "\\Longrightarrow", "\\Longleftarrow", "\\longrightarrow", "\\boxed", "\\deg", "\\det",
  "\\dim", "\\gcd", "\\operatorname", "\\mathrm", "\\mathbb", "\\mathcal", "\\mathfrak",
]);

// --- 検査 A′: 免除の根拠が生きているか（cycle 24 step 3） -------------------------

export type GroundsFinding = {
  block: string;
  item: string;
  /** 何が壊れているか（人が読む短い名前）。 */
  kind:
    | "根拠の引用が report に無い"
    | "根拠の引用が report の複数の文に当たる"
    | "根拠の文からその項目が出ない"
    | "根拠として指した本文の記述が本文に無い"
    | "分担先のブロックが本文に無い"
    | "分担先のブロックがその項目を持っていない"
    | "参照先の記録が見つからない"
    | "positioning の目印が引用に無い"
    | "根拠の指定が短すぎて何も pin していない";
  detail: string;
};

/** 根拠の文字列がこれより短いと、何を pin しているのか特定できない。 */
const MIN_REPORT_QUOTE = 12;
const MIN_BODY_QUOTE = 4;
const MIN_MARKER = 10;

/**
 * **免除の根拠が生きているかを検査する（検査 A′）。**
 *
 * cycle 23 の限界（「免除そのものを機械検証する手段は無い」）に対する答え。
 * 免除は次のいずれかが起きたら**黙って生き残ってはならない**:
 *   - 根拠 report が書き換わった／その文がその項目を生まなくなった（共通検査）
 *   - 免除が「本文はこう書いている」と言っている記述が本文から消えた（`bodyQuote` 系）
 *   - 「別のブロックが持っている」と言っている分担先が、それを失った（`division`）
 *   - 「後のサイクルが解消済み」「本文の不備として記録済み」の参照先が消えた
 *
 * 挙がったものは**違反**（`verify-transcription.ts` が exit 1 にする）。
 */
export async function checkExemptionGrounds(
  link: SourceLink,
  view: BlockView,
  passageLines: readonly { passage: Passage; lines: string[] }[],
  blocks: ReadonlyMap<string, BlockView>,
): Promise<GroundsFinding[]> {
  const sentences: string[] = [];
  for (const { passage, lines } of passageLines) {
    const scoped = passage.quotedOnly === true
      ? lines.filter((line) => line.trimStart().startsWith(">"))
      : lines;
    const fromReport = conditionSentences(scoped);
    // checkCoverage と**同じ**フォールバックを掛ける（cycle 26 step 4）。
    // ここを揃えないと、`covers` から出た項目に免除を書いても
    // 「根拠の引用が report に無い」で落ちて、免除が書けなくなる。
    sentences.push(...(fromReport.length === 0 ? [passage.covers] : fromReport));
  }
  const blockText = view.prose + " " + view.formulas.join(" ");
  const out: GroundsFinding[] = [];
  const add = (item: string, kind: GroundsFinding["kind"], detail: string): void => {
    out.push({ block: link.block, item, kind, detail });
  };

  for (const { item, grounds } of link.acknowledged) {
    // --- 共通 1: 引用が条件文のちょうど 1 文に当たること ---
    // 短い引用は原則として禁じる（何を pin しているのか特定できないため）。
    // ただし**文そのものが短い**ことはある（report の「無条件決定可能。」等）。
    // その場合は**文全体と一致する引用**だけを許す。これは pin として完全である。
    const exact = sentences.filter((s) => s === grounds.reportQuote);
    if (grounds.reportQuote.length < MIN_REPORT_QUOTE && exact.length === 0) {
      add(item, "根拠の指定が短すぎて何も pin していない", `reportQuote が ${grounds.reportQuote.length} 文字（${MIN_REPORT_QUOTE} 文字以上にするか、条件文 1 文と完全一致させること）: "${grounds.reportQuote}"`);
      continue;
    }
    const hits = exact.length > 0 ? exact : sentences.filter((s) => s.includes(grounds.reportQuote));
    if (hits.length === 0) {
      add(item, "根拠の引用が report に無い", `report が書き換わった可能性がある。免除を判定し直すこと: "${grounds.reportQuote}"`);
      continue;
    }
    if (hits.length > 1) {
      add(item, "根拠の引用が report の複数の文に当たる", `${hits.length} 文に当たる。どの文が根拠かを一意に特定できる引用にすること: "${grounds.reportQuote}"`);
      continue;
    }
    // --- 共通 2: その文から実際にその項目が出ること ---
    const produced = itemsOfSentence(hits[0]!);
    if (!produced.atoms.has(item) && !produced.terms.has(item)) {
      add(item, "根拠の文からその項目が出ない", `指した文はこの項目を生まない（別の文を指しているか、report がその語を落とした）: "${truncateForMessage(hits[0]!)}"`);
      continue;
    }
    // --- 型ごとの検査 ---
    if (grounds.type === "positioning") {
      // cycle 26 step 4: 「主張ではない」ことは機械で確かめられないが、
      // **report が自分の作業について語っている文であること**の目印は確かめられる。
      // 目印が無ければ、その文はただの数学の文であって positioning ではない。
      if (!POSITIONING_MARKERS.some((marker) => grounds.reportQuote.includes(marker))) {
        add(
          item,
          "positioning の目印が引用に無い",
          `引用が report の自己言及の語彙（${POSITIONING_MARKERS.join(" / ")}）を 1 つも含まない。` +
            `ただの数学の文を positioning と名乗って黙らせることはできない: "${grounds.reportQuote}"`,
        );
      }
      continue; // 検証できるのはここまで（型の限界。件数を毎回出す）
    }
    if (grounds.type === "notation" || grounds.type === "weaker" || grounds.type === "example" || grounds.type === "paraphrase") {
      if (grounds.bodyQuote.length < MIN_BODY_QUOTE) {
        add(item, "根拠の指定が短すぎて何も pin していない", `bodyQuote が ${grounds.bodyQuote.length} 文字: "${grounds.bodyQuote}"`);
      } else if (!blockText.includes(grounds.bodyQuote)) {
        add(item, "根拠として指した本文の記述が本文に無い", `本文が書き換わった可能性がある。免除を判定し直すこと: "${grounds.bodyQuote}"`);
      }
      continue;
    }
    if (grounds.type === "division") {
      const holder = blocks.get(grounds.holder);
      if (holder === undefined) {
        add(item, "分担先のブロックが本文に無い", `${grounds.holder} が存在しない`);
        continue;
      }
      const holderText = holder.prose + " " + holder.formulas.join(" ");
      if (!holderText.includes(grounds.holderItem)) {
        add(item, "分担先のブロックがその項目を持っていない", `${grounds.holder} に "${grounds.holderItem}" が無い。分担先が落としたなら、論文全体からその内容が落ちている`);
      }
      continue;
    }
    const ref = grounds.type === "reportStale" ? grounds.supersededBy : grounds.recordedIn;
    if (ref.marker.length < MIN_MARKER) {
      add(item, "根拠の指定が短すぎて何も pin していない", `marker が ${ref.marker.length} 文字: "${ref.marker}"`);
      continue;
    }
    let text: string;
    try {
      text = await readFile(join(projectRoot, ref.report), "utf8");
    } catch {
      add(item, "参照先の記録が見つからない", `${ref.report} が読めない`);
      continue;
    }
    if (!text.includes(ref.marker)) {
      add(item, "参照先の記録が見つからない", `${ref.report} に "${ref.marker}" が無い`);
    }
  }
  return out;
}

function truncateForMessage(s: string): string {
  return s.length <= 100 ? s : s.slice(0, 100) + " …";
}

// --- 検査 B: 添字族の裸使用 -----------------------------------------------------

export type BareFamilyFinding = {
  block: string;
  symbol: string;
  boundVariable: string;
  /** 束縛子（`\sum_{...}`）の文字列。 */
  binder: string;
  /** その記号が添字つきで使われている例（同じブロック内）。 */
  indexedExample: string;
  formula: string;
};

/**
 * **添字族の裸使用**を検出する。
 *
 * 動機（cycle 21 の事故そのもの）: 本文は
 * `g_c(y)=\sum_{\gamma\in\mathcal{G}_c}\mu\,(1+y)^{\gamma}` と書いていたが、
 * 正しくは `\mu_{c+\ell\gamma}` である。同じブロックが 2 つ前の displayMath で
 * `\mu_\gamma=\sum_{pa+qb=\gamma}\bar c_{pq}` と**族として定義している**のに、
 * その族を $\gamma$ で束縛された和の中で**添字なしで**使っていた。
 *
 * 規則: 記号 $S$ が同じブロック内で「束縛変数 $v$ を含む添字つき」で現れているとき、
 * $v$ を束縛する `\sum` / `\prod` などの**被和の中に裸の $S$** があれば違反とする。
 *
 * この規則が**当たらない**もの: $S$ が同じブロックで別の意味に使われていても、
 * その裸の使用が $v$ の束縛の中に無ければ挙げない（例: 岩澤 $\mu$ 不変量は
 * $\gamma$ の和の外にあるので挙がらない）。逆に、族の定義がブロック内に無い場合
 * （別ブロックで定義された族を使っている場合）は検出できない。
 */
export function checkBareFamilyUse(view: BlockView): BareFamilyFinding[] {
  const indexedUse = new Map<string, Map<string, string>>(); // symbol -> variable -> example
  for (const tex of view.formulas) {
    for (const atom of atomsOf(tex)) {
      const cut = atom.indexOf("_");
      if (cut < 0) continue;
      const base = atom.slice(0, cut);
      if (base === "" || !/^\\?[a-zA-Z]+$/.test(base)) continue;
      const script = atom.slice(cut);
      for (const variable of variablesIn(script)) {
        const perSymbol = indexedUse.get(base) ?? new Map<string, string>();
        if (!perSymbol.has(variable)) perSymbol.set(variable, atom);
        indexedUse.set(base, perSymbol);
      }
    }
  }

  const findings: BareFamilyFinding[] = [];
  for (const tex of view.formulas) {
    for (const { binder, boundVariables, body } of binderScopes(tex)) {
      const bareBases = new Set(
        atomsOf(body).filter((a) => !a.includes("_") && !a.includes("^")),
      );
      for (const variable of boundVariables) {
        for (const base of bareBases) {
          const example = indexedUse.get(base)?.get(variable);
          if (example === undefined) continue;
          findings.push({
            block: view.id,
            symbol: base,
            boundVariable: variable,
            binder,
            indexedExample: example,
            formula: tex.replaceAll(/\s+/g, " ").trim(),
          });
        }
      }
    }
  }
  return findings;
}

/** 添字の文字列に現れる変数（マクロと 1 文字英字）。 */
function variablesIn(script: string): string[] {
  return tokenize(script)
    .filter((t) => t.kind === "macro" || t.kind === "letter")
    .map((t) => t.text);
}

/**
 * 束縛子の添字から**束縛変数**を取り出す。
 *
 * `\gamma\in\mathcal{G}_c` なら $\gamma$、`c=0` なら $c$。
 * 走る対象は `\in` / `=` の**左辺**にあるので、右辺（走る範囲）は見ない。
 * 肩（`^`）に乗っている記号も外す——`\prod_{z_i^L=1}` の $L$ は走る変数ではなく
 * 固定された段数であり、これを束縛変数と読むと無関係な記号を巻き込む（実測で偽陽性 1 件が出た）。
 */
export function boundVariablesOf(script: string): string[] {
  const cut = script.search(/\\in|=/);
  const lhs = cut < 0 ? script : script.slice(0, cut);
  const tokens = tokenize(lhs);
  const out: string[] = [];
  for (let i = 0; i < tokens.length; i += 1) {
    const t = tokens[i]!;
    if (t.kind !== "macro" && t.kind !== "letter") continue;
    if (i > 0 && isUnderSuperscript(tokens, i)) continue;
    out.push(t.text);
  }
  return out;
}

/** その字句が `^` の直後（もしくは `^{...}` の中）にあるか。 */
function isUnderSuperscript(tokens: readonly Token[], index: number): boolean {
  let depth = 0;
  for (let i = index - 1; i >= 0; i -= 1) {
    const t = tokens[i]!;
    if (t.text === "}") depth += 1;
    else if (t.text === "{") { if (depth === 0) { return tokens[i - 1]?.text === "^"; } depth -= 1; }
    else if (depth === 0 && t.text === "^") return i === index - 1;
    else if (depth === 0 && (t.kind === "macro" || t.kind === "letter" || t.kind === "digits")) return false;
  }
  return false;
}

const BINDER_MACROS = ["\\sum", "\\prod", "\\bigcup", "\\bigcap", "\\bigoplus", "\\coprod"];

/**
 * `\sum_{...}` 等の束縛子と、その被和とみなす範囲を返す。
 *
 * 構文解析はしないので、被和は「束縛子の直後から、同じ深さの `,` / `\qquad` / `\\` /
 * 行末までのいずれか早い方」とする粗い近似である。**範囲を狭く取る**ので、
 * 見落とし（偽陰性）は起きるが、無関係な部分を巻き込む偽陽性は起きにくい。
 */
export function binderScopes(
  tex: string,
): { binder: string; boundVariables: string[]; body: string }[] {
  const out: { binder: string; boundVariables: string[]; body: string }[] = [];
  for (const macro of BINDER_MACROS) {
    let index = tex.indexOf(macro);
    while (index >= 0) {
      let i = index + macro.length;
      const scripts: string[] = [];
      while (tex[i] === "_" || tex[i] === "^") {
        const [group, next] = readRawGroup(tex, i + 1);
        if (group === undefined) break;
        if (tex[i] === "_") scripts.push(group);
        i = next;
      }
      if (scripts.length > 0) {
        out.push({
          binder: macro + "_{" + scripts.join("") + "}",
          boundVariables: [...new Set(scripts.flatMap((s) => boundVariablesOf(s)))],
          body: bodyAfter(tex, i),
        });
      }
      index = tex.indexOf(macro, index + macro.length);
    }
  }
  return out;
}

function readRawGroup(tex: string, start: number): [string | undefined, number] {
  if (tex[start] !== "{") {
    const m = /^\\[a-zA-Z]+|^./.exec(tex.slice(start));
    if (m === null) return [undefined, start];
    return [m[0], start + m[0].length];
  }
  let depth = 0;
  for (let i = start; i < tex.length; i += 1) {
    if (tex[i] === "{") depth += 1;
    else if (tex[i] === "}") { depth -= 1; if (depth === 0) return [tex.slice(start + 1, i), i + 1]; }
  }
  return [undefined, start];
}

function bodyAfter(tex: string, start: number): string {
  let depth = 0;
  for (let i = start; i < tex.length; i += 1) {
    const c = tex[i]!;
    if (c === "{") depth += 1;
    else if (c === "}") depth -= 1;
    else if (depth === 0) {
      if (c === "," || c === "\n") return tex.slice(start, i);
      if (tex.startsWith("\\qquad", i) || tex.startsWith("\\\\", i) || tex.startsWith("\\quad", i)) {
        return tex.slice(start, i);
      }
    }
  }
  return tex.slice(start);
}
