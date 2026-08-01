#!/usr/bin/env node
/**
 * 最終成果物（論文）の生成器。**入力は選んだロケールの content だけ**。
 *
 * README 7 節「証明の正本は content/。ここだけから最終成果物を生成する」を実装する。
 * `notes/` は文書本体ではないので、このファイルは `loadNoteFiles` を**呼ばない**
 * （混入していないことは `tools/verify-no-notes-in-output.ts` が機械的に検査する）。
 *
 * **生成器は 1 本である**（cycle 24 step 2）。それ以前は英語版が
 * `structured-latex-en/tools/build-latex.ts` として生成器ごと複製されており、
 * 検査が片方にしか入っていない状態が実際に生じていた。言語で変わるもの
 * （見出し語・プリアンブル・書誌の有無・強調の書式）は `tools/editions.ts` に集約し、
 * **検査はここで全版に同じものを掛ける**。
 *
 * 変換規則:
 *   - 文書順 = content のファイル名昇順 × 各ファイルの配列順（＝正準表現をそのまま使う）
 *   - 見出し `level` 1..6 → `\section` / `\subsection` / ... の節構造
 *   - 定理型ブロック → amsthm の環境（definition / claim / theorem / remark / note）
 *   - `proof` → `proof` 環境
 *   - ブロックの `labels` → `\label{lab:<ラベル>}`、`ref()` → `\cref{lab:<ラベル>}`
 *   - `math` → `$...$`、`displayMath` → `\[...\]`（KaTeX 向けの LaTeX 文字列をそのまま渡す）
 *   - `list` → `itemize`、`todo` → 目立つ未完マーカー
 *   - `cite` → `\cite[note]{keys}`（書誌を持つ版だけ。持たない版に来たら落とす）
 *
 * 使い方:
 *   node tools/build-latex.ts                     原文の .tex を生成する
 *   node tools/build-latex.ts --locale en         英語版の .tex を生成する
 *   node tools/build-latex.ts --pdf               .tex を生成し tectonic で PDF まで作る
 */

import { spawnSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { join, relative } from "node:path";

import type { TranslatedBlock, TranslatedNode } from "../schema.ts";
import {
  loadContentFilesForLocale,
  localeFromArgv,
  structuredLatexDir,
} from "./content-modules.ts";
import { bibKeysOf, editionFor, readBib, stripNoteFields } from "./editions.ts";
import { escapeText } from "./latex-escape.ts";
import { unicodeMathToLatex } from "./unicode-math.ts";

type HeadingBlock = Extract<TranslatedBlock, { kind: "heading" }>;
type TheoremLikeBlock = Exclude<TranslatedBlock, { kind: "heading" } | { kind: "figure" }>;
type Node = TranslatedNode;

const locale = localeFromArgv();
const edition = editionFor(locale);
const buildDir = join(structuredLatexDir, "build", edition.buildSubdir);
const texPath = join(buildDir, "document.tex");
const pdfPath = join(buildDir, "document.pdf");
const withPdf = process.argv.includes("--pdf");

/**
 * 見出しの深さ → LaTeX の節コマンド。
 * 複製元（Ising 側）は level 1 を `\part` へ写すが、**本プロジェクトでは level 1 が章**である
 * （部に相当する層を持たない）。そのため level 1 を `\section` から始める。
 */
const SECTION_COMMANDS = [
  "section",
  "subsection",
  "subsubsection",
  "paragraph",
  "subparagraph",
  "subparagraph",
] as const;

// --- 書誌（持つ版だけ）--------------------------------------------------------
//
// **書誌の正本は 1 つだけである**（`integrable-lattice/outputs/papers/001_R_Lambda_duality/refs.bib`）。
// リポジトリへ複製は作らない。ここで作るのは、その 1 つの正本から**ビルド時に導出する**
// gitignore 済みの中間物だけである。
//
// なぜ素通しでなく導出が要るか（実測に基づく）:
//   正本の各エントリは `note` フィールドに日本語の来歴メモを持っている。これはプロジェクト内部の
//   記録であって、投稿稿に出してよいものではない。加えて `plain.bst` は `note` を印字するので、
//   欧文フォントに無い和字が**無言で消えた状態**の参考文献リストが出来る（実測: Missing character
//   が 200 件超）。したがって `note` を落としてから BibTeX へ渡す。**落とすのは note だけ。**
const bibPath =
  edition.citations === null ? null : join(structuredLatexDir, ...edition.citations.bibPath);
if (bibPath !== null && !existsSync(bibPath)) {
  throw new Error(`参考文献データベースが無い: ${bibPath}`);
}
const bibSource = bibPath === null ? "" : readBib(bibPath);
const bibKeys = bibKeysOf(bibSource);

const contentFiles = await loadContentFilesForLocale(locale);

// ラベル → ブロック id。相互参照の解決に使う（型でも保証済みだが、生成時にも確かめる）。
const labelOwner = new Map<string, string>();
for (const { blocks } of contentFiles) {
  for (const block of blocks) {
    for (const label of block.labels) labelOwner.set(label, block.id);
  }
}

const usedRefs: { target: string; blockId: string }[] = [];
const usedCites: { key: string; blockId: string }[] = [];
const suspiciousTexts: { blockId: string; sample: string }[] = [];
const unmatchedBold: { blockId: string; sample: string }[] = [];
const body: string[] = [];
let blockCount = 0;
let headingCount = 0;
let proofCount = 0;
let todoCount = 0;

for (const { blocks } of contentFiles) {
  for (const block of blocks) {
    blockCount += 1;
    if (block.kind === "heading") {
      headingCount += 1;
      body.push(renderHeading(block));
      continue;
    }
    if (block.kind === "figure") {
      // 図表はシステムの語彙には在るが、本論文はまだ 1 件も使っていない。
      // 使い始めたときに「黙って出力から消える」ことがないよう、ここで明示的に落とす。
      throw new Error(`図表ブロック（${block.id}）の LaTeX 出力は未実装`);
    }
    body.push(renderTheoremLike(block));
  }
}

// 相互参照の解決検査（未解決が 1 件でもあれば生成を中止する）。
const unresolved = usedRefs.filter((use) => !labelOwner.has(use.target));
if (unresolved.length > 0) {
  const detail = unresolved.map((use) => `  ${use.blockId} -> "${use.target}"`).join("\n");
  throw new Error(`未解決の相互参照がある（生成を中止）:\n${detail}`);
}

// 引用キーの実在検査（.bib に無いキーは PDF で [?] になる。生成前に落とす）。
const unknownCites = usedCites.filter((use) => !bibKeys.has(use.key));
if (unknownCites.length > 0 && bibPath !== null) {
  const detail = unknownCites.map((use) => `  ${use.blockId} -> "${use.key}"`).join("\n");
  throw new Error(
    `${relative(structuredLatexDir, bibPath)} に無い引用キーがある（生成を中止）:\n${detail}`,
  );
}

// 対応の取れない `**` は PDF に素のアスタリスクとして出る（投稿稿では明白な瑕疵）。
if (unmatchedBold.length > 0) {
  const detail = unmatchedBold.map((item) => `  ${item.blockId}: ${item.sample}`).join("\n");
  throw new Error(
    `対応の取れない ** が地の文にある（PDF にアスタリスクがそのまま出る）:\n${detail}\n` +
      "  強調は 1 つのノードの中で閉じること（ノードをまたぐ ** は組めない）。",
  );
}

mkdirSync(buildDir, { recursive: true });

let bibSpecifier = "";
if (edition.citations !== null && bibPath !== null) {
  bibSpecifier = edition.citations.derivedName;
  const stripped = stripNoteFields(bibSource);
  // 正本の `%` 行はプロジェクト内部の日本語コメントである（BibTeX はエントリ外を無視するので
  // 出力には影響しないが、導出物に残しても意味が無いので落とす）。
  const derivedBib = stripped.text
    .split("\n")
    .filter((line) => !/^\s*%/.test(line))
    .join("\n");
  // 落とし残しがあると和字が無言で消えるので、残った非 ASCII は 1 件でも通さない。
  const leftover = [...new Set([...derivedBib].filter((char) => char.charCodeAt(0) > 0x7f))];
  if (leftover.length > 0) {
    throw new Error(
      `note を落とした後の書誌に非 ASCII 文字が残っている（欧文フォントで無言で消える）: ${leftover.join(" ")}\n` +
        `  対処: ${relative(structuredLatexDir, bibPath)} の該当箇所を LaTeX の記法へ直すこと。`,
    );
  }
  writeFileSync(
    join(buildDir, `${edition.citations.derivedName}.bib`),
    // ヘッダも ASCII の英語にする。上の非 ASCII 検査はヘッダを付ける前に走るので、
    // ここに日本語を書くと検査をすり抜けて導出物へ残る。
    `% Generated file - do not edit.\n` +
      `% Source: ${relative(buildDir, bibPath)} ` +
      `(note fields and %-comments removed).\n` +
      derivedBib,
    "utf8",
  );
}

writeFileSync(
  texPath,
  edition.renderDocument({
    inner: body.join("\n\n"),
    renderProse,
    escape: escapeText,
    renderNodes: renderNodes as (nodes: readonly never[], blockId: string) => string,
    hasNoCitations: usedCites.length === 0,
    bibSpecifier,
  }),
  "utf8",
);

// 地の文に「数式のつもりの記法」が混じっていると、そのまま素の文字として組まれる
// （例: text ノードの "2^M" は上付きにならない）。content 側の判断材料として警告する。
if (suspiciousTexts.length > 0) {
  console.warn(
    `警告: 地の文に数式記法らしき文字がある ${suspiciousTexts.length} 件` +
      "（そのままの文字として組まれる。math ノードにするか記法を直すこと）:",
  );
  for (const item of suspiciousTexts.slice(0, 10)) {
    console.warn(`  ${item.blockId}: ${item.sample}`);
  }
}

if (edition.citations !== null && usedCites.length === 0) {
  // 引用が 1 件も無いと BibTeX は参考文献リストを作らない（"I found no \citation commands"）。
  // 過渡的な状態なので `\nocite{*}` で .bib 全件を出し、BibTeX 経路が実際に通ることを
  // 毎回のビルドで確かめられるようにしてある。引用が入れば自動的に通常の挙動へ戻る。
  console.warn(
    `警告: cite ノードが 1 件も無い。過渡措置として \\nocite{*} で ${bibKeys.size} 件すべてを出力する` +
      "（本文が引用を持てば自動的に引用分だけになる）。",
  );
}

console.log(
  `generated ${texPath}\n` +
    `  ブロック ${blockCount} 件（見出し ${headingCount}、証明 ${proofCount}、TODO ${todoCount}）` +
    ` / ラベル ${labelOwner.size} 件 / 相互参照 ${usedRefs.length} 件（すべて解決）` +
    (edition.citations === null
      ? ""
      : ` / 引用 ${usedCites.length} 件（.bib のキー ${bibKeys.size} 件、すべて実在）`),
);

if (!withPdf) {
  console.log("  PDF まで作るには --pdf を付ける");
  process.exit(0);
}

// --- PDF ビルド --------------------------------------------------------------
const tectonicArgs = ["-X", "compile", "--keep-logs"];
if (edition.citations !== null) tectonicArgs.push("--keep-intermediates");
const result = spawnSync("tectonic", [...tectonicArgs, texPath], {
  cwd: buildDir,
  encoding: "utf8",
  maxBuffer: 64 * 1024 * 1024,
});
if (result.error !== undefined) {
  throw new Error(
    `tectonic を起動できなかった: ${result.error.message}\n  導入: brew install tectonic`,
  );
}
const output = `${result.stdout ?? ""}${result.stderr ?? ""}`;
if (result.status !== 0) {
  writeFileSync(join(buildDir, "tectonic-error.log"), output, "utf8");
  const errorLines = output
    .split("\n")
    .filter((line) => /^error|! |Undefined control sequence|Missing/.test(line))
    .slice(0, 30);
  throw new Error(
    `PDF のビルドに失敗した（詳細: ${join(buildDir, "tectonic-error.log")}）:\n${errorLines.join("\n")}`,
  );
}

// LaTeX の警告は **stdout ではなくログファイル**にしか出ない（tectonic は要約しか出さない）。
// 実測: `\cref{lab:missing}` を含む文書でも tectonic の終了コードは 0、stdout に警告は無い。
const logText = readFileSync(join(buildDir, "document.log"), "utf8");

// 1. 未解決参照。
const undefinedRefs = [
  ...logText.matchAll(/Reference `([^']+)' on page [^ ]+ undefined/g),
].map((m) => m[1]);
if (undefinedRefs.length > 0) {
  throw new Error(`PDF に未解決参照が残っている: ${[...new Set(undefinedRefs)].join(", ")}`);
}

// 2. 未定義の引用と、書誌が実際に組まれたこと（書誌を持つ版だけ）。
//    生成前のキー実在検査を通っても、BibTeX の実行が失敗すれば参考文献が丸ごと落ちる。
let bibitemCount = 0;
if (edition.citations !== null) {
  const undefinedCites = [
    ...logText.matchAll(/Citation `([^']+)' on page [^ ]+ undefined/g),
  ].map((m) => m[1]);
  if (undefinedCites.length > 0) {
    throw new Error(`PDF に未定義の引用がある: ${[...new Set(undefinedCites)].join(", ")}`);
  }
  const blgPath = join(buildDir, "document.blg");
  if (existsSync(blgPath)) {
    const blg = readFileSync(blgPath, "utf8");
    const bibErrors = blg
      .split("\n")
      .filter((line) =>
        /^Warning--I didn't find a database entry|^I couldn't open|error message/.test(line),
      );
    if (bibErrors.length > 0) {
      throw new Error(`BibTeX が書誌を解決できなかった:\n${bibErrors.slice(0, 20).join("\n")}`);
    }
  }
  const bblPath = join(buildDir, "document.bbl");
  const bblText = existsSync(bblPath) ? readFileSync(bblPath, "utf8") : "";
  bibitemCount = [...bblText.matchAll(/\\bibitem/g)].length;
  if (bibitemCount === 0) {
    throw new Error(
      `参考文献が組まれなかった（${bblPath} に \\bibitem が無い）。\n` +
        "  BibTeX が走っていないか、.bib を解決できていない。",
    );
  }
}

// 3. ラベルの重複（参照先が一意に決まらなくなる）。
if (/There were multiply-defined labels/.test(logText)) {
  const duplicated = [...logText.matchAll(/Label `([^']+)' multiply defined/g)].map((m) => m[1]);
  throw new Error(`PDF にラベルの重複がある: ${[...new Set(duplicated)].join(", ")}`);
}

// 4. フォントに無い文字は**無言で消える**ので、1 件でも許さない。
const missingChars = [
  ...new Set([...logText.matchAll(/Missing character: There is no (.) /g)].map((m) => m[1])),
];
if (missingChars.length > 0) {
  throw new Error(
    `PDF に組めない文字がある（出力から無言で消える）: ${missingChars.join(" ")}\n` +
      "  対処: tools/unicode-math.ts の対応表か、tools/editions.ts のプリアンブルへ追加する。",
  );
}

// 5. 版面をはみ出した行。右余白（geometry の margin）を超えると紙の外へ出て内容が読めなくなる。
const RIGHT_MARGIN_PT = 71; // 25mm ≒ 71pt
const overfull = [...logText.matchAll(/Overfull \\hbox \(([0-9.]+)pt too wide\)/g)]
  .map((m) => Number(m[1]))
  .filter((width) => width > RIGHT_MARGIN_PT);
if (overfull.length > 0) {
  throw new Error(
    `版面から出て内容が切れている行が ${overfull.length} 件ある` +
      `（最大 ${Math.max(...overfull).toFixed(1)}pt 超過）。\n` +
      "  別行立て数式は fitdisplay が自動で縮めるので、残るのは地の文か行内数式。\n" +
      `  詳細: ${join(buildDir, "document.log")} の Overfull \\hbox`,
  );
}

const pageMatch = logText.match(/Output written on [^(]+\((\d+) pages?/);
const pageCount = pageMatch?.[1];
if (pageCount === undefined) {
  throw new Error("ビルドログからページ数を取得できなかった（ビルドが途中で終わった可能性）");
}

// 生成物にノートが混入していないことは verify-no-notes-in-output.ts が検査する。
const overfullAll = [...logText.matchAll(/Overfull \\hbox \(([0-9.]+)pt too wide\)/g)].length;
console.log(
  `built ${pdfPath}: ${pageCount} ページ、未解決参照 0 件、組めない文字 0 件、` +
    `版面外へ出た行 0 件（軽微な overfull ${overfullAll} 件は余白内）` +
    (edition.citations === null ? "" : `、参考文献 ${bibitemCount} 件`),
);

// --- レンダリング ------------------------------------------------------------

function renderHeading(block: HeadingBlock): string {
  const command = SECTION_COMMANDS[block.level - 1] ?? "paragraph";
  const title = renderTitle(block.title, block.id);
  const labels = block.labels.map((label) => `\\label{lab:${label}}`).join("");
  return `\\${command}{${title}}${labels}`;
}

/**
 * 住処（`habitat`）と ℝ 脱出（`realEscape`）の表示。
 *
 * 本プロジェクトの中核要求は「可算と非可算を分別し、**ℝ へ脱出した箇所を必ず明示する**」
 * （リポジトリ直下 CLAUDE.md / integrable-lattice README）。データとして持っているだけでは
 * 読者に伝わらないので、**最終成果物にも印字する**（投稿稿でも落とさない）。可算側は住処だけを
 * 小さく添え、非可算側は脱出の理由を枠付きで目立たせる。
 */
function renderHabitat(block: TheoremLikeBlock): string {
  const habitat = edition.habitatLabels[block.habitat];
  if (block.realEscape === undefined) {
    // `none`（数量を扱わないブロック）に「可算」と付けると意味が通らない。
    const qualifier = block.habitat === "none" ? "" : edition.countableQualifier;
    const [open, close] = edition.habitatBrackets;
    return `\\par\\smallskip\\noindent{\\small${open}${edition.habitatLead}${habitat}${qualifier}${close}}`;
  }
  return (
    `\\par\\smallskip\\noindent\\fbox{\\parbox{\\dimexpr\\linewidth-2\\fboxsep-2\\fboxrule}{%
` +
    `${edition.escapeHeading(habitat ?? block.habitat)}${renderProse(block.realEscape, block.id)}}}`
  );
}

function renderTheoremLike(block: TheoremLikeBlock): string {
  const { env } = edition.theorem[block.kind];
  // `]` を含むタイトル（例: `\arg^{[0,2\pi)}`）で引数が途中で切れないよう波括弧で包む。
  const title =
    block.title === null || block.title === undefined
      ? ""
      : `[{${renderTitle(block.title, block.id)}}]`;
  const anchors = [
    `\\label{blk:${block.id}}`,
    ...block.labels.map((label) => `\\label{lab:${label}}`),
  ].join("");
  const statement = renderNodes(block.statement, block.id);
  const parts = [
    `\\begin{${env}}${title}${anchors}\n${statement}\n${renderHabitat(block)}\n\\end{${env}}`,
  ];
  if (block.proof !== undefined && block.proof.length > 0) {
    proofCount += 1;
    parts.push(`\\begin{proof}\n${renderNodes(block.proof, block.id)}\n\\end{proof}`);
  }
  return parts.join("\n\n");
}

function renderTitle(
  title: { text?: string; tex?: string } | null | undefined,
  blockId = "(title)",
): string {
  if (title === null || title === undefined) return "";
  if (title.tex !== undefined) return `$${title.tex}$`;
  const text = title.text ?? "";
  // 地の文と同じく、数式記法らしき文字は素の文字として組まれてしまう
  // （実測: タイトルの "2^M" が上付きにならない）。
  if (/[\^_`]/.test(text)) suspiciousTexts.push({ blockId, sample: text.slice(0, 60) });
  return renderProse(text, blockId);
}

/**
 * 地の文 1 つ分。エスケープ → Unicode 数学記号の変換 → 強調の順で写す。
 * 順序を入れ替えてはならない（エスケープ前に `\textbf` を入れると `\` が潰れる）。
 */
function renderProse(value: string, blockId: string): string {
  return applyBold(unicodeMathToLatex(escapeText(value)), blockId);
}

/**
 * 本文は強調を `**...**` と書く。LaTeX は `*` を素の文字として組むので、変換しない版では
 * アスタリスクがそのまま出る。変換する版（投稿稿）では `\textbf{...}` へ写し、
 * 対応の取れない `**` を無言で通さず、呼び出し側でビルドを落とす。
 */
function applyBold(value: string, blockId: string): string {
  if (!edition.bold) return value;
  const converted = value.replace(/\*\*(.+?)\*\*/gs, (_match, inner: string) => `\\textbf{${inner}}`);
  if (converted.includes("**")) {
    unmatchedBold.push({ blockId, sample: converted.slice(0, 60) });
  }
  return converted;
}

function renderNodes(nodes: readonly Node[], blockId: string): string {
  // 別行立て数式の直後に続く地の文は、同じ文の続きであることが多い。
  // 空行で連結すると LaTeX が新段落として字下げしてしまうので `\noindent` を付ける
  // （日本語の数学組版の通例に合わせる）。
  return nodes
    .map((node, index) => {
      const rendered = renderNode(node, blockId);
      const previous = nodes[index - 1];
      const continuesAfterDisplay =
        previous?.type === "displayMath" && (node.type === "text" || node.type === "paragraph");
      return continuesAfterDisplay ? `\\noindent ${rendered}` : rendered;
    })
    .join("\n\n");
}

function renderNode(node: Node, blockId: string): string {
  switch (node.type) {
    case "text":
      if (/[\^_`]/.test(node.value)) {
        suspiciousTexts.push({ blockId, sample: node.value.slice(0, 60) });
      }
      return renderProse(node.value, blockId);
    case "math":
      return renderInlineMath(node.tex);
    case "displayMath":
      return renderDisplayMath(node.tex);
    case "paragraph":
      // 段落の中身は連結する（数式と地の文が交互に並ぶため、間に空行を入れない）。
      return node.children.map((child) => renderInline(child, blockId)).join("");
    case "list": {
      const items = node.items
        .map((item) => `  \\item ${item.map((child) => renderInline(child, blockId)).join("")}`)
        .join("\n");
      return `\\begin{itemize}\n${items}\n\\end{itemize}`;
    }
    case "ref": {
      usedRefs.push({ target: node.target, blockId });
      // `label` は参照の表示テキストを上書きする任意フィールド。
      if (node.label !== undefined) {
        return `\\hyperref[lab:${node.target}]{${escapeText(node.label)}}`;
      }
      return `\\cref{lab:${node.target}}`;
    }
    case "cite": {
      if (edition.citations === null) {
        // 書誌を持たない版（日本語版）は書誌を地の文へ直に書く方針である。
        // 語彙には `cite` が在るので、黙って出力から消えることがないよう明示的に落とす。
        throw new Error(
          `引用ノード（${node.keys.join(", ")}）は ${locale} 版では出力できない: ${blockId}\n` +
            "  この版は書誌を地の文で書く方針。BibTeX を出す版は tools/editions.ts が宣言する。",
        );
      }
      for (const key of node.keys) usedCites.push({ key, blockId });
      const note = node.note === undefined ? "" : `[${renderProse(node.note, blockId)}]`;
      return `\\cite${note}{${node.keys.join(",")}}`;
    }
    case "todo":
      todoCount += 1;
      return `\\par\\noindent\\textbf{[TODO]}\\ ${renderProse(node.value, blockId)}`;
    case "image":
      // 図版はシステムの語彙には在るが、本論文はまだ 1 件も使っていない
      // （資産の解決規則を決めていない）。黙って消さず、使い始めたら落ちるようにしておく。
      throw new Error(`画像ノード（${node.assetKey}）の LaTeX 出力は未実装: ${blockId}`);
  }
}

/** 数式中の記号を、この版のプリアンブルが定義するマクロへ写す。 */
function mathUnicodeToLatex(tex: string): string {
  return tex.replaceAll("★", edition.starMacro);
}

/**
 * 行内数式。
 *
 * 中身が `\texttt{...}` だけのもの（ファイルパスや識別子の表記）は、数式の箱になると
 * **どこでも改行できず版面から出る**（実測: パス 1 個で 93pt はみ出した）。
 * この場合だけ `\path{...}` で組み、区切り文字で改行できるようにする。
 */
function renderInlineMath(rawTex: string): string {
  const tex = mathUnicodeToLatex(rawTex);
  const textOnly = tex.match(/^\\texttt\{([^{}]*)\}$/);
  const inner = textOnly?.[1];
  if (inner !== undefined) {
    return `\\path{${inner}}`;
  }
  return `$${tex}$`;
}

/**
 * 別行立て数式。既定では幅を測って必要なら縮める `\fitdisplay` を通す。
 * ただし `\tag` は箱の中では使えない（amsmath: "\tag not allowed here"）ので、
 * その 1 件だけは素の `equation*` で組む。
 */
function renderDisplayMath(rawTex: string): string {
  const tex = mathUnicodeToLatex(rawTex);
  if (tex.includes("\\tag")) {
    return `\\begin{equation*}\n${tex}\n\\end{equation*}`;
  }
  return `\\fitdisplay{%\n${tex}%\n}`;
}

/** 段落・リスト項目の内部（改行を挟まない）。 */
function renderInline(node: Node, blockId: string): string {
  if (node.type === "displayMath") return `\n${renderDisplayMath(node.tex)}\n`;
  if (node.type === "list") return `\n${renderNode(node, blockId)}\n`;
  return renderNode(node, blockId);
}
